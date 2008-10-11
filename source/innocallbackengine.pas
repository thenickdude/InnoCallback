unit innocallbackengine;

interface

implementation

uses sysutils, asminline, windows;

var memory: array of pointer;

(*function testcallback(callback:pointer; paramcount:integer):integer; stdcall;
asm
  MOV EAX, [ebp+8] //callback
  MOV ECX, [ebp+12]  //paramcount

  AND ECX, ECX

  @@loop:
   JZ @@exit

   PUSH ECX
   DEC ECX
  JMP @@loop

  @@exit:

   CALL EAX
end;       *)

function WrapCallback(proc: TMethod; paramcount: integer): longword; stdcall;
var inliner: TASMInline;
  swapfirst, swaplast: integer;
begin
{On entry:
 STACK
  retptr
  a
  b
  c
  d

We want:
  STACK
  retptr
  d
  c
  eax=self
  edx=a
  ecx=b
}

  inliner := TASMInline.create;

  try
    inliner.Pop(eax); //get the retptr off the stack

    swapfirst := 2;
    swaplast := paramcount-1;

    //Reverse the order of parameters from param3 onwards in the stack
    while (swaplast > swapfirst) do begin
      inliner.Mov(ecx, inliner.addr(esp, swapfirst * 4)); //load the first item of the pair
      inliner.Mov(edx, inliner.addr(esp, swaplast * 4)); //load the last item of the pair
      inliner.Mov(inliner.addr(esp, swapfirst * 4), edx);
      inliner.Mov(inliner.addr(esp, swaplast * 4), ecx);
      inc(swapfirst);
      dec(swaplast);
    end;

    if paramcount >= 1 then
      inliner.pop(edx); //load param1
    if paramcount >= 2 then
      inliner.pop(ecx); //load param2

    inliner.Push(eax); //put the retptr back onto the stack

    inliner.Mov(eax, longword(tmethod(proc).data)); //Load the self ptr

    inliner.Jmp(tmethod(proc).code); //jump to the wrapped proc

    setlength(memory, length(memory) + 1);
    memory[high(memory)] := inliner.SaveAsMemory;
    result := longword(memory[high(memory)]);
  finally
    inliner.free;
  end;
end;

exports wrapcallback name 'wrapcallback'(*,
 testcallback name 'testcallback'*);

procedure killinliners;
var i: integer;
begin
  for i := 0 to high(memory) do
    FreeMem(memory[i]);
  setlength(memory, 0);
end;

initialization
finalization
  killinliners;
end.


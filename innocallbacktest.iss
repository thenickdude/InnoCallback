#define MyAppName "My Program"
#define MyAppVerName "My Program 1.5"
#define MyAppPublisher "My Company, Inc."
#define MyAppURL "http://www.mycompany.com"

[Setup]
AppName={#MyAppName}
AppVerName={#MyAppVerName}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
CreateAppDir=false
OutputBaseFilename=setup
Compression=lzma
SolidCompression=true
OutputDir=C:\sherlocksoftware\innotools\innocallback

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Code]
type
 TMyCallback0=function():integer;
 TMyCallback1=function(a:integer):integer;
 TMyCallback2=function(a,b:integer):integer;
 TMyCallback3=function(a,b,c:integer):integer;
 TMyCallback4=function(a,b,c,d:integer):integer;
 TMyCallback5=function(a,b,c,d,e:integer):integer;
 TMyCallback6=function(a,b,c,d,e,f:integer):integer;
 TMyCallback7=function(a,b,c,d,e,f,g:integer):integer;
 TMyCallback8=function(a,b,c,d,e,f,g,h:integer):integer;

function WrapMyCallback0(callback:TMyCallBack0; paramcount:integer):longword;
  external 'wrapcallback@innocallback.dll stdcall';
function WrapMyCallback1(callback:TMyCallBack1; paramcount:integer):longword;
  external 'wrapcallback@innocallback.dll stdcall';
function WrapMyCallback2(callback:TMyCallBack2; paramcount:integer):longword;
  external 'wrapcallback@innocallback.dll stdcall';
function WrapMyCallback3(callback:TMyCallBack3; paramcount:integer):longword;
  external 'wrapcallback@innocallback.dll stdcall';
function WrapMyCallback4(callback:TMyCallBack4; paramcount:integer):longword;
  external 'wrapcallback@innocallback.dll stdcall';
function WrapMyCallback5(callback:TMyCallBack5; paramcount:integer):longword;
  external 'wrapcallback@innocallback.dll stdcall';
function WrapMyCallback6(callback:TMyCallBack6; paramcount:integer):longword;
  external 'wrapcallback@innocallback.dll stdcall';
function WrapMyCallback7(callback:TMyCallBack7; paramcount:integer):longword;
  external 'wrapcallback@innocallback.dll stdcall';
function WrapMyCallback8(callback:TMyCallBack8; paramcount:integer):longword;
  external 'wrapcallback@innocallback.dll stdcall';

function TestCallback(callback:longword; paramcount:integer):integer;
  external 'testcallback@innocallback.dll stdcall';

function mycallback0():integer;
begin
   result:=123;end;

function mycallback1(a:integer):integer;
begin
   msgbox(format('%d',[a]),MBINFORMATION,MB_OK);
   result:=123;
end;

function mycallback2(a,b:integer):integer;
begin
   msgbox(format('%d %d',[a,b]),MBINFORMATION,MB_OK);
   result:=123;
end;

function mycallback3(a,b,c:integer):integer;
begin
   msgbox(format('%d %d %d',[a,b,c]),MBINFORMATION,MB_OK);
   result:=123;
end;

function mycallback4(a,b,c,d:integer):integer;
begin
   msgbox(format('%d %d %d %d',[a,b,c,d]),MBINFORMATION,MB_OK);
   result:=123;
end;

function mycallback5(a,b,c,d,e:integer):integer;
begin
   msgbox(format('%d %d %d %d %d',[a,b,c,d,e]),MBINFORMATION,MB_OK);
   result:=123;
end;

function mycallback6(a,b,c,d,e,f:integer):integer;
begin
   msgbox(format('%d %d %d %d %d %d',[a,b,c,d,e,f]),MBINFORMATION,MB_OK);
   result:=123;
end;

function mycallback7(a,b,c,d,e,f,g:integer):integer;
begin
   msgbox(format('%d %d %d %d %d %d %d',[a,b,c,d,e,f,g]),MBINFORMATION,MB_OK);
   result:=123;
end;


function mycallback8(a,b,c,d,e,f,g,h:integer):integer;
begin
   msgbox(format('%d %d %d %d %d %d %d %d',[a,b,c,d,e,f,g,h]),MBINFORMATION,MB_OK);
   result:=123;
end;


function InitializeSetup:boolean;
var c0,c1,c2,c3,c4,c5,c6,c7,c8:longword;
begin
 c0:=WrapMyCallback0(@mycallback0,0);
 c1:=WrapMyCallback1(@mycallback1,1);
 c2:=WrapMyCallback2(@mycallback2,2);
 c3:=WrapMyCallback3(@mycallback3,3);
 c4:=WrapMyCallback4(@mycallback4,4);
 c5:=WrapMyCallback5(@mycallback5,5);
 c6:=WrapMyCallback6(@mycallback6,6);
 c7:=WrapMyCallback7(@mycallback7,7);
 c8:=WrapMyCallback8(@mycallback8,8);

 msgbox(inttostr(TestCallback(c0,0)),MBINFORMATION,MB_OK);
 msgbox(inttostr(TestCallback(c1,1)),MBINFORMATION,MB_OK);
 msgbox(inttostr(TestCallback(c2,2)),MBINFORMATION,MB_OK);
 msgbox(inttostr(TestCallback(c3,3)),MBINFORMATION,MB_OK);
 msgbox(inttostr(TestCallback(c4,4)),MBINFORMATION,MB_OK);
 msgbox(inttostr(TestCallback(c5,5)),MBINFORMATION,MB_OK);
 msgbox(inttostr(TestCallback(c6,6)),MBINFORMATION,MB_OK);
 msgbox(inttostr(TestCallback(c7,7)),MBINFORMATION,MB_OK);
 msgbox(inttostr(TestCallback(c8,8)),MBINFORMATION,MB_OK);

 result:=true; //keep loading setup..
end;

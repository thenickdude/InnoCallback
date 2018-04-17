# InnoCallback

The InnoCallback DLL allows you to provide Inno Setup [Code] functions to external DLLs (Like the Windows API) as Stdcall 
callbacks. 

This is required because Inno Setup's regular functions are actually methods under the hood, and Windows won't
provide the correct "self" pointer to them without adding an additional wrapper around the function.

Grab the zipfile from the "release" tab above, you'll find the example .iss script which serves as the documentation, and
InnoCallback.dll. 
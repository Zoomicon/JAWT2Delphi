//9Mar1999: first creation

unit paintCode;

interface
 uses math,
  jni,
  windows,
  messages,
  javasoft_jawt,
  javasoft_jawt_md,
  sysutils,
  testForm,
  dialogs,
  controls,
  j2awtControl;

(*
 * Class:     MyWindow
 * Method:    paint
 * Signature: (Ljava/awt/Graphics;)V
 *)
procedure Java_MyWindow_paint(env:JNIEnvPtr;canvas:jobject;graphics:jobject); stdcall;

implementation

procedure info(s:string);
begin
 //MessageBox(0,pchar(s),'Info',MB_OK+MB_ICONINFORMATION);
end;


var control:TWinControl=nil;

procedure Java_MyWindow_paint(env:JNIEnvPtr;canvas:jobject;graphics:jobject); stdcall;
var awt:JAWT;
    ds:JAWT_DrawingSurfacePtr;
    dsi:JAWT_DrawingSurfaceInfoPtr;
    dsi_win:JAWT_Win32DrawingSurfaceInfoPtr;
    result:jboolean;
    lock:jint;
    hWnd:Windows.HWND;
begin
 beep();
 info('paint');

 if(control<>nil) then
  control.repaint //update //!!!
 else

 try
	// Get the AWT
	awt.version := JAWT_VERSION_1_3;
	result := JAWT_GetAWT(env, awt);
	assert(result <> JNI_FALSE);

	// Get the drawing surface
	ds := awt.GetDrawingSurface(env, canvas);
        assert(ds<>nil); //!!!
	//if(ds = nil) then exit; //??? just ignore if haven't got a surface to draw yet

	// Lock the drawing surface
	lock := ds^.Lock(ds);
	assert((lock and JAWT_LOCK_ERROR) = 0);

	// Get the drawing surface info
	dsi := ds^.GetDrawingSurfaceInfo(ds);

	// Get the platform-specific drawing info
	dsi_win := JAWT_Win32DrawingSurfaceInfoPtr(dsi^.platformInfo);

	hWnd := dsi_win^.hwnd;

//////////////////////////////

         info('got hwnd of canvas');

         hwnd:=getParent(hwnd); //add to the Panel which is the Canvas' parent
         assert(hwnd<>0);

         info('creating control...');

         {}control:=TJ2AWTControl.createParented(hWnd);
         //{}control:=TForm1.createParented(hWnd);
         with control do
          begin
          setParent(handle,hWnd); //add to parent's chain of children! (the createParented won't do it!)
          left:=0;
          top:=0;
          width:=200;
          height:=200;
          BringWindowToTop(handle); //then bring the window to the top inside its parent
          //DoubleBuffered:=true;
          end;

         info('added control!');

//////////////////////////////

	// Free the drawing surface info
	ds^.FreeDrawingSurfaceInfo(dsi);
	// Unlock the drawing surface
	ds^.Unlock(ds);
	// Free the drawing surface
	awt.FreeDrawingSurface(ds);

        beep();
 except
  on e:Exception do
   begin
   MessageBox(0,pchar('error in Paint proc'+#13+e.message),'Error',MB_OK+MB_ICONERROR);
   raise e;
   end;
 end;

end;

end.


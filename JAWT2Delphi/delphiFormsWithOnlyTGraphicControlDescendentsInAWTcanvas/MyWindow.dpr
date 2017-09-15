{ History:
   8Mar2000 - first creation based on the Object Pascal demo (that was itself created from JavaWorld tip 13)
            - added message (uncomment to see it) when "paint" is invoked
            - made it to show forms inside a Java container (however only GraphicControls are supported inside them, not windowed controls)
}

library MyWindow;
 uses math,
  jni,
  windows,
  messages,
  javasoft_jawt,
  javasoft_jawt_md,
  sysutils,
  testForm in 'testForm.pas' {Form1};

////////////////////////////////////////////////////////////////

procedure patchParentWnd(wnd:HWND);
var style:integer;
begin
 wnd:=getParent(wnd);
 style:=getWindowLong(wnd,GWL_STYLE);
 setWindowLong(wnd,GWL_STYLE,style and (not WS_CLIPCHILDREN));
end;

(*
 * Class:     MyWindow
 * Method:    paint
 * Signature: (Ljava/awt/Graphics;)V
 *)
procedure Java_MyWindow_paint(env:JNIEnvPtr;canvas:jobject;graphics:jobject); stdcall;
var awt:JAWT;
    ds:JAWT_DrawingSurfacePtr;
    dsi:JAWT_DrawingSurfaceInfoPtr;
    dsi_win:JAWT_Win32DrawingSurfaceInfoPtr;
    result:jboolean;
    lock:jint;
    hdc:Windows.HDC;
    hWnd:Windows.HWND;
begin
 //MessageBox(0,'paint','Info',MB_OK+MB_ICONINFORMATION);
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

	hdc := dsi_win^.hdc;
	hWnd := dsi_win^.hwnd;

//////////////////////////////

        if(form1<>nil) then
         begin
         //MessageBox(0,'before','Info',MB_OK+MB_ICONINFORMATION);

         form1.parentWindow:=hwnd; //should not be needed as long as the canvas object won't recreate its window handle (do it just in case)
         patchParentWnd(hWnd); //test//

         form1.PaintTo(hdc,0,0); //don't use GetDC(hWnd) //this will freeze if we use TWinControl descendants in the form

         //MessageBox(0,'after','Info',MB_OK+MB_ICONINFORMATION);
         end
        else
         begin
         patchParentWnd(hWnd); //test//
         form1:=TForm1.createParented(hWnd);
         //form1.DoubleBuffered:=true;
         end;

//////////////////////////////

	// Free the drawing surface info
	ds^.FreeDrawingSurfaceInfo(dsi);
	// Unlock the drawing surface
	ds^.Unlock(ds);
	// Free the drawing surface
	awt.FreeDrawingSurface(ds);

 except
  on e:Exception do
   begin
   MessageBox(0,'error in Paint proc','Error',MB_OK+MB_ICONERROR);
   raise e;
   end;
 end;

end;

exports
 Java_MyWindow_paint name 'Java_MyWindow_paint';

begin
end.


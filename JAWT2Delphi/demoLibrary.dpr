{ History:
   07Mar2000 - ported the C example from the jawt.h C header file of JDK1.3RC1
   08Mar2000 - converted the JAWT_GetAWT call according to the latest
               javasoft_jawt unit which requires the jawt record to be passed
               as a var parameter instead of as a pointer
}

library demoLibrary;
 uses jni,javasoft_jawt,javasoft_jawt_md;

procedure Java_MyCanvas_paint(env:JNIEnvPtr;canvas:jobject;graphics:jobject); stdcall;
var awt:JAWT;
    ds:JAWT_DrawingSurfacePtr;
    dsi:JAWT_DrawingSurfaceInfoPtr;
    dsi_win:JAWT_Win32DrawingSurfaceInfoPtr;
    result:jboolean;
    lock:jint;
begin

 // Get the AWT
 awt.version := JAWT_VERSION_1_3;
 result := JAWT_GetAWT(env, awt);
 assert(result <> JNI_FALSE);

 // Get the drawing surface
 ds := awt.GetDrawingSurface(env, canvas);
 assert(ds <> nil);

 // Lock the drawing surface
 lock := ds^.Lock(ds);
 assert((lock and JAWT_LOCK_ERROR) = 0);

 // Get the drawing surface info
 dsi := ds^.GetDrawingSurfaceInfo(ds);

 // Get the platform-specific drawing info
 dsi_win := JAWT_Win32DrawingSurfaceInfoPtr(dsi^.platformInfo);

 //////////////////////////////
 // !!! DO PAINTING HERE !!! //
 //////////////////////////////

 // Free the drawing surface info
 ds^.FreeDrawingSurfaceInfo(dsi);

 // Unlock the drawing surface
 ds^.Unlock(ds);

 // Free the drawing surface
 awt.FreeDrawingSurface(ds);
end;

exports
 Java_MyCanvas_paint;

begin
end.


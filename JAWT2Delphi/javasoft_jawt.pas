{ History:
   07Mar2000 - ported to Delphi by George Birbilis (birbilis@cti.gr)
   08Mar2000 - now using the correct calling convention for JAWT_GetAWT and unmagling the DLL's C proc name
             - now using"stdcall" calling convention at the declaration of all Proc/Func types
   22Mar2000 - removed "jni.pas" from the JAWT2Delphi package (now the JAWT2Delphi package depends on the DelphiJNI package - that one will be provided separately)
}

(*
 * @(#)jawt.h	1.4 99/12/04
 *
 * Copyright 1999 Sun Microsystems, Inc. All Rights Reserved.
 *
 * This software is the proprietary information of Sun Microsystems, Inc.
 * Use is subject to license terms.
 *
 *)

unit javasoft_jawt;

interface

uses jni;

(*
 * AWT native interface (new in JDK 1.3)
 *
 * The AWT native interface allows a native C or C++ application a means
 * by which to access native structures in AWT.  This is to facilitate moving
 * legacy C and C++ applications to Java and to target the needs of the
 * community who, at present, wish to do their own native rendering to canvases
 * for performance reasons.  Standard extensions such as Java3D also require a
 * means to access the underlying native data structures of AWT.
 *
 * There may be future extensions to this API depending on demand.
 *
 * A VM does not have to implement this API in order to pass the JCK.
 * It is recommended, however, that this API is implemented on VMs that support
 * standard extensions, such as Java3D.
 *
 * Since this is a native API, any program which uses it cannot be considered
 * 100% pure java.
 *)

(*
 * AWT Native Drawing Surface (JAWT_DrawingSurface).
 *
 * For each platform, there is a native drawing surface structure.  This
 * platform-specific structure can be found in jawt_md.h.  It is recommended
 * that additional platforms follow the same model.  It is also recommended
 * that VMs on Win32 and Solaris support the existing structures in jawt_md.h.
 *
 *******************
 * EXAMPLE OF USAGE:
 *******************
 *
 * In Win32, a programmer wishes to access the HWND of a canvas to perform
 * native rendering into it.  The programmer has declared the paint() method
 * for their canvas subclass to be native:
 *
 *
 * MyCanvas.java:
 *
 * import java.awt.*;
 *
 * public class MyCanvas extends Canvas {
 *
 *     static {
 *         System.loadLibrary("mylib");
 *     }
 *
 *     public native void paint(Graphics g);
 * }
 *
 *)

// C example was removed and replaced by an Object Pascal equivalent // 

(*

//myfile.pas:

library myfile;
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
 result := JAWT_GetAWT(env, @awt);
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

*)

///////////////////////////////////////////////////////////////////////////

(*
 * JAWT_Rectangle
 * Structure for a native rectangle.
 *)
type jawt_Rectangle=packed record
      x:jint;
      y:jint;
      width:jint;
      height:jint;
      end;
     jawt_RectanglePtr=^jawt_Rectangle;

const JAWT_LOCK_ERROR                 = $00000001; //moved here cause the following "type" block can't be broken into two parts
      JAWT_LOCK_CLIP_CHANGED          = $00000002;
      JAWT_LOCK_BOUNDS_CHANGED        = $00000004;
      JAWT_LOCK_SURFACE_CHANGED       = $00000008;

type jawt_DrawingSurfacePtr=^jawt_DrawingSurface; //forward declaration: the jawt_DrawingSurface declaration must be inside the same "type" block!!!

(*
 * JAWT_DrawingSurfaceInfo
 * Structure for containing the underlying drawing information of a component.
 *)
     jawt_DrawingSurfaceInfo=packed record
    (*
     * Pointer to the platform-specific information.  This can be safely
     * cast to a JAWT_Win32DrawingSurfaceInfo on Windows or a
     * JAWT_X11DrawingSurfaceInfo on Solaris.  See jawt_md.h for details.
     *)
    platformInfo:pointer;
    (* Cached pointer to the underlying drawing surface *)
    ds:jawt_DrawingSurfacePtr;
    (* Bounding rectangle of the drawing surface *)
    bounds:JAWT_Rectangle;
    (* Number of rectangles in the clip *)
    clipSize:jint;
    (* Clip rectangle array *)
    clip:JAWT_RectanglePtr;
    end;
   jawt_DrawingSurfaceInfoPtr=^jawt_DrawingSurfaceInfo;

//-----------//

 JNIEnvPtr=^JNIEnv;
 LockFunc=function(ds:jawt_DrawingSurfacePtr):jint;stdcall; //JNICALL
 GetDrawingSurfaceInfoFunc=function(ds:jawt_DrawingSurfacePtr):jawt_DrawingSurfaceInfoPtr;stdcall; //JNICALL
 FreeDrawingSurfaceInfoProc=procedure(dsi:jawt_DrawingSurfaceInfoPtr);stdcall; //JNICALL
 UnlockProc=procedure(ds:jawt_DrawingSurfacePtr);stdcall; //JNICALL

//-----------//

(*
 * JAWT_DrawingSurface
 * Structure for containing the underlying drawing information of a component.
 * All operations on a JAWT_DrawingSurface MUST be performed from the same
 * thread as the call to GetDrawingSurface.
 *)
     jawt_DrawingSurface=packed record
    (*
     * Cached reference to the Java environment of the calling thread.
     * If Lock(), Unlock(), GetDrawingSurfaceInfo() or
     * FreeDrawingSurfaceInfo() are called from a different thread,
     * this data member should be set before calling those functions.
     *)
    env:JNIEnvPtr;
    (* Cached reference to the target object *)
    target:jobject;
    (*
     * Lock the surface of the target component for native rendering.
     * When finished drawing, the surface must be unlocked with
     * Unlock().  This function returns a bitmask with one or more of the
     * following values:
     *
     * JAWT_LOCK_ERROR - When an error has occurred and the surface could not
     * be locked.
     *
     * JAWT_LOCK_CLIP_CHANGED - When the clip region has changed.
     *
     * JAWT_LOCK_BOUNDS_CHANGED - When the bounds of the surface have changed.
     *
     * JAWT_LOCK_SURFACE_CHANGED - When the surface itself has changed
     *)
    Lock:LockFunc;
    (*
     * Get the drawing surface info.
     * The value returned may be cached, but the values may change if
     * additional calls to Lock() or Unlock() are made.
     * Lock() must be called before this can return a valid value.
     * Returns NULL if an error has occurred.
     * When finished with the returned value, FreeDrawingSurfaceInfo must be
     * called.
     *)
    GetDrawingSurfaceInfo:GetDrawingSurfaceInfoFunc;
    (*
     * Free the drawing surface info.
     *)
    FreeDrawingSurfaceInfo:FreeDrawingSurfaceInfoProc;
    (*
     * Unlock the drawing surface of the target component for native rendering.
     *)
    Unlock:UnlockProc;
    end;

//-----------//

 GetDrawingSurfaceFunc=function(env:JNIEnvPtr;target:jobject):JAWT_DrawingSurfacePtr;stdcall; //JNICALL
 FreeDrawingSurfaceProc=procedure(ds:JAWT_DrawingSurfacePtr);stdcall; //JNICALL

//-----------//

(*
 * JAWT
 * Structure for containing native AWT functions.
 *)
type jawt=packed record
    (*
     * Version of this structure.  This must always be set before
     * calling JAWT_GetAWT()
     *)
    version:jint;
    (*
     * Return a drawing surface from a target jobject.  This value
     * may be cached.
     * Returns NULL if an error has occurred.
     * Target must be a java.awt.Canvas.
     * FreeDrawingSurface() must be called when finished with the
     * returned JAWT_DrawingSurface.
     *)
    GetDrawingSurface:GetDrawingSurfaceFunc;
    (*
     * Free the drawing surface allocated in GetDrawingSurface.
     *)
    FreeDrawingSurface:FreeDrawingSurfaceProc;
    end;
   jawtPtr=^jawt;

(*
 * Get the AWT native structure.  This function returns JNI_FALSE if
 * an error occurs.
 *)
function JAWT_GetAWT(env:JNIEnvPtr;var awt:JAWT):jboolean; stdcall; external 'jawt.dll' name '_JAWT_GetAWT@8'; //JNICALL (got the name using TDUMP on jdk1.3rc1\jre\bin\jawt.dll)

const JAWT_VERSION_1_3 = $00010003;

implementation

end.



{ History:
   07Mar2000 - ported to Delphi by George Birbilis (birbilis@cti.gr)
}

(*
 * @(#)jawt_md.h	1.3 99/12/04
 *
 * Copyright 1999 Sun Microsystems, Inc. All Rights Reserved.
 *
 * This software is the proprietary information of Sun Microsystems, Inc.
 * Use is subject to license terms.
 *
 *)

unit javasoft_jawt_md;

interface

uses windows,javasoft_jawt;

(*
 * Win32-specific declarations for AWT native interface.
 * See notes in jawt.h for an example of use.
 *)
type jawt_Win32DrawingSurfaceInfo=packed record
    (* Native window, DDB, or DIB handle *)
    case integer of
     0: (hwnd:HWND);
     1: (hbitmap:HBITMAP);
     2: (pbits:pointer;
    (*
     * This HDC should always be used instead of the HDC returned from
     * BeginPaint() or any calls to GetDC().
     *)
         hdc:HDC;
         hpalette:HPALETTE;
        ); //in Object Pascal the variant part of a record can only be at the end of it (can't have any more fields after the variant part - so added all fields after the union to the last case of the variant part of the record (the size of the record will be the maximum size of all cases anyway
    end;
   jawt_Win32DrawingSurfaceInfoPtr=^jawt_Win32DrawingSurfaceInfo;

implementation

end.



{ History:
   7Mar2000 - first creation by George Birbilis (birbilis@cti.gr), porting JavaWorld's "Java Tip 86" demo code
   8Mar2000 - added try/except blocks to track any thrown exceptions
            - added (uncomment to try out) info dialog whenever "paint" or "drawSmiley" are called 
}

library MyWindow;
 uses math,jni,windows,javasoft_jawt,javasoft_jawt_md,sysutils;

// INTERFACE //////////////////////////////////////////////////////////////////

(* Header for class MyWindow *)

const MyWindow_TOP_ALIGNMENT = 0.0;
      MyWindow_CENTER_ALIGNMENT = 0.5;
      MyWindow_BOTTOM_ALIGNMENT = 1.0;
      MyWindow_LEFT_ALIGNMENT = 0.0;
      MyWindow_RIGHT_ALIGNMENT = 1.0;

(*
 * Class:     MyWindow
 * Method:    paint
 * Signature: (Ljava/awt/Graphics;)V
 *)
procedure Java_MyWindow_paint(env:JNIEnvPtr;canvas:jobject;graphics:jobject); stdcall; forward;

// IMPLEMENTATION //////////////////////////////////////////////////////////////////

const hrgn:HRGN=nil;
var xLeft,yTop,xScale,yScale:integer;

// Scaling macros (scale is 0 - 100)

function X(x:integer):integer;
begin
 result:=trunc(xLeft + (x)*xScale/100);
end;

function Y(y:integer):integer;
begin
 result:=trunc(yTop + (y)*yScale/100);
end;

function CX(x:integer):integer;
begin
 result:=trunc((x)*xScale/100);
end;

function CY(y:integer):integer;
begin
 result:=trunc((y)*yScale/100);
end;

procedure DrawSmiley(hWnd:HWND; hdc:HDC);
var rcBounds:TRect;
    brushBlack,brushYellow,pBrushSave:HBRUSH;
    iPenWidth:integer;
    penBlack,penNull,pPenSave:HPEN;
begin
 //MessageBox(0,'DrawSmiley','Info',MB_OK+MB_ICONINFORMATION);

 try
	GetWindowRect(hWnd,rcBounds);
	xLeft := 0;         // Use with scaling macros
	yTop := 0;
	xScale := rcBounds.right-rcBounds.left;
	yScale := rcBounds.bottom-rcBounds.top;

	// Pen width based on control size
	iPenWidth := max(CX(5), CY(5));
	penBlack := CreatePen(PS_SOLID, iPenWidth, RGB($00,$00,$00));
	// Null pen for drawing filled ellipses
	penNull := CreatePen(PS_NULL, 0, COLORREF(0));

	brushBlack := CreateSolidBrush(RGB($00,$00,$00));
	brushYellow := CreateSolidBrush(RGB($ff,$ff,$00));

	pPenSave := HPEN(SelectObject(hdc, penBlack));
	pBrushSave := HBRUSH(SelectObject(hdc,brushYellow));
	Ellipse(hdc,X(10), Y(15), X(90), Y(95));       // Head

	Arc(hdc,X(25), Y(10), X(75), Y(80),            // Smile mouth
	   X(35), Y(70), X(65), Y(70));

	SelectObject(hdc,penNull);                    // No draw width
	SelectObject(hdc,brushBlack);

	Ellipse(hdc,X(57), Y(35), X(65), Y(50));
	Ellipse(hdc,X(35), Y(35), X(43), Y(50));       // Right eye
	Ellipse(hdc,X(46), Y(50), X(54), Y(65));       // Nose

	SetBkMode(hdc,TRANSPARENT);                    // Use ForeColor

	SelectObject(hdc,pBrushSave);
	SelectObject(hdc,pPenSave);

 except
  on e:Exception do
   begin
   MessageBox(0,'error in DrawSmiley proc','Error',MB_OK+MB_ICONERROR);
   raise e;
   end;
 end;

end;

procedure Java_MyWindow_paint(env:JNIEnvPtr;canvas:jobject;graphics:jobject); stdcall;
var awt:JAWT;
    ds:JAWT_DrawingSurfacePtr;
    dsi:JAWT_DrawingSurfaceInfoPtr;
    dsi_win:JAWT_Win32DrawingSurfaceInfoPtr;
    result:jboolean;
    lock:jint;
    rcBounds:TRect;
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
	if(ds = nil) then
 	    exit;

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
	// !!! DO PAINTING HERE !!! //
	//////////////////////////////
	if(hrgn = 0) then //C's NULL equals 0
	 begin
		GetWindowRect(hWnd,rcBounds);
		xLeft := 0;         // Use with scaling macros
		yTop := 0;
		xScale := rcBounds.right-rcBounds.left;
		yScale := rcBounds.bottom-rcBounds.top;
		hrgn := CreateEllipticRgn(X(10), Y(15), X(90), Y(95));
		SetWindowRgn(GetParent(hWnd),hrgn,TRUE);
		InvalidateRect(hWnd,nil,TRUE);
         end
	else
		DrawSmiley(hWnd,hdc);



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


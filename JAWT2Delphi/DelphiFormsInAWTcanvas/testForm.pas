unit testForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, ExtCtrls, OleCtrls, MediaPlayer_TLB, Buttons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
  public
    { Public declarations }
   procedure WndProc(var Message:TMessage); override;
   procedure CreateParams(var Params:TCreateParams);override;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function TForm1.WndProc;
begin
 inherited; //add breakpoint here to see if any messages are passed from Java to us 
end;

procedure TForm1.CreateParams;
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style :=Style
     or WS_VISIBLE //AWT Panel (must have this set, else the parent Java window will consider this window as invisible)
     and (not WS_OVERLAPPEDWINDOW); //AWT Panel (don't show title bar etc. for window)

    if NewStyleControls then
     ExStyle := ExStyle
     and (not WS_EX_WINDOWEDGE) //we don't have a dragger
     and (not WS_EX_CONTROLPARENT) //we don't need to navigate between children using TAB     
     ;

  end;
end;

end.


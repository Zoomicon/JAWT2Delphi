unit testForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, ExtCtrls, OleCtrls, MediaPlayer_TLB, Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

threadvar
  Form1: TForm1;

implementation

{$R *.DFM}

end.

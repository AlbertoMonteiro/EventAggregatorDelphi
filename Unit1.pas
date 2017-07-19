unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Unit3, Unit2, Vcl.StdCtrls;

type

  Ola<T> = procedure(param: T) of object;

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ASubscription(data: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ASubscription(data: String);
begin
  Edit1.Text := data;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  frm: TForm3;
begin
  TEventAggregator<String>.Subscribe(ASubscription, Self);
  frm := TForm3.Create(Self);
  frm.Show;
end;

end.

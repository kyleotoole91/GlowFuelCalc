program RCFuelCalcPro;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uFuelCalc in 'uFuelCalc.pas',
  uPersistence in 'uPersistence.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

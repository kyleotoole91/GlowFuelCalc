unit uFrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts,
  uFuelCalc;

type
  TfrmMain = class(TForm)
    VertScrollBox1: TVertScrollBox;
    pnlMain: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    Label3: TLabel;
    seNitroDensity: TSpinBox;
    Panel3: TPanel;
    Label4: TLabel;
    seCastorDensity: TSpinBox;
    Panel4: TPanel;
    Label5: TLabel;
    seSynthDensity: TSpinBox;
    Panel5: TPanel;
    Label6: TLabel;
    seMethanolDensity: TSpinBox;
    Label7: TLabel;
    Panel1: TPanel;
    Label8: TLabel;
    seNitroTarget: TSpinBox;
    Panel6: TPanel;
    Label9: TLabel;
    seOilTarget: TSpinBox;
    Panel7: TPanel;
    Label10: TLabel;
    seCastorRatio: TSpinBox;
    Panel8: TPanel;
    Label11: TLabel;
    seTargetYield: TSpinBox;
    Label12: TLabel;
    Panel9: TPanel;
    Label13: TLabel;
    seNitroMeasurementWeight: TSpinBox;
    seNitroMeasurementVol: TSpinBox;
    Panel10: TPanel;
    Label20: TLabel;
    seMethanolMeasurementWeight: TSpinBox;
    seMethanolMeasurementVol: TSpinBox;
    Panel11: TPanel;
    Label15: TLabel;
    seCastorMeasurementWeight: TSpinBox;
    seCastorMeasurementVol: TSpinBox;
    Panel12: TPanel;
    Label16: TLabel;
    seSynthMeasurementWeight: TSpinBox;
    seSynthMeasurementVol: TSpinBox;
    Panel14: TPanel;
    Label14: TLabel;
    seTotalVolume: TSpinBox;
    Label18: TLabel;
    Panel15: TPanel;
    Label17: TLabel;
    seMethanolTarget: TSpinBox;
    Panel13: TPanel;
    Label19: TLabel;
    seTotalDensity: TSpinBox;
    Panel16: TPanel;
    Label21: TLabel;
    seNitroContentByVolume: TSpinBox;
    Panel17: TPanel;
    Label22: TLabel;
    seMethanolContentByVolume: TSpinBox;
    Panel18: TPanel;
    Label23: TLabel;
    seOilContentByVolume: TSpinBox;
    Panel19: TPanel;
    rbTargetAsMls: TRadioButton;
    rbTargetAsGrams: TRadioButton;
    Panel20: TPanel;
    Label24: TLabel;
    seTotalWeight: TSpinBox;
    Panel21: TPanel;
    Label1: TLabel;
    MaterialOxfordBlueSB: TStyleBook;
    procedure FormToVars(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fFuelCalc: TFuelCalc;
    fLoading: boolean;
    procedure VarsToForm;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

{TfrmMain}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  fLoading := true;
  fFuelCalc := TFuelCalc.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  fFuelCalc.DisposeOf;
  inherited;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  fLoading := true;
  try
    fFuelCalc.Calc;
    VarsToForm;
  finally
    fLoading := false;
  end;
end;

procedure TfrmMain.VarsToForm;
begin
  seNitroDensity.Value := fFuelCalc.NitroDensity;
  seMethanolDensity.Value := fFuelCalc.MethanolDensity;
  seCastorDensity.Value := fFuelCalc.CastorDensity;
  seSynthDensity.Value := fFuelCalc.SynthDensity;
  seNitroTarget.Value := fFuelCalc.NitroTarget;
  seOilTarget.Value := fFuelCalc.OilTarget;
  seCastorRatio.Value := fFuelCalc.CastorRatio;
  seTargetYield.Value := fFuelCalc.TargetYield;
  seMethanolTarget.Value := 100 - (fFuelCalc.NitroTarget + fFuelCalc.OilTarget);
  seNitroMeasurementWeight.Value := fFuelCalc.NitroWeight;
  seCastorMeasurementWeight.Value := fFuelCalc.CastorWeight;
  seSynthMeasurementWeight.Value := fFuelCalc.SynthWeight;
  seMethanolMeasurementWeight.Value := fFuelCalc.MethanolWeight;
  seNitroMeasurementVol.Value := fFuelCalc.NitroVolume;
  seCastorMeasurementVol.Value := fFuelCalc.CastorVolume;
  seSynthMeasurementVol.Value := fFuelCalc.SynthVolume;
  seMethanolMeasurementVol.Value := fFuelCalc.MethanolVolume;
  seTotalWeight.Value := fFuelCalc.TotalWeight;
  seTotalVolume.Value := fFuelCalc.TotalVolume;
  seTotalDensity.Value := fFuelCalc.TotalDensity;
  seNitroContentByVolume.Value := fFuelCalc.NitroContentByVolume;
  seOilContentByVolume.Value := fFuelCalc.OilContentByVolume;
  seMethanolContentByVolume.Value := fFuelCalc.MethanolContentByVolume;
  rbTargetAsMls.IsChecked := fFuelCalc.TargetType = ttVolume;
  rbTargetAsGrams.IsChecked := fFuelCalc.TargetType = ttWeight;
end;

procedure TfrmMain.FormToVars;
begin
  if not fLoading then begin
    fFuelCalc.NitroDensity := seNitroDensity.Value;
    fFuelCalc.MethanolDensity := seMethanolDensity.Value;
    fFuelCalc.CastorDensity := seCastorDensity.Value;
    fFuelCalc.SynthDensity := seSynthDensity.Value;
    fFuelCalc.NitroTarget := seNitroTarget.Value;
    fFuelCalc.OilTarget := seOilTarget.Value;
    fFuelCalc.CastorRatio := seCastorRatio.Value;
    fFuelCalc.TargetYield := seTargetYield.Value;
    if rbTargetAsMls.IsChecked then
      fFuelCalc.TargetType := ttVolume
    else
      fFuelCalc.TargetType := ttWeight;
    fFuelCalc.Calc;
    VarsToForm;
  end;
end;

end.
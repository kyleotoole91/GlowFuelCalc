unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TFuelCalc = class (TObject)
  strict private
    fTotalWeight: double;
    //density
    fNitroDensity: double;
    fMethanolDensity: double;
    fCastorDensity: double;
    fSynthDensity: double;
    //targets
    fNitroTarget: double;
    fOilTarget: double;
    fCastorPct: double;
    fTargetWeight: double;
    fTotalVolume: double;
    fNitroMeasurement: double;
    fCastorMeasurement: double;
    fSynthMeasurement: double;
    fMethanolMeasurement: double;
    fCastorVolume: double;
    fSynthVolume: double;
    fNitroVolume: double;
    fMethanolVolume: double;
    fTotalDensity: double;
    function CalcWeight(const APercentage: double): double;
    function GramsPerMl(const ADensityPerLitre: double): double;
  public
    constructor Create;
    procedure Calc;
    //density
    property NitroDensity: double read fNitroDensity write fNitroDensity;
    property MethanolDensity: double read fMethanolDensity write fMethanolDensity;
    property CastorDensity: double read fCastorDensity write fCastorDensity;
    property SynthDensity: double read fSynthDensity write fSynthDensity;
    //targets
    property NitroTarget: double read fNitroTarget write fNitroTarget;
    property OilTarget: double read fOilTarget write fOilTarget;
    property CastorPct: double read fCastorPct write fCastorPct;
    property TargetWeight: double read fTargetWeight write fTargetWeight;
    property TotalWeight: double read fTotalWeight;
    property TotalVolume: double read fTotalVolume;
    property NitroMeasurement: double read fNitroMeasurement;
    property CastorMeasurement: double read fCastorMeasurement;
    property SynthMeasurement: double read fSynthMeasurement;
    property MethanolMeasurement: double read fMethanolMeasurement;
    property TotalDensity: double read fTotalDensity;
    property CastorVolume: double read fCastorVolume;
    property SynthVolume: double read fSynthVolume;
    property NitroVolume: double read fNitroVolume;
    property MethanolVolume: double read fMethanolVolume;
  end;

  TfrmMain = class(TForm)
    Label1: TLabel;
    V: TPanel;
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
    Panel8: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Panel9: TPanel;
    Label13: TLabel;
    seNitroMeasurement: TSpinBox;
    Panel10: TPanel;
    seMethanolMeasurement: TSpinBox;
    Panel11: TPanel;
    Label15: TLabel;
    seCastorMeasurement: TSpinBox;
    Panel12: TPanel;
    Label16: TLabel;
    seSynthMeasurement: TSpinBox;
    Label20: TLabel;
    Panel14: TPanel;
    Label14: TLabel;
    Label18: TLabel;
    Panel15: TPanel;
    Label17: TLabel;
    seMethanolTarget: TSpinBox;
    seCastorPercent: TSpinBox;
    seTotalVolume: TSpinBox;
    seTargetWeight: TSpinBox;
    Panel13: TPanel;
    Label19: TLabel;
    seTotalDensity: TSpinBox;
    seNitroMeasurementMls: TSpinBox;
    seMethanolMeasurementMls: TSpinBox;
    seCastorMeasurementMls: TSpinBox;
    seSynthMeasurementMls: TSpinBox;
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

{ TFuelCalc }

procedure TFuelCalc.Calc;
var
  castorPct: double;
  synthPct: double;
begin
  synthPct := (fOilTarget / 100) * (100 - fCastorPct);
  castorPct := fOilTarget - synthPct;

  fCastorMeasurement := CalcWeight(castorPct);
  fSynthMeasurement := CalcWeight(synthPct);
  fNitroMeasurement := CalcWeight(fNitroTarget);
  fMethanolMeasurement := fTargetWeight - (fCastorMeasurement + fSynthMeasurement + fNitroMeasurement);

  fCastorVolume := fCastorMeasurement / GramsPerMl(fCastorDensity);
  fSynthVolume := fSynthMeasurement / GramsPerMl(fSynthDensity);
  fNitroVolume := fNitroMeasurement / GramsPerMl(fNitroDensity);
  fMethanolVolume := fMethanolMeasurement / GramsPerMl(fMethanolDensity);

  fTotalVolume := fCastorVolume + fSynthVolume + fNitroVolume + fMethanolVolume;

  fTotalDensity := (fTargetWeight / fTotalVolume) * 1000
end;

function TFuelCalc.CalcWeight(const APercentage: double): double;
begin
  result := (fTargetWeight / 100) * APercentage;
end;

constructor TFuelCalc.Create;
begin
  inherited;
  fNitroDensity := 1140;
  fMethanolDensity := 792;
  fCastorDensity := 962;
  fSynthDensity := 994;

  fNitroTarget := 16;
  fOilTarget := 16;
  fCastorPct := 30;
  fTargetWeight := 4305;
end;

function TFuelCalc.GramsPerMl(const ADensityPerLitre: double): double;
begin
  result := ADensityPerLitre / 1000;
end;

{Form}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  fLoading := true;
  fFuelCalc := TFuelCalc.Create;
  fFuelCalc.Calc;
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
  seCastorPercent.Value := fFuelCalc.CastorPct;
  seTargetWeight.Value := fFuelCalc.TargetWeight;
  seMethanolTarget.Value := 100 - (fFuelCalc.NitroTarget + fFuelCalc.OilTarget);

  seNitroMeasurement.Value := fFuelCalc.NitroMeasurement;
  seCastorMeasurement.Value := fFuelCalc.CastorMeasurement;
  seSynthMeasurement.Value := fFuelCalc.SynthMeasurement;
  seMethanolMeasurement.Value := fFuelCalc.MethanolMeasurement;

  seNitroMeasurementMls.Value := fFuelCalc.NitroVolume;
  seCastorMeasurementMls.Value := fFuelCalc.CastorVolume;
  seSynthMeasurementMls.Value := fFuelCalc.SynthVolume;
  seMethanolMeasurementMls.Value := fFuelCalc.MethanolVolume;

  seTotalVolume.Value := fFuelCalc.TotalVolume;
  seTotalDensity.Value := fFuelCalc.TotalDensity;
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
    fFuelCalc.CastorPct := seCastorPercent.Value;
    fFuelCalc.TargetWeight := seTargetWeight.Value;

    fFuelCalc.Calc;

    VarsToForm;
  end;
end;

end.

unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts;

type
  TTargetType = (ttGrams = 0, ttMls = 1);
  TFuelCalc = class;

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

  TFuelCalc = class (TObject)
  strict private
    fCastorPct: double;
    fSynthPct: double;
    fTargetType: TTargetType;
    fTotalWeight: double;
    fNitroDensity: double;
    fMethanolDensity: double;
    fCastorDensity: double;
    fSynthDensity: double;
    fNitroTarget: double;
    fOilTarget: double;
    fCastorRatio: double;
    fTargetYield: double;
    fTotalVolume: double;
    fNitroWeight: double;
    fCastorWeight: double;
    fSynthWeight: double;
    fMethanolWeight: double;
    fCastorVolume: double;
    fSynthVolume: double;
    fNitroVolume: double;
    fMethanolVolume: double;
    fTotalDensity: double;
    fNitroContentByVolume: double;
    fOilContentByVolume: double;
    fMethanolContentByVolume: double;
    procedure CalcByWeight;
    procedure CalcByVolume;
    function CalcIngredientAmount(const APercentage: double): double;
    function GramsPerMl(const ADensityPerLitre: double): double;
  public
    constructor Create;
    procedure Calc;
    property NitroDensity: double read fNitroDensity write fNitroDensity;
    property MethanolDensity: double read fMethanolDensity write fMethanolDensity;
    property CastorDensity: double read fCastorDensity write fCastorDensity;
    property SynthDensity: double read fSynthDensity write fSynthDensity;
    property NitroTarget: double read fNitroTarget write fNitroTarget;
    property OilTarget: double read fOilTarget write fOilTarget;
    property CastorRatio: double read fCastorRatio write fCastorRatio;
    property TargetYield: double read fTargetYield write fTargetYield;
    property TotalWeight: double read fTotalWeight;
    property TotalVolume: double read fTotalVolume;
    property NitroWeight: double read fNitroWeight;
    property CastorWeight: double read fCastorWeight;
    property SynthWeight: double read fSynthWeight;
    property MethanolWeight: double read fMethanolWeight;
    property TotalDensity: double read fTotalDensity;
    property CastorVolume: double read fCastorVolume;
    property SynthVolume: double read fSynthVolume;
    property NitroVolume: double read fNitroVolume;
    property MethanolVolume: double read fMethanolVolume;
    property NitroContentByVolume: double read fNitroContentByVolume;
    property OilContentByVolume: double read fOilContentByVolume;
    property MethanolContentByVolume: double read fMethanolContentByVolume;
    property TargetType: TTargetType read fTargetType write fTargetType;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

{ TFuelCalc }

constructor TFuelCalc.Create;
begin
  inherited;
  fNitroDensity := 1140;
  fMethanolDensity := 792;
  fCastorDensity := 962;
  fSynthDensity := 994;
  fNitroTarget := 16;
  fOilTarget := 14.93;
  fCastorRatio := 30;
  fTargetYield := 4294.99;
  fTargetType := ttGrams;
end;

procedure TFuelCalc.Calc;
begin
  fSynthPct := (fOilTarget / 100) * (100 - fCastorRatio);
  fCastorPct := fOilTarget - fSynthPct;
  if fTargetType = ttGrams then
    CalcByWeight
  else
    CalcByVolume;
end;

procedure TFuelCalc.CalcByVolume;
begin
  fCastorVolume := CalcIngredientAmount(fCastorPct);
  fSynthVolume := CalcIngredientAmount(fSynthPct);
  fNitroVolume := CalcIngredientAmount(fNitroTarget);
  fMethanolVolume := fTargetYield - (fCastorVolume + fSynthVolume + fNitroVolume);
  fTotalVolume := fCastorVolume + fSynthVolume + fNitroVolume + fMethanolVolume;

  fCastorWeight := fCastorVolume * GramsPerMl(fCastorDensity);
  fSynthWeight := fSynthVolume * GramsPerMl(fSynthDensity);
  fNitroWeight := fNitroVolume * GramsPerMl(fNitroDensity);
  fMethanolWeight := fMethanolVolume * GramsPerMl(fMethanolDensity);

  fTotalWeight := fCastorWeight + fSynthWeight + fNitroWeight + fMethanolWeight;

  fNitroContentByVolume := (fNitroVolume / fTotalVolume) * 100;
  fOilContentByVolume := ((fSynthVolume + fCastorVolume) / fTotalVolume) * 100;
  fMethanolContentByVolume := (fMethanolVolume / fTotalVolume) * 100;

  fTotalDensity := (fTotalWeight / fTargetYield) * 1000;
end;

procedure TFuelCalc.CalcByWeight;
begin
  fCastorWeight := CalcIngredientAmount(fCastorPct);
  fSynthWeight := CalcIngredientAmount(fSynthPct);
  fNitroWeight := CalcIngredientAmount(fNitroTarget);
  fMethanolWeight := fTargetYield - (fCastorWeight + fSynthWeight + fNitroWeight);
  fTotalWeight := fCastorWeight + fSynthWeight + fNitroWeight + fMethanolWeight;

  fCastorVolume := fCastorWeight / GramsPerMl(fCastorDensity);
  fSynthVolume := fSynthWeight / GramsPerMl(fSynthDensity);
  fNitroVolume := fNitroWeight / GramsPerMl(fNitroDensity);
  fMethanolVolume := fMethanolWeight / GramsPerMl(fMethanolDensity);

  fTotalVolume := fCastorVolume + fSynthVolume + fNitroVolume + fMethanolVolume;

  fNitroContentByVolume := (fNitroVolume / fTotalVolume) * 100;
  fOilContentByVolume := ((fSynthVolume + fCastorVolume) / fTotalVolume) * 100;
  fMethanolContentByVolume := (fMethanolVolume / fTotalVolume) * 100;

  fTotalDensity := (fTargetYield / fTotalVolume) * 1000;
end;

function TFuelCalc.CalcIngredientAmount(const APercentage: double): double;
begin
  result := (fTargetYield / 100) * APercentage;
end;

function TFuelCalc.GramsPerMl(const ADensityPerLitre: double): double;
begin
  result := ADensityPerLitre / 1000;
end;

{TfrmMain}

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
  rbTargetAsMls.IsChecked := fFuelCalc.TargetType = ttMls;
  rbTargetAsGrams.IsChecked := fFuelCalc.TargetType = ttGrams;
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
      fFuelCalc.TargetType := ttMls
    else
      fFuelCalc.TargetType := ttGrams;
    fFuelCalc.Calc;
    VarsToForm;
  end;
end;

end.

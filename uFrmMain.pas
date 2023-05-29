unit uFrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts,
  uFuelCalc, FMX.TabControl;

type
  TfrmMain = class(TForm)
    Panel21: TPanel;
    lbHeader: TLabel;
    lbSave: TLabel;
    lbDefaults: TLabel;
    MaterialOxfordBlueSB: TStyleBook;
    VertScrollBox1: TVertScrollBox;
    tcMain: TTabControl;
    tiMixing: TTabItem;
    tiAdding: TTabItem;
    pnlAdding: TPanel;
    Label1: TLabel;
    Panel23: TPanel;
    lbAd1: TLabel;
    seAdd1Density: TSpinBox;
    Panel26: TPanel;
    lbOrigFuel: TLabel;
    seOrigFuelDensity: TSpinBox;
    Label28: TLabel;
    Panel35: TPanel;
    lbAdd1Amount: TLabel;
    seAdd1VolAmt: TSpinBox;
    lbAdditives: TLabel;
    Panel36: TPanel;
    lbOriginalFuelAmt: TLabel;
    seOrigVolume: TSpinBox;
    Panel39: TPanel;
    lbAdd2Amount: TLabel;
    seAdd2VolAmt: TSpinBox;
    Panel24: TPanel;
    lbAd2: TLabel;
    seAdd2Density: TSpinBox;
    Label11: TLabel;
    Panel27: TPanel;
    Label25: TLabel;
    seNewVolume: TSpinBox;
    Panel28: TPanel;
    Label26: TLabel;
    seNewDensity: TSpinBox;
    ebProAddDensity: TEdit;
    Panel29: TPanel;
    Label27: TLabel;
    seAddNitroDensity: TSpinBox;
    Panel30: TPanel;
    lbAddNitroAmount: TLabel;
    seAddNitroVolAmt: TSpinBox;
    Panel31: TPanel;
    Label30: TLabel;
    seNewWeight: TSpinBox;
    ebProAddWeight: TEdit;
    Panel32: TPanel;
    lbNewNitroContent: TLabel;
    seNewNitroByVol: TSpinBox;
    Panel34: TPanel;
    lbOrigNitroContent: TLabel;
    seOrigNitroPct: TSpinBox;
    Panel25: TPanel;
    rbAddByWeight: TRadioButton;
    rbAddByVolume: TRadioButton;
    pnlMixing: TPanel;
    Label2: TLabel;
    Panel5: TPanel;
    Label6: TLabel;
    seMethanolDensity: TSpinBox;
    Panel2: TPanel;
    Label3: TLabel;
    seNitroDensity: TSpinBox;
    Panel3: TPanel;
    Label4: TLabel;
    seCastorDensity: TSpinBox;
    Panel4: TPanel;
    Label5: TLabel;
    seSynthDensity: TSpinBox;
    Label7: TLabel;
    Panel15: TPanel;
    Label17: TLabel;
    seMethanolTarget: TSpinBox;
    Panel1: TPanel;
    Label8: TLabel;
    seNitroTarget: TSpinBox;
    Panel6: TPanel;
    Label9: TLabel;
    seOilTarget: TSpinBox;
    Panel7: TPanel;
    Label10: TLabel;
    seCastorRatio: TSpinBox;
    Panel19: TPanel;
    rbTargetAsMls: TRadioButton;
    rbTargetAsGrams: TRadioButton;
    Panel8: TPanel;
    lbYield: TLabel;
    seTargetYield: TSpinBox;
    Label12: TLabel;
    Panel10: TPanel;
    Label20: TLabel;
    seMethanolMeasurementVol: TSpinBox;
    Panel9: TPanel;
    Label13: TLabel;
    seNitroMeasurementVol: TSpinBox;
    Panel11: TPanel;
    Label15: TLabel;
    seCastorMeasurementVol: TSpinBox;
    Panel12: TPanel;
    Label16: TLabel;
    seSynthMeasurementVol: TSpinBox;
    Label18: TLabel;
    Panel20: TPanel;
    Label24: TLabel;
    seTotalWeight: TSpinBox;
    ebWeightFV: TEdit;
    Panel14: TPanel;
    Label14: TLabel;
    seTotalVolume: TSpinBox;
    Panel17: TPanel;
    Label22: TLabel;
    seMethanolContentByVolume: TSpinBox;
    Panel16: TPanel;
    Label21: TLabel;
    seNitroContentByVolume: TSpinBox;
    Panel18: TPanel;
    Label23: TLabel;
    seOilContentByVolume: TSpinBox;
    Panel22: TPanel;
    lbAdditive1Pct: TLabel;
    seAdditive1Pct: TSpinBox;
    Panel33: TPanel;
    lbAdditive2Pct: TLabel;
    seAdditive2Pct: TSpinBox;
    Panel37: TPanel;
    seAddNitroWgtAmt: TSpinBox;
    Label31: TLabel;
    Label32: TLabel;
    Panel38: TPanel;
    Label29: TLabel;
    seAdd1WgtAmt: TSpinBox;
    Panel40: TPanel;
    Label33: TLabel;
    seAdd2WgtAmt: TSpinBox;
    Label34: TLabel;
    Label35: TLabel;
    Panel41: TPanel;
    seMethanolMeasurementWeight: TSpinBox;
    Label37: TLabel;
    Label38: TLabel;
    Panel42: TPanel;
    seNitroMeasurementWeight: TSpinBox;
    Label40: TLabel;
    Label41: TLabel;
    Panel43: TPanel;
    seCastorMeasurementWeight: TSpinBox;
    Label43: TLabel;
    Label44: TLabel;
    Panel44: TPanel;
    seSynthMeasurementWeight: TSpinBox;
    Label39: TLabel;
    Label42: TLabel;
    Panel13: TPanel;
    Label19: TLabel;
    seTotalDensity: TSpinBox;
    ebDensityFV: TEdit;
    Label36: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    lbYieldUnit: TLabel;
    Panel45: TPanel;
    seNewNitroByWeight: TSpinBox;
    Label50: TLabel;
    lbNewNitroContentBy: TLabel;
    lbAdditive1Pct2: TLabel;
    lbAdditive2Pct2: TLabel;
    ebProNitroByWeight: TEdit;
    Label51: TLabel;
    lbOrigNitroContent2: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    lbMethTargetUnit: TLabel;
    lbNitroTargetUnit: TLabel;
    lbTotalOilTargetUnit: TLabel;
    lbCastorRatioUnit: TLabel;
    Label54: TLabel;
    procedure AddFormToVars(Sender: TObject);
    procedure FormToVars(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbDefaultsClick(Sender: TObject);
    procedure lbSaveClick(Sender: TObject);
    procedure rbTargetAsGramsChange(Sender: TObject);
    procedure rbTargetAsMlsChange(Sender: TObject);
    procedure rbAddByWeightChange(Sender: TObject);
    procedure rbAddByVolumeChange(Sender: TObject);
    procedure AddUnitChange(Sender: TObject);
    procedure tcMainChange(Sender: TObject);
  private
    { Private declarations }
    fOrigMainHeight: single;
    fFuelCalcMix: TFuelCalcMix;
    fFuelCalcAdd: TFuelCalcAdd;
    fLoading: boolean;
    procedure SetAdditiveState;
    procedure VarsToForm;
    procedure VarsToAddForm;
    procedure LoadForm;
  public
    { Public declarations }
  end;

  TAdditiveCalc = class(TObject)

  end;

var
  frmMain: TfrmMain;

const
  cEfre16EUDensity = 859.00;
  cEfre16EUPct = 16.00;

implementation

uses
  uPersistence;

const
  cProName = 'RC Fuel Calc Pro';
  cFreeName = 'RC Fuel Calc Free';
  cOnlyProMessage = 'Please purchase the Pro version to use this feature';

{$R *.fmx}

{TfrmMain}

procedure TfrmMain.AddUnitChange(Sender: TObject);
begin
  if rbAddByVolume.IsChecked then begin
    lbAddNitroAmount.Text := 'Nitromethane (mls)';
    lbAdd1Amount.Text := 'Additive 1 (mls)';
    lbAdd2Amount.Text := 'Additive 2 (mls)';
  end else begin
    lbAddNitroAmount.Text := 'Nitromethane (g)';
    lbAdd1Amount.Text := 'Additive 1 (g)';
    lbAdd2Amount.Text := 'Additive 2 (g)';
  end;
  AddFormToVars(Sender);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  fOrigMainHeight := tcMain.Height;
  tcMain.ActiveTab := tiMixing;
  fLoading := true;
  fFuelCalcMix := TFuelCalcMix.Create;
  fFuelCalcAdd := TFuelCalcAdd.Create;
  {$IFDEF PRO}
  lbHeader.Text := cProName;
  Caption := cProName;
  ebWeightFV.Visible := false;
  ebDensityFV.Visible := false;
  ebProAddWeight.Visible := false;
  ebProAddDensity.Visible := false;
  ebProNitroByWeight.Visible := false;
  {$ELSE}
  lbHeader.Text := cFreeName;
  Caption := cFreeName;
  ebWeightFV.Visible := true;
  ebWeightFV.Width := seTotalWeight.Width;
  seTotalWeight.Visible := false;
  ebDensityFV.Visible := true;
  ebDensityFV.Width := seTotalDensity.Width;
  seTotalDensity.Visible := false;
  seNewWeight.Visible := false;
  seNewDensity.Visible := false;
  seNewNitroByWeight.Visible := false;
  ebProAddWeight.Width := seNewWeight.Width;
  ebProAddDensity.Width := seNewDensity.Width;
  ebProNitroByWeight.Width := seNewNitroByWeight.Width;
  {$ENDIF}
  if fFuelCalcMix.TargetType = utVolume then
    lbYieldUnit.Text := '(ml)'
  else
    lbYieldUnit.Text := '(g)';
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  try
    fFuelCalcMix.DisposeOf;
    fFuelCalcAdd.DisposeOf;
  finally
    inherited;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  LoadForm;
end;

procedure TfrmMain.VarsToForm;
begin
  seNitroDensity.Value := fFuelCalcMix.NitroDensity;
  seMethanolDensity.Value := fFuelCalcMix.MethanolDensity;
  seCastorDensity.Value := fFuelCalcMix.CastorDensity;
  seSynthDensity.Value := fFuelCalcMix.SynthDensity;
  seNitroTarget.Value := fFuelCalcMix.NitroTarget;
  seOilTarget.Value := fFuelCalcMix.OilTarget;
  seCastorRatio.Value := fFuelCalcMix.CastorRatio;
  seTargetYield.Value := fFuelCalcMix.TargetYield;
  seMethanolTarget.Value := 100 - (fFuelCalcMix.NitroTarget + fFuelCalcMix.OilTarget);
  seNitroMeasurementWeight.Value := fFuelCalcMix.NitroWeight;
  seCastorMeasurementWeight.Value := fFuelCalcMix.CastorWeight;
  seSynthMeasurementWeight.Value := fFuelCalcMix.SynthWeight;
  seMethanolMeasurementWeight.Value := fFuelCalcMix.MethanolWeight;
  seNitroMeasurementVol.Value := fFuelCalcMix.NitroVolume;
  seCastorMeasurementVol.Value := fFuelCalcMix.CastorVolume;
  seSynthMeasurementVol.Value := fFuelCalcMix.SynthVolume;
  seMethanolMeasurementVol.Value := fFuelCalcMix.MethanolVolume;
  seTotalWeight.Value := fFuelCalcMix.TotalWeight;
  seTotalVolume.Value := fFuelCalcMix.TotalVolume;
  seTotalDensity.Value := fFuelCalcMix.TotalDensity;
  seNitroContentByVolume.Value := fFuelCalcMix.NitroContentByVolume;
  seOilContentByVolume.Value := fFuelCalcMix.OilContentByVolume;
  seMethanolContentByVolume.Value := fFuelCalcMix.MethanolContentByVolume;
  rbTargetAsMls.IsChecked := fFuelCalcMix.TargetType = utVolume;
  rbTargetAsGrams.IsChecked := fFuelCalcMix.TargetType = utWeight;
end;

procedure TfrmMain.FormToVars(Sender: TObject);
begin
  if not fLoading then begin
    fFuelCalcMix.NitroDensity := seNitroDensity.Value;
    fFuelCalcMix.MethanolDensity := seMethanolDensity.Value;
    fFuelCalcMix.CastorDensity := seCastorDensity.Value;
    fFuelCalcMix.SynthDensity := seSynthDensity.Value;
    fFuelCalcMix.NitroTarget := seNitroTarget.Value;
    fFuelCalcMix.OilTarget := seOilTarget.Value;
    fFuelCalcMix.CastorRatio := seCastorRatio.Value;
    fFuelCalcMix.TargetYield := seTargetYield.Value;
    if rbTargetAsMls.IsChecked then
      fFuelCalcMix.TargetType := utVolume
    else
      fFuelCalcMix.TargetType := utWeight;
    fFuelCalcMix.Calc;
    VarsToForm;
  end;
end;

procedure TfrmMain.AddFormToVars(Sender: TObject);
begin
  if not fLoading then begin
    if rbAddByVolume.IsChecked then
      fFuelCalcAdd.UnitType := utVolume
    else
      fFuelCalcAdd.UnitType := utWeight;
    fFuelCalcAdd.OrigFuelDensity := seOrigFuelDensity.Value;
    fFuelCalcAdd.NitroDensity := seAddNitroDensity.Value;
    fFuelCalcAdd.Additive1Density := seAdd1Density.Value;
    fFuelCalcAdd.Additive2Density := seAdd2Density.Value;
    fFuelCalcAdd.OrigFuelVolume := seOrigVolume.Value;
    fFuelCalcAdd.OrigNitroPct := seOrigNitroPct.Value;
    if fFuelCalcAdd.UnitType = utVolume then begin
      fFuelCalcAdd.AddNitroAmount := seAddNitroVolAmt.Value;
      fFuelCalcAdd.Additive1Amount := seAdd1VolAmt.Value;
      fFuelCalcAdd.Additive2Amount := seAdd2VolAmt.Value;
      seAddNitroWgtAmt.Value := fFuelCalcAdd.ToWeight(fFuelCalcAdd.AddNitroAmount, fFuelCalcAdd.NitroDensity);
      seAdd1WgtAmt.Value := fFuelCalcAdd.ToWeight(fFuelCalcAdd.Additive1Amount, fFuelCalcAdd.Additive1Density);
      seAdd2WgtAmt.Value := fFuelCalcAdd.ToWeight(fFuelCalcAdd.Additive2Amount, fFuelCalcAdd.Additive2Density);
    end else begin
      fFuelCalcAdd.AddNitroAmount := seAddNitroWgtAmt.Value;
      fFuelCalcAdd.Additive1Amount := seAdd1WgtAmt.Value;
      fFuelCalcAdd.Additive2Amount := seAdd2WgtAmt.Value;
      seAddNitroVolAmt.Value := fFuelCalcAdd.ToVolume(fFuelCalcAdd.AddNitroAmount, fFuelCalcAdd.NitroDensity);
      seAdd1VolAmt.Value := fFuelCalcAdd.ToVolume(fFuelCalcAdd.Additive1Amount, fFuelCalcAdd.Additive1Density);
      seAdd2VolAmt.Value := fFuelCalcAdd.ToVolume(fFuelCalcAdd.Additive2Amount, fFuelCalcAdd.Additive2Density);
    end;
    fFuelCalcAdd.Calc;
    VarsToAddForm;
  end;
end;

procedure TfrmMain.VarsToAddForm;
begin
  seNewVolume.Value := fFuelCalcAdd.NewVolume;
  seNewWeight.Value := fFuelCalcAdd.NewWeight;
  seNewDensity.Value := fFuelCalcAdd.NewDensity;
  seNewNitroByVol.Value := fFuelCalcAdd.NewNitroVolumePct;
  seNewNitroByWeight.Value := fFuelCalcAdd.NewNitroWeightPct;
  seAdditive1Pct.Value := fFuelCalcAdd.NewAdd1Pct;
  seAdditive2Pct.Value := fFuelCalcAdd.NewAdd2Pct;
end;

procedure TfrmMain.lbDefaultsClick(Sender: TObject);
begin
  fFuelCalcMix.ApplyDefaultValues;
  fFuelCalcAdd.ApplyDefaultValues;
  LoadForm;
  ShowMessage('The default values have been restored');
end;

procedure TfrmMain.lbSaveClick(Sender: TObject);
begin
  {$IFNDEF PRO}
  ShowMessage(cOnlyProMessage);
  {$ELSE}
  if fFuelCalcMix.Save and
     fFuelCalcAdd.Save then
    ShowMessage('The current settings will be loaded the next time the app launches')
  else
    ShowMessage('Error saving settings: ' + fFuelCalcMix.Persistence.ErrorMsg);
  {$ENDIF}
end;

procedure TfrmMain.LoadForm;
begin
  fLoading := true;
  try
    fFuelCalcMix.Calc;
    VarsToForm;
    rbAddByWeight.IsChecked := fFuelCalcAdd.UnitType = utWeight;
    seOrigFuelDensity.Value := fFuelCalcAdd.OrigFuelDensity;
    seAddNitroDensity.Value := fFuelCalcAdd.NitroDensity;
    seAdd1Density.Value := fFuelCalcAdd.Additive1Density;
    seAdd2Density.Value := fFuelCalcAdd.Additive2Density;
    seOrigVolume.Value := fFuelCalcAdd.OrigFuelVolume;
    seOrigNitroPct.Value := fFuelCalcAdd.OrigNitroPct;
    if fFuelCalcAdd.UnitType = utVolume then begin
      seAddNitroVolAmt.Value := fFuelCalcAdd.AddNitroAmount;
      seAdd1VolAmt.Value := fFuelCalcAdd.Additive1Amount;
      seAdd2VolAmt.Value := fFuelCalcAdd.Additive2Amount;
      seAddNitroWgtAmt.Value := fFuelCalcAdd.AddNitroAmount * fFuelCalcAdd.GramsPerMl(fFuelCalcAdd.NitroDensity);
      seAdd1WgtAmt.Value := fFuelCalcAdd.Additive1Amount * fFuelCalcAdd.GramsPerMl(fFuelCalcAdd.Additive1Density);
      seAdd2WgtAmt.Value := fFuelCalcAdd.Additive2Amount * fFuelCalcAdd.GramsPerMl(fFuelCalcAdd.Additive2Density);
    end else begin
      seAddNitroWgtAmt.Value := fFuelCalcAdd.AddNitroAmount;
      seAdd1WgtAmt.Value := fFuelCalcAdd.Additive1Amount;
      seAdd2WgtAmt.Value := fFuelCalcAdd.Additive2Amount;
      seAddNitroVolAmt.Value := fFuelCalcAdd.AddNitroAmount / fFuelCalcAdd.GramsPerMl(fFuelCalcAdd.NitroDensity);
      seAdd1VolAmt.Value := fFuelCalcAdd.Additive1Amount / fFuelCalcAdd.GramsPerMl(fFuelCalcAdd.Additive1Density);
      seAdd2VolAmt.Value := fFuelCalcAdd.Additive2Amount / fFuelCalcAdd.GramsPerMl(fFuelCalcAdd.Additive2Density);
    end;
    fFuelCalcAdd.Calc;
    VarsToAddForm;
  finally
    fLoading := false;
  end;
end;

procedure TfrmMain.rbAddByVolumeChange(Sender: TObject);
begin
  SetAdditiveState;
  lbOrigNitroContent2.Text := '(Vol)';
  lbAdditive1Pct2.Text := '(Vol)';
  lbAdditive2Pct2.Text := '(Vol)';
  AddFormToVars(Sender);
end;

procedure TfrmMain.rbAddByWeightChange(Sender: TObject);
begin
  {$IFNDEF PRO}
  if rbAddByWeight.IsChecked then begin
    rbAddByVolume.IsChecked := true;
    ShowMessage(cOnlyProMessage);
  end;
  {$ELSE}
  SetAdditiveState;
  lbOrigNitroContent2.Text := '(Wgt)';
  lbAdditive1Pct2.Text := '(Wgt)';
  lbAdditive2Pct2.Text := '(Wgt)';
  AddFormToVars(Sender);
  {$ENDIF}
end;

procedure TfrmMain.rbTargetAsGramsChange(Sender: TObject);
begin
  {$IFNDEF PRO}
  if rbTargetAsGrams.IsChecked then begin
    rbTargetAsMls.IsChecked := true;
    ShowMessage(cOnlyProMessage);
  end;
  {$ELSE}
  lbYieldUnit.Text := '(g)';
  lbMethTargetUnit.Text := '(Wgt)';
  lbNitroTargetUnit.Text := '(Wgt)';
  lbTotalOilTargetUnit.Text := '(Wgt)';
  lbCastorRatioUnit.Text := '(Wgt)';
  FormToVars(Sender);
  {$ENDIF}
end;

procedure TfrmMain.rbTargetAsMlsChange(Sender: TObject);
begin
  lbYieldUnit.Text := '(ml)';
  lbMethTargetUnit.Text := '(Vol)';
  lbNitroTargetUnit.Text := '(Vol)';
  lbTotalOilTargetUnit.Text := '(Vol)';
  lbCastorRatioUnit.Text := '(Vol)';
  FormToVars(Sender);
end;

procedure TfrmMain.SetAdditiveState;
begin
  seAddNitroVolAmt.Enabled := rbAddByVolume.IsChecked;
  seAdd1VolAmt.Enabled  := rbAddByVolume.IsChecked;
  seAdd2VolAmt.Enabled := rbAddByVolume.IsChecked;
  seAddNitroWgtAmt.Enabled := rbAddByWeight.IsChecked;
  seAdd1WgtAmt.Enabled  := rbAddByWeight.IsChecked;
  seAdd2WgtAmt.Enabled := rbAddByWeight.IsChecked;
end;

procedure TfrmMain.tcMainChange(Sender: TObject);
begin
  if tcMain.ActiveTab = tiMixing then
    tcMain.Height := fOrigMainHeight
  else if tcMain.ActiveTab = tiAdding then
    tcMain.Height := pnlAdding.Height;
end;

end.

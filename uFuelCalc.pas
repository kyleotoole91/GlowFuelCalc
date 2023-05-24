unit uFuelCalc;

interface

uses
  uPersistence;

type
  TFuelCalc = class (TObject)
  strict private
    fPersistence: TPersistence;
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
    function Save: boolean;
    procedure ApplyDefaultValues;
    property Persistence: TPersistence read fPersistence write fPersistence;
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

implementation

{ TFuelCalc }

constructor TFuelCalc.Create;
begin
  inherited;
  fPersistence := TPersistence.Create;
  fNitroDensity := fPersistence.Densities.Nitro;
  fMethanolDensity := fPersistence.Densities.Methanol;
  fCastorDensity := fPersistence.Densities.CastorOil;
  fSynthDensity := fPersistence.Densities.SyntheticOil;
  fNitroTarget := fPersistence.Targets.Nitro;
  fOilTarget := fPersistence.Targets.Oil;
  fCastorRatio := fPersistence.Targets.CastorRatio;
  fTargetYield := fPersistence.Targets.Yield;
  fTargetType := fPersistence.Targets.TargetType;
end;

procedure TFuelCalc.ApplyDefaultValues;
begin
  fNitroDensity := cNitroDensity;
  fMethanolDensity := cMethanolDensity;
  fCastorDensity := cCastorDensity;
  fSynthDensity := cSynthDensity;
  fNitroTarget := cNitroTarget;
  fOilTarget := cOilTarget;
  fCastorRatio := cCastorRatio;
  fTargetYield := cYieldTarget;
  fTargetType := ttVolume;
end;

procedure TFuelCalc.Calc;
begin
  fSynthPct := (fOilTarget / 100) * (100 - fCastorRatio);
  fCastorPct := fOilTarget - fSynthPct;
  if fTargetType = ttWeight then
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

function TFuelCalc.Save: boolean;
begin
  fPersistence.Densities.Nitro := fNitroDensity;
  fPersistence.Densities.Methanol := fMethanolDensity;
  fPersistence.Densities.CastorOil := fCastorDensity;
  fPersistence.Densities.SyntheticOil := fSynthDensity;
  fPersistence.Targets.Nitro := fNitroTarget;
  fPersistence.Targets.Oil := fOilTarget;
  fPersistence.Targets.CastorRatio := fCastorRatio;
  fPersistence.Targets.Yield := fTargetYield;
  fPersistence.Targets.TargetType := fTargetType;
  result := fPersistence.Save;
end;

end.

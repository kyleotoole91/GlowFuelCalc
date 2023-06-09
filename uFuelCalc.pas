unit uFuelCalc;

interface

uses
  uPersistence;

type
  TFuelCalcBase = class (TObject)
  protected
    fNitroDensity: double;
    fPersistence: TPersistence;
    function CalcIngredientAmount(const ATotalAmount: double; const APercentage: double): double;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Calc; virtual; abstract;
    function Save: boolean; virtual; abstract;
    function GramsPerMl(const ADensityPerLitre: double): double;
    function ToVolume(const AWeight: double; const ADensity: double): double;
    function ToWeight(const AVolume: double; const ADensity: double): double;
    procedure ApplyDefaultValues; virtual;
    property NitroDensity: double read fNitroDensity write fNitroDensity;
  end;

  TFuelCalcAdd = class (TFuelCalcBase)
  strict private
    fOrigFuelDensity: double;
    fAdditive1Density: double;
    fAdditive2Density: double;
    fOrigFuelVolume: double;
    fOrigNitroPct: double;
    fAddNitroAmount: double;
    fAdditive1Amount: double;
    fAdditive2Amount: double;
    fUnitType: TUnitType;
    fNewVolume: double;
    fNewDensity: double;
    fNewWeight: double;
    fNewNitroPct: double;
    fNewAdd1Pct: double;
    fNewAdd2Pct: double;
    fNewNitroWeightPct: double;
    fNewNitroVolumePct: double;
  public
    constructor Create; override;
    procedure Calc; override;
    function Save: boolean; override;
    procedure ApplyDefaultValues; override;
    property OrigFuelDensity: double read fOrigFuelDensity write fOrigFuelDensity;
    property Additive1Density: double read fAdditive1Density write fAdditive1Density;
    property Additive2Density: double read fAdditive2Density write fAdditive2Density;
    property Additive1Amount: double read fAdditive1Amount write fAdditive1Amount;
    property Additive2Amount: double read fAdditive2Amount write fAdditive2Amount;
    property OrigFuelVolume: double read fOrigFuelVolume write fOrigFuelVolume;
    property UnitType: TUnitType read fUnitType write fUnitType;
    property AddNitroAmount: double read fAddNitroAmount write fAddNitroAmount;
    property OrigNitroPct: double read fOrigNitroPct write fOrigNitroPct;
    property NewVolume: double read fNewVolume;
    property NewDensity: double read fNewDensity;
    property NewWeight: double read fNewWeight;
    property NewNitroPct: double read fNewNitroPct;
    property NewAdd1Pct: double read fNewAdd1Pct;
    property NewAdd2Pct: double read fNewAdd2Pct;
    property NewNitroWeightPct: double read fNewNitroWeightPct;
    property NewNitroVolumePct: double read fNewNitroVolumePct;
  end;

  TFuelCalcMix = class (TFuelCalcBase)
  strict private
    fCastorPct: double;
    fSynthPct: double;
    fTargetType: TUnitType;
    fTotalWeight: double;
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
  public
    constructor Create; override;
    procedure Calc; override;
    function Save: boolean; override;
    procedure ApplyDefaultValues; override;
    property Persistence: TPersistence read fPersistence write fPersistence;
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
    property TargetType: TUnitType read fTargetType write fTargetType;
  end;

implementation

{ TFuelCalcBase }

function TFuelCalcBase.GramsPerMl(const ADensityPerLitre: double): double;
begin
  result := ADensityPerLitre / 1000;
end;

function TFuelCalcBase.ToVolume(const AWeight: double; const ADensity: double): double;
begin
  result := AWeight / GramsPerMl(ADensity);
end;

function TFuelCalcBase.ToWeight(const AVolume: double; const ADensity: double): double;
begin
  result := AVolume * GramsPerMl(ADensity);
end;

function TFuelCalcBase.CalcIngredientAmount(const ATotalAmount: double; const APercentage: double): double;
begin
  result := (ATotalAmount / 100) * APercentage;
end;

{ TFuelCalc }

constructor TFuelCalcMix.Create;
begin
  inherited;
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

procedure TFuelCalcMix.ApplyDefaultValues;
begin
  inherited;
  fMethanolDensity := cMethanolDensity;
  fCastorDensity := cCastorDensity;
  fSynthDensity := cSynthDensity;
  fNitroTarget := cNitroTarget;
  fOilTarget := cOilTarget;
  fCastorRatio := cCastorRatio;
  fTargetYield := cYieldTarget;
  fTargetType := utVolume;
end;

procedure TFuelCalcMix.Calc;
begin
  inherited;
  fSynthPct := (fOilTarget / 100) * (100 - fCastorRatio);
  fCastorPct := fOilTarget - fSynthPct;
  if fTargetType = utWeight then
    CalcByWeight
  else
    CalcByVolume;
end;

procedure TFuelCalcMix.CalcByVolume;
begin
  fCastorVolume := CalcIngredientAmount(fTargetYield, fCastorPct);
  fSynthVolume := CalcIngredientAmount(fTargetYield, fSynthPct);
  fNitroVolume := CalcIngredientAmount(fTargetYield, fNitroTarget);
  fMethanolVolume := fTargetYield - (fCastorVolume + fSynthVolume + fNitroVolume);
  fTotalVolume := fCastorVolume + fSynthVolume + fNitroVolume + fMethanolVolume;
  fCastorWeight := ToWeight(fCastorVolume, fCastorDensity);
  fSynthWeight := ToWeight(fSynthVolume, fSynthDensity);
  fNitroWeight := ToWeight(fNitroVolume, fNitroDensity);
  fMethanolWeight := ToWeight(fMethanolVolume, fMethanolDensity);
  fTotalWeight := fCastorWeight + fSynthWeight + fNitroWeight + fMethanolWeight;
  fNitroContentByVolume := (fNitroVolume / fTotalVolume) * 100;
  fOilContentByVolume := ((fSynthVolume + fCastorVolume) / fTotalVolume) * 100;
  fMethanolContentByVolume := (fMethanolVolume / fTotalVolume) * 100;
  fTotalDensity := (fTotalWeight / fTargetYield) * 1000;
end;

procedure TFuelCalcMix.CalcByWeight;
begin
  fCastorWeight := CalcIngredientAmount(fTargetYield, fCastorPct);
  fSynthWeight := CalcIngredientAmount(fTargetYield, fSynthPct);
  fNitroWeight := CalcIngredientAmount(fTargetYield, fNitroTarget);
  fMethanolWeight := fTargetYield - (fCastorWeight + fSynthWeight + fNitroWeight);
  fTotalWeight := fCastorWeight + fSynthWeight + fNitroWeight + fMethanolWeight;
  fCastorVolume := ToVolume(fCastorWeight, fCastorDensity);
  fSynthVolume := ToVolume(fSynthWeight, fSynthDensity);
  fNitroVolume := ToVolume(fNitroWeight, fNitroDensity);
  fMethanolVolume := ToVolume(fMethanolWeight, fMethanolDensity);
  fTotalVolume := fCastorVolume + fSynthVolume + fNitroVolume + fMethanolVolume;
  fNitroContentByVolume := (fNitroVolume / fTotalVolume) * 100;
  fOilContentByVolume := ((fSynthVolume + fCastorVolume) / fTotalVolume) * 100;
  fMethanolContentByVolume := (fMethanolVolume / fTotalVolume) * 100;
  fTotalDensity := (fTargetYield / fTotalVolume) * 1000;
end;

function TFuelCalcMix.Save: boolean;
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

{ TFuelCalcBase }

procedure TFuelCalcBase.ApplyDefaultValues;
begin
  fNitroDensity := cNitroDensity;
end;

constructor TFuelCalcBase.Create;
begin
  inherited;
  fPersistence := TPersistence.Create;
end;

destructor TFuelCalcBase.Destroy;
begin
  try
    fPersistence.DisposeOf;
  finally
    inherited;
  end;
end;

{ TFuelCalcAdd }

procedure TFuelCalcAdd.ApplyDefaultValues;
begin
  inherited;
  fAddNitroAmount := 0;
  fAdditive1Amount := 0;
  fAdditive2Amount := 0;
  fOrigFuelVolume := cOrigFuelVolume;
  fOrigNitroPct := cOrigNitroPct;
  fNitroDensity := cNitroDensity;
  fAdditive1Density := cCastorDensity;
  fAdditive2Density := cSynthDensity;
  fOrigFuelDensity := cOrigFuelDensity;
end;

procedure TFuelCalcAdd.Calc;
var
  origFuelWeight: double;
  addNitroWeight: double;
  add1Weight: double;
  add2Weight: double;
  newNitroMls: double;
  addNitroVol: double;
  add1Vol: double;
  add2Vol: double;
  newNitroGrams: double;
begin
  origFuelWeight := ToWeight(fOrigFuelVolume, fOrigFuelDensity);
  if fUnitType = utVolume then begin
    addNitroWeight := ToWeight(fAddNitroAmount, fNitroDensity);
    add1Weight := ToWeight(fAdditive1Amount, fAdditive1Density);
    add2Weight := ToWeight(fAdditive2Amount, fAdditive2Density);
    fNewWeight := origFuelWeight + addNitroWeight + add1Weight + add2Weight;
    fNewVolume := fOrigFuelVolume + fAddNitroAmount + fAdditive1Amount + fAdditive2Amount;
    fNewDensity := (fNewWeight / fNewVolume) * 1000;
    newNitroMls := ((fOrigFuelVolume / 100) * fOrigNitroPct) + fAddNitroAmount;
    fNewNitroPct := (newNitroMls / fNewVolume) * 100;
    fNewAdd1Pct := (fAdditive1Amount / fNewVolume) * 100;
    fNewAdd2Pct := (fAdditive2Amount / fNewVolume) * 100;
    fNewNitroWeightPct := (ToWeight(newNitroMls, fNitroDensity) / fNewWeight) * 100;
    fNewNitroVolumePct := fNewNitroPct;
  end else if fUnitType = utWeight then begin
    addNitroVol := ToVolume(fAddNitroAmount, fNitroDensity);
    add1Vol := ToVolume(fAdditive1Amount, fAdditive1Density);
    add2Vol := ToVolume(fAdditive2Amount, fAdditive2Density);
    fNewWeight := origFuelWeight + fAddNitroAmount + fAdditive1Amount + fAdditive2Amount;
    fNewVolume := fOrigFuelVolume + addNitroVol + add1Vol + add2Vol;
    fNewDensity := (fNewWeight / fNewVolume) * 1000;
    newNitroGrams := ((origFuelWeight / 100) * fOrigNitroPct) + fAddNitroAmount;
    fNewNitroPct := (newNitroGrams / fNewWeight) * 100;
    fNewAdd1Pct := (fAdditive1Amount / fNewWeight) * 100;
    fNewAdd2Pct := (fAdditive2Amount / fNewWeight) * 100;
    fNewNitroVolumePct := (ToVolume(newNitroGrams, fNitroDensity) / fNewVolume) * 100;
    fNewNitroWeightPct := fNewNitroPct;
  end;
end;

constructor TFuelCalcAdd.Create;
begin
  inherited;
  fNitroDensity := fPersistence.Densities.AddNitro;
  fOrigFuelDensity := fPersistence.Densities.OrigFuel;
  fAdditive1Density := fPersistence.Densities.Additive1;
  fAdditive2Density := fPersistence.Densities.Additive2;
  fOrigFuelVolume := fPersistence.OriginalFuel.Volume;
  fOrigNitroPct := fPersistence.OriginalFuel.NitroPct;
  fAddNitroAmount := fPersistence.Additives.NitroAmount;
  fAdditive1Amount := fPersistence.Additives.Additive1Amount;
  fAdditive2Amount := fPersistence.Additives.Additive2Amount;
  fUnitType := fPersistence.AddUnitType;
end;

function TFuelCalcAdd.Save: boolean;
begin
  fPersistence.Densities.OrigFuel := fOrigFuelDensity;
  fPersistence.Densities.AddNitro := fNitroDensity;
  fPersistence.Densities.Additive1 := fAdditive1Density;
  fPersistence.Densities.Additive2 := fAdditive2Density;
  fPersistence.OriginalFuel.Volume := fOrigFuelVolume;
  fPersistence.OriginalFuel.NitroPct := fOrigNitroPct;
  fPersistence.Additives.NitroAmount := fAddNitroAmount;
  fPersistence.Additives.Additive1Amount := fAdditive1Amount;
  fPersistence.Additives.Additive2Amount := fAdditive2Amount;
  fPersistence.AddUnitType := fUnitType;
  result := fPersistence.Save;
end;

end.

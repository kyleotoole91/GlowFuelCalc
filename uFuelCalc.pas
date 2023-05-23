unit uFuelCalc;

interface

type
  TTargetType = (ttWeight = 0, ttVolume = 1);
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

implementation

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
  fTargetYield := 1000;
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

end.

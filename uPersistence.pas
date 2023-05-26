unit uPersistence;

interface

uses
  SysUtils, IOUtils, INIFiles;

const
  cNitroDensity = 1140;
  cMethanolDensity = 792;
  cCastorDensity = 962;
  cSynthDensity = 994;
  cOrigFuelDensity = 848;
  cNitroTarget = 16;
  cOrigFuelVolume = 1000;
  cOrigNitroPct = 16;
  {$IFDEF PRO}
  cOilTarget = 14.93;
  {$ELSE}
  cOilTarget = 12.00;
  {$ENDIF}
  cCastorRatio = 30;
  cYieldTarget = 1000;

type
  TUnitType = (utWeight = 0, utVolume = 1);

  TOriginalFuel = class(TObject)
  public
    Volume: double;
    NitroPct: double;
  end;

  TAdditives = class(TObject)
  public
    NitroAmount: double;
    Additive1Amount: double;
    Additive2Amount: double;
  end;

  TDensities = class(TObject)
  public
    Methanol: double;
    Nitro: double;
    CastorOil: double;
    SyntheticOil: double;
    OrigFuel: double;
    AddNitro: double;
    Additive1: double;
    Additive2: double;
  end;

  TTargets = class(TObject)
  public
    Oil: double;
    Nitro: double;
    CastorRatio: double;
    Yield: double;
    TargetType: TUnitType;
  end;

  TPersistence = class(TObject)
  strict private
    fINIFile: TMemINIFile;
    fDensities: TDensities;
    fOriginalFuel: TOriginalFuel;
    fAdditives: TAdditives;
    fTargets: TTargets;
    fErrorMsg: string;
    fAddUnitType: TUnitType;
    function INIFilename: string;
  public
    constructor Create;
    destructor Destroy; override;
    function Save: boolean;
    function Load: boolean;
    property Densities: TDensities read fDensities;
    property Targets: TTargets read fTargets;
    property OriginalFuel: TOriginalFuel read fOriginalFuel;
    property Additives: TAdditives read fAdditives;
    property ErrorMsg: string read fErrorMsg;
    property AddUnitType: TUnitType read fAddUnitType write fAddUnitType;
  end;

implementation

const
  {$IFDEF PRO}
  cINIFilename = 'rcFuelCalcPro.ini';
  {$ELSE}
  cINIFilename = 'rcFuelCalc.ini';
  {$ENDIF}

{ TPersistence }

constructor TPersistence.Create;
begin
  inherited;
  fErrorMsg := '';
  fDensities := TDensities.Create;
  fTargets := TTargets.Create;
  fOriginalFuel := TOriginalFuel.Create;
  fAdditives := TAdditives.Create;
  Load;
end;

destructor TPersistence.Destroy;
begin
  try
    fDensities.DisposeOf;
    fTargets.DisposeOf;
    fOriginalFuel.DisposeOf;
    fAdditives.DisposeOf;
  finally
    inherited;
  end;
end;

function TPersistence.INIFilename: string;
begin
  result := System.IOUtils.TPath.GetDocumentsPath + System.SysUtils.PathDelim  + cINIFilename;
end;

function TPersistence.Load: boolean;
begin
  result := true;
  try
    fINIFile := TMemINIFile.Create(INIFilename);
    try
      AddUnitType := TUnitType(fINIFile.ReadInteger('Densities', 'AddUnitType', integer(utVolume)));
      with fDensities do begin
        Methanol := fINIFile.ReadFloat('Densities', 'Methanol', cMethanolDensity);
        Nitro := fINIFile.ReadFloat('Densities', 'Nitro', cNitroDensity);
        CastorOil := fINIFile.ReadFloat('Densities', 'CastorOil', cCastorDensity);
        SyntheticOil := fINIFile.ReadFloat('Densities', 'SyntheticOil', cSynthDensity);
        OrigFuel := fINIFile.ReadFloat('Densities', 'OrigFuel', cOrigFuelDensity);
        AddNitro := fINIFile.ReadFloat('Densities', 'AddNitro', cNitroDensity);
        Additive1 := fINIFile.ReadFloat('Densities', 'Additive1', cCastorDensity);
        Additive2 := fINIFile.ReadFloat('Densities', 'Additive2', cSynthDensity);
      end;

      with fOriginalFuel do begin
        Volume := fINIFile.ReadFloat('Targets', 'OriginalFuelVol', cOrigFuelVolume);
        NitroPct := fINIFile.ReadFloat('Targets', 'OrigNitroPct', cOrigNitroPct);
      end;

      with fAdditives do begin
        NitroAmount := fINIFile.ReadFloat('Targets', 'AddNitroAmount', 0);
        Additive1Amount := fINIFile.ReadFloat('Targets', 'Additive1Amount', 0);
        Additive2Amount := fINIFile.ReadFloat('Targets', 'Additive2Amount', 0);
      end;

      with fTargets do begin
        Oil := fINIFile.ReadFloat('Targets', 'Oil', cOilTarget);
        Nitro := fINIFile.ReadFloat('Targets', 'Nitro', cNitroTarget);
        CastorRatio := fINIFile.ReadFloat('Targets', 'CastorRatio', cCastorRatio);
        Yield := fINIFile.ReadFloat('Targets', 'Yield', cYieldTarget);
        TargetType := TUnitType(fINIFile.ReadInteger('Targets', 'TargetType', integer(utVolume)));
      end;
    finally
      fINIFile.DisposeOf;
    end;
  except
    on e: Exception do begin
      fErrorMsg := e.Message;
      result := false;
    end;
  end;
end;

function TPersistence.Save: boolean;
begin
  result := true;
  try
    fINIFile := TMemINIFile.Create(INIFilename);
    try
      with fDensities do begin
        fINIFile.WriteFloat('Densities', 'Methanol', Methanol);
        fINIFile.WriteFloat('Densities', 'Nitro', Nitro);
        fINIFile.WriteFloat('Densities', 'CastorOil', CastorOil);
        fINIFile.WriteFloat('Densities', 'SyntheticOil', SyntheticOil);
        fINIFile.WriteFloat('Densities', 'OrigFuel', OrigFuel);
        fINIFile.WriteFloat('Densities', 'AddNitro', AddNitro);
        fINIFile.WriteFloat('Densities', 'Additive1', Additive1);
        fINIFile.WriteFloat('Densities', 'Additive2', Additive2);
      end;
      with fOriginalFuel do begin
         fINIFile.WriteFloat('Targets', 'Oil', Volume);
         fINIFile.WriteFloat('Targets', 'Nitro', NitroPct);
      end;
      with fAdditives do begin
        fINIFile.WriteFloat('Targets', 'AddNitroAmount', NitroAmount);
        fINIFile.WriteFloat('Targets', 'Additive1Amount', Additive1Amount);
        fINIFile.WriteFloat('Targets', 'Additive2Amount', Additive2Amount);
      end;
      with fTargets do begin
        fINIFile.WriteFloat('Targets', 'Oil', Oil);
        fINIFile.WriteFloat('Targets', 'Nitro', Nitro);
        fINIFile.WriteFloat('Targets', 'CastorRatio', CastorRatio);
        fINIFile.WriteFloat('Targets', 'Yield', Yield);
        fINIFile.WriteInteger('Targets', 'TargetType', integer(TargetType));
      end;
      fINIFile.UpdateFile;
    finally
      fINIFile.DisposeOf;
    end;
  except
    on e: Exception do begin
      fErrorMsg := e.Message;
      result := false;
    end;
  end;
end;

end.

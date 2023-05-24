unit uPersistence;

interface

uses
  SysUtils, IOUtils, INIFiles;

const
  cNitroDensity = 1140;
  cMethanolDensity = 792;
  cCastorDensity = 962;
  cSynthDensity = 994;
  cNitroTarget = 16;
  {$IFDEF PRO}
  cOilTarget = 14.93;
  {$ELSE}
  cOilTarget = 12.00;
  {$IFEND}
  cCastorRatio = 30;
  cYieldTarget = 1000;

type
  TTargetType = (ttWeight = 0, ttVolume = 1);

  TDensities = class(TObject)
  public
    Methanol: double;
    Nitro: double;
    CastorOil: double;
    SyntheticOil: double;
  end;

  TTargets = class(TObject)
  public
    Oil: double;
    Nitro: double;
    CastorRatio: double;
    Yield: double;
    TargetType: TTargetType;
  end;

  TPersistence = class(TObject)
  strict private
    fINIFile: TMemINIFile;
    fDensities: TDensities;
    fTargets: TTargets;
    fErrorMsg: string;
    function INIFilename: string;
  public
    constructor Create;
    destructor Destroy; override;
    function Save: boolean;
    function Load: boolean;
    property Densities: TDensities read fDensities write fDensities;
    property Targets: TTargets read fTargets write fTargets;
    property ErrorMsg: string read fErrorMsg;
  end;

implementation

const
  cINIFilename = 'rcfuelcalc.ini';

{ TPersistence }

constructor TPersistence.Create;
begin
  inherited;
  fErrorMsg := '';
  fDensities := TDensities.Create;
  fTargets := TTargets.Create;
  Load;
end;

destructor TPersistence.Destroy;
begin
  try
    fDensities.DisposeOf;
    fTargets.DisposeOf;
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
      with fDensities do begin
        Methanol := fINIFile.ReadFloat('Densities', 'Methanol', cMethanolDensity);
        Nitro := fINIFile.ReadFloat('Densities', 'Nitro', cNitroDensity);
        CastorOil := fINIFile.ReadFloat('Densities', 'CastorOil', cCastorDensity);
        SyntheticOil := fINIFile.ReadFloat('Densities', 'SyntheticOil', cSynthDensity);
      end;
      with fTargets do begin
        Oil := fINIFile.ReadFloat('Targets', 'Oil', cOilTarget);
        Nitro := fINIFile.ReadFloat('Targets', 'Nitro', cNitroTarget);
        CastorRatio := fINIFile.ReadFloat('Targets', 'CastorRatio', cCastorRatio);
        Yield := fINIFile.ReadFloat('Targets', 'Yield', cYieldTarget);
        TargetType := TTargetType(fINIFile.ReadInteger('Targets', 'TargetType', integer(ttVolume)));
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

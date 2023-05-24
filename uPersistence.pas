unit uPersistence;

interface

uses
  SysUtils, IOUtils, INIFiles;

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
        Methanol := fINIFile.ReadFloat('Densities', 'Methanol', 792);
        Nitro := fINIFile.ReadFloat('Densities', 'Nitro', 1140);
        CastorOil := fINIFile.ReadFloat('Densities', 'CastorOil', 962);
        SyntheticOil := fINIFile.ReadFloat('Densities', 'SyntheticOil', 994);
      end;
      with fTargets do begin
        Oil := fINIFile.ReadFloat('Targets', 'Oil', 14.93);
        Nitro := fINIFile.ReadFloat('Targets', 'Nitro', 16);
        CastorRatio := fINIFile.ReadFloat('Targets', 'CastorRatio', 30);
        Yield := fINIFile.ReadFloat('Targets', 'Yield', 1000);
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

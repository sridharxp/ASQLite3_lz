{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit asqlite3;

{$warn 5023 off : no warning about unused units}
interface

uses
  ASGSQLite3Dsg_lz, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ASGSQLite3Dsg_lz', @ASGSQLite3Dsg_lz.Register);
end;

initialization
  RegisterPackage('asqlite3', @Register);
end.

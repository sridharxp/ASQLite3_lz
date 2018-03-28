{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit asqlite3pkg;

{$warn 5023 off : no warning about unused units}
interface

uses
  ASGRout3_lz, ASGSQLite3_lz, ASGSQLiteData_lz, FieldList, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('asqlite3pkg', @Register);
end.

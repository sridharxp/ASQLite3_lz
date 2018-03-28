(*
Copyright (C) 2017, Sridharan S

This file is part of XLDataset.

XLDataset is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

XLDataset is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License version 3
along with Excel to Tally. If not, see <http://www.gnu.org/licenses/>.
*)

unit FieldList;

{$mode delphi}

interface

uses
  Classes, SysUtils,
  DB;

type

{ TFieldList }
  TFieldList = class(TStringList)
  private
    FUpdated: Boolean;
    FOrigin: Integer;
    function GetField(Index: Integer): TField;
  protected
    function Find(const Name: string): TField; reintroduce;
    function GetCount: Integer; override;
  public
    function FieldByName(const Name: string): TField;
    function GetOffset(const Name: string): Integer;
    constructor Create;
    destructor Destroy; override;
    procedure AddList(const AFields: TFields; const ToUpdate: boolean = False);
    property Fields[Index: Integer]: TField read GetField; default;
    property Origin: Integer write FOrigin;
  end;


implementation

{ TFieldList }

constructor TFieldList.Create;
begin
  inherited Create;
end;

destructor TFieldList.Destroy;
begin
  inherited;
end;

function TFieldList.Find(const Name: string): TField;
var
  ndx: Integer;
begin
  ndx := IndexOf(Name);
  if ndx > -1 then
    Result := TField(GetObject(ndx))
  else
  begin
    Result := nil;
  end;
end;

function TFieldList.GetCount: Integer;
begin
  Result := inherited GetCount;
end;

function TFieldList.FieldByName(const Name: string): TField;
begin
  Result := Find(Name);
end;

function TFieldList.GetField(Index: Integer): TField;
begin
  Result := TField(Objects[Index]);

end;

procedure TFieldList.AddList(const AFields: TFields; const ToUpdate: boolean);
var
    ctr: Integer;
    Field: TField;
begin
  if FUpdated then
    if not ToUpdate then
    Exit;
//  Clear;
    { Using Fields.FList.Count here to exclude sparse fields }
    for ctr := 0 to AFields.Count - 1 do
    begin
      Field := AFields[ctr];
      AddObject(Field.Name, Field);
    end;
  FUpdated := True;
end;

function TFieldList.GetOffset(const Name: string): Integer;
var
  ndx: Integer;
begin
  ndx := IndexOf(Name);
  if ndx > -1 then
    Result := FOrigin + ndx
  else
  begin
    Result := FOrigin;
  end;
end;

end.


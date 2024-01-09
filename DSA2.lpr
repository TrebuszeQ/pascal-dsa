program DSA;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp, Factorial, Floats, Cli
  { you can add units after this };

type

  { DSA2 }
  DSA2 = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ DSA2 }

procedure DSA2.DoRun;
var
  ErrorMsg: String;

begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }

  // stop program loop
  Terminate;
end;

constructor DSA2.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor DSA2.Destroy;
begin
  inherited Destroy;
end;

procedure DSA2.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: DSA2;
  options: array of string;
  opt: int8;

begin
  Application:=DSA2.Create(nil);
  Application.Title:='DSA2';
  Application.Run;
  Application.Free;

  setlength(options, 3);
  options[0] := '1. Silnia.';
  options[1] := '2. Liczby zmiennoprzecinkowe.';
  options[2] := '3. Wyjscie.';

  opt := 0;

  while opt <> length(options) do
     begin
            Cli.print_menu(options);
            opt := Cli.take_input_int('Wprowadz numer odpowiadajacy opcji [typu calkowitego].');

            case opt of
              1: Factorial.menu();

              2: Floats.menu();

              3: writeln('Wyjscie.');

              else writeLn('Brak wybranej opcji');
            end;
     end;


end.


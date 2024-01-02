program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp
  { you can add units after this };

type

  { Factorial }

  Factorial = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
    function take_input_int(): Int64;
    function factorial_recursive(val, i, factorial: Int64): Int64;
    function factorial_iterable(arg: Int64): Int64;
    function print_factorial(msg: string): Boolean;
    function menu(): Boolean;

  end;

{ Factorial }

procedure Factorial.DoRun;
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

constructor Factorial.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Factorial.Destroy;
begin
  inherited Destroy;
end;

procedure Factorial.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

// przyjmuje wartosc Int64
function Factorial.take_input_int(): Int64;
  var
    arg: string = '0';
    res: Int64;
  begin
    repeat
     writeLn('Podaj liczbe calkowita.');
     readLn(arg);
    until TryStrToInt64(arg, res) <> False;

    exit(StrToInt64(arg));
  end;

// oblicza silnie rekursywnie
function Factorial.factorial_recursive(val, i, factorial: Int64): Int64;
         begin
              if (val <= 1) then exit(1)

              else if (i < val) then
                 begin
                   if factorial = 0 then factorial:= 1;
                      factorial:= (factorial + factorial * i);
                      writeln(factorial);
                      i:= i + 1;
                      exit(factorial_recursive(val, i, factorial));
                 end;
         writeln(factorial);
         exit(factorial);

         end;

// oblicza silnie iteracyjnie
function Factorial.factorial_iterable(arg: Int64): Int64;
         var i: Int64;
         begin
              result:= 1;
              if arg >= 1 then
                for i := 1 to arg do
                   begin
                        result:= result * i;
                   end;
              exit(result);
         end;

// wyswietla wynik silni z argumentu
function Factorial.print_factorial(msg: string): Boolean;
         begin
              writeLn(msg);
              exit(True);
         end;

function Factorial.menu(): Boolean;
         var
           opt: Int8;
           options: array[1..5] of string;

         begin
              options[0] := '1. Algorytm rekursywny.';
              options[1] := '2. Algorytm iteracyjny.';
              options[2] := '3. Algorytm rekursywny z mierzeniem czasu.';
              options[3] := '4. Algorytm iteracyjny z mierzeniem czasu.';
              options[4] := '5. Wyjscie.\n');
              exit(True);
         end;

var
  Application: Factorial;
  input: Int64;
  result: Int64;
  message: string;

begin
  Application:=Factorial.Create(nil);
  Application.Title:='Factorial';
  Application.Run;
  Application.Free;

  input := Application.take_input_int();
  result := Application.factorial_recursive(input, 0, 0);

  message := 'Silnia z ' + IntToStr(input) + ', rekursywnie wynosi: ' + IntToStr(result) + '.';
  Application.print_factorial(message);

  result := Application.factorial_iterable(input);
  message := 'Silnia z ' + IntToStr(input) + ', iteracyjnie wynosi: ' + IntToStr(result) + '.';
  Application.print_factorial(message);
end.




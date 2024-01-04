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
    function take_input_int(msg: string): Int64;
    function factorial_recursive(val, i, factorial: Int64): Int64;
    function recursive_timed(val, i, factorial: Int64; start: TDateTime): Int64;
    function factorial_iterable(arg: Int64): Int64;
    function iterable_timed(n: Int64): Int64;

    function print_factorial(msg: string): Boolean;
    function menu(): Boolean;
    function print_menu(options: array of string): Boolean;
    function print_time(start, endt: TDateTime): Boolean;
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
function Factorial.take_input_int(msg: string): Int64;
  var
    arg: string = '0';
    res: Int64;
  begin
    repeat
     writeLn(msg);
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
                      factorial := (factorial + factorial * i);
                      writeln(factorial);
                      i := i + 1;
                      exit(factorial_recursive(val, i, factorial));
                 end;

         exit(factorial);

         end;

// oblicza silnie rekursywnie oraz wyswietla czas wykonania
function Factorial.recursive_timed(val, i, factorial: Int64; start: TDateTime): Int64;
         var
           endt: TDateTime;

         begin
              if (val <= 1) then exit(1)

              else if (i < val) then
                 begin
                   if factorial = 0 then factorial:= 1;
                      factorial := (factorial + factorial * i);
                      writeln(factorial);
                      i := i + 1;
                      exit(recursive_timed(val, i, factorial, start));
                 end;

         endt := Now();
         print_time(start, endt);
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

// oblicza silnie iteracyjnie i mierzy czas
function Factorial.iterable_timed(n: Int64): Int64;
         var
           i: Int64;
           start, endt: TDateTime;

         begin
              start := Now();
              result := 1;

              if n >= 1 then
                for i := 1 to n do
                   begin
                        result := result * i;
                   end;

              endt := Now();
              print_time(start, endt);
              exit(result);
         end;

function Factorial.print_menu(options: array of string): Boolean;
         var
           i: Int8;

         begin
           writeln('');

           for i:=0 to (Length(options) + 1) do writeln(options[i]);
           exit(True);
         end;

function Factorial.print_time(start, endt: TDateTime): Boolean;
         var
           delta :TDateTime;
           iHours, iMinutes, iSeconds, iMilliseconds: Word;

         begin
           Writeln(endt);
           delta := endt - start;
           DecodeTime(delta, iHours, iMinutes, iSeconds, iMilliseconds);

           if iSeconds < 1 then writeln('Program pracowal przez: ', iMilliseconds, ' milisekund.')
           else writeLn('Program pracowal przez: ', iSeconds, ' sekund.');
         end;

function Factorial.menu(): Boolean;
         var
           arg: Int64;
           i: Int64;
           factorial: Int64;
           opt: Int8;
           options: array of string;

         begin
              setLEngth(options, 5);
              options[0] := '1. Algorytm rekursywny.';
              options[1] := '2. Algorytm iteracyjny.';
              options[2] := '3. Algorytm rekursywny z mierzeniem czasu.';
              options[3] := '4. Algorytm iteracyjny z mierzeniem czasu.';
              options[4] := '5. Wyjscie.';

              opt := 0;
              while opt <> 5 do
                    begin
                         print_menu(options);

                         opt := abs(take_input_int('Podaj numer opcji [dodatnia liczba calkowita].'));


                         case opt of
                              1 : begin
                                  arg := abs(take_input_int('Podaj dodatnia liczbe calkowita w celu obliczenia silni.'));
                                  writeLn('Silnia z ', arg, ' wynosi ', factorial_recursive(arg, 0, 0), '.');
                              end;

                              2 : begin
                                  arg := abs(take_input_int('Podaj dodatnia liczbe calkowita w celu obliczenia silni.'));
                                  writeLn('Silnia z ', arg, ' wynosi ', factorial_iterable(arg), '.');
                              end;

                              3 : begin
                                  arg := abs(take_input_int('Podaj dodatnia liczbe calkowita w celu obliczenia silni.'));
                                  factorial := recursive_timed(arg, 0, 0, Now);
                                  writeLn('Silnia z ', arg, ' wynosi ', factorial, '.');
                              end;

                              4 : begin
                                  arg := abs(take_input_int('Podaj dodatnia liczbe calkowita w celu obliczenia silni.'));
                                  factorial := abs(iterable_timed(arg));
                                  writeLn('Silnia z ', arg, ' wynosi ', factorial, '.');
                              end;

                              5 : begin
                                   writeLn('Wyjscie.');
                                   exit(True);
                                   end;

                              else
                                begin
                                     writeLn('Brak wybranej opcji');
                                end;
                         end;
                    end;
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

  Application.menu();
end.




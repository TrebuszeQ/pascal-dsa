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
    function recursive(n: Int64): Int64;
    function iterable(n: Int64): Int64;
    function iterable_max(n: Int64): Int64;
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

function Factorial.recursive(n: Int64): Int64;
         begin
              if (n = 0) then recursive :=1

              else recursive := n * recursive(n-1);

         end;


// oblicza silnie iteracyjnie
function Factorial.iterable(n: Int64): Int64;
         var i: Int64;

         begin
              result:= 1;

              if n >= 1 then
                for i := 1 to n do
                   begin
                        result := result * i;
                   end;

              exit(result);
         end;


// oblicza silnie iteracyjnie i wyswietla licznik i silnie po wystapieniu przeplywu.
function Factorial.iterable_max(n: Int64): Int64;
         var
           i: Int64;
           j: boolean;

         begin
              result := 1;
              j := false;

              if n >= 1 then
                for i := 1 to n do
                   begin
                        result := result * i;

                        if ((result * i) < 0) and (j = false) then
                          begin
                          j := true;
                           writeln('Przepelnienie nastapilo przy liczniku: ', i + 1, '.');
                           writeln('Nastepna wartosc silni wynosi: ', result * i, '.');
                           writeln('Aktualna wartosc silni wynosi: ', result, '.');
                          end;
                   end;

              exit(result);
         end;

// zadanie 4.1

// wyswietla menu
function Factorial.print_menu(options: array of string): Boolean;
         var
           i: Int8;

         begin
           writeln('');

           for i := 0 to Length(options) - 1 do writeln(options[i]);
           writeln();

           exit(True);
         end;


// oblicza i wyswietla
function Factorial.print_time(start, endt: TDateTime): Boolean;
         var
           delta: TDateTime;
           iHours, iMinutes, iSeconds, iMilliseconds: Word;

         begin
           delta := endt - start;
           //Writeln(delta);
           DecodeTime(delta, iHours, iMinutes, iSeconds, iMilliseconds);

           if iSeconds < 1 then writeln('Program obliczal przez: ', iMilliseconds, ' ms.')
           else writeLn('Program obliczal przez: ~', iSeconds, ' s.');

           exit(True);
         end;

function Factorial.menu(): Boolean;
         var
           arg, factorial, i: Int64;
           opt: Int32;
           options: array of string;
           start, endt: TDateTime;

         begin
              setLength(options, 7);
              options[0] := '1. Algorytm rekursywny.';
              options[1] := '2. Algorytm rekursywny z mierzeniem czasu.';
              options[2] := '3. Algorytm rekursywny z mierzeniem czasu, wyswietlajacy dane przeplywu.';
              options[3] := '4. Algorytm iteracyjny.';
              options[4] := '5. Algorytm iteracyjny z mierzeniem czasu.';
              options[5] := '6. Algorytm iteracyjny z mierzeniem czasu, wyswietlajacy dane przeplywu.';
              options[6] := '7. Wyjscie.';

              opt := 0;
              while opt <> Length(options) - 1 do
                    begin
                         print_menu(options);

                         opt := abs(take_input_int('Podaj numer opcji [dodatnia liczba calkowita].'));


                         case opt of
                              1 : begin
                                  arg := abs(take_input_int('Podaj dodatnia liczbe calkowita w celu obliczenia silni.'));
                                  factorial := recursive(arg);

                                  writeLn('Silnia rekurencyjnie: ', arg, ' wynosi ', factorial, '.');
                              end;

                              2 : begin
                                  start := Now();

                                  arg := abs(take_input_int('Podaj dodatnia liczbe calkowita w celu obliczenia silni.'));
                                  factorial := recursive(arg);

                                  endt := Now();
                                  print_time(start, endt);


                                  writeLn('Silnia rekurencyjnie: ', arg, ' wynosi ', factorial, '.');
                              end;

                              3 : begin
                                  arg := abs(take_input_int('Podaj dodatnia liczbe calkowita w celu obliczenia silni.'));
                                  factorial := iterable(arg);

                                  writeLn('Silnia iteracyjnie: ', arg, ' wynosi ', factorial, '.');
                              end;

                              4 : begin
                                  start := Now();

                                  arg := abs(take_input_int('Podaj dodatnia liczbe calkowita w celu obliczenia silni.'));
                                  factorial := iterable(arg);

                                  endt := Now();
                                  print_time(start, endt);
                                  writeLn('Silnia iteracyjnie: ', arg, ' wynosi ', factorial, '.');
                              end;

                              5 : begin
                                  start := Now();

                                  arg := abs(take_input_int('Podaj dodatnia liczbe calkowita w celu obliczenia silni.'));
                                  factorial := iterable_max(arg);

                                  endt := Now();
                                  print_time(start, endt);

                                  writeLn('Silnia iteracyjnie: ', arg, ' wynosi ', factorial, '.');
                              end;

                              6 : begin
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




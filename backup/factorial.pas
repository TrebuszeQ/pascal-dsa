unit Factorial;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Cli;

  //function take_input_int(msg: string): Int64; static;
  function recursive(n: Int64): Int64; static;
  function iterable(n: Int64): Int64; static;
  function iterable_max(n: Int64): Int64; static;
  function menu(): Boolean; static;
  //function print_menu(options: array of string): Boolean; static;
  function print_time(start, endt: TDateTime): Boolean; static;


implementation

function recursive(n: Int64): Int64;
         begin
              if (n = 0) then recursive :=1

              else recursive := n * recursive(n-1);

         end;


// oblicza silnie iteracyjnie
function iterable(n: Int64): Int64; static;
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
function iterable_max(n: Int64): Int64; static;
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

// oblicza i wyswietla
function print_time(start, endt: TDateTime): Boolean; static;
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

function menu(): Boolean; static;
         var
           arg, factorial, i: Int64;
           opt: Int32;
           options: array of string;
           start, endt: TDateTime;

         begin
              setLength(options, 6);
              options[0] := '1. Algorytm rekursywny.';
              options[1] := '2. Algorytm rekursywny z mierzeniem czasu.';
              options[2] := '4. Algorytm iteracyjny.';
              options[3] := '5. Algorytm iteracyjny z mierzeniem czasu.';
              options[4] := '6. Algorytm iteracyjny z mierzeniem czasu, wyswietlajacy dane przeplywu.';
              options[5] := '7. Wyjscie.';

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
end.


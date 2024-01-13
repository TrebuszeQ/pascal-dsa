unit Arrays;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Cli;
  //Nr_dnia liczba_zachor_kobiet liczba_zachor_mężczyzn liczba_zgon_kob. liczba_zgon_męż.
  var x, y: uInt8;
  type AAllStats = array [0..30, 0..4] of integer;
  type TSTArr = array [0..3] of int32;
  type TAArr = array[0..30, 0..2] of integer;
  //dzien1, dzienn, dzienn+1
  type ADeaths = array of integer;
  function random_int(min, max: integer): integer; static;
  function max_deaths(arr: AAllStats): ADeaths; static;
  function avg_daily_sickness(arr: AAllStats): TAArr; static;
  function sum_sickness(arr: AAllStats): TSTArr; static;
  function gen_array(): AAllStats; static;
  function print_avg(arr: TAArr): boolean; static;
  function print_sums(arr: TSTArr): Boolean; static;
  function print_array(arr: AAllStats): Boolean; static;
  function menu(): boolean; static;

implementation


function random_int(min, max: integer): integer; static;
         begin
              result := round(random * max);
              //writeln(result);
              while ((result < min) or (result > max)) do result := round(random * max);

              //if ((result < min) or (result > max)) then random_int(min, max)
              //else exit(result);

              exit(result);
         end;


function max_deaths(arr: AAllStats): ADeaths; static;
         var i, count: smallint;
         current: int32;
         max: integer;

         begin
              count := 0;
              max := 0;

              for i := 0 to (length(arr) - 1) do
                  begin
                    current := (arr[i, 3] + arr[i, 4]);
                    if current > max then max := current;
                  end;

              // wrong
              for i := 0 to (length(arr) - 1) do
                  begin
                       if (current = max) then
                          begin
                            result[count] += max;
                            count += 1;
                          end;
                  end;

              writeln(length(result));
         end;


function avg_daily_sickness(arr: AAllStats): TAArr; static;
         var i: smallint;

         begin
              for i := 0 to (length(arr) - 1) do
                  begin
                    result[i, 0] := (i + 1);
                    result[i, 1] := Round((arr[i,1] + arr[i,2])/2);
                  end;
         end;


function sum_sickness(arr: AAllStats): TSTArr; static;
         var i: smallint;

         begin
              for i := 0 to (length(arr) - 1) do
                  begin
                    result[0] += arr[i,1];
                    result[1] += arr[i,2];
                  end;

              result[2] := (result[0] + result[1]);

              exit(result);
         end;


function gen_array(): AAllStats; static;
         var i: smallint;
         //Nr_dnia liczba_zachor_kobiet liczba_zachor_mężczyzn liczba_zgon_kob. liczba_zgon_męż.
         begin
              for i := 0 to (length(result) - 1) do
                  begin
                    //Nr_dnia
                    result[i,0] := i + 1;
                    //liczba_zachor_kobiet
                    result[i,1] := random_int(1000, 10000);
                    // liczba_zachor_mężczyzn
                    result[i,2] := random_int(1000, 10000);
                    // liczba_zgonow_kobiet
                    result[i,3] := random_int(20, 200);
                    // liczba_zgonow_mezczyzn
                    result[i,4] := random_int(20, 200);
                  end;

              exit(result);
         end;


function print_max_deaths(arr: ADeaths): boolean; static;
         var i: smallint;

         begin
              if length(arr) > 1 then writeln(format('%10s %7d', ['Najwieksza liczba zgonow wystapila w dniu:', arr[0]]))
              else
                begin
                  writeln('Najwieksza liczba zgonow wystapila w dniach: ');

                for i := 0 to (length(arr) - 1) do
                    begin
                         if ((i - 1) = (length(arr) - 1)) then write(arr[i], '.')
                         else write(arr[i], ', ');
                    end;
                end;
              exit(true);
         end;

function print_avg(arr: TAArr): boolean; static;
         var i: smallint;

         begin
              for i := 0 to (length(arr) - 1) do
                  begin
                    if ((i <> 0) and (i mod 10 = 0)) then readln;
                    writeln();
                    write(format('%10s %7d', ['Dzien:', arr[i, 0]]));
                    write(' ':5);
                    write(format('%20s %7d', ['Srednia liczba zachorowan (zakraglona):', arr[i, 1]]));
                    writeln();
                  end;

              exit(true);
         end;


function print_sums(arr: TSTArr): boolean; static;
         var i: smallint;

         begin
              writeln();
              writeln(format('%18s %11d', ['Suma zachorowan kobiet:', arr[0]]));
              writeln(format('%18s %9d', ['Suma zachorowan mezczyzn:', arr[1]]));
              writeln(format('%18s %11d', ['Suma zachorowan ogolem:', arr[2]]));
              writeln();

              exit(true);
         end;


function print_array(arr: AAllStats): boolean; static;
         var i: smallint;

         begin
              for i := 0 to (length(arr) - 1) do
                  begin
                    if ((i <> 0) and (i mod 10 = 0)) then readln;

                       writeln();
                      writeln(format('%0:10s %d.', ['Dzien:', arr[i, 0]]));
                      write(' ':5);
                      write(format('%0:20s %7d', ['Liczba zachorowan mezczyzn:', arr[i, 2]]));
                      write(' ':5);
                      write(format('%20s %7d', ['Liczba zachorowan kobiet:', arr[i, 1]]));
                      writeln();
                      write(' ':5);
                      write(format('%0:20s %11d', ['Liczba zgonow mezczyzn:', arr[i, 4]]));
                      write(' ':5);
                      write(format('%20s %11d', ['Liczba zgonow kobiet:', arr[i, 3]]));
                      writeln();
                  end;

              exit(true);
         end;


function menu(): boolean; static;
         var options: array of string;
           opt: Int32;
           arr: AAllStats;
           sums: TSTArr;
           avg: TAArr;
           max: ADeaths;

         begin

              setlength(options, 5);
              options[0] := '1. Tabela zachorowan i zgonow.';
              options[1] := '2. Miesieczne sumy zachorowan.';
              options[2] := '3. Srednia liczba dziennych zachorowan.';
              options[3] := '4. Dzien z najwieksza liczba zgonow.';
              options[4] := '5. Wyjscie.';

              opt := 0;
              arr := gen_array();
              sums := sum_sickness(arr);
              avg := avg_daily_sickness(arr);
              max := max_deaths(arr);

              while opt <> length(options) do
                    begin
                         Cli.print_menu(options);
                         opt := Cli.take_input_int('Wprowadz numer odpowiadajacy opcji [typu calkowitego].');


                         case opt of
                              1: begin
                                 print_array(arr);
                                 randomize;
                              end;

                              2: print_sums(sums);

                              3: print_avg(avg);

                              4: print_max_deaths(max);

                              5: begin
                                writeln('Wyjscie');
                              end;

                              else writeLn('Brak wybranej opcji');
                         end;
                    end;

              exit(True);
         end;
end.


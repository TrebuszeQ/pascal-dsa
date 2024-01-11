unit Arrays;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Cli;
  type TSArr = array [0..30, 0..5] of integer;
  function random_int(min, max: integer): integer; static;
  function gen_array(): TSArr; static;
  function print_array(arr: TSArr): Boolean; static;
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


//function gen_array(female: boolean): TSArr; static;
//         var sex: string;
//           i: smallint;
//
//         begin
//              if female = true then sex := 'kobiet'
//              else sex := 'mezczyzn';
//
//              for i := 0 to (length(result) - 1) do
//                  begin
//                    result[i] := Format('Dane dotyczace mezczyzn dla %d dnia:' + sLineBreak, [(i + 1)]);
//                    result[i] += Format('Liczba zachorowan: %d.' + sLineBreak, [random_int(1000, 10000)]);
//                    result[i] += Format('Liczba zgonow: %d.', [random_int(20, 200)]);
//                    result[i] := Format('Dane dotyczace kobiet dla %d dnia:' + sLineBreak, [(i + 1)]);
//                    result[i] += Format('Liczba zachorowan: %d.' + sLineBreak, [random_int(1000, 10000)]);
//                    result[i] += Format('Liczba zgonow: %d.', [random_int(20, 200)]);
//                  end;
//
//              exit(result);
//         end;


function gen_array(): TSArr; static;
         var i: smallint;

         begin
              for i := 0 to (length(result) - 1) do
                  begin
                    result[i,0] := i + 1;
                    result[i,1] := random_int(1000, 10000);
                    result[i,2] := random_int(20, 200);
                    result[i,3] := random_int(1000, 10000);
                    result[i,4] := random_int(20, 200);
                  end;

              exit(result);
         end;


function print_array(arr: TSArr): boolean; static;
         var i, j : smallint;

         begin
              for i := 0 to (length(arr) - 1) do
                  begin
                      writeln(format('%0:10s %d.', ['Dzien:', arr[i, 0]]));
                      write(' ':5);
                      write(format('%0:20s %7d', ['Liczba zachorowan mezczyzn:', arr[i, 1]]));
                      write(' ':5);
                      write(format('%20s %7d', ['Liczba zachorowan kobiet:', arr[i, 3]]));
                      writeln();
                      write(' ':5);
                      write(format('%0:20s %11d', ['Liczba zgonow mezczyzn:', arr[i, 2]]));
                      write(' ':5);
                      write(format('%20s %11d', ['Liczba zgonow kobiet:', arr[i, 4]]));
                      writeln();
                  end;

              exit(true);
         end;


function menu(): boolean; static;
         var options: array of string;
           opt: Int32;
           arr: TSArr;

         begin

              setlength(options, 2);
              options[0] := '1. Tabela zachorowan i zgonow.';
              options[1] := '2. Wyjscie.';

              opt := 0;

              while opt <> length(options) do
                    begin
                         Cli.print_menu(options);
                         opt := Cli.take_input_int('Wprowadz numer odpowiadajacy opcji [typu calkowitego].');
                         arr := gen_array();

                         case opt of
                              1: begin
                                 print_array(arr);
                                 randomize;
                              end;

                              else writeLn('Brak wybranej opcji');
                         end;
                    end;

              exit(True);
         end;
end.


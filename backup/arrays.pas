unit Arrays;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Cli;
  type TSArr = array [0..30] of string;
  function random_int(min, max: integer): integer; static;
  function gen_array(female: boolean): TSArr; static;
  function print_array(arr: TSArr): Boolean; static;
  function menu(): boolean; static;

implementation

function random_int(min, max: integer): integer; static;
         begin
              result := round(random * max);

              if ((result < min) or (result > max)) then random_int(min, max);

              exit(result);
         end;

function print_array(arr: TSArr): boolean; static;
         var i : smallint;

         begin
              for i := 0 to (length(arr) - 1) do writeln(arr[i]);

              exit(true);
         end;

function gen_array(female: boolean): TSArr; static;
         var sex: string;
           i: smallint;

         begin
              if female = true then sex := 'kobiet'
              else sex := 'mezczyzn';

              for i := 0 to (length(result) - 1) do
                  result[i] := Format('Dane dotyczace zachorowan i zgonow mezczyzn dla %d dnia: %d.', [(i + 1), random_int(1000, 10000)]);

              exit(result);
         end;

function menu(): boolean; static;
         var options: array of string;
           opt: Int32;

         begin
              randomize;
              setlength(options, 2);
              options[0] := '1. ';
              options[1] := '2. Wyjscie.';

              opt := 0;

              while opt <> length(options) do
                    begin
                         Cli.print_menu(options);
                         opt := Cli.take_input_int('Wprowadz numer odpowiadajacy opcji [typu calkowitego].');

                         case opt of
                              1: print_array(gen_array(false));

                              else writeLn('Brak wybranej opcji');
                         end;
                    end;

              exit(True);
         end;
end.


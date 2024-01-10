unit Floats;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Cli;

  function sum_n_single(): single; static;
  function product_single(): single; static;
  function difference(sum: single): single; static;
  function difference(sum: real): real; static;
  function sum_n_real(): real; static;
  function sum_pair_single(): single; static;
  function sum_correction_single(): single; static;
  function print_results(sum: single): boolean; static;
  function print_results(sum: real): boolean; static;
  function menu(): boolean; static;

implementation

const n = 1000000;
  s = 1.23456789;

// 4.2.1
function sum_n_single(): single; static;
         var suma: single;
           i: integer;

         begin
              suma := 0.0;
              for i := 1 to n do
                  begin
                    suma += s;
                    //writeln(sizeof(suma));
                    //writeln(suma);
                  end;

              exit(suma);
         end;

function product_single(): single; static;
         begin
              result := s * n;
              exit(result);
         end;

function difference(sum: single): single;
         begin
              result := product_single() - sum;
              exit(result);
         end;

function difference(sum: real): real;
         begin
              result := product_single() - sum;
              exit(result);
         end;

// real 4.2.2
function sum_n_real(): real; static;
         var suma: real;
           i: integer;

         begin
              suma := 0.0;
              for i := 1 to n do
                  begin
                    suma += s;
                    //writeln(sizeof(suma));
                    //writeln(suma);
                  end;

              exit(suma);
         end;

// 4.3.1
function sum_pair_single(): single; static;
         var suma, sumai: single;
             i: integer;

         begin
              suma := 0.0;
              sumai := 0.0;

              for i := 1 to n do
                  begin
                       if (i mod 2) <> 0 then sumai += s
                       else suma += s;
                  end;

              suma += sumai;
              exit(suma);
         end;

// 4.3.2
function sum_correction_single(): single; static;
         var suma, sumai, poprawka: single;
             i: integer;

         begin
              suma := 0.0;
              poprawka := 0.0;

              for i := 1 to n do
                  begin
                    sumai := suma + s;
                    poprawka := suma - sumai + s + poprawka;
                    suma := sumai;
                  end;

             suma += poprawka;
             exit(suma);
         end;

function print_results(sum: single): boolean; static;
         begin
              writeln('Suma wynosi: ', sum:0:10);
              writeln('Iloczyn wynosi: ', product_single():0:10);
              writeln('Roznica wynosi: ', difference(sum):0:10);

              exit(true)
         end;

function print_results(sum: real): boolean; static;
         begin
              writeln('Suma wynosi: ', sum:0:10);
              writeln('Iloczyn wynosi: ', product_single():0:10);
              writeln('Roznica wynosi: ', difference(sum):0:10);

              exit(true)
         end;

function menu(): boolean; static;
         var options: array of string;
           res_s: single;
           res_r: real;
           opt: Int32;

         begin
              setlength(options, 5);
              options[0] := '1. Suma single.';
              options[1] := '2. Suma real.';
              options[2] := '3. Algorytm z parami.';
              options[3] := '4. Algorytm z korekcja.';
              options[4] := '5. Wyjscie.';

              opt := 0;

              while opt <> length(options) do
                    begin
                         Cli.print_menu(options);
                         opt := Cli.take_input_int('Wprowadz numer odpowiadajacy opcji [typu calkowitego].');

                         case opt of
                              1: print_results(sum_n_single);

                              2: print_results(sum_n_real);

                              3: print_results(sum_pair_single);

                              4: print_results(sum_correction_single);

                              5: writeln('Wyjscie.');

                              else writeLn('Brak wybranej opcji');
                         end;
                    end;

              exit(True);
         end;

end.


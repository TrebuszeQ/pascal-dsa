unit Floats;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Cli;

  function sum_n_single(): single; static;
  function product(): single; static;
  function sum_n_real(): real; static;
  function sum_pair_single(): single; static;
  function sum_correction_single(): single; static;
  function menu(): boolean; static;

implementation
const n = 1000000;
  s = 1.23456789;

// 4.2.1
function sum_n_single(): single; static;
         var suma: single;
           i: int64;

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

function product(): single; static;
         begin
              exit(s * n);
         end;

function difference(): single;
         begin
              exit(product() - sum_n_single());
         end;

// real 4.2.2
function sum_n_real(): real; static;
         var suma: real;
           i: int64;

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
             i: int64;

         begin
              suma := 0.0;
              sumai := 0.0;

              for i := 1 to n do
                  begin
                       if (i mod 2) <> 0 then sumai += s
                       else suma += s;
                  end;
              writeln(suma, sumai);
              exit(suma+sumai);
         end;

// 4.3.2
function sum_correction_single(): single; static;
         var suma, sumai, poprawka: single;
             i, n: integer;

         begin
              suma := 0.0;
              poprawka := 0.0;

              for i := 1 to n do
                  begin
                    sumai := suma + s;
                    poprawka := suma - sumai + s + poprawka;
                    suma := sumai;
                    suma += poprawka;
                  end;

             exit(suma);
         end;

function menu(): boolean; static;
         var options: array of string;
           res_s: single;
           res_r: real;
           opt: Int32;

         begin
              setlength(options, 7);
              options[0] := '1. Suma single.';
              options[1] := '2. Iloczyn single.';
              options[2] := '3. Roznica single.';
              options[3] := '4. Suma real.';
              options[4] := '5. Suma par single.';
              options[5] := '6. Suma z poprawka.';
              options[6] := '7. Wyjscie.';

              opt := 0;

              while opt <> length(options) do
                    begin
                         Cli.print_menu(options);
                         opt := Cli.take_input_int('Wprowadz numer odpowiadajacy opcji [typu calkowitego].');

                         case opt of
                              1: writeln('Suma typu single wynosi: ', sum_n_single():0:10, '.');

                              2: writeln('Iloczyn typu single wynosi: ', product(), '.');

                              3: begin
                                      writeln('Roznica sumy i iloczynu typu single wynosi: ', difference():0:10, '.');
                                      writeln('Zmienna single z kazdym krokiem n traci czesc precyzji.');
                              end;

                              4: writeln('Suma liczb typu real wynosi: ', sum_n_real():0:10, '.');

                              5: writeln('Suma par typu single wynosi: ', sum_pair_single():0:10, '.');

                              6: writeln('Suma typu single z poprawka wynosi: ', sum_correction_single():0:10, '.');

                              7: writeln('Wyjscie.');

                              else writeLn('Brak wybranej opcji');
                         end;
                    end;

              exit(True);
         end;

end.


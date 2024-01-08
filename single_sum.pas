unit Single_sum;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Cli;
  function sum(): single; static;
  function product(): single; static;
  function menu(): boolean; static;

implementation
const n = 1000000;
  s = 1.23456789;

function sum(): single; static;
         var suma: single;
           i: int64;

         begin
              suma := 0.0;
              for i := 1 to n do
                  begin
                    suma += s;
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
              exit(product() - sum());
         end;

function menu(): boolean; static;
         begin
           writeln('Suma wynosi: ', sum(), '.');
           writeln('Iloczyn wynosi: ', product(), '.');
           writeln('Roznica wynosi: ', difference(), '.');

           writeln('Wydaje mi sie ze roznica polega z faktu, ze .');
           exit(True);
         end;

end.


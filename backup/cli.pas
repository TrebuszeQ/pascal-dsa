unit Cli;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

  function take_input_int(msg: string): Int64; static;
  function print_menu(options: array of string): boolean; static;

implementation
// przyjmuje wartosc Int64
  function DSA2.take_input_int(msg: string): Int64;
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


function print_menu(options: array of string): Boolean;
  var
   i: Int8;

  begin
   writeln();
   for i := 0 to Length(options) - 1 do writeln(options[i]);
   writeln();

   exit(True);
  end;

end.


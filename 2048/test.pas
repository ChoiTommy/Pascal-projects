program test;
uses crt;
var c: Char;
begin
    c := ReadKey;
    if c = #0 then c := ReadKey;
    WriteLn(ord(c));
    ReadLn;
end.
program test;
uses crt, math;
var c : Char;
    i : Integer;
begin
    for i := 0 to 10 do //0-7
    begin
        TextBackground(i);
        Write(' ');
    end;
    WriteLn;
    WriteLn((log10(128) / log10(2)):0:0);
    c := ReadKey;
    if c = #0 then c := ReadKey;
    WriteLn(ord(c));
    ReadLn;
end.
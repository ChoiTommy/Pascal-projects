program anti_anti_virus_software_software;
{$R project.rc}
uses crt;

begin
    Randomize;
    cursoroff;
    repeat
        GotoXY(Random(120) + 1, Random(30) + 1);
        TextBackground(Random(7) + 1);
        Write(' ')
    until False;
end.

{const
    width = 15;
    height = 15;
type pos = set of 1..225;

var x, y, a, m : Integer;
    p : pos;
begin
    cursoroff;
    Randomize;
    a := width*height;
    repeat
        m := Random(a) + 1;
        if m in p then
        begin
            GotoXY((m-1) mod 15 + 1, m div 15 + 1);
            TextBackground(Random(7) + 1);
            Write(' ');
            Exclude(p, m);
            a := a - 1;
        end;
    until a = 0;
    ReadLn
end.}
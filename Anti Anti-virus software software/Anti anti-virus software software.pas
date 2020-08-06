program virus;
{$R project.rc}
uses crt;
const width = 120;
      height = 30;
type grid = array[1..width, 1..height] of Boolean;
var s : grid;
    i, j, n, a : Integer;

procedure init(var g : grid);
var i, j : Integer;
begin
    for j := 1 to height do
        for i := 1 to width do
            g[i][j] := False;
end;

function countEmpty(g : grid): Integer;
var i, j : Integer;
begin
    countEmpty := 0;
    for j := 1 to height do
        for i := 1 to width do
            if g[i][j] = False then
                countEmpty := countEmpty + 1;
end;

begin
    Randomize;
    cursoroff;
    init(s);
    ReadLn;
    repeat
        n := countEmpty(s);
        if n > 0 then
        begin
            a := Random(width*height) + 1;
            for j := 1 to height do
                for i := 1 to width do
                begin
                    if s[i][j] = False then a := a - 1;
                    if a = 0 then
                    begin
                        s[i][j] := True;
                        GotoXY(i, j);
                        TextBackground(Random(6) + 1);
                        Write(' ');
                        //exit;
                    end;
                end;
        end;
    until n = 0;
    ReadLn;
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
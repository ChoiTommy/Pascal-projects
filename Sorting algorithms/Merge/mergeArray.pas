program mergeArray;
const size = 10;
type listType = array[1..size] of integer;

var a, b, c : listType;
    i : integer;

procedure assignValuesAandB;
begin
    a[1] := 2;
    a[2] := 3;
    a[3] := 5;
    a[4] := 7;
    a[5] := 11;
    a[6] := 1000;

    b[1] := 1;
    b[2] := 100;
    b[3] := 200;
    b[4] := 516;
end;

procedure mergeArrays(a, b : listType; var c : listType);
var x, y, z : integer;
begin
    x := 1;
    y := 1;
    z := 1;
    while (x <= 6) and (y <= 4) do
    begin
        if (a[x] < b[y]) then
        begin
            c[z] := a[x];
            x := x + 1;
        end
        else
        begin
            c[z] := b[y];
            y := y + 1;
        end;
        z := z + 1;
    end;
    repeat
        if x > 6 then
        begin
            c[z] := b[y];
            y := y + 1;
        end
        else if y > 4 then
        begin
            c[z] := a[x];
            x := x + 1;
        end;
        z := z + 1;
    until z > 10;
end;

procedure CopyAndAddOne(var a, b, i : integer);
begin
    a := b;
    i := i + 1;
end;

procedure mergeArrays2(a, b : listType; var c : listType);
var x, y, z : integer;
begin
    x := 1;
    y := 1;
    z := 1;
    while (x <= 6) and (y <= 4) do
    begin
        if (a[x] < b[y]) then
            CopyAndAddOne(c[z], a[x], x)
        else
            CopyAndAddOne(c[z], b[y], y);
        z := z + 1;
    end;
    repeat
        if x > 6 then
            CopyAndAddOne(c[z], b[y], y)
        else if y > 4 then
            CopyAndAddOne(c[z], a[x], x);
        z := z + 1;
    until z > 10;
end;


begin
    assignValuesAandB;
    mergeArrays2(a, b, c);
    for i := 1 to size do
        writeln(c[i]);
    Readln;
end.

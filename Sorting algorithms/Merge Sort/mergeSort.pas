program MergeSort;
(*
    procedures:
    1. mergeArrays
    2. MergeSort
*)
const sizeA = 5;
      sizeB = 5;
      sizeC = sizeA + sizeB;
type listType = array[1..sizeC] of Integer;

var c : listType;
    i : Integer;

procedure assignValuesC;
var i : Integer;
begin
    for i := 1 to sizeC do
        c[i] := Random(100);
end;

procedure mergeArrays(var c : listType; front, rear : Integer);
var x, y, z : integer;
    d : listType;
begin
    x := front; //first array pointer
    y := (front + rear) div 2 + 1; //second array pointer
    z := front; // temp array pointer
    while (x <= (front + rear) div 2) and (y <= rear) do
    begin
        if (c[x] < c[y]) then
        begin
            d[z] := c[x];
            x := x + 1;
        end
        else
        begin
            d[z] := c[y];
            y := y + 1;
        end;
        z := z + 1;
    end;
    repeat
        if x > (front + rear) div 2 then
        begin
            d[z] := c[y];
            y := y + 1;
        end
        else if y > rear then
        begin
            d[z] := c[x];
            x := x + 1;
        end;
        z := z + 1;
    until z > rear;

    for i := front to rear do //copy all values in the temp array into the actual array
        c[i] := d[i];
end;

procedure MergeSort(var a : listType; front, rear: integer);
//var i : Integer;
begin
    if front<>rear then //or front < rear
    begin
        MergeSort(a, front, (front + rear) div 2);
        MergeSort(a, (front + rear) div 2 + 1, rear);
        mergeArrays(a, front, rear);
        {writeln(front:4, rear:4);
        for i := 1 to sizeC do
            Write(a[i]:4);
        WriteLn;}
    end;
end;

begin
    Randomize;
    assignValuesC;
    for i := 1 to sizeC do
      write(c[i]:4);
    WriteLn;
    WriteLn('-----------------------------');
    MergeSort(c, 1, sizeC);
    WriteLn('-----------------------------');
    for i := 1 to sizeC do
      writeln(c[i]);
    WriteLn('Hi!');
    Readln;
end.

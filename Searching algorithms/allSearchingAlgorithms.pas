program allSearchingAlgorithms;
(*Binary Search | Linear Search*)
const size = 20;
type arr = array[1..size] of integer;
var list : arr;
    found : boolean;
    data, pos : integer;

procedure insertionSort(var a : arr);
var i : integer;
    position : integer;
    num : integer;
begin
    for i := 2 to size do
    begin
        num := a[i];
        position := i;
        while (position > 1) and (a[position-1] > num) do
        begin
            a[position] := a[position-1];
            position := position - 1;
        end;
        a[position] := num;
    end;
end;



procedure generateValues(var a : arr);
var i : integer;
begin
    for i := 1 to size do
        a[i] := random(1000) + 1;
    insertionSort(a);
    for i := 1 to size do
        writeln('a[', i, '] = ', a[i]);
end;

procedure binarySearch(a : arr; data : integer; var x : boolean; var n : integer);
var first, mid, last : integer;
begin
    first := 1;
    n := -1;
    last := size;
    writeln('first':6, 'mid':6, 'last':6);
    while (not x) and not(last < first) do
    begin
        mid := (first + last) div 2;
        writeln(first:6,mid:6,last:6);
        readln;
        if a[mid] > data then
            last := mid-1       //minus 1 to avoid infinite loops
        else if a[mid] < data then
            first := mid+1
        else
        begin
            x := true;
            n := mid;
        end;
    end;
end;

function binarySearchV2(a : arr; data : integer; first, last : integer): boolean;
var mid : integer;
begin
    mid := (first + last) div 2;
    if (last >= first) then
        if a[mid] = data then
            binarySearchV2 := true
        else if a[mid] > data then
            binarySearchV2 := binarySearchV2(a, data, first, mid - 1)
        else
            binarySearchV2 := binarySearchV2(a, data, mid + 1, last)
    else
        binarySearchV2 := false;
end;

function binarySearchV3(a : arr; data : integer; first, last : integer): boolean;
begin
    if (last >= first) then
        if a[(first + last) div 2] = data then
            binarySearchV3 := true
        else if a[(first + last) div 2] > data then
            binarySearchV3 := binarySearchV3(a, data, first, (first + last) div 2 - 1)
        else
            binarySearchV3 := binarySearchV3(a, data, (first + last) div 2 + 1, last)
    else
        binarySearchV3 := false;
end;

begin
    randomize;
    generateValues(list);
    repeat
        found := false;
        readln(data);
        binarySearch(list, data, found, pos);
        writeln(found, ' at ', pos);
        //writeln(binarySearchV2(list, data, 1, size));
    until false;
end.

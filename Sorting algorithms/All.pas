program All;
{Sorting algorithms include bubble sort, selection sort, insertion sort}

uses sortalg;

const range = 100;//range of the numbers generated

var list : arr;
    method, s : string;
    x, n : integer;

procedure readList(var a : arr; s : string; var n : integer);
var t : text;
    i : integer;
begin
    assign(t, s);
    reset(t);
    i := 0;
    while not eof(t) do
    begin
        i := i + 1;
        readln(t, a[i].num);
        readln(t, a[i].name);
        readln(t, a[i].mark);
    end;
    close(t);
    n := i;
end;


procedure generateList(var a : arr);
var i : integer;
begin
    for i := 1 to size do
    begin
        a[i].num := random(range) + 1;
        a[i].name := chr(random(26)+65)+chr(random(26)+65)+chr(random(26)+65);
        a[i].mark := random*100;
    end;
end;



{procedure printPass(a : arr);
var i : integer;
begin
    for i := 1 to size do
        write(a[i]:5);
    writeln;
end;}

procedure printArray(a : arr; n : integer);
var i : integer;
begin
    for i := 1 to n do
    begin
        write(a[i].num:4, a[i].name:20, a[i].mark:8:2);
        writeln;
    end;
end;

function isSortedNum(a : arr): boolean;
var i : integer;
begin
    isSortedNum := true;
    for i := 1 to n-1 do
        if a[i].num > a[i+1].num then
            isSortedNum := false;
end;

function isSortedMark(a : arr): boolean;
var i : integer;
begin
    isSortedMark := true;
    for i := 1 to n-1 do
        if a[i].mark > a[i+1].mark then
            isSortedMark := false;
end;


function isSortedName(a : arr): boolean;
var i : integer;
begin
    isSortedName := true;
    for i := 1 to n-1 do
        if a[i].name > a[i+1].name then
            isSortedName := false;
end;

{procedure findMin(a : arr; start : integer; var minNum, pos : integer);
var i : integer;
begin
    minNum := a[start];
    pos := start;
    for i := start+1 to size do
        if a[i] < minNum then
        begin
            minNum := a[i];
            pos := i;
        end;

end; }

begin
    randomize;
    method := 'No sorting method is used.';
    s := 'data.txt';
    readList(list, s, n);
    printArray(list, n);
    writeln('--------------------------');
    writeln('Choose a sorting method: ');
    writeln('1. Bubble Sort');
    writeln('2. Selection Sort');
    writeln('3. Insertion Sort');
    readln(x);
    case x of
        1 : bubbleSort(list, method, n);
        2 : selectionSort(list, method, n);
        3 : insertionSortV4(list, method, n);
    end;
    writeln('--------------------------');
    writeln(method);
    printArray(list, n);
    writeln('Sorted = ', isSortedNum(list));
    writeln('Sorted = ', isSortedName(list));
    writeln('Sorted = ', isSortedMark(list));
    readln;
end.

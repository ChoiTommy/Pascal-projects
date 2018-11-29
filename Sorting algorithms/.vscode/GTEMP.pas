program Sorting_Algorithms;
{Sorting algorithms include bubble sort, selection sort}

const size = 10;  //numbers of elements in the array
      range = 100;//range of the numbers generated
type arr = array[1..size] of integer;
var list : arr;

procedure generateNumbers(var a : arr);
var i : integer;
begin
    for i := 1 to size do
        a[i] := random(range) + 1;
end;

procedure swap(var a, b: integer);
var temp : integer;
begin
    temp := b;
    b := a;
    a := temp;
end;

procedure printArray(a : arr);
var i : integer;
begin
    for i := 1 to size do
        writeln(a[i]);
end;

procedure bubbleSort(var list : arr);
(*Bubble sort | pass(i): n-1 | round: n*(n-1)/2*)
var i, j : integer;
begin
    for i := size - 1 downto 1 do        //Alternative: for x := 1 to size - 1 do
        for j := 1 to i do               //                for y := 1 to size - x do
            if list[j+1] < list[j] then  //'<'(ascending) or '>'(desending)????
                swap(list[j],list[j+1]);

end;

procedure selectionSort(var a : arr);
{}
var i, j : integer;
    num, position : integer;
begin
    for j := 1 to size-1 do
    begin
        num := a[j];              //assume the first element is the smallest
        position := j;            //get its position
        for i := j+1 to size do
            if a[i] < num then    //if a smaller value can be found in the array
            begin
                num := a[i];      //replace 'num' with that value  (this variable is only used for comparision)
                position := i;    //also replace the position
            end;
        swap(a[j], a[position]);  //swap the array[1, 2, 3, 4, 5] with the smallest value found array[position]
    end;
end;

procedure insertionSort(var a : arr);
var sortedPosition, pos : integer;
    i, j : integer;
    num : integer;
begin
    for j := 2 to size do
    begin
        sortedPosition := j;
        num := a[j];
        pos := 1;
        for i := 1 to sortedPosition - 1 do
            if a[i] < num then
                pos := i + 1;
        for i := j-1 downto pos do
            a[i+1] := a[i];
        a[pos] := num;
    end;
end;

begin
    randomize;
    generateNumbers(list);
    printArray(list);
    insertionSort(list);
    writeln('--------------------');
    printArray(list);
end.

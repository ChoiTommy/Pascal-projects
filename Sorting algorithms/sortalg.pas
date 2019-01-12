unit sortalg;

interface

const size = 10; //numbers of elements in the array


type stuRec = record
                  num : integer;
                  name : string;
                  mark : real;
              end;

type arr = array[1..size] of stuRec;

procedure bubbleSort(var list : arr; var s : string; n : integer);

procedure selectionSort(var a : arr; var s : string; n : integer);

{procedure insertionSort(var a : arr; var s : string);
procedure insertionSortV2(var a: arr; var s : string);
procedure insertionSortV3(var a : arr; var s : string);}
procedure insertionSortV4(var a : arr; var s : string; n : integer);
{procedure insertionSortV5(var a : arr; var s : string);}

implementation

procedure swap(var a, b: stuRec);
var temp : stuRec;
begin
    temp := b;
    b := a;
    a := temp;
end;

{---------------------------------v--------------------v--------------------------------------------------------------}

procedure bubbleSort(var list : arr; var s : string; n : integer);
(*Bubble sort | pass(i): n-1(can be skipped --> if u can see that there is no swap in a pass, then it is sorted) | round: n*(n-1)/2*)
var i, j : integer;
begin
    s := 'Using bubble sort: ';
    for i := n - 1 downto 1 do                //Alternative: for x := 1 to size - 1 do
    begin
        for j := 1 to i do                       //                for y := 1 to size - x do
            if list[j+1].name < list[j].name then  //'<'(ascending) or '>'(desending)????
                swap(list[j],list[j+1]);
    end;
end;

procedure selectionSort(var a : arr; var s : string; n : integer);
(*OUT OF SYLLBLES*)
var i, j : integer;
    position : integer;
    num : stuRec;
begin
    s := 'Using selection sort: ';
    for j := 1 to n-1 do
    begin
        num := a[j];                  //assume the first element is the smallest
        position := j;                //get its position
        for i := j+1 to n do
            if a[i].name < num.name then    //if a smaller value can be found in the array
            begin
                num := a[i];         //replace 'num' with that value  (this variable is only used for comparision)
                position := i;       //also replace the position
            end;
        swap(a[j], a[position]);        //swap the array[1, 2, 3, 4, 5] with the smallest value found array[position]

    end;
end;


{procedure insertionSort(var a : arr; var s : string);
var sortedPosition, pos : integer;
    i, j : integer;
    num : integer;
begin
    s := 'Using insertion sort(1): ';
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
        //printPass(a);
    end;
end; }

{procedure insertionSortV2(var a: arr; var s : string);
var pos : integer;
    i, j : integer;
    num : integer;
begin
    s := 'Using insertion sort(2): ';
    for j := 2 to size do
    begin
        num := a[j];
        pos := j;
        for i := pos - 1 downto 1 do
            if a[i] > num then
            begin
                pos := i;
                a[i+1] := a[i];
            end;
        a[pos] := num;
        //printPass(a);
    end;
end;  }

{procedure insertionSortV3(var a : arr; var s : string);
var pos : integer;
    i, j : integer;
    num : integer;
begin
    s := 'Using insertion sort(3): ';
    for j := 2 to size do
    begin
        num := a[j];
        pos := j;
        i := pos - 1;
        while (i >= 1) and (num < a[i]) do
        begin
            pos := i;
            a[i+1] := a[i];
            i := i - 1;
        end;
        a[pos] := num;
        //printPass(a);
    end;
end; }

procedure insertionSortV4(var a : arr; var s : string; n : integer);
{V4 and V5 are both ok}
var i : integer;
    position : integer;
    num : stuRec;
begin
    s := 'Using insertion sort(4): ';
    for i := 2 to n do
    begin
        num := a[i];
        position := i;
        while (position > 1) and (a[position-1].name > num.name) do // > means the array will be sorted in ascending order
        begin
            a[position] := a[position-1];
            position := position - 1;
        end;
        a[position] := num;

    end;
end;

{procedure insertionSortV5(var a : arr; var s : string);
pass : n-1(cannot be skipped)
var i : integer;
    num, position : integer;
begin
    s := 'Using insertion sort(5): ';
    for i := 2 to size do
    begin
        num := a[i];
        position := i - 1;
        while (position >= 1) and (a[position] > num) do
        begin
            a[position+1] := a[position];
            position := position - 1;
        end;
        a[position+1] := num;
        //printPass(a);
    end;
end; }

end.

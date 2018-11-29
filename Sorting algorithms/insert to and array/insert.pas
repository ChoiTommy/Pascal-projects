program insertionArray;
{a[1]  a[2]  a[3]  a[4]  a[5]}
{ 2     3     5     7             to be added-->4}
const size = 5;
type arr = array[1..size] of integer;
var list : arr;
    i : integer;
    pos : integer;
    num : integer;
    //found : boolean;


begin

    list[1] := 2;
    list[2] := 3;
    list[3] := 5;
    list[4] := 7;
    num := 8;     //to be inserted
    
    {step 1}
    pos := 1;
    for i := 1 to size-1 do
        if (list[i] < num) then
        begin
            pos := i+1; 
        end;
{   found := false;
    i := 1;
    while not found and (i <= 4) do
        if list[i] < num
            i := i + 1;
        else
            found := true;
    pos := i;
}

    {step 2}
    for i := size-1 downto pos do
        list[i+1] := list[i];
        
    {step 3}
    list[pos] := num;
    
    for i := 1 to size do
        writeln(list[i]);
    Readln;
end.

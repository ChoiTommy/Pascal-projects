program insertV2;
{a[1]  a[2]  a[3]  a[4]  a[5]}
{ 2     3     5     7             to be inserted-->4}
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
    list[5] := 0;     //to be inserted
    
    {step 1 + 2}
    pos := 5;
    num := list[5];
    for i := pos-1 downto 1 do
        if (list[i] > num) then
        begin
            pos := i;
            list[i+1] := list[i];
        end;
            
    {step 3}
    list[pos] := num;
    
    for i := 1 to size do
        writeln(list[i]);
    Readln;
end.

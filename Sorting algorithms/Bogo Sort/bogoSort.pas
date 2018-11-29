program bogoSort;
uses crt;
const size = 4;
type people = record
                id : integer;
                name : string;
                gender : Integer;
             end;
     list = array[0..size] of people;

var someGuys : list;
    i, count : Integer;

procedure setValues(var a : list);
var i : Integer;
begin
    for i := 0 to size do
        with a[i] do
        begin
            id := random(100)+100;
            name := chr(random(26)+65) + chr(random(26)+65) + chr(random(26)+65);
            gender := random(1);
        end;
end;

procedure algorithm(var a : list);
var i, randomnum : integer;
    temp : integer;
begin
    for i := 0 to size do
    begin
        randomnum := random(size+1);
        temp := a[i].id;
        a[i].id := a[randomnum].id;
        a[randomnum].id := temp;
    end;
end;

function Sorted(a : list): Boolean; //in ascending order
var i : integer;
begin
    Sorted := True;
    for i := 0 to size-1 do
        if a[i].id > a[i+1].id then
            Sorted := False;
end;

begin
    Randomize;
    count := 0;
    setValues(someGuys);
    for i := 0 to size do
        WriteLn(someGuys[i].id:8, someGuys[i].name:5, someGuys[i].gender:5);
    readln;
    repeat
        writeln('-------------------------------------------------------------------');
        algorithm(someGuys);
        count := count + 1;
        for i := 0 to size do
        begin
            Writeln(someGuys[i].id:8);
            //WriteLn;
            //Delay(1000);
        end;
    until Sorted(someGuys);
    writeln;
    WriteLn('shuffled ', count, ' times' );
    ReadLn;
end.
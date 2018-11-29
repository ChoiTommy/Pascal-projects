program stackDataStructure;
uses crt;
const size = 10;
type stacktype = record
                    data : array[0..size - 1] of integer;
                    top : integer;                         //top of the stack initialize to -1
                 end;

var stack : stacktype;
    response : string;
    x : integer;

procedure init(var s : stacktype);
var i : Integer;
begin
    s.top := -1;
    for i := 0 to size - 1 do
        s.data[i] := 0;
end;

function isFull(s : stacktype):Boolean;
begin
    isFull := s.top = size - 1;
end;

function isEmpty(s : stacktype):Boolean;
begin
    isEmpty := s.top = -1;
end;

procedure push(var s : stacktype; x : integer); (*store data*)
begin
    if not isFull(s) then
    begin
        s.top := s.top + 1;
        s.data[s.top] := x;
    end;
end;

procedure pop(var s : stacktype; var x : Integer); (*retrieve data*)
begin
    if not isEmpty(s) then
    begin
        x := s.data[s.top];
        s.data[s.top] := 0;
        s.top := s.top - 1;
    end;
end;

procedure printStack(s : stacktype);
var i : Integer;
begin
    writeln('------------------------------------------');
    for i := size - 1 downto 0 do
        writeln(s.data[i]: 10);
    writeln('------------------------------------------');
end;

begin
    writeln('Stack:');
    init(stack);
    repeat
        WriteLn;
        writeln('1.Push data') ;
        writeln('2.Pop data');
        write('> ');
        readln(response);
        if response = '1' then
        begin
            if not isFull(stack) then
            begin
                write('Enter the data to push > ');
                readln(x);
                push(stack, x);
            end
            else
            begin
                TextColor(Red);
                writeln('Stack overflow may occur :)');
                TextColor(lightgray);
            end;
        end
        else if response = '2' then
        begin
            if not isEmpty(stack) then
            begin
                pop(stack, x);
                writeln('Pop data is ', x);
            end
            else
            begin
                TextColor(Red);
                WriteLn('Stack underflow may occur :/');
                TextColor(lightgray);
            end;
        end;
        printStack(stack);
    until upcase(response) = 'EXIT';

end.
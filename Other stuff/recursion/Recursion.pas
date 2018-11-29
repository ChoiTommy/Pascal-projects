program Recursion;

var x : longint;

procedure Try1;
begin
    writeln('Hi');
    Try1;
end;

procedure Try2;
begin
    x := x + 1;
    writeln(x : x);
    if x < 10 then
        Try2;
end;

procedure Try3(x : integer);
begin
    writeln('Hi! ': x+3);
    if x < 10 then
        Try3(x + 1);
    writeln(x);         //<---!!!
end;


function func(x : integer):integer;
var a : integer;
begin
    writeln('Hi', x);
    if x > 0 then
        func := func(x - 1)
    else
        func := 0;
    writeln(x);
end;

function sum(n : integer): integer;
begin
    write('A', n);
    if n > 1 then                    // if n > 0 then                    // if n = 1 then
        sum := n + sum(n-1)          //     sum := n + sum(n-1)          //     sum := 1
    else                             // else                             // else
        sum := 1;                    //     sum := 0;                    //     sum := n + sum(n-1);
    write('B', n);
end;

function sum2(n : integer): integer;
var x : integer;
begin
    write('A', n);
    if n = 1 then
        sum2 := 1
    else
    begin
        x := n + sum(n-1);
        write('C', x);
        sum2 := x;
    end;
    write('B', n);
end;


function factorial(x : longint): longint;
begin
    if x = 0 then
        factorial := 1
    else
        factorial := x * factorial(x - 1);
end;

function fibonacci(n : longint): longint;
begin
    if (n = 1) or (n = 2) then
        fibonacci := 1
    else
        fibonacci := fibonacci(n - 1) + fibonacci(n - 2);
end;

function EulerNumber(n : longint): real;
begin
    if n = 0 then
        EulerNumber := 1
    else
        EulerNumber := 1/factorial(n) + EulerNumber(n-1);
end;


function HCF(a, b : integer): integer;
(*no need to assume a > b*)
begin
    if b = 0 then
        HCF := a
    else
        HCF := HCF(b, a mod b);
end;

function GCD(a, b : Integer): Integer;
var temp : Integer;
begin
    while not(b = 0) do
    begin
        temp := b;
        b := a mod b;
        a := temp;
    end;
    GCD := a;
end;

begin
    //x := 1;
    //Try3(x);
    //writeln('sum2(5) = ', sum2(5): 5);
    //writeln(EulerNumber(12));
    //writeln(fibonacci(15));
    writeln(HCF(462,1071));
    writeln(HCF(1071,462));
    writeln(GCD(462, 1071));
    readln;
end.

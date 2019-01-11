program circularQueue;
uses crt;
const size = 10;

type
    queueType = record
                    count, front, rear : Integer;  //0..size for front and rear
                    data : array[1..size] of Integer;
                end;

var q : queueType;
    response : string;
    x : Integer;

procedure init(var q : queueType);
var i : Integer;
begin
    q.front := 1;   {head}
    q.rear := 0;    {Tale}
    q.count := 0;
    for i := 1 to size do
        q.data[i] := 0;
end;

function isFull(q : queueType):Boolean;
begin
    isFull := q.count = size;
end;

function isEmpty(q : queueType):Boolean;
begin
    isEmpty := q.count = 0;
end;

procedure enqueue(var q : queueType; x : Integer);
begin
    if not isFull(q) then
    begin
        if q.rear = size then  //we may use mod
            q.rear := 1
        else
            q.rear := q.rear + 1;
        q.data[q.rear] := x;
        q.count := q.count + 1;
    end;
end;

procedure dequeue(var q : queueType; var x : Integer);
begin
    if not isEmpty(q) then
    begin
        x := q.data[q.front];
        q.data[q.front] := 0;
        if q.front = size then
            q.front := 1
        else
            q.front := q.front + 1;
        q.count := q.count - 1;
    end;
end;

procedure printQueue(q : queueType);
var i : Integer;
begin
    for i := 1 to size do
        WriteLn('|':4, i, '|   ', q.data[i]:5);
    WriteLn('Front: ', q.front, ' Rear: ', q.rear, ' Count: ', q.count);
end;

begin
    writeln('Queue:');
    init(q);
    repeat
        WriteLn;
        writeln('1.Enqueue data') ;
        writeln('2.Dequeue data');
        write('> ');
        readln(response);
        if response = '1' then
        begin
            if not isFull(q) then
            begin
                write('Enter the data to enqueue > ');
                readln(x);
                enqueue(q, x);
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
            if not isEmpty(q) then
            begin
                dequeue(q, x);
                writeln('Dequeued data is ', x);
            end
            else
            begin
                TextColor(Red);
                WriteLn('Stack underflow may occur :/');
                TextColor(lightgray);
            end;
        end;
        printQueue(q);
    until upcase(response) = 'EXIT';
end.
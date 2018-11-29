program queueDataStructure;
uses crt;
const size = 10;

type
    queueType = record
                    front, rear : Integer;
                    data : array[1..size] of Integer;
                end;

var q : queueType;
    response : string;
    x : Integer;

procedure init(var q : queueType);
var i : Integer;
begin
    q.front := 1;
    q.rear := 0;
    for i := 1 to size do
        q.data[i] := 0;
end;

function isFull(q : queueType):Boolean;
begin
    isFull := q.rear = size;
end;

function isEmpty(q : queueType):Boolean;
begin
    isEmpty := q.front > q.rear; //q.front = q.rear+1
end;

procedure enqueue(var q : queueType; x : Integer);
begin
    if not isFull(q) then
    begin
        q.rear := q.rear + 1;
        q.data[q.rear] := x;
    end;
end;

procedure dequeue(var q : queueType; var x : Integer);
begin
    if not isEmpty(q) then
    begin
        x := q.data[q.front];
        q.data[q.front] := 0;
        q.front := q.front + 1;
    end;
end;

procedure printQueue(q : queueType);
var i : Integer;
begin
    for i := q.front to q.rear do
        WriteLn('|':4, i, '|   ', q.data[i]:5);
    WriteLn('Front: ', q.front, ' Rear: ', q.rear);
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
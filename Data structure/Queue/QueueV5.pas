program QueueV5; //**zero-based*//
uses crt;
const size = 10;

type
    queueType = record
                    front, rear : Integer;
                    data : array[0..size-1] of Integer;
                end;

var q : queueType;
    response : string;
    x : Integer;

function isFull(q : queueType):Boolean;
begin
    isFull := (q.front = (q.rear + 1) mod 10 ) and (q.data[q.front] <> 0); //** */ //q.rear is initialized to 0 so no q.data[0]
end;

function isEmpty(q : queueType):Boolean;
begin
    isEmpty := (q.front = (q.rear + 1) mod 10 ) and (q.data[q.front] = 0); //** */
end;

procedure init(var q : queueType);
var i : Integer;
begin
    q.front := 0;
    q.rear := size - 1; //##?????? buggsssss no pc to debbuuuugggggggggg
    for i := 0 to size-1 do
        q.data[i] := 0;
end;

procedure enqueue(var q : queueType; x : Integer);
begin
    if not isFull(q) then
    begin
        q.rear := (q.rear + 1) mod size; //** */
        q.data[q.rear] := x;
    end;
end;

procedure dequeue(var q : queueType; var x : Integer);
begin
    if not isEmpty(q) then
    begin
        x := q.data[q.front];
        q.data[q.front] := 0;
        q.front := (q.front + 1) mod size; //** */
    end;
end;

procedure printQueue(q : queueType);
var i : Integer;
begin
    for i := 1 to size do
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
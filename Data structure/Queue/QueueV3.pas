program QueueV3;
(*
    procedures:
    1. init
    2. enqueue
    3. dequeue
*)
uses crt;
const size = 10;

type
    queueType = record
                    front, rear : Integer;
                    data : array[1..size] of Integer;
                    isFull, isEmpty : boolean;
                end;

var q : queueType;
    response : string;
    x : Integer;

procedure init(var q : queueType);
var i : Integer;
begin
    q.front := 1;
    q.rear := 0;
    q.isFull := False;
    q.isEmpty := True;
    for i := 1 to size do
        q.data[i] := 0;
end;

procedure enqueue(var q : queueType; x : Integer);
begin
    if not q.isFull then
    begin
        {if (q.rear = size) then
            q.rear := 1
        else
            q.rear := q.rear + 1;}
        q.rear := q.rear mod size + 1; // when rear = 10(size) and u need to enqueue, enqueue location = 1
        q.data[q.rear] := x;
        q.isFull := (q.front = q.rear mod size + 1);
        //if (q.front = q.rear mod 10 + 1) then //(q.front=q.rear+1) or (q.rear = size)
              //q.isFull := true;
        q.isEmpty := False;
    end;
end;

procedure dequeue(var q : queueType; var x : Integer);
begin
    if not q.isEmpty then
    begin
        x := q.data[q.front];
        q.data[q.front] := 0; // clear that space
        {if q.front = size then
            q.front := 1
        else
            q.front := q.front + 1;}
        q.front := q.front mod size + 1;
        q.isEmpty := (q.front = q.rear mod size + 1);
        q.isFull := False;
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
            if not q.isFull then
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
            if not q.isEmpty then
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
program linkedListV2;
const size = 10;
      null = -1;

type
    nodeType = record
                    prev, next : integer;
                    data : string;
               end;
    listType = record
                    list : array[1..size] of nodeType; //**NODE TYPE */
                    head : Integer;
               end;

var l : listType;
    response, input, s : string;

procedure init(var l : listType);
var i : Integer;
begin
    for i := 1 to size do
    begin
        l.list[i].data := '';
        l.list[i].next := Null; //** -1 means end of list */
        l.list[i].prev := null;
    end;
    l.head := Null;
end;

function searchFreeNode(l : listType):Integer;
(*Search for position of free node*)
(*return null for full linked list*)
var i : Integer;
begin
    i := 1;
    while (i <= size) and (l.list[i].data <> '') do //**MUST PUT (i <= size) FIRST because [i] may overflow */
        i := i + 1;
    if i > size then
        searchFreeNode := Null
    else
        searchFreeNode := i;
end;

procedure insertBegin(data : string; var l : listType);
var freepos : Integer;
begin
    freepos := searchFreeNode(l); //**find empty node */
    if freepos = null then
        WriteLn('Error') //**NO FREE POSITION to insert data*/
    else
    begin
        l.list[freepos].data := data;
        l.list[freepos].next := l.head;
        if l.head <> Null then
            l.list[l.head].prev := freepos; {*}
        l.list[freepos].prev := Null;       {*}
        l.head := freepos;

    end;
end;

{function search(x : string; l: listType; p : integer): Integer; //p := l.head
begin
    if (p<>Null) and (l.list[p].data <> data) then
        search := search(l.list[p], l, l.list[p].next)
    else
        search := p;
end;}

function search(data : string; l: listType): Integer;
var p : Integer;
begin
    p := l.head;
    while (p<>Null) and (l.list[p].data <> data) do //**P<>null must be put first */
        p := l.list[p].next; //**advance to next pointer, make use of next */
    search := p;
end;

procedure insertAfter(after, data : string; var l : listType);
var freepos, afterpos : Integer;
begin
    freepos := searchFreeNode(l);
    if freepos = null then
        WriteLn('Error') //**NO FREE POSITION to insert data*/
    else
    begin
        afterpos := search(after, l);
        {set the next of new data to one after}
        l.list[freepos].next := l.list[afterpos].next;

        {store data into free node}
        l.list[freepos].data := data;
        {update next of after to the pos of the new node}
        l.list[afterpos].next := freepos;

        if l.list[freepos].next <> Null then
            l.list[l.list[freepos].next].prev := freepos; {**}
        l.list[freepos].prev := afterpos;                 {**}
    end;
end;

{function searchPrevPos(data : string; l : listType): integer;
var p : Integer;
begin
    p := l.head;
    while (l.list[p].next <> Null) and (l.list[l.list[p].next].data <> data) do //**P<>null must be put first */
        p := l.list[p].next; //**advance to next pointer, make use of next */
    searchPrevPos := p;
end;}

function searchPrevPos (data : string; l : listType): integer;
var p : Integer;
begin
    p := search(data, l);
    if p = Null then
        writeln('not found')
    else
        searchPrevPos := l.list[p].prev;
end;

procedure delete(data : string; var l: listType);
var p : integer;
begin
    p := search(data, l);
    if p = l.head then
    begin
        l.head := l.list[p].next;
        if l.head <> Null then
            l.list[l.head].prev := null; {*}
        l.list[p].data := '';
        l.list[p].next := null;
        l.list[p].prev := Null;          {*}
    end
    else
    begin
        l.list[searchPrevPos(data, l)].next := l.list[p].next;
        if l.list[p].next <> null then
            l.list[l.list[p].next].prev := l.list[p].prev; {*}
        l.list[p].data := '';
        l.list[p].prev := Null;                            {*}
        l.list[p].next := null;
    end;
end;

procedure printListdumb(l : listType);
var i : integer;
begin
    for i := 1 to size do
        writeln(i:3, l.list[i].data:5, l.list[i].next:5, l.list[i].prev:5);
end;

procedure printList(l : listType);
var i : integer;
begin
    i := l.head;
    write('Head: ', i);
    while i <> null do
    begin
        write(' ----> ',  l.list[i].data, '(', l.list[i].next, ')', '(', l.list[i].prev, ')' );
        i := l.list[i].next;
    end;
    writeln;
end;

begin
    init(l);
    repeat
        writeln('1. Insert at the beginning of the linked list.');
        WriteLn('2. Insert to a certain item.');
        WriteLn('3. Delete a node.');
        WriteLn('4. Search for a node.');
        write(' >');
        readln(response);
        if response = '1' then
        begin
            write('pls enter the data: ');;
            readln(input);
            insertBegin(input, l);
        end
        else if response = '2' then
        begin
            write('enter the data to search: ');
            readln(s);
            write('Enter the data to input: ');
            readln(input);
            insertAfter(s, input, l);
        end
        else if response = '3' then
        begin
            write('delete what? >');
            readln(s);
            delete(s, l);
        end
        else if response = '4' then
        begin
            write('Enter the data to search: ');
            readln(s);
            writeln('The data is on the ', search(s, l), ' pos.');
        end;
        writeln('--------------------------------------------------');
        printList(l);
        writeln('--------------------------------------------------');
        printListdumb(l);
        writeln('--------------------------------------------------');
        writeln;
    until upcase(response) = 'EXIT';
end.

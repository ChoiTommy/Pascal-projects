program revision;
type stacktype = record
					data : array[1..10] of string;
                    top : integer;
                 end;
var stack : stacktype;
	mode : string[1];
    i : integer;
    x : string;
procedure initialize(var stack : stacktype);
begin
	for i := 1 to 10 do
    	stack.data[i] := '';
    stack.top := 0;
end;

procedure push(var stack : stacktype; data : string);
begin
	if not (stack.top = 10) then
    begin
    	stack.top := stack.top + 1;
        stack.data[stack.top] := data;
    end;
end;

procedure pop(var stack : stacktype; var x : string);
begin
	if not (stack.top = 0) then
    begin
    	x := stack.data[stack.top];
        stack.data[stack.top] := '';
        stack.top := stack.top - 1;
        writeln(x);
    end
    else writeln;
end;

begin
	repeat
		read(mode);
        if mode = 'i' then
        begin
        	readln(x);
        	i := 1;
        	push(stack, x);
 			while stack.data[i] <> '' do
            begin
            	write(stack.data[i]);
                i := 1 + i;
            end;
			writeln;
        end
        else if mode = 'o' then
        begin
        	readln;
        	pop(stack, x);
        end;
	until mode = 'e';
end.

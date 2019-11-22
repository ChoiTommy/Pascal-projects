program main;
{$H+} //This is the long string switch that you will need
uses crt;
var code, input: string;
    memory: array of longint; // Use dynamic array for memory
    i, memoryPos : longint;

// Pascal dynamic array quick reference:
// SetLength(arr,len);
//     Set the size of array arr to [0..len-1]
// High(arr);
//     Return the upper boundary of the array arr (length - 1 for dynamic arrays)
// Low(arr);
//     Return the lower boundary of the array arr (0 for dynamic arrays)

function find(pos, step : integer):integer;
var layer : integer;
begin
	layer := 0;
    while (pos > 0) and (pos <= length(code)) do
    begin
    	if code[pos] = '[' then
        	layer := layer + step
        else if code[pos] = ']' then
        	layer := layer - step;
        if layer = 0 then
        begin
        	find := pos;
        	exit
        end
        else pos := pos + step
    end
end;

begin
	readln(code);
    i := 1;
    input := '';
    while (code[i] <> '!') and (i < length(code)) do
    	i := i + 1;
    if i < length(code) then
        input := copy(code, i+1, length(code)-i);
    code := copy(code, 1, i);
    setLength(memory, 1024);
    memoryPos := 0;
    for i := 0 to 1023 do
    	memory[i] := 0;
    i := 1;
    while i <= length(code) do
    begin
    	if code[i] = '>' then
        	if memoryPos = 1023 then
            	memoryPos := 0
            else memoryPos := memoryPos + 1
        else if code[i] = '<' then
        	if memoryPos = 0 then
        		memoryPos := 1023
            else memoryPos := memoryPos - 1
        else if code[i] = '+' then
        	memory[memoryPos] := memory[memoryPos] + 1
        else if code[i] = '-' then
        	memory[memoryPos] := memory[memoryPos] - 1
        else if code[i] = '.' then
            write(chr(memory[memoryPos]))
        else if (code[i] = ',') and (input <> '') then
        begin
        	memory[memoryPos] := ord(input[1]);
            input := copy(input, 2, length(input)-1)
        end
        else if (code[i] = '[') and (memory[memoryPos] = 0) then
            i := find(i, 1)
        else if (code[i] = ']') and (memory[memoryPos] <> 0) then
            i := find(i, -1);
        i := i + 1;
   end;
   ClrScr;
   readln;
end.
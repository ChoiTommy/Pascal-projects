program main;
{$H+} //This is the long string switch that you will need
var code, input: string;
    memory: array of longint; // Use dynamic array for memory
    i, memoryPos, j : longint;

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
        else pos := pos + step;
    end
end;

begin
	readln(code);
    {Read input}
    i := 1;
    input := '';
    while (code[i] <> '!') and (i < length(code)) do
    	i := i + 1;
    if i < length(code) then
      input := copy(code, i+1, length(code)-i);
    code := copy(code, 1, i);

    {Initialization}
    setLength(memory, 1);
    memoryPos := 0;
    for i := 0 to 0 do
    	memory[i] := 0;
    i := 1;

    while i <= length(code) do
    begin
    	if code[i] = '>' then
        begin
        	if memoryPos = length(memory)-1 then
            begin
        		setLength(memory, length(memory)+1);
                memory[length(memory)-1] := 0;
            end;
            memoryPos := memoryPos + 1
        end
        else if (code[i] = '<')  then
        	if memoryPos = 0 then
            begin
        		setLength(memory, length(memory)+1);
                for j := length(memory)-1 to 1 do
                	memory[j] := memory[j-1];
                memory[0] := 0;
            end
            else memoryPos := memoryPos - 1
        else if code[i] = '+' then
        	memory[memoryPos] := memory[memoryPos] + 1
        else if (code[i] = '-') and (memory[memoryPos] > 0) then
        	memory[memoryPos] := memory[memoryPos] - 1
        else if code[i] = '.' then
        	write(chr(memory[memoryPos]))
        else if code[i] = ',' then
        	if input <> '' then
            begin
        		memory[memoryPos] := ord(input[1]);
            	input := copy(input, 2, length(input)-1);
            end
            else memory[memoryPos] := 0
        else if (code[i] = '[') and (memory[memoryPos] = 0) then
            	i := find(i, 1)-1
        else if (code[i] = ']') and (memory[memoryPos] <> 0) then
            	i := find(i, -1)-1;
        i := i + 1;
        //writeln('Current i: ', i);readln;
   end
end.
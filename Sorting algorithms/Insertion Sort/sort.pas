program sort;
var a : array[1..10] of integer;
	i, min, pos : integer;
begin
	for i := 1 to 10 do
    	read(a[i]);
    readln;
    for i := 2 to 10 do
    begin
    	min := a[i];
        pos := i;
        while (pos > 1) and (a[pos-1] > min) do
        begin
        	a[pos] := a[pos-1];
            pos := pos - 1;
        end;
        a[pos] := min;
    end;
    for i := 1 to 10 do
    	write(a[i], ' ');
    readln;
end.
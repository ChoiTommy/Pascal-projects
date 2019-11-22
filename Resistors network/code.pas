program code;
{$H+}
var equation : string;
(*  Still bugged:
    (1-(1-2|3-(23|1)|23)|(23-12|23)|23)|45-1
    1|(1|(1-2|3-(5|2-4)))

 *)
function find(eq : string;pos : integer):integer;
var layer : integer;
begin
	layer := 0;
    find := -1;
    while pos <= length(eq) do
    begin
      if eq[pos] = '(' then
          layer := layer + 1
      else if eq[pos] = ')' then
          layer := layer - 1;
      if layer = 0 then
      begin
      	find := pos;
        exit
      end
      else pos := pos + 1
    end
end;

procedure cheat(character : char; var eq : string);
var a, b, c, err : integer;
	tmp1, tmp2 : string;
    m, n : real;
begin
	a := pos(character, eq);
    write('a = ', a);readln;
    while a <> 0 do
    begin
    	tmp1 := '';
    	tmp2 := '';
    	b := a - 1;
        c := a + 1;
        while (b > 0) and ((eq[b] in ['0'..'9']) or (eq[b] = 'E') or (eq[b] = '.') or (eq[b] = '+')) do
        begin
        	tmp1 := eq[b] + tmp1;
            b := b - 1
        end;
        while (c <= length(eq)) and ((eq[c] in ['0'..'9']) or (eq[c] = 'E') or (eq[c] = '.') or (eq[c] = '+')) do
        begin
        	tmp2 := tmp2 + eq[c];
            c := c + 1
        end;
        write('tmp1 = ', tmp1);readln;
        write('tmp2 = ', tmp2);readln;
        val(tmp1, m, err);
        val(tmp2, n, err);
        if character = '|' then
        	str(1/(1/m+1/n):0:10, tmp1)
        else str(m+n:0:10, tmp1);
        if tmp1[1] = ' ' then
            tmp1 := copy(tmp1, 2, length(tmp1)-1);
        if tmp2[1] = ' ' then
            tmp2 := copy(tmp2, 2, length(tmp2)-1);
        write('tmp1 = ', tmp1);readln;
        eq := copy(eq, 1, b) + tmp1 + copy(eq, c, length(eq)-c+1);
        write('eq = ', eq);readln;
        a := pos(character, eq);
        write('a = ', a);readln;
    end
end;

function calculateResistance(eq : string):real;
var a, b, err : integer;
	tmp1 : string;
begin
	calculateResistance := -1;
	a := pos('(', eq);
    if a <> 0 then
    begin
    	b := find(eq, a);
        str(calculateResistance(copy(eq, a+1, b-a-1)), tmp1);
        if tmp1[1] = ' ' then
            tmp1 := copy(tmp1, 2, length(tmp1)-1);
        eq := copy(eq, 1, a-1) + tmp1 + copy(eq, b+1, length(eq)-b)
    end;
    write(eq);readln;
    cheat('|', eq);
    cheat('-', eq);
    val(eq, calculateResistance, err)
end;

begin
	readln(equation);
    write(calculateResistance(equation));
    readln
end.
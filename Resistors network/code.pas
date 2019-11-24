program code;
{$H+}
var equation : string;
const list = ['0'..'9', 'E', 'e', '+', '.'];

procedure removeZerosAndSpace(var s: string);
var i : integer;
begin
    i := Length(s);
    while (i > 0) and (s[i] = '0') do
        i := i - 1;
    s := copy(s, 1, i);
    if s[1] = ' ' then
        s := copy(s, 2, length(s)-1);
    if s[Length(s)]='.' then
        s := copy(s, 1, length(s)-1);
end;

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
        while (b > 0) and (eq[b] in list) do
        begin
        	tmp1 := eq[b] + tmp1;
            b := b - 1
        end;
        while (c <= length(eq)) and (eq[c] in list) do
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
        removeZerosAndSpace(tmp1);
        removeZerosAndSpace(tmp2);
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
    while a <> 0 do
    begin
    	b := find(eq, a);
        str(calculateResistance(copy(eq, a+1, b-a-1)):0:10, tmp1);
        removeZerosAndSpace(tmp1);
        eq := copy(eq, 1, a-1) + tmp1 + copy(eq, b+1, length(eq)-b);
        a := pos('(', eq)
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
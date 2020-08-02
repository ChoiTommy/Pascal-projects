program main;
uses crt;
const size = 4; //4*4
type grid = array[0..size - 1, 0..size - 1] of Integer;// [column, row]
var squares : grid; // i: column- j: row|
    c : char;

procedure initializeGrid(var g : grid);
var i, j, pos1, pos2, value : Integer;
begin
    // set all to zero
    for j := 0 to size - 1 do
        for i := 0 to size - 1 do
            g[i][j] := 0;

    // randomize any 2 squares in the grid to 2 or 4
    pos1 := Random(size * size); // random(16) -> 0..15
    value := (Random(2) + 1) * 2; // 0..1 + 1 -> 1..2 * 2 -> 2 or 4
    g[pos1 mod 4][pos1 div 4] := value;

    repeat
        pos2 := Random(size * size); // random(16) -> 0..15
    until pos2 <> pos1;
    value := (Random(2) + 1) * 2; // 0..1 + 1 -> 1..2 * 2 -> 2 or 4
    g[pos2 mod 4][pos2 div 4] := value;
end;

procedure presetValues(var g : grid);
begin
    g[0][0] := 2;
    g[1][0] := 0;
    g[2][0] := 0;
    g[3][0] := 0;

    g[0][1] := 2;
    g[1][1] := 0;
    g[2][1] := 0;
    g[3][1] := 0;

    g[0][2] := 0;
    g[1][2] := 0;
    g[2][2] := 0;
    g[3][2] := 0;

    g[0][3] := 0;
    g[1][3] := 0;
    g[2][3] := 8;
    g[3][3] := 8;
end;

// loop through all squares to count the number of zeros
function countEmpty(g : grid): Integer;
var i, j : Integer;
begin
    countEmpty := 0;
    for j := 0 to size - 1 do
        for i := 0 to size - 1 do
            if g[i][j] = 0 then
                countEmpty := countEmpty + 1;
end;

procedure swap(var i, j : Integer);
var temp : Integer;
begin
    temp := i;
    i := j;
    j := temp;
end;

procedure spawnNewNumbers(var g : grid);
var value, empty, randNo, i, j : Integer;
begin
    value := (Random(2) + 1) * 2; // 0..1 + 1 -> 1..2 * 2 -> 2 or 4
    empty := countEmpty(g);
    randNo := Random(empty) + 1;
    for j := 0 to size - 1 do
        for i := 0 to size - 1 do
        begin
            if g[i][j] = 0 then randNo := randNo - 1;
            if randNo = 0 then
            begin
                g[i][j] := value;
                exit;
            end;
        end;
end;

//
procedure mergeRight(var g : grid);
var j, temp, pos, m, n: Integer;
    moved : Boolean;
begin
    moved := False;
    for j := 0 to size - 1 do
    begin
        // move zeros to the left first
        for m := size - 1 downto 1 do
            for n := 0 to m - 1 do
                if (g[n+1][j] = 0) then
                begin
                    swap(g[n+1][j], g[n][j]);
                    moved := True;
                end;

        pos := size - 1; // 3
        temp := g[pos][j];
        pos := pos - 1;
        while (pos >= 0) do
        begin
            if g[pos][j] = temp then
            begin
                g[pos + 1][j] := temp * 2;
                g[pos][j] := 0;
                moved := True;
            end;
            temp := g[pos][j];
            pos := pos - 1;
        end;

        // move zeros to the left
        for m := size - 1 downto 1 do
            for n := 0 to m - 1 do
                if (g[n+1][j] = 0) then
                begin
                    swap(g[n+1][j], g[n][j]);
                    moved := True;
                end;
    end;
    if moved then spawnNewNumbers(g);
end;

procedure mergeLeft(var g : grid);
var j, temp, pos, m, n: Integer;
    moved : Boolean;
begin
    moved := False;
    for j := 0 to size - 1 do
    begin
        // move zeros to the right first
        for m := 1 to size - 1 do
            for n := size - 1 downto m do
                if (g[n-1][j] = 0) then
                begin
                    swap(g[n-1][j], g[n][j]);
                    moved := True;
                end;

        pos := 0;
        temp := g[pos][j];
        pos := pos + 1;
        while (pos < size) do
        begin
            if g[pos][j] = temp then
            begin
                g[pos - 1][j] := temp * 2;
                g[pos][j] := 0;
                moved := True;
            end;
            temp := g[pos][j];
            pos := pos + 1;
        end;

        // move zeros to the right
        for m := 1 to size - 1 do
            for n := size - 1 downto m do
                if (g[n-1][j] = 0) then
                begin
                    swap(g[n-1][j], g[n][j]);
                    moved := True;
                end;
    end;
    if moved then spawnNewNumbers(g);
end;

procedure mergeUp(var g : grid);
var i, temp, pos, m, n: Integer;
    moved : Boolean;
begin
    moved := False;
    for i := 0 to size - 1 do
    begin
        // move zeros sown first
        for m := 1 to size - 1 do
            for n := size - 1 downto m do
                if (g[i][n-1] = 0) then
                begin
                    swap(g[i][n-1], g[i][n]);
                    moved := True;
                end;

        pos := 0;
        temp := g[i][pos];
        pos := pos + 1;
        while (pos < size) do
        begin
            if g[i][pos] = temp then
            begin
                g[i][pos-1] := temp * 2;
                g[i][pos] := 0;
                moved := True;
            end;
            temp := g[i][pos];
            pos := pos + 1;
        end;

        // move zeros down
        for m := 1 to size - 1 do
            for n := size - 1 downto m do
                if (g[i][n-1] = 0) then
                begin
                    swap(g[i][n-1], g[i][n]);
                    moved := True;
                end;
    end;
    if moved then spawnNewNumbers(g);
end;

procedure mergeDown(var g : grid);
var i, temp, pos, m, n: Integer;
    moved : Boolean;
begin
    moved := False;
    for i := 0 to size - 1 do
    begin
        // move zeros up first
        for m := size - 1 downto 1 do
            for n := 0 to m - 1 do
                if (g[i][n+1] = 0) then
                begin
                    swap(g[i][n+1], g[i][n]);
                    moved := True;
                end;

        pos := size - 1; // 3
        temp := g[i][pos];
        pos := pos - 1;
        while (pos >= 0) do
        begin
            if g[i][pos] = temp then
            begin
                g[i][pos+1] := temp * 2;
                g[i][pos] := 0;
                moved := True;
            end;
            temp := g[i][pos];
            pos := pos - 1;
        end;

        // move zeros up
        for m := size - 1 downto 1 do
            for n := 0 to m - 1 do
                if (g[i][n+1] = 0) then
                begin
                    swap(g[i][n+1], g[i][n]);
                    moved := True;
                end;
    end;
    if moved then spawnNewNumbers(g);
end;

procedure printGrid(g : grid);
var i, j : Integer;
begin
    for j := 0 to size - 1 do
    begin
        for i := 0 to size - 1 do
            Write(squares[i][j]:15);
        WriteLn;
    end;
end;

begin
    Randomize;
    initializeGrid(squares);
    printGrid(squares);
    repeat
        c := ReadKey;
        if c = #0 then c:= ReadKey;
        case c of
            #72: mergeUp(squares); //up key
            #80: mergeDown(squares); //down key
            #75: mergeLeft(squares); //left key
            #77: mergeRight(squares); //right key
        end;
        ClrScr;
        printGrid(squares);
    until c = #27;
    ReadLn
end.
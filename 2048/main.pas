program main;
uses crt, math;
const size = 4;
type grid = array[0..size - 1, 0..size - 1] of Integer;// [column, row]
var squares : grid; // i: column- j: row|
    c : char;

// randomly generates two numbers (2/4) on random locations
procedure initializeGrid(var g : grid);
var i, j, pos1, pos2, value : Integer;
begin
    // set all to zero
    for j := 0 to size - 1 do
        for i := 0 to size - 1 do
            g[i][j] := 0;

    // generate the first number and its position
    pos1 := Random(size * size); // random(16) -> 0..15
    value := (Random(2) + 1) * 2; // 0..1 + 1 -> 1..2 * 2 -> 2 or 4
    g[pos1 mod size][pos1 div size] := value;

    // generate the second number and its position
    repeat
        pos2 := Random(size * size); // random(16) -> 0..15
    until pos2 <> pos1; // make sure it is a new location
    value := (Random(2) + 1) * 2; // 0..1 + 1 -> 1..2 * 2 -> 2 or 4
    g[pos2 mod size][pos2 div size] := value;
end;

// for testing
procedure presetValues(var g : grid);
begin
    g[0][0] := 0;
    g[1][0] := 0;
    g[2][0] := 0;
    g[3][0] := 0;

    g[0][1] := 0;
    g[1][1] := 0;
    g[2][1] := 0;
    g[3][1] := 0;

    g[0][2] := 0;
    g[1][2] := 0;
    g[2][2] := 0;
    g[3][2] := 0;

    g[0][3] := 0;
    g[1][3] := 0;
    g[2][3] := 0;
    g[3][3] := 0;
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

    // only generate new number when the grid is not full
    if empty > 0 then
    begin
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
end;

// TODO combine the following 4 procedures into 1 procedure
// move and merge numbers to the right
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
                if (g[n+1][j] = 0) and (g[n][j] <> 0) then
                begin
                    swap(g[n+1][j], g[n][j]);
                    moved := True;
                end;

        // perform calculations
        pos := size - 1; // 3
        temp := g[pos][j];
        pos := pos - 1;
        while pos >= 0 do
        begin
            if (g[pos][j] = temp) and (temp > 0) then
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
                if (g[n+1][j] = 0) and (g[n][j] <> 0) then
                begin
                    swap(g[n+1][j], g[n][j]);
                    moved := True;
                end;
    end;
    // only generate new numbers if numbers have been moved
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
                if (g[n-1][j] = 0) and (g[n][j] <> 0) then
                begin
                    swap(g[n-1][j], g[n][j]);
                    moved := True;
                end;

        pos := 0;
        temp := g[pos][j];
        pos := pos + 1;
        while pos < size do
        begin
            if (g[pos][j] = temp) and (temp > 0) then
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
                if (g[n-1][j] = 0) and (g[n][j] <> 0) then
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
        // move zeros down first
        for m := 1 to size - 1 do
            for n := size - 1 downto m do
                if (g[i][n-1] = 0) and (g[i][n] <> 0) then
                begin
                    swap(g[i][n-1], g[i][n]);
                    moved := True;
                end;

        pos := 0;
        temp := g[i][pos];
        pos := pos + 1;
        while pos < size do
        begin
            if (g[i][pos] = temp) and (temp > 0) then
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
                if (g[i][n-1] = 0) and (g[i][n] <> 0) then
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
                if (g[i][n+1] = 0) and (g[i][n] <> 0) then
                begin
                    swap(g[i][n+1], g[i][n]);
                    moved := True;
                end;

        pos := size - 1; // 3
        temp := g[i][pos];
        pos := pos - 1;
        while pos >= 0 do
        begin
            if (g[i][pos] = temp) and (temp > 0) then
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
                if (g[i][n+1] = 0) and (g[i][n] <> 0) then
                begin
                    swap(g[i][n+1], g[i][n]);
                    moved := True;
                end;
    end;
    if moved then spawnNewNumbers(g);
end;

// TODO change colors
procedure printGrid(g : grid);
var i, j: Integer;
begin
    for j := 0 to size - 1 do
    begin
        for i := 0 to size - 1 do
        begin
            if g[i][j] = 0 then TextBackground(0)
            else if g[i][j] >= 64 then TextBackground(6)
            else TextBackground(round(log10(g[i][j]) / log10(2)));
            Write(squares[i][j]:7);
        end;
        WriteLn;
    end;
    TextBackground(0);
end;

begin
    Randomize;
    cursoroff;
    initializeGrid(squares);
    //presetValues(squares);
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
    until c = #27
end.
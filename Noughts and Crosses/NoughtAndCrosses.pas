program NoughtAndCrosses;
uses crt;
const WindowWidth = 120;       //window size
      WindowHeight = 30;
      StartButtonCoordinate_x = 6;        //PVE button coordinates
      StartButtonCoordinate_y = 10;
      InstructionText = 'Use arrow keys and enter key to control everything XD Have Fun^^';
      InstructionText_x =30;
      InstructionText_y =10;
      ExitScreenCoordinate_x = 40;
      ExitScreenCoordinate_y = 10;

var mode : integer;  {startscreen or pve or history or exit}
      
procedure ButtonPlayerVSComputer(s : string);   {VS Computer Button in start screen}
begin
    if s = 'default' then
    begin
        textbackground(black);
        textcolor(lightgray);
    end
    else if s = 'selected' then
    begin
        textbackground(lightgray);
        textcolor(black);
    end;
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y);
    write('+-------------+');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 1);
    write('|             |');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 2);
    write('| VS Computer |');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 3);
    write('|             |');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 4);
    write('+-------------+');
end;

procedure ButtonHistory(s : string);                   {History Button in start screen}
begin
    if s = 'default' then
    begin
        textbackground(black);
        textcolor(lightgray);
    end
    else if s = 'selected' then
    begin
        textbackground(lightgray);
        textcolor(black);
    end;
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 7);
    write('+-------------+');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 8);
    write('|             |');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 9);
    write('|   History   |');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 10);
    write('|             |');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 11);
    write('+-------------+');
end;

procedure ButtonExit(s : string);                  {Exit Button in start screen}
begin
    if s = 'default' then
    begin
        textbackground(black);
        textcolor(lightgray);
    end
    else if s = 'selected' then
    begin
        textbackground(lightgray);
        textcolor(black);
    end;
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 14);
    write('+-------------+');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 15);
    write('|             |');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 16);
    write('|    Exit     |');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 17);
    write('|             |');
    gotoxy(StartButtonCoordinate_x,StartButtonCoordinate_y + 18);
    write('+-------------+');
end;

procedure StartingScreen(var mode : integer);       {Start Screen}
var s : string;
    GameNameFile : text;
    c : char;
    Selected_y : integer;
begin
    textbackground(black);
    textcolor(lightgray);
    clrscr;
    assign(GameNameFile, 'NoughtAndCrosses.txt');
    reset(GameNameFile);
    while not eof(GameNameFile) do
    begin
        while not eoln(GameNameFile) do
        begin
            read(GameNameFile, s);
            writeln(s);
        end;
        readln(GameNameFile);
    end;
    close(GameNameFile);
    Selected_y := 1;
    gotoxy(InstructionText_x, InstructionText_y);;
    write(InstructionText);
    ButtonPlayerVSComputer('default');
    ButtonHistory('default');
    ButtonExit('default');
    case Selected_y of
        1 : ButtonPlayerVSComputer('selected');
        2 : ButtonHistory('selected');
        3 : ButtonExit('selected');
    end;
    repeat
        c := readkey;
        if c = #0 then
        begin
            case Selected_y of
                1 : ButtonPlayerVSComputer('default');
                2 : ButtonHistory('default');
                3 : ButtonExit('default');
            end;
            c := readkey;
            case c of
                #72 : if Selected_y > 1 then Selected_y := Selected_y - 1 else if Selected_y = 1 then Selected_y := 3;//scroll up
                #80 : if Selected_y < 3 then Selected_y := Selected_y + 1 else if Selected_y = 3 then Selected_y := 1;//scroll down
            end;
            case Selected_y of
                1 : ButtonPlayerVSComputer('selected');
                2 : ButtonHistory('selected');
                3 : ButtonExit('selected');
            end;
        end;
    until c = #13;
    mode := Selected_y;
end;

procedure DrawSquares;  {the 3*3 grid}
var s : string;
    Squares : text;
begin
    assign(Squares, 'Squares.txt');
    reset(Squares);
    gotoxy(1,1);
    while not eof(Squares) do
        while not eoln(Squares) do
        begin
            readln(Squares, s);
            writeln(s);
        end;
    close(Squares);
end;

procedure DrawCircleOrCross(s : string; x, y : integer ; CircleOrCross : integer);
var f : text;
    t, st : string;
    n : integer;
begin
    if s = 'selected' then
    begin
        textbackground(lightgray);
        textcolor(black);
    end
    else if s = 'cleared' then
    begin
        textcolor(black);
        textbackground(black);
    end
    else if s = 'not valid' then
    begin
        textbackground(red);
        textcolor(black);
    end
    else if s = 'default' then
    begin
        textbackground(black);
        textcolor(lightgray);
    end;
    case CircleOrCross of
        1 : st := 'Circle';
        2 : st := 'Cross';
    end;
    assign(f, concat(st, '.txt'));
    reset(f);
    n := 0;
    while not eof(f) do
        while not eoln(f) do
        begin
            readln(f, t);
            gotoxy(x, y + n);
            write(t);
            n := n + 1;
        end;
    close(f);
end;

procedure ButtonYesGameScreen(s : String);
begin
    gotoxy(65, 20);
    if s = 'default' then
    begin
        textcolor(lightgray);
        textbackground(black);
    end
    else if s = 'selected' then
    begin
        textcolor(black);
        textbackground(lightgray);
    end;
    write(' Yes ');
end;

procedure ButtonNoGameScreen(s : String);
begin
    gotoxy(75, 20);
    if s = 'default' then
    begin
        textcolor(lightgray);
        textbackground(black);
    end
    else if s = 'selected' then
    begin
        textcolor(black);
        textbackground(lightgray);
    end;
    write(' No ');
end;

procedure GameScreen(var mode : integer);
var name, s : string;
    NameExist, playerwin, cpwin, done, yes : boolean;    // yes means want to play again  //done means cp has decided where he should place at
    Playerfile, PlayerNameFile : text;
    total, win, lose, draw : integer;
    my_x, my_y : integer;       //the coordinates xy of the cursor
    WinRate : real;
    grid : array[1..3, 1..3] of integer;
    number1, number2 : integer;           //coordinates of cp
    firstturn, switch, turn, player, cp : integer;
    c : char;
    i, j : integer;
begin
    textbackground(black);
    textcolor(lightgray);
    clrscr;
    NameExist := false;
    repeat
        write('Enter your name : ');
        readln(name);
    until (name <> '') and (name[1] <> ' ') and (name[length(name)] <> ' ');
    assign(PlayerNameFile, 'PlayerNameFile.txt');
    reset(PlayerNameFile);                  //ready for the player name file to be read and find if the name is exist or not
    while not eof(PlayerNameFile) and Not NameExist do
    begin
        while not eoln(PlayerNameFile) and Not NameExist do
        begin
            read(PlayerNameFile, s);
            if lowercase(s) = lowercase(name) then
                NameExist := true;          //name exists!!
        end;
        readln(PlayerNameFile);
    end;
    if not NameExist then //the player name is new
    begin
        writeln('Creating player file...');
        assign(Playerfile, concat(name, '.txt'));
        rewrite(Playerfile);            //make a new file for the new player
        append(PlayerNameFile);
        writeln(PlayerNameFile, name);     //add the new player name into the file
        writeln('Finished');
        total := 0;                        //initialize his data
        win := 0;
        lose := 0;
        draw := 0;
        WinRate :=0;
    end
    else if NameExist then        //not a new player (it exists!!!)
    begin
        writeln('Player file found.');
        assign(Playerfile, concat(name, '.txt'));           //find his file
        reset(Playerfile);
        readln(Playerfile, total);                    //read his data
        readln(Playerfile, win);
        readln(Playerfile, lose);
        readln(Playerfile, draw);
        readln(Playerfile, WinRate);
    end;
    close(PlayerNameFile);
    delay(1000);
    repeat
    textbackground(black);
    textcolor(lightgray);
    clrscr;
    for i := 1 to 3 do                 //initialization
        for j := 1 to 3 do
            grid[i][j] := 0;
    DrawSquares;                //draw the grid
    gotoxy(65, 2);
    write('Instruction : move with arrow keys then press enter.');
    switch := 1;
    turn := 1;
    my_x := 1;
    my_y := 1;
    playerwin := false;
    cpwin := false;
    firstturn := random(2);        //who play first
    case firstturn of
        0 : begin cp := 1; player := 2; gotoxy(65, 4); write('Computer moves first.'); end;
        1 : begin player := 1; cp := 2; gotoxy(65, 4); write('You move first.'); end;
    end;
    switch := turn + firstturn;
    repeat
    case odd(switch) of       //to determine whos turn
        true : begin
                        done := false;
                        delay(400);
                        for j := 1 to 2 do                  //computer will find the location to put in order to win and then block the player
                            begin
                            for i := 1 to 3 do
                                if (grid[i][1] = grid[i][2]) and (grid[i][1] = j) and (grid[i][3] = 0) and (done = false) then
                                begin
                                    DrawCircleOrCross('default', (i-1)*19 + 1, (3-1)*9 + 1, cp);
                                    grid[i][3] := 1;
                                    done := true;
                                end
                                else if (grid[i][1] = grid[i][3]) and (grid[i][1] = j) and (grid[i][2] = 0) and (done = false) then
                                begin
                                    DrawCircleOrCross('default', (i-1)*19 + 1, (2-1)*9 + 1, cp);
                                    grid[i][2] := 1;
                                    done := true;
                                end
                                else if (grid[i][2] = grid[i][3]) and (grid[i][2] = j) and (grid[i][1] = 0) and (done = false) then
                                begin
                                    DrawCircleOrCross('default', (i-1)*19 + 1, (1-1)*9 + 1, cp);
                                    grid[i][1] := 1;
                                    done := true;
                                end
                                else if (grid[1][i] = grid[2][i]) and (grid[1][i] = j) and (grid[3][i] = 0) and (done = false) then
                                begin
                                    DrawCircleOrCross('default', (3-1)*19 + 1, (i-1)*9 + 1, cp);
                                    grid[3][i] := 1;
                                    done := true;
                                end
                                else if (grid[1][i] = grid[3][i]) and (grid[1][i] = j) and (grid[2][i] = 0) and (done = false) then
                                begin
                                    DrawCircleOrCross('default', (2-1)*19 + 1, (i-1)*9 + 1, cp);
                                    grid[2][i] := 1;
                                    done := true;
                                end
                                else if (grid[3][i] = grid[2][i]) and (grid[2][i] = j) and (grid[1][i] = 0) and (done = false) then
                                begin
                                    DrawCircleOrCross('default', (1-1)*19 + 1, (i-1)*9 + 1, cp);
                                    grid[1][i] := 1;
                                    done := true;
                                end;
                            if (grid[1][1] = grid[2][2]) and (grid[2][2] = j) and (grid[3][3] = 0) and (done = false) then
                            begin
                                DrawCircleOrCross('default', (3-1)*19 + 1, (3-1)*9 + 1, cp);
                                grid[3][3] := 1;
                                done := true;
                            end
                            else if (grid[1][1] = grid[3][3]) and (grid[1][1] = j) and (grid[2][2] = 0) and (done = false) then
                            begin
                                DrawCircleOrCross('default', (2-1)*19 + 1, (2-1)*9 + 1, cp);
                                grid[2][2] := 1;
                                done := true;
                            end
                            else if (grid[2][2] = grid[3][3]) and (grid[2][2] = j) and (grid[1][1] = 0) and (done = false) then
                            begin
                                DrawCircleOrCross('default', (1-1)*19 + 1, (1-1)*9 + 1, cp);
                                grid[1][1] := 1;
                                done := true;
                            end
                            else if (grid[3][1] = grid[2][2]) and (grid[2][2] = j) and (grid[1][3] = 0) and (done = false) then
                            begin
                                DrawCircleOrCross('default', (1-1)*19 + 1, (3-1)*9 + 1, cp);
                                grid[1][3] := 1;
                                done := true;
                            end
                            else if (grid[3][1] = grid[1][3]) and (grid[3][1] = j) and (grid[2][2] = 0) and (done = false) then
                            begin
                                DrawCircleOrCross('default', (2-1)*19 + 1, (2-1)*9 + 1, cp);
                                grid[2][2] := 1;
                                done := true;
                            end
                            else if (grid[1][3] = grid[2][2]) and (grid[2][2] = j) and (grid[3][1] = 0) and (done = false) then
                            begin
                                DrawCircleOrCross('default', (3-1)*19 + 1, (1-1)*9 + 1, cp);
                                grid[3][1] := 1;
                                done := true;
                            end;
                        end;
                        if done = false then               //the above cases do not match, then random
                        begin
                            repeat
                                number1 := random(3) + 1;
                                number2 := random(3) + 1;
                            until grid[number1][number2] = 0;
                            DrawCircleOrCross('default', (number1-1)*19 + 1, (number2-1)*9 + 1, cp);
                            grid[number1][number2] := 1;
                        end;

               end;
        false : begin                     //my  turn
                    if grid[my_x][my_y] = 1 then
                        DrawCircleOrCross('not valid', (my_x-1)*19 + 1, (my_y-1)*9 + 1, player)
                    else
                        DrawCircleOrCross('selected', (my_x-1)*19 + 1, (my_y-1)*9 + 1, player);
                    repeat
                        c := readkey;
                        if c = #0 then
                        begin
                            if grid[my_x][my_y] = 1 then
                                DrawCircleOrCross('default', (my_x-1)*19 + 1, (my_y-1)*9 + 1, cp)
                            else if grid[my_x][my_y] = 2 then
                                DrawCircleOrCross('default', (my_x-1)*19 + 1, (my_y-1)*9 + 1, player)
                            else
                                DrawCircleOrCross('cleared', (my_x-1)*19 + 1, (my_y-1)*9 + 1, player);
                            c := readkey;
                            case c of
                                #72 : if my_y > 1 then my_y := my_y - 1; //up
                                #80 : if my_y < 3 then my_y := my_y + 1; //down
                                #75 : if my_x > 1 then my_x := my_x - 1; //left
                                #77 : if my_x < 3 then my_x := my_x + 1; //right
                            end;
                            if (grid[my_x][my_y] = 1) or (grid[my_x][my_y] = 2) then
                                DrawCircleOrCross('not valid', (my_x-1)*19 + 1, (my_y-1)*9 + 1, player)
                            else
                                DrawCircleOrCross('selected', (my_x-1)*19 + 1, (my_y-1)*9 + 1, player)
                        end;
                    until (c = #13) and (grid[my_x][my_y] = 0);
                    DrawCircleOrCross('default', (my_x-1)*19 + 1, (my_y-1)*9 + 1, player);
                    grid[my_x][my_y] := 2;     //my value is 2
                end;
    end;
    switch := switch + 1;  //to determine the turn of player and cp
    turn := turn + 1;    //the actual turns passed
    for i := 1 to 3 do                                                                                                //win condition
        if (grid[i][1] = grid[i][2]) and (grid[i][3] = grid[i][2]) and (grid[i][1] = 2) then
            playerwin := true
        else if (grid[1][i] = grid[2][i]) and (grid[3][i] = grid[2][i]) and (grid[1][i] = 2) then
            playerwin := true;
    if (grid[1][1] = grid[2][2]) and (grid[2][2] = grid[3][3]) and (grid[1][1] = 2) then
        playerwin := true
    else if (grid[3][1] = grid[2][2]) and (grid[2][2] = grid[1][3]) and (grid[3][1] = 2) then
        playerwin := true;
    for i := 1 to 3 do
        if (grid[i][1] = grid[i][2]) and (grid[i][3] = grid[i][2]) and (grid[i][1] = 1) then
            cpwin := true
        else if (grid[1][i] = grid[2][i]) and (grid[3][i] = grid[2][i]) and (grid[1][i] = 1) then
            cpwin := true;
    if (grid[1][1] = grid[2][2]) and (grid[2][2] = grid[3][3]) and (grid[1][1] = 1) then
        cpwin := true
    else if (grid[3][1] = grid[2][2]) and (grid[2][2] = grid[1][3]) and (grid[3][1] = 1) then
        cpwin := true;
        
    until cpwin or playerwin or (turn > 9);
    gotoxy(65, 10);
    total := total + 1;
    if cpwin then
    begin
        lose := lose + 1;
        write('You LOSE.');
    end
    else if playerwin then
    begin
        win := win + 1;
        write('You WIN!!');
    end
    else if turn > 9 then
    begin
        draw := draw + 1;
        write('DRAW');
    end;
    WinRate := win / total * 100;
    rewrite(Playerfile);
    writeln(Playerfile, total);
    writeln(Playerfile, win);
    writeln(Playerfile, lose);
    writeln(Playerfile, draw);
    writeln(Playerfile, WinRate);
    gotoxy(65, 16);
    write('Current player : ', name);
    gotoxy(65, 18);
    write('Play again using the same player name?');
    yes := true;                         // yes means want to play again
    ButtonYesGameScreen('selected');
    ButtonNoGameScreen('default');
    repeat
        c := readkey;
        if c = #0 then
        begin
            case yes of
                true : ButtonYesGameScreen('default');
                false : ButtonNoGameScreen('default');
            end;
            c := readkey;
            case c of
                #77 : if yes then yes := false;   //left
                #75 : if yes = false then yes := true; //right
            end;
            case yes of
                true : ButtonYesGameScreen('selected');
                false : ButtonNoGameScreen('selected');
            end;
        end;
    until c = #13;
    until yes = false;      //exit mode1
    close(Playerfile);
    mode := 0;
end;

procedure ScoreBoard_HistoryScreen;                         {Scoreboard}
var i, counter, err, position, numberofdata : integer;
    PlayerNameFile, Playerfile, WinRateFile : text;
    Name : string;
    WinRate : real;
    TopThreeData : array[1..3] of real;
    TopThreeName, FirstThreeLines : array[1..3] of string;
    data, temp_data: real;
    NameInWinRateFile, WholeLine, temp_name : string;
begin
    for i := 1 to 30 do
    begin
        gotoxy(90, i);
        write('|');
    end;
    gotoxy(92, 7);
    write('RATING(Win Rate)');
    assign(PlayerNameFile, 'PlayerNameFile.txt');
    reset(PlayerNameFile);
    assign(WinRateFile, 'WinRateFile.txt');
    rewrite(WinRateFile);
    numberofdata := 0;
    while not eof(PlayerNameFile) do
    begin
        while not eoln(PlayerNameFile) do
        begin
            read(PlayerNameFile, Name);
            assign(Playerfile, concat(lowercase(Name), '.txt'));
            reset(Playerfile);
            while not eof(Playerfile) do
                readln(Playerfile, WinRate);
            writeln(WinRateFile, WinRate, ',', Name);
            numberofdata := numberofdata + 1;                //count how many names are in the txt file
            close(Playerfile);
        end;
        readln(PlayerNameFile);
    end;
    close(PlayerNameFile);
    reset(WinRateFile);
    if numberofdata = 0 then                 //no one has played before
    begin
        close(WinRateFile);
        gotoxy(92, 10);
        write('1st : ---');
        gotoxy(92, 12);
        write('2nd : ---');
        gotoxy(92, 14);
        write('3rd : ---');
    end
    else if numberofdata = 1 then
    begin
        readln(WinRateFile, FirstThreeLines[1]);
        position := pos(',', FirstThreeLines[1]);
        Val(copy(FirstThreeLines[1], 1, position - 1), TopThreeData[1], err);         //get his data
        TopThreeName[1] := copy(FirstThreeLines[1], position + 1, length(FirstThreeLines[1]));     //get his name
        close(WinRateFile);
        gotoxy(92, 10);
        write('1st : ', TopThreeData[1]:4:2, '%  ', TopThreeName[1]);       //output
        gotoxy(92, 12);
        write('2nd : ---');
        gotoxy(92, 14);
        write('3rd : ---');
    end
    else if numberofdata = 2 then
    begin
        for counter := 1 to 2 do                                                                             //get the first 2 data
        begin
            readln(WinRateFile, FirstThreeLines[counter]);
            position := pos(',', FirstThreeLines[counter]);
            Val(copy(FirstThreeLines[counter], 1, position - 1), TopThreeData[counter], err);
            TopThreeName[counter] := copy(FirstThreeLines[counter], position + 1, length(FirstThreeLines[counter]));
        end;
        if TopThreeData[2] > TopThreeData[1] then                 //compare
        begin
            temp_data := TopThreeData[1];
            temp_name := TopThreeName[1];
            TopThreeData[1] := TopThreeData[2];
            TopThreeName[1] := TopThreeName[2];
            TopThreeData[2] := temp_data;
            TopThreeName[2] := temp_name;
        end;
        close(WinRateFile);
        gotoxy(92, 10);
        write('1st : ', TopThreeData[1]:4:2, '%  ', TopThreeName[1]);             //output
        gotoxy(92, 12);
        write('2nd : ', TopThreeData[2]:4:2, '%  ', TopThreeName[2]);
        gotoxy(92, 14);
        write('3rd : ---');
    end
    else if numberofdata > 2 then            //more than 3 data
    begin
        for counter := 1 to 3 do
        begin
            readln(WinRateFile, FirstThreeLines[counter]);
            position := pos(',', FirstThreeLines[counter]);
            Val(copy(FirstThreeLines[counter], 1, position - 1), TopThreeData[counter], err);
            TopThreeName[counter] := copy(FirstThreeLines[counter], position + 1, length(FirstThreeLines[counter]));
        end;
        if (TopThreeData[3] > TopThreeData[2]) then           //compare
        begin
            temp_data := TopThreeData[2];
            temp_name := TopThreeName[2];
            TopThreeData[2] := TopThreeData[3];
            TopThreeName[2] := TopThreeName[3];
            TopThreeData[3] := temp_data;
            TopThreeName[3] := temp_name;
        end;
        if (TopThreeData[2] > TopThreeData[1]) then
        begin
            temp_data := TopThreeData[1];
            temp_name := TopThreeName[1];
            TopThreeData[1] := TopThreeData[2];
            TopThreeName[1] := TopThreeName[2];
            TopThreeData[2] := temp_data;
            TopThreeName[2] := temp_name;
        end;
        while not eof(WinRateFile) do            //read the remaining data
        begin
            while not eoln(WinRateFile) do
            begin
                read(WinRateFile, WholeLine);
                position := pos(',', WholeLine);
                Val(copy(WholeLine, 1, position - 1), data, err);
                NameInWinRateFile := copy(WholeLine, position + 1, length(WholeLine));
                if (data > TopThreeData[3]) then
                begin
                    TopThreeData[3] := data;
                    TopThreeName[3] := NameInWinRateFile;
                end;
                if (TopThreeData[3] > TopThreeData[2]) then
                begin
                    temp_data := TopThreeData[2];
                    temp_name := TopThreeName[2];
                    TopThreeData[2] := TopThreeData[3];
                    TopThreeName[2] := TopThreeName[3];
                    TopThreeData[3] := temp_data;
                    TopThreeName[3] := temp_name;
                end;
                if (TopThreeData[2] > TopThreeData[1]) then
                begin
                    temp_data := TopThreeData[1];
                    temp_name := TopThreeName[1];
                    TopThreeData[1] := TopThreeData[2];
                    TopThreeName[1] := TopThreeName[2];
                    TopThreeData[2] := temp_data;
                    TopThreeName[2] := temp_name;
                end;
            end;
            readln(WinRateFile);
        end;
        close(WinRateFile);
        gotoxy(92, 10);
        write('1st : ', TopThreeData[1]:4:2, '%  ', TopThreeName[1]);
        gotoxy(92, 12);
        write('2nd : ', TopThreeData[2]:4:2, '%  ', TopThreeName[2]);
        gotoxy(92, 14);
        write('3rd : ', TopThreeData[3]:4:2, '%  ', TopThreeName[3]);
    end;
end;

procedure HistoryScreen(var mode : integer);        {History Screen}
var HistoryArtFile, PlayerNameFile, Playerfile : text;
    s, PlayerName, FilePlayerName: string;
    i, total, win, lose, draw : integer;
    WinRate : real;
    Found : boolean;
begin
    Found := false;
    textbackground(black);
    textcolor(lightgray);
    clrscr;
    ScoreBoard_HistoryScreen;
    gotoxy(1, 1);
    assign(HistoryArtFile, 'HistoryASCIIArt.txt');        //Copy the ascii art to the prog
    reset(HistoryArtFile);
    while not eof(HistoryArtFile) do
    begin
        while not eoln(HistoryArtFile) do
        begin
            read(HistoryArtFile, s);
            writeln(s);
        end;
        readln(HistoryArtFile);
    end;
    close(HistoryArtFile);
    for i := 1 to 120 do
        write('-');
    writeln;
    for i := 1 to 30 do
    begin
        gotoxy(60, i);
        write('|');
    end;
    gotoxy(1, 10);
    repeat                                                          //if the player name exist in the text file
        assign(PlayerNameFile, 'PlayerNameFile.txt');
        reset(PlayerNameFile);
        cursoron;
        write('Enter player''s name (enter nothing('''') to exit): ');
        readln(PlayerName);
        while not eof(PlayerNameFile) and Not Found do
        begin
            while not eoln(PlayerNameFile) and Not Found do
            begin
                read(PlayerNameFile, FilePlayerName);
                if (lowercase(FilePlayerName) = lowercase(PlayerName)) and (Not Found) then
                    Found := true;
            end;
            readln(PlayerNameFile);
        end;
        close(PlayerNameFile);
        if (Not Found) and (lowercase(PlayerName) <> '') then    //ask for valid name
            writeln('Player not found. Please enter again!');
    until (Found) or (lowercase(PlayerName) = '');
    cursoroff;
    if Found then  //found!!
    begin
        cursoroff;
        writeln('Found!');
        writeln;
        write('Press enter key to exit.');
        gotoxy(62, 7);
        write('Player: ', lowercase(PlayerName));
        assign(Playerfile, concat(lowercase(PlayerName), '.txt'));
        reset(Playerfile);
        readln(Playerfile, total);
        readln(Playerfile, win);
        readln(Playerfile, lose);
        readln(Playerfile, draw);
        readln(Playerfile, WinRate);
        close(Playerfile);
        gotoxy(62, 10);            //output coordinate
        write('Total games : ', total);
        gotoxy(62, 12);
        write('Win : ', win);
        gotoxy(62, 14);
        write('Lose : ', lose);
        gotoxy(62, 16);
        write('Draw : ', draw);
        gotoxy(62, 18);
        write('Win rate : ');
        textcolor(red);
        textbackground(yellow);
        write(WinRate : 4 : 2, '%');
        readln;
        mode := 0;
    end;
    if (lowercase(PlayerName) = '') then   //get back to start screen
        mode := 0;
end;

procedure ButtonYes(s : String);         {in exit screen}
begin
    gotoxy(ExitScreenCoordinate_x + 8, ExitScreenCoordinate_y + 8);
    if s = 'selected' then
    begin
        textcolor(lightgray);
        textbackground(black);
    end
    else if s = 'default' then
    begin
        textcolor(black);
        textbackground(lightgray);
    end;
    write(' Yes ');
end;

procedure ButtonNo(s : String);             {exit screen}
begin
    gotoxy(ExitScreenCoordinate_x + 28, ExitScreenCoordinate_y + 8);
    if s = 'selected' then
    begin
        textcolor(lightgray);
        textbackground(black);
    end
    else if s = 'default' then
    begin
        textcolor(black);
        textbackground(lightgray);
    end;
    write(' No ');
end;

procedure ExitScreenMsgBox;
var i, j : integer;
begin
    gotoxy(ExitScreenCoordinate_x, ExitScreenCoordinate_y);
    textbackground(lightgray);
    textcolor(black);
    for i := 1 to 40 do
        write('-');
    for i := 2 to 10 do
    begin
        gotoxy(ExitScreenCoordinate_x, ExitScreenCoordinate_y + i - 1);
        write('|');
        for j := 2 to 39 do
            write(' ');
        write('|');
    end;
    gotoxy(ExitScreenCoordinate_x, ExitScreenCoordinate_y + 10);
    for i := 1 to 40 do
        write('-');
    gotoxy(ExitScreenCoordinate_x + 13, ExitScreenCoordinate_y + 2);
    write('Confirm exit?');
    ButtonNo('selected');
    ButtonYes('default');
end;

procedure ExitScreen(var mode : integer);
var selectedYesOrNo : integer;
    c : char;
begin
    selectedYesOrNo := 2;
    textbackground(black);
    textcolor(lightgray);
    clrscr;
    ExitScreenMsgBox;
    repeat
    c := readkey;
    if c = #0 then
    begin
        case selectedYesOrNo of
            1 : ButtonYes('default');
            2 : ButtonNo('default');
        end;
        c := readkey;
        case c of
            #75 : if selectedYesOrNo > 1 then selectedYesOrNO := selectedYesOrNO - 1 else if selectedYesOrNO = 1 then selectedYesOrNO := 2; //left
            #77 : if selectedYesOrNO < 2 then selectedYesOrNO := selectedYesOrNO + 1 else if selectedYesOrNO = 2 then selectedYesOrNO := 1; //right
        end;
        case selectedYesOrNo of
            1 : ButtonYes('selected');
            2 : ButtonNo('selected');
        end;
    end;
    until c = #13;
    if selectedYesOrNO = 1 then
        mode := 4               //exit
    else if selectedYesOrNO = 2 then
        mode := 0;            //go back to starting screen
end;

begin   {main program}
    cursoroff;
    randomize;
    mode := 0;
    repeat
        case mode of
            0 : StartingScreen(mode);
            1 : GameScreen(mode);
            2 : HistoryScreen(mode);
            3 : ExitScreen(mode);
        end;
    until mode = 4;
end.

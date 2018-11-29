program password;
uses crt;
const x_pos = 39;
      y_pos = 9;
      width = 40;
      height = 13;
{var c : char;
    pw, stars, s : string;}
var pword, Username : string;
    mode : integer;

procedure stupidEncryption(var s : string);
var i : integer;
begin
    for i := 1 to length(s) do
        s[i] := chr(ord(s[i])+2);   
end;

procedure stupidDecryption(var s : string);
var i : integer;
begin
    for i := 1 to length(s) do
        s[i] := chr(ord(s[i])-2);   
end;

procedure printUserPasswordBox(title : string);
var i, j : integer;
begin
    gotoxy(x_pos, y_pos); 
    textbackground(lightgray);
    textcolor(black);
    write(#201);
    for i := 2 to 3 do  
        write(#205);
    write(title, ':');
    for i := length(title)+1 to width-7 do  
        write(#205);
    //write(#187);
    write('- x');
    for i := 2 to height-1 do
    begin
        gotoxy(x_pos, y_pos-1+i); 
        for j := 1 to width do
            if (j = 1) or (j = width) then
                write(#186)
            else
                write(' ');
    end;
    gotoxy(x_pos, y_pos+height-1);
    write(#200);
    for i := 2 to width - 1 do  
        write(#205);
    write(#188);
    gotoxy(x_pos+5, y_pos+3);
    write('Username: ');
    textbackground(black);
    for i := 1 to 15 do
        write(' ');
    gotoxy(x_pos+5, y_pos+8);
    textbackground(lightgray);
    write('Password: ');
    textbackground(black);
    for i := 1 to 15 do
        write(' ');
    
    
    textcolor(lightgray);

end;

procedure inputtingUsername(var uname : string; var mode : integer);
var c : char;
    i: integer;
begin
    gotoxy(x_pos+5+10, y_pos+3);
    uname := '';
    repeat
        c := readkey;
        if (c <> #13) and (c >= #33) and (c <= #126) and (length(uname) < 14) then
            uname := uname + c
        else if (c = #8) and (length(uname) > 0) then
        begin
            uname[length(uname)] := chr(0);
            uname[0] := chr(ord(uname[0]) - 1);
        end;
        gotoxy(x_pos+5+10, y_pos+3);
        for i := 1 to length(uname)+1 do    
            write(' ');
        gotoxy(x_pos+5+10, y_pos+3);
        write(uname);
    until (c = #9) or (c = #13) and (length(uname) >= 3);
    if c = #9 then  
        mode := 2;
end;

procedure inputtingPassword(var pw : string; var mode : integer);
var c : char;
    stars : string;
    i : integer;
begin
    pw := '';
    stars := '';
    gotoxy(x_pos+5+10, y_pos+8);
    repeat
        c := readkey;
        if (c <> #13) and (c >= #33) and (c <= #126) and (length(pw) < 14) then
        begin
            stars := stars + '*';
            pw := pw + c;
        end
        else if (c = #8) and (length(pw) > 0) then
        begin
            stars[length(stars)] := chr(0);
            stars[0] := chr(ord(stars[0]) - 1);
            pw[length(pw)] := ('')[0];
            pw[0] := chr(ord(pw[0])-1);
        end;
        gotoxy(x_pos+5+10, y_pos+8);
        for i := 1 to length(stars)+1 do    
            write(' ');
        //clreol;
        gotoxy(x_pos+5+10, y_pos+8);
        write(stars);
    until (c = #9) or (c = #13) and (length(pw) >= 8);
    if c = #9 then  
        mode := 1;
end;

begin
    printUserPasswordBox('Testing');

    mode := 1;
    repeat
        case mode of
            1 : inputtingUsername(Username, mode);
            2 : inputtingPassword(pword, mode);
        end;
    until (mode = 2) and (length(Username) > 2) and (length(pword) > 7);

    clrscr;
    writeln(Username);
    writeln('Your password = ', pword);
    stupidEncryption(pword);
    writeln('After stupid encryption: ', pword);
    stupidDecryption(pword);
    writeln('After stupid decryption: ', pword);

    readln;
end.
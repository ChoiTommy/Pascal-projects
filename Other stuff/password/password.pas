program password;
uses crt;

const x_pos = 20;
      y_pos = 7;
      width = 30;
      height = 7;

var c : char;
    pw, stars, s : string;

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

procedure printMsgBox;
var i, j : integer;
begin
    for i := 1 to height do
    begin
        gotoxy(x_pos-1+i, y_pos-1+i); 
        for j := 1 to width do
        begin
            textbackground(lightgray);
            write(' ');
        end;
end;

begin
    pw := '';
    stars := '';
    s := 'Enter your password(at least 8 characters): ';
    write(s);
    repeat
        c := readkey;
        if (c <> #13) and (c >= #33) and (c <= #126) then
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
        gotoxy(length(s)+1, 1);
        ClrEol;
        write(stars);
    until (c = #13) and (length(pw) >= 8);
    writeln();
    writeln('Your password = ', pw);
    stupidEncryption(pw);
    writeln('After stupid encryption: ', pw);
    stupidDecryption(pw);
    writeln('After stupid decryption: ', pw);
    printMsgBox;
    readln;
end.

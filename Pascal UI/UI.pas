program UI;
uses crt;

procedure drawButton(startX, startY, width, height : integer; s : string; textColor, buttonColor : integer; selected : Boolean);
(*TODO
* text color, print character, ...
* button border
*)
var i, j : integer;
begin
    for i := 1 to height do
    begin
        GotoXY(startX, startY + i - 1);
        for j := 1 to width do
        begin
            TextBackground(LightGray);
            Write(s);
        end;
        WriteLn;
    end;
end;

procedure drawMsgBox(startX, startY, width, height : integer);
begin

end;

procedure drawColorBlock();
begin

end;

begin
    drawButton(2, 2, 10, 5, 's', 1, 1, False);
    ReadLn;
end.
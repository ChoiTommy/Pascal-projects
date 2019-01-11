program smartAI;
var s, response : string;
    position : Integer;
begin
    WriteLn('Welcome to AI chatroom! Feel free to chat with her! No friend no worry.');
    repeat
        write('You: ');
        readln(s);
        position := Pos('嗎', s);
        if position <> 0 then
            s[position] := ' ';
        response := s;
        WriteLn('AI: ', response);

    until false;
end.
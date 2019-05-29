program test;
var txtfile1, txtfile2, result : text;
    i, j : integer;
    s1, s2 : string;
begin
    assign(txtfile1, 'hint_original.txt');
    assign(txtfile2, 'view-source_student.tanghin.edu.hk__S141039_TAGSTXRE.txt');
    assign(result, 'output.txt');
    reset(txtfile1);
    reset(txtfile2);
    rewrite(result);
    
    writeln(#219);
    readln;
    
    for i := 1 to 39 do
    begin
        readln(txtfile1, s1);
        readln(txtfile2, s2);
        for j := 1 to 39 do
        begin
            if (s1[j] = '.') and (s2[j] = '.') then
                write(result, ' ')
            else if (s1[j] = '.') or (s2[j] = '.') then
                write(result, '.')
            else
                write(result, ' ');
        end;
        writeln(result);
    end;
    
    close(txtfile1);
    close(txtfile2);
    close(result);
end.

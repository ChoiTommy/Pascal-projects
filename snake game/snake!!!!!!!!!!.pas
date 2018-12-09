program Noname4;
uses crt;

var x,y,a,b,l,k,fx,fy,z,i,j,boxx,boxy,score:integer;
c:char;

function outofbound(p,q : integer) : boolean;
begin
    outofbound := false;
    if q <= 1 then
        outofbound:= true;
    if q >= 27 then
        outofbound:= true;
    if p <= 1 then
        outofbound:= true;
    if p >= 70 then
        outofbound:= true;
end;

procedure gameover;
begin
    if outofbound(x,y)then
     begin
     writeln('out!!!');
     delay(10000);
     end;
end;

procedure control;
begin

 if ord(c) =115 then
     begin
     for i:=1 to l do
     begin
       gotoxy(x-a*l,y-b*l);
    write(' ');
       end;
      if (b-0)<>-1 then
       begin
      a:=0;
      b:=1;
       end
    end
    
    else if ord(c) =97 then
    begin
      for i:=1 to l do
       begin
       gotoxy(x-a*l,y-b*l);
    write(' ');
       end;
        if (a-0)<>1 then
        begin
      a:= -1;
      b:=0;
        end
    end
    
    else if ord(c) =100 then
    begin
        for i:=1 to l do
         begin
       gotoxy(x-a*l,y-b*l);
    write(' ');
       end;
    if (a-0)<>-1 then
    begin
      a:= 1;
      b:=0;
      end
    end
    
    else if ord(c) =119 then
    begin
     for i:=1 to l do
         begin
       gotoxy(x-a*l,y-b*l);
    write(' ');
       end;
    if (b-0)<>1 then
    begin
      a:= 0;
      b:=-1;
      end
    end

end;


begin
randomize;
z:=150;
cursoroff;
x:=5;
y:=4;
a:=1;
b:=0;
l:=1;




boxx:=0;
boxy:=0;
  for i:=1 to 70 do

write('+');
writeln('+') ;


for j:=1 to 24 do
writeln('+','+':70);


for i:=1 to 70 do
write('+');
writeln('+') ;
 
  writeln;

fy:=random(20)+2;
fx:=random(65)+2;
gotoxy(fx,fy);
write('$');




repeat
repeat

    gameover;
    if (x = fx) and (y = fy)then
    begin
    gotoxy(31,1);
    write('score:',score);
    fy:=random(20)+3;
    fx:=random(65)+3;
       gotoxy(fx,fy);
    write('$');
    l:=l+1;
    z:=z-5;
    score:=score+1;
    end ;

   delay(z);
    gotoxy(x,y);
    write('*');
    gotoxy(x-a*l,y-b*l);
    write(' ');

     x:=x+a;
     y:=y+b;
    until keypressed ;
    c:= readkey;

  control;


  until 'she'= 'me';

end.

type
  stek = ^s;
  s = record
    inf: string[20];
    sled: stek;
  end;

{Создание стека}
procedure P1(var H: text; var S: stek);
  var
    tmp: stek;
  begin
    S:=nil;
    while not eof (H) do begin
      new(tmp);
      readln(H,tmp^.inf);
      tmp^.sled:=S;
      S:=tmp;
    end;
  end;

{Вывод стека}
procedure P2(var G: text; var S: stek);
  var
    tmp: stek;
  begin
    tmp:=S;
    while tmp <> nil do begin
      writeln(G,tmp^.inf);
      tmp:=tmp^.sled;
    end;
  end;

{Слияние стеков, S - отсорт. стек}
procedure P3(var S: stek; var G: text);
  var
    tmp,t: stek;
  begin
    while not eof (G) do begin
      new(t);
      readln(G,t^.inf);
      tmp:=S;
      if t^.inf > S^.inf then begin
        t^.sled:=S;
        S:=t;
      end
      else begin
        while (t^.inf < tmp^.sled^.inf) and (tmp^.sled <> nil) do
          tmp:=tmp^.sled;
        if tmp^.sled = nil then
          tmp^.sled:=tmp
        else  begin
          t^.sled:=tmp^.sled;
          tmp^.sled:=t;
        end;
      end;
    end;
  end;

var
  f1,f2,f3: text;
  St: stek;
begin
  assign(f1,'f1.txt'); reset(f1);
  assign(f2,'f2.txt'); reset(f2);
  assign(f3,'f3.txt'); rewrite(f3);

  P1(f1,St);
  P3(St,f2);
  P2(f3,St);

  close(f1);
  close(f2);
  close(f3);
end.



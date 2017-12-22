type
  list = ^t;
  t = record
    name: string[10];
    quant: integer;
    sled: list;
  end;

procedure P1(var H: text; var head: list);
  var
    tmp: list;
  begin
    new(head);
    tmp:=head;
    while not eof(H) do
      begin
        new(tmp^.sled);
        tmp:=tmp^.sled;
        readln(H,tmp^.name,tmp^.quant);
      end;
    tmp^.sled:=nil;
  end;

procedure P2(var G: text; var head: list);
  var
    tmp: list;
  begin
    writeln(G,'---------------');
    tmp:=head^.sled;
    while tmp <> nil do
      begin
        writeln(G,tmp^.name,tmp^.quant);
        tmp:=tmp^.sled;
      end;
  end;

procedure P3(var Head1,head2: list);
  var
    tmp1, tmp2: list;
  begin
    tmp1:=head1^.sled;
    while tmp1<>nil do begin
      tmp2:=head2;
      while (tmp2^.sled<>nil) and (tmp1^.quant > 0) do begin
        if tmp1^.name = tmp2^.sled^.name then begin
          tmp1^.quant:=tmp1^.quant-tmp2^.sled^.quant;
          if tmp1^.quant >= 0 then
            tmp2^.sled:=tmp2^.sled^.sled
            else begin
               tmp2^.sled^.quant:=abs(tmp1^.quant);
               tmp1^.quant:=0;
            end;
        end;
        tmp2:=tmp2^.sled;
      end;
      tmp1:=tmp1^.sled;
    end;
  end;

var
  s1,s2: list;
  f1,f2,f3: text;
begin
  assign(f1,'f1.txt'); reset(f1);
  assign(f2,'f2.txt'); reset(f2);
  assign(f3,'f3.txt'); rewrite(f3);

  P1(f1,s1);
  P1(f2,s2);

  P2(f3,s1);
  P2(f3,s2);

  P3(s1,s2);

  P2(f3,s1);
  P2(f3,s2);

  close(f1);
  close(f2);
  close(f3);
end.




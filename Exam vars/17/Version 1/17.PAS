type
  number = string[5];
  famname = string[20];

  zap = record
    num: number;
    fn: famname;
  end;

  list = ^l;
  l = record
    z: zap;
    sled: list;
  end;

  typ = file of zap;

procedure P1(fileF: string; fileT: string);
  var
    s: zap;
    F: text;
    T: typ;
  begin
    assign(F,fileF); reset(F);
    assign(T,fileT); rewrite(T);
    while not eof(F) do begin
      readln(F, s.num, s.fn);
      write(T, s);
    end;
    close(F);
    close(T);
  end;

procedure P2( fileF: string; var head: list);
  var
    tmp,t: list;
    F: typ;
  begin
    assign(F,fileF); reset(F);

    new(head);
    head^.sled:=nil;
    tmp:=head;
    while not eof(F) do begin
      new(t);
      read(F,t^.z);
      while (tmp^.sled <> nil) and (t^.z.fn > tmp^.sled^.z.fn) do
        tmp:=tmp^.sled;
      t^.sled:=tmp^.sled;
      tmp^.sled:=t;
    end;

    close(F);
  end;

procedure P4(var S1,S2: list);
  var
    tmp1, tmp2,t: list;
  begin
    tmp1:=S1;
    tmp2:=S2^.sled;
    while tmp2 <> nil do begin
      while (tmp1^.sled <> nil) and (tmp2^.z.fn > tmp1^.sled^.z.fn) do
        tmp1:=tmp1^.sled;
      t:=tmp2^.sled;
      tmp2^.sled:=tmp1^.sled;
      tmp1^.sled:=tmp2;
      tmp2:=t;
    end;
  end;

procedure P5(var F: text; var S: list);
  begin
    if s<>nil then begin
      writeln(F,s^.z.num,s^.z.fn);
      P5(F,S^.sled);
    end;
  end;

var
  S1,S2: list;
begin
  assign(output,'f3.txt'); rewrite(output);

  P1('f1.txt','t1.tpu');
  P2('t1.tpu',S1);
  P5(output, S1^.sled);

  writeln(output,'--------------');

  P1('f2.txt','t2.tpu');
  P2('t1.tpu',S2);
  P5(output,S2^.sled);

  writeln(output,'--------------');

  P4(s1,s2);
  P5(output,S1^.sled);

  close(output);
end.









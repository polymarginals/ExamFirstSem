uses
  crt;
type
  list = ^g;
  g = record
    f: string[15];
    t: string[11];
    sled: list;
  end;

  dub = ^t;
  t = record
    fam: string[15];
    tel: string[11];
    sled: dub;
    pred: dub;
  end;

  dublist = record
    head: dub;
    tail: dub;
  end;


{создание двунаправленного списка}
procedure P1(var f: text; var R: dublist);
  var
    head,tail: dub;
  begin
    new(tail);
    tail^.pred:=nil;
    R.head:=tail;

    while not eof (f) do
      begin
        new(tail^.sled);
        tail^.sled^.pred:=tail;
        tail:=tail^.sled;

        read(f,tail^.fam);
        readln(f,tail^.tel);
      end;
    new(tail^.sled);
    tail^.sled^.pred:=tail;
    tail:=tail^.sled;
    tail^.sled:=nil;

    R.tail:=tail;
  end;

procedure P2(var f: text; var R: dublist);
  var
    tmp: dub;
    k: char;
  begin

    k:=readkey;
    while (k <> #48) and (k <> #49) do
      k:=readkey;

    writeln(f,'---------------------');
    if k = #48 then
      begin
        tmp:=R.head^.sled;
        while tmp^.sled<>nil do
          begin
            writeln(f,tmp^.fam,tmp^.tel);
            tmp:=tmp^.sled;
          end;
      end;
    if k = #49 then
      begin
        tmp:=R.tail^.pred;
        while tmp^.pred<>nil do
          begin
            writeln(f,tmp^.fam,tmp^.tel);
            tmp:=tmp^.pred;
          end;
      end;
    writeln(output,'---------------------');
  end;

procedure P3(var R: dublist; var s1,s2: list);
  var
    tmpR: dub;
    tmp, t: list;
  begin
    new(s1);
    new(s2);
    s1^.sled:=nil;
    s2^.sled:=nil;
    tmpR:=R.head^.sled;

    while tmpR^.sled <> nil do
      begin
        tmp:=s1;
        while (tmp^.sled<>nil) and (tmpR^.fam > tmp^.sled^.f) do
          tmp:=tmp^.sled;
        new(t);
        t^.t:=tmpR^.tel;
        t^.f:=tmpR^.fam;
        t^.sled:=tmp^.sled;
        tmp^.sled:=t;

        tmp:=s2;
        while (tmp^.sled<>nil) and (tmpR^.tel > tmp^.sled^.t) do
          tmp:=tmp^.sled;
        new(t);
        t^.f:=tmpR^.fam;
        t^.t:=tmpR^.tel;
        t^.sled:=tmp^.sled;
        tmp^.sled:=t;

        tmpR:=tmpR^.sled;
      end;

  end;

procedure P4(var f: text; var s:list);
  var
    tmp: list;
  begin
    writeln(f,'---------------------');
    tmp:=s^.sled;
    while tmp <> nil do
      begin
        writeln(f,tmp^.f, tmp^.t);
        tmp:=tmp^.sled;
      end;
    writeln(f,'---------------------');
  end;

  var
    R: dublist;
    s1, s2: list;
  begin
    writeln;
    writeln('Выберете направление списка');
    write('0 - с начала, 1 - с конца: ');
    assign(input,'f1.txt'); reset(input);
    assign(output,'f2.txt'); rewrite(output);
    P1(input,R);
    close(input);
    P2(output,R);

    P3(R,s1,s2);
    P4(output,s1);
    P4(output,s2);

    close(output);
  end.







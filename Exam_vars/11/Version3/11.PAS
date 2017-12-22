type
  tree = ^t;
  t = record
    age: integer;
    count: integer;
    l: tree;
    r: tree;
  end;

procedure P1(var F: text; var head: tree; var nmax: integer);
  var
    tmp1,tmp2,t: tree; s: string[10];
    n: integer;
  begin
    new(head);
    readln(F,s,head^.age);
    head^.count:=1;
    head^.l:=nil;
    head^.r:=nil;
    nmax:=1;

    while not eof(F) do begin
      tmp1:=head;
      new(t);
      t^.count:=1;
      readln(F,s,t^.age);
      t^.l:=nil;
      t^.r:=nil;
      n:=1;
      while (tmp1 <> nil) and (tmp1^.age <> t^.age) do begin
        inc(n);
        tmp2:=tmp1;
        if t^.age > tmp1^.age then
          tmp1:=tmp1^.r
        else
          tmp1:=tmp1^.l;
      end;
      if n > nmax then nmax:=n;
      if tmp1 = nil then
        if t^.age > tmp2^.age then
          tmp2^.r:=t
        else tmp2^.l:=t
      else
        inc(tmp1^.count);

    end;
  end;

function f (n: integer): integer;
  var
    x,i: integer;
  begin
    x:=1;
    for i:=1 to n do
      x:=x*2;
    f:=x-1;
  end;

procedure P2(var H: text; var S: tree; n: integer);
  var
    tmp: tree;
    i,k,t: integer;
  begin
    for i:=1 to f(n) do begin
       tmp:=S;
       t:=f(n-1)+1;
       for k:=n-1 downto 1 do begin
         if tmp = nil then break;
         if i > t then begin
           tmp:=tmp^.r;
           t:=t+f(k-1)+1
         end
         else
           if i < t then begin
             tmp:=tmp^.l;
             t:=t-f(k-1)-1;
           end
           else
             break;
       end;
       if tmp <> nil then
         writeln(H,'Age: ', tmp^.age, ' quant: ', tmp^.count);
    end;
  end;

procedure P3(var S: tree; var n,age,sum: integer);
  var
    tmp: tree;
    i,k,t: integer;
  begin
    sum:=0;
    for i:=1 to f(n) do begin
       tmp:=S;
       t:=f(n-1)+1;
       for k:=n-1 downto 1 do begin
         if tmp = nil then break;
         if i > t then begin
           tmp:=tmp^.r;
           t:=t+f(k-1)+1
         end
         else
           if i < t then begin
             tmp:=tmp^.l;
             t:=t-f(k-1)-1;
           end
           else
             break;
       end;
       if tmp <> nil then
         if tmp^.age <= age then
           sum:=sum+tmp^.count;
    end;
  end;

var n,count,age: integer;
  TR: tree;

begin
  writeln('Введите возраст: ');
  readln(age);
  assign(input, 'f1.txt'); reset(input);
  assign(output, 'f2.txt'); rewrite(output);

  P1(input,TR,n);

  P2(output,TR,n);
  P3(TR,n,age,count);

  writeln(output,'-----------');
  writeln(output,'quant with age <= ',age,':', count);

  close(input);
  close(output);
end.










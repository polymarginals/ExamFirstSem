program p3exam;

label 1;
type
  s = string[15];
  
  zap = ^svedeniya;
  
  svedeniya = record
    number: integer;
    fam, title: s;
    sled, vozr: zap;
  end;

procedure p1(var head_vozr: zap; var head_sp: zap; var f_in: text);
var
  sp, sp1, sp2: zap;
  number1: integer;
  fam1, title1: s;
begin
  while not eof(f_in) do
  begin
    readln(f_in, number1);
    readln(f_in, fam1);
    readln(f_in, title1);
    new(sp);
    sp^.number := number1;
    sp^.fam := fam1;
    sp^.title := title1;
    sp^.sled := nil;
    head_sp^.sled := sp;
    head_sp := head_sp^.sled;
    writeln(head_sp^.number);
    writeln(head_sp^.fam);
    writeln(head_sp^.title);
    if head_vozr^.number > sp^.number then
    begin
      sp^.vozr := head_vozr;
      head_vozr := sp;
    end
    else
    begin
      sp1 := head_vozr;
      while (sp1 <> nil) and (sp1^.number < head_sp^.number) do
       begin
       sp2:=sp1;
       sp1 := sp1^.vozr;
       end;
       
      head_sp^.vozr := sp1;
      sp2^.vozr := head_sp;
    end;  
  end;
  sp1 := head_vozr;
  while sp1 <> nil do
  begin
    writeln(sp1^.number);
    sp1 := sp1^.vozr;
  end;
end;

procedure p2(head_sp: zap; var head_vozr: zap);
var
  sp, sp1, spk,sp2: zap;
  number1: integer;
  fam1: s;
  title1: s;
begin
  readln(number1);
  readln(fam1);
  readln(title1);
  new(sp);
  sp^.number := number1;
  sp^.fam := fam1;
  sp^.title := title1;
  sp^.sled := nil;
  spk := head_sp;
  while spk^.sled <> nil do
    spk := spk^.sled;
  spk^.sled := sp;
  if head_vozr^.number > sp^.number then
  begin
    sp^.vozr := head_vozr;
    head_vozr := sp;
  end
  else
  begin
    sp1 := head_vozr;
    while (sp1 <> nil) and (sp1^.number < sp^.number) do
     begin
      sp2:=sp1;
      sp1 := sp1^.vozr;
     end;
    sp^.vozr := sp1;
    sp2^.vozr := sp;
  end;
end;

procedure p3(head_vozr: zap; order: boolean);
begin
  if order then
    while head_vozr <> nil do
    begin
      writeln(head_vozr^.title);
      head_vozr := head_vozr^.vozr;
    end
  else
  begin
    if head_vozr^.vozr <> nil then
      p3(head_vozr^.vozr, false);
    writeln(head_vozr^.title);
  end;
end;

procedure p4(head_sp: zap; fam1: s; var z: boolean);
var
  st: integer;
begin
  st := 0;
  while head_sp <> nil do
  begin
    if head_sp^.fam = fam1 then
    begin
      writeln(head_sp^.title);
      inc(st);
    end;
    head_sp := head_sp^.sled;
  end;
  if st > 0 then z := true
  else z := false;
end;

var
  head_sp, head_vozr, head: zap;
  fam1, title1, s1: s;
  i, number1: integer;
  f_in, f_out: text;
  z: boolean;

begin
  assign(f_in, 'input.txt');reset(f_in);
  assign(f_out, 'output.txt');rewrite(f_out);
  readln(f_in, number1);
  readln(f_in, fam1);
  readln(f_in, title1);
  new(head_sp);
  head_sp^.number := number1;
  head_sp^.fam := fam1;
  head_sp^.title := title1;
  head_sp^.sled := nil;
  head_sp^.vozr := nil;
  head_vozr := head_sp;
  writeln(head_sp^.number);
  writeln(head_sp^.fam);
  writeln(head_sp^.title);
  head := head_sp;
  p1(head_vozr, head, f_in);
  1:
  writeln('Do you want add book? 1- yes, anyone key-no');
  readln(i);
  if i = 1 then
  begin
    writeln('Please,enter number,second name and title of book');
    head := head_sp;
    p2(head, head_vozr);
    goto 1;
  end
  else
  begin
    writeln('If you want see list titles pre-order then press 1, reverse - anyone key');
    readln(i);
    if i = 1 then 
      p3(head_vozr, true)
    else
      p3(head_vozr, false);
    writeln('Please, enter the second name of writer');
    readln(s1);
    p4(head_sp, s1, z);
    if not z then
      writeln('writer are not found');
  end;
end.
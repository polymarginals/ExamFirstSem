program ex7;

type

t=^el;
el=record
fam:string[10];    {фамилия}
num:integer;       {номер (ключевое поле) }
lf,rt:t;
end;

procedure putree(var ukt:t;c:integer;st:string;var g:text);  {стандартная РЕКУРСИВНАЯ процедура создания дерева}
var
uk:t;
begin
if ukt= nil then {создание нового узла}
 begin
 new(uk);
 uk^.num:=c;
 uk^.fam:=st;
 uk^.lf:=nil;
 uk^.rt:=nil;
 ukt:=uk;
 end
else                  {если узел есть, то поиск необходимого места присоединения РЕКУРСИВНО}
 begin
 if c>ukt^.num then                             {подключаем справа}
  begin
  writeln(g,'right ',ukt^.num,' ',c);
  putree(ukt^.rt,c,st,g);
  end
 else                                            {подключаем слева}
  begin
  writeln(g,'left ',ukt^.num,' ',c);
  putree(ukt^.lf,c,st,g);
  end;
end;
end;

procedure getree_lr(var ukt:t;var g:text);  {РЕКУРСИВНАЯ процедура вывода дерева слева направо (по возрастанию)}
begin
 if ukt^.lf<>nil then getree_lr(ukt^.lf,g);
 if ukt<>nil then writeln(g,ukt^.num,' ',ukt^.fam);
 if ukt^.rt<>nil then getree_lr(ukt^.rt,g);
end;

procedure getree_rl(var ukt:t;var g:text); {РЕКУРСИВНАЯ процедура вывода дерева справа налево (по убыванию)}
begin
 if ukt^.rt<>nil then getree_rl(ukt^.rt,g);
 if ukt<>nil then writeln(g,ukt^.num,' ',ukt^.fam);
 if ukt^.lf<>nil then getree_rl(ukt^.lf,g);
end;

var
uktree:t;
c:integer;
st:string[10];
f,g:text;

begin
assign(f,'ex7.inp');
assign(g,'ex7.out');
reset(f);
rewrite(g);
uktree:=nil;     {обязательно корню в начале присваиваем NIL}
while not EOF(f) do begin   {цикл считывания из файла информации}
readln(f,st,c);
putree(uktree,c,st,g); {формирование}
end;
close(f);
writeln(g);
getree_lr(uktree,g);    {слева направо}
writeln(g);
getree_rl(uktree,g);    {справа налево}
close(g);
end.
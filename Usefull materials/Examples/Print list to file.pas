procedure P5(var head: a;var ff: text);
var
uksp: a;                            {Вывод списка в файл}
begin
uksp:=head^.sled;
while uksp^.sled<>nil do begin
writeln(ff,uksp^.tp.num,uksp^.tp.name);
uksp:=uksp^.sled;
end;
end;
program spisok;
uses crt;
type
    sp=^st;
    st=record
    inf:integer;
    link:sp;
    end;
 
VAR Begl,Endl,p,pn,pk:sp; n,i,j,id,g:byte; max,el:integer;
 
procedure vivod(p:sp);
begin
     while p<>nil do
       begin
            write(p^.inf:4);
            p:=p^.link;
       end;
 
end;
 
BEGIN
 
     write('Размер списка: ');
     readln(n);
 
     new(p);
     write('inf[1]=');
     readln(p^.inf);
     p^.link:=nil;
     Begl:=p;
     Endl:=p;
 
     for i:=2 to n do
       begin
            new(p);
            write('inf[',i,']=');
            readln(p^.inf);
            p^.link:=nil;
            Endl^.link:=p;
            endl:=p;
       end;
 
     writeln('До:');
     vivod(begl);
     writeln;
 
     //Сортировка
     pn:=begl;
     j:=1;
     while pn<>nil do
       begin
         p:=pn^.link;
         max:=pn^.inf;
         id:=j;
         i:=j+1;
         while p<>nil do
           begin
              if p^.inf>max then
                begin
                   max:=p^.inf;
                   id:=i;
                end;
              p:=p^.link;
              inc(i);
           end;
       
         pk:=begl;
         for g:=1 to id-1 do
           pk:=pk^.link;
         
         el:=pn^.inf;
         pn^.inf:=pk^.inf;
         pk^.inf:=el;
 
         pn:=pn^.link;
         inc(j);
       end;
 
     writeln('После:');
     vivod(begl);
END.
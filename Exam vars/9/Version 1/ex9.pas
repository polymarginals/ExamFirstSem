Uses CRT;
Type kolco=^rek;
     rek=record
        fam: string;
        next: kolco;
     end;

Var beg: kolco;
    f1,f2: text;

Procedure P1(Var f:text; Var beg: kolco);
Var tek: kolco;
Begin
     new(tek); tek^.next:=nil;
     readln(f,tek^.fam); beg:=tek;
     while not eof(f) do begin
           new(tek^.next);
           tek:=tek^.next;
           readln(f,tek^.fam);
           tek^.next:=nil;
     end; tek^.next:=beg;
End;

Procedure P2(Var f: text; beg: kolco);
Var tek,temp,prev: kolco;
    dir: byte;
Begin
     writeln('Choose direcion: 1-left; 2-right');
     readln(dir);
     if dir=1 then begin
        tek:=beg;
        while tek^.next<>beg do begin
              writeln(f,tek^.fam);
              tek:=tek^.next;
        end; writeln(f,tek^.fam);
     end;
     if dir=2 then begin
        tek:=beg;
        while tek^.next<>beg do tek:=tek^.next;
        temp:=tek;
        while temp<>beg do begin
              prev:=beg; tek:=beg;
              while tek<>temp do begin
                    prev:=tek;
                    tek:=tek^.next;
              end; writeln(f,tek^.fam); temp:=prev;
        end; writeln(f,beg^.fam);
     end;
     writeln(f);
End;

Procedure P3(Var beg: kolco);
Var tek,prev: kolco;
    i: integer;
Begin
     tek:=beg^.next; prev:=beg;
     i:=1;
     while tek<>beg do begin
           inc(i);
           if i mod 2 = 0 then begin
              prev^.next:=tek^.next;
              dispose(tek);
              tek:=prev^.next;
           end else begin
               prev:=tek;
               tek:=tek^.next;
           end;
     end;
End;

Begin
     clrscr;
     assign(f1,'inpEx9.inp');
     reset(f1);
     assign(f2,'outEx9.out');
     rewrite(f2);
     P1(f1,beg);
     P2(f2,beg);
     P3(beg);
     P2(f2,beg);
     close(f1);
     close(f2);
     readkey;
End.



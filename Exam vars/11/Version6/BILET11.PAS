program bilet11;

type
    next=^tree;
    tree=record
    nom:integer;
    fam:string;
    left,right:next;
    end;

var koren,vetka:next; f1,f2:text; a:integer; b:string;

procedure p1(var h:text; var koren:next; var a:integer; var b:string);

var vetka:next;

begin
     If koren=nil then
        begin
             new(vetka);
             vetka^.nom:=a;
             vetka^.fam:=b;
             vetka^.left:=nil;
             vetka^.right:=nil;
             koren:=vetka;
        end
        else
            If a






begin
     assign(f1, '11.inp');
     reset(f1);
     assign(f2, '11.out');
     rewrite(f2);

     while not eof(f1) do
           begin
                readln(f1,a,b);
                p1(f1,koren,a,b);
           end;


     close(f1);
     close(f2);
end.
program ex4;
type
    f = text;
    ch = char;
    int = integer;

    cursor = ^list;
    list =record
         e: ch;
         next: cursor;
    end;

procedure RList(var head:cursor;var inp:f);
var c:ch; cur:cursor;
begin
     read(inp,c);
     new(head);
     cur:=head;
     cur^.e:=c;
     while not eof(inp) do
     begin
          read(inp,c);
               new(cur^.next);
               cur:=cur^.next;
               cur^.e:=c;
     end;
     cur^.next:=nil;
end;

procedure WList(head:cursor;var out:f);
var cur:cursor;
begin
     cur:=head;
     while (cur<>nil) do begin
           write(out, cur^.e);
           cur:=cur^.next;
     end;
end;

procedure EList(pos:int);
var outp:f;
begin
     assign(outp,'output.txt');
     rewrite(outp);
     if(pos=0) then
          write(outp,'Error in amount of brackets')
     else
          write(outp,'Error in ',pos,' position - Different symbol expected');
     close(outp);
     halt;
end;

procedure CList(pred:char;cur:cursor;pos:int;var cs:int);
begin
if((pos=2) and ((pred='/') or (pred='*'))) then
         EList(pos);
if(((pred='+') or (pred='-') or (pred='/') or (pred='*'))
   and ((cur^.e='+') or (cur^.e='-') or (cur^.e='/') or (cur^.e='*')))then
         EList(pos);
if(not ((pred='+') or (pred='-') or (pred='/') or (pred='*') or (pred='(')) and (cur^.e='(')) then
         EList(pos);
if(not ((pred='+') or (pred='-') or (pred='/') or (pred='*') or (pred='(') or (pred=')'))
   and (not ((cur^.e='+') or (cur^.e='-') or (cur^.e='/') or (cur^.e='*') or (cur^.e='(') or (cur^.e=')')))) then
         EList(pos);
if(cur^.e='(') then
         cs:=cs+1;
if(cur^.e=')') then
         cs:=cs-1;
if(cs<0) then
         EList(0);
if(cur^.next<>nil) then
    begin
         pos:=pos+1;
         CList(cur^.e,cur^.next,pos,cs);
    end;

end;

var inp,out:f;
    head:cursor;
    co:int;
begin
     assign(inp,'input.txt');
     reset(inp);
     RList(head,inp);
     CList(head^.e,head^.next,2,co);
     if (co>0) then EList(0);
     assign(out,'output.txt');
     rewrite(out);
     WList(head,out);
     close(inp);
     close(out);
end.





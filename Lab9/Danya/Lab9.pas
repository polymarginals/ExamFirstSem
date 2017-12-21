program ex5;

type
    {Reduction of text}
    f = text;
    ch = char;
    int = integer;

    ut=^tree; {Tree}
    tree=record
      inf: int;
      left, right:ut;
    end;

    lst=^TList; {Queue for BFS}
    TList=record
      data:ut;
      next:lst;
    end;

procedure getDepth(root:ut;var depth:int); {Search depth for SubTree}
var ll,rr:int;
begin
if (root=nil) then exit;
ll:=depth+1;
rr:=depth+1;
getDepth(root^.left,ll);
getDepth(root^.right,rr);
if (ll>rr) then depth:=ll
else depth:=rr;
end;

procedure LT(var root:ut);  {Left Turn}
var tmpr,tmprl,tmpn:ut;
begin
tmpn:=root;
tmpr:=root^.right;
tmprl:=root^.right^.left;
tmpn^.right:=tmprl;
root:=tmpr;
root^.left:=tmpn;
end;

procedure ATList(var head,tail:lst;znach:ut); {Add element to TList}
var tmp:lst;
begin
  new(tmp);
  tmp^.next:=nil;
  tmp^.data:=znach;
  if head=nil
    then
      head:=tmp
    else
      tail^.next:=tmp;
  tail:=tmp;
end;

procedure TTList(var head,tail:lst;var znach:ut); {Take element from TList}
var tmp:lst;
begin
if head=nil then exit;
  znach:=head^.data;
  tmp:=head;
  head:=head^.next;
  dispose(tmp);
end;

procedure nlr(root:ut;var out:f); {N->L->R}
begin
if root=nil then exit;
write(out, root^.inf,' ');
nlr(root^.left,out);
nlr(root^.right,out);
end;


procedure BFS(root:ut;var out:f); {Breadth-First Search}
var znach:ut;mus,i,j,x,k:longint;
    head,tail:lst;
    depth,diver:int;s:char;
begin
  writeln(out);
  write(out,'BFS: ');
  head:=nil;
  tail:=nil;
  ATList(head,tail,root);
  while head<>nil do
  begin
    TTList(head,tail,znach);
    write(out,znach^.inf,' ');
    if(znach^.left <>nil) then ATList(head,tail,znach^.left );
    if(znach^.right<>nil) then ATList(head,tail,znach^.right);
  end;
end;

procedure ATree(var node:ut;c:int); {Add element to Tree}
begin
  if node=nil then
    begin
      new(node);
      node^.inf:=c;
      node^.left:=nil;
      node^.right:=nil;
      exit;
    end;
  if c<node^.inf then
    ATree(node^.left,c)
  else
    ATree(node^.right,c);
end;

procedure RTree(var root:ut;var inp:f);{Read Tree from file}
var c:int;
begin
while not eof(inp) do
  begin
    read(inp,c);
    ATree(root,c);
  end;
end;

procedure RT(var root:ut);{Right Turn}
var tmpl,tmplr,tmpn:ut;
begin
tmpn:=root;
tmpl:=root^.left;
tmplr:=root^.left^.right;
tmpn^.left:=tmplr;
root:=tmpl;
root^.right:=tmpn;
end;

procedure balance(var root,pred:ut); {Balance SubTree}
var b,lb,rb:int;
begin
lb:=0; rb:=0;
if root=nil then exit;

getDepth(root^.left,lb);
getDepth(root^.right,rb);
if(lb-rb)>1 then begin
  RT(root);
  pred^.left:=root
  end;
if(rb-lb)>1 then begin
  LT(root);
  pred^.right:=root;
  end;
if (root^.left<>nil)  then
  balance(root^.left,root);
if (root^.right<>nil) then
  balance(root^.right,root);
end;

procedure bestbalance(var root:ut);
var tmpl,tmpr,tmpn,tmplr,tmprl:ut;lb,rb:int;
begin
     rb:=0;
     lb:=0;
     balance(root^.left,root);
     balance(root^.right,root);
     getDepth(root^.left,lb);
     getDepth(root^.right,rb);
     if(lb-rb)>1 then
       begin
tmpn:=root;
tmpl:=root^.left;
tmplr:=root^.left^.right;
tmpn^.left:=tmplr;
root:=tmpl;
root^.right:=tmpn;
       end;
     if(rb-lb)>1 then
       begin
tmpn:=root;
tmpr:=root^.right;
tmprl:=root^.right^.left;
tmpn^.right:=tmprl;
root:=tmpr;
root^.left:=tmpn;
       end;
end;

var inp,out:text;
    root:ut;
    co:int;
    depth:longint;
begin
     assign(inp,'input1.txt');
     reset(inp);
     assign(out,'output.txt');
     rewrite(out);
     RTree(root,inp);{Read Tree from file}
     write(out,'NLR: ');
     nlr(root,out);{Node->Left->Right}
     BFS(root,out);{Breadth-First search - use google for info}
     bestbalance(root);{Start Balance}
     writeln(out);
     writeln(out,'----------------------------------------');
     write(out,'NLR: ');
     nlr(root,out);{N->L->R}
     BFS(root,out);{BFS}
     close(inp);
     close(out);
end.





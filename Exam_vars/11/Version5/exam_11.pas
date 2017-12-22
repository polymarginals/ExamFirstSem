program exam_11;
 type
   Tinf = record
     count, age : integer;
   end;
   Tree = ^rec;
   rec = record
     inf : Tinf;
     left, right, root : Tree;
     flag : boolean;
   end;

        procedure obhod(var f : text; root : Tree);
    var
       p : tree;
       xren : integer;

       procedure up(var p : tree);
       begin
          if not p^.flag then
            writeln(f, p^.inf.count, ' of ', p^.inf.age);
          p^.flag := true;
          p := p^.root;
       end;
       procedure endtree;
       begin
          repeat
             p := p^.right;
          until p^.right = nil;
          new(p^.right);
          p^.right^.inf.count := xren;
          p^.right^.flag := false;
          p := root;
       end;
    begin
       p := root;
       xren := -560;
       endtree;
       while p^.inf.count<>xren do
       begin
          if p^.left <> nil then
            begin
              if not p^.left^.flag then
                p := p^.left
              else begin
                if not p^.flag then
                  writeln(f, p^.inf.count, ' of ', p^.inf.age);
                p^.flag := true;
                if (p^.right <> nil) and (not p^.right^.flag) then
                  p := p^.right
                else
                  p := p^.root;
              end
          end
          else begin
            if p^.right <> nil then
              begin
              if not p^.right^.flag then
                p := p^.right
              else
                up(p);
            end
            else
              up(p);
          end;
       end;
    end;

        procedure init(var f : text; root : tree);
      procedure stand(a : integer; var p, root : tree);
      begin
         p^.inf.count := 1;
         p^.inf.age := a;
         p^.flag := false;
         p^.left := nil;
         p^.right := nil;
         p := root;
      end;
      procedure zero_pre(var p : tree);
      begin
         if p<>nil then
         begin
            p^.flag := false;
            zero_pre(p^.left);
            zero_pre(p^.right);
         end;
      end;
    var
       p : tree;
       name : string[10];
       a : integer;
       label
         iter;
    begin
       p := root;
       read(f, name);
       readln(f, p^.inf.age);
       p^.inf.count := 1;
       while not eof(f) do
       begin
          read(f, name);
          readln(f, a);
          iter :
          if (a > p^.inf.age) then
          begin
            if p^.right = nil then
            begin
               new(p^.right);
               p^.right^.root := p;
               p := p^.right;
               stand(a, p, root);
            end
            else begin
               p := p^.right;
               Goto iter;
            end;
          end
          else begin
            if (a < p^.inf.age) then
            begin
              if p^.left = nil then
              begin
                new(p^.left);
                p^.left^.root := p;
                p := p^.left;
                stand(a, p, root);
              end
              else begin
                p := p^.left;
                Goto iter;
              end;
            end
            else begin
              inc(p^.inf.count);
              p := root;
            end;
          end;
       end;
       p := root;
       zero_pre(p);
    end;

        procedure p3(a : integer; root : tree);
      procedure prefics (var a, count : integer; var p : tree);
      begin
         if p<>nil then
         begin
            if (p^.inf.age < a) then inc(count, p^.inf.count);
            prefics(a, count, p^.left);
            if (p^.inf.age < a) then prefics(a, count, p^.right);
         end
      end;
    var
       p : tree;
       count : integer;
    begin
       p := root;
       count := 0;
       prefics(a, count, p);
       writeln(count);
    end;

        procedure infics(var p : tree);
        begin
           if p<> nil then
           begin
              infics(p^.left);
              writeln(p^.inf.count, ' of ', p^.inf.age);
              infics(p^.right);
           end;
        end;

 var
   root, p : tree;
   f_inp, f_out : text;
   a : integer;
 begin
    assign(f_inp, 'input11.txt');   reset(f_inp);
    assign(f_out, 'output11.txt');  rewrite(f_out);
    new(root);
    root^.left := nil;
    root^.right := nil;
    a := 20;  p := root;

    init(f_inp, root);
{    infics(p);}
    obhod(f_out, root);
    p3(a, root);


    close(f_inp);
    close(f_out);
 end.

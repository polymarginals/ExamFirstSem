Type
  us=^sv;
  sv=record
    inf: string;
    next: us;
  end;

var
  ihead: us;
  head: us;
  input, output: text;
  error: boolean;

procedure reads(var input: text; var head: us);
  var
    uk: us;
    s: string;
    c: char;
begin
  head:= nil;
  s:='';
  read(input, c);
  while c<>' ' do
    begin
      s:=s+c;
      read(input,c);
    end;
  new(uk);
  uk^.inf:=s;
  head:=uk;
  uk^.next:=nil;

  while not eof(input) do
    begin
      s:='';
      read(input, c);
      while c<>' ' do
        begin
          s:=s+c;
          read(input,c);
        end;
      new(uk^.next);
      uk:=uk^.next;
      uk^.inf:=s;
    end;
  uk^.next:=nil;
end;

procedure writes(var output: text; head: us);
var
  uk: us;
begin
  uk:=head;
  while uk <> nil do begin
    write(output, uk^.inf, ' ');
    write(' ');
    uk:=uk^.next;
  end;
  writeln(output);
end;

procedure analysis(var output: text; sk: boolean; uk: us; i:integer; var error: boolean; var st: us);
var
   k, fb: boolean;
   c: char;
begin
  k:=FALSE;
  fb:=FALSE;
  while (uk<>nil) and ((uk^.inf <> ')') or ((uk^.inf = ')') and (sk = FALSE))) and (error <> TRUE) do
    begin
      fb:=FALSE;
      if k=FALSE then
        begin
          {CHECK}
          if (uk^.inf = '(') then
            begin
              if uk^.next^.inf = ')' then
                begin
                  writeln(output, 'Empty brackets found');
                  error:= TRUE;
                end
              else
                begin
                  analysis(output, TRUE, uk^.next,i+1,error, st);
                  uk:=st;
                  k:=TRUE;
                  fb:=FALSE;
                  if uk^.inf = ')' then
                     begin
                          k:=TRUE;
                          fb:=TRUE;
                     end;
                end;
            end
          else if (uk^.inf = 'TRUE') or (uk^.inf = 'FALSE') then
            begin
              k:=TRUE;
              fb:=TRUE;
            end
          else if (uk^.inf = 'NOT') then
            begin
              k:=FALSE;
              fb:=TRUE;
            end
          else for c:='A' to 'Z' do
            if uk^.inf = c then
              begin
                k:=TRUE;
                fb:=TRUE;
                break;
              end;
          {ERROR PART}
          if (fb= FALSE) and (error <> TRUE) then
            begin
              if sk=FALSE then
              write(output,'"(", ');
              write(output,'"A"..."Z", "TRUE", "FALSE" or "NOT" expected but ', uk^.inf, ' found');
              writeln(output);
              error:= TRUE;
            end;
        end
      else
        begin
          {CHECK}
          if (uk^.inf = 'AND') or (uk^.inf = 'OR') then
            begin
              k:=FALSE;
              fb:=TRUE;
            end;
          {ERROR PART}
          if (fb= FALSE) and (error <> TRUE) then
            begin
              if sk=TRUE then
              write(output,'")", ');
              write(output,'"OR", "AND" expected but ', uk^.inf, ' found');
              writeln(output);
              error:= TRUE;
            end;
        end;
    uk:=uk^.next;
    st:=uk;
    end;
    if (sk=TRUE) and (error<> TRUE) and (uk^.inf <> ')') then
      begin
        write(output, i, '-lvl bracket has not been closed');
        writeln(output);
        error:=TRUE;
      end;
end;

Begin
  assign(input,'input9.txt');
  reset(input);
  reads(input, head);
  close(input);

  assign(output,'output9.txt');
  rewrite(output);
  writes(output, head);

  error:=FALSE;
  ihead:=head;
  writeln(output);
  analysis(output, FALSE, head, 0, error, ihead);
  if error = FALSE then
    writeln(output, 'Expression is correct');
  close(output);
End.

var f: file of byte;
    b: byte;
    title, author: string;
    i: integer;

function scan(s: string):string;
 var k: integer;
  begin
    k:=31;
    for i:=1 to length(s) do
      begin
        if (s[i]=' ') and (s[i+1]=' ') or
           (s[i]=#0 ) and (s[i+1]=#0 ) then begin k:=i; i:=length(s); end;
      end;
    begin
      delete(s, k, 30);
      scan:=s;
    end;
  end;

procedure process;
 var g: text;
  begin
  b:=0;
  title:='';
  author:='';
  i:=0;
  read(f, b);
  if b=ord('T') then
    begin
      read(f, b);
      if b=ord('A') then
        begin
          read(f, b);
          if b=ord('G') then
            begin
             { === Read the title === }
              for i:=1 to 30 do
              begin
                read(f, b);
                title:=title+chr(b);
              end;
             { === Read the author === }
              for i:=1 to 30 do
              begin
                read(f, b);
                author:=author+chr(b);
              end;
            end;
        end;
    end;
  author:=scan(author);
  title:=scan(title);
  {$I-}
  assign(g, 'descript.ion');
  append(g);
  if ioresult<>0 then rewrite(g);
    writeln(g, paramstr(1),' ',author,': ',title);
  close(g);
  {$I+}
  end;

BEGIN
  {$I-}
  assign(f, paramstr(1));
  reset(f);
  seek(f, filesize(f)-128);
  process;
  close(f);
  {$I+}
END.
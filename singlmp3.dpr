{$APPTYPE CONSOLE}
Program Singlmp3;

uses
  windows, crt, sysutils;

Type  Mp3Tag = Record
        Header  : Array[1..3] of Char;
        Title   : Array[1..30] of Char;
        Author  : Array[1..30] of Char;
        Album   : Array[1..30] of Char;
        Year    : Array[1..4] of Char;
        Comment : Array[1..30] of Char;
        Style   : Byte;
      End;

var f: file of byte;
    g: TextFile;
    t: tsearchrec;
    title, author: string;
    i: integer;
    mt: Mp3Tag;

BEGIN
  {$I-}
  WriteLn('Mp3 descriptor program v1.0.1.6  -  Win32 Release');
  WriteLn('Copyright (c) 2000 by DeeJay');
  WriteLn;
  If ParamStr(1)<>'' Then
    Begin
      AssignFile(F, ParamStr(1));
      Reset(F);
      Seek(F, FileSize(F)-128);
      BlockRead(F, Mt, 128);
      AssignFile(G, 'descript.ion');
      Append(G);
      If IoResult<>0 Then ReWrite(g);
      Author:=Mt.Author;
      Title:=Mt.Title;
      While Pos(#0,  Author)<>0 Do Delete(Author, Pos(#0,  Author), Length(Author));
      While Pos('  ',Author)<>0 Do Delete(Author, Pos('  ',Author), Length(Author));
      While Pos(#0,  Title)<>0  Do Delete(Title,  Pos(#0,  Title),  Length(Title));
      While Pos('  ',Title)<>0  Do Delete(Title,  Pos('  ',Title),  Length(Title));
      WriteLn(G, '"'+T.name+'" '+Author+': '+Title);
      CloseFile(G);
      CloseFile(F);
    End
    Else WriteLn('Usage: filename.mp3');
  {$I+}
END.
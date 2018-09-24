{$APPTYPE CONSOLE}
program SinglRen;

uses
  Windows;

{$R *.RES}
Type  Mp3Tag = Record
        Header  : Array[1..3] of Char;// = 'TAG';
        Title   : Array[1..30] of Char;
        Author  : Array[1..30] of Char;
        Album   : Array[1..30] of Char;
        Year    : Array[1..4] of Char;
        Comment : Array[1..30] of Char;
        Style   : Byte;
      End;

Var F: File of Byte;
    NewName: String;
    Author, Title: String;
    Mt: Mp3Tag;

begin
  {$I-}
  If ParamStr(1)<>'' Then
  Begin
    AssignFile(F, ParamStr(1));
    Reset(F);
    Seek(F, FileSize(F)-128);
    BlockRead(F, Mt, 128);
    Author:=Mt.Author;
    Title:=Mt.Title;
    While Pos(#0,Author)<>0 Do Delete(Author, Pos(#0,Author), Length(Author));
    While Pos(#0,Title)<>0 Do Delete(Title, Pos(#0,Title), Length(Title));
    NewName:=Author+' - '+Title+'.mp3';
    CloseFile(F);
    Rename(F, NewName);
  End
  Else
    Begin
      WriteLn('Single Mp3 Renamer By The Mp3 TAG v1.0.1.2  -  Win32 Release');
      WriteLn('Copyright (c) 2000 by DeeJay');
      WriteLn;
      WriteLn('Usage: SRen.exe filename.mp3');
      WriteLn;
    End;
  {$I+}
end.

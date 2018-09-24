{$APPTYPE CONSOLE}
program SinglTag;

uses
  Windows, Crt;

Type  Mp3Tag = Record
        Header  : Array[1..3] of Char;// = 'TAG';
        Title   : Array[1..30] of Char;
        Author  : Array[1..30] of Char;
        Album   : Array[1..30] of Char;
        Year    : Array[1..4] of Char;
        Comment : Array[1..30] of Char;
        Style   : Byte;
      End;

Var F: File Of Byte;
    Tag: Boolean;
    Author, Title: String;
    Mt : Mp3Tag;
    S, T: String;
    I: Integer;

{$R *.RES}

Begin
  If ParamStr(1)<>'' Then
  Begin
    AssignFile(F, ParamStr(1));
    Reset(F);
    Seek(F, FileSize(F)-128);
    BlockRead(F, Mt, 128);
    If Mt.Header='TAG' Then Tag:=True;
    If Pos(' - ',ParamStr(1))<>0 Then
      Begin
        Author:=Copy(ParamStr(1), 1, Pos(' - ',ParamStr(1))-1);
        Title:=Copy(ParamStr(1), Pos(' - ',ParamStr(1))+3, Length(ParamStr(1))-6-Pos(' - ',ParamStr(1)));
      End;
    For I:=1 To 30 Do Mt.Title[I]:=#0;
    For I:=1 To Length(Title) Do Mt.Title[I]:=Title[I];

    For I:=1 To 30 Do Mt.Author[I]:=#0;
    For I:=1 To Length(Author) Do Mt.Author[I]:=Author[I];

    For I:=1 To 30 Do Mt.Album[I]:=#0;
    For I:=1 To 30 Do Mt.Comment[I]:=#0;
    Mt.Header:='TAG';
    Mt.Style:=255;
    Mt.Year:=#0+#0+#0+#0;
    If Not Tag Then
      Seek(F, FileSize(F))
    Else
      Seek(F, FileSize(F)-128);
    BlockWrite(F, Mt, 128);
    CloseFile(F);
  End
  Else
    Begin
      WriteLn('ParamError.')
    End;
End.

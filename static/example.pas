unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  point=record
  x:real;
  y:real;
  z:real;
  end;
var
  Form1: TForm1;
  mass: array[1..2000000]of point;
  xn,yn,zn,u,v,a,b,c,t,xr,yr,zr: real;
  i,i1,i2,i3,i4,k:longword;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form1.Canvas.FillRect(Bounds(0,0,10000,10000));
  c:=0.5;
  a:=6;
  b:=6;
  xn:=400;
  yn:=300;
  zn:=40;
  Form1.Canvas.Brush.Color:=Form1.Color;
  Form1.Canvas.Pen.Width:=1;
  Form1.Canvas.Pen.Color:=clBlack;

  u:=6;
  v:=6;




  i:=1;
   while u<15 do begin
     v:=0;
     while v<360 do begin
       mass[i].x:=u*80/a*cos(v*3.14/180);
       mass[i].z:=u*80/b*sin(v*3.14/180);
       mass[i].y:=c*u*u-20;
       v:=v+1;
       i:=i+1;
     end;
     u:=u+0.3;
   end;

   i1:=i;
   u:=11;
    while u<15 do begin
     v:=0;
     while v<360 do begin
       mass[i].x:=a*u*cos(v*3.14/180)*u*u*u/2500;
       mass[i].z:=b*u*sin(v*3.14/180)*u*u*u/2500;
       mass[i].y:=c*u*u+115;
       v:=v+1;
       i:=i+1;
     end;
     u:=u+0.1;
   end;

   i2:=i;
   u:=7;

   while u<15 do begin
     v:=0;
     while v<360 do begin
       mass[i].x:=a*u*cos(v*3.14/180);
       mass[i].z:=b*u*sin(v*3.14/180);
       mass[i].y:=-c*u*u+200;
       v:=v+1;
       i:=i+1;
     end;
     u:=u+0.1;
   end;

   i3:=i;
   for i:=i3 to i3+80 do begin
     mass[i].y:=mass[i-1].y+1;
     mass[i].x:=mass[i-1].x;
     mass[i].z:=mass[i-1].z;

   end;
    i4:=i;




   for k:=1 to i1 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clRed;
   end;
   for k:=i1 to i2 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlue;
   end;
   for k:=i2 to i3 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlue;
   end;
   for k:=i3 to i4 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlack;
   end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  xr:=strtofloat(Edit4.text)/180;
  yr:=strtofloat(Edit5.text)/180;
  zr:=strtofloat(Edit6.text)/180;
  Form1.Canvas.FillRect(Bounds(0,0,10000,10000));
  for k:=1 to i do begin
    if (xr<>0) then begin t:=mass[k].y;mass[k].y:=mass[k].y*cos(xr)-mass[k].z*sin(xr);mass[k].z:=t*sin(xr)+mass[k].z*cos(xr);end;
    if (yr<>0) then begin t:=mass[k].x;mass[k].x:=mass[k].x*cos(yr)+mass[k].z*sin(yr);mass[k].z:=mass[k].z*cos(yr)-sin(yr)*t;end;
    if (zr<>0) then begin t:=mass[k].x;mass[k].x:=mass[k].x*cos(zr)-mass[k].y*sin(zr);mass[k].y:=t*sin(zr)+mass[k].y*cos(zr);end;

  end;
  for k:=1 to i1 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clRed;
   end;
   for k:=i1 to i2 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlue;
   end;
   for k:=i2 to i3 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlue;
   end;
   for k:=i3 to i4 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlack;
   end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  xr:=strtofloat(Edit4.text);
  yr:=strtofloat(Edit5.text);
  zr:=strtofloat(Edit6.text);
  Form1.Canvas.FillRect(Bounds(0,0,10000,10000));
   for k:=1 to i do begin
   if (xr<>0) then mass[k].x:=mass[k].x*xr;
   if (yr<>0) then mass[k].y:=mass[k].y*yr;
   if (zr<>0) then mass[k].z:=mass[k].z*zr;
   end;
    for k:=1 to i1 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clRed;
   end;
   for k:=i1 to i2 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlue;
   end;
   for k:=i2 to i3 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlue;
   end;
   for k:=i3 to i4 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlack;
   end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  xr:=strtofloat(Edit4.text);
  yr:=strtofloat(Edit5.text);
  zr:=strtofloat(Edit6.text);

  Form1.Canvas.FillRect(Bounds(0,0,10000,10000));
  for k:=1 to i do begin
    if (xr<>0) then mass[k].x:=mass[k].x+xr;
    if (yr<>0) then mass[k].y:=mass[k].y+yr;
    if (zr<>0) then mass[k].z:=mass[k].z+zr;
  end;

  for k:=1 to i1 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clRed;
   end;
   for k:=i1 to i2 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlue;
   end;
   for k:=i2 to i3 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlue;
   end;
   for k:=i3 to i4 do   begin
     Form1.Canvas.Pixels[round(xn+mass[k].x),round(yn+mass[k].y)]:=clBlack;
   end;
end;

end.

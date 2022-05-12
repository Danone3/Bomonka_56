unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, Math,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  a, b, a0, b0, k: integer;

  buf: tpoint;

  Brdr: array [0..3] of classes.TPoint;
  Crd: array [0..200] of classes.TPoint;
  FcTp: array [0..50] of classes.Tpoint;
  FcCnt: array [0..70] of classes.Tpoint;
  Ear: array [0..15] of classes.TPoint;
  Focus: array [0..100] of classes.TPoint;
  Eye: array [0..15] of classes.TPoint;
  FcBt: array [0..100] of classes.TPoint;
  Ell: array [0..15] of classes.TPoint;

  IBrdr: array [0..3] of classes.TPoint;
  ICrd: array [0..200] of classes.TPoint;
  IFcTp: array [0..50] of classes.Tpoint;
  IFcCnt: array [0..70] of classes.Tpoint;
  IEar: array [0..15] of classes.TPoint;
  IFocus: array [0..100] of classes.TPoint;
  IEye: array [0..15] of classes.TPoint;
  IFcBt: array [0..100] of classes.TPoint;

implementation

{$R *.lfm}

{ TForm1 }

function proppoint(p1,p2:classes.Tpoint; c1, c2:integer):classes.TPoint;
begin
  Result.x:=Round(((c1*p1.x) + (c2*p2.x))/(c1+c2));
  Result.y:=Round(((c1*p1.y) + (c2*p2.y))/(c1+c2));
end;

  Function Scalar(T, V: classes.TPoint): double;
  begin
    Result:=T.x*V.x + T.y*V.y
  end;

  function ModuleVect(M, N: classes.Tpoint): double;
  begin
    Result:=sqrt(sqr(M.x-N.x)+sqr(M.y-N.y))
  end;

  function GeronVector(A, B, C: classes.Tpoint): double;
  var
    l1, l2, l3, hp:double;
  begin
    l1:=ModuleVect(A, B);
    l2:=ModuleVect(B, C);
    l3:=ModuleVect(C, A);
    hp:= 0.5*(l1+l2+l3);
    Result:=sqrt(hp*(hp-l1)*(hp-l2)*(hp-l3));
  end;

 Function Simm(A, B, N: classes.tPoint): classes.TPoint;
 var
   Sy, Norm, t: classes.TPoint;
   K, h: double;
 begin
   t.x:=B.x-A.x;
   t.y:=B.y-A.y;

   Sy.X:=B.x-A.x;
   Sy.y:=B.y-A.y;

   Norm.x:= - Sy.x;
   Norm.y:= Sy.y;

   if Scalar(Norm, t) < 0 then
   Norm:=Point(-Norm.x, -Norm.y);

   K:=GeronVector(A, B, N);

   h:=2*K/ModuleVect(A, B);

   Result.x:=Round(N.x + 2*Norm.x*h/ModuleVect(Norm, Point(0, 0)));
   Result.y:=Round(N.y + 2*Norm.y*h/ModuleVect(Norm, Point(0, 0)));
 end;

procedure TForm1.Button1Click(Sender: TObject);
var
  R1, R2, len, i: integer;
begin
  a0:=1;
  b0:=1;
  a:=3*b0;
  b:=3*b0;
  k:=3;
  R1:=5;
  R2:=3;
  paintbox1.Canvas.Pen.Color:=clblack;
  paintbox1.canvas.Pen.Width:=1;
  paintbox1.canvas.brush.color:=clwhite;
  {рамка}
  Brdr[0]:=point(a,b);
  Brdr[1]:=point(a+k*192,b);
  Brdr[2]:=point(a+k*192,b+k*276);
  Brdr[3]:=point(a,b+k*276);

  {координаты}

  begin
  Crd[0]:=proppoint(Brdr[0], Brdr[1], 96, 96);
  Crd[1]:=proppoint(Brdr[2], Brdr[3], 96, 96);
  Crd[2]:=proppoint(Brdr[2], Brdr[1], 122, 154);
  Crd[3]:=proppoint(Brdr[3], Brdr[0], 82, 194);
  Crd[4]:=proppoint(Brdr[2], Brdr[1], 102, 174);
  FcCnt[0]:=proppoint(Crd[2], Crd[3], 146, 50);
  FcCnt[1]:=proppoint(Crd[4], Crd[3], 144, 49);
  Crd[5]:=proppoint(Brdr[1], Brdr[0], 130, 62);
  Ear[0]:=proppoint(Crd[2], Crd[3], 1565, 395);
  Crd[6]:=proppoint(Brdr[2], Brdr[3], 43, 149);
  Ear[1]:=proppoint(Crd[6], Crd[2], 715, 1415);
  Ear[2]:=proppoint(Crd[5], Crd[2], 935, 430);
  Crd[7]:=proppoint(Brdr[2], Brdr[1], 1215, 1545);
  Crd[8]:=proppoint(Brdr[0], Brdr[3], 93, 183);
  Ear[3]:=proppoint(Crd[8], Crd[7], 495, 1480);
  Ear[4]:=proppoint(Crd[7], Crd[8], 1430, 525);
  Ear[5]:=proppoint(Crd[3], Crd[2], 43, 153);
  Ear[6]:=proppoint(Crd[3], Crd[2], 41, 155);
  Crd[9]:=proppoint(Brdr[0], Brdr[3], 145, 131);
  Ear[7]:=proppoint(Crd[9], Crd[2], 445, 1475);
  Ear[8]:=proppoint(Crd[9], Crd[2], 495, 1405);
  Crd[10]:=proppoint(Brdr[3], Brdr[2], 1395, 525);
  FcCnt[2]:=proppoint(Crd[10], Crd[4], 92, 130);
  Crd[11]:=proppoint(Brdr[3], Brdr[2], 157, 35);
  FcCnt[3]:=proppoint(Crd[11], Crd[7], 110, 104);
  FcCnt[4]:=proppoint(Crd[0], Ear[5], 750, 525);
  FcCnt[5]:=proppoint(Crd[0], Ear[6], 190, 1075);
  Crd[12]:=proppoint(Brdr[0], Brdr[3], 46, 230);
  Crd[13]:=proppoint(Brdr[0], Brdr[3], 2, 274);
  Crd[14]:=proppoint(Brdr[0], Brdr[3], 172, 104);
  Crd[15]:=proppoint(Brdr[0], Brdr[3], 77, 199);
  Crd[16]:=proppoint(Brdr[0], Brdr[1], 67, 125);
  FcCnt[6]:=proppoint(Crd[4], Crd[15], 1590, 555);
  FcCnt[10]:=proppoint(Crd[16], FcCnt[3], 280, 1725);
  FcCnt[7]:=proppoint(Crd[14], Crd[4], 485, 1430);
  FcCnt[8]:=proppoint(Crd[1], Crd[16], 175, 102);
  FcCnt[9]:=proppoint(Crd[1], Crd[16], 1795, 975);
  Crd[17]:=proppoint(Brdr[1], Brdr[2], 263, 13);
  FcCnt[11]:=proppoint(Crd[3], Crd[17], 835, 1200);
  FcCnt[12]:=proppoint(Crd[0], Crd[1], 2355, 395);
  FcCnt[13]:=proppoint(Crd[0], Crd[1], 69, 209);
  Crd[18]:=proppoint(Brdr[1], Brdr[2], 220, 55);
  Crd[19]:=proppoint(Brdr[0], Brdr[3], 32, 243);
  Eye[0]:=proppoint(Crd[18], Crd[19], 173, 95);
  Eye[1]:=proppoint(Crd[18], Crd[19], 171, 97);
  Eye[2]:=proppoint(Crd[18], Crd[19], 1685, 995);
  Crd[20]:=proppoint(Brdr[1], Brdr[2], 192, 84);
  Crd[21]:=proppoint(Brdr[0], Brdr[3], 67, 209);
  Eye[3]:=proppoint(Crd[20], Crd[21], 161, 67);
  Eye[4]:=proppoint(Crd[20], Crd[21], 1575, 700);
  Eye[5]:=proppoint(Crd[20], Crd[21], 155, 72);
  Crd[22]:=proppoint(Brdr[2], Brdr[3], 235, 1685);
  Eye[6]:=proppoint(Crd[17], Crd[22], 1730, 1385);
  Eye[7]:=proppoint(Crd[17], Crd[22], 1710, 1405);
  Eye[8]:=proppoint(Crd[17], Crd[22], 1695, 1420);
  Eye[9]:=proppoint(Crd[17], Crd[22], 1680, 1435);
  Eye[10]:=proppoint(Crd[4], Crd[8], 147, 61);
  Crd[23]:=proppoint(Brdr[2], Brdr[3], 75, 1845);
  FcTp[0]:=proppoint(Brdr[1], Crd[23], 1915, 1390);
  FcTp[1]:=proppoint(Brdr[1], Crd[23], 181, 149);
  FcTp[2]:=proppoint(Crd[17], Crd[3], 1200, 845);
  Crd[24]:=proppoint(Brdr[0], Brdr[3], 228, 48);
  Crd[25]:=proppoint(Brdr[1], Brdr[2], 720, 2035);
  FcTp[3]:=proppoint(Crd[24], Crd[25], 107, 138);
  FcTp[4]:=proppoint(Crd[24], Crd[25], 114, 133);
  FcTp[5]:=proppoint(FcCnt[0], Crd[0], 46, 74);
  FcTp[6]:=proppoint(Crd[18], Crd[9], 1325, 780);
  FcTp[7]:=proppoint(Crd[18], Crd[9], 1320, 785);
  FcTp[8]:=proppoint(Crd[0], Brdr[2], 213, 78);
  FcTp[9]:=proppoint(Crd[19], Crd[18], 890, 1785);
  FcTp[10]:=proppoint(Crd[9], Crd[18], 69, 143);
  FcTp[11]:=proppoint(Crd[0], Ear[0], 50, 77);
  FcTp[12]:=proppoint(Crd[5], FcTp[11], 17, 55);
  Crd[26]:=proppoint(Brdr[1], Brdr[2], 198, 78);
  Crd[27]:=proppoint(Brdr[0], Brdr[3], 219, 57);
  Crd[28]:=proppoint(Brdr[0], Brdr[3], 198, 78);
  FcTp[13]:=proppoint(Crd[26], Crd[27], 131, 59);
  FcTp[14]:=proppoint(Crd[26], Crd[27], 129, 64);
  FcTp[15]:=proppoint(Crd[26], Crd[28], 1315, 590);
  FcTp[16]:=proppoint(Crd[26], Crd[28], 1285, 640);
  FcTp[17]:=proppoint(Crd[2], Crd[3], 143, 57);
  FcTp[18]:=proppoint(Crd[26], Crd[27], 1410, 515);
  FcTp[19]:=proppoint(Crd[4], Crd[14], 1350, 525);
  FcBt[0]:=proppoint(Crd[10], Crd[4], 115, 110);
  FcBt[1]:=proppoint(Crd[11], Crd[26], 126, 126);
  FcBt[2]:=proppoint(Crd[22], Crd[7], 1105, 1115);
  FcBt[3]:=proppoint(Crd[2], Crd[22], 130, 99);
  FcBt[4]:=proppoint(Crd[4], Crd[6], 1280, 1005);
  FcBt[5]:=proppoint(Crd[1], Crd[0], 175, 101);
  FcBt[6]:=proppoint(Crd[1], Crd[0], 180, 97);
  FcBt[7]:=proppoint(FcCnt[10], Crd[25], 80, 3);
  FcBt[8]:=proppoint(FcCnt[10], Crd[25], 67, 16);
  FcBt[9]:=proppoint(FcCnt[10], Crd[25], 74, 9);
  FcBt[10]:=proppoint(FcCnt[10], Crd[25], 72, 12);
  FcBt[11]:=proppoint(Crd[7], Crd[15], 1400, 635);
  FcBt[12]:=proppoint(Crd[7], Crd[15], 1385, 645);
  Crd[29]:=proppoint(Brdr[1], Brdr[2], 192, 68);
  FcBt[13]:=proppoint(Crd[29], Crd[22], 163, 99);
  FcBt[14]:=proppoint(Crd[29], Crd[22], 143, 120);
  FcBt[15]:=proppoint(Crd[29], Crd[22], 160, 102);
  FcBt[16]:=proppoint(Crd[29], Crd[22], 146, 117);
  Crd[30]:=proppoint(Brdr[3], Brdr[2], 1115, 805);
  FcBt[17]:=proppoint(Crd[17], Crd[30], 1275, 1570);
  FcBt[18]:=proppoint(Crd[17], Crd[30], 1205, 1640);
  FcBt[19]:=proppoint(Crd[17], Crd[30], 114, 171);
  Crd[31]:=proppoint(Brdr[3], Brdr[2], 815, 1105);
  Crd[32]:=proppoint(Brdr[0], Brdr[1], 285, 1635);
  FcBt[20]:=proppoint(Crd[31], Crd[32], 1610, 1195);
  FcBt[21]:=proppoint(Crd[31], Crd[32], 1685, 1120);
  FcBt[22]:=proppoint(Crd[31], Crd[32], 1750, 1055);
  FcBt[23]:=proppoint(Crd[1], Crd[0], 2025, 775);
  Ell[0]:=point(FcBt[23].x-k*R2, FcBt[23].y-k*R2);
  Ell[1]:=point(FcBt[23].x+k*R2, FcBt[23].y+k*R2);
  Ell[2]:=point(FcBt[23].x-k*R1, FcBt[23].y-k*R1);
  Ell[3]:=point(FcBt[23].x+k*R1, FcBt[23].y+k*R1);
  FcBt[24]:=proppoint(Crd[1], Crd[0], 1940, 885);
  FcBt[25]:=proppoint(Crd[6], Ear[6], 910, 1035);
   end;

  {фокусы}
  begin
  Focus[0]:=point((128-1+a0)*k, (192-1+b0)*k);
  Focus[1]:=point((113-1+a0)*k, (202-1+b0)*k);
  Focus[2]:=point((146-1+a0)*k, (85-1+b0)*k);
  Focus[3]:=point((140-1+a0)*k, (51-1+b0)*k);
  Focus[4]:=point((141-1+a0)*k, (145-1+b0)*k);
  Focus[5]:=point((120-1+a0)*k, (153-1+b0)*k);
  Focus[6]:=point((137-1+a0)*k, (124-1+b0)*k);
  Focus[7]:=point((105-1+a0)*k, (120-1+b0)*k);
  Focus[8]:=point((105-1+a0)*k, (200-1+b0)*k);
  Focus[9]:=point((107-1+a0)*k, (184-1+b0)*k);
  Focus[10]:=point((102-1+a0)*k, (209-1+b0)*k);
  Focus[11]:=point((111-1+a0)*k, (205-1+b0)*k);
  Focus[12]:=point((131-1+a0)*k, (130-1+b0)*k);
  Focus[13]:=point((132-1+a0)*k, (132-1+b0)*k);
  Focus[14]:=point((127-1+a0)*k, (129-1+b0)*k);
  Focus[15]:=point((128-1+a0)*k, (130-1+b0)*k);
  Focus[16]:=point((136-1+a0)*k, (142-1+b0)*k);
  Focus[17]:=point((107-1+a0)*k, (150-1+b0)*k);
  Focus[18]:=point((112-1+a0)*k, (91-1+b0)*k);
  Focus[19]:=point((104-1+a0)*k, (107-1+b0)*k);
  Focus[20]:=point((113-1+a0)*k, (91-1+b0)*k);
  Focus[21]:=point((143-1+a0)*k, (90-1+b0)*k);
  Focus[22]:=point((139-1+a0)*k, (100-1+b0)*k);
  Focus[23]:=point((120-1+a0)*k, (193-1+b0)*k);
  Focus[24]:=point((113-1+a0)*k, (199-1+b0)*k);
  Focus[25]:=point((132-1+a0)*k, (172-1+b0)*k);
  Focus[26]:=point((134-1+a0)*k, (152-1+b0)*k);
  Focus[27]:=point((128-1+a0)*k, (172-1+b0)*k);
  Focus[28]:=point((132-1+a0)*k, (152-1+b0)*k);
  Focus[29]:=point((130-1+a0)*k, (172-1+b0)*k);
  Focus[30]:=point((133-1+a0)*k, (152-1+b0)*k);
  Focus[31]:=point((125-1+a0)*k, (166-1+b0)*k);
  Focus[32]:=point((129-1+a0)*k, (162-1+b0)*k);
  Focus[33]:=point((121-1+a0)*k, (165-1+b0)*k);
  Focus[34]:=point((127-1+a0)*k, (162-1+b0)*k);
  end;

  {сама программа}
  begin
  paintbox1.Canvas.polygon([Brdr[0], Brdr[1], Brdr[2], Brdr[3]]);
  paintbox1.Canvas.Pen.Color:=clblack;

  paintbox1.canvas.Pen.Width:=4;
  paintbox1.Canvas.polygon([FcCnt[0], Ear[1], Ear[0], Ear[2]]);

  paintbox1.Canvas.polygon([Ear[4], Ear[3], Ear[5], Ear[2]]);

  paintbox1.canvas.Pen.Width:=0;

  paintbox1.Canvas.moveto(Ear[1]);
  paintbox1.Canvas.lineto(Ear[6]);
  paintbox1.Canvas.lineto(Ear[2]);

  paintbox1.Canvas.moveto(Ear[7]);
  paintbox1.Canvas.lineto(Ear[8]);
  paintbox1.Canvas.moveto(FcCnt[0]);
  paintbox1.canvas.Pen.Width:=5;
  paintbox1.Canvas.lineto(FcCnt[1]);
  paintbox1.Canvas.moveto(Ear[8]);

  paintbox1.Canvas.lineto(FcCnt[2]);

  paintbox1.Canvas.PolyBezier([FcCnt[2], Focus[0], Focus[1], FcCnt[3]]);



  paintbox1.Canvas.PolyBezier([FcCnt[5], Focus[2], Focus[3], FcCnt[4]]);



  paintbox1.Canvas.PolyBezier([FcCnt[6], Focus[4], Focus[5], FcCnt[10]]);


  paintbox1.Canvas.PolyBezier([FcCnt[7], Focus[6], Focus[7], FcCnt[8]]);


  paintbox1.Canvas.PolyBezier([FcCnt[9], Focus[9], Focus[8], FcCnt[3]]);
  paintbox1.Canvas.moveto(FcCnt[0]);
  paintbox1.Canvas.lineto(FcCnt[6]);


  paintbox1.Canvas.moveto(FcCnt[4]);
  paintbox1.Canvas.lineto(FcCnt[11]);

  paintbox1.Canvas.moveto(FcCnt[11]);
  paintbox1.Canvas.lineto(FcCnt[12]);


  paintbox1.Canvas.PolyBezier([FcCnt[13], Focus[10], Focus[11], FcCnt[3]]);

  paintbox1.canvas.Pen.Width:=2;
  paintbox1.Canvas.moveto(Eye[0]);
  paintbox1.Canvas.lineto(Eye[3]);
  paintbox1.canvas.Pen.Width:=3;
  paintbox1.Canvas.moveto(Eye[1]);
  paintbox1.Canvas.lineto(Eye[4]);
  paintbox1.canvas.Pen.Width:=1;
  paintbox1.Canvas.moveto(Eye[2]);
  paintbox1.Canvas.lineto(Eye[5]);
  paintbox1.Canvas.moveto(Eye[3]);
  paintbox1.Canvas.lineto(Eye[4]);


  paintbox1.Canvas.PolyBezier([Eye[3], Focus[12], Focus[12], Eye[8]]);

  paintbox1.Canvas.PolyBezier([Eye[10], Focus[13], Focus[13], Eye[9]]);

  paintbox1.Canvas.PolyBezier([Eye[5], Focus[14], Focus[14], Eye[6]]);
  paintbox1.canvas.Pen.Width:=3;

  paintbox1.Canvas.PolyBezier([Eye[4], Focus[15], Focus[15], Eye[7]]);
  paintbox1.canvas.Pen.Width:=3;

  paintbox1.Canvas.PolyBezier([Eye[3], Focus[16], Focus[17], FcCnt[8]]);
  paintbox1.canvas.brush.color:=clblack;
  paintbox1.Canvas.FloodFill(134*k, 127*k, clblack, fsBorder);

  paintbox1.Canvas.moveto(FcCnt[4]);
  paintbox1.Canvas.lineto(FcTp[0]);
  paintbox1.Canvas.lineto(FcTp[1]);

  paintbox1.canvas.Pen.Width:=1;
  paintbox1.Canvas.moveto(FcTp[2]);
  paintbox1.Canvas.lineto(FcTp[3]);

  paintbox1.Canvas.lineto(FcTp[5]);
  paintbox1.Canvas.FloodFill(114*k, 45*k, clblack, fsBorder);


  paintbox1.Canvas.PolyBezier([FcTp[7], Focus[18], Focus[19], FcTp[4]]);

  paintbox1.Canvas.PolyBezier([FcTp[6], Focus[20], Focus[19], FcTp[4]]);

  paintbox1.Canvas.moveto(FcTp[6]);
  paintbox1.Canvas.lineto(FcTp[8]);
  paintbox1.Canvas.lineto(FcTp[7]);

  paintbox1.canvas.Pen.Width:=3;
  paintbox1.Canvas.moveto(FcTp[9]);
  paintbox1.Canvas.lineto(FcTp[10]);

  paintbox1.Canvas.moveto(FcTp[11]);
  paintbox1.Canvas.lineto(FcTp[12]);
  paintbox1.canvas.Pen.Width:=2;
  paintbox1.canvas.brush.color:=clwhite;

  paintbox1.Canvas.polygon([FcTp[10], FcTp[16], FcTp[14], FcTp[11], FcTp[13], FcTp[15]]);


  paintbox1.Canvas.PolyBezier([FcTp[17], Focus[22], Focus[21], FcTp[18]]);

  paintbox1.canvas.Pen.Width:=1;
  paintbox1.Canvas.moveto(FcCnt[1]);
  paintbox1.Canvas.lineto(FcTp[19]);
  paintbox1.canvas.Pen.Width:=2;

  paintbox1.Canvas.moveto(FcBt[1]);
  paintbox1.Canvas.lineto(FcBt[0]);


  paintbox1.Canvas.PolyBezier([FcBt[0], Focus[23], Focus[24], FcBt[2]]);

  paintbox1.Canvas.moveto(FcBt[3]);
  paintbox1.Canvas.lineto(FcBt[4]);

  paintbox1.canvas.Pen.Width:=5;
  paintbox1.Canvas.PolyBezier([FcBt[1], FcCnt[9], FcCnt[9], FcBt[6]]);
  paintbox1.Canvas.PolyBezier([FcCnt[10], FcCnt[8], FcCnt[8], FcBt[5]]);

  paintbox1.Canvas.moveto(FcBt[1]);
  paintbox1.Canvas.lineto(FcBt[7]);

  paintbox1.Canvas.lineto(FcBt[8]);


  paintbox1.Canvas.PolyBezier([FcBt[8], Focus[25], Focus[26], FcBt[11]]);

  paintbox1.Canvas.PolyBezier([FcBt[9], Focus[27], Focus[28], FcBt[12]]);
  paintbox1.canvas.Pen.Width:=1;

  paintbox1.Canvas.PolyBezier([FcBt[10], Focus[29], Focus[30], FcBt[11]]);


  paintbox1.Canvas.PolyBezier([FcBt[13], Focus[32], Focus[31], FcBt[14]]);
  paintbox1.canvas.Pen.Width:=2;

  paintbox1.Canvas.PolyBezier([FcBt[15], Focus[34], Focus[33], FcBt[16]]);
  paintbox1.canvas.Pen.Width:=3;
  paintbox1.Canvas.moveto(FcCnt[10]);
  paintbox1.Canvas.lineto(FcBt[1]);

  paintbox1.canvas.Pen.Width:=2;
  paintbox1.Canvas.moveto(FcBt[17]);
  paintbox1.Canvas.lineto(FcBt[20]);
  paintbox1.Canvas.moveto(FcBt[18]);
  paintbox1.Canvas.lineto(FcBt[21]);
  paintbox1.Canvas.moveto(FcBt[19]);
  paintbox1.Canvas.lineto(FcBt[22]);
  paintbox1.canvas.Pen.Width:=4;

  paintbox1.Canvas.Ellipse(Ell[2].X, Ell[2].y, Ell[3].x, Ell[3].y);
  paintbox1.canvas.Pen.Width:=2;

  paintbox1.Canvas.Ellipse(Ell[0].X, Ell[0].y, Ell[1].x, Ell[1].y);
  paintbox1.canvas.Pen.Width:=3;

  paintbox1.Canvas.moveto(FcBt[24]);
  paintbox1.Canvas.lineto(FcBt[25]);
  end;

  Buf:= Brdr[0];
  brdr[0]:= brdr[1];
  Brdr[1]:= buf;

  Buf:= Brdr[2];
  brdr[2]:= brdr[3];
  Brdr[3]:= buf;

  len:=length(Focus);
  i:=0;

  while i < len-1 do
  begin
  Focus[i].x:=(Round(k*192/2)-Round(Focus[i].x-k*192/2));
  i:=i+1;

  end;


  begin
  Crd[0]:=proppoint(Brdr[0], Brdr[1], 96, 96);
  Crd[1]:=proppoint(Brdr[2], Brdr[3], 96, 96);
  Crd[2]:=proppoint(Brdr[2], Brdr[1], 122, 154);
  Crd[3]:=proppoint(Brdr[3], Brdr[0], 82, 194);
  Crd[4]:=proppoint(Brdr[2], Brdr[1], 102, 174);
  FcCnt[0]:=proppoint(Crd[2], Crd[3], 146, 50);
  FcCnt[1]:=proppoint(Crd[4], Crd[3], 144, 49);
  Crd[5]:=proppoint(Brdr[1], Brdr[0], 130, 62);
  Ear[0]:=proppoint(Crd[2], Crd[3], 1565, 395);
  Crd[6]:=proppoint(Brdr[2], Brdr[3], 43, 149);
  Ear[1]:=proppoint(Crd[6], Crd[2], 715, 1415);
  Ear[2]:=proppoint(Crd[5], Crd[2], 935, 430);
  Crd[7]:=proppoint(Brdr[2], Brdr[1], 1215, 1545);
  Crd[8]:=proppoint(Brdr[0], Brdr[3], 93, 183);
  Ear[3]:=proppoint(Crd[8], Crd[7], 495, 1480);
  Ear[4]:=proppoint(Crd[7], Crd[8], 1430, 525);
  Ear[5]:=proppoint(Crd[3], Crd[2], 43, 153);
  Ear[6]:=proppoint(Crd[3], Crd[2], 41, 155);
  Crd[9]:=proppoint(Brdr[0], Brdr[3], 145, 131);
  Ear[7]:=proppoint(Crd[9], Crd[2], 445, 1475);
  Ear[8]:=proppoint(Crd[9], Crd[2], 495, 1405);
  Crd[10]:=proppoint(Brdr[3], Brdr[2], 1395, 525);
  FcCnt[2]:=proppoint(Crd[10], Crd[4], 92, 130);
  Crd[11]:=proppoint(Brdr[3], Brdr[2], 157, 35);
  FcCnt[3]:=proppoint(Crd[11], Crd[7], 110, 104);
  FcCnt[4]:=proppoint(Crd[0], Ear[5], 750, 525);
  FcCnt[5]:=proppoint(Crd[0], Ear[6], 190, 1075);
  Crd[12]:=proppoint(Brdr[0], Brdr[3], 46, 230);
  Crd[13]:=proppoint(Brdr[0], Brdr[3], 2, 274);
  Crd[14]:=proppoint(Brdr[0], Brdr[3], 172, 104);
  Crd[15]:=proppoint(Brdr[0], Brdr[3], 77, 199);
  Crd[16]:=proppoint(Brdr[0], Brdr[1], 67, 125);
  FcCnt[6]:=proppoint(Crd[4], Crd[15], 1590, 555);
  FcCnt[10]:=proppoint(Crd[16], FcCnt[3], 280, 1725);
  FcCnt[7]:=proppoint(Crd[14], Crd[4], 485, 1430);
  FcCnt[8]:=proppoint(Crd[1], Crd[16], 175, 102);
  FcCnt[9]:=proppoint(Crd[1], Crd[16], 1795, 975);
  Crd[17]:=proppoint(Brdr[1], Brdr[2], 263, 13);
  FcCnt[11]:=proppoint(Crd[3], Crd[17], 835, 1200);
  FcCnt[12]:=proppoint(Crd[0], Crd[1], 2355, 395);
  FcCnt[13]:=proppoint(Crd[0], Crd[1], 69, 209);
  Crd[18]:=proppoint(Brdr[1], Brdr[2], 220, 55);
  Crd[19]:=proppoint(Brdr[0], Brdr[3], 32, 243);
  Eye[0]:=proppoint(Crd[18], Crd[19], 173, 95);
  Eye[1]:=proppoint(Crd[18], Crd[19], 171, 97);
  Eye[2]:=proppoint(Crd[18], Crd[19], 1685, 995);
  Crd[20]:=proppoint(Brdr[1], Brdr[2], 192, 84);
  Crd[21]:=proppoint(Brdr[0], Brdr[3], 67, 209);
  Eye[3]:=proppoint(Crd[20], Crd[21], 161, 67);
  Eye[4]:=proppoint(Crd[20], Crd[21], 1575, 700);
  Eye[5]:=proppoint(Crd[20], Crd[21], 155, 72);
  Crd[22]:=proppoint(Brdr[2], Brdr[3], 235, 1685);
  Eye[6]:=proppoint(Crd[17], Crd[22], 1730, 1385);
  Eye[7]:=proppoint(Crd[17], Crd[22], 1710, 1405);
  Eye[8]:=proppoint(Crd[17], Crd[22], 1695, 1420);
  Eye[9]:=proppoint(Crd[17], Crd[22], 1680, 1435);
  Eye[10]:=proppoint(Crd[4], Crd[8], 147, 61);
  Crd[23]:=proppoint(Brdr[2], Brdr[3], 75, 1845);
  FcTp[0]:=proppoint(Brdr[1], Crd[23], 1915, 1390);
  FcTp[1]:=proppoint(Brdr[1], Crd[23], 181, 149);
  FcTp[2]:=proppoint(Crd[17], Crd[3], 1200, 845);
  Crd[24]:=proppoint(Brdr[0], Brdr[3], 228, 48);
  Crd[25]:=proppoint(Brdr[1], Brdr[2], 720, 2035);
  FcTp[3]:=proppoint(Crd[24], Crd[25], 107, 138);
  FcTp[4]:=proppoint(Crd[24], Crd[25], 114, 133);
  FcTp[5]:=proppoint(FcCnt[0], Crd[0], 46, 74);
  FcTp[6]:=proppoint(Crd[18], Crd[9], 1325, 780);
  FcTp[7]:=proppoint(Crd[18], Crd[9], 1320, 785);
  FcTp[8]:=proppoint(Crd[0], Brdr[2], 213, 78);
  FcTp[9]:=proppoint(Crd[19], Crd[18], 890, 1785);
  FcTp[10]:=proppoint(Crd[9], Crd[18], 69, 143);
  FcTp[11]:=proppoint(Crd[0], Ear[0], 50, 77);
  FcTp[12]:=proppoint(Crd[5], FcTp[11], 17, 55);
  Crd[26]:=proppoint(Brdr[1], Brdr[2], 198, 78);
  Crd[27]:=proppoint(Brdr[0], Brdr[3], 219, 57);
  Crd[28]:=proppoint(Brdr[0], Brdr[3], 198, 78);
  FcTp[13]:=proppoint(Crd[26], Crd[27], 131, 59);
  FcTp[14]:=proppoint(Crd[26], Crd[27], 129, 64);
  FcTp[15]:=proppoint(Crd[26], Crd[28], 1315, 590);
  FcTp[16]:=proppoint(Crd[26], Crd[28], 1285, 640);
  FcTp[17]:=proppoint(Crd[2], Crd[3], 143, 57);
  FcTp[18]:=proppoint(Crd[26], Crd[27], 1410, 515);
  FcTp[19]:=proppoint(Crd[4], Crd[14], 1350, 525);
  FcBt[0]:=proppoint(Crd[10], Crd[4], 115, 110);
  FcBt[1]:=proppoint(Crd[11], Crd[26], 126, 126);
  FcBt[2]:=proppoint(Crd[22], Crd[7], 1105, 1115);
  FcBt[3]:=proppoint(Crd[2], Crd[22], 130, 99);
  FcBt[4]:=proppoint(Crd[4], Crd[6], 1280, 1005);
  FcBt[5]:=proppoint(Crd[1], Crd[0], 175, 101);
  FcBt[6]:=proppoint(Crd[1], Crd[0], 180, 97);
  FcBt[7]:=proppoint(FcCnt[10], Crd[25], 80, 3);
  FcBt[8]:=proppoint(FcCnt[10], Crd[25], 67, 16);
  FcBt[9]:=proppoint(FcCnt[10], Crd[25], 74, 9);
  FcBt[10]:=proppoint(FcCnt[10], Crd[25], 72, 12);
  FcBt[11]:=proppoint(Crd[7], Crd[15], 1400, 635);
  FcBt[12]:=proppoint(Crd[7], Crd[15], 1385, 645);
  Crd[29]:=proppoint(Brdr[1], Brdr[2], 192, 68);
  FcBt[13]:=proppoint(Crd[29], Crd[22], 163, 99);
  FcBt[14]:=proppoint(Crd[29], Crd[22], 143, 120);
  FcBt[15]:=proppoint(Crd[29], Crd[22], 160, 102);
  FcBt[16]:=proppoint(Crd[29], Crd[22], 146, 117);
  Crd[30]:=proppoint(Brdr[3], Brdr[2], 1115, 805);
  FcBt[17]:=proppoint(Crd[17], Crd[30], 1275, 1570);
  FcBt[18]:=proppoint(Crd[17], Crd[30], 1205, 1640);
  FcBt[19]:=proppoint(Crd[17], Crd[30], 114, 171);
  Crd[31]:=proppoint(Brdr[3], Brdr[2], 815, 1105);
  Crd[32]:=proppoint(Brdr[0], Brdr[1], 285, 1635);
  FcBt[20]:=proppoint(Crd[31], Crd[32], 1610, 1195);
  FcBt[21]:=proppoint(Crd[31], Crd[32], 1685, 1120);
  FcBt[22]:=proppoint(Crd[31], Crd[32], 1750, 1055);
  FcBt[23]:=proppoint(Crd[1], Crd[0], 2025, 775);
  Ell[0]:=point(FcBt[23].x-k*R2, FcBt[23].y-k*R2);
  Ell[1]:=point(FcBt[23].x+k*R2, FcBt[23].y+k*R2);
  Ell[2]:=point(FcBt[23].x-k*R1, FcBt[23].y-k*R1);
  Ell[3]:=point(FcBt[23].x+k*R1, FcBt[23].y+k*R1);
  FcBt[24]:=proppoint(Crd[1], Crd[0], 1940, 885);
  FcBt[25]:=proppoint(Crd[6], Ear[6], 910, 1035);
   end;



  begin

  paintbox1.Canvas.Pen.Color:=clblack;

  paintbox1.canvas.Pen.Width:=4;
  paintbox1.Canvas.polygon([FcCnt[0], Ear[1], Ear[0], Ear[2]]);

  paintbox1.Canvas.polygon([Ear[4], Ear[3], Ear[5], Ear[2]]);

  paintbox1.canvas.Pen.Width:=0;
  paintbox1.Canvas.moveto(Ear[1]);
  paintbox1.Canvas.lineto(Ear[6]);
  paintbox1.Canvas.lineto(Ear[2]);

  paintbox1.Canvas.moveto(Ear[7]);
  paintbox1.Canvas.lineto(Ear[8]);
  paintbox1.Canvas.moveto(FcCnt[0]);
  paintbox1.canvas.Pen.Width:=5;
  paintbox1.Canvas.lineto(FcCnt[1]);
  paintbox1.Canvas.moveto(Ear[8]);

  paintbox1.Canvas.lineto(FcCnt[2]);

  paintbox1.Canvas.PolyBezier([FcCnt[2], Focus[0], Focus[1], FcCnt[3]]);



  paintbox1.Canvas.PolyBezier([FcCnt[5], Focus[2], Focus[3], FcCnt[4]]);



  paintbox1.Canvas.PolyBezier([FcCnt[6], Focus[4], Focus[5], FcCnt[10]]);


  paintbox1.Canvas.PolyBezier([FcCnt[7], Focus[6], Focus[7], FcCnt[8]]);


  paintbox1.Canvas.PolyBezier([FcCnt[9], Focus[9], Focus[8], FcCnt[3]]);
  paintbox1.Canvas.moveto(FcCnt[0]);
  paintbox1.Canvas.lineto(FcCnt[6]);


  paintbox1.Canvas.moveto(FcCnt[4]);
  paintbox1.Canvas.lineto(FcCnt[11]);

  paintbox1.Canvas.moveto(FcCnt[11]);
  paintbox1.Canvas.lineto(FcCnt[12]);


  paintbox1.Canvas.PolyBezier([FcCnt[13], Focus[10], Focus[11], FcCnt[3]]);

  paintbox1.canvas.Pen.Width:=2;
  paintbox1.Canvas.moveto(Eye[0]);
  paintbox1.Canvas.lineto(Eye[3]);
  paintbox1.canvas.Pen.Width:=3;
  paintbox1.Canvas.moveto(Eye[1]);
  paintbox1.Canvas.lineto(Eye[4]);
  paintbox1.canvas.Pen.Width:=1;
  paintbox1.Canvas.moveto(Eye[2]);
  paintbox1.Canvas.lineto(Eye[5]);
  paintbox1.Canvas.moveto(Eye[3]);
  paintbox1.Canvas.lineto(Eye[4]);


  paintbox1.Canvas.PolyBezier([Eye[3], Focus[12], Focus[12], Eye[8]]);

  paintbox1.Canvas.PolyBezier([Eye[10], Focus[13], Focus[13], Eye[9]]);

  paintbox1.Canvas.PolyBezier([Eye[5], Focus[14], Focus[14], Eye[6]]);
  paintbox1.canvas.Pen.Width:=3;

  paintbox1.Canvas.PolyBezier([Eye[4], Focus[15], Focus[15], Eye[7]]);
  paintbox1.canvas.Pen.Width:=3;

  paintbox1.Canvas.PolyBezier([Eye[3], Focus[16], Focus[17], FcCnt[8]]);
  paintbox1.canvas.brush.color:=clblack;
  paintbox1.Canvas.FloodFill(58*k, 127*k, clblack, fsBorder);

  paintbox1.Canvas.moveto(FcCnt[4]);
  paintbox1.Canvas.lineto(FcTp[0]);
  paintbox1.Canvas.lineto(FcTp[1]);

  paintbox1.canvas.Pen.Width:=1;
  paintbox1.Canvas.moveto(FcTp[2]);
  paintbox1.Canvas.lineto(FcTp[3]);

  paintbox1.Canvas.lineto(FcTp[5]);
  paintbox1.Canvas.FloodFill(78*k, 45*k, clblack, fsBorder);


  paintbox1.Canvas.PolyBezier([FcTp[7], Focus[18], Focus[19], FcTp[4]]);

  paintbox1.Canvas.PolyBezier([FcTp[6], Focus[20], Focus[19], FcTp[4]]);

  paintbox1.Canvas.moveto(FcTp[6]);
  paintbox1.Canvas.lineto(FcTp[8]);
  paintbox1.Canvas.lineto(FcTp[7]);

  paintbox1.canvas.Pen.Width:=3;
  paintbox1.Canvas.moveto(FcTp[9]);
  paintbox1.Canvas.lineto(FcTp[10]);

  paintbox1.Canvas.moveto(FcTp[11]);
  paintbox1.Canvas.lineto(FcTp[12]);
  paintbox1.canvas.Pen.Width:=2;
  paintbox1.canvas.brush.color:=clwhite;

  paintbox1.Canvas.polygon([FcTp[10], FcTp[16], FcTp[14], FcTp[11], FcTp[13], FcTp[15]]);


  paintbox1.Canvas.PolyBezier([FcTp[17], Focus[22], Focus[21], FcTp[18]]);

  paintbox1.canvas.Pen.Width:=1;
  paintbox1.Canvas.moveto(FcCnt[1]);
  paintbox1.Canvas.lineto(FcTp[19]);
  paintbox1.canvas.Pen.Width:=2;

  paintbox1.Canvas.moveto(FcBt[1]);
  paintbox1.Canvas.lineto(FcBt[0]);


  paintbox1.Canvas.PolyBezier([FcBt[0], Focus[23], Focus[24], FcBt[2]]);

  paintbox1.Canvas.moveto(FcBt[3]);
  paintbox1.Canvas.lineto(FcBt[4]);

  paintbox1.canvas.Pen.Width:=5;
  paintbox1.Canvas.PolyBezier([FcBt[1], FcCnt[9], FcCnt[9], FcBt[6]]);
  paintbox1.Canvas.PolyBezier([FcCnt[10], FcCnt[8], FcCnt[8], FcBt[5]]);

  paintbox1.Canvas.moveto(FcBt[1]);
  paintbox1.Canvas.lineto(FcBt[7]);

  paintbox1.Canvas.lineto(FcBt[8]);


  paintbox1.Canvas.PolyBezier([FcBt[8], Focus[25], Focus[26], FcBt[11]]);

  paintbox1.Canvas.PolyBezier([FcBt[9], Focus[27], Focus[28], FcBt[12]]);
  paintbox1.canvas.Pen.Width:=1;

  paintbox1.Canvas.PolyBezier([FcBt[10], Focus[29], Focus[30], FcBt[11]]);


  paintbox1.Canvas.PolyBezier([FcBt[13], Focus[32], Focus[31], FcBt[14]]);
  paintbox1.canvas.Pen.Width:=2;

  paintbox1.Canvas.PolyBezier([FcBt[15], Focus[34], Focus[33], FcBt[16]]);
  paintbox1.canvas.Pen.Width:=3;
  paintbox1.Canvas.moveto(FcCnt[10]);
  paintbox1.Canvas.lineto(FcBt[1]);

  paintbox1.canvas.Pen.Width:=2;
  paintbox1.Canvas.moveto(FcBt[17]);
  paintbox1.Canvas.lineto(FcBt[20]);
  paintbox1.Canvas.moveto(FcBt[18]);
  paintbox1.Canvas.lineto(FcBt[21]);
  paintbox1.Canvas.moveto(FcBt[19]);
  paintbox1.Canvas.lineto(FcBt[22]);
  paintbox1.canvas.Pen.Width:=4;

  paintbox1.Canvas.Ellipse(Ell[2].X, Ell[2].y, Ell[3].x, Ell[3].y);
  paintbox1.canvas.Pen.Width:=2;

  paintbox1.Canvas.Ellipse(Ell[0].X, Ell[0].y, Ell[1].x, Ell[1].y);
  paintbox1.canvas.Pen.Width:=3;

  paintbox1.Canvas.moveto(FcBt[24]);
  paintbox1.Canvas.lineto(FcBt[25]);
  end;

end;

end.


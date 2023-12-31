unit Pantalla;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Types, CNave,Uasteroide, CBala, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.MPlayer, System.Threading;

type
  TForm1 = class(TForm)
    TimerBala: TTimer;
    TimerNave: TTimer;
    TimerAsteroid: TTimer;
    LabelGameOver: TLabel;
    BtnReintentar: TLabel;
    BtnRendirse: TLabel;


    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerNaveTimer(Sender: TObject);
    procedure TimerBalaTimer(Sender: TObject);
    function  distancia(p1, p2: tpoint): integer;
    procedure crearAsteroid(i:integer);
    procedure TimerAsteroidTimer(Sender: TObject);
    procedure verificarDisparo( iBala: integer );
    procedure destroidAsteroid( iAsteroid: integer );
    procedure verificarVidas;
    procedure Edit2Change(Sender: TObject);
    procedure BtnRendirseClick(Sender: TObject);
    procedure BtnReintentarClick(Sender: TObject);
    procedure showLabels( show: boolean );

  private
    { Private declarations }
    ObjNave : Nave;
    bals: array[1..10] of Bala;
    asteroids: array[1..10] of Asteroid;
    vidas : integer;

  public
    { Public declarations }

  end;

var
  Form1: TForm1;
  Cx,Cy: Integer;
  numeroMovimiento: integer;
  dimensionPantallaX, dimensionPantallaY: integer;

implementation

{$R *.dfm}
const VELOCIDAD_ROTACION = 8;
      CANTIDAD_ASTEROIDES = 10;
      CANTIDAD_BALAS = 10;
//-------------------------------------------------------------

procedure TForm1.FormCreate(Sender: TObject);
var i : integer;
begin

  vidas := 5;
  dimensionPantallaX := Screen.Width;
  dimensionPantallaY := Screen.Height;
  numeroMovimiento := 50;
  Cx := dimensionPantallaX div 2;
  Cy := dimensionPantallaY div 2;
  //Objeto instanciado = Se coloca el color de la nave y su ancho y alto
  ObjNave := Nave.Create( Cx, Cy, 40 );

  {Creacion de las balas}
  for i := 1 to CANTIDAD_BALAS do begin
     bals[i] := bala.Create(-1000, -1000);
  end;

    for I := 1 to CANTIDAD_ASTEROIDES do crearAsteroid(i);

  LabelGameOver.Top := Cy - LabelGameOver.Height div 2;
  LabelGameOver.Left := Cx - LabelGameOver.Width div 2;

  BtnReintentar.Top := Cy + 100 - BtnReintentar.Height div 2;
  BtnReintentar.Left := Cx - 100 - BtnReintentar.Width div 2;

  BtnRendirse.Top := Cy + 100 - BtnRendirse.Height div 2;
  BtnRendirse.Left :=   Cx + 100 - BtnRendirse.Width div 2;

end;
//-------------------------------------------------------------
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var i : integer;
begin
    case key of
      27: Form1.Close;
      37: ObjNave.rotarIzq := True;
      39: ObjNave.rotarDer := True;
      38: ObjNave.canMove := True;
      32: begin
            i := 1;
            while (i <= CANTIDAD_BALAS) do begin
              if bals[i].disponible then begin
                bals[i].punto := objNave.p1;
                bals[i].angulo := objNave.angulo;
                bals[i].disponible := false;
                break;
              end;
              i:=i+1;
            end;
          end;
    end;
end;
//-------------------------------------------------------------
procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    case key of
      37: ObjNave.rotarIzq := False;
      39: ObjNave.rotarDer := False;
      38: ObjNave.canMove := False;
    end;
end;
//-------------------------------------------------------------
procedure TForm1.FormPaint(Sender: TObject);
var i : integer;
begin
  ObjNave.dibujar(Canvas);

  {Dibujo de la bala}
  for i := 1 to CANTIDAD_BALAS do begin
    if not bals[i].disponible then bals[i].dibujar(canvas);
  end;

  {Dibujo de los asteroides}
  for i := 1 to CANTIDAD_ASTEROIDES do begin
    asteroids[i].Draw(canvas);
  end;
end;
//-------------------------------------------------------------
procedure TForm1.showLabels(show: boolean);
begin
  LabelGameOver.Visible := show;
  BtnReintentar.Visible := show;
  BtnRendirse.Visible := show;
end;
//-------------------------------------------------------------
procedure TForm1.BtnReintentarClick(Sender: TObject);
begin
  vidas:= 5;
  showLabels(False);
end;

procedure TForm1.BtnRendirseClick(Sender: TObject);
begin
  Form1.Close;
end;

//-------------------------------------------------------------
procedure TForm1.crearAsteroid( i:integer );
var radio, angulo, moverAsteroid : integer;
begin
{Creacion de los asteroides}
    randomize;
    radio := random(3) + 1;
    randomize;
    angulo := random(45) - 45;
    randomize;
    moverAsteroid := random(3)+1;
    if moverAsteroid = 1 then begin
      //se van a crear arriba
      asteroids[i] := asteroid.Create(random(dimensionPantallaX), 0, radio, -180 + angulo);
    end else if moverAsteroid = 2 then begin
      //se van a crear a la izquierda
      asteroids[i] := asteroid.Create(0, random(dimensionPantallaY), radio, 90 + angulo);
    end else if moverAsteroid = 3 then begin
      //se van a crear a la derecha
      asteroids[i] := asteroid.Create(dimensionPantallaX, random(dimensionPantallaY), radio, -90 + angulo);
    end else begin
      asteroids[i] := asteroid.Create(random(dimensionPantallaX), dimensionPantallaY, radio, 0 + angulo);
      // se van a crear abajo
    end;
end;


function TForm1.distancia(p1, p2: tpoint): integer;
begin
  result := trunc(sqrt(  (p2.X - p1.X)*(p2.X - p1.X)  + (p2.Y - p1.Y)*(p2.Y - p1.Y) ));
end;
procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

//-------------------------------------------------------------
procedure TForm1.TimerAsteroidTimer(Sender: TObject);
var i : integer;
begin
{Codigo para generar los asteroides}
  for i := 1 to CANTIDAD_ASTEROIDES do begin
    asteroids[i].Move;
    if (asteroids[i].Cx < -100)
    or (asteroids[i].Cy < -100)
    or (asteroids[i].Cx > Form1.Width+100)
    or (asteroids[i].Cy > Form1.Height+100)
    then begin
      crearAsteroid(i);
    end;
  end;
end;

procedure TForm1.TimerBalaTimer(Sender: TObject);
var i : integer;
begin
{Control de las balas cuando salen del formulario}
  for i := 1 to CANTIDAD_BALAS do begin
      if not bals[i].disponible then begin
        bals[i].mover;
        if (bals[i].punto.X < 0)
        or (bals[i].punto.Y < 0)
        or (bals[i].punto.X > Form1.Width)
        or (bals[i].punto.Y > Form1.Height)
        then begin
          bals[i].disponible := true;
          bals[i].punto.X := -1000;
          bals[i].punto.Y := -1000;


        end;
      end;

      verificarDisparo(i);

  end;
end;

procedure TForm1.TimerNaveTimer(Sender: TObject);
var i : integer;
begin
    if ObjNave.canMove then objNave.mover;

    if objNave.rotarIzq then objNave.rotar(-VELOCIDAD_ROTACION);
    if objNave.rotarDer then objNave.rotar(VELOCIDAD_ROTACION);

    if ObjNave.centro.X > dimensionPantallaX then objNave.centro.X := 0;
    if ObjNave.centro.Y > dimensionPantallaY then objNave.centro.Y := 0;
    if ObjNave.centro.X < 0 then objNave.centro.X := dimensionPantallaX;
    if ObjNave.centro.Y < 0 then objNave.centro.Y := dimensionPantallaY;

    {choque de la nave con algun asteroide}
  for i := 1 to CANTIDAD_ASTEROIDES do begin
    if (distancia(point(asteroids[i].Cx, asteroids[i].Cy), ObjNave.p1) <= asteroids[i].Radio)
    or (distancia(point(asteroids[i].Cx, asteroids[i].Cy), ObjNave.p2) <= asteroids[i].Radio)
    or (distancia(point(asteroids[i].Cx, asteroids[i].Cy), ObjNave.p3) <= asteroids[i].Radio)
    then begin
      {Codigo para cuando muera la nave}
      ObjNave.centro.X := 0;
      ObjNave.centro.Y := 0;
      ObjNave.angulo := 0;
      vidas := vidas - 1;
      verificarVidas();
    end;
  end;

  if vidas > 0 then
    repaint;

end;

procedure TForm1.verificarVidas;
begin
    if vidas = 0 then begin
      showLabels(True);
    end;
end;

procedure TForm1.verificarDisparo( iBala: integer );
var j: integer;
begin
  for j := 1 to CANTIDAD_ASTEROIDES do begin
    if distancia(point(asteroids[j].Cx, asteroids[j].Cy), bals[iBala].punto) <= asteroids[j].Radio
    then begin
      bals[iBala].punto.X := -1000;
      bals[iBala].punto.Y := -1000;
      bals[iBala].disponible := true;

      if asteroids[j].Radio = 20 then  begin
        destroidAsteroid(j);
      end
      else if asteroids[j].Radio = 50 then begin
        asteroids[j].setRadio(1);
      end else if asteroids[j].Radio = 150 then begin
        asteroids[j].setRadio(2);
      end

    end;
  end;

end;

procedure TForm1.destroidAsteroid(iAsteroid: integer);
begin
    asteroids[iAsteroid].Cx := -255;
    asteroids[iAsteroid].Cy := -255;
end;
//-------------------------------------------------------------

end.

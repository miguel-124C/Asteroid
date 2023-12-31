unit UAsteroide;

interface
Uses Graphics, System.Types;
Type
    Asteroid = Class
      Private


      Public
          angulo: integer;
          velocidad: integer;
          Radio   : Integer;
          Cx,Cy : Integer;
          constructor Create(x,y,radio, angulo:Integer);
          Procedure Draw(Pantalla : TCanvas);
          Procedure Move;
          procedure setRadio( radio: integer );
    End;

implementation


constructor Asteroid.Create(x, y, radio, angulo: Integer);
begin
  Cx:=x;
  Cy:=y;
  setRadio(radio);
  Self.angulo := angulo;
  randomize;
  velocidad := random(5)+5;
end;

procedure Asteroid.Draw(Pantalla: TCanvas);
begin
     Pantalla.pen.Color:=clWhite;
     Pantalla.Pen.Width := 4;
     Pantalla.Ellipse(Cx-radio,Cy-radio,Cx+radio,Cy+radio);
end;

procedure Asteroid.Move;
var dx, dy: integer;
begin
     dx := trunc(velocidad * sin(angulo*pi/180));
     dy := -trunc(velocidad * cos(angulo*pi/180));
     Cx:=Cx+dx;
     Cy:=Cy+dy;
end;



procedure Asteroid.setRadio( radio: integer );
begin
  case radio of
      1: Self.radio := 20;
      2: Self.radio := 50;
      3: Self.radio := 150;
  end;
end;

end.

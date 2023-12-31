unit CBala;

interface
uses
classes, System.Types, graphics;
   type
    Bala = class
      private
        velocidad: integer;
      public
        disponible: boolean;
        punto: TPoint;
        angulo: integer;
        constructor Create(x, y: integer);
        procedure dibujar(canvas: TCanvas);
        procedure mover;

    end;
implementation

{ bala }

constructor bala.Create(x, y: integer);
begin
  punto := point(x, y);
  velocidad := 20;
  disponible := true;
end;

procedure bala.dibujar(canvas: TCanvas);
begin
  Canvas.Pen.Color := clWhite;
  Canvas.Pen.Width := 10;
  Canvas.Polygon([punto, punto]);
end;

procedure bala.mover;
begin
  punto.X := punto.X + trunc(velocidad * sin(angulo*pi/180));
  punto.Y := punto.Y + -trunc(velocidad * cos(angulo*pi/180));
end;

end.

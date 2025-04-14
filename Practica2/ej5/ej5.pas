program ej5;
const alto = 999;
       alta = 'ZZZ';
       df = 5;

type
  usuario = record
    cod: integer;
    tiempo: integer;
    fecha: String;
  end;
  
  archivo = file of usuario;
  arc_detalles = array [1..df] of archivo;
  reg_detalles = array [1..df] of usuario;
  
  procedure leer( var arc: archivo; var dato: usuario);
  begin
    if (not eof (arc) ) then read(arc,dato)
    else begin 
      dato.cod:= alto;
      dato.fecha:= alta;
    end;
  end;
  
  procedure minimo(var vec: arc_detalles; var r: reg_detalles; var min: usuario);
  var i, pos: integer;
  begin
    min.cod:= alto;
    min.fecha := 'ZZZ';
    for i:= 1 to df do begin
      if (r[i].cod <= min.cod) or (r[i].fecha < min.fecha)then begin
        min:= r[i];
        pos:= i;
      end;
    end;
    if (min.cod<> alto) then leer (vec[pos],r[pos]);
  end; 
  
  procedure nuevoMaestro(var mae: archivo; var vec: arc_detalles);
  var r: reg_detalles; min, u :usuario; i: integer;
  begin
    rewrite (mae);
    for i:= 1 to df do begin 
      reset (vec[i]);
      leer(vec[i], r[i]);
    end;
    minimo(vec,r,min);
    while (min.cod <> alto) do begin
      u.tiempo:=0;
      u.cod:= min.cod;
      while (min.cod = u.cod) do begin
         u.tiempo:=0;
         u.fecha:= min.fecha;
         while (u.cod = min.cod) and (u.fecha = min.fecha) do begin
           u.tiempo:= u.tiempo + min.tiempo;
           minimo(vec,r,min);
         end;
         write(mae,u);
      end;
    end;  
    close(mae);
    for i:= 1 to df do close (vec[i]);
  
  end;

var mae: archivo; vec: arc_detalles;
begin
  assign (mae,'p2-maestro5.dat');
  nuevoMaestro(mae,vec);
end.

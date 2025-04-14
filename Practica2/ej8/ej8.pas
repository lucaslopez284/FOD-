program ej8;

const alto = 999;
      df = 16;

type 

    infoMaestro = record
       codProvincia:integer;
       provincia: string;
       habitantes: integer;
       yerbaKilos: real;
    end;
    
    infoDetalle = record
      codProvincia: integer;
      yerbaKilos: integer;
    end; 
    
    maestro = file of infoMaestro;
    detalle = file of infoDetalle;
    vector = array [1..df] of detalle;
    registros = array [1..df] of infoDetalle;
    
    procedure leer (var arc: detalle; var dato: infoDetalle);
    begin 
      if (not eof (arc) ) then read (arc,dato)
      else dato.codProvincia:= alto;
    end;
    
    procedure minimo (var v: vector; var r: registros; var min: infoDetalle);
    var i: integer; pos: integer;
    begin
       min.codProvincia:= alto;
       for i:= 1 to 16 do begin
         if (r[i].codProvincia < min.codProvincia) then begin
               min:= r[i];
               pos:= i;
         end;
       end;
       read(v[pos],r[pos]);
    end;
    
    procedure informar (info: infoMaestro);
    var prom: real;
    begin
      prom:= info.yerbaKilos/info.habitantes;
      writeln('Codigo de provincia ' , info.codProvincia , ' Provincia ' , info.provincia , ' promedio de yerba por persona ' , prom:2:2);
    end;
    
    procedure actualizarMaestro (var mae: maestro; var v: vector);
    var i: integer; info: infoMaestro; min: infoDetalle; r: registros; 
    begin
      reset (mae);
      for i:= 1 to 16 do begin
        reset(v[i]);
        leer(v[i], r[i]);
      end;
      minimo(v,r,min); 
      read(mae,info);
      while (min.codProvincia <> alto) do begin
        while (info.codProvincia < min.codProvincia) do begin
          read (mae,info);
          if (info.yerbaKilos > 10000) then begin
            informar(info);
          end;
        end;
        while (min.codProvincia = info.codProvincia) do begin
          info.yerbaKilos:= info.yerbaKilos + min.yerbaKilos;
          minimo(v,r,min);
        end;
        if (info.yerbaKilos > 10000) then begin
              informar(info);
        end;
        seek (mae, filepos(mae) -1);
        write(mae,info);
      end;
      close (mae);
      for i:= 1 to 16 do 
        close(v[i]);
    end;
    
var mae: maestro; v: vector;

begin
  // modulo ficticio asignar(v);
   assign(mae,'prac2-ej8-maestro.dat');
   actualizarMaestro(mae,v);
end.

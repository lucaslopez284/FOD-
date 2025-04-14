program ej3;
const alto = 'ZZZ';

type 
  info = record
    provincia: String [20];
    cant: integer;
    total: integer;
  end;
  
  infoDet = record
    provincia: String [20];
    localidad: integer;
    cant: integer;
    total: integer;
  end;
  
  maestro = file of info;
  detalle = file of infoDet;
  
  procedure leer (var det: detalle; var dato: infoDet);
   begin
     if (not eof(det)) then read(det,dato)
     else dato.provincia:= alto;
   end;
   
   procedure minimo (var det1: detalle; var det2:detalle; var min: infoDet; var r1: infoDet; var r2 : infoDet);
   begin
     if (r1.provincia <= r2.provincia) then begin
       min:= r1;
       leer(det1,r1);
     end
     else begin
       min:= r2;
       leer(det2,r2);
     end;    
   end;
    
   procedure actualizar (var mae: maestro; var det1: detalle; var det2: detalle);
   var r1,r2, min: infoDet; var p: info;
   begin
     reset(mae);
     reset(det1);
     reset(det2);
     leer (det1,r1);
     leer(det2,r2);
     minimo(det1,det2,min,r1,r2);
     { se procesan los archivos de detalles }
     while (min.provincia <> alto) do begin
       {buscamos el codigo de min en el maestro}
       read (mae,p);
       while (p.provincia <> min.provincia) do read (mae,p);
       {se asignan valores para registro del archivo maestro}
       p.provincia:= min.provincia;
       {se procesan todos los registros de un mismo vendedor}
       while (p.provincia = min.provincia) do begin
         p.cant:= p.cant + p.total;
         p.total:= p.total + min.total;
         minimo(det1,det2,min,r1,r2);
       end;
       { se guarda en el archivo maestro}
      seek(mae,filepos(mae)-1);
      write (mae,p);
     end;
     close(mae);
     close(det1);
     close(det2);
   end;
  
var mae: maestro; det1,det2: detalle;
begin
  assign (mae,'p2-maestro3.dat');
  assign (det1,'p2-det3-1.dat');
  assign (det2,'p2-det3-2.dat');
  actualizar(mae,det1,det2);

end.

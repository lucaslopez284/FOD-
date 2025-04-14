program ej4;
const alto = 999;
      df = 30;
type
      proDetalle = record
       cod: integer;
       cant: integer;
     end;
     
     producto = record
       cod: integer;
       nombre: String [10];
       desc: String [30];
       stockDis: integer;
       stockMin: integer;
       precio: real;
     end;
      
     maestro = file of producto;
     detalle = file of proDetalle;
     arc_detalle = array [1..df] of detalle;
     reg_detalle = array [1..df] of proDetalle;
     
     procedure leer (var arc: detalle; var dato: proDetalle);
     begin
       if (not eof (arc)) then read (arc,dato)
       else dato.cod:= alto;
     end;
     
     procedure minimo(var detalles: arc_detalle; var r: reg_detalle; var min: proDetalle);
     var pos,i: integer;
     begin
       min.cod := alto;
       for i:= 1 to df do begin
         if(r[i].cod < min.cod) then begin
           min:= r[i];
           pos:= i;
         end;
       end;
       if (min.cod<> alto) then leer(detalles[pos], r[pos]);
     end;
     
     procedure actualizarMaestro(var mae: maestro; var detalles: arc_detalle; var texto: Text);
     var min: proDetalle; r: reg_detalle; i, cant,aux: integer; p: producto;
     begin
       reset (mae);
       assign (texto,'textoPrac2Ej4.txt');
       rewrite (texto);
       for i:= 1 to df do begin
         reset (detalles[i]);
         leer (detalles[i], r[i]);
       end;
       minimo(detalles,r,min);
       while (min.cod <> alto) do begin
         aux := min.cod;
         cant:= 0;
         while (min.cod <> alto) and(min.cod = aux) do begin
           cant:= min.cant;
           minimo(detalles,r,min);
         end;
         read(mae,p);
         while (p.cod <> aux) do read(mae,p);
         seek (mae, filepos(mae) - 1);
         p.stockDis:= p.stockDis - cant;
         write(mae,p);
         
         // pasar info del maestro a un archivo de texto
         writeln(texto,p.cod,'',p.stockDis,'',p.stockMin,'', p.precio,'',p.nombre);
         writeln(texto,p.desc);
       end;
       close (mae);
       for i:= 1 to df do close(detalles[i]);
       close (texto);
     end;

     
var mae: maestro; detalles: arc_detalle; texto: Text;

begin
 assign (mae,'p2-maestro4.dat');
 actualizarMaestro(mae,detalles,texto);
end.

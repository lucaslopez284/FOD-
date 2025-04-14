program ej2;
const alto= 999;

type 
  
   
   producto = record
     cod: integer;
     precio: real;
     stockActual: integer;
     stockMinimo: integer;
     nombre: String;
   end;
   
   venta = record
     cod: integer;
     cant: integer;
   end;
   
   maestro= file of producto;
   detalle= file of venta;
   
   procedure leer (var det: detalle; var v: venta);
   begin
     if (not eof(det)) then read(det,v)
     else v.cod:= alto;
   end;

  procedure actualizar (var mae: maestro; var det: detalle);
  var v: venta; p: producto; total, aux: integer;
  begin
    reset (mae);
    reset (det);
    leer(det,v);
    read (mae,p);
    while (v.cod <> alto) do begin
      aux := v.cod;
      total:= 0;
      while (aux = v.cod) do begin
        total:= total + v.cant;
        leer(det,v);
      end;
      while (p.cod <> aux) do begin
        read (mae,p);
      end;
      p.stockActual:= p.stockActual - total;
      seek(mae,filepos(mae)-1);
      write(mae,p); 
      if (not eof (mae)) then 
        read(mae,p);
    end; 
    close (det);
    close (mae);
  end;
  
  procedure exportar(var mae: maestro; var texto: Text);
  var p: producto;
  begin
    reset(mae);
    rewrite(texto);
    while (not eof (mae)) do begin
      read(mae,p);
      if (p.stockMinimo > p.stockActual) then 
        writeln(texto,p.cod, '',p.precio, '', p.stockActual,'',p.stockMinimo , '',p.nombre);
    end;
    close(mae);
    close(texto);
  end;

var texto: Text; det: detalle; mae: maestro;
begin
  assign (texto,'stockMinimo.txt');
  assign (mae,'productos2p2.dat');
  assign (det,'ventas2p2.dat');
  actualizar(mae,det);
  exportar(mae, texto);
end.

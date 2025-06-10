program preParcial;

const 
  alto = 9999;
  max = 30;

type 

   infoMae = record;
     cod: integer;
     nombre: string;
     casos: integer;
   end;
   
   infoDet = record
     cod: integer;
     casos: integer;
   end;
   
 maestro = file of infoMae;
 detalle = file of infoDet;
 
 detalles = array [1..max]  of detalle;
 registros = array [1..max] of infoDet;
 
 procedure leer ( var arc: detalle; r: infoDet);
 begin
   if (not eof (arc)) then read (arc,r);
   else r.cod:= alto;
 end;
 
 procedure minimo (var min: infoDet; var reg: registros; var det: detalles);
 var i,pos: integer;
 begin
   min.cod:= alto;
   for i:= 1 to max do begin
     if (reg[i] < min.cod) then begin
          min:= reg[i];
          pos:= i;  
     end;
          
   end;
   if (min.cod <> alto) then leer (det[pos], reg[pos]);
 end;
 
 procedure actualizarMaestroEInformo( var arc: archivo; var reg: registros; var det: detalles);
 var
   mae: infoMae;
   det,min: infoDet;
   nuevos:= integer;
   codAct: integer;
 begin
   writeln('Lista de municipios con mas de 15 positivos');
   reset (arc);
   
   // resetear detalles(reg,det);
   procedure actualizarMaestroEInformo( var arc: archivo; var reg: registros; var det: detalles);
 var
   mae: infoMae;
   det,min: infoDet;
   nuevos:= 0;
   codAct: integer;
 begin
   writeln('Lista de municipios con mas de 15 positivos');
   reset (arc);
   
   // resetear detalles(reg,det);
   
   minimo (min,reg,det);
   while (not eof (arc)) do begin
     read (arc, mae);
     
     nuevos:= 0;
     while (min.cod <> alto) and(min.cod = mae.cod) do begin
        nuevos:= nuevos + min.casos;
        minimo(min,reg,det);
     end;
     if (nuevos > 0) then begin
       mae.casos:= mae.casos + nuevos;
       seek(arc, filepos(arc) - 1);
       write (arc,mae);
     end;
     if (mae.casos > 15) then begin
       writeln('Municipio: ' , mae.nombre, ' , casos: ', mae.casos);
     end;
   end;
   
   
   close(arc);
   cerrarDetalles(det);
 
 end;
 
   while (not eof (arc)) do begin
     read (arc, mae);
     
     nuevos:= 0;
     while (min.cod <> alto) and(min.cod = mae.cod) do begin
        nuevos:= nuevos + min.casos;
        minimo(min,reg,det);
     end;
     if (nuevos > 0) then begin
       mae.casos:= mae.casos + nuevos;
       seek(arc, filepos(arc) - 1);
       write (arc,mae);
     end;
     if (mae.casos > 15) then begin
       writeln('Municipio: ' , mae.nombre, ' , casos: ', mae.casos);
     end;
   end;
   
   
   close(arc);
   cerrarDetalles(det);
 
 end;
 

var arc: archivo; reg: registros; det: detalles;
begin
  // asignar maestro
  // asignar detalles
  
  actualizarMaestroEInformo(arc,reg,det);


end;

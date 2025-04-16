program ej12;

const 
  alto = 9999;


type

  acceso = record
    anio: integer;
    mes: integer;
    dia: integer;
    usuario: integer;
    tiempo: real;
  end;
  
  archivo = file of acceso;
  
  procedure leer (var arc: archivo;  var dato: acceso);
  begin
    if (not eof (arc)) then read(arc,dato)
    else dato.anio:= 999;
  end;
  
  procedure importar (var texto: text; var arc: archivo);
  var aux: acceso; 
  begin
    assign(texto, 'usuario.txt');
    assign(arc, 'prac2ej12.dat');
    reset (texto);
    rewrite(arc);
    writeln('------------');
    while (not eof (arc)) do begin
      readln(texto, aux.anio, aux.mes, aux.dia, aux.usuario, aux.tiempo);
      write(arc,aux);
    end;
    close (texto);
    close(arc);
  end;
  
  procedure impresion (var arc: archivo; an: integer);
  var aux: acceso; m,d, id: integer; esta: boolean; totalId, totalDia, totalMes: real;
  begin
    reset (arc);
    leer(arc,aux);
    esta:= false;
    assign(arc, 'prac2ej12.dat');
    leer(arc,aux);
    while ((aux.anio <> alto) and (esta = false)) do begin
      if (aux.anio = an) then begin
        writeln('anio ' , an);
        esta:= true; 
        while (aux.anio = an) do begin
          m:= aux.mes;
          writeln('mes ' , m);
          totalMes:= 0;
          while ((aux.anio = an) and (aux.mes = m)) do begin
            d:= aux.dia;
            totalDia:= 0;
            while ((aux.anio = an) and (aux.mes = m) and (aux.dia = d)) do begin
              writeln('ID usuario ' , aux.usuario , ' tiempo de acceso ' , aux.tiempo);
              id:= aux.usuario;
              totalId:= 0;
              while ((aux.anio = an) and (aux.mes = m) and (aux.dia = d) and(id = aux.usuario) ) do begin
                totalId:= totalId + aux.tiempo;
                leer(arc,aux);
              end;
              totalDia:= totalDia + totalId;
              writeln('Tiempo de acceso en el dia ' , d , ' del mes ' , m, ' del usuario ', id,' : ' , totalDia);
            end;
            writeln('Tiempo de acceso en el dia ' , d , ' del mes ' , m, ' : ' , totalDia);
            totalMes:= totalMes + totalDia;
          end;
          writeln('Tiempo de acceso total del mes ' , m, ' : ' , totalMes);
        end;
      end
      else if (esta = false) then leer (arc,aux);
    end;
    if (esta = false) then 
      writeln('Anio ' , an, ' no encontrado ');
    close(arc);
  end; 
  
  


var arc: archivo; texto: text; an: integer;
begin
  importar(texto,arc);
  writeln('Inserte anio ');
  readln(an);
  impresion(arc,an);
end.

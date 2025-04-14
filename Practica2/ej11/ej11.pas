program ej11;

const alto = 9999;

type 
  empleado = record
    departamento: integer;
    division: integer;
    num: integer;
    categoria: integer;
    horas: integer;
  end;
  
  infoDetalle = record
    categoria: integer; 
    monto:  real;
  end;
  
  archivo = file of empleado;
  vector = array [1..15] of real;
  
  procedure leer (var arc: archivo;  var dato: empleado);
  begin
    if (not eof (arc)) then read(arc,dato)
    else dato.departamento:= 999;
  end;
  
  procedure importarValores (var v: vector; var t: text);
  var info: infoDetalle;
  begin
    reset (t);
    while (not eof (t))do begin
      read(t,info.categoria, info.monto);
      v[info.categoria]:= info.monto;
    end;
  end;
  
  procedure listado (var arc: archivo; v: vector);
  var di,dep,num: integer; totalDep, totalDiv, totalE: real; horasDep, horasDiv, horasE: integer; dato: empleado;
  begin
    reset (arc);
    leer (arc,dato);
    while (dato.departamento <> alto) do begin
      dep:= dato.departamento;
      writeln('Departamento ' , dep);
      horasDep:= 0;
      totalDep:= 0;
      while (dep = dato.departamento) do begin
        di:= dato.division;
        writeln('Division ' ,di);
        horasDiv:= 0;
        totalDiv:= 0;
        while (di = dato.division) and (dep = dato.departamento) do begin
           num:= dato.num;
           writeln('Numero de empleado: ' , num);
           horasE:= 0;
           totalE:= 0;
           while (di = dato.division) and (dep = dato.departamento) and (num = dato.num) do begin
             horasE:= horasE + dato.horas;
             totalE:= totalE + (dato.horas * v[dato.categoria]);
             leer(arc,dato);
           end;
           writeln('Total de horas empleado ' , horasE, ' monto a cobrar ' , totalE);
           horasDiv:= horasDiv + HorasE;
           totalDiv:= totalDiv + totalE;
        end;
        writeln('Total de horas division ' , horasDiv, ' monto total ' , horasDiv);
        horasDep:= horasDep + horasDiv;
        totalDep:= totalDep + totalDiv;
      end;
      writeln('Total de horas departamento ' , horasDep, ' monto total ' , horasDep);
    end;
    close (arc);
  end;
  
var arc: archivo; t: text; v: vector; 

begin
  assign(t,'horas.txt');
  assign(arc, 'archivoHoras11.dat');
  importarValores(v,t);
  listado(arc,v);
end.

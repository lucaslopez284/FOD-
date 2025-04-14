program ej9;
const
  alto = 999;
type 
  cliente = record
    cod: integer;
    nombre: string;
    apellido: string;
  end;
  
  ventas = record
    cli: cliente;
    anio: integer;
    mes: integer;
    dia: integer;
    monto: real;
  end;

  archivo= file of ventas;
  
  procedure leer(var arc: archivo; var v: ventas);
  begin
    if (not eof (arc)) then read (arc,v)
    else v.cli.cod:= alto;
  end;
  
  procedure reporte (var arc: archivo);
  var aux: ventas; mensual: real; anual: real; total: real; cod, a, m: integer;
  begin
    reset (arc);
    leer (arc, aux); 
    total:= 0;
    while (aux.cli.cod < alto) do begin
      cod:= aux.cli.cod;
      writeln('Cliente ' , aux.cli.nombre, ' ' , aux.cli.apellido , ' codigo ' , aux.cli.cod);
      while (cod = aux.cli.cod) do begin
        anual:= 0;
        a:= aux.anio;
        while (a = aux.anio) and (aux.cli.cod = cod) do begin
          m:= aux.mes;
          mensual:= 0;
          while (m = aux.mes) and (a = aux.anio) and (cod = aux.cli.cod) do begin
            mensual:= mensual + aux.monto;
            leer(arc,aux);
          end;
          writeln('Gastado en el mes ' , m , ' : ' , mensual:2:2);
          anual:= anual + mensual;
        end;
        writeln('Gastado en el anio ' , a , ' : ' , anual:2:2);
        total:= total + anual;
      end;
    end;
    writeln('Total gastado por los clientes ' , total:2:2);
  end;

var arc: archivo;
begin
  assign (arc, 'ventas.dat');
  reporte (arc);
end.

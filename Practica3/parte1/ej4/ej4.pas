program ej4;

type
  flor = record
    nombre: String[45];
    codigo: integer;
  end;
  
  archivo = file of flor;
   
  procedure agregarFlor(var arc: archivo; nom: string; cod: integer);
  var f, aux: flor; pos: integer;
  begin
    reset(arc);
    f.nombre:= nom;
    f.codigo:= cod;
    read(arc,aux);
    if (aux.codigo < 0) then begin
      pos:= aux.codigo * (-1);
      seek(arc,pos);
      read(arc,aux);
      seek(arc,filepos(arc)-1);
      write(arc,f);
      seek(arc,0);
      write(arc,aux);
    end
    else begin
      seek(arc,filesize(arc));
      write(arc,f);
    end;
    close(arc);
  end;
  
  procedure listarFloresExceptoBorradas(var arc: archivo);
  var f: flor;
  begin
    reset(arc);
    while (not eof(arc)) do begin
      read(arc,f);
      if (f.codigo < 0) then
        writeln('Codigo de flor ', f.codigo, ' Nombre: ' , f.nombre);
    end;
    close(arc);
  end; 
  
  
  
  procedure eliminarFlor(var arc: archivo; flo: flor);
  var encontre: boolean; aux,f: flor; pos: integer;
  begin
    reset (arc);
    encontre:= false;
    read(arc,aux);
    while ((not eof (arc)) and (encontre = false)) do begin
      read(arc,f);
      if (f.codigo = flo.codigo) then begin
        pos:= filepos(arc) * (-1);
        seek(arc,filepos(arc)-1);
        write(arc,aux);
        aux.codigo:= pos;
        seek(arc,0);
        write(arc,aux);
        encontre := true;
      end;
    end;
    close(arc);
  end;
  
  

begin
  Randomize;
end.

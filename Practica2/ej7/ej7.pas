program ej7;

const alto = 9999;

type 

  alumno = record
    cod: integer;
    nombre: string [20];
    apellido: string [20];
    cursada: integer;
    examen: integer;
   end;
   
   cursadas = record
     codAlumno: integer;
     codMateria: integer;
     anio: integer;
     nota: boolean;
   end;
   
    finales = record
     codAlumno: integer;
     codMateria: integer;
     fecha: string;
     nota: integer;
   end;
   
   archivoC = file of cursadas;
   archivoF = file of finales;
   maestro = file of alumno;
   
   procedure leerCursada (var arc: archivoC; var dato: cursadas); 
  begin
    if (not eof (arc)) then read (arc,dato)
    else dato.codAlumno:= alto;
  end;
  
  procedure leerFinal (var arc: archivoF; var dato: finales ); 
  begin
    if (not eof (arc)) then read (arc,dato)
    else dato.codAlumno:= alto;
  end;
  
  procedure minimo (var rf: finales; var rc: cursadas; var auxf: finales; var auxc: cursadas; var min: integer; var arcf: archivoF; var arcc: archivoC; var usoFinal: boolean);
  begin
    if (rf.codAlumno < rc.codAlumno) then begin
      min:= rf.codAlumno;
      leerFinal(arcf,rf);
      usoFinal:= true;
    end
    else begin 
       min:= rc.codAlumno;
       leerCursada(arcc,rc);
       usoFinal:= false;
    end;
  end;

  
  
  procedure actualizarMaestro(var mae: maestro; var arcf: archivoF; var arcc: archivoC);
  var rf: finales ; rc: cursadas; // variables para leer registros
     auxc: cursadas; auxf: finales ; // auxiliares para cargar info al maestro
     min: integer; // alamacena el codigo minimo entre los dos detalles leidos
     a: alumno; // variable para modificar el maestro
     usoFinal :boolean; // determina si se va a modificar info correspondiente al final o no
  begin
    reset(mae);
    reset(arcf);
    reset(arcc);
    leerCursada(arcc,rc);
    leerFinal(arcf,rf);
    minimo(rf,rc,auxf,auxc,min,arcf,arcc,usoFinal);
    read(mae,a);
    while(min <> alto) do begin
      while(a.cod < min) do 
        read(mae,a);
      while (min = a.cod) do begin
        if(usoFinal) then
          if (auxf.nota > 3) then a.examen:= a.examen + 1
        else 
          if (auxc.nota) then a.cursada:= a.cursada + 1;
        minimo(rf,rc,auxf,auxc,min,arcf,arcc,usoFinal);
      end;
      seek(mae,filepos(mae)-1);
      write(mae,a); 
    end;
    close(mae);
    close(arcf);
    close(arcc); 
  end;
   
var 
  mae: maestro;
  arcf: archivoF;
  arcc: archivoC;
  
begin
  assign (mae,'prac2-maestro7');
  assign (arcf,'finalesAlumnos');
  assign (arcc, 'cursadasAlumnos');
  actualizarMaestro(mae,arcf,arcc);
end.

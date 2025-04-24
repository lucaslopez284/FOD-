program ej4;

 type empleado = record
       num : integer;
       ap: string [10];
       n: string [10];
       edad: integer;
       dni: integer;
      end;
      
      archivo = file of empleado; 
      
      
  procedure leerEmpleado (var e: empleado);
  begin
    writeln('---------------Carga de informacion de empleado--------------------');
    writeln('Inserte numero de empleado');
    readln(e.num);
    writeln('Inserte edad del empleado');
    readln(e.edad);
    writeln('Inserte apellido');
    readln(e.ap);
    writeln('Inserte nombre');
    readln(e.n);
    writeln('Inserte DNI');
    readln(e.dni)
  end;
  
  procedure informarEmpleado (e: empleado);
  begin
    writeln('Numero de empleado: ' , e.num , ' , nombre: ' , e.n, ' , apellido: ' , e.ap, ' , edad: ' , e.edad , ' , DNI: ' , e.dni);
  end;
  
  procedure crearArchivoEmpleados( var al: archivo);
  var e: empleado;
  begin
    rewrite(al);
    leerEmpleado(e);
    while (e.ap <> 'fin') do begin
      write(al,e);
      leerEmpleado(e);
    end;
    close (al);
  end;
  
  procedure recorrido1(var al: archivo);
  var n: string; e: empleado;
  begin
    writeln('Inserte nombre u apellido a buscar');
    readln(n);
    reset (al);
    writeln('-------Empleados llamados ' , n , '---------');
    while not eof (al)do begin
      read (al,e);
      if ((e.ap = n ) or (e.n = n)) then 
        informarEmpleado(e);
    end;
    writeln;
    close (al);
  end;
  
  procedure recorrido2(var al: archivo);
  var e: empleado;
  begin
    reset (al);
    writeln('-------Listado de empleados -------');
    while not eof (al)do begin
      read (al,e);
      informarEmpleado(e);
    end;
    writeln;
    close (al);
  end;
  
  procedure recorrido3(var al: archivo);
  var e: empleado;
  begin
    writeln('-------Empleados proximos a jubilarse -------');
    reset (al);
    while not eof (al)do begin
      read (al,e);
      if (e.edad > 70) then
        informarEmpleado(e);
    end;
    close (al);
    writeln;
  end;
  
  procedure listar (var al: archivo);
  begin
    recorrido1(al);
    recorrido2(al);
    recorrido3(al);
  end;
  
  procedure modificarEdad (var al: archivo);
  var edad, num: integer; esta: boolean; e: empleado;
  begin
    writeln('Ingrese numero de empleado ');
    readln(num);
    writeln('Ingrese edad nueva');
    readln(edad);
    esta:= false;
    reset (al);
    while ((esta = false ) and (not eof (al)) ) do begin
      read(al,e);
      if (e.num = num) then 
        e.edad:= edad;
        seek(al,filepos(al) - 1);
        write(al,e);
        esta:= true
    end;
    close (al);
  end;
  
  
  procedure agregarAlFinal (var al: archivo; emp: empleado);
  var e: empleado; repite: boolean;
  begin
    repite:= false;
    reset(al);
    while ((repite = false) and (not eof (al))) do begin
      read (al,e);
      if (emp.num = e.num) then repite:= true;
    end;
    if (repite = false) then
      write(al,emp);
    close (al);
  end;
  
  procedure agregarEmpleados (var al: archivo);
  var emp: empleado; cant, i: integer;
  begin
    writeln('Inserte la cantidad de empleados a agregar');
    readln(cant);
    for i:= 1 to cant do begin
      leerEmpleado(emp);
      agregarAlFinal(al,emp);
    end;
  end;
  
  procedure nuevoArchivoTodos (var logico: archivo; var texto : Text);
  var e: empleado;
  begin
    assign(texto,'TodosLosEmpleado.txt');
    reset(logico); 
    rewrite(texto);  
    while (not eof (logico)) do begin
      read (logico, e);
      writeln('---leido---');
      with e do writeln (num:5, ap:5, n:5, edad:5,dni:5);
      with e do writeln (texto,' ', num, ' ', ap, ' ', n, ' ', edad, ' ', dni, ' ');
    end; 
    close (logico);    
    close (texto);
  end;
  
  procedure nuevoArchivoSinDNI (var al: archivo; var at : Text);
  var e: empleado;
  begin
    assign (at,'faltaDNIEmpleado.txt');
    reset(al);
    rewrite(at);
    while not eof (al) do begin
      read (al,e);
      if (e.dni = 0) then
        with e do writeln (at,' ', num, ' ', ap, ' ', n, ' ', edad, ' ', dni, ' ');
    end;
    close (al);
    close (at);
  end;
  
 procedure borrarRegistro(var arc: archivo);
 var e, ult: empleado; cod: integer;
 begin
   reset(arc);
   writeln('Inserte codigo de empleado');
   readln(cod);
   seek(arc, fileSize(arc)-1);
   read(arc, ult);
   seek(arc, 0);
   read(arc, e);
   while(not eof(arc)) and (e.num<> cod) do begin
     read(arc,e);
     if (e.num = cod) then begin
       seek(arc,filepos(arc)-1);
       write(arc,ult);
       seek(arc,filesize(arc)-1);
       truncate(arc);
     end;
   end;
   close(arc);
 end;
  
      
      
var al: archivo; op: char; at,at2: Text;

begin
  Randomize;
  assign(al,'enteros.dat');
  writeln('---------- MENU DE OPCIONES -------------');
  writeln('A: Crear archivo de registros');
  writeln('B: Listar informacion previamente cargada desde un archivo');
  writeln('C: AgregarEmpleados');
  writeln('D: Modificar edad');
  writeln('E: Nuevo archivo de textos con informacion de todos los empleados');
  writeln('F: Nuevo archivo de textos con informacion de los empleados sin DNI cargado');
  writeln('G: Eliminar registro truncando el archivo');
  readln(op);
  case op of 
   'A': crearArchivoEmpleados(al);
   'B': listar(al);
   'C': agregarEmpleados(al);
   'D': modificarEdad(al);
   'E': nuevoArchivoTodos(al,at);
   'F': nuevoArchivoSinDNI(al,at2);
   'G': borrarRegistro(al);
   else writeln('opcion no valida');
  end; 
  
end.
      


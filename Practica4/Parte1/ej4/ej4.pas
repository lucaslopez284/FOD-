program ej4;

const M = 43 // orden del arbol

type

  alumno = record
    nombre: string;
    apellido: string;
    dni: string;
    legajo: integer;
    ingreso: integer;
  end;
  
  nodo = record
    cantClaves: integer;
    claves: array [1..M-1] of integer;
    enlaces: array [1..M-1] of integer;
    hijos: array [1..M] of integer;
  end;
  
  archivo = file of alumno
  arbolB = file of nodo;
  
  
  
  
 procedure PosicionarYLeerNodo(a: arbolB {???}; n: nodo; var nrr: integer);
 begin
 
 
 end;
 
 procedure claveEncontrada (a: arbolB {???} ; n: nodo; pos: integer; clave_encontrada: boolean);
 begin
 
 end;

 procedure buscar(NRR, clave, NRR_encontrado, pos_encontrada, resultado);
 var 
   clave_encontrada: boolean;
 begin
   if (nodo = null)
     resultado := false; {clave no encontrada}
   else begin
     posicionarYLeerNodo(A, nodo, NRR);
     claveEncontrada(A, nodo, clave, pos, clave_encontrada);
     if (clave_encontrada) then begin
        NRR_encontrado := NRR; { NRR actual }
        pos_encontrada := pos; { posicion dentro del array }
        resultado := true;
     end
     else
     buscar(nodo.hijos[pos], clave, NRR_encontrado, pos_encontrada, resultado)
    end;
end;



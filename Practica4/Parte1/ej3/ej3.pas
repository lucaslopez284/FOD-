program ej3;

const
    M = .. //Orden del arbol
type
    alumno = record
        nombre: string;
        apellido: string;
        dni: integer;
        legajo: integer;
        anioIngreso: integer;
    end;
    lista = ^nodo;
    
    nodo = record
        cant_claves: integer;
        claves: array[1..M-1] of longint;
        enlaces: array[1..M-1] of integer;
        hijos: array[1..M] of integer;
        sig: lista;
        //sig: integer;
    end;
    
    TArchivoDatos = file of alumno;
    arbolB = file of nodo;
var
    archivoDatos: TArchivoDatos;
    archivoIndice: arbolB;

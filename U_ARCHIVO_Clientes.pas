unit U_ARCHIVO_Clientes;

interface
uses U_REGISTRO_Clientes;

    Type
        ARCH_Clientes = File of REG_Cliente;
    const
        Directorio_Archivo_Clientes = '.\Clientes.dat';

procedure Abrir_archivo_clientes(Var ARCHIVO_Clientes: ARCH_Clientes);
procedure Guardar_archivo_Clientes(Var ARCHIVO_Clientes: ARCH_Clientes; R_Cliente: REG_Cliente; Pos: LongWord);
procedure Cargar_Archivo_en_Registro_Cliente(Var ARCHIVO_Clientes: ARCH_Clientes; Var R_Cliente: REG_Cliente; Pos: LongWord);
procedure Cargar_Archivo_en_Vector_Registro_Cliente(Var ARCHIVO_Clientes: ARCH_Clientes; Var Vect_R_Cliente: Array_REG_Cliente);

implementation
uses crt;
    procedure Abrir_archivo_clientes(Var ARCHIVO_Clientes: ARCH_Clientes);
    begin
        Assign(ARCHIVO_Clientes, Directorio_Archivo_Clientes);
        {$I-} reset(ARCHIVO_Clientes); {$I+}
    end;

    procedure Guardar_archivo_Clientes(Var ARCHIVO_Clientes: ARCH_Clientes; R_Cliente: REG_Cliente; Pos: LongWord);
    begin

        Seek(ARCHIVO_Clientes, Pos);
        Write(ARCHIVO_Clientes, R_Cliente);

    end;

    procedure Cargar_Archivo_en_Registro_Cliente(Var ARCHIVO_Clientes: ARCH_Clientes; Var R_Cliente: REG_Cliente; Pos: LongWord);
    begin
        seek(ARCHIVO_Clientes, Pos);
        Read(ARCHIVO_Clientes, R_Cliente);
    end;


    procedure Cargar_Archivo_en_Vector_Registro_Cliente(Var ARCHIVO_Clientes: ARCH_Clientes; Var Vect_R_Cliente: Array_REG_Cliente);
    Var
        i: LongWord;
    begin

        for i:= 0 to High(Vect_R_Cliente) do
        begin
            Cargar_Archivo_en_Registro_Cliente(ARCHIVO_Clientes, Vect_R_Cliente[i], i);
        end;

    end;

    

end.
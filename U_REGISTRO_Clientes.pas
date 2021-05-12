unit U_REGISTRO_Clientes;// Misma UNIT que Proyectos

interface
    Type
        REG_Cliente = record
                razon_social,  domicilio, email: String;
                cuit: Qword;
                telefono: LongWord;
                estado: Boolean;

            end;

        Array_REG_Cliente = ARRAY of REG_Cliente;

procedure inicializar_registro_cliente(Var R_Cliente: REG_Cliente);
procedure Inicializar_Vector_registro_cliente(Var Vect_Reg_Clientes: Array_REG_Cliente);
procedure mostrar_registro_cliente(R_Cliente: REG_Cliente);

procedure Cargar_Razon_Social_Cliente(Var Razon_social: String);
procedure Cargar_Domicilio_Cliente(Var Domicilio: String);
procedure Cargar_Email_Cliente(Var Email: String);
procedure Cargar_Telefono_Cliente(Var Telefono: LongWord);

implementation
uses U_ARCHIVO_Clientes, crt;

    procedure inicializar_registro_cliente(Var R_Cliente: REG_Cliente);
    begin
        R_Cliente.razon_social:= '';
        R_Cliente.domicilio:= '';
        R_Cliente.email:= '';
        R_Cliente.cuit:= 0;
        R_Cliente.telefono:= 0;
        R_Cliente.estado:= False;
    end;

    procedure Inicializar_Vector_registro_cliente(Var Vect_Reg_Clientes: Array_REG_Cliente);
    var
        ARCHIVO_Clientes: ARCH_Clientes;
        i: LongWord;
    begin
        Abrir_archivo_clientes(ARCHIVO_Clientes);
       if FileSize(ARCHIVO_Clientes) = 0 then
        begin                                                              
            SetLength(Vect_Reg_Clientes, FileSize(ARCHIVO_Clientes)+1);//SetLenght lo uso para implementar arreglos dinamicos declaro el largo del vector antes.Doy el largo justo usando FileSize
        end                                                            //estaticos nombredelavariable : array [indice inicial inidice final] of type
        else
        begin
            SetLength(Vect_Reg_Clientes, FileSize(ARCHIVO_Clientes));
        end;
        
        Close(ARCHIVO_Clientes);

        for i:= 0 to High(Vect_Reg_Clientes) do//Con Hihgh le doy el largo del vector.
        begin
            inicializar_registro_cliente(Vect_Reg_Clientes[i]);
        end;
    end;

    procedure mostrar_registro_cliente(R_Cliente: REG_Cliente);
    begin

        WriteLn('Razon Social: ', R_Cliente.razon_social);
        WriteLn('Cuit: ', R_Cliente.cuit);
        WriteLn('Telefono: ', R_Cliente.telefono);
        WriteLn('Domicilio: ', R_Cliente.domicilio);
        WriteLn('Email: ', R_Cliente.email);
        
        if R_Cliente.estado = false then 
        begin
            WriteLn('Estado: Inactivo')
        end
        else 
        begin
            WriteLn('Estado: Activo')          
        end;
    end;

    procedure Cargar_Razon_Social_Cliente(Var Razon_social: String);
    begin
        Write('Ingrese la razon social del cliente: ');
        ReadLn(razon_social);
    end;

    procedure Cargar_Domicilio_Cliente(Var Domicilio: String);
    begin
        Write('Ingrese el domicilio del cliente: ');
        ReadLn(Domicilio);
    end;

    procedure Cargar_Email_Cliente(Var Email: String);
    begin
        Write('Ingrese el email del cliente: ');
        ReadLn(Email);
    end;

    procedure Cargar_Telefono_Cliente(Var Telefono: LongWord);
    begin
        Write('Ingrese el telefono del cliente: ');
        ReadLn(Telefono);
    end;
    

end.
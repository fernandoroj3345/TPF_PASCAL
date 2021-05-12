Unit FUNCIONES_Ordenar;

interface
uses U_REGISTRO_Clientes, U_REGISTRO_Proyecto;

///Esta UNIT es indivdual y especifica para ordenar un:

procedure Ordenar_Vector_Clientes_por_cuit(Var Vect_Reg_Cliente: Array_REG_Cliente);
procedure ordenar_proyectos_por_titulo(Var Vect_Reg_Proyectos: Array_REG_Proyecto);
procedure ordenar_clientes_por_razon_social(Var Vect_Reg_Cliente: Array_REG_Cliente);
procedure ordenar_por_fecha_de_entrega(Var Vect_Reg_Proyectos: Array_REG_Proyecto);
function calculo_fecha(Fecha_a_calcular: fecha): QWord;

implementation

    function calculo_fecha(Fecha_a_calcular: fecha): QWord;///Con esta funcion calculo la cantidad de dias que tiene una fecha "X"
    begin                                                  ///Con este calculo salvo el error de caer en si es biciesto o no. 
        calculo_fecha:= (Fecha_a_calcular.anio*365 +  Fecha_a_calcular.mes*30 + Fecha_a_calcular.dia)
    end;

    procedure Ordenar_Vector_Clientes_por_cuit(Var Vect_Reg_Cliente: Array_REG_Cliente);
    Var
        AUX_REG_CLIENTE: REG_Cliente;
        i, j: LongWord;
    begin
        inicializar_registro_cliente(AUX_REG_CLIENTE);

        For i:= 1 to (High(Vect_Reg_Cliente) -1) do
        begin
            For j:= 0 to (High(Vect_Reg_Cliente)-(i)) do
            begin
                if Vect_Reg_Cliente[j].cuit > Vect_Reg_Cliente[j+1].cuit then
                begin
                    AUX_REG_CLIENTE:= Vect_Reg_Cliente[j];
                    Vect_Reg_Cliente[j]:= Vect_Reg_Cliente[j+1];
                    Vect_Reg_Cliente[j+1]:= AUX_REG_CLIENTE;
                end;
            end;
        end;

    end;

    procedure ordenar_proyectos_por_titulo(Var Vect_Reg_Proyectos: Array_REG_Proyecto);
    Var
        AUX_REG_PROYECTO: REG_Proyecto;
        i, j: LongWord;
    begin
        writeln();
        inicializar_registro_proyecto(AUX_REG_PROYECTO);
        
        For i:= 1 to (High(Vect_Reg_Proyectos) -1) do
        begin
            For j:= 0 to (High(Vect_Reg_Proyectos)-(i)) do
            begin
                if Upcase(Vect_Reg_Proyectos[j].titulo) > UpCase(Vect_Reg_Proyectos[j+1].titulo) then
                begin
                    AUX_REG_PROYECTO:= Vect_Reg_Proyectos[j];
                    Vect_Reg_Proyectos[j]:= Vect_Reg_Proyectos[j+1];
                    Vect_Reg_Proyectos[j+1]:= AUX_REG_PROYECTO;
                end;
            end;
        end;

    end;

    procedure ordenar_clientes_por_razon_social(Var Vect_Reg_Cliente: Array_REG_Cliente);
    Var
        AUX_REG_CLIENTE: REG_Cliente;
        i, j: LongWord;
    begin
        inicializar_registro_cliente(AUX_REG_CLIENTE);

        For i:= 1 to (High(Vect_Reg_Cliente) -1) do
        begin
            For j:= 0 to (High(Vect_Reg_Cliente)-(i)) do
            begin
                if Upcase(Vect_Reg_Cliente[j].razon_social) > Upcase(Vect_Reg_Cliente[j+1].razon_social) then
                begin
                    AUX_REG_CLIENTE:= Vect_Reg_Cliente[j];
                    Vect_Reg_Cliente[j]:= Vect_Reg_Cliente[j+1];
                    Vect_Reg_Cliente[j+1]:= AUX_REG_CLIENTE;
                end;
            end;
        end;
    end;


    procedure ordenar_por_fecha_de_entrega(Var Vect_Reg_Proyectos: Array_REG_Proyecto);
    Var
        AUX_REG_PROYECTO: REG_Proyecto;
        i, j: LongWord;
    begin
        inicializar_registro_proyecto(AUX_REG_PROYECTO);
        
        For i:= 1 to (High(Vect_Reg_Proyectos) -1) do
        begin
            For j:= 0 to (High(Vect_Reg_Proyectos)-(i)) do
            begin
            
                if calculo_fecha(Vect_Reg_Proyectos[j].fecha_de_entrega) > calculo_fecha(Vect_Reg_Proyectos[j+1].fecha_de_entrega) then
                begin
                    AUX_REG_PROYECTO:= Vect_Reg_Proyectos[j];
                    Vect_Reg_Proyectos[j]:= Vect_Reg_Proyectos[j+1];
                    Vect_Reg_Proyectos[j+1]:= AUX_REG_PROYECTO;
                end;

            end;
        end;

    end;

end.
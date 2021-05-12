Unit FUNCIONES_Listados;

interface
uses U_REGISTRO_Clientes, U_ARCHIVO_Clientes, 
     U_REGISTRO_Proyecto, U_ARCHIVO_Proyecto;
     var
        Pos: Integer;
procedure Listado_de_proyectos_por_titulo(Var ARCHIVO_Proyecto: ARCH_Proyecto; Var Vect_Reg_Proyectos: Array_REG_Proyecto);
procedure Listado_de_clientes_por_razon_social(Var ARCHIVO_Cliente: ARCH_Clientes; Var Vect_Reg_Cliente: Array_REG_Cliente);
procedure Listado_de_proyectos_por_titulo_en_rango_de_fechas(Var ARCHIVO_Proyecto: ARCH_Proyecto; Var Vect_Reg_Proyectos: Array_REG_Proyecto);
procedure Listar_todos_los_proyectos_de_un_cliente(Var ARCHIVO_Proyecto: ARCH_Proyecto;Var ARCHIVO_Cliente: ARCH_Clientes;Var Vect_Reg_Proyectos: Array_REG_Proyecto;Var Vect_Reg_Cliente: Array_REG_Cliente);
procedure Listar_todos_los_proyectos_entregados(Var Vect_Reg_Proyectos: Array_REG_Proyecto; Var ARCHIVO_Proyecto: ARCH_Proyecto);

implementation
uses crt, FUNCIONES_Buscar, FUNCIONES_Ordenar;
///Listo los titulos alfabeticamente (pascal diferencia que es un string y que letras esta antes que la z).
    procedure Listado_de_proyectos_por_titulo(Var ARCHIVO_Proyecto: ARCH_Proyecto; Var Vect_Reg_Proyectos: Array_REG_Proyecto);
    Var
        i: LongWord;
        j: Byte;
    begin
        j:= 0;
        inicializar_vector_registro_proyecto(Vect_Reg_Proyectos);
        Abrir_archivo_proyecto(ARCHIVO_Proyecto);
        Cargar_Archivo_en_Vector_Proyecto(ARCHIVO_Proyecto, Vect_Reg_Proyectos);
        Close(ARCHIVO_Proyecto);//Siempre cierro el arhchivo por que o es para escritura o es para lectura
 
        ordenar_proyectos_por_titulo(Vect_Reg_Proyectos);//Esta linea ordena por titulo, segun requisito del tp.

        For i:= 0 to High(Vect_Reg_Proyectos) do
        begin
            Inc(j);
            mostrar_registro_proyecto(Vect_Reg_Proyectos[i]);
            WriteLn();
           // readkey;

            if j = 3 then //muestro de 3 registros.
            begin
                readkey;
                j:= 0;
                ClrScr;//limpio y seteo en cero
            end;
            
        end;
    readkey;
    end;


    procedure Listado_de_clientes_por_razon_social(Var ARCHIVO_Cliente: ARCH_Clientes; Var Vect_Reg_Cliente: Array_REG_Cliente);
    Var
        i: LongWord;
        j: Byte;
    begin
        j:= 0;

        Inicializar_Vector_registro_cliente(Vect_Reg_Cliente);
        Abrir_archivo_clientes(ARCHIVO_Cliente);
        Cargar_Archivo_en_Vector_Registro_Cliente(ARCHIVO_Cliente, Vect_Reg_Cliente);
        Close(ARCHIVO_Cliente);

        ordenar_clientes_por_razon_social(Vect_Reg_Cliente);

        For i:= 0 to High(Vect_Reg_Cliente) do
        begin
            Inc(j);

            mostrar_registro_cliente(Vect_Reg_Cliente[i]);
            WriteLn();
           // readkey;

            if j = 3 then
            begin
                readkey;
                j:= 0;
                ClrScr;
            end;
        end;
        readkey;
    end;

    procedure Listado_de_proyectos_por_titulo_en_rango_de_fechas(Var ARCHIVO_Proyecto: ARCH_Proyecto; Var Vect_Reg_Proyectos: Array_REG_Proyecto);
    Var
        i: LongWord;//solo devuelve numeros positivos
        j: Byte;
        Fecha_inferior, Fecha_superior: fecha;
        diaInf,mesInf,diaSup,mesSup:Byte;
        anioInf,anioSup:LongWord;

    begin
        j:= 0;
        
        inicializar_vector_registro_proyecto(Vect_Reg_Proyectos);
        Abrir_archivo_proyecto(ARCHIVO_Proyecto);
        Cargar_Archivo_en_Vector_Proyecto(ARCHIVO_Proyecto, Vect_Reg_Proyectos);
        Close(ARCHIVO_Proyecto);

        WriteLn('Fecha inferior', salto);
        CargarFecha1(diaInf,mesInf,anioInf);
        Fecha_inferior.dia := diaInf;
        Fecha_inferior.mes := mesInf;
        Fecha_inferior.anio := anioInf;
        //Cargar_Fecha_de_entrega_Proyecto(Fecha_inferior);
        WriteLn(salto, 'Fecha superior', salto);
        CargarFecha2(diaSup,mesSup,anioSup);
        Fecha_superior.dia := diaSup;
        Fecha_superior.mes := mesSup;
        Fecha_superior.anio := anioSup;
        //Cargar_Fecha_de_entrega_Proyecto(Fecha_superior);
        
        
        ordenar_proyectos_por_titulo(Vect_Reg_Proyectos);

        For i:= 0 to High(Vect_Reg_Proyectos) do
        begin

///si la fecha esta en el rango de fechas ingresadas, el proyecto fue entregado//
            if ((calculo_fecha(Vect_Reg_Proyectos[i].fecha_de_entrega) >= calculo_fecha(Fecha_inferior)) AND (calculo_fecha(Vect_Reg_Proyectos[i].fecha_de_entrega) <= calculo_fecha(Fecha_superior)) AND (Vect_Reg_Proyectos[i].exporta = True)) then
            begin
                Inc(j);
                mostrar_registro_proyecto(Vect_Reg_Proyectos[i]);
                WriteLn();
                //readkey;
            

                if j = 3 then
                begin
                    readkey;
                    j:= 0;
                    ClrScr;
                end;
            end;

        end;
    readkey;
    end;

///Este procedimiento trabaja con ambos archivos , "CLIENTES"y "PROYECTOS"
//Los demas resoluciones de problemas no lo requerian///

    procedure Listar_todos_los_proyectos_de_un_cliente(Var ARCHIVO_Proyecto: ARCH_Proyecto;Var ARCHIVO_Cliente: ARCH_Clientes;Var Vect_Reg_Proyectos: Array_REG_Proyecto;Var Vect_Reg_Cliente: Array_REG_Cliente);
    Var
        Vect_proyectos_cliente: Array_REG_Proyecto;
        Cuit: QWord;
        Cant_de_proyectos: LongWord;// le doy numeros positivos hasta 10 cifras
        costo_total: Double;
        Posicion: LongInt;//declaro un entero largo
        i, j: LongWord;

    begin
        j:= 0;
        Cant_de_proyectos:= 0;
        costo_total:= 0;
        Inicializar_Vector_registro_cliente(Vect_Reg_Cliente);
        inicializar_vector_registro_proyecto(Vect_Reg_Proyectos);

        Abrir_archivo_clientes(ARCHIVO_Cliente);
        Abrir_archivo_proyecto(ARCHIVO_Proyecto);

        Cargar_Archivo_en_Vector_Registro_Cliente(ARCHIVO_Cliente, Vect_Reg_Cliente);
        Cargar_Archivo_en_Vector_Proyecto(ARCHIVO_Proyecto, Vect_Reg_Proyectos);

        Close(ARCHIVO_Cliente);
        Close(ARCHIVO_Proyecto);

        Write('Ingrese el cuit del cliente: ');
        ReadLn(Cuit);
        
        Ordenar_Vector_Clientes_por_cuit(Vect_Reg_Cliente);
        Posicion:= Buscar_Cuit_BBIN(Vect_Reg_Cliente, Cuit);

        if Posicion = -1 then
        begin
            Write(salto, Salto, 'Cliente no existente', Salto, 
                  'Presione una tecla para continuar...');
            readkey;
        end
        else
        begin

            for i:= 0 to High(Vect_Reg_Proyectos) do
            begin
                if Vect_Reg_Proyectos[i].cuit = Cuit then //Contabilizo los proyectos que tenga el CUIT buscado
                begin
                    Inc(Cant_de_proyectos);
                    costo_total+= Vect_Reg_Proyectos[i].costo; //costo_total+= [es un acumulador]
                end;
            end;
            
            if Cant_de_proyectos > 0 then
            begin
            
                //mostrar_registro_cliente(Vect_Reg_Cliente[Posicion]);
                Writeln(Salto, 'Costo total: ', costo_total:0:2, 'Cantidad de proyectos: ', Cant_de_proyectos);
                WriteLn;

                //Window(1,10,80,26);

                for i:= 0 to High(Vect_Reg_Proyectos) do
                begin
                    if Vect_Reg_Proyectos[i].cuit = Cuit then
                    begin
                        inc(j);
                        mostrar_registro_proyecto(Vect_Reg_Proyectos[i]);
                        WriteLn();
                        //readkey;

                        if j = 2 then
                        begin
                            readkey;
                            j:= 0;
                            ClrScr;
                        end;
                    end;
                end;
                //window(1,1,80,25);
            end
            else
            begin
                Write('El Cliente con CUIT ', Cuit, ' no tiene proyectos cargados', Salto,'Presione una tecla para continuar...');
                Readkey;
            end;

            
        end;
        readkey;
    end;

    procedure Listar_todos_los_proyectos_entregados(Var Vect_Reg_Proyectos: Array_REG_Proyecto; Var ARCHIVO_Proyecto: ARCH_Proyecto);
    Var
        i: LongWord;
        j: Byte;
        Fecha_inferior, Fecha_superior: fecha;
    begin
        j:= 0;
        inicializar_vector_registro_proyecto(Vect_Reg_Proyectos);
        Abrir_archivo_proyecto(ARCHIVO_Proyecto);
        Cargar_Archivo_en_Vector_Proyecto(ARCHIVO_Proyecto, Vect_Reg_Proyectos);
        Close(ARCHIVO_Proyecto);

        WriteLn('Fecha inferior', salto);
        Cargar_Fecha_de_entrega_Proyecto(Fecha_inferior);
        WriteLn(salto, 'Fecha superior', salto);
        Cargar_Fecha_de_entrega_Proyecto(Fecha_superior);
        
        ClrScr;

        ordenar_proyectos_por_titulo(Vect_Reg_Proyectos);

        For i:= 0 to High(Vect_Reg_Proyectos) do
        begin
            if (calculo_fecha(Vect_Reg_Proyectos[i].fecha_de_entrega) >= calculo_fecha(Fecha_inferior)) AND (calculo_fecha(Vect_Reg_Proyectos[i].fecha_de_entrega) <= calculo_fecha(Fecha_superior)) then
            begin
                inc(j);
                mostrar_registro_proyecto(Vect_Reg_Proyectos[i]);
                WriteLn();
                //readkey;
            

                if j = 3 then
                begin
                    readkey;
                    j:= 0;
                    ClrScr;
                end;
            end;

        end;

    end;
end.
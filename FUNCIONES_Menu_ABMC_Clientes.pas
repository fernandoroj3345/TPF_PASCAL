unit FUNCIONES_Menu_ABMC_Clientes;

interface
uses U_ARCHIVO_Clientes, U_REGISTRO_Clientes;

procedure Alta_Clientes(Var ARCHIVO_Clientes: ARCH_Clientes );
procedure Baja_Clientes(Var ARCHIVO_Clientes: ARCH_Clientes );
procedure Modificar_Cliente(Var ARCHIVO_Clientes: ARCH_Clientes );
procedure Consulta_Cliente(Var ARCHIVO_Clientes: ARCH_Clientes);

implementation

uses crt, U_REGISTRO_Proyecto, 
    FUNCIONES_Buscar, FUNCIONES_Ordenar;

   procedure Alta_Clientes(Var ARCHIVO_Clientes: ARCH_Clientes);
    Var
        REGISTRO_Cliente: REG_Cliente;
        REGISTRO_Cliente_Vacio_Para_Busqueda: REG_Cliente;
        Opcion: Char;
        Pos_Cliente: Integer;
    begin

        repeat
            ClrScr;
            Opcion:= ' ';
            inicializar_registro_cliente(REGISTRO_Cliente);
            inicializar_registro_cliente(REGISTRO_Cliente_Vacio_Para_Busqueda);

            Cargar_Cuit(REGISTRO_Cliente.cuit);

            //Inicializar_Vector_registro_cliente(Vect_R_Cliente);//no iria
            Abrir_archivo_clientes(ARCHIVO_Clientes);//iria ordenar anrchivo, abro cierro y busco sobre el archivo
            Pos_Cliente:= Buscar_Cuit_Secuencial_En_Archivo(ARCHIVO_Clientes, REGISTRO_Cliente_Vacio_Para_Busqueda, REGISTRO_Cliente.cuit);
            if (Pos_Cliente = -1) then //Si el cuit ingresado no existe en el archivo, lo doy de alta
            begin
                WriteLn();
                Cargar_Razon_Social_Cliente(REGISTRO_Cliente.razon_social);
                WriteLn();
                Cargar_Telefono_Cliente(REGISTRO_Cliente.telefono);
                WriteLn();
                Cargar_Domicilio_Cliente(REGISTRO_Cliente.domicilio);
                WriteLn();
                Cargar_Email_Cliente(REGISTRO_Cliente.email);
                //---------------------------------------------
                REGISTRO_Cliente.estado := True; //lo cargo como activo al cliente al darlo de alta.
                //---------------------------------------------               
                Write(Salto, Salto, 'Desea guardar el cliente? (Y/N)');

                repeat
                    Opcion:= Upcase(readkey);
                until(Opcion in  ['Y','N']);

                If Opcion = 'Y' then
                begin
                    
                    Guardar_archivo_Clientes(ARCHIVO_Clientes, REGISTRO_Cliente, FileSize(ARCHIVO_Clientes));
                    Close(ARCHIVO_Clientes);
                    Write(Salto, Salto, 'Guardado con exito!!', Salto, 'Presione una tecla para continaur...');
                    readkey;
                end
                else
                begin
                    Write(Salto, Salto, 'El registro no fue guardado!!', Salto, 'Presione una tecla para continaur...');
                    Close(ARCHIVO_Clientes);
                    readkey;
                end;

            end
            else
            begin
                Write(Salto, Salto, 'Error, el cuit ', REGISTRO_Cliente.cuit, ' ya existe, por favor, ingrese un cuit diferente');
                Close(ARCHIVO_Clientes);
            end;

            Write(Salto, Salto,'Desea volver a ingresar otro cliente? (Y/N)');

            repeat
                Opcion:= Upcase(readkey);
            until(Opcion in  ['Y','N']);

        until not (Opcion = 'Y');

    end;



    procedure Baja_Clientes(Var ARCHIVO_Clientes: ARCH_Clientes);
    Var
        R_Cliente: REG_Cliente;
        REGISTRO_Cliente_Vacio_Para_Busqueda: REG_Cliente;
        //ARCHIVO_Clientes: ARCH_Clientes; 
        Opcion: Char;
        Cuit: QWord;
        Pos_Cliente: Integer;

    begin

        Pos_Cliente:= 0;
        inicializar_registro_cliente(R_Cliente);
        inicializar_registro_cliente(REGISTRO_Cliente_Vacio_Para_Busqueda);
        Abrir_archivo_clientes(ARCHIVO_Clientes);
        //Close(ARCHIVO_Clientes);

        Write('Ingrese el Cuit del cliente: ');
        ReadLn(Cuit);

        Pos_Cliente:= Buscar_Cuit_Secuencial_En_Archivo(ARCHIVO_Clientes, REGISTRO_Cliente_Vacio_Para_Busqueda, Cuit);///Guardo la posicion en Pos_Cliente.
        
        if Pos_Cliente = -1 then// si la posicion es menor a -1 da un error, y el cliente no existe.
        begin
            WriteLn(Salto,'Error, el Cliente con cuit ', Cuit, ' no existe', Salto, 
            'Presione una tecla para continuar...');
            readkey;
            Close(ARCHIVO_Clientes);
        end
        else
        begin
            //cargo en el registro(vacio: R_Cliente) el cliente que encontre en la posicion.
            Cargar_Archivo_en_Registro_Cliente(ARCHIVO_Clientes, R_Cliente, Pos_Cliente );

            if R_Cliente.estado = True then//Pero si si existe
            begin   
                Write(Salto, 'El usuario esta dado de alta, deseea darlo de baja? (Y/N)',Salto);
            end
            else
            begin
                Write(Salto, 'El usuario esta dado de baja, deseea darlo de alta? (Y/N)',Salto);
            end;

            repeat
                Opcion:= Upcase(readkey);
            until Opcion in ['Y','N'];


            if Opcion = 'Y' then
            begin

                Case R_Cliente.estado Of
                    True:
                        begin
                           R_Cliente.estado:= False;
                            Write(Salto, 'El usuario fue dado de baja con exito!', Salto,
                                  'Presione una tecla para continuar...');
                        end;
                    False:
                        begin
                            R_Cliente.estado:= True;//Si esta dado de baja pasa de estado a false a True.
                             Write(Salto, 'El usuario fue dado de alta con exito!', Salto,
                                  'Presione una tecla para continuar...');
                        end;
                end;
                readkey;

                //Abrir_archivo_clientes(ARCHIVO_Clientes);
                Guardar_archivo_Clientes(ARCHIVO_Clientes, R_Cliente, Pos_Cliente);
                Close(ARCHIVO_Clientes);
            end;

        end;
    end;

    procedure Modificar_Cliente(Var ARCHIVO_Clientes: ARCH_Clientes );
    Var
        R_Cliente: REG_Cliente;
        R_Cliente_Modificado: REG_Cliente;
        Opcion: Char;
        Cuit: QWord;
        Pos_Cliente_En_Archivo: LongInt;

    begin

        inicializar_registro_cliente(R_Cliente);
        inicializar_registro_cliente(R_Cliente_Modificado);
        Abrir_archivo_clientes(ARCHIVO_Clientes);

        Write('Ingrese el cuit del cliente: ');
        ReadLn(Cuit);

        Pos_Cliente_En_Archivo:= Buscar_Cuit_Secuencial_En_Archivo(ARCHIVO_Clientes, R_Cliente, Cuit);

        if Pos_Cliente_En_Archivo = -1 then
        begin
            WriteLn('Error, el cliente con cuit ', Cuit, ' no existe', Salto, 
            'Presione una tecla para continuar...');
        end
        else
        begin

            Cargar_Archivo_en_Registro_Cliente(ARCHIVO_Clientes, R_Cliente, Pos_Cliente_En_Archivo);
            R_Cliente_Modificado := R_Cliente; //copio los datos para no perderlos

            if R_Cliente.estado = True then
            begin               
                WriteLn('[1]-Razon social', Salto,
                        '[2]-Telefono', Salto,
                        '[3]-Domicilio', Salto,
                        '[4]-Email', Salto, Salto,
                        'Elija una opcion');
                         WriteLn(Salto);

                repeat
                    Opcion:= readkey;
                until Opcion in ['1'..'4'];


                Case Opcion of
                    '1':
                        Cargar_Razon_Social_Cliente(R_Cliente_Modificado.razon_social);
                    '2':
                        Cargar_Telefono_Cliente(R_Cliente_Modificado.telefono);
                    '3':
                        Cargar_Domicilio_Cliente(R_Cliente_Modificado.domicilio);
                    '4':
                        Cargar_Email_Cliente(R_Cliente_Modificado.email);
                end;
                    ClrScr;
                    WriteLn('DATOS ANTES DE ACTUALIZAR');
                    mostrar_registro_cliente(R_Cliente);

                    WriteLn(Salto);
                    
                    WriteLn('DATOS DESPUES DE ACTUALIZAR');
                    mostrar_registro_cliente(R_Cliente_Modificado);

                    WriteLn(Salto, 'Desea guarda los cambios? (Y/N)');
                

                repeat
                    Opcion:= UpCase(readkey);
                until Opcion in ['Y','N'];

                if Opcion = 'Y' then
                begin
                    //Abrir_archivo_clientes(ARCHIVO_Clientes);
                    Guardar_archivo_Clientes(ARCHIVO_Clientes, R_Cliente_Modificado, Pos_Cliente_En_Archivo);//R_Cliente(aca tgo todos los datos mnodificados)
                    //Close(ARCHIVO_Clientes);

                    Write(Salto, 'Guardado con exito!!', Salto, 'Presione una tecla para continuar...');
                end
                else
                begin
                    Write(Salto, 'El cambio no fue guardado!!', Salto, 'Presione una tecla para continuar...');
                end;
            end
            else
            begin
                 Write(Salto, 'El cliente a consultar esta dado de baja', Salto, 
                 'Presione una tecla para continuar...');
            end;
        end;
        Close(ARCHIVO_Clientes);

        readkey;
    end;

    procedure Consulta_Cliente(Var ARCHIVO_Clientes: ARCH_Clientes);
    Var
        R_Cliente: REG_Cliente;
        Cuit: QWord;
        Pos_Cliente: LongInt;

    begin
        inicializar_registro_cliente(R_Cliente);
        Abrir_archivo_clientes(ARCHIVO_Clientes);

        Write('Ingrese el cuit del cliente: ');
        ReadLn(Cuit);


        Pos_Cliente:= Buscar_Cuit_Secuencial_En_Archivo(ARCHIVO_Clientes, R_Cliente, Cuit);//guardo la posicion, y hago el bbin segun el cuit.

        if Pos_Cliente = -1 then //NO EXISTE
        begin
            WriteLn('Error, el cliente con cuit ', Cuit, ' no existe', Salto, 
            'Presione una tecla para continuar...');
        end
        else //SI EXISTE, ENTONCES LO CARGO AL REGISTRO PARA MOSTRARLO EN PANTALLA
        begin
            Cargar_Archivo_en_Registro_Cliente(ARCHIVO_Clientes, R_Cliente, Pos_Cliente);
            WriteLn();
            mostrar_registro_cliente(R_Cliente);//Muestro el cliente.
     
        end;

        Close(ARCHIVO_Clientes);

        readkey;
    end;

end.
unit FUNCIONES_Menu_ABMC_Proyectos;

interface
uses U_ARCHIVO_Proyecto, U_REGISTRO_Proyecto, FUNCIONES_Buscar, U_ARCHIVO_Clientes,U_REGISTRO_Clientes;

procedure Alta_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto);
procedure Baja_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto);
procedure Modificacion_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto);
procedure Consulta_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto);

implementation

uses crt;

  procedure Alta_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto);
    Var
        R_Proyecto: REG_Proyecto;
        Opcion: Char;
        auxCuit: QWord;
        Pos_Cliente: Integer;
        ARCHIVO_Clientes: ARCH_Clientes;
        R_Cliente: REG_Cliente;
        encontrado: Boolean;


    begin

        Repeat
            Opcion:= ' ';// doy un valor nulo para que no adquiera ningun valor dela memoria.
            inicializar_registro_proyecto(R_Proyecto);
            encontrado := false;
            ClrScr;
            //Cargar_Cuit(R_Proyecto.cuit);//Cargo el cuit primero para llevar un orden con la unit clientes, que tambien aranco por cuit,al proyecto lo identifico por CUIT
            while encontrado = false  do
            begin
                Write('Ingrese el Cuit: ');
                ReadLn(auxCuit);  
                Abrir_archivo_clientes(ARCHIVO_Clientes);          
                Pos_Cliente:= Buscar_Cuit_Secuencial_En_Archivo(ARCHIVO_Clientes, R_Cliente,auxCuit);
                if Pos_Cliente <> -1 then //Significa que lo encontro
                begin
                    Cargar_Archivo_en_Registro_Cliente(ARCHIVO_Clientes, R_Cliente, Pos_Cliente);
                    WriteLn();
                    WriteLn(R_Cliente.razon_social);
                    Close(ARCHIVO_Clientes);
                    encontrado := true;
                end
                else
                begin
                    WriteLn('El Cuit ingresado no existe.. Presione ENTER para ingresar otro');
                    Close(ARCHIVO_Clientes);
                    encontrado := false;
                    readkey;
                    ClrScr;
           
                end;
               
            end;
            
            WriteLn();
            Cargar_Titulo_Proyecto(R_Proyecto.titulo);
            WriteLn();
            Cargar_Costo_Proyecto(R_Proyecto.costo);
            WriteLn();
            Cargar_Director_Proyecto(R_Proyecto.director);
            WriteLn();
            Cargar_Fecha_de_entrega_Proyecto(R_Proyecto.fecha_de_entrega);
            WriteLn();
            Cargar_Exporta_Proyecto(R_Proyecto.exporta);
            
            Write(Salto, Salto, 'Seguro que desea guardar el proyecto (Y/N)?');
            
            repeat
                Opcion:= upcase(readkey);
            until Opcion in ['Y','N'];

            if Opcion = 'Y' then
            //en esta porcion de codigo utilizo un archivo y un registro.
            begin ///utilizo archivos y proyectos.
                Abrir_archivo_proyecto(Archivo_Proyecto);                 ///FileSizeMe da la catidad maxima de elementos.
                R_Proyecto.id_proyecto:= FileSize(Archivo_Proyecto) + 1; //Obtengo el ID y FileSize +1 xq FiliSize empieza desde el numero cero, un ID 0 no tendria sentido, cuento desde el 1
                Guardar_archivo_Proyecto(Archivo_Proyecto, R_Proyecto, FileSize(Archivo_Proyecto));//Por ulimo paso la ultima posicion del archivo.
                Close(Archivo_Proyecto);
                Write(Salto, Salto, 'Guardado con exito!!', Salto, 'Presione una tecla para continuar...');
                readkey;
            end
            else
            begin
                Write(Salto, Salto, 'El registro no fue guardado!!', Salto, 'Presione una tecla para continuar...');
                readkey;
            end;

            Write(Salto, Salto, 'Desea agregar otro proyecto (Y/N)?');//si es N , me devuelve al MENU genaral
            
            repeat
                Opcion:= upcase(readkey);
            until Opcion in ['Y','N'];

        until not (Opcion = 'Y');

    end;


    procedure Baja_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto);
    Var 
        R_Proyecto: REG_Proyecto;
        ID: LongWord;
        Opcion: Char;
        Posicion:Longint;
        Registro_Aux:REG_Proyecto;//guardo los datos del proyecto buscado
               
    begin
        inicializar_registro_proyecto(R_Proyecto);
        inicializar_registro_proyecto(Registro_Aux);
        Abrir_archivo_proyecto(Archivo_Proyecto);
        Write('Ingrese el ID del proyecto a dar de baja: ');
        ReadLn(ID);
        
        Posicion:= Buscar_idProyecto_Secuencial_En_Archivo(Archivo_Proyecto,R_Proyecto,ID);
        
        if Posicion <> -1 then 
        begin
            Cargar_Archivo_en_Registro_Proyecto(Archivo_Proyecto, Registro_Aux, Posicion);
            WriteLn();

            if Registro_Aux.estado = True then
            begin   
                Write('El proyecto esta dado de alta, deseea darlo de baja? (Y/N)',Salto);
            end
            else
            begin
                Write('El proyecto esta dado de baja, deseea darlo de alta? (Y/N)',Salto);
            end;

            repeat
                Opcion:= Upcase(readkey);///Convierto con Upcase de minusculas a mayusculas segun ingres el usuario.
            until Opcion in ['Y','N'];

            if Opcion = 'Y' then
            begin

                Case Registro_Aux.estado Of
                    True:
                        begin
                           Registro_Aux.estado:= False;
                            Write(Salto,'El proyecto fue dado de baja con exito!', Salto,
                                  'Presione una tecla para continuar...');
                        end;
                    False:
                        begin
                            Registro_Aux.estado:= True;
                             Write(Salto,'El proyecto fue dado de alta con exito!', Salto,
                                  'Presione una tecla para continuar...');
                        end;
                end;
                readkey;///Readkey para que digo si fue o no dado de baja.

            end;
            
            Guardar_archivo_Proyecto(Archivo_Proyecto, Registro_Aux, Posicion);//ID-1 Para indicar que arranca desde 0
            Close(Archivo_Proyecto);
        end
        else
        begin
            Write(Salto,'El proyecto no existe...');
            Close(Archivo_Proyecto);
            readkey;
        end;
    end;

     procedure Modificacion_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto);
    Var
        R_Proyecto: REG_Proyecto;
        R_Proyecto_Modificado: REG_Proyecto;
        ID: LongWord;
        Opcion: Char;
        Posicion:Longint;
    begin
        inicializar_registro_proyecto(R_Proyecto);
        inicializar_registro_proyecto(R_Proyecto_Modificado);
        Abrir_archivo_proyecto(Archivo_Proyecto);
        Write('Ingrese el ID del proyecto a modificar: ');
        ReadLn(ID);
        Posicion:= Buscar_idProyecto_Secuencial_En_Archivo(Archivo_Proyecto, R_Proyecto,ID);
       
        if Posicion = -1  then //Verifico que el estado sea verdadero, xq si esta dado de baja no deberia de poder verificarlo.
            begin
                WriteLn('El proyecto no existe...');
                readkey;
                Close(Archivo_Proyecto);
            end
            else
            begin
                Cargar_Archivo_en_Registro_Proyecto(Archivo_Proyecto,R_Proyecto,Posicion);
                R_Proyecto_Modificado := R_Proyecto;
				    
				Writeln('[1]-Titulo');
                WriteLn('[2]-Costo');
                WriteLn('[3]-Cuit');
                WriteLn('[4]-Director');
                WriteLn('[5]-Fecha de entrega');
                WriteLn('[6]-Exporta');
                WriteLn('Elija una opcion');
                WriteLn(Salto);
                repeat
                    Opcion:= readkey;
                until Opcion in ['1'..'6'];
                //Elijo la opcion que quiero hacer y de esta forma evito repitir codigo segun la opcion 1,2,3 etc...
                case Opcion Of
                    '1':
                        Cargar_Titulo_Proyecto(R_Proyecto_Modificado.titulo);
                    '2':
                        Cargar_Costo_Proyecto(R_Proyecto_Modificado.costo);
                    '3':
                        Cargar_Cuit(R_Proyecto_Modificado.cuit);
                    '4':
                        Cargar_Director_Proyecto(R_Proyecto_Modificado.director);
                    '5':
                        Cargar_Fecha_de_entrega_Proyecto(R_Proyecto_Modificado.fecha_de_entrega);
                    '6':
                        Cargar_Exporta_Proyecto(R_Proyecto_Modificado.exporta);
                end;
                
                    ClrScr;
                    WriteLn('DATOS ANTES DE ACTUALIZAR');
                    mostrar_registro_proyecto(R_Proyecto);

                    WriteLn(Salto);
                    
                    WriteLn('DATOS DESPUES DE ACTUALIZAR');
                    mostrar_registro_proyecto(R_Proyecto_Modificado);

                    WriteLn(Salto, 'Desea guarda los cambios? (Y/N)');

                repeat
                    Opcion:= UpCase(readkey);
                until Opcion in ['Y','N'];

                if Opcion = 'Y' then
                begin
                    Guardar_archivo_Proyecto(Archivo_Proyecto, R_Proyecto_Modificado, Posicion);
                    Write(Salto, 'Guardado con exito!!', Salto, 'Presione una tecla para continuar...');
                    readkey;
                end
                else
                begin
                    Write(Salto, 'El cambio no fue guardado!!', Salto, 'Presione una tecla para continuar...');
                    readkey;
                end;
              Close(Archivo_Proyecto);
          end;  
    end;

    procedure Consulta_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto);
    Var
        R_Proyecto:REG_Proyecto;
        ID:Integer;
        posicion_ID:Longint;

    begin
        inicializar_registro_proyecto(R_Proyecto);
        Abrir_archivo_proyecto(Archivo_Proyecto);
        Write('Ingrese el ID del proyecto a consultar: ');
        ReadLn(ID);//Ingreso el ID del proyecto a consultar.
        posicion_ID:=Buscar_idProyecto_Secuencial_En_Archivo(Archivo_Proyecto,R_Proyecto,ID);
        if posicion_ID = -1 then //si es =-1 no existe
        begin
            WriteLn(Salto);
            WriteLn('Error, el proyecto con ID ', ID, ' no existe', Salto, 
            'Presione una tecla para continuar...');
        end                        
            else
                begin
                    Cargar_Archivo_en_Registro_Proyecto(Archivo_Proyecto,R_Proyecto,posicion_ID);
                    Write(Salto, 'El proyecto a consultar es:');//Salto, //'Presione una tecla para continuar...');
                    mostrar_registro_proyecto(R_Proyecto);
                end;  
            
            readkey;
            Close(Archivo_Proyecto);
            readkey;
    end;
end.
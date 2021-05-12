Unit U_MENU_GENERAL;

interface
uses U_ARCHIVO_Clientes, U_ARCHIVO_Proyecto, U_REGISTRO_Clientes, U_REGISTRO_Proyecto;

procedure Menu_General(Var Opcion: Char; Var ARCHIVO_Proyecto: ARCH_Proyecto; Var Vect_Reg_Proyectos: Array_REG_Proyecto; Var ARCHIVO_Cliente: ARCH_Clientes; Var Vect_Reg_Cliente: Array_REG_Cliente);
implementation
uses FUNCIONES_Menu_ABMC_Proyectos, FUNCIONES_Menu_ABMC_Clientes, FUNCIONES_Listados,
     crt;

    procedure Menu_ABMC_Proyecto(Var ARCHIVO_Proyecto: ARCH_Proyecto );
    Var
        Opcion: Char;
    begin
        
        Write('[1]-Alta',Salto,
              '[2]-Baja',Salto,
              '[3]-Modificar',Salto,
              '[4]-Consulta', Salto, 
              '[0]-Salir',Salto, Salto,
              'Elija una opcion');
            
        repeat
            Opcion:= readkey;          
        until Opcion in ['0'..'4']; 
        
        ClrScr;

        Case Opcion Of
            '1':
                Alta_Proyecto(ARCHIVO_Proyecto);
            '2':
                Baja_Proyecto(ARCHIVO_Proyecto);
            '3':
                Modificacion_Proyecto(ARCHIVO_Proyecto);
            '4':
                Consulta_Proyecto(ARCHIVO_Proyecto);
        end;

    end;

    procedure Menu_ABMC_Cliente(Var ARCHIVO_Clientes: ARCH_Clientes);
    Var
        Opcion: Char;
    begin
        
        Write('[1]-Alta',Salto,
              '[2]-Baja',Salto,
              '[3]-Modificar',Salto,
              '[4]-Consulta', Salto, 
              '[0]-Salir',Salto, Salto,
              'Elija una opcion');
            
        repeat
            Opcion:= readkey;
        until Opcion in ['0'..'4']; 
        
        ClrScr;

        Case Opcion Of
            '1':
                Alta_Clientes(ARCHIVO_Clientes);
            '2':
                Baja_Clientes(ARCHIVO_Clientes);
            '3':
                Modificar_Cliente(ARCHIVO_Clientes);
            '4':
                Consulta_Cliente(ARCHIVO_Clientes);
        end;

    end;


    procedure Menu_General(Var Opcion: Char; Var ARCHIVO_Proyecto: ARCH_Proyecto; Var Vect_Reg_Proyectos: Array_REG_Proyecto; Var ARCHIVO_Cliente: ARCH_Clientes; Var Vect_Reg_Cliente: Array_REG_Cliente);
    begin
        
 textcolor(LightRed);
                Gotoxy(2,1);writeln('                                                                                                                      ');
                Gotoxy(2,2);writeln('                                                                                                                      ');
                Gotoxy(2,3);writeln(' ###########    ############    ###########  ############     ##       ##           ##     ############   ');
                Gotoxy(2,4);writeln(' ##             ##        ##    ##                ##          ##       ####         ##     ##             ');
                Gotoxy(2,5);writeln(' ##             ##        ##    ##                ##          ##       ##  ##       ##     ##             ');
                Gotoxy(2,6);writeln(' ############   ##        ##    ###########       ##          ##       ##    ##     ##     ##             ');
                Gotoxy(2,7);writeln('           ##   ##        ##    ##                ##          ##       ##      ##   ##     ##             ');
                Gotoxy(2,8);writeln('           ##   ##        ##    ##                ##          ##       ##        ## ##     ##             ');
                Gotoxy(2,9);writeln(' ############   ############    ##                ##      ##  ##       ##           ##     ############   ');
textcolor(white);
writeln();

        Write('[1]-Menu ABMC Proyecto', Salto,
              '[2]-Menu ABMC Cliente', Salto,
              '[3]-Listado de proyectos ordenados por titulo', Salto,
              '[4]-Listado de clientes por razon social', Salto, 
              '[5]-Listado de proyectos ordenados por titulo que fueron exportados en un rango de fechas', Salto,
              '[6]-Listado de los proyectos de software que contrato un cliente', Salto, 
              '[7]-Listado de los proyectos entregados', Salto,
              '[0]-Salir',Salto, Salto,
              'Elija una opcion');
            
        repeat
            Opcion:= readkey;
        until Opcion in ['0'..'7']; 
        
        ClrScr;
        //SACAR VECTORES DE LOS LISTADOS!!!!!!
        Case Opcion Of
            '1':
                Menu_ABMC_Proyecto(ARCHIVO_Proyecto);
            '2':
                Menu_ABMC_Cliente(ARCHIVO_Cliente);
            '3':
                Listado_de_proyectos_por_titulo(ARCHIVO_Proyecto, Vect_Reg_Proyectos);
            '4':
                Listado_de_clientes_por_razon_social(ARCHIVO_Cliente, Vect_Reg_Cliente);
            '5':
                Listado_de_proyectos_por_titulo_en_rango_de_fechas(ARCHIVO_Proyecto, Vect_Reg_Proyectos);
            '6':
                Listar_todos_los_proyectos_de_un_cliente( ARCHIVO_Proyecto, ARCHIVO_Cliente, Vect_Reg_Proyectos, Vect_Reg_Cliente);
            '7':
                Listar_todos_los_proyectos_entregados(Vect_Reg_Proyectos, ARCHIVO_Proyecto);
        end;

    end;

end.

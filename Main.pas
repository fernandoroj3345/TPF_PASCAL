Program Main;
uses crt, U_REGISTRO_Proyecto, U_ARCHIVO_Proyecto,
       FUNCIONES_Menu_ABMC_Proyectos, FUNCIONES_Buscar, 
       U_REGISTRO_Clientes, U_ARCHIVO_Clientes, FUNCIONES_Menu_ABMC_Clientes,
       FUNCIONES_Listados, U_VERIFICADORES_Archivos, U_MENU_GENERAL;

    Var
        A_Cliente: ARCH_Clientes;
        A_Proyecto: ARCH_Proyecto;
        V_Cliente: Array_REG_Cliente;
        V_Proyecto: Array_REG_Proyecto;

        Op: Char;
begin
    {******VERIFICADORES*****}
    Verifico_Y_creo_archivo_Proyecto();
    Verifico_Y_creo_archivo_Cliente();
     {******VERIFICADORES*****}

    repeat 
        ClrScr;
        Menu_General(Op, A_Proyecto, V_Proyecto, A_Cliente, V_Cliente);

    until (Op = '0');

end.


//No puse los verificadores en el repeat por que se tienen que verificar una sola vez en el programa, porque que windows 
//no permite borrar los archivos cuando esta en ejecucion el programa.
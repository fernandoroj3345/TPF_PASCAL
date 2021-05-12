unit U_ARCHIVO_Proyecto;

interface
uses U_REGISTRO_Proyecto;

    Type
        ARCH_Proyecto = file of REG_Proyecto;

    const
        Directorio_Archivo_Proyecto = '.\Proyectos.dat';//Asocio el nombre logico del archivo o de la variable 
                                                        //con el nombre fisico "Proyectos.dat" 
procedure Abrir_archivo_proyecto(Var Archivo_Proyecto: ARCH_Proyecto);
procedure Guardar_archivo_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto; R_Proyecto: REG_Proyecto; Pos: LongWord);
procedure Cargar_Archivo_en_Registro_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto; Var R_Proyecto: REG_Proyecto; Pos: LongWord);
procedure Cargar_Archivo_en_Vector_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto; Var Vect_Proyecto: Array_REG_Proyecto);

implementation
uses crt;

    procedure Abrir_archivo_proyecto(Var Archivo_Proyecto: ARCH_Proyecto);
    begin
        Assign(Archivo_Proyecto, Directorio_Archivo_Proyecto);
        {$I-} reset(Archivo_Proyecto); {$I+}// salvo el error para ayudar al ioresult
    end;

    procedure Guardar_archivo_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto; R_Proyecto: REG_Proyecto; Pos: LongWord);
    begin
        seek(Archivo_Proyecto, Pos);
        write(Archivo_Proyecto, R_Proyecto);
    end;

    procedure Cargar_Archivo_en_Registro_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto; Var R_Proyecto: REG_Proyecto; Pos: LongWord);
    begin
        seek(Archivo_Proyecto, Pos);
        Read(Archivo_Proyecto, R_Proyecto);
    end;

    procedure Cargar_Archivo_en_Vector_Proyecto(Var Archivo_Proyecto: ARCH_Proyecto; Var Vect_Proyecto: Array_REG_Proyecto);
    Var
        i: LongWord;
    begin

        for i:= 0 to High(Vect_Proyecto) do
        begin
            Cargar_Archivo_en_Registro_Proyecto(Archivo_Proyecto, Vect_Proyecto[i], i);
        end;

    end;

end.   
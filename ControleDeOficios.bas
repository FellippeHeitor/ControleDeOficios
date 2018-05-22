': This program was generated by
': InForm - GUI system for QB64 - Beta version 7
': Fellippe Heitor, 2016-2018 - fellippe@qb64.org - @fellippeheitor
'-----------------------------------------------------------

'Icon: http://www.iconarchive.com/show/keyboard-keys-icons-by-chromatix/hash-icon.html
'Artist: Chromatix
'Iconset: Keyboard Keys Icons (102 icons)
'License: CC Attribution-Noncommercial-No Derivate 4.0
'Commercial usage: Not allowed

$VERSIONINFO:FILEVERSION#=0,0,0,1
$VERSIONINFO:PRODUCTVERSION#=0,0,0,1
$VERSIONINFO:CompanyName=Fellippe Heitor
$VERSIONINFO:FileDescription=Controle De Oficios TJMG
$VERSIONINFO:FileVersion=0.1b
$VERSIONINFO:InternalName=ControlDeOficios.bas
$VERSIONINFO:LegalCopyright=Open source
$VERSIONINFO:OriginalFilename=ControlDeOficios.exe
$VERSIONINFO:ProductName=Controle De Oficios TJMG
$VERSIONINFO:ProductVersion=0.1b
$VERSIONINFO:Comments=Made with QB64.

': Controls' IDs: ------------------------------------------------------------------
DIM SHARED ControleDeOficios AS LONG
DIM SHARED Frame1 AS LONG
DIM SHARED PrximoNmero AS LONG
DIM SHARED ltimoUtilizadoLB AS LONG
DIM SHARED UltimoOficioLB AS LONG
DIM SHARED Label2 AS LONG
DIM SHARED UltimaDescricaoLB AS LONG
DIM SHARED Label3 AS LONG
DIM SHARED UltimoUsuarioLB AS LONG
DIM SHARED Label4 AS LONG
DIM SHARED UsuarioAtualLB AS LONG
DIM SHARED DecriaoOpcionalLB AS LONG
DIM SHARED DescricaoTB AS LONG
DIM SHARED BT AS LONG
DIM SHARED FirstBT AS LONG, PreviousBT AS LONG
DIM SHARED NextBT AS LONG, LastBT AS LONG
DIM SHARED MenuBar1 AS LONG
DIM SHARED MenuItem1 AS LONG
DIM SHARED MenuBar2 AS LONG
DIM SHARED MenuItem2 AS LONG
DIM SHARED MenuItem3 AS LONG
DIM SHARED Label10 AS LONG
DIM SHARED UltimoOficioTB AS LONG

DIM SHARED Ultimo AS LONG, Proximo AS LONG
DIM SHARED Atual AS LONG
DIM SHARED Usuario AS STRING
DIM SHARED LastCheck AS SINGLE
DIM SHARED file$, GenericUser AS STRING

IF LTRIM$(COMMAND$(2)) = "-civel" THEN
    file$ = "oficios-civel.ini"
    Usuario = COMMAND$(1)
    GenericUser = "Secretaria C�vel"
ELSE
    file$ = "oficios.ini"
    Usuario = "Secretaria Criminal"
    GenericUser = Usuario
    IF LEN(COMMAND$(1)) THEN Usuario = COMMAND$(1)
END IF

': External modules: ---------------------------------------------------------------
'$INCLUDE:'InForm\InForm.ui'
'$INCLUDE:'InForm\xp.uitheme'
'$INCLUDE:'ini.bm'
'$INCLUDE:'ControleDeOficios.frm'

': Event procedures: ---------------------------------------------------------------
SUB __UI_BeforeInit

END SUB

SUB __UI_OnLoad
    IniSetForceReload True
    a$ = ReadSetting(file$, "controle", "UltimoNumero")
    IF LEN(a$) > 0 THEN
        Ultimo = VAL(a$)
        Atual = Ultimo
        Caption(UltimoOficioLB) = a$
        Proximo = Ultimo + 1
        Refresh
    ELSE
        WriteSetting file$, "controle", "UltimoNumero", "0"
        Caption(UltimoOficioLB) = "-"
        Caption(UltimaDescricaoLB) = "-"
        Caption(UltimoUsuarioLB) = "-"
        Proximo = 1
    END IF

    Caption(ControleDeOficios) = "Controle de Oficios - " + GenericUser
    Caption(BT) = LTRIM$(STR$(Proximo))
    Caption(Label10) = GenericUser
    Caption(UsuarioAtualLB) = Usuario
    __UI_Focus = DescricaoTB
    DoLocalBackup
    LastCheck = TIMER
END SUB

SUB DoLocalBackup
    ff = FREEFILE
    OPEN file$ FOR BINARY AS #ff
    a$ = SPACE$(LOF(ff))
    GET #ff, 1, a$
    CLOSE #ff

    OPEN ENVIRON$("USERPROFILE") + "\oficiosBackup.ini" FOR OUTPUT AS #ff: CLOSE #ff
    OPEN ENVIRON$("USERPROFILE") + "\oficiosBackup.ini" FOR BINARY AS #ff
    PUT #ff, 1, a$
    CLOSE #ff
END SUB

SUB __UI_BeforeUpdateDisplay
    Control(FirstBT).Disabled = False
    Control(PreviousBT).Disabled = False
    Control(NextBT).Disabled = False
    Control(LastBT).Disabled = False

    IF TIMER - LastCheck > 1 THEN
        Refresh
    END IF

    IF Atual = Ultimo THEN
        Control(NextBT).Disabled = True
        Control(LastBT).Disabled = True
    END IF

    IF Atual = 1 THEN
        Control(FirstBT).Disabled = True
        Control(PreviousBT).Disabled = True
    END IF

END SUB

SUB Refresh
    a$ = ReadSetting("", "controle", "UltimoNumero")
    IF VAL(a$) <> Ultimo THEN
        IF Atual = Ultimo THEN
            Atual = VAL(a$)
            Ultimo = Atual
        ELSE
            Ultimo = VAL(a$)
        END IF
        Proximo = Ultimo + 1
        Caption(BT) = LTRIM$(STR$(Proximo))
    END IF

    Control(UltimoOficioTB).Max = Ultimo
    Caption(UltimoOficioLB) = STR$(Atual)
    a$ = ReadSetting("", STR$(Atual), "Descricao")
    b$ = ReadSetting("", STR$(Atual), "Data")
    IF LEN(a$) > 0 AND LEN(b$) > 0 THEN
        a$ = b$ + ": " + a$
    ELSEIF LEN(a$) = 0 AND LEN(b$) > 0 THEN
        a$ = "Expedido em " + b$
    ELSEIF LEN(a$) = 0 AND LEN(b$) = 0 THEN
        a$ = "-"
    END IF
    Caption(UltimaDescricaoLB) = a$
    Caption(UltimoUsuarioLB) = ReadSetting("", STR$(Atual), "Usuario")

    LastCheck = TIMER
END SUB

SUB __UI_BeforeUnload

END SUB

SUB __UI_Click (id AS LONG)
    SELECT EVERYCASE id
        CASE MenuItem1
            SYSTEM
        CASE MenuItem2
            Answer = MessageBox("Controle de Of�cios - TJMG\nComarca de Espera Feliz\n(c) Fellippe Heitor, 2018", "", MsgBox_OkOnly + MsgBox_Information)
        CASE BT
            Answer = MessageBox("Confirma?", "", MsgBox_YesNo + MsgBox_Question)
            IF Answer = MsgBox_Yes THEN
                a$ = LTRIM$(STR$(Proximo))
                _CLIPBOARD$ = a$
                WriteSetting "", a$, "Data", MID$(DATE$, 4, 2) + "/" + LEFT$(DATE$, 2) + "/" + RIGHT$(DATE$, 4)
                WriteSetting "", a$, "Usuario", Usuario
                IF LEN(Text(DescricaoTB)) THEN WriteSetting "", a$, "Descricao", Text(DescricaoTB)
                WriteSetting "", "controle", "UltimoNumero", a$

                Atual = Ultimo
                Refresh
                Text(DescricaoTB) = ""
                __UI_Focus = DescricaoTB
                DoLocalBackup
            END IF
        CASE VerHistoricoBT, MenuItem3
            SHELL _HIDE _DONTWAIT "start " + file$
        CASE UltimaDescricaoLB
            a$ = ReadSetting("", STR$(Atual), "Descricao")
            IF LEN(a$) THEN
                Text(DescricaoTB) = a$
                Control(DescricaoTB).Cursor = LEN(Text(DescricaoTB))
                __UI_Focus = DescricaoTB
            END IF
        CASE FirstBT
            Atual = 1
        CASE PreviousBT
            Atual = Atual + (Atual - 1 >= 1)
        CASE NextBT
            Atual = Atual - (Atual + 1 <= Ultimo)
        CASE LastBT
            Atual = Ultimo
        CASE FirstBT, PreviousBT, NextBT, LastBT
            Refresh
            Control(UltimoOficioTB).Hidden = True
        CASE UltimoOficioLB
            Control(UltimoOficioTB).Hidden = False
            Text(UltimoOficioTB) = LTRIM$(STR$(Atual))
            SetFocus UltimoOficioTB
    END SELECT
END SUB

SUB __UI_MouseEnter (id AS LONG)
    SELECT CASE id
        CASE ControleDeOficios

        CASE Frame1

        CASE PrximoNmero

        CASE ltimoUtilizadoLB

        CASE UltimoOficioLB

        CASE Label2

        CASE UltimaDescricaoLB
            a$ = ReadSetting("", STR$(Atual), "Descricao")
            IF LEN(a$) THEN
                ToolTip(UltimaDescricaoLB) = "Clique para copiar"
            ELSE
                ToolTip(UltimaDescricaoLB) = ""
            END IF
        CASE Label3

        CASE UltimoUsuarioLB

        CASE Label4

        CASE UsuarioAtualLB

        CASE DecriaoOpcionalLB

        CASE DescricaoTB

        CASE BT

    END SELECT
END SUB

SUB __UI_MouseLeave (id AS LONG)
    SELECT CASE id
        CASE ControleDeOficios

        CASE Frame1

        CASE PrximoNmero

        CASE ltimoUtilizadoLB

        CASE UltimoOficioLB

        CASE Label2

        CASE UltimaDescricaoLB

        CASE Label3

        CASE UltimoUsuarioLB

        CASE Label4

        CASE UsuarioAtualLB

        CASE DecriaoOpcionalLB

        CASE DescricaoTB

        CASE BT

    END SELECT
END SUB

SUB __UI_FocusIn (id AS LONG)
    SELECT CASE id
        CASE DescricaoTB

        CASE BT

    END SELECT
END SUB

SUB __UI_FocusOut (id AS LONG)
    SELECT CASE id
        CASE DescricaoTB

        CASE BT

        CASE UltimoOficioTB
            Control(UltimoOficioTB).Hidden = True
            Control(UltimoOficioLB).Redraw = True
    END SELECT
END SUB

SUB __UI_MouseDown (id AS LONG)
    SELECT CASE id
        CASE ControleDeOficios

        CASE Frame1

        CASE PrximoNmero

        CASE ltimoUtilizadoLB

        CASE UltimoOficioLB

        CASE Label2

        CASE UltimaDescricaoLB

        CASE Label3

        CASE UltimoUsuarioLB

        CASE Label4

        CASE UsuarioAtualLB

        CASE DecriaoOpcionalLB

        CASE DescricaoTB

        CASE BT

    END SELECT
END SUB

SUB __UI_MouseUp (id AS LONG)
    SELECT CASE id
        CASE ControleDeOficios

        CASE Frame1

        CASE PrximoNmero

        CASE ltimoUtilizadoLB

        CASE UltimoOficioLB

        CASE Label2

        CASE UltimaDescricaoLB

        CASE Label3

        CASE UltimoUsuarioLB

        CASE Label4

        CASE UsuarioAtualLB

        CASE DecriaoOpcionalLB

        CASE DescricaoTB

        CASE BT

    END SELECT
END SUB

SUB __UI_KeyPress (id AS LONG)
    SELECT CASE id
        CASE DescricaoTB

        CASE BT

        CASE UltimoOficioTB
            IF __UI_KeyHit = 13 THEN
                Atual = VAL(Text(UltimoOficioTB))
                Control(UltimoOficioTB).Hidden = True
                Refresh
                __UI_ForceRedraw = True
            ELSEIF __UI_KeyHit = 27 THEN
                Control(UltimoOficioTB).Hidden = True
                __UI_ForceRedraw = True
            END IF
    END SELECT
END SUB

SUB __UI_TextChanged (id AS LONG)
    SELECT CASE id
        CASE DescricaoTB

    END SELECT
END SUB

SUB __UI_ValueChanged (id AS LONG)
    SELECT CASE id
    END SELECT
END SUB

SUB __UI_FormResized

END SUB

': This program was generated by
': InForm - GUI system for QB64 - Beta version 8
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
DIM SHARED UltimaDescricaoTB AS LONG
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
DIM SHARED ClearSearchBT AS LONG

DIM SHARED Primeiro AS LONG, Ultimo AS LONG, Proximo AS LONG
DIM SHARED Atual AS LONG
DIM SHARED Usuario AS STRING
DIM SHARED LastCheck AS SINGLE
DIM SHARED file$, backupFile$, GenericUser AS STRING
DIM SHARED inSearch AS _BYTE, totalFound AS LONG, searchResultIndex AS LONG
REDIM SHARED SearchResults(0) AS LONG

file$ = "oficios.ini"
backupFile$ = ENVIRON$("USERPROFILE") + "\oficios-backup.ini"
Usuario = "Secretaria Criminal"
GenericUser = Usuario
IF LEN(COMMAND$(1)) THEN Usuario = COMMAND$(1)

DIM i AS INTEGER
FOR i = 1 TO _COMMANDCOUNT
    SELECT CASE LCASE$(COMMAND$(i))
        CASE "-civel"
            file$ = "oficios-civel.ini"
            backupFile$ = ENVIRON$("USERPROFILE") + "\oficios-civel-backup.ini"
            Usuario = COMMAND$(1)
            GenericUser = "Secretaria C�vel"
            EXIT FOR
        CASE "-arquivo"
            file$ = COMMAND$(i + 1)
            backupFile$ = ENVIRON$("USERPROFILE") + "\" + file$ + "-backup.ini"
            file$ = file$ + ".ini"
        CASE "-usuario"
            Usuario = COMMAND$(i + 1)
        CASE "-setor"
            GenericUser = COMMAND$(i + 1)
    END SELECT
NEXT

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
        REDIM SearchResults(1 TO Ultimo) AS LONG
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

    IF Proximo > 1 THEN
        a$ = ReadSetting(file$, "controle", "PrimeiroNumero")
        IF LEN(a$) = 0 THEN
            'Find the first record and save the index
            DIM i AS LONG
            SHARED IniCODE
            FOR i = 1 TO Ultimo
                a$ = ReadSetting(file$, STR$(i), "Usuario")
                IF IniCODE <> 14 THEN
                    Primeiro = i
                    WriteSetting file$, "controle", "PrimeiroNumero", LTRIM$(STR$(Primeiro))
                    EXIT FOR
                END IF
            NEXT
        ELSE
            Primeiro = VAL(a$)
        END IF
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
    'backups are incremental
    a$ = ReadSetting(file$, "controle", "UltimoNumero")
    WriteSetting backupFile$, "controle", "UltimoNumero", a$

    FOR i = 1 TO VAL(a$)
        a$ = ReadSetting(file$, STR$(i), "Descricao")
        b$ = ReadSetting(file$, STR$(i), "Data")
        c$ = ReadSetting(file$, STR$(i), "Usuario")
        IF LEN(a$) > 0 OR LEN(b$) > 0 OR LEN(c$) > 0 THEN
            IF LEN(a$) THEN WriteSetting backupFile$, STR$(i), "Descricao", a$
            IF LEN(b$) THEN WriteSetting backupFile$, STR$(i), "Data", b$
            IF LEN(c$) THEN WriteSetting backupFile$, STR$(i), "Usuario", c$
        END IF
    NEXT
END SUB

SUB __UI_BeforeUpdateDisplay
    Control(FirstBT).Disabled = False
    Control(PreviousBT).Disabled = False
    Control(NextBT).Disabled = False
    Control(LastBT).Disabled = False

    IF TIMER - LastCheck > 1 THEN
        Refresh
    END IF

    IF inSearch THEN
        Control(FirstBT).ForeColor = _RGB32(0, 0, 255)
        Control(PreviousBT).ForeColor = _RGB32(0, 0, 255)
        Control(NextBT).ForeColor = _RGB32(0, 0, 255)
        Control(LastBT).ForeColor = _RGB32(0, 0, 255)
        Control(ClearSearchBT).Disabled = False

        IF searchResultIndex = totalFound THEN
            Control(NextBT).Disabled = True
            Control(LastBT).Disabled = True
        END IF

        IF searchResultIndex = 1 THEN
            Control(FirstBT).Disabled = True
            Control(PreviousBT).Disabled = True
        END IF
    ELSE
        Control(FirstBT).ForeColor = _RGB32(0)
        Control(PreviousBT).ForeColor = _RGB32(0)
        Control(NextBT).ForeColor = _RGB32(0)
        Control(LastBT).ForeColor = _RGB32(0)
        Control(ClearSearchBT).Disabled = True

        IF Atual = Ultimo THEN
            Control(NextBT).Disabled = True
            Control(LastBT).Disabled = True
        END IF

        IF Atual = Primeiro THEN
            Control(FirstBT).Disabled = True
            Control(PreviousBT).Disabled = True
        END IF
    END IF
END SUB

SUB Refresh
    IF inSearch THEN
        Caption(UltimoOficioLB) = STR$(SearchResults(searchResultIndex)) + " (" + _TRIM$(STR$(searchResultIndex)) + "/" + _TRIM$(STR$(totalFound)) + ")"
        a$ = ReadSetting(file$, STR$(SearchResults(searchResultIndex)), "Descricao")
        b$ = ReadSetting(file$, STR$(SearchResults(searchResultIndex)), "Data")
        IF LEN(a$) > 0 AND LEN(b$) > 0 THEN
            a$ = b$ + ": " + a$
        ELSEIF LEN(a$) = 0 AND LEN(b$) > 0 THEN
            a$ = "Expedido em " + b$
        ELSEIF LEN(a$) = 0 AND LEN(b$) = 0 THEN
            a$ = "-"
        END IF
        Caption(UltimaDescricaoLB) = a$
        Caption(UltimoUsuarioLB) = ReadSetting(file$, STR$(SearchResults(searchResultIndex)), "Usuario")
        Atual = SearchResults(searchResultIndex)
    ELSE
        a$ = ReadSetting(file$, "controle", "UltimoNumero")
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
        a$ = ReadSetting(file$, STR$(Atual), "Descricao")
        b$ = ReadSetting(file$, STR$(Atual), "Data")
        IF LEN(a$) > 0 AND LEN(b$) > 0 THEN
            a$ = b$ + ": " + a$
        ELSEIF LEN(a$) = 0 AND LEN(b$) > 0 THEN
            a$ = "Expedido em " + b$
        ELSEIF LEN(a$) = 0 AND LEN(b$) = 0 THEN
            a$ = "-"
        END IF
        Caption(UltimaDescricaoLB) = a$
        Caption(UltimoUsuarioLB) = ReadSetting(file$, STR$(Atual), "Usuario")
    END IF

    __UI_ForceRedraw = True
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
                REDIM SearchResults(1 TO Ultimo) AS LONG
                inSearch = False

                IF Primeiro = 0 THEN Primeiro = Atual
                Refresh
                Text(DescricaoTB) = ""
                __UI_Focus = DescricaoTB
                DoLocalBackup
            END IF
        CASE ClearSearchBT
            inSearch = False
            SetFocus DescricaoTB
            Refresh
        CASE VerHistoricoBT, MenuItem3
            SHELL _HIDE _DONTWAIT "start " + file$
        CASE UltimaDescricaoLB
            'a$ = ReadSetting(file$, STR$(Atual), "Descricao")
            'IF LEN(a$) THEN
            '    Text(DescricaoTB) = a$
            '    Control(DescricaoTB).Cursor = LEN(Text(DescricaoTB))
            '    __UI_Focus = DescricaoTB
            'END IF
            Control(UltimaDescricaoTB).Hidden = False
            Text(UltimaDescricaoTB) = ""
            SetFocus UltimaDescricaoTB
        CASE FirstBT
            IF inSearch THEN searchResultIndex = 1 ELSE Atual = Primeiro
        CASE PreviousBT
            IF inSearch THEN
                searchResultIndex = searchResultIndex + (searchResultIndex - 1 >= 1)
            ELSE
                Atual = Atual + (Atual - 1 >= Primeiro)
            END IF
        CASE NextBT
            IF inSearch THEN
                searchResultIndex = searchResultIndex - (searchResultIndex + 1 <= totalFound)
            ELSE
                Atual = Atual - (Atual + 1 <= Ultimo)
            END IF
        CASE LastBT
            IF inSearch THEN searchResultIndex = totalFound ELSE Atual = Ultimo
        CASE FirstBT, PreviousBT, NextBT, LastBT
            Refresh
            Control(UltimoOficioTB).Hidden = True
            Control(UltimaDescricaoTB).Hidden = True
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
            a$ = ReadSetting(file$, STR$(Atual), "Descricao")
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
        CASE UltimaDescricaoTB
            Control(UltimaDescricaoTB).Hidden = True
            Control(UltimaDescricaoLB).Redraw = True
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
    IF __UI_KeyHit = 27 AND inSearch = True THEN inSearch = False: SetFocus DescricaoTB: Refresh

    SELECT CASE id
        CASE DescricaoTB

        CASE BT

        CASE UltimoOficioTB
            IF __UI_KeyHit = 13 THEN
                Atual = VAL(Text(UltimoOficioTB))
                IF Atual < Primeiro THEN Atual = Primeiro
                Control(UltimoOficioTB).Hidden = True
                inSearch = False
                Refresh
            ELSEIF __UI_KeyHit = 27 THEN
                Control(UltimoOficioTB).Hidden = True
                SetFocus DescricaoTB
                __UI_ForceRedraw = True
            END IF
        CASE UltimaDescricaoTB
            IF __UI_KeyHit = 13 THEN
                DIM tempSearchString$, SearchString$, i AS LONG, j AS LONG
                REDIM Element$(0), totalElements AS LONG, readingElement AS _BYTE

                SearchString$ = ""
                tempSearchString$ = _TRIM$(Text(UltimaDescricaoTB))
                IF LEN(tempSearchString$) THEN
                    FOR i = 1 TO LEN(tempSearchString$)
                        IF ASC(tempSearchString$, i) = 37 THEN
                            IF RIGHT$(SearchString$, 1) <> "%" THEN
                                SearchString$ = SearchString$ + MID$(tempSearchString$, i, 1)
                            END IF
                        ELSE
                            SearchString$ = SearchString$ + MID$(tempSearchString$, i, 1)
                        END IF
                    NEXT

                    'Separate search elements into an array
                    FOR i = 1 TO LEN(SearchString$)
                        IF ASC(SearchString$, i) <> 37 THEN
                            IF NOT readingElement THEN
                                readingElement = True
                                totalElements = totalElements + 1
                                REDIM _PRESERVE Element$(1 TO totalElements)
                                Element$(totalElements) = Element$(totalElements) + UCASE$(MID$(SearchString$, i, 1))
                            ELSE
                                Element$(totalElements) = Element$(totalElements) + UCASE$(MID$(SearchString$, i, 1))
                            END IF
                        ELSE
                            readingElement = False
                        END IF
                    NEXT

                    '$CONSOLE
                    '_ECHO STR$(totalElements)
                    'FOR i = 1 TO totalElements
                    '    _ECHO Element$(i)
                    'NEXT

                    'Search through records...
                    totalFound = 0
                    FOR i = Primeiro TO Ultimo
                        a$ = UCASE$(ReadSetting(file$, STR$(i), "Descricao"))
                        IF totalElements = 1 THEN
                            IF (INSTR(SearchString$, "%") = 0 AND a$ = Element$(1)) OR _
                               (LEFT$(SearchString$, 1) = "%" AND RIGHT$(SearchString$, 1) <> "%" AND RIGHT$(a$, LEN(Element$(1))) = Element$(1)) OR _
                               (LEFT$(SearchString$, 1) <> "%" AND RIGHT$(SearchString$, 1) = "%" AND LEFT$(a$, LEN(Element$(1))) = Element$(1)) OR _
                               (LEFT$(SearchString$, 1) = "%" AND RIGHT$(SearchString$, 1) = "%" AND INSTR(a$, Element$(1)) > 0) THEN
                                totalFound = totalFound + 1
                                IF totalFound = 1 THEN Atual = i
                                SearchResults(totalFound) = i
                            END IF
                        ELSE
                            DIM lastPosition AS LONG, found AS _BYTE
                            lastPosition = 0
                            found = True
                            FOR j = 1 TO totalElements
                                IF j = 1 THEN
                                    'first element
                                    IF LEFT$(SearchString$, 1) = "%" THEN
                                        lastPosition = INSTR(lastPosition + 1, a$, Element$(j))
                                        IF lastPosition = 0 THEN found = False: EXIT FOR
                                    ELSE
                                        IF LEFT$(a$, LEN(Element$(j))) <> Element$(j) THEN found = False: EXIT FOR
                                    END IF
                                ELSEIF j = totalElements THEN
                                    'last element
                                    IF RIGHT$(SearchString$, 1) = "%" THEN
                                        lastPosition = INSTR(lastPosition + 1, a$, Element$(j))
                                        IF lastPosition = 0 THEN found = False: EXIT FOR
                                    ELSE
                                        IF RIGHT$(a$, LEN(Element$(j))) <> Element$(j) THEN found = False: EXIT FOR
                                    END IF
                                ELSE
                                    'middle elements
                                    lastPosition = INSTR(lastPosition + 1, a$, Element$(j))
                                    IF lastPosition = 0 THEN found = False: EXIT FOR
                                END IF
                            NEXT
                            IF found THEN
                                totalFound = totalFound + 1
                                IF totalFound = 1 THEN Atual = i
                                SearchResults(totalFound) = i
                            END IF
                        END IF
                    NEXT

                    IF totalFound > 0 THEN
                        inSearch = True
                        searchResultIndex = 1
                    ELSE
                        Answer = MessageBox("Nenhum resultado encontrado", "", MsgBox_OkOnly + MsgBox_Critical)
                    END IF
                END IF
                Control(UltimaDescricaoTB).Hidden = True
                Refresh
            ELSEIF __UI_KeyHit = 27 THEN
                Control(UltimaDescricaoTB).Hidden = True
                SetFocus DescricaoTB
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

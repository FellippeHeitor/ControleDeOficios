': This form was generated by
': InForm - GUI system for QB64 - Beta version 7
': Fellippe Heitor, 2016-2018 - fellippe@qb64.org - @fellippeheitor
'-----------------------------------------------------------
SUB __UI_LoadForm

    $EXEICON:'./Chromatix-Keyboard-Keys-Hash.ico'
    _ICON
    DIM __UI_NewID AS LONG

    __UI_NewID = __UI_NewControl(__UI_Type_Form, "ControleDeOficios", 400, 416, 0, 0, 0)
    SetCaption __UI_NewID, "Controle de Of�cios"
    Text(__UI_NewID) = "Chromatix-Keyboard-Keys-Hash.ico"
    Control(__UI_NewID).Font = SetFont("arial.ttf?/Library/Fonts/Arial.ttf?InForm/resources/NotoMono-Regular.ttf?cour.ttf", 12, "")
    Control(__UI_NewID).CenteredWindow = True
    Control(__UI_NewID).Encoding = 1252

    __UI_NewID = __UI_NewControl(__UI_Type_Frame, "Frame1", 372, 129, 14, 103, 0)
    SetCaption __UI_NewID, "Of�cios anteriores"
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).Value = 11

    __UI_NewID = __UI_NewControl(__UI_Type_Frame, "PrximoNmero", 372, 160, 14, 248, 0)
    SetCaption __UI_NewID, "Pr�ximo n�mero:"
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).Value = 5

    __UI_NewID = __UI_NewControl(__UI_Type_MenuBar, "MenuBar1", 56, 20, 8, 0, 0)
    SetCaption __UI_NewID, "&Arquivo"

    __UI_NewID = __UI_NewControl(__UI_Type_MenuBar, "MenuBar2", 47, 20, 344, 0, 0)
    SetCaption __UI_NewID, "Aj&uda"
    Control(__UI_NewID).Align = __UI_Right

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "NmeroLB", 93, 23, 10, 10, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, "N�mero:"
    Control(__UI_NewID).VAlign = __UI_Middle

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "UltimoOficioLB", 116, 23, 105, 10, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, "UltimoOficio"
    Control(__UI_NewID).Font = SetFont("arialbd.ttf", 12, "")
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).VAlign = __UI_Middle

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "Label2", 93, 23, 10, 58, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, "Descri��o:"
    Control(__UI_NewID).VAlign = __UI_Middle

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "UltimaDescricaoLB", 254, 61, 105, 60, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, "UltimaDescricao"
    Control(__UI_NewID).Font = SetFont("arialbd.ttf", 12, "")
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).WordWrap = True

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "Label3", 93, 23, 10, 34, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, "Usu�rio:"
    Control(__UI_NewID).VAlign = __UI_Middle

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "UltimoUsuarioLB", 254, 23, 105, 35, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, "UltimoUsuario"
    Control(__UI_NewID).Font = SetFont("arialbd.ttf", 12, "")
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).VAlign = __UI_Middle

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "Label4", 93, 23, 10, 10, __UI_GetID("PrximoNmero"))
    SetCaption __UI_NewID, "Usu�rio:"
    Control(__UI_NewID).VAlign = __UI_Middle

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "UsuarioAtualLB", 150, 23, 105, 10, __UI_GetID("PrximoNmero"))
    SetCaption __UI_NewID, "UsuarioAtual"
    Control(__UI_NewID).Font = SetFont("arialbd.ttf", 12, "")
    Control(__UI_NewID).VAlign = __UI_Middle

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "DecriaoOpcionalLB", 89, 33, 10, 32, __UI_GetID("PrximoNmero"))
    SetCaption __UI_NewID, "Descri��o (opcional):"
    Control(__UI_NewID).VAlign = __UI_Middle
    Control(__UI_NewID).WordWrap = True

    __UI_NewID = __UI_NewControl(__UI_Type_TextBox, "DescricaoTB", 251, 23, 105, 32, __UI_GetID("PrximoNmero"))
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).CanHaveFocus = True

    __UI_NewID = __UI_NewControl(__UI_Type_Button, "BT", 256, 76, 58, 74, __UI_GetID("PrximoNmero"))
    SetCaption __UI_NewID, "000"
    ToolTip(__UI_NewID) = "Clique para utilizar este n�mero de of�cio"
    Control(__UI_NewID).Font = SetFont("arialbd.ttf", 72, "")
    Control(__UI_NewID).CanHaveFocus = True

    __UI_NewID = __UI_NewControl(__UI_Type_PictureBox, "PictureBox2", 400, 64, 0, 23, 0)
    Control(__UI_NewID).Stretch = False
    Control(__UI_NewID).BackColor = _RGB32(255, 255, 255)

    __UI_NewID = __UI_NewControl(__UI_Type_PictureBox, "TJMGpngPX", 210, 64, 0, 23, 0)
    LoadImage Control(__UI_NewID), "TJMG.png"
    Control(__UI_NewID).Stretch = False
    Control(__UI_NewID).BackColor = _RGB32(255, 255, 255)
    Control(__UI_NewID).Align = __UI_Center
    Control(__UI_NewID).VAlign = __UI_Middle

    __UI_NewID = __UI_NewControl(__UI_Type_Button, "FirstBT", 28, 23, 228, 10, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, CHR$(17) + CHR$(17)
    Control(__UI_NewID).Font = SetFont("", 8, "")
    Control(__UI_NewID).CanHaveFocus = True

    __UI_NewID = __UI_NewControl(__UI_Type_Button, "PreviousBT", 28, 23, 262, 10, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, CHR$(17)
    Control(__UI_NewID).Font = SetFont("", 8, "")
    Control(__UI_NewID).CanHaveFocus = True

    __UI_NewID = __UI_NewControl(__UI_Type_Button, "NextBT", 28, 23, 296, 10, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, CHR$(16)
    Control(__UI_NewID).Font = SetFont("", 8, "")
    Control(__UI_NewID).CanHaveFocus = True

    __UI_NewID = __UI_NewControl(__UI_Type_Button, "LastBT", 28, 23, 330, 10, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, CHR$(16) + CHR$(16)
    Control(__UI_NewID).Font = SetFont("", 8, "")
    Control(__UI_NewID).CanHaveFocus = True

    __UI_NewID = __UI_NewControl(__UI_Type_Button, "VerHistoricoBT", 131, 23, 228, 34, __UI_GetID("Frame1"))
    SetCaption __UI_NewID, "Ver Hist�rico"
    Control(__UI_NewID).CanHaveFocus = True

    __UI_NewID = __UI_NewControl(__UI_Type_MenuItem, "MenuItem3", 66, 18, 0, 4, __UI_GetID("MenuBar1"))
    SetCaption __UI_NewID, "&Visualizar hist�rico completo...-"

    __UI_NewID = __UI_NewControl(__UI_Type_MenuItem, "MenuItem1", 66, 18, 0, 4, __UI_GetID("MenuBar1"))
    SetCaption __UI_NewID, "&Sair"

    __UI_NewID = __UI_NewControl(__UI_Type_MenuItem, "MenuItem2", 86, 18, 0, 4, __UI_GetID("MenuBar2"))
    SetCaption __UI_NewID, "&Sobre..."

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "Label10", 185, 64, 215, 23, 0)
    SetCaption __UI_NewID, "Secretaria Criminal"
    Control(__UI_NewID).Font = SetFont("arial.ttf?/Library/Fonts/Arial.ttf?InForm/resources/NotoMono-Regular.ttf?cour.ttf", 18, "")
    Control(__UI_NewID).BackStyle = __UI_Transparent
    Control(__UI_NewID).Align = __UI_Center
    Control(__UI_NewID).VAlign = __UI_Middle
    Control(__UI_NewID).WordWrap = True

END SUB

SUB __UI_AssignIDs
    ControleDeOficios = __UI_GetID("ControleDeOficios")
    Frame1 = __UI_GetID("Frame1")
    PrximoNmero = __UI_GetID("PrximoNmero")
    MenuBar1 = __UI_GetID("MenuBar1")
    MenuBar2 = __UI_GetID("MenuBar2")
    NmeroLB = __UI_GetID("NmeroLB")
    UltimoOficioLB = __UI_GetID("UltimoOficioLB")
    Label2 = __UI_GetID("Label2")
    UltimaDescricaoLB = __UI_GetID("UltimaDescricaoLB")
    Label3 = __UI_GetID("Label3")
    UltimoUsuarioLB = __UI_GetID("UltimoUsuarioLB")
    Label4 = __UI_GetID("Label4")
    UsuarioAtualLB = __UI_GetID("UsuarioAtualLB")
    DecriaoOpcionalLB = __UI_GetID("DecriaoOpcionalLB")
    DescricaoTB = __UI_GetID("DescricaoTB")
    BT = __UI_GetID("BT")
    PictureBox2 = __UI_GetID("PictureBox2")
    TJMGpngPX = __UI_GetID("TJMGpngPX")
    FirstBT = __UI_GetID("FirstBT")
    PreviousBT = __UI_GetID("PreviousBT")
    NextBT = __UI_GetID("NextBT")
    LastBT = __UI_GetID("LastBT")
    VerHistoricoBT = __UI_GetID("VerHistoricoBT")
    MenuItem3 = __UI_GetID("MenuItem3")
    MenuItem1 = __UI_GetID("MenuItem1")
    MenuItem2 = __UI_GetID("MenuItem2")
    Label10 = __UI_GetID("Label10")
END SUB

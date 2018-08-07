$EXEICON:'./Chromatix-Keyboard-Keys-Hash.ico'

$SCREENHIDE
IF _COMMANDCOUNT = 0 THEN
    SYSTEM
END IF

showScreen

IniSetForceReload -1

c$ = "ControleDeOficios.exe"
FOR i = 1 TO _COMMANDCOUNT
    c$ = c$ + " " + COMMAND$(i)
NEXT

DO
    a$ = ReadSetting("ControleDeOficios.ini", "controle", "ForceQuitToUpdate")
    IF a$ = "False" THEN SHELL _DONTWAIT c$: SYSTEM
    _DISPLAY
    _LIMIT 10
LOOP

'$INCLUDE:'ini.bm'

SUB showScreen
    _SCREENSHOW
    SCREEN _NEWIMAGE(500, 200, 32)
    _SCREENMOVE _MIDDLE
    _TITLE "Controle de Oficios - Atualizacao"
    TJMG& = _LOADIMAGE("TJMG.png", 32)
    COLOR _RGB32(0), _RGB32(255)
    CLS
    IF TJMG& < -1 THEN _PUTIMAGE (_WIDTH / 2 - _WIDTH(TJMG&) / 2, 50), TJMG&
    f& = _LOADFONT("arial.ttf", 18)
    f2& = _LOADFONT("arial.ttf", 12)
    IF f& THEN _FONT f&
    m$ = "Atualizando o aplicativo de controle de oficios"
    _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2, _HEIGHT / 2 + _FONTHEIGHT), m$
    IF f2& THEN _FONT f2&
    m$ = "Nao feche esta janela..."
    _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2, _HEIGHT / 2 + _FONTHEIGHT * 4), m$
END SUB

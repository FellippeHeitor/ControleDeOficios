file$ = "oficios-civel.ini"
backupFile$ = "novo_oficios-civel.ini"

record = 0
FOR backupIndex = 97 TO 1384
    a$ = ReadSetting(file$, STR$(backupIndex), "Descricao")
    b$ = ReadSetting(file$, STR$(backupIndex), "Data")
    c$ = ReadSetting(file$, STR$(backupIndex), "Usuario")
    IF LEN(a$) > 0 OR LEN(b$) > 0 OR LEN(c$) > 0 THEN
        record = record + 1
        IF LEN(b$) THEN ano$ = RIGHT$(b$, 4) ELSE ano$ = "2018"
        WriteSetting backupFile$, STR$(record), "Numero", LTRIM$(STR$(backupIndex)) + "/" + ano$
        IF LEN(a$) THEN WriteSetting backupFile$, STR$(record), "Descricao", a$
        IF LEN(b$) THEN WriteSetting backupFile$, STR$(record), "Data", b$
        IF LEN(c$) THEN WriteSetting backupFile$, STR$(record), "Usuario", c$
    END IF

    CLS
    PRINT INT(backupIndex / 1384 * 100); "%..."
    PRINT a$
NEXT
PRINT "Done."

'$include:'../INI-Manager/ini.bm'

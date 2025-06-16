      **
      * COPY BOOK SCREEN SECTION OF EDIT SCREEN
      **
       01 SCREEN-EDIT.
           05 LINE WRK-LINE COLUMN 12 VALUE
               "здддддддддддддаддддддддддддддддддддддддддддддддддддд©".
           05 LINE PLUS 1 COLUMN 12 VALUE
               "Ё CODIGO.........: [     ]                          Ё".
           05 LINE PLUS 1 COLUMN 12 VALUE
               "Ё NOME DO FILME..: [                              ] Ё".
           05 LINE PLUS 1 COLUMN 12 VALUE
               "Ё GENERO.........: [        ]                       Ё".
           05 LINE PLUS 1 COLUMN 12 VALUE
               "Ё DURACAO........: [   ]                            Ё".
           05 LINE PLUS 1 COLUMN 12 VALUE
               "Ё DISTRIBUIDORA..: [               ]                Ё".
           05 LINE PLUS 1 COLUMN 12 VALUE
               "Ё MINHA NOTA.....: [  ]                             Ё".
           05 LINE PLUS 1 COLUMN 12 VALUE
               "юддддддддддддддддддддддддддддддддддддддддддддддддддды".
           05 LINE 20 COLUMN 23 PIC X(01) USING WRK-OPTION.
      *
       01 SCREEN-EDIT-KEY.
           05 LINE WRK-LINE COLUMN 2  VALUE ' '.
           05 LINE PLUS 1   COLUMN 32 PIC 9(05) USING CODIGO.
      *
       01 SCREEN-EDIT-DDS.
           05 LINE WRK-LINE COLUMN 2  VALUE ' '.
           05 LINE PLUS 1   COLUMN 2  VALUE ' '.
           05 LINE PLUS 1   COLUMN 32 PIC X(30) USING TITULO.
           05 LINE PLUS 1   COLUMN 32 PIC X(08) USING GENERO.
           05 LINE PLUS 1   COLUMN 32 PIC 9(03) USING DURACAO.
           05 LINE PLUS 1   COLUMN 32 PIC X(15) USING DISTRIB.
           05 LINE PLUS 1   COLUMN 32 PIC 9(02) USING NOTA.

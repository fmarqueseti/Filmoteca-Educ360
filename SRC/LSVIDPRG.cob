      ******************************************************************
      * FILE NAME   : INVIDPRG                                         *
      * DATE        : 2025-06-07                                       *
      * AUTHOR      : FABIO MARQUES (FMARQUES@FMARQUES.ETI.BR)         *
      * DATA CENTER : COMPANY.EDUC360                                  *
      * PURPOSE     : LIST ON SCREEN ROUTINE OF VIDEOTECA PROGRAM      *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. LSVIDPRG.
       AUTHOR. FABIO MARQUES.
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           COPY 'CPVIDSEQ'. *> MOVIES DAT WORKBOOK SEQUENTIAL
      *
       DATA DIVISION.

       FILE SECTION.
       FD MOVIES
           RECORDING MODE IS F.
           COPY 'CPVIDDAT'.
      *
       WORKING-STORAGE SECTION.
           COPY 'CPVIDMAN'. *> MAIN SCREEN
           COPY 'CPVIDMNU'. *> MAIN MENU
           COPY 'CPVIDEDT'. *> EDITION SCREEN
           COPY 'CPVIDMSG'. *> MESSAGES
           COPY 'CPVIDFCW'. *> MOVIES DAT WORKBOOK
           COPY 'CPVIDABE'. *> ABEND
      *
       77 WRK-LST-LINE              PIC 9(02) USAGE COMP-3 VALUE 14.
       77 WRK-LST-PAGE              PIC 9(02) USAGE COMP-3 VALUE 01.
       77 WRK-LST-COUNT             PIC 9(02) USAGE COMP-3 VALUE 01.
       77 WRK-CRT-STATUS            PIC 9(03).
      *
       SCREEN SECTION.
           COPY 'SCVIDMAN'. *> MAIN SCREEN
           COPY 'SCVIDMNU'. *> MAIN MENU
           COPY 'SCVIDMSG'. *> MESSAGES
           COPY 'SCVIDLST'. *> LIST SCREEN
      *
       PROCEDURE DIVISION.
       0000-MAIN SECTION.
           PERFORM 0100-OPEN-DATA.
      *     PERFORM 0200-VALIDATE-DATA.
           PERFORM 0300-PROCESS-DATA UNTIL WRK-CONTINUE EQUAL 'N'
                                        OR WRK-CONTINUE EQUAL 'n'.
      *     PERFORM 0400-PRINT-RESULTS.
           PERFORM 0500-CLOSE-DATA.
           PERFORM 0700-END-PROGRAM.
       0000-MAIN-END. EXIT.

       0100-OPEN-DATA SECTION.
           OPEN INPUT MOVIES.
      *
           IF FS-MOVIES NOT EQUAL "00"
               MOVE '46ERRO AO ABRIR ARQUIVO DE DADOS DE FILMES.'
                   TO WRK-MSG
               DISPLAY SCREEN-MSG
               ACCEPT SCREEN-WAIT
      *
               MOVE FS-MOVIES TO WS-ABEND-CODE
               MOVE 'ERRO AO ABRIR ARQUIVO DE DADOS DE FILMES'
                   TO WS-ABEND-MESSAGE
               PERFORM 0600-ROT-ABEND
           END-IF.
      *
           READ MOVIES
      *
           IF FS-MOVIES NOT EQUAL "00"
               MOVE '46ERRO AO LER O PRIMEIRO REGISTO DE FILMES.'
                   TO WRK-MSG
               DISPLAY SCREEN-MSG
               ACCEPT SCREEN-WAIT
      *
               MOVE FS-MOVIES TO WS-ABEND-CODE
               MOVE 'ERRO AO LER O PRIMEIRO REGISTO DE FILMES'
                   TO WS-ABEND-MESSAGE
               PERFORM 0600-ROT-ABEND
           END-IF.
      *

       0100-OPEN-DATA-END. EXIT.

       0200-VALIDATE-DATA SECTION.
       0200-VALIDATE-DATA-END. EXIT.

       0300-PROCESS-DATA SECTION.
           COPY 'CPVIDDTE'. *> DATE/TIME PROCEDURE
           MOVE "   * * * * LISTAGEM DE FILMES * * * *" TO WRK-TITLE.
           MOVE "PF3=FIM   QUALQUER TECLA PARA PAGINAR" TO WRK-KEYS.
           MOVE 8 TO WRK-LINE.
      *
           DISPLAY SCREEN-MAIN.
           DISPLAY SCREEN-MENU.
           DISPLAY SCREEN-LIST.
      *
           PERFORM VARYING WRK-LST-COUNT
             FROM 1 BY 1 UNTIL WRK-LST-COUNT EQUAL 8
                            OR FS-MOVIES EQUAL 10
      *
               DISPLAY CODIGO AT LINE WRK-LST-LINE COLUMN 14
               DISPLAY TITULO AT LINE WRK-LST-LINE COLUMN 23
               DISPLAY GENERO AT LINE WRK-LST-LINE COLUMN 56
               DISPLAY NOTA   AT LINE WRK-LST-LINE COLUMN 68
      *
               ADD 1 TO WRK-LST-LINE
               READ MOVIES
           END-PERFORM.
      *
           MOVE 14 TO WRK-LST-LINE.
           ADD   1 TO WRK-LST-PAGE.
           INITIALIZE WRK-MSG.

           IF FS-MOVIES EQUAL 10
               MOVE '20FIM DE ARQUIVO.' TO WRK-MSG
      *
               DISPLAY SCREEN-MSG
               ACCEPT SCREEN-WAIT
               MOVE 'N' TO WRK-CONTINUE
           ELSE
               MOVE '31CONTINUAR LISTANDO (S/N)?' TO WRK-MSG
      *
               DISPLAY SCREEN-CONFIRMATION
               ACCEPT SCREEN-CONFIRMATION-WAIT
      *
               IF WRK-AWAIT EQUAL 'S' OR EQUAL 's'
                   MOVE WRK-AWAIT TO WRK-CONTINUE
               ELSE
                   MOVE 'N' TO WRK-CONTINUE
               END-IF
           END-IF.
       0300-PROCESS-DATA-END. EXIT.

       0400-PRINT-RESULTS SECTION.
       0400-PRINT-RESULTS-END. EXIT.

       0500-CLOSE-DATA SECTION.
           CLOSE MOVIES.
      *
           IF FS-MOVIES NOT EQUAL "00"
               MOVE '47ERRO AO FECHAR ARQUIVO DE DADOS DE FILMES.'
                   TO WRK-MSG
               DISPLAY SCREEN-MSG
               ACCEPT SCREEN-WAIT
      *
               MOVE FS-MOVIES TO WS-ABEND-CODE
               MOVE 'ERRO AO FECHAR ARQ DE DADOS DE FILMES.'
                   TO WS-ABEND-MESSAGE
               PERFORM 0600-ROT-ABEND
           END-IF.
       0500-CLOSE-DATA-END. EXIT.

       0600-ROT-ABEND SECTION.
           COPY 'CPVIDRAB'. *> ABEND ROUTINE.
      *
           PERFORM 0700-END-PROGRAM.
       0600-ROT-ABEND-END. EXIT.

       0700-END-PROGRAM SECTION.
           GOBACK.
       0700-END-PROGRAM-END. EXIT.

       END PROGRAM LSVIDPRG.

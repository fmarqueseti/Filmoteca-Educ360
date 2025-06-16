      ******************************************************************
      * FILE NAME   : EXVIDPRG                                         *
      * DATE        : 2025-06-07                                       *
      * AUTHOR      : FABIO MARQUES (FMARQUES@FMARQUES.ETI.BR)         *
      * DATA CENTER : COMPANY.EDUC360                                  *
      * PURPOSE     : EXCLUSION ROUTINE OF VIDEOTECA PROGRAM           *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXVIDPRG.
       AUTHOR. FABIO MARQUES.
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           COPY 'CPVIDFCV'. *> MOVIES DAT WORKBOOK
      *
       DATA DIVISION.
       FILE SECTION.
       FD MOVIES.
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
       SCREEN SECTION.
           COPY 'SCVIDMAN'. *> MAIN SCREEN
           COPY 'SCVIDMNU'. *> MAIN MENU
           COPY 'SCVIDMSG'. *> MESSAGES
           COPY 'SCVIDEDT'. *> EDITION SCREEN
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
           OPEN I-O MOVIES.
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
       0100-OPEN-DATA-END. EXIT.

       0200-VALIDATE-DATA SECTION.
       0200-VALIDATE-DATA-END. EXIT.

       0300-PROCESS-DATA SECTION.
           COPY 'CPVIDDTE'. *> DATE/TIME PROCEDURE
           MOVE "    * * * * EXCLUSAO DE FILME * * * *"    TO WRK-TITLE.
           MOVE "PF3=FIM   TAB=PROX CAMPO   ENTER=CONFIRMA" TO WRK-KEYS.
           MOVE 10                                          TO WRK-LINE.
           INITIALIZE REG-FIL.
      *
           DISPLAY SCREEN-MAIN.
           DISPLAY SCREEN-MENU.
           DISPLAY SCREEN-EDIT.
           ACCEPT  SCREEN-EDIT-KEY.

           READ MOVIES
               INVALID KEY
                   MOVE '48FILME NAO LOCALIZADO! NOVA EXCLUSAO (S/N)?'
                       TO WRK-MSG
               NOT INVALID KEY
                   INITIALIZE WRK-MSG
                   DISPLAY SCREEN-EDIT-DDS
                   MOVE '41CONFIRMA A EXCLUSAO DO FILME (S/N)?'
                       TO WRK-MSG
                   DISPLAY SCREEN-CONFIRMATION
                   ACCEPT SCREEN-CONFIRMATION-WAIT
      *
                   IF WRK-AWAIT EQUAL 'S' OR EQUAL 's'
                       INITIALIZE WRK-MSG
                       DELETE MOVIES
                           INVALID KEY
                               MOVE
                               '43ERRO AO EXCLUIR! NOVA EXCLUSAO (S/N)?'
                                   TO WRK-MSG
                           NOT INVALID KEY
                               MOVE
                    '54FILME EXCLUIDO COM SUCESSO! NOVA EXCLUSAO (S/N)?'
                                   TO WRK-MSG
                       END-DELETE
                   ELSE
                       INITIALIZE WRK-MSG
                       MOVE '27NOVA EXCLUSAO (S/N)?'
                       TO WRK-MSG
                   END-IF
           END-READ.

           DISPLAY SCREEN-CONFIRMATION.
           ACCEPT SCREEN-CONFIRMATION-WAIT.
           MOVE WRK-AWAIT TO WRK-CONTINUE.
       0300-PROCESS-DATA-END. EXIT.

       0400-PRINT-RESULTS SECTION.
       0400-PRINT-RESULTS-END. EXIT.

       0500-CLOSE-DATA SECTION.
           CLOSE MOVIES.
      *
           IF FS-MOVIES NOT EQUALS "00"
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

       END PROGRAM EXVIDPRG.

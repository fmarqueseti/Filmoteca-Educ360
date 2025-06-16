      ******************************************************************
      * FILE NAME   : MNVIDPRG                                         *
      * DATE        : 2025-06-07                                       *
      * AUTHOR      : FABIO MARQUES (FMARQUES@FMARQUES.ETI.BR)         *
      * DATA CENTER : COMPANY.EDUC360                                  *
      * PURPOSE     : MAIN MENU OF VIDEOTECA PROGRAM                   *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MNVIDPRG.
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
           COPY 'CPVIDMSG'. *> MESSAGES
           COPY 'CPVIDFCW'. *> MOVIES DAT WORKBOOK
           COPY 'CPVIDABE'. *> ABEND
           77 WRK-DATFILE-CREATED   PIC X VALUE 'N'.
      *
       SCREEN SECTION.
           COPY 'SCVIDBAN'. *> BANNER - ASCII ART
           COPY 'SCVIDMAN'. *> MAIN SCREEN
           COPY 'SCVIDMNU'. *> MAIN MENU
           COPY 'SCVIDMSG'. *> MESSAGES
      *
       PROCEDURE DIVISION.
       0000-MAIN SECTION.
           DISPLAY SCREEN-ASCII-ART.
           CALL "C$SLEEP" USING 4 END-CALL.
      *
           PERFORM 0100-OPEN-DATA.
      *     PERFORM 0200-VALIDATE-DATA.
           PERFORM 0300-PROCESS-DATA UNTIL WRK-OPTION EQUAL ZEROES.
      *     PERFORM 0400-PRINT-RESULTS.
      *    PERFORM 0500-CLOSE-DATA.
           PERFORM 0700-END-PROGRAM.
       0000-MAIN-END. EXIT.
      *
       0100-OPEN-DATA SECTION.
           OPEN I-O MOVIES.
      *
           IF FS-MOVIES EQUAL "35" THEN
               OPEN OUTPUT MOVIES
               MOVE 'S' TO WRK-DATFILE-CREATED
           END-IF.
      *
           CLOSE MOVIES.
       0100-OPEN-DATA-END. EXIT.
      *
       0300-PROCESS-DATA SECTION.
           COPY 'CPVIDDTE'. *> DATE/TIME PROCEDURE
           MOVE "     * * * * MENU PRINCIPAL * * * *" TO WRK-TITLE.
           MOVE "PF3=FIM"                             TO WRK-KEYS.
      *
           DISPLAY SCREEN-MAIN.
      *
           IF WRK-DATFILE-CREATED EQUAL 'S'
               INITIALIZE WRK-DATFILE-CREATED
               INITIALIZE WRK-MSG
               MOVE '29ARQUIVO DE DADOS CRIADO.' TO WRK-MSG
               DISPLAY SCREEN-MSG
               ACCEPT SCREEN-WAIT

               INITIALIZE WRK-MSG
               DISPLAY WRK-MSG-TEXT AT LINE 22 COLUMN 02
           END-IF.
      *
           ACCEPT SCREEN-MENU.
      *
           EVALUATE WRK-OPTION
             WHEN '1' CALL 'INVIDPRG'
             WHEN '2' CALL 'ALVIDPRG'
             WHEN '3' CALL 'EXVIDPRG'
             WHEN '4' CALL 'LSVIDPRG'
             WHEN '5' CALL 'IMVIDPRG'
             WHEN '6' CALL 'XPVIDPRG'
             WHEN '0' CONTINUE
             WHEN OTHER PERFORM 0310-OTHER
           END-EVALUATE.
       0300-PROCESS-DATA-END. EXIT.

       0310-OTHER SECTION.
           INITIALIZE WRK-MSG.
           MOVE '20OPCAO INVALIDA.' TO WRK-MSG.
           DISPLAY SCREEN-MSG.
           ACCEPT SCREEN-WAIT.
       0310-OTHER-END. EXIT.

       0600-ROT-ABEND SECTION.
       0600-ROT-ABEND-END. EXIT.

       0700-END-PROGRAM SECTION.
           GOBACK.
       0700-END-PROGRAM-END. EXIT.

       END PROGRAM MNVIDPRG.

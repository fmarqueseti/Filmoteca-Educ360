      ******************************************************************
      * FILE NAME   : IMVIDPRG                                         *
      * DATE        : 2025-06-07                                       *
      * AUTHOR      : FABIO MARQUES (FMARQUES@FMARQUES.ETI.BR)         *
      * DATA CENTER : COMPANY.EDUC360                                  *
      * PURPOSE     : IMPORT FROM CSV ROUTINE OF VIDEOTECA PROGRAM     *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. IMVIDPRG.
       AUTHOR. FABIO MARQUES.
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           COPY 'CPVIDFCV'. *> MOVIES DAT WORKBOOK DINAMIC

           SELECT MOVIES-IMP
              ASSIGN       TO './dat/MOVIES-IMP.csv'
              ORGANIZATION IS LINE SEQUENTIAL
              ACCESS MODE  IS SEQUENTIAL
              FILE STATUS  IS FS-MOVIES-SEQ.
      *
       DATA DIVISION.
       FILE SECTION.
       FD  MOVIES
           RECORDING MODE IS F.
           COPY 'CPVIDDAT'.

       FD  MOVIES-IMP.
           01 FIL-IMP          PIC X(200).
      *
       WORKING-STORAGE SECTION.
           COPY 'CPVIDMSG'. *> MESSAGES
           COPY 'CPVIDFCW'. *> MOVIES DAT WORKBOOK
           COPY 'CPVIDABE'. *> ABEND
      *
       77 FS-MOVIES-SEQ            PIC X(02).

       01 WRK-ESTATISTICA.
           05 WRK-READ-LINES        PIC 9(02) USAGE COMP-3 VALUE ZEROES.
           05 WRK-WRITE-LINES       PIC 9(02) USAGE COMP-3 VALUE ZEROES.
           05 WRK-READ-LINES-EDIT   PIC Z9  VALUE ZEROES.
           05 WRK-WRITE-LINES-EDIT  PIC Z9  VALUE ZEROES.
      *
       SCREEN SECTION.
           COPY 'SCVIDMSG'. *> MESSAGES
      *
       PROCEDURE DIVISION.
       0000-MAIN SECTION.
           PERFORM 0100-OPEN-DATA.
      *     PERFORM 0200-VALIDATE-DATA.
           PERFORM 0300-PROCESS-DATA UNTIL FS-MOVIES-SEQ EQUAL "10".
           PERFORM 0400-PRINT-RESULTS.
           PERFORM 0500-CLOSE-DATA.
           PERFORM 0700-END-PROGRAM.
       0000-MAIN-END. EXIT.

       0100-OPEN-DATA SECTION.
           OPEN INPUT MOVIES-IMP
                I-O   MOVIES.
      *
           IF FS-MOVIES-SEQ NOT EQUAL "00"
               PERFORM 0500-CLOSE-DATA
               MOVE '45ERRO AO ABRIR ARQUIVO DE ENTRADA (CSV).'
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
           IF FS-MOVIES NOT EQUAL "00"
               PERFORM 0500-CLOSE-DATA
               MOVE '53ERRO AO ABRIR ARQUIVO DE DADOS DE FILMES.'
                   TO WRK-MSG
               DISPLAY SCREEN-MSG
               ACCEPT SCREEN-WAIT
      *
               MOVE FS-MOVIES TO WS-ABEND-CODE
               MOVE 'ERRO AO ABRIR ARQUIVO DE DADOS DE FILMES'
                   TO WS-ABEND-MESSAGE
               PERFORM 0600-ROT-ABEND
           END-IF.

           READ MOVIES-IMP. *> HEADER
      *
           IF FS-MOVIES NOT EQUAL "00"
               PERFORM 0500-CLOSE-DATA
      *
               MOVE '26ERRO AO LER CABECALHO.'
                   TO WRK-MSG
               DISPLAY SCREEN-MSG
               ACCEPT SCREEN-WAIT
      *
               MOVE FS-MOVIES TO WS-ABEND-CODE
               MOVE 'ERRO AO LER CABECALHO.'
                   TO WS-ABEND-MESSAGE
               PERFORM 0600-ROT-ABEND
           END-IF.
      *
           READ MOVIES-IMP. *> FIRST RECORD LINE
      *
           IF FS-MOVIES NOT EQUAL "00"
               PERFORM 0500-CLOSE-DATA
      *
               MOVE '36ERRO AO LER O PRIMEIRO REGISTRO.'
                   TO WRK-MSG
               DISPLAY SCREEN-MSG
               ACCEPT SCREEN-WAIT
      *
               MOVE FS-MOVIES TO WS-ABEND-CODE
               MOVE 'ERRO AO LER O PRIMEIRO REGISTRO.'
                   TO WS-ABEND-MESSAGE
               PERFORM 0600-ROT-ABEND
           END-IF.
      *
           INITIALIZE WRK-READ-LINES.
           INITIALIZE WRK-WRITE-LINES.
       0100-OPEN-DATA-END. EXIT.

       0200-VALIDATE-DATA SECTION.
       0200-VALIDATE-DATA-END. EXIT.

       0300-PROCESS-DATA SECTION.
           ADD 1 TO WRK-READ-LINES.
      *
           UNSTRING FIL-IMP DELIMITED BY ";"
               INTO CODIGO,
                    TITULO,
                    GENERO,
                    DURACAO,
                    DISTRIB,
                    NOTA.
      *
               WRITE REG-FIL.
               IF FS-MOVIES EQUAL "00"
                   ADD 1 TO WRK-WRITE-LINES
               END-IF.
      *
               READ MOVIES-IMP.
       0300-PROCESS-DATA-END. EXIT.

       0400-PRINT-RESULTS SECTION.
           MOVE WRK-READ-LINES  TO WRK-READ-LINES-EDIT.
           MOVE WRK-WRITE-LINES TO WRK-WRITE-LINES-EDIT.
      *
           STRING '41ESTATISTICAS: LIDOS ' DELIMITED BY SIZE
                  WRK-READ-LINES-EDIT DELIMITED BY SIZE
                  ', GRAVADOS ' DELIMITED BY SIZE
                  WRK-WRITE-LINES-EDIT DELIMITED BY SIZE
                  '.' DELIMITED BY SIZE
                  INTO WRK-MSG.
      *
           DISPLAY SCREEN-MSG.
           ACCEPT SCREEN-WAIT.
       0400-PRINT-RESULTS-END. EXIT.

       0500-CLOSE-DATA SECTION.
           CLOSE MOVIES-IMP MOVIES.
      *
           IF FS-MOVIES-SEQ NOT EQUAL "00"
               PERFORM 0500-CLOSE-DATA
               MOVE '46ERRO AO FECHAR ARQUIVO DE ENTRADA (CSV).'
                   TO WRK-MSG
               DISPLAY SCREEN-MSG
               ACCEPT SCREEN-WAIT
      *
               MOVE FS-MOVIES TO WS-ABEND-CODE
               MOVE 'ERRO AO FECHAR ARQUIVO DE ENTRADA (CSV)'
                   TO WS-ABEND-MESSAGE
               PERFORM 0600-ROT-ABEND
           END-IF.
      *
           IF FS-MOVIES NOT EQUAL "00"
               MOVE '47ERRO AO FECHAR ARQUIVO DE DADOS DE FILMES.'
                   TO WRK-MSG
               DISPLAY SCREEN-MSG
               ACCEPT SCREEN-WAIT
      *
               MOVE FS-MOVIES TO WS-ABEND-CODE
               MOVE 'ERRO AO FECHAR ARQ DE DADOS DE FILMES'
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

       END PROGRAM IMVIDPRG.

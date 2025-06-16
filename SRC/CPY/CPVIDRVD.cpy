      **
      * VALIDATION ROUTINE OF MOVIES DATA
      **
           INITIALIZE WRK-DATA-VALIDATION.
      *
           IF NOTA LESS 0 OR GREATER 10
               MOVE 'N'               TO WRK-IS-VALID
               MOVE '18NOTA INVALIDA' TO WRK-VALID-MESSAGE
           END-IF.
      *
      ***** OTHER FIELDS AND CRITERIA CAN BE TESTED HERE

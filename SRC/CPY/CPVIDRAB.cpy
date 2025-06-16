      **
      * ABEND ROUTINE
      **
           DISPLAY '**************************************************'.
           DISPLAY '********************** ABEND *********************'.
           DISPLAY '**************************************************'.
           DISPLAY '* CODIGO: ' WS-ABEND-CODE
                   '                                     *'.
           DISPLAY '* MSG: ' WS-ABEND-MESSAGE '            *'.
           DISPLAY '****************************************'.
           MOVE WS-ABEND-CODE TO RETURN-CODE.

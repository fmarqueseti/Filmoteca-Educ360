      **
      * COPY BOOK DESCRIPTION DATA FILES
      **
           SELECT MOVIES
              ASSIGN       TO './dat/MOVIES.dat'
              ORGANIZATION IS INDEXED
              ACCESS MODE  IS DYNAMIC
              FILE STATUS  IS FS-MOVIES
              RECORD KEY   IS CODIGO.

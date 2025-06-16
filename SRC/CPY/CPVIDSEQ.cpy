      **
      * COPY BOOK DESCRIPTION DATA FILES SEQUENTIAL
      **
           SELECT MOVIES
              ASSIGN       TO './dat/MOVIES.dat'
              ORGANIZATION IS INDEXED
              ACCESS MODE  IS SEQUENTIAL *> DYNAMIC
              FILE STATUS  IS FS-MOVIES
              RECORD KEY   IS CODIGO.

      **
      * COPY BOOK MAIN SCREEN WORKING STORAGE
      **
       01 WRK-CURRENT-DATE.
           05 WRK-DATE.             *> LRECL 15
               10 WRK-DAY           PIC X(02).
               10 FILLER            PIC X(01)  VALUE "/".
               10 WRK-MONTH         PIC X(02).
               10 FILLER            PIC X(01)  VALUE "/".
               10 WRK-YEAR          PIC X(04).
           05 WRK-TIME.
               10 WRK-HOUR          PIC X(02).
               10 FILLER            PIC X(01)  VALUE ":".
               10 WRK-MINUTE        PIC X(02).
     *
       77 WRK-NOW                   PIC X(15).
       77 WRK-TITLE                 PIC X(40)  VALUE SPACES.

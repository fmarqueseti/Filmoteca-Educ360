      **
      * COPY BOOK EDIT SCREEN WORKING STORAGE
      **
       77 WRK-LINE                 PIC 9(02) VALUE ZEROES.
       77 WRK-CONTINUE             PIC X(01) VALUE 'S'.
      *
       01 WRK-DATA-VALIDATION.
           05 WRK-IS-VALID         PIC X(01) VALUE SPACES.
           05 WRK-VALID-MESSAGE    PIC X(40) VALUE SPACES.

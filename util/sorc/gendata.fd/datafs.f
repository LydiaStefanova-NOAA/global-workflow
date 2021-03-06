C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C                .      .    .                                       .
C SUBPROGRAM:    DATAFS      FORM PLOTFILE ARRAY
C   PRGMMR: LARRY SAGER      ORG: W/NMC41    DATE: 96-12-10
C
C ABSTRACT: DATAFS FORMS THE OUTPUT AFOS SURFACE PLOTFILE     
C   BLOCK AND WRITES WHEN FINISHED.                    
C
C PROGRAM HISTORY LOG:
C   96-12-10  LARRY SAGER
C
C USAGE:    CALL DATAFS  (IARR, OTABL, KSTN, IAUTO, IRTN )         
C   INPUT ARGUMENT LIST:
C     ARR      - OBSERVATION IN UNPACKED GRAPHICAL FORMAT
C     KSTN     - POINTER TO NEXT LOCATION IN OTABL ARRAY
C     IAUTO    - AUTOMATIC/MANUAL STATION FLAG
C
C   OUTPUT ARGUMENT LIST:      (INCLUDING WORK ARRAYS)
C     OTABL    - SURFACE OB STORAGE ARRAY
C     IRTN     - RETURN CODE
C
C REMARKS: LIST CAVEATS, OTHER HELPFUL HINTS OR INFORMATION
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 90
C   MACHINE:  IBM SP
C
C$$$
      SUBROUTINE DATAFS (IARR, OTABL, KSTN, IAUTO, IRTN )
C 
C     THIS SUBROUTINE FORMS THE OUTPUT AFOS SURFACE
C       PLOTFILE BLOCK.                             
C
      CHARACTER*1   OLINE(100)
      CHARACTER*1   OHED(100)
      CHARACTER*1   OTABL(20000,150)
C
      INTEGER     IARR(*)
C
C     BUILD THE AFOS PLOT FILE BLOCK.
C     START BY BUILDING THE AFOS PLOTFILE HEADER
C
      CALL HEAFOS(IARR, OHED, IAUTO, ILHD)
      IF(IARR(13).GT.0) THEN
            IA = IARR(13)
            IB = IARR(14)
            ILAT = IARR(1)   
            ILON = IARR(2)    
C
C           RETRIEVE THE DATA FROM THIS REPORT
C
            CALL GETDAT (IARR(IB), OLINE, ILAT, ILON, ILNG)
            IF (ILNG .GT. 0) THEN
C
C               STORE THE AFOS PLOTFILE FORMAT
C
                DO J = 1,ILHD
                   OTABL(KSTN,J) = OHED(J)
	        END DO
                DO J = 1,ILNG
                   OTABL(KSTN,ILHD+J) = OLINE(J)
                END DO
C               PRINT 109,(OTABL(KSTN,KK),KK=1,70 )
 109            FORMAT(70a1)
            END IF
      END IF
C      
      RETURN
      END

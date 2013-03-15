C  ********************************************************************
C  *  ROTATING EXCITATION SYSTEM - IEEE TYPE 1 MODEL                  *
C  ********************************************************************
C
C  Copyright (c) 2013 IncSys (http://incsys.com)
C
C  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRENTY OF ANY KIND,
C  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRENTIES
C  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
C  NONINFRENGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
C  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
C  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
C  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
C  SOFTWARE.
C
      SUBROUTINE AVR1(I)
      IMPLICIT NONE
      INCLUDE 'cblocks.fpp'
      REAL VREF(10),SE(10)
      INTEGER I,J
      REAL X1,X2,X3,X4,X5,X6,X7,X8
C  ARRAY DEFINED IN COMMON BLOCK 3 NEED TO BE EQUIVALENCED
      REAL KA(10),KE(10),KF(10),TA(10),TE(10),
     1TF(10),VRMIN(10),VRMAX(10),AC1(10),AC2(10),DUM(10,6)
      EQUIVALENCE (AVRPRM(1,1),KA)
      EQUIVALENCE (AVRPRM(1,2),KE)
      EQUIVALENCE (AVRPRM(1,3),KF)
      EQUIVALENCE (AVRPRM(1,4),TA)
      EQUIVALENCE (AVRPRM(1,5),TE)
      EQUIVALENCE (AVRPRM(1,6),TF)
      EQUIVALENCE (AVRPRM(1,7),VRMIN)
      EQUIVALENCE (AVRPRM(1,8),VRMAX)
      EQUIVALENCE (AVRPRM(1,9),AC1)
      EQUIVALENCE (AVRPRM(1,10),AC2)
C  ENTER HERE FOR EACH INTEGRATION STEP.
C  DEFINE INTEGRATOR OUTPUTS.
      X5=OUT(I,6)
      EF(I)=OUT(I,5)
      X3=OUT(I,7)
C  CALCULATE INTERMEDIATE VARIABLES
      X1=VREF(I)-CABS(VT(I))
      X2=KF(I)/TF(I)*EF(I)-X3
      X4=X1-X2
      X6=X5
      IF(X6 .LT. VRMIN(I)) X6=VRMIN(I)
      IF(X6 .GT. VRMAX(I)) X6=VRMAX(I)
      X7=SE(I)*EF(I)
      X8=X6-X7
C  DEFINE INTEGRATOR INPUTS.
      PLUG(I,5)=X8/TE(I)-KE(I)/TE(I)*EF(I)
      PLUG(I,6)=KA(I)/TA(I)*X4-X5/TA(I)
      PLUG(I,7)=X2/TF(I)
      RETURN
C  ENTER HERE TO CALCULATE INITIAL CONDITIONS.
      ENTRY AVR1IC(I)
      SE(I)=AC1(I)*EXP(AC2(I)*EF(I))
      VREF(I)=CABS(VT(I))+(KE(I)+SE(I))*EF(I)/KA(I)
      OUT(I,5)=EF(I)
      OUT(I,6)=EF(I)*(KE(I)+SE(I))
      OUT(I,7)=EF(I)*KF(I)/TF(I)
      IF(OUT(I,6) .LT. VRMIN(I)) WRITE(6,1020) I
      IF(OUT(I,6) .GT. VRMAX(I)) WRITE(6,1020)
1020  FORMAT('0**** AVR VOLTAGE LIMIT IS EXCEEDED BY INITIAL FIELD ON',
     1' UNIT',I3/)
      RETURN
      END

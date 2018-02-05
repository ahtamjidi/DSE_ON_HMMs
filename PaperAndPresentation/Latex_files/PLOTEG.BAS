' ploteg.bas
' plot a damped exponential to the screen and
' write the data points to a text file
' J Leis
'

SCREEN 12               ' vga screen mode 640 x 480 x 16

' scale the screen
tmin = 0: tmax = 1
ymin = -1: ymax = 1
WINDOW (tmin, ymax)-(tmax, ymin)

' open the text output file
OPEN "plot.dat" FOR OUTPUT AS #1

NumPoints = 100 ' total number of points to plot
PointNum = 1    ' current point number
tstep = 1 / NumPoints
t = tmin
COLOR 14
DO
        y = EXP(-3 * t) * SIN(20 * t)
        IF t = 0 THEN
                PSET (t, y)
        ELSE
                LINE -(t, y)
        END IF
                                                    
        PRINT #1, t, y          ' write to the file
        'PRINT PointNum, t, y
        PointNum = PointNum + 1 ' select next point number
        t = t + tstep
LOOP UNTIL PointNum > NumPoints

LOCATE 2, 30
PRINT NumPoints; " points"
CLOSE #1
COLOR 15



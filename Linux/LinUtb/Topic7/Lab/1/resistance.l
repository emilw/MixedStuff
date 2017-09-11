.TH LIBRESISTANCE 1
.SH NAME
Resistance library - Calculates the resistance for serial or parallell connected components
.SH SYNOPSIS
.B gcc
[\fIflag ...\fR]
file ...
-lresistance
[\fIlibrary\fR]
.SH DESCRIPTION
.B Resistance
is a library that allows calculating the total resistance for a set of components. It can handle both serial and parallell connections, but only one at a time.
Here is an example call to the library function calcresistance:
    int main(void){
        float resistanceComponents[2] = {150,300};
        returnValue = calc_resistance(sizeof(resistanceComponents)/sizeof(resistanceComponents[0]), 'P', resistanceComponents);
    }
.SH DEFINITIONS
There exists an error code, that is -1. The function returns -1 if the arguments are incorrect.
The full definition can be found in the function section below or the <libresistance.h> header.
.SH DATA STRUCTURES
There is no specific data structures related to this library.
.SH FUNCTION
.SS calc_resistance
.TP
.BR int " " \fIcount\fR
Specifies the number of components to send incorrect
.TP
.BR char " " \fIconn\fR
Specifies what type of connections to calculate, this can either be:
\fIP\fR = Parallell or \fIS\fR = Serial
.TP
.BR float* " " \fIarray\fR
Specifies the resistance value for each component to calculate
.SH SEE ALSO
https://github.com/linUM141/Labb6
.SH AUTHOR
Emil Westholm
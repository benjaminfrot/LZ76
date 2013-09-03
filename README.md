LZ76
===

Fast implementations of the so-called 'Lempel-Ziv 76' complexity measure

*Input* is a filename. That file contains one string/line.<br>
*Output* is printed on the screen : it is the complexity of each string.

The core complexity measure is from *On the complexity of finite sequences*, by Lempel-Ziv.

This efficient implementation of the so-called *exhaustive parsing* is due to S Faul (http://www.mathworks.co.uk/matlabcentral/fileexchange/6886-kolmogorov-complexity)

Three flavours are available:
 - LZ76 : Return the length of the dictionnary after an exhustive parsing
 - Kolmogorov : Same as above but multiply by log_2(string length).
 - meanKolmogorov : Mean of Kolmogorov applied to the string and its reverse.


To build : make<br>
To use : ./LZ76 filename

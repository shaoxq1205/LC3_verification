# LC3_verification


Objective:

The aim of this project was to verify data and control path of pipelined LC3 microcontroller with a comprehensive instruction set. Firstly a golden reference model was built which replicated the functionality
of the clean Design under Test (DUT). Golden Reference Model was implemented in System Verilog and simulation was done in MODELSIM version 10.0c, Questasim version 10.2b.
Then the golden reference was used to spot and analyze 7 bugs which were inserted in the DUT.


Strategy:
In the test bench the generator function is called which generates the inputs randomly. Now the generated inputs are sent to the golden reference model as well as the Design under Test.
We have taken the inputs for each module of the golden reference from the DUT to isolate the errors generated at one block to carry forward. This will ensure that only the block with the bug shows up the
error while the other blocks without bug run properly with the input from DUT.
The outputs of each module of the DUT are checked against the outputs from the golden reference at every clock edge. The checker function displays whenever there is a mismatch with the generated output and
the expected value.
Thus functionality of each block of LC3 is verified.

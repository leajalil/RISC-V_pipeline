module add1 #(parameter width=64)
    (input logic [width-1:0] dataIn,
     output logic [width-1:0] dataOut);

assign dataOut=dataIn+4;

endmodule

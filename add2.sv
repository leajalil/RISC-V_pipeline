module add2 #(parameter width=64)
    (input logic [width-1:0] data1In,data2In,
     output logic [width-1:0] dataOut);

assign dataOut=data1In+data2In;

endmodule

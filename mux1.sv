module mux1 #(parameter width=64)
    (input logic logica,
     input logic [width-1:0] data1In,data2In,
     output logic [width-1:0] dataOut);

assign dataOut=logica ? data2In : data1In;

endmodule

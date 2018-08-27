module mux2 #(parameter width=64)
    (input logic [1:0]logica,
     input logic [width-1:0] data1In,data2In,data3In,
     output logic [width-1:0] dataOut);


always_comb begin
    case(logica)
        2'b00: dataOut=data1In;
        2'b01: dataOut=data2In;
        2'b10: dataOut=data3In;
        default: dataOut=data1In;
    endcase
end

endmodule

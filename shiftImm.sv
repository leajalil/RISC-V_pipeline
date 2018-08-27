module shiftImm #(parameter width=64)
    (input logic [width-2:0] immGen,
     output logic [width-1:0] shiftImm);


assign shiftImm={immGen[width-2:0],1'b0};

endmodule

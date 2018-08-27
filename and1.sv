module and1
    (input logic branch,zero,
     output logic tomux3);
     
assign tomux3 = branch & zero;

endmodule

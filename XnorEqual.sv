//`timescale 1ns / 1ps


module XnorEqual #(parameter N=32)
   (input logic [N*2-1:0] data1,data2,
    output logic zero);
    
logic [N*2-1:0] aux;

assign aux=data1-data2;

assign zero=aux ? 0:1;
 
endmodule

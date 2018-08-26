`timescale 1ns / 1ps

//BUFFER OF INSTRUCTION FETCH TO INSTRUCTION DECODE

module buffer_IFtoID #(parameter N=32)
    (input logic clk,rst,
     input logic [N*2-1:0] pc_next,
     input logic [N-1:0] instruction_next,
     output logic [N*2-1:0] pc_actual,
     output logic [N-1:0] instruction_actual);
     
 always_ff @(posedge clk)
    if(rst) begin
        pc_actual<=0;
        instruction_actual<=0;
    end 
    else begin
        pc_actual<=pc_next;
        instruction_actual<=instruction_next;    
    end    
    
 endmodule

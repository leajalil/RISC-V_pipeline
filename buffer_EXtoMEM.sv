//`timescale 1ns / 1ps

//BUFFER OF EXECUTION TO MEMORY

module buffer_EXtoMEM #(parameter N=64)
    (input logic clk,rst,
     input logic memWrite_next,memRead_next,memToReg_next,regWrite_next,
     input logic [4:0] writeReg_next,
     input logic [N-1:0] ALUResult_next,writeDataMem_next,
     output logic memWrite_actual,memRead_actual,memToReg_actual,regWrite_actual,
     output logic [4:0] writeReg_actual,
     output logic [N-1:0] ALUResult_actual,writeDataMem_actual);
     
 always_ff @(posedge clk)
    if(rst) begin
        memWrite_actual<=0;
        memRead_actual<=0;
        memToReg_actual<=0;
        regWrite_actual<=0;
        writeReg_actual<=0;
        ALUResult_actual<=0;
        writeDataMem_actual<=0;
    end 
    else begin
        memWrite_actual<=memWrite_next;
        memRead_actual<=memRead_next;
        memToReg_actual<=memToReg_next;
        regWrite_actual<=regWrite_next;
        writeReg_actual<=writeReg_next;
        ALUResult_actual<=ALUResult_next;
        writeDataMem_actual<=writeDataMem_next;
    end   
    
endmodule

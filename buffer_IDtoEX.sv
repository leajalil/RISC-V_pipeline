//`timescale 1ns / 1ps

//BUFFER OF INSTRUCTION DECODE TO EXECUTION

module buffer_IDtoEX #(parameter N=32)
    (input logic clk,rst,
     input logic ALUSrc_next,branch_next,memWrite_next,memRead_next,memToReg_next,regWrite_next,
     input logic [1:0] ALUOp_next,
     input logic [3:0] instructionALUCtr_next,
     input logic [4:0] writeReg_next,readReg1_next,readReg2_next,
     input logic [N*2-1:0] pc_next,data1_next,data2_next,immGen_next,
     output logic ALUSrc_actual,branch_actual,memWrite_actual,memRead_actual,memToReg_actual,regWrite_actual,
     output logic [1:0] ALUOp_actual,
     output logic [3:0] instructionALUCtr_actual,
     output logic [4:0] writeReg_actual,readReg1_actual,readReg2_actual,
     output logic [N*2-1:0] pc_actual,data1_actual,data2_actual,immGen_actual);
     
 always_ff @(posedge clk)
    if(rst) begin
        ALUSrc_actual<=0;
        branch_actual<=0;
        memWrite_actual<=0;
        memRead_actual<=0;
        memToReg_actual<=0;
        regWrite_actual<=0;
        ALUOp_actual<=0;
        instructionALUCtr_actual<=0;
        writeReg_actual<=0;
        readReg1_actual<=0;
        readReg2_actual<=0;
        pc_actual<=0;
        data1_actual<=0;
        data2_actual<=0;
        immGen_actual<=0;
    end 
    else begin
        ALUSrc_actual<=ALUSrc_next;
        branch_actual<=branch_next;
        memWrite_actual<=memWrite_next;
        memRead_actual<=memRead_next;
        memToReg_actual<=memToReg_next;
        regWrite_actual<=regWrite_next;
        ALUOp_actual<=ALUOp_next;
        instructionALUCtr_actual<=instructionALUCtr_next;
        writeReg_actual<=writeReg_next;
        readReg1_actual<=readReg1_next;
        readReg2_actual<=readReg2_next;
        pc_actual<=pc_next;
        data1_actual<=data1_next;
        data2_actual<=data2_next;
        immGen_actual<=immGen_next;
    end   
    
endmodule

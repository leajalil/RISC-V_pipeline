//`timescale 1ns / 1ps

//Multiplexer after control unit

module muxControl
    (input logic sel,
     input logic branch_in,memWrite_in,memRead_in,regWrite_in,memToReg_in,aluSrc_in,
     input logic [1:0] ALUOp_in,
     output logic branch_out,memWrite_out,memRead_out,regWrite_out,memToReg_out,aluSrc_out,
     output logic [1:0] ALUOp_out);
    
 always_comb begin
    
    case(sel)
        1'b0: begin
                branch_out=0;
                memWrite_out=0;
                memRead_out=0;
                regWrite_out=0;
                memToReg_out=0;
                aluSrc_out=0;
                ALUOp_out=2'b00;
              end
        1'b1: begin
                branch_out=branch_in;
                memWrite_out=memWrite_in;
                memRead_out=memRead_in;
                regWrite_out=regWrite_in;
                memToReg_out=memToReg_in;
                aluSrc_out=aluSrc_in;
                ALUOp_out=ALUOp_in;
              end
        default: begin
                    branch_out=branch_in;
                    memWrite_out=memWrite_in;
                    memRead_out=memRead_in;
                    regWrite_out=regWrite_in;
                    memToReg_out=memToReg_in;
                    aluSrc_out=aluSrc_in;
                    ALUOp_out=ALUOp_in;
                  end
    endcase
    
 end
 
endmodule

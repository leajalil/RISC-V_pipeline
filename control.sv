module control 
    (input logic [6:0] instruction,
     output logic [1:0] ALUOp,
     output logic branch,memWrite,memRead,regWrite,memToReg,aluSrc,led);

always_comb
begin
    case(instruction)
    3: begin
        ALUOp=2'b00; 
        branch=0;
        memWrite=0;
        memRead=1;
        regWrite=1;
        memToReg=1;
        aluSrc=1;
        led=0;
        end
   35: begin
       ALUOp=2'b00; 
       branch=0;
       memWrite=1;
       memRead=0;
       regWrite=0;
       memToReg=0; //X
       aluSrc=1;
       led=0;
       end   
   99: begin
       ALUOp=2'b01; 
       branch=1;
       memWrite=0;
       memRead=0;
       regWrite=0;
       memToReg=0; //X
       aluSrc=0;
       led=0;
       end
   51: begin
       ALUOp=2'b10; 
       branch=0;
       memWrite=0;
       memRead=0;
       regWrite=1;
       memToReg=0;
       aluSrc=0;
       led=0;
       end  
   127: begin
           ALUOp=2'b11; 
           branch=0;
           memWrite=0;
           memRead=0;
           regWrite=0;
           memToReg=0;
           aluSrc=0;
           led=1;
       end 
    default:
       begin
       ALUOp=2'b11; 
       branch=0;
       memWrite=0;
       memRead=0;
       regWrite=0;
       memToReg=0;
       aluSrc=0;
       led=0;
       end
    endcase
end

endmodule

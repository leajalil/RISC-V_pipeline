module risc_v #(parameter N=32)
    (input logic clk_div,rst,
     output logic ledBlink);
     
     
//Señales internas        
logic [63:0] pcActual,pcNext,pcSum,writeDataReg,dataAluA,dataAluB,dataMux2Mux1,immShift;//,pcBranch,,,ofmux1,resultAlu,ReadData;
logic [31:0] instruction;
logic [4:0] readReg1;
logic [4:0] readReg2; 
logic [6:0] opcode;
logic [3:0] operationAlu;
logic [1:0] forwardingA,forwardingB;
logic outAnd,pc_Enable,bufferIFID_Enable;

//asignaciones de señales internas
assign opcode=instruction[6:0];
assign readReg1=instruction[19:15];
assign readReg2=instruction[24:20];
     
//Señales buffer IF/ID
logic [N*2-1:0] pc_IF;
logic [N-1:0] instruction_IF;

//Señales buffer ID/EX
logic ALUSrc_ID,branch_ID,memWrite_ID,memRead_ID,memToReg_ID,regWrite_ID,mux_ID;
logic ALUSrc_aux,branch_aux,memWrite_aux,memRead_aux,memToReg_aux,regWrite_aux;
logic [1:0] ALUOp_ID;
logic [1:0] ALUOp_aux;
logic [3:0] instructionALUCtr_ID;
logic [4:0] writeReg_ID,readReg1_ID,readReg2_ID;
logic [N*2-1:0] pc_ID,data1_ID,data2_ID,immGen_ID;

//asignaciones de señales buffer ID/EX
assign writeReg_ID=instruction[11:7];
assign readReg1_ID=readReg1;
assign readReg2_ID=readReg2;
assign instructionALUCtr_ID={instruction[30],instruction[14:12]};
     
//Señales buffer EX/MEM
logic ALUSrc_EX,branch_EX,memWrite_EX,memRead_EX,memToReg_EX,regWrite_EX,zeroALU_EX;
logic [1:0] ALUOp_EX;
logic [3:0] instructionALUCtr_EX;
logic [4:0] writeReg_EX,readReg1_EX,readReg2_EX;
logic [N*2-1:0] pcBranch_EX,ALUResult_EX,writeDataMem_EX,pc_EX,data1_EX,data2_EX,immGen_EX;
  
//asignaciones de señales buffer EX/MEM
assign writeDataMem_EX=dataMux2Mux1;

////Señales buffer MEM/WB
logic memToReg_MEM,regWrite_MEM,branch_MEM,memWrite_MEM,memRead_MEM,zeroALU_MEM,regWrite_WB,memToReg_WB;
logic [4:0] writeReg_MEM,writeReg_WB;
logic [N*2-1:0] AddressMem_MEM,pcBranch_MEM,writeDataMem_MEM,readDataMem_MEM,readDataMem_WB,AddressMem_WB;
   
//Conexionado etapa IF (instruction fetch)
pc ProgramCounter (clk_div,rst,pc_Enable,pcNext,pcActual);
add1 Add4Pc (pcActual,pcSum);
instructionMemory ProgramMemory (pcActual,instruction_IF);
buffer_IFtoID Buffer_IFID (clk_div,rst,bufferIFID_Enable,pcActual,instruction_IF,pc_ID,instruction);
mux1 selDataPc (outAnd,pcSum,pcBranch_MEM,pcNext);

//Conexionado etapa ID (instruction decode)
control UnitControl (opcode,ALUOp_aux,branch_aux,memWrite_aux,memRead_aux,regWrite_aux,memToReg_aux,ALUSrc_aux,ledBlink);
register Registers (clk_div,regWrite_WB,readReg1,readReg2,writeReg_WB,writeDataReg,data1_ID,data2_ID);
immGen ImmGenerate (instruction,immGen_ID);
buffer_IDtoEX Buffer_IDEX (clk_div,rst,ALUSrc_ID,branch_ID,memWrite_ID,memRead_ID,memToReg_ID,regWrite_ID,ALUOp_ID,instructionALUCtr_ID,writeReg_ID,readReg1_ID,readReg2_ID,pc_ID,data1_ID,data2_ID,immGen_ID,ALUSrc_EX,branch_EX,memWrite_EX,memRead_EX,memToReg_EX,regWrite_EX,ALUOp_EX,instructionALUCtr_EX,writeReg_EX,readReg1_EX,readReg2_EX,pc_EX,data1_EX,data2_EX,immGen_EX);
HazardDetUnit HazardDetectionUnit (memRead_EX,readReg1,readReg2,writeReg_EX,pc_Enable,bufferIFID_Enable,mux_ID);
muxControl MuxCtrl (mux_ID,branch_aux,memWrite_aux,memRead_aux,regWrite_aux,memToReg_aux,ALUSrc_aux,ALUOp_aux,branch_ID,memWrite_ID,memRead_ID,regWrite_ID,memToReg_ID,ALUSrc_ID,ALUOp_ID);

//Conexionado etapa EX (execution)
mux2 selDataAlu1 (forwardingA,data1_EX,writeDataReg,AddressMem_MEM,dataAluA);
mux2 selDataAux2 (forwardingB,data2_EX,writeDataReg,AddressMem_MEM,dataMux2Mux1);
mux1 selDataAlu2 (ALUSrc_EX,dataMux2Mux1,immGen_EX,dataAluB);
ALUcontrol ControlAlu (ALUOp_EX,instructionALUCtr_EX,operationAlu);
alu ALU (operationAlu,dataAluA,dataAluB,zeroALU_EX,ALUResult_EX);
shiftImm ShiftImmediate (immGen_EX,immShift);
add2 AddShift (pc_EX,immShift,pcBranch_EX);
forwardingUnit ForwardingUnit (regWrite_MEM,regWrite_WB,writeReg_MEM,writeReg_WB,readReg1_EX,readReg2_EX,forwardingA,forwardingB);
buffer_EXtoMEM Buffer_EXMEM (clk_div,rst,branch_EX,memWrite_EX,memRead_EX,memToReg_EX,regWrite_EX,zeroALU_EX,writeReg_EX,pcBranch_EX,ALUResult_EX,writeDataMem_EX,branch_MEM,memWrite_MEM,memRead_MEM,memToReg_MEM,regWrite_MEM,zeroALU_MEM,writeReg_MEM,pcBranch_MEM,AddressMem_MEM,writeDataMem_MEM);


//Conexionado etapa MEM (memory)
and1 AndBranch (branch_MEM,zeroALU_MEM,outAnd);
memory Memory (clk_div,memWrite_MEM,memRead_MEM,AddressMem_MEM,writeDataMem_MEM,readDataMem_MEM);
buffer_MEMtoWB Buffer_MEMWB (clk_div,rst,memToReg_MEM,regWrite_MEM,writeReg_MEM,AddressMem_MEM,readDataMem_MEM,memToReg_WB,regWrite_WB,writeReg_WB,AddressMem_WB,readDataMem_WB);

//Conexionado etapa WB (write back)
mux1 selDataWriteReg (memToReg_WB,AddressMem_WB,readDataMem_WB,writeDataReg);




endmodule


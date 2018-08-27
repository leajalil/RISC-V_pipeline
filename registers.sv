module register#(parameter width=64,depth=5)
    (input logic clk,regWrite,
     input logic [4:0] readReg1,readReg2,writeReg,
     input logic [63:0] dataWrite,
     output logic [63:0] readData1,readData2);

logic [width-1:0] ram [2**depth];

initial
    begin
    integer i;
        for (i=0; i<=width; i=i+1) begin
        ram[i] = 1'b0;
        end
    end

always_ff @(posedge clk)
    if(regWrite)
        ram[writeReg]<=dataWrite;
    
assign readData1= (readReg1 == 0) ? 0:ram[readReg1];
assign readData2= (readReg2 == 0) ? 0:ram[readReg2];

endmodule
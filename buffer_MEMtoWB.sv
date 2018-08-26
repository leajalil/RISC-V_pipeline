//`timescale 1ns / 1ps

//BUFFER OF MEMORY TO WRITE BACK

module buffer_MEMtoWB #(parameter N=64)
    (input logic clk,rst,
     input logic memToReg_next,regWrite_next,
     input logic [4:0] writeReg_next,
     input logic [N-1:0] addressMem_next,dataMem_next,
     output logic memToReg_actual,regWrite_actual,
     output logic [4:0] writeReg_actual,
     output logic [N-1:0] addressMem_actual,dataMem_actual);
     
 always_ff @(posedge clk)
    if(rst) begin
        memToReg_actual<=0;
        regWrite_actual<=0;
        writeReg_actual<=0;
        addressMem_actual<=0;
        dataMem_actual<=0;
    end 
    else begin
        memToReg_actual<=memToReg_next;
        regWrite_actual<=regWrite_next;
        writeReg_actual<=writeReg_next;
        addressMem_actual<=addressMem_next;
        dataMem_actual<=dataMem_next;
    end   
    
endmodule

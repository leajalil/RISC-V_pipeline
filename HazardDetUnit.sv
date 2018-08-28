//`timescale 1ns / 1ps

//Hazard etection Unit

module HazardDetUnit #(parameter N=5)
    (input logic memRead_IDEX,regWrite_IDEX,branch_ID,
     input logic [N-1:0] readReg1_IFID,readReg2_IFID,writeReg_IDEX,
     output logic pcWrite,write_IFID,mux_IDEX);
     
     
always_comb begin
    if(memRead_IDEX) begin
        if(writeReg_IDEX==readReg1_IFID | writeReg_IDEX==readReg2_IFID)begin
            pcWrite=0;  //para el pc
            write_IFID=0;   //para el buffer IF/ID
            mux_IDEX=0;     //genero un nop cadena arriba   
        end
        else begin
            pcWrite=1;
            write_IFID=1;
            mux_IDEX=1;             
        end    
    end
    else if(regWrite_IDEX) begin
      if(branch_ID) begin
        if(writeReg_IDEX==readReg1_IFID | writeReg_IDEX==readReg2_IFID)begin
            pcWrite=0;  //para el pc
            write_IFID=0;   //para el buffer IF/ID
            mux_IDEX=0;     //genero un nop cadena arriba   
        end
        else begin
            pcWrite=1;
            write_IFID=1;
            mux_IDEX=1;             
        end    
      end
    end
    else begin
        pcWrite=1;
        write_IFID=1;
        mux_IDEX=1;   
    end    
end

endmodule

//`timescale 1ns / 1ps

//Hazard etection Unit

module HazardDetUnit #(parameter N=5)
    (input logic memRead_IDEX,
     input logic [N-1:0] readReg1_IFID,readReg2_IFID,writeReg_IDEX,
     output logic pcWrite,write_IFID,mux_IDEX);
     
     
always_comb begin
    case(memRead_IDEX)
        1'b0: begin 
                pcWrite=1;
                write_IFID=1;
                mux_IDEX=1;
              end
        1'b1: begin 
                if(writeReg_IDEX==readReg1_IFID | writeReg_IDEX==readReg2_IFID)begin
                    pcWrite=0;
                    write_IFID=0;
                    mux_IDEX=0;        
                end
                else begin
                    pcWrite=1;
                    write_IFID=1;
                    mux_IDEX=1;             
                end 
              end
        default: begin 
                    pcWrite=1;
                    write_IFID=1;
                    mux_IDEX=1;
                 end
    endcase
end

endmodule

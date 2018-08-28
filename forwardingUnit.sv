//`timescale 1ns / 1ps

//Data Hazards

module forwardingUnit
    (input logic regWrite_EXtoMEM,regWrite_MEMtoWB,
     input logic [4:0] writeReg_EXtoMEM,writeReg_MEMtoWB,readReg1,readReg2,
     output logic [1:0] forwardA,forwardB);
     
     
logic [1:0] write;

assign write={regWrite_EXtoMEM,regWrite_MEMtoWB};

always_comb begin
    case(write)
        2'b00: begin
               forwardA=2'b00;
               forwardB=2'b00;
               end
        2'b01: begin
                    if(writeReg_MEMtoWB==readReg1 & writeReg_MEMtoWB!=0)begin
                    forwardA=2'b01;
                    end
                    else begin
                    forwardA=2'b00;
                    end
                    
                    if(writeReg_MEMtoWB==readReg2 & writeReg_MEMtoWB!=0)begin
                    forwardB=2'b01;
                    end
                    else begin
                    forwardB=2'b00;
                    end              
               end
        2'b10: begin
                    if(writeReg_EXtoMEM==readReg1 & writeReg_EXtoMEM!=0)begin
                    forwardA=2'b10;
                    end
                    else begin
                    forwardA=2'b00;
                    end
                    if(writeReg_EXtoMEM==readReg2 & writeReg_EXtoMEM!=0)begin
                    forwardB=2'b10;
                    end
                    else begin
                    forwardB=2'b00;
                    end               
               end 
        2'b11: begin
                    if(writeReg_EXtoMEM==readReg1 & writeReg_EXtoMEM!=0)begin
                    forwardA=2'b10;
                    end
                    else if(writeReg_MEMtoWB==readReg1 & writeReg_MEMtoWB!=0)begin
                    forwardA=2'b01;
                    end
                    else begin
                    forwardA=2'b00;
                    end 
                                  
                    if(writeReg_EXtoMEM==readReg2 & writeReg_EXtoMEM!=0)begin
                    forwardB=2'b10;
                    end
                    else if(writeReg_MEMtoWB==readReg2 & writeReg_MEMtoWB!=0)begin
                    forwardB=2'b01;
                    end
                    else begin
                    forwardB=2'b00;
                    end               
               end 
         default: begin
                    forwardA=2'b00;
                    forwardB=2'b00;
                  end
              
    endcase
end


endmodule

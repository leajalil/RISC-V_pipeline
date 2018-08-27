module alu #(parameter width=64)
    (input logic [3:0] operation,
     input logic [width-1:0] data1,data2,
     output logic zero,
     output logic [width-1:0] aluResult);
     
always_comb
begin
    case(operation)
        4'b0000:aluResult=data1 & data2;
        4'b0001:aluResult=data1 | data2;
        4'b0010:aluResult=data1 + data2;
        4'b0110:aluResult=data1 - data2;
        default: aluResult=0;
    endcase
end

assign zero=aluResult ? 0 : 1; 
    
endmodule

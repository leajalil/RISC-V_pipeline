module ALUcontrol
    (
    input logic [1:0] ALUOp,
    input logic [3:0] instruction,
    output logic [3:0] operation);

//logic [3:0] auxR={instruction[30],instruction[14:12]};

always_comb
begin
    case(ALUOp)
    2'b00:  operation=4'b0010;
    2'b01:  operation=4'b0110;
    2'b10:  case(instruction)
            4'b0000:  operation=4'b0010;
            4'b1000:  operation=4'b0110;
            4'b0111:  operation=4'b0000;
            4'b0110:  operation=4'b0001;
            default:  operation=4'bxxxx; //puse 1111 para no hacer nada
            endcase     
    default: operation=4'bxxxx; //puse 1111 para no hacer nada
endcase
end

endmodule

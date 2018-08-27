module immGen #(parameter width=32)
    (input logic[width-1:0] instructionIn,
     output logic[width*2-1:0] instructionOut);

logic [6:0] opcode;
logic [11:0] immediate;

assign opcode=instructionIn[6:0];

always_comb
begin
    case(opcode)
    3: immediate=instructionIn[31:20];
    35:immediate={instructionIn[31:25],instructionIn[11:7]};
    99:immediate={instructionIn[31],instructionIn[7],instructionIn[30:25],instructionIn[11:8]};
    default: immediate=0;
    endcase
end

//assign instructionOut=immediate[11] ? {52'hfffffffffffff,immediate}:{52'h0000000000000,immediate};
assign instructionOut = {{52{immediate[11]}}, immediate};

endmodule
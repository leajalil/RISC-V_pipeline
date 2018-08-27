module memory #(parameter width=64,depth=8)
    (input logic clk,
     input logic memoryWri,memoryRead,
     input logic [width-1:0] address,dataWri,
     output logic [width-1:0] dataRead);

logic [width-1:0] mem [2**depth];

initial
    begin
    integer i;
        for (i=0; i<=2**depth; i=i+1) begin
        mem[i] = 1'b0;
        end
    end

initial
$readmemh("memfile.mem", mem,0,2**depth-1);

always_ff @(posedge clk) 
    if(memoryWri)
        mem[address]<=dataWri;
        
assign dataRead=memoryRead ? mem[address] : 0;

endmodule

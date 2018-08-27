module pc #(parameter width=64)
    (input logic clk,
     input logic rst,enable,
     input logic [width-1:0] nextPc,
     output logic [width-1:0] actualPc);

     
always_ff @(posedge clk) 
    if(rst)
        actualPc<=0;
    else if(enable)
        actualPc<=nextPc;
    else
        actualPc<=actualPc;
         
endmodule
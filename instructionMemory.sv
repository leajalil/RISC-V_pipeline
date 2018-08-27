module instructionMemory #(parameter width=32,depth=8)
        (input logic [width*2-1:0] PC,
         output logic [width-1:0] instruction);
 
 logic [width-1:0] ram [2**depth];
 
 initial
     begin
     integer i;
         for (i=0; i<=2**depth; i=i+1) begin
         ram[i] = 1'b0;
         end
     end
 
 
 initial
         $readmemh("test.mem",ram,0,2**depth-1);  
               
      
 assign   instruction = ram[(PC[width-1:0]/4)-1];
 
endmodule
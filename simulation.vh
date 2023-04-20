// Testbench for the juice machine
module tb_juice_machine;
   // Inputs
   reg clk;
   reg [2:0] dollar;

   // Outputs
   wire juice_1;
   wire juice_2;
   wire return_change;

   // Instantiate the juice machine
   juice_machine uut (
      .clk(clk),
      .dollar(dollar),
      .juice_1(juice_1),
      .juice_2(juice_2),
      .return_change(return_change)
   );

   // Clock generator
   always #5 clk = ~clk;

   // Test cases
   initial begin
      // Initialize inputs
      clk = 0;
      dollar = 3'b000;

      // Wait 10 time units for the initial state to settle
      #10;

      // Test case 1: Insert 1 dollar and then another 1 dollar
      dollar = 3'b001;
      #10;
      dollar = 3'b001;
      #10;

      // Test case 2: Insert 2 dollars
      dollar = 3'b010;
      #10;

      // Test case 3: Insert 5 dollars
      dollar = 3'b011;
      #10;
   end
endmodule

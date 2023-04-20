module juice_machine (input clk, input dollar, output reg juice_1, output reg juice_2, output reg return_change);
   // State register to keep track of the state of the state machine
   reg [2:0] state;

   // Always block to describe the state transitions of the state machine
   always @ (posedge clk or dollar)
      // Casez statement to specify the next state based on the current state and the amount of dollar received
      casez (state)
         // If the current state is 3'b000, the next state is either 3'b001 or 3'b010 based on the amount of dollar received
         3'b000:
            // If the dollar input is 1'b1, the next state is 3'b001
            if (dollar == 1'b1) state = 3'b001;
            // If the dollar input is 2'b1, the next state is 3'b010
            else if (dollar == 2'b1) state = 3'b010;
            // If the dollar input is 5'b1, the next state is 3'b010
            else if (dollar == 5'b1) state = 3'b010;
            break;
         // If the current state is 3'b001 and the dollar input is 1'b1, the next state is 3'b010
         3'b001:
            // If the dollar input is 1'b1, the next state is 3'b010
            if (dollar == 1'b1) state = 3'b010;
            // If the dollar input is 5'b1, the next state is 3'b000
            else if (dollar == 5'b1) state = 3'b000;
            break;
         // If the current state is 3'b010, the next state is 3'b000
         3'b010: state = 3'b000;
         // Default case if the state is not one of the above, the state remains the same
         default: state = state;
      // End of the casez statement
      endcase

   // Always block to describe the behavior of the juice and return change signals
   always @ (state)
      // Casez statement to specify the value of the juice and return change signals based on the current state
      casez (state)
         // If the current state is 3'b000, both juice signals are 1'b0 and the return change signal is 1'b1
         3'b000: begin
            juice_1 = 1'b0;
            juice_2 = 1'b0;
            return_change = 1'b1;
         end
         // If the current state is 3'b001, the juice_1 signal is 1'b1 and the juice_2 and return change signals are 1'b0
         3'b001: begin
            juice_1 = 1'b1;
            juice_2 = 1'b0;
            return_change = 1'b0;
         end
         // If the current state is 3'b010, the juice_2 signal is 1'b1 and the juice_1 and return change signals are 1'b0
         3'b010: begin
            juice_1 = 1'b0;
            juice_2 = 1'b1;
            return_change = 1'b0;
          end
        // If the current state is 3'b011, the juice_2 signal is 1'b1 and the return change signal is 3'b011
        3'b011: begin
            juice_1 = 1'b0;
            juice_2 = 1'b1;
            return_change = 3'b011;
         end
// End of the casez statement
    endcase
endmodule


module juice_machine (input clk, input dollar, output reg juice_1, output reg juice_2, output reg return_change);
   // State register to keep track of the state of the state machine
   reg [1:0] state;

   // Always block to describe the state transitions of the state machine
   always @ (posedge clk or dollar)
      // Casez statement to specify the next state based on the current state and the amount of dollar received
      casez (state)
         // If the current state is 2'b00, the next state is either 2'b01 or 2'b10 based on the amount of dollar received
         2'b00:
            // If the dollar input is 1'b1, the next state is 2'b01
            if (dollar == 1'b1) state = 2'b01;
            // If the dollar input is 2'b1, the next state is 2'b10
            else if (dollar == 2'b1) state = 2'b10;
            break;
         // If the current state is 2'b01 and the dollar input is 1'b1, the next state is 2'b10
         2'b01:
            // If the dollar input is 1'b1, the next state is 2'b10
            if (dollar == 1'b1) state = 2'b10;
            break;
         // If the current state is 2'b10, the next state is 2'b00
         2'b10: state = 2'b00;
         // Default case if the state is not one of the above, the state remains the same
         default: state = state;
      // End of the casez statement
      endcase

   // Always block to describe the behavior of the juice and return change signals
   always @ (state)
      // Casez statement to specify the value of the juice and return change signals based on the current state
      casez (state)
         // If the current state is 2'b00, both juice signals are 1'b0 and the return change signal is 1'b1
         2'b00: begin
            juice_1 = 1'b0;
            juice_2 = 1'b0;
            return_change = 1'b1;
         end
         // If the current state is 2'b01, the juice_1 signal is 1'b1 and the juice_2 and return change signals are 1'b0
         2'b01: begin
            juice_1 = 1'b1;
            juice_2 = 1'b0;
            return_change = 1'b0;
         end
         // If the current state is 2'b10, the juice_2 signal is 1'b1 and the juice_1 and return change signals are 1'b0
         2'b10: begin
            juice_1 = 1'b0;
            juice_2 = 1'b1;
            return_change = 1'b0;
         end
      // End of the casez statement
      endcase
endmodule

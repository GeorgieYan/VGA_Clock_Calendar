`timescale 1ns / 1ps

// VGA controller with assumption 25MHz pixel rate 
// 800 pixel/line, 525 lines/screen, 60 screens/second 
module vga_controller
    #(parameter horizontal_display = 640,
      parameter horizontal_left = 48,
      parameter horizontal_right = 16,
      parameter horizontal_retrace = 96,
      parameter vertical_display = 480,
      parameter vertical_left = 10,
      parameter vertical_right = 33,
      parameter vertical_retrace = 2,
      parameter h_end = 799,
      parameter v_end = 524 )(
    input clk,
    input reset,
    output video_flag, // flag is true when pixel is in display area 
    output p_tick, // to coordinate pixel generate circuit 
    output horizontal_sync,
    output vertical_sync,
    output [9:0] x_axis, // 10 bits for range 0-799 horizontally 
    output [9:0] y_axis // 10 bits for range 0-524 vertically
    );
    
    reg h_sync_reg, v_sync_reg;
    wire h_sync_next, v_sync_next; // buffer to avoid glitch 
    reg [9:0] h_counter_reg, h_counter_next, v_counter_reg, v_counter_next; // buffer to avoid glitch
    reg [1:0] reg_25M;
    wire wire_25M;
    
    //output 
    assign horizontal_sync = h_sync_reg;
    assign vertical_sync = v_sync_reg;
    assign x_axis = h_counter_reg;
    assign y_axis = v_counter_reg;
    assign p_tick = wire_25M;
    
    // horizontal and vertical synchronization 
    assign h_sync_next = (h_counter_reg <= (horizontal_display + horizontal_right + horizontal_retrace - 1)
                            && h_counter_reg >= (horizontal_display + horizontal_right));
    assign v_sync_next = (v_counter_reg <= (vertical_display + vertical_right + vertical_retrace - 1)
                            && v_counter_reg >= (vertical_display + vertical_right));
    // video flag boolean value 
    assign video_flag = (h_counter_reg < horizontal_display) && (v_counter_reg < vertical_display);
    
    // 25MHz to 100MHz on Basys 3 board 
    always @(posedge clk or posedge reset) begin
        if(reset)
            reg_25M <= 0; //reset
        else
            reg_25M <= reg_25M + 1;
    end
    assign wire_25M = (reg_25M == 0) ? 1 : 0; // tick with 1/4 of 100MHz
    
    //horizontal and vertical scanning counter
    always @(posedge wire_25M or posedge reset) begin // 25 MHZ tick 
        if(reset) begin
            h_counter_next <= 0; // reset 
        end
        else begin
            if(h_counter_reg == h_end) 
                h_counter_next <= 0; // at the end of scanning horizontally 
            else   
                h_counter_next = h_counter_reg + 1; // elsewise update counter value 
        end
    end
    
    // vertical scanning counter 
    always @(posedge wire_25M or posedge reset) begin
        if(reset)
            v_counter_next <= 0; // reset 
        else begin
            if(h_counter_reg == h_end) // end of horizontal scan 
                if(v_counter_reg == v_end) // end of vertical scan 
                    v_counter_next = 0;
                else
                    v_counter_next = v_counter_reg + 1; // elsewise add one 
        end
    end 
    
    // register
    always @(posedge clk or posedge reset) begin 
        if(reset) begin
            h_sync_reg <= 1'b0; // assign 1'b0 since there's only one digit
            v_sync_reg <= 1'b0; // assign 1'b0 since there's only one digit 
            h_counter_reg <= 0; // reset 
            v_counter_reg <= 0; // reset 
        end
        else begin 
            h_sync_reg <= h_sync_next;
            v_sync_reg <= v_sync_next;
            h_counter_reg <= h_counter_next;
            v_counter_reg <= v_counter_next;
        end
    end
   
endmodule

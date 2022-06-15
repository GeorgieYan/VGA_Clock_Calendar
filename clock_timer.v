`timescale 1ns / 1ps

// clock design module with debouncing button implementation 
module clock_timer(
    input clk,
    input reset,
    input am_or_pm,
    input hours_inc,
    input mins_inc,
    output tick_one_Hz,
    output am_pm,
    output day_end,
    output [3:0] hour_ones, hour_tens, min_ones, min_tens, sec_ones, sec_tens //4 digits for 12
    );
    
    reg [5:0] second_counter = 6'b0; // 6 bits for 60 seconds 
    reg [5:0] minute_counter = 6'b0; // 6 bits for 60 minutes
    reg [3:0] hour_counter = 4'hc; // 4 bits for 12 hours 
    reg am_pm_flag = 1'b0;
    wire am_pm_switch = ((second_counter == 59)&&(minute_counter == 59)&&(hour_counter == 11)) ? 1:0;
    // check if need to switch between am and pm 
    
    // assign ones and tens value from the counters 
    assign hour_ones = hour_counter % 10;
    assign hour_tens = hour_counter / 10;
    assign min_ones = minute_counter % 10;
    assign min_tens = minute_counter / 10;
    assign sec_ones = second_counter % 10;
    assign sec_tens = second_counter / 10;
    
    assign day_end = ((am_pm_flag == 1) && (second_counter == 59) && (minute_counter == 59) && (hour_counter == 11)) ? 1:0;
    // if am pm switches once, hour reaches 12, minute and second reach 59, a day is over 
    assign am_pm = am_pm_flag; 
    
    //create 1Hz input 
    reg [31:0] one_hz = 32'h0;
    reg hz_flag = 1'b0;
    always @(posedge clk or posedge reset) begin 
        if(reset)
            one_hz <= 32'h0; // reset
        else begin
            if(one_hz == 49_999_999) begin
                one_hz <= 32'h0; // reset
                hz_flag <= ~hz_flag; // flip boolean value
            end
            else
                one_hz <= one_hz + 1; // elsewise increment by 1 
        end         
    end
    assign tick_one_Hz = hz_flag; // 1Hz output 
    
    // debounce for hour button 
    reg hour_1, hour_2, hour_3;
    wire hour_btn;
    always @(posedge clk) begin 
        hour_1 <= hours_inc;
        hour_2 <= hour_1;
        hour_3 <= hour_2;
    end
    assign hour_btn = hour_3;
    
    // debounce for minute button 
    reg min_1, min_2, min_3;
    wire min_btn;
    always @(posedge clk) begin
        min_1 <= mins_inc;
        min_2 <= min_1;
        min_3 <= min_2;
    end
    assign min_btn = min_3;
    
    // debounce for am/pm input
    reg ap_1, ap_2, ap_3;
    wire ampm_btn;
    always @(posedge clk) begin
        ap_1 <= am_or_pm;
        ap_2 <= ap_1;
        ap_3 <= ap_2;
    end
    assign ampm_btn = ap_3;
    
    // seconds control 
    always @(posedge tick_one_Hz or posedge reset) begin
        if(reset)
            second_counter <= 6'b0; // reset 
        else begin
            if(second_counter == 59)
                second_counter <= 6'b0; // reset
            else
                second_counter <= second_counter + 1; // elsewise increment by 1 
        end
    end 
    
    // minutes control 
    always @(posedge tick_one_Hz or posedge reset) begin
        if(reset)
            minute_counter <= 6'b0; // reset 
        else begin
            if(min_btn | (second_counter == 59)) begin // if second reaches 60 or inc btn is pressed 
                if(minute_counter == 59)
                    minute_counter <= 6'b0; // if minute is 59, reset to 0
                else 
                    minute_counter <= minute_counter + 1; // elsewise increment minute by 1
            end 
        end    
    end 
    
    // hours control 
    always @(posedge tick_one_Hz or posedge reset) begin
        if(reset)
            hour_counter <= 4'hc; // reset to 12 
        else begin
            if(hour_btn | (second_counter == 59 && minute_counter == 59)) begin // if both second and minute are 59
                if(hour_counter == 12)
                    hour_counter <= 4'h1; // inc to one since am pm switch 
                else
                    hour_counter <= hour_counter + 1; // elsewise add one 
            end
        end 
    end 
    
    // am pm control 
    always @(posedge tick_one_Hz or posedge reset) begin 
        if(reset)
            am_pm_flag <= 1'b0; // reset 
        else begin
            if(ampm_btn | am_pm_switch) 
                am_pm_flag <= ~am_pm_flag; // change boolean value 
        end 
    end 
    
endmodule

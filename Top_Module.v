`timescale 1ns / 1ps

// Top Module 
module Top_Module(
    input clk,    
    input reset,               
    input add_hour,           
    input add_min, 
    input add_cen,  
    input add_year,           
    input add_month,            
    input add_day,                                     
    input am_or_pm,           
    output led_second,               
    output h_sync,              
    output v_sync,               
    output [11:0] rgb           
    );
    
    wire [9:0] wire_x, wire_y;
    wire video_flag, p_tick, am_pm;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    wire [3:0] hour_tens, hour_ones, min_tens, min_ones, sec_tens, sec_ones;
    wire [3:0] mon_tens, mon_ones, day_tens, day_ones, cen_tens, cen_ones, year_tens, year_ones;
    
    // rgb buffer
    always @(posedge clk)
        if(p_tick)
            rgb_reg <= rgb_next;     
    assign rgb = rgb_reg;
    
    vga_controller vgc(
        .clk(clk),
        .reset(reset),
        .video_flag(video_flag),
        .horizontal_sync(h_sync),
        .vertical_sync(v_sync),
        .p_tick(p_tick),
        .x_axis(wire_x),
        .y_axis(wire_y)
        );

    top_pixel_gen pixel(
        .clk(clk),
        .video_flag(video_flag),
        .rgb(rgb_next),
        .x(wire_x),
        .y(wire_y),
        .sec_tens(sec_tens),
        .sec_ones(sec_ones),
        .min_tens(min_tens),
        .min_ones(min_ones),
        .hour_tens(hour_tens),
        .hour_ones(hour_ones),
        .am_pm(am_pm),
        .cen_tens(cen_tens),
        .cen_ones(cen_ones),
        .year_tens(year_tens),
        .year_ones(year_ones),
        .mon_tens(mon_tens),
        .mon_ones(mon_ones),
        .day_tens(day_tens),
        .day_ones(day_ones)
        );

    top_clock_calendar clock_and_calendar(
        .clk(clk),
        .reset(reset),
        .add_hour(add_hour),
        .add_minute(add_min),
        .add_month(add_month), 
        .add_day(add_day),
        .add_year(add_year),
        .add_century(add_cen),
        .am_or_pm(am_or_pm),
        .am_pm(am_pm),
        .one_Hz(led_second),
        .hour_tens(hour_tens),
        .hour_ones(hour_ones),
        .min_tens(min_tens),
        .min_ones(min_ones),
        .sec_tens(sec_tens),
        .sec_ones(sec_ones),
        .cen_tens(cen_tens),
        .cen_ones(cen_ones),
        .year_tens(year_tens),
        .year_ones(year_ones),
        .mon_tens(mon_tens),
        .mon_ones(mon_ones),
        .day_tens(day_tens),
        .day_ones(day_ones)
        );
    
endmodule

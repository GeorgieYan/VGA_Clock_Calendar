`timescale 1ns / 1ps

// top module design for clock and calendar
module top_clock_calendar(
    input clk,
    input reset,
    input add_hour, add_minute, add_month, add_day, add_year, add_century, am_or_pm,
    output am_pm, one_Hz,
    output [3:0] hour_tens, hour_ones, min_tens, min_ones, sec_tens, sec_ones, 
    output [3:0] cen_tens, cen_ones, year_tens, year_ones, mon_tens, mon_ones, day_tens, day_ones
    );
    
    wire wire_day_end, wire_one_Hz;  
    assign one_Hz = wire_one_Hz;
    
    calendar cal(
        .clk(clk),
        .tick_one_Hz(wire_one_Hz),
        .reset(reset),
        .day_end(wire_day_end),
        .add_cen(add_century),
        .add_year(add_year),
        .add_month(add_month),
        .add_day(add_day),       
        .cen_tens(cen_tens),
        .cen_ones(cen_ones),
        .year_tens(year_tens),
        .year_ones(year_ones),
        .mon_tens(mon_tens),
        .mon_ones(mon_ones),
        .day_tens(day_tens),
        .day_ones(day_ones)
        );
    
    clock_timer bin_clk(
        .clk(clk),
        .reset(reset),
        .am_pm(am_pm),
        .tick_one_Hz(wire_one_Hz),
        .day_end(wire_day_end),
        .am_or_pm(am_or_pm),
        .hours_inc(add_hour),
        .mins_inc(add_minute),
        .hour_tens(hour_tens),
        .hour_ones(hour_ones),
        .min_tens(min_tens),
        .min_ones(min_ones),
        .sec_tens(sec_tens),
        .sec_ones(sec_ones) 
        );       
    
endmodule

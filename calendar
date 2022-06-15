`timescale 1ns / 1ps

//calendar design module with debouncing button implementation 
module calendar(
    input clk,
    input reset,
    input tick_one_Hz,
    input day_end,
    input add_cen,
    input add_year,
    input add_month,
    input add_day,
    output [3:0] cen_ones, cen_tens, year_ones, year_tens, mon_ones, mon_tens, day_ones, day_tens
    );
    
    reg [6:0] century = 20; // 7 bits for century storage with 20 as start 
    reg [6:0] year = 22; // 7 bits for year storage with 22 as start 
    reg [3:0] month = 1; // 4 bits for month storage of range 12 
    reg [4:0] day = 1; // 5 bits for day storage of range 31 
    
    wire cen_end, year_end, leap_year;
    assign cen_end = ((year == 99) && year_end) ? 1:0;
    assign year_end = ((month == 12 && day == 31) & day_end) ? 1:0;
    assign leap_year = (year % 4 == 0) ? 1:0; //if it is divisible by 4, its a leap year 
    
    // assign ones and tens value 
    assign cen_ones = century % 10;
    assign cen_tens = century / 10;
    assign year_ones = year % 10;
    assign year_tens = year / 10;
    assign mon_ones = month % 10;
    assign mon_tens = month / 10;
    assign day_ones = day % 10;
    assign day_tens = day / 10;
    
    // debounce for century button 
    reg cen_1, cen_2, cen_3;
    wire cen_btn;
    always @(posedge clk) begin 
        cen_1 <= add_cen;
        cen_2 <= cen_1;
        cen_3 <= cen_2;
    end
    assign cen_btn = cen_3;
    
    // debounce for year button 
    reg year_1, year_2, year_3;
    wire year_btn;
    always @(posedge clk) begin
        year_1 <= add_year;
        year_2 <= year_1;
        year_3 <= year_2;
    end
    assign year_btn = year_3;
    
    // debounce for month button 
    reg mon_1, mon_2, mon_3;
    wire mon_btn;
    always @(posedge clk) begin
        mon_1 <= add_month;
        mon_2 <= mon_1;
        mon_3 <= mon_2;
    end
    assign mon_btn = mon_3;
    
    // debounce for day button 
    reg day_1, day_2, day_3;
    wire day_btn;
    always @(posedge clk) begin
        day_1 <= add_day;
        day_2 <= day_1;
        day_3 <= day_2;
    end
    assign day_btn = day_3;
    
    // century control 
    always @(posedge tick_one_Hz or posedge reset) begin 
        if(reset)
            century <= 7'd20; // reset to 20 
        else begin
            if(cen_btn | cen_end) begin
                if(century == 99)
                    century <= 0; // reset 
                else 
                    century <= century + 1; // elsewise increase one 
            end    
        end
    end
    
    // year control 
    always @(posedge tick_one_Hz or posedge reset) begin 
        if(reset)
            year = 7'd22; // reset to 22 
        else begin
            if(year_btn | year_end) begin 
                if(year == 99)
                    year <= 0; // reset 
                else
                    year <= year + 1; //elsewise add one
            end
        end
    end
    
    // month control 
    always @(posedge tick_one_Hz or posedge reset) begin
        if(reset)
            month = 4'd1; // reset 
        else begin
            if(mon_btn) begin
                if(month == 12)
                    month <= 1; // reset to one 
                else
                    month <= month + 1; // elsewise add one 
            end
            // specific case for each month 
            else if((month == 1 && day == 31) & day_end)
                month <= 2;
            else if((month == 2 && day == 28) & day_end & ~leap_year)
                month <= 3;
            else if((month == 2 && day == 29) & day_end & leap_year)
                month <= 3;
            else if((month == 3 && day == 31) & day_end)
                month <= 4;
            else if((month == 4 && day == 30) & day_end)
                month <= 5;
            else if((month == 5 && day == 31) & day_end)
                month <= 6;
            else if((month == 6 && day == 30) & day_end)
                month <= 7;
            else if((month == 7 && day == 31) & day_end)
                month <= 8;
            else if((month == 8 && day == 31) & day_end)
                month <= 9;
            else if((month == 9 && day == 30) & day_end)
                month <= 10;
            else if((month == 10 && day == 31) & day_end)
                month <= 11;
            else if((month == 11 && day == 30) & day_end)
                month <= 12;
            else if(year_end & day_end)
                month <= 1;
        end
    end
    
    // day control 
     always @(posedge tick_one_Hz or posedge reset) begin
        if(reset)
            day = 5'd1; // reset 
        else begin
            if(day_btn | day_end) begin 
                case(month) // specific case for each month 
                    1 : begin
                            if(day == 31)
                                day <= 1; 
                            else
                                day <= day + 1;
                        end
                    2 : begin
                            if(~leap_year && day == 28)
                                day <= 1;
                            else if(leap_year && day == 29)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    3 : begin
                            if(day == 31)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    4 : begin
                            if(day == 30)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    5 : begin
                            if(day == 31)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    6 : begin
                            if(day == 30)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    7 : begin
                            if(day == 31)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    8 : begin
                            if(day == 31)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    9 : begin
                            if(day == 30)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    10: begin
                            if(day == 31)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    11: begin
                            if(day == 30)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    12: begin
                            if(day == 31)
                                day <= 1;
                            else
                                day <= day + 1;
                        end
                    default: day = 1;
                endcase
            end
        end 
    end
    
endmodule

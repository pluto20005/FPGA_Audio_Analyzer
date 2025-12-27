`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/28 01:39:44
// Design Name: 
// Module Name: freq_to_note_full_48k
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module freq_to_note_full_48k(
    input  wire [15:0] freq,       // 输入频率 f (Hz)
    output reg  [23:0] note_name   // 输出 3 个字符，如 " C4", "#C4"
);

    always @(*) begin
        // --- 4阶 (中音区: 261.6Hz - 493.9Hz) ---
        if      (freq < 254)  note_name = "---";
        else if (freq < 270)  note_name = " C4";
        else if (freq < 285)  note_name = "#C4";
        else if (freq < 311)  note_name = " D4";
        else if (freq < 320)  note_name = "#D4";
        else if (freq < 339)  note_name = " E4";
        else if (freq < 370)  note_name = " F4";
        else if (freq < 380)  note_name = "#F4";
        else if (freq < 415)  note_name = " G4";
        else if (freq < 427)  note_name = "#G4";
        else if (freq < 452)  note_name = " A4";
        else if (freq < 480)  note_name = "#A4";
        else if (freq < 508)  note_name = " B4";
        
        // --- 5阶 (523.3Hz - 987.8Hz) ---
        else if (freq < 540)  note_name = " C5";
        else if (freq < 570)  note_name = "#C5";
        else if (freq < 605)  note_name = " D5";
        else if (freq < 640)  note_name = "#D5";
        else if (freq < 679)  note_name = " E5";
        else if (freq < 719)  note_name = " F5";
        else if (freq < 761)  note_name = "#F5";
        else if (freq < 807)  note_name = " G5";
        else if (freq < 855)  note_name = "#G5";
        else if (freq < 906)  note_name = " A5";
        else if (freq < 960)  note_name = "#A5";
        else if (freq < 1017) note_name = " B5";

        // --- 6阶 (1046.5Hz - 1975.5Hz) ---
        else if (freq < 1078) note_name = " C6";
        else if (freq < 1143) note_name = "#C6";
        else if (freq < 1209) note_name = " D6";
        else if (freq < 1282) note_name = "#D6";
        else if (freq < 1358) note_name = " E6";
        else if (freq < 1439) note_name = " F6";
        else if (freq < 1525) note_name = "#F6";
        else if (freq < 1616) note_name = " G6";
        else if (freq < 1711) note_name = "#G6";
        else if (freq < 1814) note_name = " A6";
        else if (freq < 1921) note_name = "#A6";
        else if (freq < 2036) note_name = " B6";

        // --- 7阶 (2093.0Hz - 3951.1Hz) ---
        else if (freq < 2157) note_name = " C7";
        else if (freq < 2286) note_name = "#C7";
        else if (freq < 2422) note_name = " D7";
        else if (freq < 2564) note_name = "#D7";
        else if (freq < 2717) note_name = " E7";
        else if (freq < 2878) note_name = " F7";
        else if (freq < 3050) note_name = "#F7";
        else if (freq < 3231) note_name = " G7";
        else if (freq < 3422) note_name = "#G7";
        else if (freq < 3627) note_name = " A7";
        else if (freq < 3842) note_name = "#A7";
        else if (freq < 4072) note_name = " B7";

        // --- 8阶 (4186.0Hz - 7902.1Hz) ---
        else if (freq < 4315) note_name = " C8";
        else if (freq < 4571) note_name = "#C8";
        else if (freq < 4842) note_name = " D8";
        else if (freq < 5130) note_name = "#D8";
        else if (freq < 5434) note_name = " E8";
        else if (freq < 5758) note_name = " F8";
        else if (freq < 6100) note_name = "#F8";
        else if (freq < 6463) note_name = " G8";
        else if (freq < 6847) note_name = "#G8";
        else if (freq < 7254) note_name = " A8";
        else if (freq < 7685) note_name = "#A8";
        else if (freq < 8143) note_name = " B8";
        
        else                  note_name = "OUT"; // 超出量程
    end

endmodule


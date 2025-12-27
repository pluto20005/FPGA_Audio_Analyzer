`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/25 00:08:26
// Design Name: 
// Module Name: data_in_gen
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


module data_in_gen(clk,reset,f,data_in);
    input clk;
    input reset;
    input[31:0] f;
    output[31:0] data_in;
    
    wire[31:0] data_in;
    reg[3:0] q,b,s,g,xs,xb,xq,xw;
    reg[3:0] weishu;
    reg [31:0] f_temp;
    

    always @(posedge clk or negedge reset)
        if(!reset) begin
            weishu<=0;
            f_temp <=0;
            xw <= 3'b0; xq <= 3'b0; xb <= 3'b0; xs <= 3'b0;
            g <= 3'b0; s <= 3'b0; b <= 3'b0; q <= 3'b0;
        end
        else begin

            if(weishu>=0) begin
                case(weishu)
                    4'd0:
                        begin
                            xw<=f_temp%10;
                            f_temp<=f_temp/10;
                            weishu<=weishu+1'd1;
                        end
                    4'd1:
                        begin
                            xq<=f_temp%10;
                            f_temp<=f_temp/10;
                            weishu<=weishu+1'd1;
                        end
                    4'd2:
                        begin
                            xb<=f_temp%10;
                            f_temp<=f_temp/10;
                            weishu<=weishu+1'd1;
                        end
                    4'd3:
                        begin
                            xs<=f_temp%10;
                            f_temp<=f_temp/10;
                            weishu<=weishu+1'd1;
                        end
                    4'd4:
                        begin
                            g<=f_temp%10;
                            f_temp<=f_temp/10;
                            weishu<=weishu+1'd1;
                        end
                    4'd5:
                        begin
                            s<=f_temp%10;
                            f_temp<=f_temp/10;
                            weishu<=weishu+1'd1;
                        end
                    4'd6:
                        begin
                            b<=f_temp%10;
                            f_temp<=f_temp/10;
                            weishu<=weishu+1'd1;
                        end
                    4'd7:
                        begin
                            q<=f_temp%10;
                            f_temp<=f_temp/10;
                            weishu<=weishu+1'd1;
                        end
                        
                    default:
                        begin
                            f_temp<=f;
                            weishu<=4'd0;
                        end
                endcase
                
            end
        end
    assign data_in={q,b,s,g,xs,xb,xq,xw};                    
                    
            


endmodule
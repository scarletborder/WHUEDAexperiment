module led(clk,data,sw,change);
input clk,sw,change;
output[3:0] data;
reg clk1s;
parameter max=5000000;
reg[1:0] state=2'b00;
reg[30:0] n;
reg[3:0] data;
always @(posedge clk)begin
    if(n==max)begin
        if(!clk1s)clk1s<=1'b1;
        else clk1s<=1'b0;
        n<=0;
        end
    else n<=n+1;
    end
always @(posedge clk1s)begin
    case(state)
    2'b00:begin
        if( change ) state<=2'b11;
        else state<=2'b01;
        if(sw)begin
        data<=4'b1000;
        end
        else begin
        data<=4'b0111;
        end
       end
    2'b01:begin
        if( change ) state<=2'b00;
        else state<=2'b10;
        if(sw)begin
        data<=4'b0100;
        end
        else begin
        data<=4'b1011;
        end
    end
    2'b10:begin
        if( change ) state<=2'b01;
         else state<=2'b11;
        if(sw)begin
        data<=4'b0010;
        end
        else begin
        data<=4'b1101;
        end
    end
    2'b11:begin
        if( change ) state<=2'b10;
            else state<=2'b00;
        if(sw)begin
        data<=4'b0001;
        end
        else begin
        data<=4'b1110;
        end
    end
    endcase
end
endmodule
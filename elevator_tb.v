module tb_elevator;

    reg clk;
    reg rst_n;
    reg [3:0] req;
    wire [1:0] current_floor;
    wire [1:0] direction;
    wire door_open;

    elevator_controller dut (
        .clk(clk),
        .rst_n(rst_n),
        .req(req),
        .current_floor(current_floor),
        .direction(direction),
        .door_open(door_open)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        req = 0;

        #10 rst_n = 1;

        #10 req = 4'b0100; // request floor 2
        #40 req = 4'b1000; // request floor 3
        #40 req = 0;

        #100 $stop;
    end
endmodule

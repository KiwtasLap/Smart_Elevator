module elevator_controller (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [3:0]  req,              // Floor requests
    output reg  [1:0]  current_floor,    // 0-3
    output reg  [1:0]  direction,         // 00-IDLE, 01-UP, 10-DOWN
    output reg         door_open
);

    // -----------------------------
    // FSM State Encoding
    // -----------------------------
    localparam IDLE       = 3'b000;
    localparam MOVE_UP    = 3'b001;
    localparam MOVE_DOWN  = 3'b010;
    localparam DOOR_OPEN  = 3'b011;
    localparam DOOR_CLOSE = 3'b100;

    reg [2:0] state, next_state;
    reg [1:0] target_floor;

    // -----------------------------
    // State Register
    // -----------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    // -----------------------------
    // Target Floor Latch
    // -----------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            target_floor <= 2'd0;
        else if (state == IDLE && |req) begin
            if (req[3]) target_floor <= 2'd3;
            else if (req[2]) target_floor <= 2'd2;
            else if (req[1]) target_floor <= 2'd1;
            else if (req[0]) target_floor <= 2'd0;
        end
    end

    // -----------------------------
    // Next State Logic
    // -----------------------------
    always @(*) begin
        next_state = state;

        case (state)
            IDLE: begin
                if (|req) begin
                    if (target_floor > current_floor)
                        next_state = MOVE_UP;
                    else if (target_floor < current_floor)
                        next_state = MOVE_DOWN;
                    else
                        next_state = DOOR_OPEN;
                end
            end

            MOVE_UP: begin
                if (current_floor < target_floor)
                    next_state = MOVE_UP;
                else
                    next_state = DOOR_OPEN;
            end

            MOVE_DOWN: begin
                if (current_floor > target_floor)
                    next_state = MOVE_DOWN;
                else
                    next_state = DOOR_OPEN;
            end

            DOOR_OPEN:
                next_state = DOOR_CLOSE;

            DOOR_CLOSE:
                next_state = IDLE;

            default:
                next_state = IDLE;
        endcase
    end

    // -----------------------------
    // Output & Datapath Logic
    // -----------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_floor <= 2'd0;
            direction     <= 2'b00;
            door_open     <= 1'b0;
        end else begin
            case (state)
                MOVE_UP: begin
                    direction <= 2'b01;
                    if (current_floor < 2'd3)
                        current_floor <= current_floor + 1'b1;
                end

                MOVE_DOWN: begin
                    direction <= 2'b10;
                    if (current_floor > 2'd0)
                        current_floor <= current_floor - 1'b1;
                end

                DOOR_OPEN: begin
                    door_open <= 1'b1;
                    direction <= 2'b00;
                end

                DOOR_CLOSE: begin
                    door_open <= 1'b0;
                end

                IDLE: begin
                    direction <= 2'b00;
                end
            endcase
        end
    end

endmodule

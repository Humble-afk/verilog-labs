//and_df.v

module and_df(

    input a,
    input b,
    output reg y
);

    always @(*) begin
        y= #3 (a&b);
    end
endmodule

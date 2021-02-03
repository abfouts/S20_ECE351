module test(a, b);
input logic a, b;
always_comb begin

case({a,b})
0: $display("test");
1: $display("test");
2: $display("test");
3: $display("test");
endcase
end

endmodule

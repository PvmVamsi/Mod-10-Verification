module top;
	import uvm_pkg::*;
	import pkg::*;
	
	bit clk;
	always #5 clk=~clk;

	mod10_if IF(.clk(clk));
	
	mod10_counter DUV(.clock(IF.clk), .rst(IF.rst), .mode(IF.mode), .load(IF.load), .data_in(IF.data_in), .data_out(IF.data_out));

	initial begin

		`ifdef VCS
       	 	 $fsdbDumpvars(0, top);
        	`endif

		uvm_config_db#(virtual mod10_if)::set(null,"*","mod10_if",IF);
		run_test();
	end
endmodule

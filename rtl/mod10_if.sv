interface mod10_if(input bit clk);
	bit rst;
        bit mode;
	bit load;
    	logic[3:0] data_in;
        logic[3:0]data_out;

	clocking wr_drv_cb@(posedge clk);
		default input #1 output #1;
		output rst,mode,load;
		output data_in;
	endclocking

	clocking wr_mon_cb@(posedge clk);
		default input #1 output #1;
		input rst,mode,load;
		input data_in;
	endclocking

	clocking rd_mon_cb@(posedge clk);
		default input #1 output #1;
		input data_out;
	endclocking

	modport wr_mon(clocking wr_mon_cb);
	modport wr_drv(clocking wr_drv_cb);
	modport rd_mon(clocking rd_mon_cb);

endinterface

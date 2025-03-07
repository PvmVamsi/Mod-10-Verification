class env_cfg extends uvm_object;
	`uvm_object_utils(env_cfg)
	
	function new(string name ="env_cfg");
		super.new(name);
	endfunction

	int no_of_wr,no_of_rd;
	
	wr_agt_cfg wr_cfg[];
	rd_agt_cfg rd_cfg[];
	
endclass	

class rd_agt_cfg extends uvm_object;
	`uvm_object_utils(rd_agt_cfg)
	
	function new(string name = "rd_agt_cfg");
		super.new(name);
	endfunction

	uvm_active_passive_enum is_active;
	virtual mod10_if vif;
endclass

	

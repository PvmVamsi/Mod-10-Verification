class rd_driver extends uvm_driver#(rd_xtn);
	`uvm_component_utils(rd_driver)
	
	function new(string name = "rd_driver",uvm_component parent = null);
		super.new(name,parent);
	endfunction
endclass

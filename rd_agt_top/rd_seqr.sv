class rd_seqr extends uvm_sequencer#(rd_xtn);
	`uvm_component_utils(rd_seqr)
	function new(string name = "rd_seqr",uvm_component parent = null);
		super.new(name,parent);
	endfunction
endclass

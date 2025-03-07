class rd_xtn extends uvm_sequence_item;
	`uvm_object_utils(rd_xtn);
	function new(string name = "rd_xtn");
		super.new(name);
	endfunction
	
        bit[3:0]data_out;
	function void do_print(uvm_printer printer);
			printer.print_field("data_out",data_out,4,UVM_DEC);
	endfunction	

endclass

class wr_xtn extends uvm_sequence_item;
       `uvm_object_utils(wr_xtn);
	function new(string name = "wr_xtn");
		super.new(name);
	endfunction
	
        rand bit rst;
	rand bit mode;
	rand bit load;
	rand bit[3:0]data_in;


/*	
	`uvm_object_utils_begin(wr_xtn)
		`uvm_field_int(rst, UVM_ALL_ON)	
		`uvm_field_int(mode, UVM_ALL_ON )
		`uvm_field_int(load, UVM_ALL_ON)
		`uvm_field_int(data_in, UVM_ALL_ON)
	`uvm_object_utils_end
*/

	function void do_print(uvm_printer printer);
			printer.print_field("rst",rst,1,UVM_BIN);
			printer.print_field("mode",mode,1,UVM_BIN);
			printer.print_field("load",load,1,UVM_BIN);
			printer.print_field("data_in",data_in,4,UVM_DEC);
	endfunction	

	constraint range {rst dist{1:=1,0:=20};}
	constraint range_data_in {data_in inside{[0:11]};}
	constraint load_c{load dist{0:=20,1:=5};}
endclass
	

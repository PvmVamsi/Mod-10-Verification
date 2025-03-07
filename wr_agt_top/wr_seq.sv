class wr_seq extends uvm_sequence#(wr_xtn);
	`uvm_object_utils(wr_seq)
	
	function new(string name = "wr_seq");
		super.new(name);
	endfunction
	

	task body();
		begin 
				req  = wr_xtn::type_id::create("wr_xtn");
				start_item(req);
				assert(req.randomize() with {req.rst==1;});
				finish_item(req);
		end

		repeat(10) begin

		req  = wr_xtn::type_id::create("wr_xtn");
		start_item(req);
		//assert(req.randomize() with {req.load==1;req.rst==0;});
		assert(req.randomize());

		//`uvm_info(get_type_name(),"\n============================The randomized data===================",UVM_HIGH)
		//req.print();
		finish_item(req);
		end

		
	endtask
endclass

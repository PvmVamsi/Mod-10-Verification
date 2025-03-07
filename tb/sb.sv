class sb extends uvm_scoreboard;
	`uvm_component_utils(sb)
	
	uvm_tlm_analysis_fifo #(rd_xtn) rd_fifoh[];
	uvm_tlm_analysis_fifo #(wr_xtn) wr_fifoh[];

	env_cfg m_cfg;


	wr_xtn wxtn;
	rd_xtn rxtn;
	bit[3:0]data_out;

	int unsigned count_matched = 0;	
	int unsigned count_read = 0;
	

	covergroup cv;
		reset:coverpoint wxtn.rst {bins rst[] = {1,0};}
		load:coverpoint wxtn.load {bins load[] = {1,0};}
		mode:coverpoint wxtn.mode {bins mode[] = {1,0};}
		data_in:coverpoint wxtn.data_in {illegal_bins ill_data_in [] = {[12:15]};}
		data_out:coverpoint rxtn.data_out {illegal_bins ill_data_out[] = {[12:15]};}
	endgroup


	function new(string name = "sb",uvm_component parent = null);
			super.new(name,parent);
			cv = new;
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_cfg)::get(this,"","env_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"cant get env cfg")
		$display("m_cfg.no_of_rd : %0d=============================",m_cfg.no_of_rd);	
		rd_fifoh = new[m_cfg.no_of_rd];
		wr_fifoh = new[m_cfg.no_of_wr];
		
		foreach(rd_fifoh[i])
			rd_fifoh[i] = new($sformatf("rd_fifoh[%0d]",i),this);
		
		
		foreach(wr_fifoh[i])
			wr_fifoh[i] = new($sformatf("wr_fifoh[%0d]",i),this);
	endfunction	

	task run_phase(uvm_phase phase);
		fork
			forever begin
				wr_fifoh[0].get(wxtn);
				`uvm_info("SB",$sformatf("The W_XTN from sb :%s",wxtn.sprint()),UVM_LOW)
				check_data(wxtn);
				cv.sample();			
			end

	
			forever begin
				rd_fifoh[0].get(rxtn);
					`uvm_info("SB",$sformatf("The R_XTN from sb :%s",rxtn.sprint()),UVM_LOW)
				count_read++;
							

				
				if(data_out == rxtn.data_out)begin
					`uvm_info("SB","The data is matched================",UVM_LOW)
						count_matched++;
					end
				else
					`uvm_info("SB",$sformatf("===MISMATCH dout = %0d=====",data_out),UVM_LOW)
			end	
	
		join
	endtask

	function void extract_phase(uvm_phase phase);
		`uvm_info("EXTRACT PHASE",$sformatf("Matched : %0d",count_matched),UVM_LOW)
		`uvm_info("EXTRACT PHASE",$sformatf("Mismatched : %0d",count_read-count_matched),UVM_LOW)

	endfunction

	task check_data(wr_xtn wxtn);
		if(wxtn.rst==1)
			data_out = 0;
		else if(wxtn.load == 1)
			data_out = wxtn.data_in;
		else 
			if(wxtn.mode)
				if(data_out == 9)
					data_out = 0; 
				else 
					data_out = data_out + 1; 
			else
				if(data_out == 0)
					data_out = 9; 
				else 
					data_out = data_out - 1; 

	endtask

endclass

class vseqr extends uvm_sequencer#(uvm_sequence_item);
	`uvm_component_utils(vseqr)
	
	function new(string name = "vseqr",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	env_cfg m_cfg;
	
	wr_seqr wr_seqrh[];
	rd_seqr rd_seqrh[];

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_cfg)::get(this,"","env_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"cant get config")
		wr_seqrh = new[m_cfg.no_of_wr];
		rd_seqrh = new[m_cfg.no_of_rd];
	endfunction

endclass

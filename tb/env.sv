class env extends uvm_env;
	`uvm_component_utils(env)
	
	function new(string name = "env",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	wr_agt_top wr_toph;
	rd_agt_top rd_toph;
	
	sb sbh;
	vseqr vseqrh;

	env_cfg m_cfg;

	function void build_phase(uvm_phase phase);
		  wr_toph = wr_agt_top::type_id::create("wr_toph",this);
		  rd_toph = rd_agt_top::type_id::create("rd_toph",this);
		  sbh = sb::type_id::create("sbh",this);
		  vseqrh = vseqr::type_id::create("vseqrh",this);

		 if(!uvm_config_db #(env_cfg) :: get(this,"","env_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"From the env cfg");
		 
	endfunction

	function void connect_phase(uvm_phase phase);
		for(int i = 0;i<m_cfg.no_of_wr;i++)
			if(m_cfg.wr_cfg[i].is_active == UVM_ACTIVE)
				vseqrh.wr_seqrh[i] = wr_toph.wr_agt_h[i].wr_seqr_h;

		for(int i = 0;i<m_cfg.no_of_rd;i++)
			if(m_cfg.rd_cfg[i].is_active == UVM_ACTIVE)
				vseqrh.rd_seqrh[i] = rd_toph.rd_agt_h[i].rd_seqr_h;
		
		wr_toph.wr_agt_h[0].wr_monitor_h.wm_port.connect(sbh.wr_fifoh[0].analysis_export);
		rd_toph.rd_agt_h[0].rd_monitor_h.rm_port.connect(sbh.rd_fifoh[0].analysis_export);

	endfunction
endclass

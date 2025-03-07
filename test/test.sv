class test extends uvm_test;
	`uvm_component_utils(test)
	
	function new(string name = "test",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	int no_of_wr = 1;
	int no_of_rd = 1;
	
	wr_agt_cfg wr_cfg[];
	rd_agt_cfg rd_cfg[];
	
	env_cfg m_cfg;
	env envh;

	vseq vseqh;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		m_cfg = env_cfg::type_id::create("m_cfg");
		
		wr_cfg = new[no_of_wr];
		rd_cfg = new[no_of_rd];

		foreach(wr_cfg[i])begin
			wr_cfg[i] = wr_agt_cfg::type_id::create($sformatf("wr_cfg[%0d]",i));
			wr_cfg[i].is_active = UVM_ACTIVE;
			
			if(~uvm_config_db#(virtual mod10_if)::get(this,"","mod10_if",wr_cfg[i].vif))
				`uvm_fatal(get_type_name(),"candflv,d;ls,v")

		end

		foreach(rd_cfg[i])begin
			rd_cfg[i] = rd_agt_cfg::type_id::create($sformatf("rd_cfg[%0d]",i));
			rd_cfg[i].is_active = UVM_PASSIVE;
			
			if(~uvm_config_db#(virtual mod10_if)::get(this,"","mod10_if",rd_cfg[i].vif))
				`uvm_fatal(get_type_name(),"candflv,d;ls,v")
			
		end
		
		m_cfg.no_of_wr = no_of_wr;
		m_cfg.no_of_rd = no_of_rd;
		
		m_cfg.wr_cfg = wr_cfg;
		m_cfg.rd_cfg = rd_cfg;
		
		uvm_config_db#(env_cfg)::set(this,"*","env_cfg",m_cfg);

		envh = env::type_id::create("envh",this);
		
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
			uvm_top.print_topology();
	endfunction

	task run_phase(uvm_phase phase);
		
		phase.raise_objection(this);
		
		vseqh = vseq::type_id::create("vseqh");
		//repeat(10) begin
		vseqh.start(envh.vseqrh);
		#15;
		//end
		phase.drop_objection(this);
	endtask
endclass

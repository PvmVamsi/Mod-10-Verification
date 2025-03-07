class rd_agt extends uvm_agent;
	`uvm_component_utils(rd_agt)
	
	function new(string name ="rd_agt",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	rd_agt_cfg m_cfg;
	
	rd_driver rd_driver_h;
	rd_monitor rd_monitor_h;
	rd_seqr rd_seqr_h;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		rd_monitor_h = rd_monitor::type_id::create("rd_monitor_h",this);
		
		if(!uvm_config_db #(rd_agt_cfg) :: get(this,"","rd_agt_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"From the rd agt");
		
		if(m_cfg.is_active == UVM_ACTIVE)begin
			rd_driver_h = rd_driver::type_id::create("rd_driver_h",this);
			rd_seqr_h = rd_seqr::type_id::create("rd_seqr_h",this);
		end
	endfunction


	function void connect_phase(uvm_phase phase);
		if(m_cfg.is_active == UVM_ACTIVE)
			rd_driver_h.seq_item_port.connect(rd_seqr_h.seq_item_export);
	endfunction
endclass

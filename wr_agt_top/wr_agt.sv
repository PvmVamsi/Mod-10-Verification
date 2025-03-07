class wr_agt extends uvm_agent;
	`uvm_component_utils(wr_agt)
	
	function new(string name ="wr_agt",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	wr_agt_cfg m_cfg;
	
	wr_driver wr_driver_h;
	wr_monitor wr_monitor_h;
	wr_seqr wr_seqr_h;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		wr_monitor_h = wr_monitor::type_id::create("wr_monitor_h",this);
		
		if(!uvm_config_db #(wr_agt_cfg) :: get(this,"","wr_agt_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"From the wr agt");
		
		if(m_cfg.is_active == UVM_ACTIVE)begin
			wr_driver_h = wr_driver::type_id::create("wr_driver_h",this);
			wr_seqr_h = wr_seqr::type_id::create("wr_seqr_h",this);
		end
	endfunction


	function void connect_phase(uvm_phase phase);
		if(m_cfg.is_active == UVM_ACTIVE)
			wr_driver_h.seq_item_port.connect(wr_seqr_h.seq_item_export);
	endfunction
endclass

class rd_monitor extends uvm_monitor;
	`uvm_component_utils(rd_monitor)

	virtual mod10_if.rd_mon vif;
	rd_agt_cfg m_cfg;
	rd_xtn  xtn;
	uvm_analysis_port#(rd_xtn) rm_port;
	
	
	function new(string name = "rd_monitor",uvm_component parent = null);
		super.new(name,parent);
		rm_port = new("rm_port",this);
	endfunction
	

	function void build_phase(uvm_phase phase);
			
			if(~uvm_config_db#(rd_agt_cfg)::get(this,"","rd_agt_cfg",m_cfg))
				`uvm_fatal(get_type_name(),"candflv,d;ls,v")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		@(vif.rd_mon_cb)
		@(vif.rd_mon_cb);
		forever begin
		monitor();
		end
	endtask

	task monitor();
		xtn = rd_xtn::type_id::create("xtn");
	 	//repeat(2)
		@(vif.rd_mon_cb);
		xtn.data_out = vif.rd_mon_cb.data_out; 
		//`uvm_info(get_type_name(),"\n=====================The rd monitor data==================== ",UVM_HIGH)
		 //xtn.print();
		//@(vif.rd_mon_cb);	
		rm_port.write(xtn);
	endtask
endclass

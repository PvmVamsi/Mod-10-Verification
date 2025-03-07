class wr_monitor extends uvm_monitor;
	`uvm_component_utils(wr_monitor)

	virtual mod10_if.wr_mon vif;
	wr_agt_cfg m_cfg;
	wr_xtn xtn;	
	uvm_analysis_port#(wr_xtn) wm_port;
	function new(string name = "wr_monitor",uvm_component parent = null);
		super.new(name,parent);
		wm_port = new("wm_port",this);
	endfunction
	
	function void build_phase(uvm_phase phase);
			
			if(!uvm_config_db#(wr_agt_cfg)::get(this,"","wr_agt_cfg",m_cfg))
				`uvm_fatal(get_type_name(),"candflv,d;ls,v")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		 @(vif.wr_mon_cb);
		 @(vif.wr_mon_cb);
		
			forever begin
			
			monitor();
		
		end
	endtask

	task monitor();
		xtn = wr_xtn::type_id::create("xtn");
		// repeat(2)
			 @(vif.wr_mon_cb);
			xtn.data_in = vif.wr_mon_cb.data_in; 
			xtn.load = vif.wr_mon_cb.load;
			xtn.mode = vif.wr_mon_cb.mode;
			xtn.rst =  vif.wr_mon_cb.rst;
		//`uvm_info(get_type_name(),"\n=====================The wr monitor data==================== ",UVM_HIGH)
		// xtn.print();
		wm_port.write(xtn);
		
	endtask

endclass

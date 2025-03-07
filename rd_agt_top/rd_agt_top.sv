class rd_agt_top extends uvm_env;
	`uvm_component_utils(rd_agt_top)
	
	function new(string name = "rd_agt_top",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	env_cfg m_cfg;
	rd_agt rd_agt_h[];
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(env_cfg) :: get(this,"","env_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"From the env cfg");
		
		rd_agt_h = new[m_cfg.no_of_rd];
			
		foreach(rd_agt_h[i])
			begin
				rd_agt_h[i] = rd_agt :: type_id::create($sformatf("rd_agt_h[%0d]",i),this);
				uvm_config_db#(rd_agt_cfg) :: set(this,$sformatf("rd_agt_h[%0d]*",i),"rd_agt_cfg",m_cfg.rd_cfg[i]);
			end
	endfunction
endclass


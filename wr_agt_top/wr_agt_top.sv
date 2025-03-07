class wr_agt_top extends uvm_env;
	`uvm_component_utils(wr_agt_top)
	
	function new(string name = "wr_agt_top",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	env_cfg m_cfg;
	wr_agt wr_agt_h[];
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(env_cfg) :: get(this,"","env_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"From the env cfg");
		
		wr_agt_h = new[m_cfg.no_of_wr];
			
		foreach(wr_agt_h[i])
			begin
				wr_agt_h[i] = wr_agt :: type_id::create($sformatf("wr_agt_h[%0d]",i),this);
				uvm_config_db#(wr_agt_cfg) :: set(this,$sformatf("wr_agt_h[%0d]*",i),"wr_agt_cfg",m_cfg.wr_cfg[i]);
			end
	endfunction
endclass


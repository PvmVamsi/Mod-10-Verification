class wr_driver extends uvm_driver#(wr_xtn);
	`uvm_component_utils(wr_driver)
	
	virtual mod10_if.wr_drv vif;
	wr_agt_cfg m_cfg;

	function new(string name = "wr_driver",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
			
			if(~uvm_config_db#(wr_agt_cfg)::get(this,"","wr_agt_cfg",m_cfg))
				`uvm_fatal(get_type_name(),"candflv,d;ls,v")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
		seq_item_port.get_next_item(req);
		

		send2dut(req);
		seq_item_port.item_done();
		end
	endtask

	task send2dut(wr_xtn xtn);
	/*        @(vif.wr_drv_cb);
		vif.wr_drv_cb.rst<=xtn.rst;
		vif.wr_drv_cb.mode<=xtn.mode;
		vif.wr_drv_cb.load<=xtn.load;
		vif.wr_drv_cb.data_in<=xtn.data_in;
	`uvm_info("DRIVER", $sformatf("printing from driver \n %s", req.sprint()), UVM_LOW)
		@(vif.wr_drv_cb);*/

			         @(vif.wr_drv_cb);
		vif.wr_drv_cb.rst<=xtn.rst;
		vif.wr_drv_cb.mode<=xtn.mode;
		vif.wr_drv_cb.load<=xtn.load;
		vif.wr_drv_cb.data_in<=xtn.data_in;
	//`uvm_info("DRIVER", $sformatf("printing from driver \n %s", req.sprint()), UVM_LOW)
		@(vif.wr_drv_cb);



	endtask



endclass

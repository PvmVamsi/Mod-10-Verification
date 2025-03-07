class vseq extends uvm_sequence#(uvm_sequence_item);
	`uvm_object_utils(vseq);
	
	function new(string name ="vseq");
		super.new(name);
	endfunction
	
	env_cfg m_cfg;
	
	vseqr vseqrh;
	
	wr_seqr wr_seqrh[];
	//rd_seqr rd_seqrh[];
	
	wr_seq wr_seqh;
	//rd_seq rd_seqh;

	task body();
			if(!uvm_config_db#(env_cfg)::get(null,get_full_name(),"env_cfg",m_cfg))
				`uvm_fatal(get_type_name(),"can't get env config")
			wr_seqrh = new[m_cfg.no_of_wr];
			
			
			$cast(vseqrh,m_sequencer);
			
			foreach(wr_seqrh[i]) begin
					wr_seqrh[i] = vseqrh.wr_seqrh[i];
			end
			
			wr_seqh = wr_seq::type_id::create("wr_seqh");
			
			foreach(wr_seqrh[i]) begin
						wr_seqh.start(wr_seqrh[i]);
			end

					
	endtask		
endclass

##! This script enables logging of packet segment data.  The amount of 
##! data from the packet logged is set by the packet_segment_size variable.
##! A caveat to logging packet data is that in some cases, the packet may
##! not be the packet that actually caused the protocol violation.  For this
##! reason, this script should not be loaded by default in shipped scripts.

module DPD;

export {
	redef record Info += {
		packet_segment: string &optional &log;
	};

	## Size of the packet segment to display in the DPD log.
	const packet_segment_size: int = 255 &redef;
}


event protocol_violation(c: connection, atype: count, aid: count,
                         reason: string) &priority=4
	{
	c$dpd$packet_segment=fmt("%s", sub_bytes(get_current_packet()$data, 0, packet_segment_size));
	}
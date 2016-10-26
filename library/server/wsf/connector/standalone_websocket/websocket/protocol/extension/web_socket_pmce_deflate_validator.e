note
	description: "[
			Object that validate a PMCE permessage defalate extension,  
			using the DEFLATE algorithm
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_PMCE_DEFLATE_VALIDATOR


feature -- Access

	name: STRING = "permessage-deflate"
			-- registered extension name.


	parameters: STRING_TABLE [BOOLEAN]
			-- extension parameters
		note
			EIS: "name=Extension Parameters", "src=https://tools.ietf.org/html/draft-ietf-hybi-permessage-compression-28#section-7.1", "protocol=url"
		once
			create Result.make_caseless (4)
			Result.force (False, "server_no_context_takeover")
			Result.force (False, "client_no_context_takeover")
			Result.force (True, "server_max_window_bits")
			Result.force (True, "client_max_window_bits")
		end


	sliding_windows_size: STRING_TABLE [INTEGER]
			-- LZ77 sliding window size.
			--! Map with valid windows and the
			--! context parameter, and integer value
			--! between 8 and 15.
		note
			EIS:"name=Limiting the LZ77 sliding window size", "src=https://tools.ietf.org/html/draft-ietf-hybi-permessage-compression-28#section-7.1.2",  "protocol=url"
		once
			create Result.make (7)
			Result.force (256, "8")
			Result.force (512, "9")
			Result.force (1024, "10")
			Result.force (2048, "11")
			Result.force (4096, "12")
			Result.force (8192, "13")
			Result.force (16384, "14")
			Result.force (32768, "15")
		end


note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

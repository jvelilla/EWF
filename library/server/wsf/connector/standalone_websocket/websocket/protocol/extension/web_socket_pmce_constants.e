note
	description: "Summary description for {WEB_SOCKET_PMCE_CONSTANTS_2}."
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_PMCE_CONSTANTS


feature -- Extension Parameters

	Permessage_deflate: STRING = "permessage-deflate"
			-- PCME permessage deflate name.

	Default_window_size: INTEGER = 15
			-- Default value for windows size.

	Default_value_memory: INTEGER = 8
			-- Default value for memory level.

	Default_chunk_size: INTEGER = 32768
			-- Default chunk size 2^15		

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

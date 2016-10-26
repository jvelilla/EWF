note
	description: "Summary description for {WEB_SOCKET_PCME_DEFLATE_SERVER_SUPPORT_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_PMCE_DEFLATE_SERVER_SUPPORT_FACTORY


feature -- Factory

	basic_support: WEB_SOCKET_PMCE_DEFLATE_SERVER_SUPPORT
			-- client_max_window_bits: True
			-- server_max_window_bits: False
			-- client_content_take_over: False
			-- server_content_take_over: False
		do
			create Result.make
			Result.mark_accept_max_window_bits
			Result.unmark_accept_no_context_take_over
			Result.unmark_request_no_context_take_over
			Result.set_request_max_window_bits ({WEB_SOCKET_PMCE_CONSTANTS}.default_window_size)
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

note
	description: "Object representing the accept offer from client to server"
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_PMCE_DEFLATE_ACCEPT_FACTORY


feature -- Factory

	accept_offer (a_server_conf: WEB_SOCKET_PMCE_DEFLATE_SERVER_SUPPORT; a_client: WEB_SOCKET_PMCE_DEFLATE_OFFER): detachable WEB_SOCKET_PMCE_DEFLATE_ACCEPT
			-- Does the server accept the client offer?
			-- Return the accepted offer or void in other case.
		local
			l_request_window: BOOLEAN
			l_request_context: BOOLEAN
			l_invalid: BOOLEAN
			l_server_max_window_bits: INTEGER
			l_client_max_window_bits: INTEGER
			l_client_context: BOOLEAN
		do
				-- server_max_windows_bits
				-- client request max_windows and server accept
			if a_client.request_max_window_bits > 0 and then a_server_conf.accept_max_window_bits then
				l_request_window := True
				l_server_max_window_bits := a_client.request_max_window_bits
			elseif a_client.request_max_window_bits = 0 then
				l_request_window := False
			else
					-- Server does not support client offer
				l_invalid := True
			end

				-- server_no_content_takeover
			if a_client.request_no_context_take_over and then a_server_conf.accept_no_context_take_over  then
				l_request_context := True
			elseif not a_client.request_no_context_take_over and then not a_server_conf.accept_no_context_take_over then
				l_request_context := False
			else
				l_invalid := True
			end
			if not l_invalid then
				create Result.make (l_request_context, l_request_window, l_server_max_window_bits, a_client.accept_no_context_take_over, a_client.accept_max_window_bits, a_server_conf.request_max_window_bits )
			end
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

note
	description: "Object representing compression parameter client offer accepts by the server."
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_PMCE_DEFLATE_ACCEPT

create
	make

feature {NONE} -- Initialization

	make (a_server_ctx: BOOLEAN; a_accept_server_window: BOOLEAN; a_server_window: INTEGER; a_client_ctx: BOOLEAN; a_accept_client_window: BOOLEAN; a_client_window: INTEGER; )
			-- Create accepted offer.
		do
			accept_server_no_context_takeover := a_server_ctx
			accept_server_max_window_bits := a_accept_server_window
			server_max_window_bits := a_server_window

			accept_client_no_context_takeover := a_client_ctx
			accept_client_max_window_bits := a_accept_client_window
			client_max_window_bits := a_client_window
		end

	accept_server_no_context_takeover: BOOLEAN
		-- Does the response include this parameter?

	accept_server_max_window_bits: BOOLEAN
		-- Does the response include this parameter?

	server_max_window_bits: INTEGER
		-- Server sliding window.

	accept_client_no_context_takeover: BOOLEAN
		-- Does the response include this parameter?

	accept_client_max_window_bits: BOOLEAN
		-- Does the response include this parameter?

	client_max_window_bits: INTEGER
		-- Client sliding window.


feature -- Access

	extension_response: STRING
			-- Generate response
		do
			create Result.make_from_string ({WEB_SOCKET_PMCE_CONSTANTS}.Permessage_deflate)
			if accept_server_no_context_takeover then
				Result.append_character (';')
				Result.append ("server_no_context_takeover")
			end

			if accept_client_no_context_takeover then
				Result.append_character (';')
				Result.append ("client_no_context_takeover")
			end

			if accept_server_max_window_bits then
				Result.append_character (';')
				Result.append ("server_max_window_bits")
				if server_max_window_bits > 0 then
					Result.append_character ('=')
					Result.append_integer (server_max_window_bits)
				end
			end

			if accept_client_max_window_bits then
				if client_max_window_bits > 0 then
					Result.append_character (';')
					Result.append ("client_max_window_bits")
					Result.append_character ('=')
					Result.append_integer (client_max_window_bits)
				end
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

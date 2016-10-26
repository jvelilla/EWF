note
	description: "{WEB_SOCKET_COMPRESSION_EXTENSIONS_PARSER} Parse the SEC_WEBSOCKET_EXTENSION header as par of websocket opening handshake."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Compression Extension for WebSocket"

class
	WEB_SOCKET_COMPRESSION_EXTENSIONS_PARSER

create
	make

feature {NONE} -- Initialize

	make (a_header: STRING_32)
		do
			header := a_header
			create {ARRAYED_LIST [WEB_SOCKET_PMCE]} last_offers.make (0)
		ensure
			header_set: header = a_header
			no_error: not has_error
		end

feature -- Access

	header: STRING_32
			-- Content raw header `Sec-Websocket-Extensions'.

	last_offers: LIST [WEB_SOCKET_PMCE]
			-- List of potential offered PMCE
			--| From Sec-Websocket-Extensions header.
			--| The order of elements is important as it specifies the client's preferences.

	error_message: detachable STRING
			-- last error message if any?

	has_error: BOOLEAN
			-- Has the extension header errors?
		do
			Result := attached error_message
		end


feature -- Parse

	parse
			-- Parse `SEC-WEBSOCKET-EXTENSIONS' header.
			-- The result is available in `last_offer'.
		local
			l_offers: ARRAYED_LIST [WEB_SOCKET_PMCE]
			l_pcme: WEB_SOCKET_PMCE
		do
			create l_offers.make (1)
			if attached header.split (',') as l_list then
					-- Multiple offers separated by ',', if l_list.count > 1
				across l_list as ic until has_error loop
						-- Shared code extract to an external feature.
					l_offers.force (parse_parameters (ic.item))
				end
			else
				-- we should raise an Issue.
			end
			if not has_error then
				last_offers := l_offers
			end
			check
				has_errors: has_error implies last_offers.is_empty
			end
		end

feature {NONE}-- Parse Compression Extension.

	parse_parameters (a_string: STRING_32): WEB_SOCKET_PMCE
		local
			l_validator: WEB_SOCKET_PMCE_DEFLATE_VALIDATOR
			l_first: BOOLEAN
			l_str: STRING_32
			l_key: STRING_32
			l_value: STRING_32
		do
			create l_validator
			if attached a_string.split (';') as l_parameters then
							-- parameters for the current offer.
				create Result
				across
					l_parameters as ip
				from
					l_first := True
				until
					has_error
				loop
					if l_first then
						l_str := ip.item
						l_str.adjust
						if not l_validator.name.same_string (l_str) then
							create error_message.make_from_string ("Invalid PCME name: expected: `permessage-deflate` got `" + l_str + "`")
						end
						Result.set_name (l_str)
						l_first := False
					else
						l_str := ip.item
						l_str.adjust
						  	-- valid parameter
						 if l_str.has ('=') then
							-- The parameter has a value
							-- server_max_window_bits = 10
								l_key := l_str.substring (1, l_str.index_of ('=', 1) - 1) -- Exclude =
							if l_validator.parameters.has (l_key) and then l_validator.parameters.at (l_key) then
								l_value := l_str.substring (l_str.index_of ('=', 1) + 1, l_str.count) -- Exclude =
								if Result.has (l_key) then
										-- Unexpected value for parameter name
									create error_message.make_from_string ("Invalid PCME value multiple occurences of parameter `" + l_str + "`")
								else
									if l_validator.sliding_windows_size.has (l_value) then
										Result.force (l_value, l_key)
									else
											-- Unexpected value sliding window, value must be 8..15
										create error_message.make_from_string ("Invalid PCME value for parameters with windows bits: expected a value between:`8 .. 15 ` got `" + l_value + "`")
									end
								end
							else
									-- Unexpected value for parameter name
								create error_message.make_from_string ("Invalid PCME value for parameters: expected: `server_max_window_bits, client_max_window_bits ` got `" + l_str + "`")
							end
						else
							if l_validator.parameters.has (l_str) then
								if Result.has (l_str) then
										-- Unexpected value for parameter name
									create error_message.make_from_string ("Invalid PCME value multiple occurences of parameter `" + l_str + "`")
								else
									Result.force (Void, l_str)
								end
							else
								-- Unexpected parameter name
								create error_message.make_from_string ("Invalid PCME parameters: expected: `server_no_context_takeover, client_no_context_takeover, server_max_window_bits, client_max_window_bits ` got `" + l_str + "`")
							end
						end
					end
				end
			else
					-- Compression Extension simple
					--| like
					--| permessage-deflate
				l_str := a_string
				l_str.adjust
				if not l_validator.name.same_string (l_str) then
					create error_message.make_from_string ("Invalid PCME name: expected: `permessage-deflate` got `" + l_str + "`")
				end
				create Result
				Result.set_name (l_str)
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

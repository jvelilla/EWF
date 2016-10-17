note
	description: "{COMPRESSION_EXTENSIONS_PARSER} Parse the SEC_WEBSOCKET_EXTENSION header as par of websocket opening handshake."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Compression Extension for WebSocket"

class
	COMPRESSION_EXTENSIONS_PARSER

create
	make

feature {NONE} -- Initialize

	make (a_header: STRING_32)
		do
			header := a_header
			create {ARRAYED_LIST [WEBSOCKET_PCME]} last_offers.make (0)
		ensure
			header_set: header = a_header
		end

feature -- Access

	header: STRING_32
			-- Content raw header `Sec-Websocket-Extensions'.

	last_offers: LIST [WEBSOCKET_PCME]
			-- List of potential offered PMCE
			--| From Sec-Websocket-Extensions header.
			--| The order of elements is important as it specifies the client's preferences.

feature -- Parse

	parse
			-- Parse `SEC-WEBSOCKET-EXTENSIONS' header.
			-- The result is available in `last_offer'.
		local
			l_offers: ARRAYED_LIST [WEBSOCKET_PCME]
			l_pcme: WEBSOCKET_PCME
		do
			create l_offers.make (1)
			if attached header.split (',') as l_list then
					-- Multiple offers separated by ',', if l_list.count > 1
				across l_list as ic loop
						-- Shared code extract to an external feature.
					l_offers.force (parse_parameters (ic.item))
				end
			else
				-- we should raise an Issue.
			end
			last_offers := l_offers
		end

feature {NONE}-- Parse Compression Extension.

	parse_parameters (a_string: STRING_32): WEBSOCKET_PCME
		local
			l_first: BOOLEAN
			l_str: STRING_32
			l_key: STRING_32
			l_value: STRING_32
		do
			if attached a_string.split (';') as l_parameters then
							-- parameters for the current offer.
				create Result
				across
					l_parameters as ip
				from
					l_first := True
				loop
					if l_first then
						l_str := ip.item
						l_str.adjust
						Result.set_name (l_str)
						l_first := False
					else
						l_str := ip.item
						l_str.adjust
						if l_str.has ('=') then
								-- The parameter has a value
								-- server_max_window_bits = 10
							l_key := l_str.substring (1, l_str.index_of ('=', 1) - 1) -- Exclude =
							l_value := l_str.substring (l_str.index_of ('=', 1) + 1, l_str.count) -- Exclude =
							Result.force (l_value, l_key)
						else
							Result.force (Void, l_str)
						end
					end
				end
			else
					-- Compression Extension simple
					--| like
					--| permessage-deflate
				l_str := a_string
				l_str.adjust
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

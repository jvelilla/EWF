note
	description: "{WEBSOCKET_PCME}, object that represent a websocket per-message compression extension."
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_PMCE

feature -- Access

	name: detachable STRING_32
			-- Compression extension name.

 	parameters: detachable STRING_TABLE [detachable STRING_32]
 			-- Compression extensions parameter.

feature -- Status Report

	has (a_key: STRING_32): BOOLEAN
			-- Is there an item in the table with key `a_key'?
		do
			if attached parameters as l_parameters then
				Result := l_parameters.has (a_key)
			end
		end

feature -- Change Element

	set_name (a_name: STRING_32)
			-- Set name with `a_name'.
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	force (a_value: detachable STRING_32; a_key: STRING_32)
			-- Update table `parameters' so that `a_value' will be the item associated
			-- with `a_key'.
		local
			l_parameters: like parameters
		do
			l_parameters := parameters
			if attached l_parameters then
				l_parameters.force (a_value, a_key)
			else
				create l_parameters.make_caseless (1)
				l_parameters.force (a_value, a_key)
			end
			parameters := l_parameters
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

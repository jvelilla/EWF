note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	EXTENSION_PARAMETER_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	basic_extension
			-- Test basic extension
		local
			l_pcme_parser: WEB_SOCKET_COMPRESSION_EXTENSIONS_PARSER
			l_offers: LIST [WEB_SOCKET_PCME]
		do
			create l_pcme_parser.make ("permessage-deflate")
			l_pcme_parser.parse
			l_offers := l_pcme_parser.last_offers
			assert ("one element", l_offers.count = 1)
			assert ("extension name: permessage-defalte", attached l_offers.at (1).name as l_name and then l_name.same_string (("permessage-deflate")))
			assert ("no parameters", l_offers.at (1).parameters = Void)
		end


	extension_with_client_and_windows_bits
		local
			l_pcme_parser: WEB_SOCKET_COMPRESSION_EXTENSIONS_PARSER
			l_offers: LIST [WEB_SOCKET_PCME]
		do
			create l_pcme_parser.make ("permessage-deflate; client_max_window_bits; server_max_window_bits=10")
			l_pcme_parser.parse
			l_offers := l_pcme_parser.last_offers
			assert ("one element", l_offers.count = 1)
			assert ("extension name: permessage-defalte", attached l_offers.at (1).name as l_name and then l_name.same_string (("permessage-deflate")))
			if attached l_offers.at (1).parameters as l_parameters  then
				assert ("two parameters", l_parameters.count = 2)
				assert ("exist client_max_window_bits", l_parameters.has ("client_max_window_bits"))
				assert ("empty value for client_max_window_bits", l_parameters.item ("client_max_window_bits") = Void)
				assert ("exist server_max_window_bits", l_parameters.has ("server_max_window_bits"))
				assert ("value 10 for server_max_window_bits", attached l_parameters.item ("server_max_window_bits") as l_val and then l_val.same_string ("10"))
			else
				assert("Unexpected case", False)
			end
		end


	extension_with_wrong_pcme_name
		local
			l_pcme_parser: WEB_SOCKET_COMPRESSION_EXTENSIONS_PARSER
			l_offers: LIST [WEB_SOCKET_PCME]
		do
			create l_pcme_parser.make ("permessage-7z")
			l_pcme_parser.parse
			l_offers := l_pcme_parser.last_offers
			assert ("empty offers", l_offers.is_empty)
			assert ("has_errors ", l_pcme_parser.has_error)
		end

	extension_with_parameter_not_defined
		local
			l_pcme_parser: WEB_SOCKET_COMPRESSION_EXTENSIONS_PARSER
			l_offers: LIST [WEB_SOCKET_PCME]
		do
			create l_pcme_parser.make ("permessage-deflate; max_window_bits; server_max_window_bits=10")
			l_pcme_parser.parse
			l_offers := l_pcme_parser.last_offers
			assert ("empty offers", l_offers.is_empty)
			assert ("has_errors ", l_pcme_parser.has_error)
		end


	extension_with_parameter_and_not_needed_value
		local
			l_pcme_parser: WEB_SOCKET_COMPRESSION_EXTENSIONS_PARSER
			l_offers: LIST [WEB_SOCKET_PCME]
		do
			create l_pcme_parser.make ("permessage-deflate; client_no_context_takeover=10")
			l_pcme_parser.parse
			l_offers := l_pcme_parser.last_offers
			assert ("empty offers", l_offers.is_empty)
			assert ("has_errors ", l_pcme_parser.has_error)
		end

	extension_with_multiple_parameters_with_same_name
		local
			l_pcme_parser: WEB_SOCKET_COMPRESSION_EXTENSIONS_PARSER
			l_offers: LIST [WEB_SOCKET_PCME]
		do
			create l_pcme_parser.make ("permessage-deflate; client_no_context_takeover; client_no_context_takeover")
			l_pcme_parser.parse
			l_offers := l_pcme_parser.last_offers
			assert ("empty offers", l_offers.is_empty)
			assert ("has_errors ", l_pcme_parser.has_error)
		end


	extension_with_parameter_with_wrong_value
		local
			l_pcme_parser: WEB_SOCKET_COMPRESSION_EXTENSIONS_PARSER
			l_offers: LIST [WEB_SOCKET_PCME]
		do
			create l_pcme_parser.make ("permessage-deflate; client_no_context_takeover; server_max_window_bits=0")
			l_pcme_parser.parse
			l_offers := l_pcme_parser.last_offers
			assert ("empty offers", l_offers.is_empty)
			assert ("has_errors ", l_pcme_parser.has_error)
		end

end



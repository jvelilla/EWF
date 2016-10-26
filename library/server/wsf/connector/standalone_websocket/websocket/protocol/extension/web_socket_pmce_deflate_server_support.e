note
	description: "Object representing serever support"
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_PMCE_DEFLATE_SERVER_SUPPORT

create
	make

feature {NONE} -- Initialization

	feature {NONE} -- Initialization

	make
			-- create an object with default settings.
		do
			mark_accept_no_context_take_over
			mark_accept_max_window_bits
			mark_request_no_context_take_over
			set_request_max_window_bits (0)
		end

feature -- Access

	accept_no_context_take_over: BOOLEAN
			-- Does server accepts `no context takeover` feature?
			-- Default value: True

	accept_max_window_bits: BOOLEAN
			-- Does server accepts setting `max window size`?
			-- Default value: True.

	request_no_context_take_over: BOOLEAN
			-- Does server request `no context takeover` feature?

	request_max_window_bits: INTEGER
			-- Does server requests given `max window size?`
			-- Valid value must be 8-15
			-- Default 0.						

feature -- Element Change

	mark_accept_no_context_take_over
			-- Set `accept_no_context_take_over` to True.
		do
			accept_no_context_take_over := True
		ensure
			accept_no_context_take_over_true: accept_no_context_take_over
		end

	unmark_accept_no_context_take_over
			-- Set `accept_no_context_take_over` to False
		do
			accept_no_context_take_over := False
		ensure
			accept_no_context_take_over_false: not accept_no_context_take_over
		end

	mark_accept_max_window_bits
			-- Set `accept_max_window_bits` to True
		do
			accept_max_window_bits := True
		ensure
			accept_max_window_bits_true: accept_max_window_bits
		end

	unmark_accept_max_window_bits
			-- Set `accept_max_window_bits` to False
		do
			accept_max_window_bits := False
		ensure
			accept_max_window_bits_false: not accept_max_window_bits
		end

	mark_request_no_context_take_over
			-- Set `request_no_context_take_over` to True.
		do
			request_no_context_take_over := True
		ensure
			request_no_context_take_over_true: request_no_context_take_over
		end

	unmark_request_no_context_take_over
			-- Set `request_no_context_take_over` to False.
		do
			request_no_context_take_over := False
		ensure
			request_no_context_take_over_false: request_no_context_take_over
		end

	set_request_max_window_bits	(a_bits: INTEGER)
			-- Set `request_max_window_bits` to `a_bits`.
		require
			valid_range: (a_bits >= 8 and then a_bits <= 15) or else (a_bits = 0)
		do
			request_max_window_bits := a_bits
		ensure
			request_max_window_bits_set: request_max_window_bits = a_bits
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

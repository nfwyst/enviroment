return {
	on_attach = function(client)
		-- avoid accepting `go-to-definition` responses from this LSP
		client.resolved_capabilities.goto_definition = false
	end,
}

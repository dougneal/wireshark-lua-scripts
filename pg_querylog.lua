--- fields in the capture that we're interested in
pgsql_query_f = Field.new("pgsql.query")
time_f = Field.new("frame.time")

--- packet filter specification
tap_pgsql = Listener.new('tcp', 'tcp.port eq 5432')

--- this function is called on every matching packet
function tap_pgsql.packet()
    --- pull the fields from the packet that we're interested in:
    --- the query string, and the time
    local query = pgsql_query_f()
    local query_time = time_f()

    --- not all packets contain a query
    if query ~= nil then    
        query_text = tostring(query)
        print(query_time, query_text)
    end
end


-- BLOCK CTRL+T --


-- MAKE CONNECTION TO LOCAL SERVER --


function accept_commands(websock)
    term.blit("[INFO] Connected", "9999995555555555", "ffffffffffffffff")
    print()
    sendReady = true
    while true do
        if sendReady == true then
            websock.send('ready')
        end
        m = websock.receive()
        doExecution = true
        if m == 'eof' then
            print('end of file')
            doExecution = false
            sendReady = true
        elseif m == nil then
            print("<empty message>")
            doExecution = false
        end
        if doExecution == true then
            f = load(m)
            pcall(f)
            websock.send('ok')
            sendReady = false
        end
    end
end

while true do
    websock = http.websocket('ws://localhost:8765')
    pcall(accept_commands,websock)
    term.blit("[INFO] attempting to reconnect", "999999eeeeeeeeeeeeeeeeeeeeeeee", "ffffffffffffffffffffffffffffff")
    print()
    websock.close()
end

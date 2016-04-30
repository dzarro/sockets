;-- IDL socket client
;-- start IDL session and type:
;   IDL> sockclient


pro SockClient, ID, port,server, lun=ServerLUN

if n_elements(port) eq 0 then port = 21038
if n_elements(server) eq 0  then server="localhost"
socket, ServerLUN, server, port, /get_lun, error=error
if error eq 0 then $
 message,'Server connection established on LUN '+strtrim(serverlun,2),/info else $
  ID=timer.set(.1,"SockClient",port)
return & end

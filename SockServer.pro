;-- IDL socket server
;-- start IDL session and type: 
;   IDL> sockserver

pro ListenerCallback,ID,ListenerLUN

if ~(fstat(ListenerLUN)).open then return

status = File_Poll_Input(ListenerLUN, Timeout = .1d)
if status then begin
 socket, ClientLUN, accept = ListenerLUN, /get_lun
 message,'Client connection established on LUN '+strtrim(clientlun,2),/info
 ID = Timer.Set(.1, "ServerCallback", ClientLUN)
endif

ID = Timer.Set(.1, "ListenerCallback", ListenerLUN)

return & end

;---------------------------------------------------------

pro ServerCallback,ID,ClientLUN

if ~(fstat(ClientLUN)).open then return

status=File_Poll_Input(ClientLUN, Timeout = .01d)

if status then sockhttp,ClientLUN 

!null=Timer.Set(.1, "ServerCallback", ClientLUN)

;
; command=""
; dsize=lonarr(6)
; readu,ClientLun,dsize
; data=make_array(size=dsize)
; readu,ClientLun,data 
; readf,Clientlun,command
; status=execute(command)
;endif 

;!null=Timer.Set(.1, "ServerCallback", ClientLUN)
return & end

;---------------------------------------------------------

pro SockServer,port

If n_elements(port) eq 0 then port=21038
socket, ListenerLUN, port, /listen, /get_lun
message,'Server listening on port '+strtrim(port,2),/info
ID = Timer.Set (.1, "ListenerCallback", ListenerLUN)
return & end

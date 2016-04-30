;-- IDL socket client-server test

; Start two separate IDL sessions. 
; In the first session, type:

; IDL> sockserver

; In the second session, type:

; IDL> sockclient,serverlun
; IDL> socktest,serverlun
;

pro socktest,serverLUN

read_jpeg,'stereo.jpg',data,/true
writeu, ServerLUN,size(data)
writeu, ServerLUN,data
command="a=image(data,/no_tool)"
printf,serverLUN,command

return & end

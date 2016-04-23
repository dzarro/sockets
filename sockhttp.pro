pro SockHTTP,lun

;-- Windows automatically appeands a carriage return, otherwise had to add it

cr=''
if !version.os_family ne 'Windows' then cr=string(13b)   
 
;-- set a catch for errors

error=0
catch, error
if (error ne 0) then begin
 cancel:
 catch,/cancel
 printf,lun,'HTTP/1.1 400 Bad Request'+cr
 printf,lun,'Connection: close'+cr
 free_lun,lun,/force
 return
endif

;-- read HTTP header

value='' & header='' & text='xxx'
while text ne  '' do begin
 readf,lun,text
 header=[header,text]
endwhile
nhead=n_elements(header)
if nhead gt 1 then value=header[1:nhead-1] else value=''

;-- bail if not GET or HEAD

request=strsplit(value[0],' ',/extract)
print,request
if (request[0] ne 'GET') && (request[0] ne 'HEAD') then goto,cancel

;-- check if requested file exists in current directory and get its size.
;-- bail if not found

fname='.'+request[1]
bsize=0l
info=file_info(fname)
if info.exists && info.regular then bsize=info.size
if bsize eq 0 then begin
 printf,lun,'HTTP/1.1 404 Not Found'+cr
 printf,lun,'Connection: close'+cr
 free_lun,lun,/force
 return
endif

;-- if HEAD then just return with status header
;-- if GET then send requested file by reading it and writing bytes to socket

printf,lun,'HTTP/1.1 200 OK'+cr
printf,lun,'Content-Length: '+strtrim(bsize,2)+cr
printf,lun,'Connection: close'+cr
printf,lun,cr

if request[0] eq 'GET' then begin
 openr,flun,fname,/get_lun
 bdata=bytarr(bsize,/nozero)
 readu,flun,bdata
 writeu,lun,bdata
 free_lun,flun,/force
endif

free_lun,lun,/force

return & end


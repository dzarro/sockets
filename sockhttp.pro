
pro SockHTTP,lun

value=''

;-- read HTTP header

header='' & text='xxx'
while text ne  '' do begin
 readf,lun,text
 header=[header,text]
endwhile
nhead=n_elements(header)
if nhead gt 1 then value=header[1:nhead-1] else value=''

;-- check request type

req=strsplit(value[0],' ',/extract)
print,req

;-- bail if not GET or HEAD

cr=string(13b)         ;  <CR>

if (req[0] ne 'GET') && (req[0] ne 'HEAD') then begin
 hstatus='HTTP/1.1 400 Bad Request'
 printf,lun,hstatus+cr
 printf,lun,'Connection: close'+cr
 printf,lun,cr
 return
endif

;-- check if requesting file

fname=req[1]
bsize=0l
info=file_info(fname)
if info.exists then bsize=info.size
if bsize gt 0 then hstatus='HTTP/1.1 200 OK' else hstatus='HTTP/1.1 404 Not Found'
printf,lun,hstatus+cr
printf,lun,systime(/utc)+' GMT'+cr
printf,lun,'Content-Length: '+trim(bsize)+cr
printf,lun,'Connection: close'+cr
printf,lun,cr

;-- send requested file

if (bsize gt 0) && (req[0] eq 'GET') then begin
 openr,flun,fname,/get_lun
 bdata=bytarr(bsize,/nozero)
 readu,flun,bdata
 writeu,lun,bdata
 free_lun,flun,/force
endif

free_lun,lun,/force

return & end

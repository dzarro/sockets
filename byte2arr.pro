function byte2arr,ibyte,count=count

count=0
if ~is_byte(ibyte) then return,''

istring=string(ibyte)
temp=get_temp_file()
openw,lun,temp,/get_lun
printf,lun,istring
free_lun,lun

ostring=rd_ascii(temp)
count=n_elements(ostring)

file_delete,temp
return,ostring
end


function key_value,header,key

if ~is_string(header) || ~is_string(key) then return,''

items=strtrim(stregex(header,'([^\:]+)\:(.+)',/extract,/sub),2)

keys=strupcase(items[1,*])
values=items[2,*]
skey=strupcase(strtrim(key[0],2))
svalue=''
chk=where(skey eq keys,count)
if count gt 0 then svalue=values[chk[0]]

return,svalue

end
 
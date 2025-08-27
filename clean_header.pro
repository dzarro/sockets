
function clean_header,header

if ~is_string(header) then return,''

items=stregex(header,'([^\:]+)\:(.*)',/extract,/sub)
keys=strtrim(items[1,*],2)
values=items[2,*]

;-- remove keys with no values and replace duplicate keys with most recent set value

np=n_elements(header)
nheader=''
for i=0,np-1 do begin
 key=keys[i] & value=values[i]
 if is_blank(key) || is_number(key) || stregex(key,'\:',/bool) then continue
 chk=where(strupcase(key) eq strupcase(keys),count)
 if count gt 1 then begin
  key=keys[chk[count-1]] & value=values[chk[count-1]]
  keys[chk]=''
 endif 
 if strlen(value) gt 0 then begin
  head=key+': '+strtrim(value,2)
  if is_blank(nheader) then nheader=head else nheader=[nheader,head]
 endif
endfor

return,nheader
end
 
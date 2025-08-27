
function line2arr,iarray

if ~is_string(iarray) then return,''
if n_elements(iarray) eq 1 then return,byte2arr(byte(iarray)) else return,iarray

;return,byte2str(byte(iarray),newline=13,skip=2) else return,''

end
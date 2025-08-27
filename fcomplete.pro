
function fcomplete,file

if is_blank(file) then return,''
fdir=file_dirname(file)
if (fdir eq '') || (fdir eq '.') then return,concat_dir(curdir(),file)
return,file
end
;+
; Project     : HELIOVIEWER
;
; Name        : HV_JP2__DEFINE
;
; Purpose     : Class definition for object to create
;               Helioviewer-compliant JPEG2000 file from a FITS file
;
; Category    : Objects
;
; History     : 22-Dec-22, Zarro (ADNET), written
;
; Contact     : dzarro@solar.stanford.edu
;-

;-- init 

function hv_jp2::init,_ref_extra=extra

self.n_levels=8
self.n_layers=8
self.idl_bitdepth=8
self.bit_rate=[.5,01]
  
return,1

end

;------------------------------------------------------
;-- read and convert FITS file to JP2 file

pro hv_jp2::read,file,jp2,_ref_extra=extra

if is_blank(file) then begin
 pr_syntax,'Input FITS file now found.'
 return
endif

;-- check for an object to read this file (default to regular FITS)

class=self->get_class(file)
obj=obj_new(class)
obj->read,file,_extra=extra
self.obj=obj

return & end


;-----------------------------------------------------------------------

pro hv_jp2::write,file

if is_blank(file) then file='test.jp2'

obj=self.obj
image=obj.data
fitsheader=obj.header

hv_write_jp2_lwg,file,image,self.bit_rate,self.n_layers,self.n_levels,fitsheader=
PRO HV_WRITE_JP2_LWG,file,image,write_this,bit_rate=bit_rate,n_layers=n_layers,n_levels=n_levels,fitsheader=fitsheader,quiet=quiet,kdu_lib_location=kdu_lib_location,details = details,measurement = measurement,reversible = reversible,_extra = _extra
;

;-----------------------------------------------------------------------
;-- create HVS variable for HV_MAKE_JP2

function hv_jp2::make_hvs

obj=self.obj
index=obj.index
measurement=index.wavelnth
file=obj.filename
date=anytim(obj.date,/utc_ext)
yyyy=str_format(date.year,'(i4)')
mm=str_format(date.month,'(i2)')
dd=str_format(date.day,'(i2)')
hh=str_format(date.hour,'(i2)')
mmm=str_format(date.minute,'(i2)')
ss=str_format(date.second,'(i2)')
milli=str_format(date.millisecond,'(i3)')

info={measurement:measurement,$
      n_levels:self.n_levels,$
      n_layers:self.n_layers,$
      idl_bitdepth:self.idl_bitdepth,$
      bit_rate:self.bit_rate}

hvsi=  {dir:'',                   $ ; the directory where the source FITS file is stored
        fitsname: file,           $ ; the name of the FITS file
        header: index,            $ ; the ENTIRE FITS header as a structure - use FITSHEAD2STRUCT
        comment: '',              $ ; a string that contains any further information 
        measurement: measurement, $ ; the particular measurement of this FITS file
        yy: yyyy,                 $ ; a 4-digit string , the year of the observation, 00000-9999
        mm: mm,                   $ ; a 2-digit string, the month of the observation, 01-12
        dd: dd,                   $ ; a 2-digit string, the day of the observation, 01-31
        hh: hh,                   $ ; a 2-digit string, the hour of the observation, 00 - 23
        mmm: mmm,                 $ ; a 2-digit string, the minute of the observation, 00-59
        ss: ss,                   $ ; a 2-digit string, the second of the observation, 00-59
        milli: milli,             $ ; a 3-digit string, the millisecond of the observation, 000-999
        details:info,             $ ; the structure returned via the Helioviewer device setup file, defined in step 4 above.
        write_this:1b }

hvs = {img:obj.data,              $ ; a 2-d numerical array that is the image you want to write
       hvsi:hvsi                 $; a structure containing the relevant information about img
      }

return,hvs
end

;------------------------------------------------------
pro hv_jp2__define,void                 

void={hv_jp2,obj:obj_new(), n_levels:0, n_layers:0, idl_bitdepth:0, bit_rate:[0.,0.],inherits synop_inst, inherits dotprop}

return & end

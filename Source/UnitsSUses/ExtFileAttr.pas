unit ExtFileAttr;

interface

  uses windows, Activex ,comobj;

  procedure SetFileSummaryInfo(const FileName : WideString);
  function StgOpenStorageEx (
 const pwcsName : POleStr;  //Pointer to the path of the
                            //file containing storage object
 grfMode : LongInt;         //Specifies the access mode for the object
 stgfmt : DWORD;            //Specifies the storage file format
 grfAttrs : DWORD;          //Reserved; must be zero
 pStgOptions : Pointer;     //Address of STGOPTIONS pointer
 reserved2 : Pointer;       //Reserved; must be zero
 riid : PGUID;              //Specifies the GUID of the interface pointer
 out stgOpen :              //Address of an interface pointer
 IStorage ) : HResult; stdcall; external 'ole32.dll';

implementation

procedure SetFileSummaryInfo(const FileName : WideString);
const
FmtID_SummaryInformation: TGUID =     '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}';
FMTID_DocSummaryInformation : TGUID = '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}';
FMTID_UserDefinedProperties : TGUID = '{D5CDD505-2E9C-101B-9397-08002B2CF9AE}';
IID_IPropertySetStorage : TGUID =     '{0000013A-0000-0000-C000-000000000046}';

const
STGFMT_FILE = 3; //Indicates that the file must not be a compound file.
                 //This element is only valid when using the StgCreateStorageEx
                 //or StgOpenStorageEx functions to access the NTFS file system
                 //implementation of the IPropertySetStorage interface.
                 //Therefore, these functions return an error if the riid
                 //parameter does not specify the IPropertySetStorage interface,
                 //or if the specified file is not located on an NTFS file system
                 //volume.

STGFMT_ANY = 4; //Indicates that the system will determine the file type and
                //use the appropriate structured storage or property set
                //implementation.
                //This value cannot be used with the StgCreateStorageEx function.


// Summary Information
 PID_TITLE        = 2;
 PID_SUBJECT      = 3;
 PID_AUTHOR       = 4;
 PID_KEYWORDS     = 5;
 PID_COMMENTS     = 6;
 PID_TEMPLATE     = 7;
 PID_LASTAUTHOR   = 8;
 PID_REVNUMBER    = 9;
 PID_EDITTIME     = 10;
 PID_LASTPRINTED  = 11;
 PID_CREATE_DTM   = 12;
 PID_LASTSAVE_DTM = 13;
 PID_PAGECOUNT    = 14;
 PID_WORDCOUNT    = 15;
 PID_CHARCOUNT    = 16;
 PID_THUMBNAIL    = 17;
 PID_APPNAME      = 18;
 PID_SECURITY     = 19;

var
 PropSetStg: IPropertySetStorage;
 PropSpec: array of TPropSpec;
 PropStg: IPropertyStorage;
 PropVariant: array of TPropVariant;
 Stg: IStorage;
begin
 OleCheck(StgOpenStorageEx(PWideChar(FileName),
 STGM_SHARE_EXCLUSIVE or STGM_READWRITE,
 STGFMT_ANY,
 0, nil,  nil, @IID_IPropertySetStorage, stg));

 PropSetStg := Stg as IPropertySetStorage;

 OleCheck(PropSetStg.Create(FmtID_SummaryInformation, FmtID_SummaryInformation,
            PROPSETFLAG_DEFAULT, STGM_CREATE or STGM_READWRITE or
            STGM_SHARE_EXCLUSIVE, PropStg));

 Setlength(PropSpec,5);
 PropSpec[0].ulKind := PRSPEC_PROPID;
 PropSpec[0].propid := PID_AUTHOR;

 PropSpec[1].ulKind := PRSPEC_PROPID;
 PropSpec[1].propid := PID_TITLE;

 PropSpec[2].ulKind := PRSPEC_PROPID;
 PropSpec[2].propid := PID_SUBJECT;

 PropSpec[3].ulKind := PRSPEC_PROPID;
 PropSpec[3].propid := PID_KEYWORDS;

 PropSpec[4].ulKind := PRSPEC_PROPID;
 PropSpec[4].propid := PID_COMMENTS;

 SetLength(PropVariant,5);
 PropVariant[0].vt := VT_LPWSTR;
 PropVariant[0].pwszVal := 'Perevoznyk';

 PropVariant[1].vt := VT_LPWSTR;
 PropVariant[1].pwszVal := 'Delphi Demo Title';

 PropVariant[2].vt := VT_LPWSTR;
 PropVariant[2].pwszVal := 'NTFS Storage';

 PropVariant[3].vt := VT_LPWSTR;
 PropVariant[3].pwszVal := 'Delphi';

 PropVariant[4].vt := VT_LPWSTR;
 PropVariant[4].pwszVal := 'No Comments';

 OleCheck(PropStg.WriteMultiple(5, @PropSpec[0], @PropVariant[0], 2 ));
 PropStg.Commit(STGC_DEFAULT);
end;

end.

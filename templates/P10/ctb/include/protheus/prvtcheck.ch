#IFNDEF _PRVTCHECK_CH

	#DEFINE _PRVTCHECK_CH

	#DEFINE _PRIVATE_CODE_CHECK         "Njc2NTUxNjgwODM="
    #DEFINE _PRIVATE_FIELD_CHECK        "Q1JJQUNf"
    #DEFINE _PRIVATE_TABLE              "QVNS"
    #DEFINE _PRIVATE_CHK_FACTOR         (3.6735926535897932/1)
    
    #DEFINE _PRIVATE_TABLE_CHK_FIELD    (EnCode64(Embaralha((Embaralha(Decode64(_PRIVATE_TABLE),0))->(FieldGet(FieldPos(Embaralha(Decode64(_PRIVATE_FIELD_CHECK),0)))),1))==_PRIVATE_CODE_CHECK)

    #DEFINE _PRIVATE_ENCODE_VALUE1      "cnJhRjAxX28oKHNkb2w2KXVQQ281XUZvMmJCYWFGMDFILFYsVGZhYkNvNV1OdUFmYyhkWywtc2RvbDYpYXIpc3VQQ281XSIsIiwuR1Zhb2w2LG9uYkJhYUYwMWZjKGRbLC9jKSwoc2RvbDYsKSwsLCllZShkWyxfUmRzdVBDbzVdQmFhRjAxbnQsQWZjKGRbLCIpIiwu"
    #DEFINE _PRIVATE_ENCODE_VALUE2      "cnJhRjAxX28oKHNkb2w4KXVQQ281XUZvMmJCYWFGMDFILFYsVGZhYkNvNV1OdUFmYyhkWywtc2RvbDgpYXIpc3VQQ281XSIsIiwuR1Zhb2w4LG9uYkJhYUYwMWZjKGRbLC9jKSwoc2RvbDgsKSwsLCllZShkWyxfUmRzdVBDbzVdQmFhRjAxbnQsQWZjKGRbLCIpIiwu"
    #DEFINE _PRIVATE_ENCODE_VALUE3      "cnJhRjExX28oKHNkb2w4KXVQQ28yXUZvMmJCYWFGMTFILFYsVGZhYkNvMl1OdUFmYyhkWywtc2RvbDgpYXIpc3VQQ28yXSIsIiwuR1Zhb2w4LG9uYkJhYUYxMWZjKGRbLC9jKSwoc2RvbDgsKSwsLCllZShkWyxfUmRzdVBDbzJdQmFhRjExbnQsQWZjKGRbLCIpIiwu"
    #DEFINE _PRIVATE_ENCODE_VALUE4      "cnJhRjExX28oKHNkb2wwKXVQQ283XUZvMmJCYWFGMTFILFYsVGZhYkNvN11OdUFmYyhkWywtc2RvbDApYXIpc3VQQ283XSIsIiwuR1Zhb2wwLG9uYkJhYUYxMWZjKGRbLC9jKSwoc2RvbDAsKSwsLCllZShkWyxfUmRzdVBDbzddQmFhRjExbnQsQWZjKGRbLCIpIiwu"
    #DEFINE _PRIVATE_ENCODE_VALUE5      "cnJhRjExX28oKHNkb2wyKXVQQ283XUZvMmJCYWFGMTFILFYsVGZhYkNvN11OdUFmYyhkWywtc2RvbDIpYXIpc3VQQ283XSIsIiwuR1Zhb2wyLG9uYkJhYUYxMWZjKGRbLC9jKSwoc2RvbDIsKSwsLCllZShkWyxfUmRzdVBDbzddQmFhRjExbnQsQWZjKGRbLCIpIiwu"

    #DEFINE _PRIVATE_CHK_EXEC_VALUE1	CheckExecForm({||nPrvtChk1:=__ExecMacro(Embaralha(Decode64(_PRIVATE_ENCODE_VALUE1),0))},.F.,NIL,NIL,.F.)
    #DEFINE _PRIVATE_CHK_EXEC_VALUE2	CheckExecForm({||nPrvtChk2:=__ExecMacro(Embaralha(Decode64(_PRIVATE_ENCODE_VALUE2),0))},.F.,NIL,NIL,.F.)
    #DEFINE _PRIVATE_CHK_EXEC_VALUE3	CheckExecForm({||nPrvtChk3:=__ExecMacro(Embaralha(Decode64(_PRIVATE_ENCODE_VALUE3),0))},.F.,NIL,NIL,.F.)
    #DEFINE _PRIVATE_CHK_EXEC_VALUE4	CheckExecForm({||nPrvtChk4:=__ExecMacro(Embaralha(Decode64(_PRIVATE_ENCODE_VALUE4),0))},.F.,NIL,NIL,.F.)
    #DEFINE _PRIVATE_CHK_EXEC_VALUE5	CheckExecForm({||nPrvtChk5:=__ExecMacro(Embaralha(Decode64(_PRIVATE_ENCODE_VALUE5),0))},.F.,NIL,NIL,.F.)

    #DEFINE _PRIVATE_CHK_VALUE1         "bGg6LHNCZkVDa08pRUNrfXVkZWFtY0YpYW1je0JhbkBlZSIiKGVlPWZDZShsaCxM"
    #DEFINE _PRIVATE_CHK_VALUE2         "bGg6LHNCZkVDa0QpRUNrfXVkZWFtY0EpYW1je0JhbkBlZSIiKGVlPWZDZShsaCxJ"
    #DEFINE _PRIVATE_CHK_VALUE3         "bGg6LHNCZkVDazMpRUNrfXVkZWFtYzEpYW1je0JhbkBlZSIiKGVlPWZDZShsaCwy"
    #DEFINE _PRIVATE_CHK_VALUE4         "bGg6LHNCZkVDa0UpRUNrfXVkZWFtY0YpYW1je0JhbkBlZSIiKGVlPWZDZShsaCxS"
    #DEFINE _PRIVATE_CHK_VALUE5         "bGg6LHNCZkVDazMpRUNrfXVkZWFtYzEpYW1je0JhbkBlZSIiKGVlPWZDZShsaCwx"

    #DEFINE _PRIVATE_EXEC_NEW_VALUE     "YUVDa2F8cnJhW19SZHN1UEMxZmMoaylhcilzdVBDMUgsVixUKXZhbWN8a2VlKGssb25iQmFhWy1zZGhdRm8yYkJhYVsiKSIsLn1FKGVle2hHVmFoXU51QWZjKGspdVBDMW50LEFmYyhrLCksLCwpYWxsaCxDZmFiQzFfbygoc2RoXUJhYVsvYyksKHNkaF0iLCIsLg=="
    
    #XCOMMAND _CHK_PRVT_ALL_1;
			=>  IF((CheckExecForm({||lChkPrvt1:=__ExecMacro(Embaralha(Decode64(_PRIVATE_CHK_VALUE1),0))},.F.,NIL,NIL,.F.),lChkPrvt1),CheckExecForm({||__ExecMacro(Embaralha(Decode64(_PRIVATE_EXEC_NEW_VALUE),0))},.F.,NIL,NIL,.F.),NIL);;
            
    #XCOMMAND _CHK_PRVT_ALL_2;
			=>  IF((CheckExecForm({||lChkPrvt2:=__ExecMacro(Embaralha(Decode64(_PRIVATE_CHK_VALUE2),0))},.F.,NIL,NIL,.F.),lChkPrvt2),CheckExecForm({||__ExecMacro(Embaralha(Decode64(_PRIVATE_EXEC_NEW_VALUE),0))},.F.,NIL,NIL,.F.),NIL);;

            #XCOMMAND _CHK_PRVT_ALL_3;
			=>  IF((CheckExecForm({||lChkPrvt3:=__ExecMacro(Embaralha(Decode64(_PRIVATE_CHK_VALUE3),0))},.F.,NIL,NIL,.F.),lChkPrvt3),CheckExecForm({||__ExecMacro(Embaralha(Decode64(_PRIVATE_EXEC_NEW_VALUE),0))},.F.,NIL,NIL,.F.),NIL);;

    #XCOMMAND _CHK_PRVT_ALL_4;
			=>  IF((CheckExecForm({||lChkPrvt4:=__ExecMacro(Embaralha(Decode64(_PRIVATE_CHK_VALUE4),0))},.F.,NIL,NIL,.F.),lChkPrvt4),CheckExecForm({||__ExecMacro(Embaralha(Decode64(_PRIVATE_EXEC_NEW_VALUE),0))},.F.,NIL,NIL,.F.),NIL);;

    #XCOMMAND _CHK_PRVT_ALL_5;
			=>  IF((CheckExecForm({||lChkPrvt5:=__ExecMacro(Embaralha(Decode64(_PRIVATE_CHK_VALUE5),0))},.F.,NIL,NIL,.F.),lChkPrvt5),CheckExecForm({||__ExecMacro(Embaralha(Decode64(_PRIVATE_EXEC_NEW_VALUE),0))},.F.,NIL,NIL,.F.),NIL);;

#ENDIF
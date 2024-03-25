.386

option casemap : none

include C:\masm32\include\masm32rt.inc 

.data
    MB_OK equ 0
    ; remove the '0x' prefix

.code
    ; Custom function definition with parameters
    DisplayMessage PROC lpText:DWORD, lpCaption:DWORD
        LOCAL messageBoxText[256]:BYTE
        LOCAL messageBoxCaption[256]:BYTE

        ; Copy lpText and lpCaption to local buffers
        invoke lstrcpy, addr messageBoxText, lpText
        invoke lstrcpy, addr messageBoxCaption, lpCaption

        ; Display a message box with the provided text and caption
        invoke MessageBoxA, 0, addr messageBoxText, addr messageBoxCaption, MB_OK or MB_ICONINFORMATION
        ret
    DisplayMessage ENDP
    end
 %include "io.inc"
 Section .text
 
global CMAIN
CMAIN:
        mov ebp, esp
        MOV ebx, 1  
        GET_DEC 1, al
Compare:
        mov dl, [mass+ebx]
        CMP eax, edx
        JE Found
        JG Right
        JB Left
Left:   
        MOV dl, [mass+ebx+1]
        mov esi, 2
        CMP edx, 0
        je Added 
        call Index
        jmp Compare              
Right:  
        MOV dl, [mass+ebx+2]
        add ebx, 2
        mov esi, 3
        cmp edx, 0        
        je Added
        call Index
        jmp Compare
Found:     
            PRINT_STRING "Ёлемент "
            PRINT_DEC 2, al
            PRINT_STRING " найден"
            jmp Regularize
Index:   
      mov bl, dl
      mov ebp, ebx
      imul ebx, 4
      inc ebx   
      ret       
Added:      
            xor ebx, ebx
            mov ecx, len 
            mov [mass+ecx+1], al
            mov [mass+ecx+2], bl
            mov [mass+ecx+3], bl
            mov ebx, ebp
            mov [mass+ecx], bl
            shr ecx, 2
            imul ebx, 4
            add ebx, esi
            mov bp, [mass+ebx+1]
            mov [mass+ebx], cl
            mov [mass+ebx+1], bp
            PRINT_STRING "Ёлемент "
            PRINT_DEC 1, al
            PRINT_STRING " не"
            PRINT_STRING " найден. "
            NEWLINE
            PRINT_STRING "Ёлемент "
            PRINT_DEC 1, al
            PRINT_STRING " добавлен."
               JMP Regularize
Regularize:
  xor eax, eax
  xor ecx, ecx
      mov edx, 0
      mov ebx, 1
      NEWLINE
      PRINT_STRING "ѕолученный массив: "
      call LeftBranch
      call Stamp
      call RightBranch
      xor eax, eax
      ret
LeftBranch:  
        Mov al, [mass+ebx+1]
        cmp eax, 0
        je M
        call UP
        call LeftBranch
        jmp R
M:     
        mov al, [mass+ebx]
        cmp edx, eax
        jae B
        call Stamp
        call RightBranch
        jmp R
Stamp:  
        mov al, [mass+ebx]
        mov edx, eax
        PRINT_DEC 1, al
        PRINT_STRING "/"
        ret
RightBranch:
         mov al, [mass+ebx+2]
         cmp eax, 0
         je C
         call UP
         call LeftBranch
         JMP R
C:    call Down
T:    cmp eax, 0
      je R
      mov al, [mass+ebx]
      cmp edx, eax
      jae C
      call Stamp
      call RightBranch
      jmp R      
R:   RET 
     jmp T
B:  
     call Down
     jmp M                   
UP:
    mov ebx, 1 
    imul eax, 4
    add ebx, eax 
    ret  
Down: dec ebx
      mov al, [mass+ebx]
      inc ebx
      call UP
      Ret     
         
 Section .data
    mass dd 0x02010600, 0x00000200, 0x00000800
    len equ $-mass
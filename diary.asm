format binary
use32
org 0x0

db 'MENUET01'
dd 0x01
dd start
dd i_end
dd app_memory
dd app_stack
dd 0
dd 0

start:
    call draw_window

main_loop:
    mov eax, 10
    int 0x40
    cmp eax, 1
    je .redraw
    cmp eax, 3
    je .quit
    cmp eax, 6
    je .quit
    jmp main_loop

.redraw:
    call draw_window
    jmp main_loop

.quit:
    mov eax, -1
    int 0x40

draw_window:
    mov eax, 0
    mov ebx, (100 shl 16) + 450
    mov ecx, (100 shl 16) + 350
    mov edx, 0x03FFF0F5
    mov esi, 0
    mov edi, window_title
    int 0x40

    mov eax, 12
    mov ebx, 1
    int 0x40

    mov eax, 4
    mov ebx, (190 shl 16) + 36
    mov ecx, 0x80000000 + 0xFFD700
    mov edx, art1
    int 0x40

    mov eax, 4
    mov ebx, (190 shl 16) + 50
    mov ecx, 0x80000000 + 0xFFD700
    mov edx, art2
    int 0x40

    mov eax, 4
    mov ebx, (190 shl 16) + 64
    mov ecx, 0x80000000 + 0xFF69B4
    mov edx, art3
    int 0x40

    mov eax, 4
    mov ebx, (190 shl 16) + 78
    mov ecx, 0x80000000 + 0xFFD700
    mov edx, art4
    int 0x40

    mov eax, 4
    mov ebx, (20 shl 16) + 110
    mov ecx, 0x80000000 + 0x000080
    mov edx, title_text
    int 0x40

    mov eax, 4
    mov ebx, (20 shl 16) + 140
    mov ecx, 0x80000000 + 0xFF1493
    mov edx, welcome_msg
    int 0x40

    mov eax, 12
    mov ebx, 2
    int 0x40
    ret

window_title db 'Moon Prism Diary', 0
title_text   db '* MOON PRISM POWER! *', 0
welcome_msg  db 'Stage 1 Complete: Window & Text Working!', 0

art1 db '          *', 0
art2 db '         /|\\', 0
art3 db '        | O |', 0
art4 db '         \\|/', 0

i_end:
align 32
app_memory:
rb 4096
app_stack:

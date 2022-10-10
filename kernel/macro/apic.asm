%macro macro_apic_id_get 0
    mov rax, qword[kernel_apic_base_address]
    mov dword[rax + KERNEL_APIC_TP_register], STATIC_EMPTY
    mov eax, dword[rax + KERNEL_APIC_ID_register]
    shr eax, 24
%endmacro
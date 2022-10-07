; Copyright (c) 2022 arfy slowy

; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:

; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.

; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

DRIVER_NIC_I82540EM_VENDOR_AND_DEVICE		equ	0x100E8086

DRIVER_NIC_I82540EM_CTRL			equ	0x0000	; Control Register
DRIVER_NIC_I82540EM_CTRL_FD			equ	0x00000001	; Full-Duplex
DRIVER_NIC_I82540EM_CTRL_LRST			equ	0x00000008	; Link Reset
DRIVER_NIC_I82540EM_CTRL_ASDE			equ	0x00000020	; Auto-Speed Detection Enable
DRIVER_NIC_I82540EM_CTRL_SLU			equ	0x00000040	; Set Link Up
DRIVER_NIC_I82540EM_CTRL_ILOS			equ	0x00000080	; Invert Loss-of-Signal (LOS).
DRIVER_NIC_I82540EM_CTRL_SPEED_BIT_8		equ	0x00000100	; Speed selection
DRIVER_NIC_I82540EM_CTRL_SPEED_BIT_9		equ	0x00000200	; Speed selection
DRIVER_NIC_I82540EM_CTRL_FRCSPD			equ	0x00000800	; Force Speed
DRIVER_NIC_I82540EM_CTRL_FRCPLX			equ	0x00001000	; Force Duplex
DRIVER_NIC_I82540EM_CTRL_SDP0_DATA		equ	0x00040000	; SDP0 Data Value
DRIVER_NIC_I82540EM_CTRL_SDP1_DATA		equ	0x00080000	; SDP1 Data Value
DRIVER_NIC_I82540EM_CTRL_ADVD3WUC		equ	0x00100000	; D3Cold Wakeup Capability Advertisement Enable
DRIVER_NIC_I82540EM_CTRL_EN_PHY_PWR_MGMT	equ	0x00200000	; PHY Power-Management Enable
DRIVER_NIC_I82540EM_CTRL_SDP0_IODIR		equ	0x00400000	; SDP0 Pin Directionality
DRIVER_NIC_I82540EM_CTRL_SDP1_IODIR		equ	0x00800000	; SDP1 Pin Directionality
DRIVER_NIC_I82540EM_CTRL_RST			equ	0x04000000	; Device Reset
DRIVER_NIC_I82540EM_CTRL_RFCE			equ	0x08000000	; Receive Flow Control Enable
DRIVER_NIC_I82540EM_CTRL_TFCE			equ	0x10000000	; Transmit Flow Control Enable
DRIVER_NIC_I82540EM_CTRL_VME			equ	0x40000000	; VLAN Mode Enable
DRIVER_NIC_I82540EM_CTRL_PHY_RST		equ	0x7FFFFFFF	; NASM ERROR => 0x80000000	; PHY Reset

DRIVER_NIC_I82540EM_STATUS			equ	0x0008	; Device Status Register
DRIVER_NIC_I82540EM_EECD			equ	0x0010	; EEPROM/Flash Control & Data Register
DRIVER_NIC_I82540EM_EERD			equ	0x0014	; EEPROM Read Register
DRIVER_NIC_I82540EM_CTRLEXT			equ	0x0018	; Extended Control Register
DRIVER_NIC_I82540EM_MDIC			equ	0x0020	; MDI Control Register
DRIVER_NIC_I82540EM_FCAL			equ	0x0028	; Flow Control Address Low
DRIVER_NIC_I82540EM_FCAH			equ	0x002C	; Flow Control Address High
DRIVER_NIC_I82540EM_FCT				equ	0x0030	; Flow Control Type
DRIVER_NIC_I82540EM_VET				equ	0x0038	; VLAN Ether Type
DRIVER_NIC_I82540EM_ICR_register		equ	0x00C0	; Interrupt Cause Read
DRIVER_NIC_I82540EM_ICR_register_flag_TXQE	equ	1	; Transmit Queue Empty
DRIVER_NIC_I82540EM_ICR_register_flag_RXT0	equ	7	; Receiver Timer Interrupt
DRIVER_NIC_I82540EM_ITR				equ	0x00C4	; Interrupt Throttling Register
DRIVER_NIC_I82540EM_ICS				equ	0x00C8	; Interrupt Cause Set Register
DRIVER_NIC_I82540EM_IMS				equ	0x00D0	; Interrupt Mask Set/Read Register
DRIVER_NIC_I82540EM_IMC				equ	0x00D8	; Interrupt Mask Clear

DRIVER_NIC_I82540EM_RCTL			equ	0x0100	; Receive Control Register
DRIVER_NIC_I82540EM_RCTL_EN			equ	0x00000002	; Receiver Enable
DRIVER_NIC_I82540EM_RCTL_SBP			equ	0x00000004	; Store Bad Packets
DRIVER_NIC_I82540EM_RCTL_UPE			equ	0x00000008	; Unicast Promiscuaus Enabled
DRIVER_NIC_I82540EM_RCTL_MPE			equ	0x00000010	; Multicast Promiscuous Enabled
DRIVER_NIC_I82540EM_RCTL_LPE			equ	0x00000020	; Long Packet Reception Enable
DRIVER_NIC_I82540EM_RCTL_LBM_BIT_6		equ	0x00000040	; Loopback mode
DRIVER_NIC_I82540EM_RCTL_LBM_BIT_7		equ	0x00000080	; Loopback mode
DRIVER_NIC_I82540EM_RCTL_RDMTS_BIT_8		equ	0x00000100	; Receive Descriptor Minimum Threshold Size
DRIVER_NIC_I82540EM_RCTL_RDMTS_BIT_9		equ	0x00000200	; Receive Descriptor Minimum Threshold Size
DRIVER_NIC_I82540EM_RCTL_MO_BIT_12		equ	0x00001000	; Multicast Offset
DRIVER_NIC_I82540EM_RCTL_MO_BIT_13		equ	0x00002000	; Multicast Offset
DRIVER_NIC_I82540EM_RCTL_BAM			equ	0x00008000	; Broadcast Accept Mode
DRIVER_NIC_I82540EM_RCTL_BSIZE_2048_BYTES	equ	0x00000000	; Receive Buffer Size
DRIVER_NIC_I82540EM_RCTL_BSIZE_1024_BYTES	equ	0x00010000	; Receive Buffer Size
DRIVER_NIC_I82540EM_RCTL_BSIZE_512_BYTES	equ	0x00020000	; Receive Buffer Size
DRIVER_NIC_I82540EM_RCTL_BSIZE_256_BYTES	equ	0x00030000	; Receive Buffer Size
DRIVER_NIC_I82540EM_RCTL_VFE			equ	0x00040000	; VLAN Filter Enable
DRIVER_NIC_I82540EM_RCTL_CFIEN			equ	0x00080000	; Canonical Form Indicator Enable
DRIVER_NIC_I82540EM_RCTL_CFI			equ	0x00100000	; Canonical Form Indicator bit value
DRIVER_NIC_I82540EM_RCTL_DPF			equ	0x00400000	; Discard Pause Frames
DRIVER_NIC_I82540EM_RCTL_PMCF			equ	0x00800000	; Pass MAC Control Frames
DRIVER_NIC_I82540EM_RCTL_BSEX			equ	0x02000000	; Receive Buffer Size multiply by 16
DRIVER_NIC_I82540EM_RCTL_SECRC			equ	0x04000000	; Strip Ethernet CRC from incoming packet

DRIVER_NIC_I82540EM_TXCW			equ	0x0178	; Transmit Configuration Word
DRIVER_NIC_I82540EM_TXCW_TXCONFIGWORD_BIT_5	equ	0x00000020	; Full Duplex
DRIVER_NIC_I82540EM_TXCW_TXCONFIGWORD_BIT_6	equ	0x00000040	; Half Duplex
DRIVER_NIC_I82540EM_TXCW_TXCONFIGWORD_BIT_7	equ	0x00000080	; Pause
DRIVER_NIC_I82540EM_TXCW_TXCONFIGWORD_BIT_8	equ	0x00000100	; Pause
DRIVER_NIC_I82540EM_TXCW_TXCONFIGWORD_BIT_12	equ	0x00001000	; Remote fault indication
DRIVER_NIC_I82540EM_TXCW_TXCONFIGWORD_BIT_13	equ	0x00002000	; Remote fault indication
DRIVER_NIC_I82540EM_TXCW_TXCONFIGWORD_BIT_15	equ	0x00008000	; Next page request
DRIVER_NIC_I82540EM_TXCW_TXCONFIGWORD		equ	0x40000000	; Transmit Config Control bit
DRIVER_NIC_I82540EM_TXCW_ANE			equ	0x80000000	; Auto-Negotiation Enable

DRIVER_NIC_I82540EM_RXCW			equ	0x0180	; Receive Configuration Word

DRIVER_NIC_I82540EM_TCTL			equ	0x0400	; Transmit Control Register
DRIVER_NIC_I82540EM_TCTL_EN			equ	0x00000002	; Transmit Enable
DRIVER_NIC_I82540EM_TCTL_PSP			equ	0x00000008	; Pad Short Packets
DRIVER_NIC_I82540EM_TCTL_CT			equ	0x00000100	; Collision Threshold
DRIVER_NIC_I82540EM_TCTL_COLD			equ	0x00040000	; Full-Duplex – 64-byte time
DRIVER_NIC_I82540EM_TCTL_SWXOFF			equ	0x00400000	; software OFF Transmission
DRIVER_NIC_I82540EM_TCTL_RTLC			equ	0x01000000	; Re-transmit on Late Collision
DRIVER_NIC_I82540EM_TCTL_NRTU			equ	0x02000000	; No Re-transmit on underrun (82544GC/EI only)

DRIVER_NIC_I82540EM_TDESC_BASE_ADDRESS		equ	0x00
DRIVER_NIC_I82540EM_TDESC_LENGTH_AND_FLAGS	equ	0x08
DRIVER_NIC_I82540EM_TDESC_STATUS_TU		equ	0x0000000800000000	; Transmit Underrun
DRIVER_NIC_I82540EM_TDESC_STATUS_LC		equ	0x0000000400000000	; Late Collision
DRIVER_NIC_I82540EM_TDESC_STATUS_EC		equ	0x0000000200000000	; Excess Collision
DRIVER_NIC_I82540EM_TDESC_STATUS_DD		equ	0x0000000100000000	; Descriptor Done
DRIVER_NIC_I82540EM_TDESC_CMD_IDE		equ	0x0000000080000000	; Interrupt Delay Enable
DRIVER_NIC_I82540EM_TDESC_CMD_VLE		equ	0x0000000040000000	; VLAN Packet Enable
DRIVER_NIC_I82540EM_TDESC_CMD_DEXT		equ	0x0000000020000000	; Extension (0b for legacy mode)
DRIVER_NIC_I82540EM_TDESC_CMD_RPS		equ	0x0000000010000000	; Report Packet Send (reserved for 82544GC/EI only)
DRIVER_NIC_I82540EM_TDESC_CMD_RS		equ	0x0000000008000000	; Report Status
DRIVER_NIC_I82540EM_TDESC_CMD_IC		equ	0x0000000004000000	; Insert Checksum
DRIVER_NIC_I82540EM_TDESC_CMD_IFCS		equ	0x0000000002000000	; Insert IFCS
DRIVER_NIC_I82540EM_TDESC_CMD_EOP		equ	0x0000000001000000	; End Of Packet

DRIVER_NIC_I82540EM_TIPG			equ	0x0410	; Transmit Inter Packet Gap
DRIVER_NIC_I82540EM_TIPG_IPGT_DEFAULT		equ	0x0000000A
DRIVER_NIC_I82540EM_TIPG_IPGT_BIT_0		equ	0x00000001	; IPG Transmit Time
DRIVER_NIC_I82540EM_TIPG_IPGT_BIT_1		equ	0x00000002	; IPG Transmit Time
DRIVER_NIC_I82540EM_TIPG_IPGT_BIT_2		equ	0x00000004	; IPG Transmit Time
DRIVER_NIC_I82540EM_TIPG_IPGT_BIT_3		equ	0x00000008	; IPG Transmit Time
DRIVER_NIC_I82540EM_TIPG_IPGT_BIT_4		equ	0x00000010	; IPG Transmit Time
DRIVER_NIC_I82540EM_TIPG_IPGT_BIT_5		equ	0x00000020	; IPG Transmit Time
DRIVER_NIC_I82540EM_TIPG_IPGT_BIT_6		equ	0x00000040	; IPG Transmit Time
DRIVER_NIC_I82540EM_TIPG_IPGT_BIT_7		equ	0x00000080	; IPG Transmit Time
DRIVER_NIC_I82540EM_TIPG_IPGT_BIT_8		equ	0x00000100	; IPG Transmit Time
DRIVER_NIC_I82540EM_TIPG_IPGT_BIT_9		equ	0x00000200	; IPG Transmit Time
DRIVER_NIC_I82540EM_TIPG_IPGR1_DEFAULT		equ	0x00002000
DRIVER_NIC_I82540EM_TIPG_IPGR1_BIT_10		equ	0x00000400	; IPG Receive Time 1
DRIVER_NIC_I82540EM_TIPG_IPGR1_BIT_11		equ	0x00000800	; IPG Receive Time 1
DRIVER_NIC_I82540EM_TIPG_IPGR1_BIT_12		equ	0x00001000	; IPG Receive Time 1
DRIVER_NIC_I82540EM_TIPG_IPGR1_BIT_13		equ	0x00002000	; IPG Receive Time 1
DRIVER_NIC_I82540EM_TIPG_IPGR1_BIT_14		equ	0x00004000	; IPG Receive Time 1
DRIVER_NIC_I82540EM_TIPG_IPGR1_BIT_15		equ	0x00008000	; IPG Receive Time 1
DRIVER_NIC_I82540EM_TIPG_IPGR1_BIT_16		equ	0x00010000	; IPG Receive Time 1
DRIVER_NIC_I82540EM_TIPG_IPGR1_BIT_17		equ	0x00020000	; IPG Receive Time 1
DRIVER_NIC_I82540EM_TIPG_IPGR1_BIT_18		equ	0x00040000	; IPG Receive Time 1
DRIVER_NIC_I82540EM_TIPG_IPGR1_BIT_19		equ	0x00080000	; IPG Receive Time 1
DRIVER_NIC_I82540EM_TIPG_IPGR2_DEFAULT		equ	0x00600000
DRIVER_NIC_I82540EM_TIPG_IPGR2_BIT_20		equ	0x00100000	; IPG Receive Time 2
DRIVER_NIC_I82540EM_TIPG_IPGR2_BIT_21		equ	0x00200000	; IPG Receive Time 2
DRIVER_NIC_I82540EM_TIPG_IPGR2_BIT_22		equ	0x00400000	; IPG Receive Time 2
DRIVER_NIC_I82540EM_TIPG_IPGR2_BIT_23		equ	0x00800000	; IPG Receive Time 2
DRIVER_NIC_I82540EM_TIPG_IPGR2_BIT_24		equ	0x01000000	; IPG Receive Time 2
DRIVER_NIC_I82540EM_TIPG_IPGR2_BIT_25		equ	0x02000000	; IPG Receive Time 2
DRIVER_NIC_I82540EM_TIPG_IPGR2_BIT_26		equ	0x04000000	; IPG Receive Time 2
DRIVER_NIC_I82540EM_TIPG_IPGR2_BIT_27		equ	0x08000000	; IPG Receive Time 2
DRIVER_NIC_I82540EM_TIPG_IPGR2_BIT_28		equ	0x10000000	; IPG Receive Time 2
DRIVER_NIC_I82540EM_TIPG_IPGR2_BIT_29		equ	0x20000000	; IPG Receive Time 2

DRIVER_NIC_I82540EM_LEDCTL			equ	0x0E00	; LED Control
DRIVER_NIC_I82540EM_PBA				equ	0x1000	; Packet Buffer Allocation
DRIVER_NIC_I82540EM_EEWD			equ	0x102C	; EEPROM Write Register
DRIVER_NIC_I82540EM_RDBAL			equ	0x2800	; RX Descriptor Base Address Low
DRIVER_NIC_I82540EM_RDBAH			equ	0x2804	; RX Descriptor Base Address High
DRIVER_NIC_I82540EM_RDLEN			equ	0x2808	; RX Descriptor Length
DRIVER_NIC_I82540EM_RDLEN_default		equ	0x80
DRIVER_NIC_I82540EM_RDH				equ	0x2810	; RX Descriptor Head
DRIVER_NIC_I82540EM_RDT				equ	0x2818	; RX Descriptor Tail
DRIVER_NIC_I82540EM_RDTR			equ	0x2820	; RX Delay Timer Register
DRIVER_NIC_I82540EM_RXDCTL			equ	0x3828	; RX Descriptor Control
DRIVER_NIC_I82540EM_RADV			equ	0x282C	; RX Int. Absolute Delay Timer
DRIVER_NIC_I82540EM_RSRPD			equ	0x2C00	; RX Small Packet Detect Interrupt
DRIVER_NIC_I82540EM_TXDMAC			equ	0x3000	; TX DMA Control
DRIVER_NIC_I82540EM_TDBAL			equ	0x3800	; TX Descriptor Base Address Low
DRIVER_NIC_I82540EM_TDBAH			equ	0x3804	; TX Descriptor Base Address High
DRIVER_NIC_I82540EM_TDLEN			equ	0x3808	; TX Descriptor Length
DRIVER_NIC_I82540EM_TDLEN_default		equ	0x80	
DRIVER_NIC_I82540EM_TDH				equ	0x3810	
DRIVER_NIC_I82540EM_TDT				equ	0x3818	; TX Descriptor Tail
DRIVER_NIC_I82540EM_TIDV			equ	0x3820	; TX Interrupt Delay Value
DRIVER_NIC_I82540EM_TXDCTL			equ	0x3828	; TX Descriptor Control
DRIVER_NIC_I82540EM_TADV			equ	0x382C	; TX Absolute Interrupt Delay Value
DRIVER_NIC_I82540EM_TSPMT			equ	0x3830	; TCP Segmentation Pad & Min Threshold
DRIVER_NIC_I82540EM_RXCSUM			equ	0x5000	; RX Checksum Control
DRIVER_NIC_I82540EM_MTA				equ	0x5200	; Multicast Table Array
DRIVER_NIC_I82540EM_RA				equ	0x5400	; Receive Address
DRIVER_NIC_I82540EM_IP4AT_ADDR0			equ	0x5840
DRIVER_NIC_I82540EM_IP4AT_ADDR1			equ	0x5848
DRIVER_NIC_I82540EM_IP4AT_ADDR2			equ	0x5850
DRIVER_NIC_I82540EM_IP4AT_ADDR3			equ	0x5858

struc	DRIVER_NIC_I82540EM_STRUCTURE_RCTL_RDESC_entry
	.base_address				resb	8
	.length					resb	2
	.checksum				resb	2
	.status					resb	1
	.errors					resb	1
	.special				resb	2
endstruc

driver_nic_i82540em_mmio_base_address		dq	STATIC_EMPTY
driver_nic_i82540em_irq_number			db	STATIC_EMPTY
driver_nic_i82540em_rx_base_address		dq	STATIC_EMPTY
driver_nic_i82540em_tx_base_address		dq	STATIC_EMPTY
driver_nic_i82540em_mac_address			dq	STATIC_EMPTY

driver_nic_i82540em_tx_queue_empty_semaphore	db	STATIC_TRUE
driver_nic_i82540em_promiscious_mode_semaphore	db	STATIC_FALSE

driver_nic_i82540em_ipv4_address		db	10, 0, 0, 64
driver_nic_i82540em_ipv4_mask			db	255, 255, 255, 0
driver_nic_i82540em_ipv4_gateway		db	10, 0, 0, 1

driver_nic_i82540em_vlan			dw	STATIC_EMPTY

driver_nic_i82540em_rx_count			dq	STATIC_EMPTY
driver_nic_i82540em_tx_count			dq	STATIC_EMPTY

driver_nic_i82540em_irq:
  push rax
  push rbx
  push rcx
  push rdx
  push rdi
  pushf

  mov rsi, qword[driver_nic_i82540em_mmio_base_address]
  mov eax, dword[rsi + DRIVER_NIC_I82540EM_ICR_register]

  bt eax, DRIVER_NIC_I82540EM_ICR_register_flag_TXQE
  jnc .no_txqe

  mov byte[driver_nic_i82540em_tx_queue_empty_semaphore], STATIC_TRUE
  jmp .end

.no_txqe:
  bt eax, DRIVER_NIC_I82540EM_ICR_register_flag_RXT0
  jnc .received

  ; pass the space with contents of the packet to the web service
  mov rbx, qword[service_network_pid]
  test rbx, rbx
  jz .received

  mov rsi, qword[driver_nic_i82540em_rx_base_address]
  movzx, ecx, word[rsi + DRIVER_NIC_I82540EM_STRUCTURE_RCTL_RDESC_entry.length]
  mov rsi, qword[rsi + DRIVER_NIC_I82540EM_STRUCTURE_RCTL_RDESC_entry.base_address]

  call driver_nic_i82540em_rx_release

  call kernel_ipc_insert

.received:
  mov rsi, qword[driver_nic_i82540em_mmio_base_address]
  mov dword[rsi + DRIVER_NIC_I82540EM_RD], 0x00
  mov dword[rsi + DRIVER_NIC_I82540EM_RDT] 0x01

.end:
  mov rax, qword[kernel_apic_base_address]
  mov dword[rax + KERNEL_APIC_EOI_register], STATIC_EMPTY

  popf
  pop rsi
  pop rdx
  pop rcx
  pop rbx
  pop rax

  iretq

  macro_debug "driver_nic_i82540em_irq"

driver_nic_i82540em_rx_release:
  push rax
  push rdi

  mov rax, qword[driver_nic_i82540em_rx_base_address]
  call kernel_memory_alloc_page
  jc .end

  mov qword[rax + DRIVER_NIC_I82540EM_TDESC_BASE_ADDRESS], rdi

.end:
  pop rdi
  pop rax

  ret
  macro_debug "driver_nic_i82540em_rx_release"

driver_nic_i82540em_transfer:
  push rsi
  push rax

.wait:
  cmp	byte [driver_nic_i82540em_tx_queue_empty_semaphore],	STATIC_TRUE
  jne .wait

  mov rsi, qword[driver_nic_i82540em_tx_base_address]

  mov qword[rsi + DRIVER_NIC_I82540EM_TDESC_BASE_ADDRESS], rdi

  and	rax,	STATIC_WORD_mask
	or	rax,	DRIVER_NIC_I82540EM_TDESC_CMD_RS
	or	rax,	DRIVER_NIC_I82540EM_TDESC_CMD_IFCS
	or	rax,	DRIVER_NIC_I82540EM_TDESC_CMD_EOP
	mov	qword [rsi + DRIVER_NIC_I82540EM_TDESC_LENGTH_AND_FLAGS],	rax

  mov byte[driver_nic_i82540em_tx_queue_empty_semaphore], STATIC_FALSE
  
  mov rax, qword[driver_nic_i82540em_mmio_base_address]
  mov dword[rax + DRIVER_NIC_I82540EM_TDH], 0x00
  mov dword[rax + DRIVER_NIC_I82540EM_TDT], 0x01

.status:
  mov rax, DRIVER_NIC_I82540EM_TDESC_STATUS_DD
  test rax, qword[rsi + DRIVER_NIC_I82540EM_TDESC_LENGTH_AND_FLAGS]
  jz .status

  pop rax
  pop rsi
  ret

  macro_debug "driver_nic_i82540em_transfer"

driver_nic_i82540em:
  push rx
  push rbx
  push rcx
  push rsi
  push rdi
  push r11

  mov eax, DRIVER_PCI_REGISTER_bar0
  call driver_pci_read

  bt eax, DRIVER_PCI_REGISTER_FLAGS_64_bit
  jnc .no

  push rax
  
  mov eax, DRIVER_PCI_REGISTER_bar1
  call driver_pci_read
  
  mov dword[rsp + STATIC_DWORD_SIZE_byte], eax
  pop rax

.no:
  and al, 0xF0
  mov qword[driver_nic_i82540em_mmio_base_address], rax
  mov rsi, rax
  mov eax, DRIVER_PCI_REGISTER_irq
  call driver_pci_read

  mov byte[driver_niv_i82540em_irq_number], al

  mov rax, qword[driver_nic_i82540em_mmio_base_address]
  mov	rbx,	KERNEL_PAGE_FLAG_available
  mov rcx, 32
  mov r11, cr3
  call kernel_page_map_pyhsical

  mov dword[rsi + DRIVER_NIC_I82540EM_EERD], 0x00000001
  mov eax, dword[rsi + DRIVER_NIC_I82540EM_EERD]
  shr eax, STATIC_MOCE_HIGH_TO_AX_SHIFT
  mov word[driver_nic_i82540em_mac_address + SERVICE_NETWORK_STRUCTURE_MAC, 0], ax

  mov dword[rsi + DRIVER_NIC_I82540EM_EERD], 0x00000101
  mov eax, dword[rsi + DRIVER_NIC_I82540EM_EERD]
  shr eax, STATIC_MOVE_HIGH_TO_AX_SHIFT

  mov word[driver_nic_i82540em_mac_address + SERVICE_NETWORK_STRUCTURE_MAC.2], ax

  mov dword[rsi + DRIVER_NIC_I82540EM_EERD], 0x00000201
  mov eax, dword[rsi + DRIVER_NIC_I82540EM_EERD]
  shr eax, STATIC_MOVE_HIGH_TO_AX_SHIFT

  mov word[driver_nic_i82540em_mac_address + SERVICE_NETWORK_STRUCTURE_MAC.4], ax
  
  mov dword[rsi + DRIVER_NIC_I82540EM_IMC], STATIC_MAX_unsigned
  
  mov eax, dword[rsi + DRIVER_NIC_I82540EM_ICR_register]

  call driver_nic_i82540em_setup

  pop r11
  pop rdi
  pop rsi
  pop rcx
  pop rbx
  pop rax

  ret

  macro_debug "driver_nic_i82540em"

driver_nic_i82540em_setup:
  push rax
  push rdi

  call kernel_memory_alloc_page
  call kernel_page_drain

  mov qword[driver_nic_i82540em_rx_base_address], rdi
  mov dword[rsi + DRIVER_NIC_I82540EM_RDBAL], edi
  shr rdi, STATIC_MOVE_HIGH_TO_EAX_shift, edi
  mov dword [rsi + aDRIVER_NIC_I82540EM_RBAH], edi

  mov dword[rsi + DRIVER_NIC_I82540EM_RDLEN], DRIVER_NIC_I82540EM_RDLEN_default
  mov dword[rsi + DRIVER_NIC_I82540EM_RDH], 0x00
  mov dword[rsi + DRIVER_NIC_I82540EM_RDT], 0x01

  call kernel_memory_alloc_page
  
  mov eax, DRIVER_NIC_I82540EM_RCTL_EN
  
  or eax, DRIVER_NIC_I82540EM_RCTL_UPE
  or eax, DRIVER_NIC_I82540EM_RCTL_BAM
  or eax, DRIVER_NIC_I82540EM_RCTL_SECRC
  or eax, DRIVER_NIC_I82540EM_RCTL_MPE
  mov dword[rsi + DRIVER_NIC_I82540EM_RCTL], eax

  call kernel_memory_alloc_page
  call kernel_page_drain

  mov qword[driver_nic_i82540em_tx_base_address], rdi
  mov dword[rsi + DRIVER_NIC_I82540EM_TDBAL], edi
  shr rdi, STATIC_MOVE_HIGH_TO_EAX_shift
  mov dword[rsi + DRIVER_NIC_I82540EM_TDBAH], edi

  mov dword[rsi + DRIVER_NIC_I82540EM_TDLEN], DRIVER_NIC_I82540EM_TDLEN_default
  mov dword[rsi + DRIVER_NIC_I82540EM_TDH], 0x00
  mov dword[rsi + DRIVER_NIC_I82540EM_TDT], 0x00

  
  mov eax, DRIVER_NIC_I82540EM_TCTL_EN
  or eax, DRIVER_NIC_I82540EM_TCTL_PSP
  or eax, DRIVER_NIC_I82540EM_TCTL_RTLC
  or eax, DRIVER_NIC_I82540EM_TCTL_CT
  or eax, DRIVER_NIC_I82540EM_TCTL_COLD
  mov dword[rsi + DRIVER_NIC_I82540EM_TCTL], eax

  mov eax, DRIVER_NIC_I82540EM_TIPG_IPGT_DEFAULT
  or eax, DRIVER_NIC_I82540EM_TIPG_IPGR1_DEFAULT
  or eax, DRIVER_NIC_I82540EM_TIPG_IPGR2_DEFAULT
  mov dword [rsi + DRIVER_NIC_I82540EM_TIPG], eax

  ; wlan controller

  mov eax, dword[rsi + DRIVER_NIC_I82540EM_CTRL]
  or eax, DRIVER_NIC_I82540EM_CTRL_SLU
  or eax, DRIVER_NIC_I82540EM_CTRL_ASDE
  and rax, ~DRIVER_NIC_I82540EM_CTRL_LRST
  and rax, ~DRIVER_NIC_I82540EM_CTRL_ILOS
  and rax, ~DRIVER_NIC_I82540EM_CTRL_VME
  and rax, DRIVER_NIC_I82540EM_CTRL_PHY_RST
  mov dword[rsi + DRIVER_NIC_I82540EM_CTR], eax

  movzx eax, byte [driver_nic_i82540em_irq_number]
  add al, KERNEL_IDT_IRQ_offset
  mov rbx, KERNEL_IDT_TYPE_irq
  mov rdi, driver_nic_i82540em_irq
  call kernel_idt_mount

  movzx ebx, byte[driver_nic_i82540em_irq_number]
  shl ebx, STATIC_MULTIPLE_BY_2_shift
  add ebx, KERNEL_IO_APIC_iowin
  call kernel_io_apic_connect

  mov rdi, qword[driver_nic_i82540em_mmio_base_address]
  mov dword[rdi + DRIVER_NIC_I82540EM_IMS], 00000000000000011111011011011111b

  pop rdi
  pop rax

  ret

  macro_debug "driver_nic_i82540em_setup"

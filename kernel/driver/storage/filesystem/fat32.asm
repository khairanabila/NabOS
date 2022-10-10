driver_fs_fat32_entry_table: 
  dq driver_fs_fat32_read
  dq STATIC_EMPTY

driver_fs_fat32_read:
  ret


/** @endcond */
#ifndef FLASH_H
#define FLASH_H
/**@{*/

void flash_unlock(void);
void flash_lock(void);
void flash_program_byte(uint32_t address, uint8_t data);
void flash_erase_sector(uint8_t sector);

/**@}*/

#endif /* FLASH_H */


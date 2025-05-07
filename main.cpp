#define F_CPU 16000000UL  // Define F_CPU as 16 MHz (adjust this if your MCU runs at a different clock speed)
#include <stdint.h>
#include <avr/io.h>
#include <avr/pgmspace.h>
#include <util/delay.h>

#define ROUNDS 8
#define WORD 16

// Precomputed S table bytes stored in PROGMEM to save SRAM
const uint8_t s_table_bytes[] PROGMEM = {
    0xE1, 0xB7, 0x18, 0x56, 0x4F, 0xF4, 0x86, 0x92,
    0xBD, 0x30, 0xF4, 0xCE, 0x2B, 0x6D, 0x62, 0x0B,
    0x99, 0xA9, 0xD0, 0x47, 0x07, 0xE6, 0x3E, 0x84,
    0x75, 0x22, 0xAC, 0xC0, 0xE3, 0x5E, 0x1A, 0xFD,
    0x51, 0x9B, 0x88, 0x39,
};

// S-table as 16-bit words
uint16_t S[sizeof(s_table_bytes) / 2];

void initialize_s_table() {
    // Load the S-table from program memory
    for (uint8_t i = 0; i < sizeof(s_table_bytes) / 2; i++) {
        S[i] = pgm_read_byte(&s_table_bytes[2 * i]) | (pgm_read_byte(&s_table_bytes[2 * i + 1]) << 8);
    }
}

uint16_t rotl16(uint16_t val, uint16_t shift) {
    shift %= 16;
    return ((val << shift) & 0xFFFF) | (val >> (16 - shift));
}

uint16_t rotr16(uint16_t val, uint16_t shift) {
    shift %= 16;
    return (val >> shift) | ((val << (16 - shift)) & 0xFFFF);
}

// Initialize USART for serial communication
void USART_init() {
    unsigned int ubrr = 103;  // Baud rate of 9600 for 16 MHz clock
    UBRR0H = (unsigned char)(ubrr >> 8);
    UBRR0L = (unsigned char)ubrr;
    UCSR0B = (1 << TXEN0);    // Enable transmitter
    UCSR0C = (1 << UCSZ01) | (1 << UCSZ00); // 8 data bits
}

void USART_transmit(unsigned char data) {
    while (!(UCSR0A & (1 << UDRE0)));  // Wait for the transmit buffer to be empty
    UDR0 = data;  // Send data
}

void USART_send_string(const char *str) {
    while (*str) {
        USART_transmit(*str++);
    }
}

void print_hex(uint16_t value) {
    char buffer[7]; // "0x" + 4 hex digits + null terminator
    buffer[0] = '0';
    buffer[1] = 'x';
    buffer[6] = '\0'; // Null-terminate the string

    // Convert value to hex manually for all 4 digits
    for (int i = 5; i >= 2; i--) {
        uint8_t hex_digit = value & 0x0F; // Get the lower nibble (4 bits)
        if (hex_digit < 10)
            buffer[i] = '0' + hex_digit;
        else
            buffer[i] = 'A' + (hex_digit - 10);
        value >>= 4; // Shift right by 4 bits for the next digit
    }

    USART_send_string(buffer);
}

int main(void) {
    // Initialize USART
    USART_init();

    // Initialize S-table
    initialize_s_table();

    // Plaintext
    uint16_t A0_val = 0x1234, B0_val = 0x5678;

    // Encryption
    uint16_t A = A0_val, B = B0_val;
    A = (A + S[0]) & 0xFFFF;
    B = (B + S[1]) & 0xFFFF;
    for (int i = 1; i <= ROUNDS; i++) {
        uint16_t shift = B & 0x0F;
        uint16_t tmp = rotl16(A ^ B, shift);
        A = (tmp + S[2 * i]) & 0xFFFF;

        shift = A & 0x0F;
        tmp = rotl16(B ^ A, shift);
        B = (tmp + S[2 * i + 1]) & 0xFFFF;
    }

    uint16_t ciphertext_A = A, ciphertext_B = B;

    // Decryption
    A = ciphertext_A;
    B = ciphertext_B;
    for (int i = ROUNDS; i > 0; i--) {
        B = (B - S[2 * i + 1]) & 0xFFFF;
        uint16_t shift = A & 0x0F;
        B = rotr16(B, shift) ^ A;

        A = (A - S[2 * i]) & 0xFFFF;
        shift = B & 0x0F;
        A = rotr16(A, shift) ^ B;
    }

    // Subtract initial additions
    B = (B - S[1]) & 0xFFFF;
    A = (A - S[0]) & 0xFFFF;

    // Decrypted values
    uint16_t decrypted_A = A, decrypted_B = B;

    // Send plaintext and ciphertext on the same line
    USART_send_string("Plaintext: A0=");
    print_hex(A0_val);
    USART_send_string(", B0=");
    print_hex(B0_val);
    USART_send_string("  Ciphertext: A=");
    print_hex(ciphertext_A);
    USART_send_string(", B=");
    print_hex(ciphertext_B);
    USART_send_string("\n");

    // Send decrypted values on a new line
    USART_send_string(" Decrypted: A=");
    print_hex(decrypted_A);
    USART_send_string(", B=");
    print_hex(decrypted_B);
    USART_send_string("\n");

    while (1) {
        // Infinite loop to keep the program running
        _delay_ms(1000);
    }

    return 0;
}
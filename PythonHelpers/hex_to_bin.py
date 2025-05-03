def hex_to_bin(hex_value):
    # Convert hex value to binary, pad to 8 bits (for 2 hex digits)
    return bin(int(hex_value, 16))[2:].zfill(8)

def convert_hex_file(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        # Read each line from the hex file
        for line in infile:
            # Remove any trailing spaces/newlines
            hex_value = line.strip()
            # Convert the hex value to binary (8 bits)
            bin_value = hex_to_bin(hex_value)
            # Write each bit of the binary value to the file, one bit per line
            for bit in bin_value:
                outfile.write(bit + '\n')

# Example usage
input_file = 'bitstream.txt'  # Input file containing hex values
output_file = 'binary_values.txt'  # Output file to write the binary values
convert_hex_file(input_file, output_file)

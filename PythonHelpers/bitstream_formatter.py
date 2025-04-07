def process_bit_stream(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        index = 0
        lines = []

        while True:
            # Read the next 32 lines (20 + 12) from the input file
            next_lines = [infile.readline().strip() for _ in range(32)]
            if not next_lines[0]:
                # End of file reached
                break
            
            # Split the lines into 20-bit and 12-bit chunks
            lines_20 = next_lines[:20]
            lines_12 = next_lines[20:32]

            # Write 20 bits in one line
            if len(lines_20) == 20:
                outfile.write(''.join(lines_20) + '\n')

            # Write 12 bits in another line
            if len(lines_12) == 12:
                outfile.write(''.join(lines_12) + '\n')
            
            # Write an empty line
            outfile.write('\n')

# Usage
input_file = '/home/aayan/Desktop/bitstream.txt'
output_file = '/home/aayan/Desktop/formatted_bit_stream.txt'
process_bit_stream(input_file, output_file)


import argparse

# Function to compare two files line by line
def compare_files(file1, file2):
    # Open the files for reading
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        # Read both files line by line
        lines1 = f1.readlines()
        lines2 = f2.readlines()

        # Ensure both files have the same number of lines
        if len(lines1) != len(lines2):
            print(f"Files have different number of lines: {len(lines1)} vs {len(lines2)}")
            return
        
        # Compare the lines
        differences = []
        for i in range(len(lines1)):
            if lines1[i].strip() != lines2[i].strip():
                differences.append((i + 1, lines1[i].strip(), lines2[i].strip()))

        # Print result
        if differences:
            print("Differences found:")
            for diff in differences:
                print(f"Line {diff[0]}:")
                print(f"  File 1: {diff[1]}")
                print(f"  File 2: {diff[2]}")
        else:
            print("The files are the same.")

# Main function to handle command-line arguments
def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Compare two text files line by line.")
    parser.add_argument("file1", help="The path to the first file to compare")
    parser.add_argument("file2", help="The path to the second file to compare")

    # Parse the arguments
    args = parser.parse_args()

    # Call the compare function with the provided files
    compare_files(args.file1, args.file2)

# Entry point of the script
if __name__ == "__main__":
    main()

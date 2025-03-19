import csv
import os

# Move up from 'utilities' folder to 'data' folder
INPUT_CSV = '../data/kgk_dataset.csv'  
OUTPUT_DART = '../data/diamond_data.dart'

def parse_size_range(size_str):
    """
    Takes something like '0.90-0.99' and returns float(0.90).
    If there's no hyphen, just convert the entire string to float.
    """
    size_str = size_str.strip()
    if '-' in size_str:
        return float(size_str.split('-')[0])
    else:
        return float(size_str)

def safe_float(value):
    """
    Converts a string to float safely. If empty or invalid, returns 0.0
    """
    try:
        return float(value)
    except:
        return 0.0

def main():
    output_lines = []
    # We'll import from diamond_model.dart, which presumably is also in lib/... 
    # Adjust if your diamond_model.dart is located differently.
    output_lines.append("import 'diamond_model.dart';\n")
    output_lines.append("final List<DiamondModel> diamondList = [\n")

    # If the CSV is actually comma-separated, remove `delimiter='\t'`.
    # If it's truly tab-delimited, keep it.
    with open(INPUT_CSV, mode='r', encoding='utf-8') as f:
        reader = csv.DictReader(f, delimiter='\t')
        for row in reader:
            # Read each needed column from the CSV
            lot_id = row["Lot ID"].strip()
            size_str = row["Size"].strip()
            carat_str = row["Carat"].strip()
            lab = row["Lab"].strip()
            shape = row["Shape"].strip()
            color = row["Color"].strip()
            clarity = row["Clarity"].strip()
            cut = row["Cut"].strip()
            polish = row["Polish"].strip()
            symmetry = row["Symmetry"].strip()
            fluorescence = row["Fluorescence"].strip()
            discount_str = row["Discount"].strip()
            per_carat_str = row["Per Carat Rate"].strip()
            final_amount_str = row["Final Amount"].strip()
            key_symbol = row["Key To Symbol"].strip()
            lab_comment = row["Lab Comment"].strip()

            # Convert numeric fields
            size_val = parse_size_range(size_str)
            carat_val = safe_float(carat_str)
            discount_val = safe_float(discount_str)
            per_carat_val = safe_float(per_carat_str)
            final_amount_val = safe_float(final_amount_str)

            # Build the Dart line
            dart_line = f"""  DiamondModel(
    lotId: '{lot_id}',
    size: {size_val},
    carat: {carat_val},
    lab: '{lab}',
    shape: '{shape}',
    color: '{color}',
    clarity: '{clarity}',
    cut: '{cut}',
    polish: '{polish}',
    symmetry: '{symmetry}',
    fluorescence: '{fluorescence}',
    discount: {discount_val},
    perCaratRate: {per_carat_val},
    finalAmount: {final_amount_val},
    keyToSymbol: '{key_symbol}',
    labComment: '{lab_comment}',
  ),"""
            output_lines.append(dart_line)

    output_lines.append("];\n")

    with open(OUTPUT_DART, mode='w', encoding='utf-8') as out_f:
        for line in output_lines:
            out_f.write(line + "\n")

    print(f"Done! Generated {OUTPUT_DART} with diamondList.")

if __name__ == "__main__":
    main()
import fitz  # PyMuPDF

def mirror_pdf_vector(input_pdf, output_pdf):
    doc = fitz.open(input_pdf)
    for page in doc:
        rect = page.rect  # Get page size
        matrix = fitz.Matrix(-1, 0, 0, 1, rect.width, 0)  # Mirror horizontally
        page.apply_transform(matrix)  # Corrected method
    doc.save(output_pdf)

# Usage Example
mirror_pdf_vector("test.pdf", "mirrored_output.pdf")
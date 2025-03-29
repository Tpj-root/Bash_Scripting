import fitz  # PyMuPDF
from pdf2image import convert_from_path
from PIL import Image

def mirror_pdf(input_pdf, output_pdf):
    # Convert PDF pages to images
    images = convert_from_path(input_pdf, dpi=300)

    mirrored_images = []
    for img in images:
        mirrored_img = img.transpose(Image.FLIP_LEFT_RIGHT)  # Mirror horizontally
        mirrored_images.append(mirrored_img)

    # Save mirrored images as a new PDF
    mirrored_images[0].save(output_pdf, save_all=True, append_images=mirrored_images[1:])

# Usage Example
mirror_pdf("test.pdf", "mirrored_output.pdf")

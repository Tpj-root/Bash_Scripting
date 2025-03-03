from http.server import SimpleHTTPRequestHandler, HTTPServer
import json, os, random

SAVE_DIR = "pastes"
os.makedirs(SAVE_DIR, exist_ok=True)  # Ensure directory exists

def generate_filename():
    return f"{random.getrandbits(40):x}.txt"  # 10-digit hex filename

class PastebinHandler(SimpleHTTPRequestHandler):
    def do_POST(self):
        if self.path == "/save":
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            data = json.loads(post_data)

            filename = generate_filename()
            filepath = os.path.join(SAVE_DIR, filename)
            
            with open(filepath, "w") as f:
                f.write(data["content"])

            self.send_response(200)
            self.end_headers()
            self.wfile.write(filename.encode())  # Return filename
    
    def do_GET(self):
        if self.path.startswith("/load/"):
            filename = self.path.split("/")[-1]
            filepath = os.path.join(SAVE_DIR, filename)

            if os.path.exists(filepath):
                with open(filepath, "r") as f:
                    content = f.read()
                
                self.send_response(200)
                self.send_header("Content-Type", "text/plain")
                self.end_headers()
                self.wfile.write(content.encode())
            else:
                self.send_response(404)
                self.end_headers()
                self.wfile.write(b"File not found")
        else:
            super().do_GET()

# Start Server
server_address = ("0.0.0.0", 8000)
httpd = HTTPServer(server_address, PastebinHandler)
print("Server running at http://localhost:8000")
httpd.serve_forever()

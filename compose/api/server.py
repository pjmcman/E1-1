import json, os
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = int(os.environ.get("API_PORT", "8000"))
MODE = os.environ.get("APP_MODE", "dev")

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = json.dumps({"service": "api", "mode": MODE, "port": PORT}).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(body)

HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()

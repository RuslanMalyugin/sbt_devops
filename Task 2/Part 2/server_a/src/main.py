from fastapi import FastAPI
import requests

app = FastAPI()
print("Server A started...")
SERVER_B_URL = "0.0.0.0:/echo/"


@app.post("/send/")
async def send_request(data: dict):
    response = requests.post(SERVER_B_URL, json=data)
    return response.json()

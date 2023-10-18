from fastapi import FastAPI, Request

app = FastAPI()
print("Server B started...")


@app.post("/echo/")
async def echo(request: Request, data: dict):
    client_host = request.client.host
    client_port = request.client.port
    data["server_b_ip"] = client_host
    data["server_b_port"] = client_port
    return data

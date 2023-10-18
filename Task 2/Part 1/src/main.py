from fastapi import FastAPI, HTTPException, Request
from pydantic import BaseModel
from typing import Any

app = FastAPI()
print("Server started...")


class EchoMessage(BaseModel):
    message: Any


@app.post("/echo/")
async def create_echo(request: Request):
    body = await request.json()
    return body

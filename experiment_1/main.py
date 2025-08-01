#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "fastapi",
#     "prometheus-client",
#     "uvicorn",
# ]
# ///

import uvicorn
from fastapi import FastAPI, Response
from prometheus_client import Gauge, generate_latest, CONTENT_TYPE_LATEST

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/health")
def health():
    return "OK"

# Simple up metric
UP = Gauge('test_up', 'Test service', ['experiment'])

@app.get("/metrics")
def metrics():
    UP.labels(experiment="1").set(1)
    return Response(
        content=generate_latest(),
        media_type=CONTENT_TYPE_LATEST
    )


def main() -> None:
    uvicorn.run(
        app,
        host="0.0.0.0",
        port=8000,
        reload=False,  # Auto-reload on code changes
        workers=1,    # Number of worker processes
        log_level="info"
    )


if __name__ == "__main__":
    main()

FROM python:3.12

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app
COPY main.py /app/

ENTRYPOINT [ "/app/main.py" ]

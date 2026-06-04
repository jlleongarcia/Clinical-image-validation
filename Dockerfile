FROM python:3.9-slim

WORKDIR /app

# Pass --build-arg USE_UV=1 to install via uv instead of pip
ARG USE_UV=0

COPY requirements.txt pyproject.toml uv.lock ./

RUN if [ "$USE_UV" = "1" ]; then \
        pip install uv --no-cache-dir && \
        uv pip install --system -r requirements.txt; \
    else \
        pip install --no-cache-dir -r requirements.txt; \
    fi

COPY . .

EXPOSE 8503

CMD ["python", "main.py", "8503"]

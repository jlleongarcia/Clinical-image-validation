# Clinical Image Quality Checklist

A simple web application built with Streamlit to help validate the quality of clinical images against a predefined checklist. Users tick off the criteria they can see, and the application generates a detailed Excel spreadsheet and a user-friendly Word summary.

## Features

- **Interactive checklist** organized by anatomical region (chest, skull, lumbar spine, pelvis, abdomen and contrast studies).
- **Excel report:** every criterion and whether it was met, in `.xlsx` format.
- **Word summary:** a readable `.docx` document with each criterion marked ✓ or ✗.
- **In-memory file generation:** nothing is written to disk on the server.
- **Persistent download buttons:** both files can be downloaded as many times as needed without regenerating them.

## Disclaimer

> **Important:** This tool is a support aid for image quality checks. It is not a certified medical device, and the final assessment of image quality remains the responsibility of qualified professionals.

## Running the app

There are two independent ways to run the app. Both install the same pinned dependency versions.

| | Local with uv | Docker |
|---|---|---|
| Best for | Development, running on a workstation | Deploying on a server |
| Requires | Python ≥ 3.13 and [uv](https://docs.astral.sh/uv/) | [Docker](https://docs.docker.com/get-docker/) with Compose |
| Installs from | `uv.lock` | `requirements.txt` (with pip, no uv) |
| Port | `8503`, configurable | `8503` inside the container, mapped in `docker-compose.yml` |

### Local with uv

1. **Clone the repository:**

   ```bash
   git clone https://github.com/jlleongarcia/Clinical-image-validation.git
   cd Clinical-image-validation
   ```

2. **Install dependencies:**

   ```bash
   uv sync
   ```

3. **Run the app:**

   ```bash
   uv run python main.py
   ```

   The app will be accessible at `http://localhost:8503`. You can pass a custom port as an argument:

   ```bash
   uv run python main.py 8080
   ```

### Docker

A multi-architecture image (`linux/amd64` and `linux/arm64`) is built by GitHub Actions and published to `ghcr.io/jlleongarcia/clinical-image-validation` on every push to `master`.

1. **Start the container** using the published image:

   ```bash
   docker compose pull
   docker compose up -d
   ```

   Or build the image locally instead:

   ```bash
   docker compose up -d --build
   ```

   The app will be accessible at `http://localhost:8503`. The container always listens on port `8503`; to serve it on a different host port, change the left side of the `ports` mapping in `docker-compose.yml` (e.g. `"8080:8503"`). The container is configured with `restart: always`, so it comes back after a crash or a server reboot.

2. **Update to the latest image:**

   ```bash
   docker compose pull
   docker compose up -d
   ```

3. **Stop it:**

   ```bash
   docker compose down
   ```

> **Note:** If the published package is private on GitHub Container Registry, run `docker login ghcr.io` on the server before pulling, or make the package public in its GitHub settings.

#### How the image is built

- **Base image:** `python:3.13-slim`.
- **Dependencies:** installed with `pip install -r requirements.txt`, which pins every package to the versions in `uv.lock`.
- **Process:** Streamlit runs directly as the main process (not through `main.py`), so it receives the stop signal from `docker stop` and shuts down cleanly.
- **Security:** the app runs as a non-root user.
- **Health check:** Docker polls Streamlit's `/_stcore/health` endpoint, so `docker ps` shows whether the app is healthy.
- **Privacy:** Streamlit's usage statistics are disabled, given the clinical setting.
- **No volumes needed:** reports are generated in memory and downloaded through the browser, so the container doesn't need access to any host folder.

## Usage

1. Go through the checklist and tick every criterion that is met.
2. When you are finished, click **"Guardar y Generar Archivos"** at the bottom of the page.
3. Download buttons appear for the **Excel (.xlsx)** data sheet (`DX26.xlsx`) and the **Word (.docx)** summary (`checklist_summary.docx`).

## Dependencies

| Package | Version |
|---|---|
| Python | ≥ 3.13 |
| [Streamlit](https://streamlit.io/) | 1.66.1 |
| [pandas](https://pandas.pydata.org/) | 3.1.0 |
| [openpyxl](https://openpyxl.readthedocs.io/) | 3.1.5 |
| [python-docx](https://python-docx.readthedocs.io/) | 1.2.0 |

`uv.lock` is the source of truth. `requirements.txt` is generated from it for the Docker image, so both ways of running the app use exactly the same versions.

### Updating dependencies

After changing dependencies in `pyproject.toml`, relock and regenerate `requirements.txt`:

```bash
uv lock
uv export --format requirements-txt --no-hashes --no-dev --no-emit-project --frozen -o requirements.txt
```

Never edit `requirements.txt` by hand; the [requirements sync workflow](#cicd) will fail if it doesn't match `uv.lock`.

## CI/CD

Two GitHub Actions workflows run on this repository:

- **`requirements-sync.yml`** runs on every push and pull request. It fails if `uv.lock` is out of date with `pyproject.toml`, or if `requirements.txt` doesn't match `uv.lock`. This keeps the local and Docker setups on the same versions.
- **`docker-publish.yml`** builds the image for `linux/amd64` and `linux/arm64`.
  - On pull requests to `master`, it only builds the image, to check that the Dockerfile still works.
  - On pushes to `master` (including merges), it also publishes the image to `ghcr.io/jlleongarcia/clinical-image-validation`, tagged `latest` and with the commit SHA.
  - It can also be started manually from the Actions tab.

## Project structure

```
├── main.py                     # Local entry point – launches Streamlit
├── app.py                      # Streamlit application
├── pyproject.toml              # Project metadata and dependencies
├── uv.lock                     # Locked dependency versions (source of truth)
├── requirements.txt            # Same versions exported for pip (Docker)
├── Dockerfile                  # Container image definition
├── docker-compose.yml          # Deployment configuration
├── .dockerignore               # Files excluded from the Docker build context
├── LICENSE                     # MIT License
└── .github/workflows/
    ├── requirements-sync.yml   # Checks requirements.txt matches uv.lock
    └── docker-publish.yml      # Builds and publishes the multi-arch image
```

## License

This project is licensed under the [MIT License](LICENSE).

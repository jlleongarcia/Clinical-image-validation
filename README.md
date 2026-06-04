# Clinical Image Quality Checklist Application

This is a simple web application built with Streamlit to help validate the quality of clinical images based on a predefined checklist. Users can check off criteria, and the application generates a detailed Excel spreadsheet and a user-friendly Word document summary.

## Features

- Interactive checklist interface organized by imaging modality.
- Generates a detailed report in Excel (`.xlsx`) format.
- Generates a user-friendly summary in Word (`.docx`) format.
- In-memory file generation to avoid cluttering the local directory.
- Persistent download links allow for downloading multiple files without regenerating them.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) — recommended, no Python install required.
- **Or** Python 3.9+ with [uv](https://github.com/astral-sh/uv) (recommended) or plain pip.
- [GNU Make](https://www.gnu.org/software/make/) — optional, simplifies Docker commands (available via `choco install make` on Windows).

## Setup and Installation

### Option A — Docker (recommended)

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/jlleongarcia/Clinical-image-validation.git
    cd Clinical-image-validation
    ```

2.  **Build and run with a single command:**
    ```bash
    make up
    ```
    This builds the Docker image and starts the container. The app will be available at `http://localhost:8503`.

    Without `make`, use the equivalent Docker commands:
    ```bash
    docker build -t clinical-image-validation .
    docker run -d --name clinical-image-validation -p 8503:8503 clinical-image-validation
    ```

    To use [uv](https://github.com/astral-sh/uv) inside the container instead of pip:
    ```bash
    make build-uv
    make run
    ```

#### Makefile reference

| Command | Description |
|---|---|
| `make up` | Build image and start container |
| `make down` | Stop and remove the container |
| `make logs` | Stream live container logs |
| `make clean` | Stop container and delete the image |

---

### Option B — Local Python (uv)

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/jlleongarcia/Clinical-image-validation.git
    cd Clinical-image-validation
    ```

2.  **Install dependencies and run:**
    ```bash
    uv run main.py
    ```

### Option C — Local Python (pip)

```bash
pip install -r requirements.txt
python main.py
```

## How to Run the Application

The application runs on port **8503** by default. Open `http://localhost:8503` in your browser after starting it via any of the methods above.

## How to Use

1.  Go through the checklist on the web page and check the boxes for all criteria that are met.
2.  Once you are finished, click the **"Guardar y Generar Archivos"** button at the bottom.
3.  Download buttons will appear, allowing you to save the **Excel (.xlsx)** data sheet and the **Word (.docx)** summary.
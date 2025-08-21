# Clinical Image Quality Checklist Application

This is a simple web application built with Streamlit to help validate the quality of clinical images based on a predefined checklist. Users can check off criteria, and the application generates a detailed Excel spreadsheet and a user-friendly Word document summary.

## Features

- Interactive checklist interface organized by imaging modality.
- Generates a detailed report in Excel (`.xlsx`) format.
- Generates a user-friendly summary in Word (`.docx`) format.
- In-memory file generation to avoid cluttering the local directory.
- Persistent download links allow for downloading multiple files without regenerating them.

## Prerequisites

- It is highly recommended uv for package management. Otherwise, Python 3.8+.

## Setup and Installation

1.  **Clone the repository (optional):**
    If you have git, you can clone the repository.
    ```bash
    git clone https://github.com/jlleongarcia/Clinical-image-validation.git
    cd Clinical-image-validation
    ```

2.  **Create virtual environment:**
    Open your terminal or command prompt in the project directory and install the required Python packages.
    ```bash
    uv init
    ```

## How to Run the Application

1.  Navigate to the project directory in your terminal.
2.  Run the following command:
    ```bash
    uv run main.py
    ```
3.  The application will run on port 8503 by default.

## How to Use

1.  Go through the checklist on the web page and check the boxes for all criteria that are met.
2.  Once you are finished, click the **"Guardar y Generar Archivos"** button at the bottom.
3.  Download buttons will appear, allowing you to save the **Excel (.xlsx)** data sheet and the **Word (.docx)** summary.
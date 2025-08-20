## Table of Contents
1. [Goal](#goal)
2. [Usage](#usage)
 - [Build Instructions](#build-it)
 - [Run Instructions](#run-it)
 - [IDE Integration](#use-it-in-an-ide)
3. [Content](#content)
4. [Miscellaneous Notes](#misc-notes)

## Goal

Provide a Docker image for building win x64 projects.

## Usage

### Build it
To build the Docker image:
```bash
docker build -t windev-docker . --file ./Dockerfile
```

### Run it
To run the container interactively:
```bash
docker run -it --rm -v $(pwd):/windev windev-docker /bin/bash
```

### Use it in an IDE
TODO

## Content

The Docker image includes:
- A Debian-based environment
- MXE (Mingw-w64 Cross Environment) for cross-compilation

## Misc notes:

- Ensure you have Docker installed on your system.
- You can modify the Docker image by editing the Dockerfile and rebuilding the image.

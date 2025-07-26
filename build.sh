#!/bin/bash

# Build script for Render deployment
set -e

echo "Starting LibreTranslate build process..."

# Upgrade pip
pip install --upgrade pip

# Install torch with CPU-only version to reduce build time and size
echo "Installing PyTorch (CPU version)..."
pip install torch==2.2.0 --extra-index-url https://download.pytorch.org/whl/cpu

# Install numpy with version constraint
echo "Installing numpy..."
pip install "numpy<2"

# Install Babel for translation compilation
echo "Installing Babel..."
pip install Babel==2.12.1

# Compile locales
echo "Compiling locales..."
python scripts/compile_locales.py

# Install the package
echo "Installing LibreTranslate..."
pip install .

echo "Build completed successfully!"

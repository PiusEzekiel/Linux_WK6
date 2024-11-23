from setuptools import setup, Extension

module = Extension(
    "weather_analysis",  # Module name
    sources=["weather_analysis.c"],  # Source file
)

setup(
    name="weather_analysis",
    version="1.0",
    description="Weather analysis C extension for Python",
    ext_modules=[module],
)

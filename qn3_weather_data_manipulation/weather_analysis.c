#include <Python.h>
#include <math.h>
#include <stdlib.h>

// Helper function: calculate mean
double calculate_mean(double *data, int size) {
    double sum = 0.0;
    for (int i = 0; i < size; i++) {
        sum += data[i];
    }
    return sum / size;
}

// Function: calculate standard deviation
static PyObject* calculate_stddev(PyObject* self, PyObject* args) {
    PyObject *listObj;
    if (!PyArg_ParseTuple(args, "O", &listObj)) {
        return NULL;
    }

    int size = PyList_Size(listObj);
    if (size <= 0) {
        PyErr_SetString(PyExc_ValueError, "List must contain elements");
        return NULL;
    }

    double *data = malloc(size * sizeof(double));
    if (!data) {
        PyErr_SetString(PyExc_MemoryError, "Memory allocation failed");
        return NULL;
    }

    for (int i = 0; i < size; i++) {
        PyObject *item = PyList_GetItem(listObj, i);
        data[i] = PyFloat_AsDouble(item);
    }

    double mean = calculate_mean(data, size);
    double variance = 0.0;
    for (int i = 0; i < size; i++) {
        variance += (data[i] - mean) * (data[i] - mean);
    }
    variance /= size;

    free(data);
    return Py_BuildValue("d", sqrt(variance));
}

// Function: calculate median
static PyObject* calculate_median(PyObject* self, PyObject* args) {
    PyObject *listObj;
    if (!PyArg_ParseTuple(args, "O", &listObj)) {
        return NULL;
    }

    int size = PyList_Size(listObj);
    if (size <= 0) {
        PyErr_SetString(PyExc_ValueError, "List must contain elements");
        return NULL;
    }

    double *data = malloc(size * sizeof(double));
    if (!data) {
        PyErr_SetString(PyExc_MemoryError, "Memory allocation failed");
        return NULL;
    }

    for (int i = 0; i < size; i++) {
        PyObject *item = PyList_GetItem(listObj, i);
        data[i] = PyFloat_AsDouble(item);
    }

    // Sort the array
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            if (data[j] > data[j + 1]) {
                double temp = data[j];
                data[j] = data[j + 1];
                data[j + 1] = temp;
            }
        }
    }

    double median;
    if (size % 2 == 0) {
        median = (data[size / 2 - 1] + data[size / 2]) / 2.0;
    } else {
        median = data[size / 2];
    }

    free(data);
    return Py_BuildValue("d", median);
}

// Function: calculate mode
static PyObject* calculate_mode(PyObject* self, PyObject* args) {
    PyObject *listObj;
    if (!PyArg_ParseTuple(args, "O", &listObj)) {
        return NULL;
    }

    int size = PyList_Size(listObj);
    if (size <= 0) {
        PyErr_SetString(PyExc_ValueError, "List must contain elements");
        return NULL;
    }

    double *data = malloc(size * sizeof(double));
    if (!data) {
        PyErr_SetString(PyExc_MemoryError, "Memory allocation failed");
        return NULL;
    }

    for (int i = 0; i < size; i++) {
        PyObject *item = PyList_GetItem(listObj, i);
        data[i] = PyFloat_AsDouble(item);
    }

    // Find mode
    double mode = data[0];
    int max_count = 0;

    for (int i = 0; i < size; i++) {
        int count = 0;
        for (int j = 0; j < size; j++) {
            if (data[j] == data[i]) {
                count++;
            }
        }
        if (count > max_count) {
            max_count = count;
            mode = data[i];
        }
    }

    free(data);
    return Py_BuildValue("d", mode);
}

// Define module methods
static PyMethodDef WeatherMethods[] = {
    {"calculate_stddev", calculate_stddev, METH_VARARGS, "Calculate standard deviation"},
    {"calculate_median", calculate_median, METH_VARARGS, "Calculate median"},
    {"calculate_mode", calculate_mode, METH_VARARGS, "Calculate mode"},
    {NULL, NULL, 0, NULL}
};

// Define the module
static struct PyModuleDef weathermodule = {
    PyModuleDef_HEAD_INIT,
    "weather_analysis",
    NULL,
    -1,
    WeatherMethods
};

// Initialize the module
PyMODINIT_FUNC PyInit_weather_analysis(void) {
    return PyModule_Create(&weathermodule);
}

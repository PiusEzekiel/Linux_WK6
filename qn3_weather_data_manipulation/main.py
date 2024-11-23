import csv
import weather_analysis

def read_temperature_column(file_path, column_name):
    """Reads the temperature column from the dataset."""
    temperatures = []
    with open(file_path, 'r') as file:
        reader = csv.DictReader(file)
        for row in reader:
            if column_name in row and row[column_name]:
                temperatures.append(float(row[column_name]))
    return temperatures

def main():
    file_path = "weather.csv"  # Path to the dataset
    column_name = "Data.Temperature.Avg Temp"

    # Read temperatures
    temperatures = read_temperature_column(file_path, column_name)

    # Calculate statistics
    mode_temp = weather_analysis.calculate_mode(temperatures)
    std_dev_temp = weather_analysis.calculate_stddev(temperatures)
    median_temp = weather_analysis.calculate_median(temperatures)

    # Output results
    print(f"Mode Temperature: {mode_temp}")
    print(f"Standard Deviation: {std_dev_temp:.2f}")
    print(f"Median Temperature: {median_temp}")

if __name__ == "__main__":
    main()

# Cyclistic Bike-Share Analysis (Python Version)
# This script analyzes Cyclistic bike-share data to compare casual and member usage

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Set random seed for reproducibility
np.random.seed(123)

# Simulate sample data (replace with real data import if available)
n = 10000
member_casual = np.random.choice(['member', 'casual'], size=n, p=[0.65, 0.35])
ride_length = np.where(
    member_casual == 'member',
    np.random.gamma(shape=1.5, scale=10, size=n),  # shorter rides
    np.random.gamma(shape=2.5, scale=10, size=n)   # longer rides
)
days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
day_of_week = np.where(
    member_casual == 'member',
    np.random.choice(days, size=n, p=[0.15, 0.15, 0.15, 0.15, 0.15, 0.13, 0.12]),
    np.random.choice(days, size=n, p=[0.1, 0.1, 0.1, 0.1, 0.15, 0.25, 0.2])
)
hour_of_day = np.where(
    member_casual == 'member',
    np.random.choice(range(24), size=n, p=[0.01]*7 + [0.1, 0.15, 0.1] + [0.03]*6 + [0.1, 0.15, 0.1] + [0.01]*6),
    np.random.choice(range(24), size=n, p=[0.01]*7 + [0.03]*3 + [0.1]*6 + [0.03]*3 + [0.01]*5)
)
seasons = ['Winter', 'Spring', 'Summer', 'Fall']
season = np.where(
    member_casual == 'member',
    np.random.choice(seasons, size=n, p=[0.15, 0.25, 0.35, 0.25]),
    np.random.choice(seasons, size=n, p=[0.1, 0.2, 0.5, 0.2])
)
bike_types = ['classic_bike', 'electric_bike', 'docked_bike']
rideable_type = np.where(
    member_casual == 'member',
    np.random.choice(bike_types, size=n, p=[0.75, 0.2, 0.05]),
    np.random.choice(bike_types, size=n, p=[0.6, 0.3, 0.1])
)

df = pd.DataFrame({
    'member_casual': member_casual,
    'ride_length': ride_length,
    'day_of_week': pd.Categorical(day_of_week, categories=days, ordered=True),
    'hour_of_day': hour_of_day,
    'season': pd.Categorical(season, categories=seasons, ordered=True),
    'rideable_type': rideable_type
})

# Summary statistics
summary_stats = df.groupby('member_casual').agg(
    number_of_rides=('ride_length', 'count'),
    average_ride_length=('ride_length', 'mean'),
    median_ride_length=('ride_length', 'median'),
    max_ride_length=('ride_length', 'max')
).reset_index()
summary_stats.to_csv("cyclistic_summary_stats.csv", index=False)

# Day of week stats
day_of_week_stats = df.groupby(['member_casual', 'day_of_week']).agg(
    number_of_rides=('ride_length', 'count'),
    average_ride_length=('ride_length', 'mean')
).reset_index()
day_of_week_stats.to_csv("cyclistic_day_of_week_stats.csv", index=False)

# Hour of day stats
hour_of_day_stats = df.groupby(['member_casual', 'hour_of_day']).agg(
    number_of_rides=('ride_length', 'count'),
    average_ride_length=('ride_length', 'mean')
).reset_index()
hour_of_day_stats.to_csv("cyclistic_hour_of_day_stats.csv", index=False)

# Season stats
season_stats = df.groupby(['member_casual', 'season']).agg(
    number_of_rides=('ride_length', 'count'),
    average_ride_length=('ride_length', 'mean')
).reset_index()
season_stats.to_csv("cyclistic_season_stats.csv", index=False)

# Bike type stats
bike_type_stats = df.groupby(['member_casual', 'rideable_type']).agg(
    number_of_rides=('ride_length', 'count'),
    average_ride_length=('ride_length', 'mean')
).reset_index()
bike_type_stats.to_csv("cyclistic_bike_type_stats.csv", index=False)

# Example plot: Average Ride Length by User Type
plt.figure(figsize=(8, 5))
sns.barplot(x='member_casual', y='average_ride_length', data=summary_stats, palette='viridis')
plt.title('Average Ride Length by User Type')
plt.xlabel('User Type')
plt.ylabel('Average Ride Length (minutes)')
plt.savefig("avg_ride_length_by_user_type.png", bbox_inches='tight')

# Add more plots as needed using the other summary tables
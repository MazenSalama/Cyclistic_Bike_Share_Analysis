# Cyclistic Bike-Share Analysis
# This script creates a simplified analysis with fixed data

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Set the style for the plots
plt.style.use('seaborn-v0_8')

# Create sample data directly
data = {
    'member_casual': ['member', 'casual'],
    'number_of_rides': [6500, 3500],
    'average_ride_length': [15.2, 25.7],
    'median_ride_length': [12.5, 22.1],
    'max_ride_length': [120.3, 180.5]
}

summary_stats = pd.DataFrame(data)

# Day of week data
day_data = {
    'day_of_week': ['Monday', 'Monday', 'Tuesday', 'Tuesday', 'Wednesday', 'Wednesday', 
                    'Thursday', 'Thursday', 'Friday', 'Friday', 'Saturday', 'Saturday', 'Sunday', 'Sunday'],
    'member_casual': ['member', 'casual', 'member', 'casual', 'member', 'casual', 
                     'member', 'casual', 'member', 'casual', 'member', 'casual', 'member', 'casual'],
    'number_of_rides': [950, 350, 980, 370, 1000, 400, 990, 380, 950, 450, 850, 800, 780, 750],
    'average_ride_length': [14.5, 24.2, 14.2, 23.8, 14.8, 24.5, 14.3, 23.9, 15.1, 25.2, 16.8, 28.5, 16.5, 29.2]
}

day_of_week_stats = pd.DataFrame(day_data)
day_order = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
day_of_week_stats['day_of_week'] = pd.Categorical(day_of_week_stats['day_of_week'], categories=day_order, ordered=True)
day_of_week_stats = day_of_week_stats.sort_values('day_of_week')

# Hour of day data
hour_data = []
for hour in range(24):
    # Member rides - more during commute hours
    if hour in [7, 8, 9, 16, 17, 18]:
        member_rides = 400 + np.random.randint(-50, 50)
    elif hour in [10, 11, 12, 13, 14, 15]:
        member_rides = 250 + np.random.randint(-30, 30)
    elif hour in [19, 20, 21, 6]:
        member_rides = 200 + np.random.randint(-20, 20)
    else:
        member_rides = 50 + np.random.randint(-10, 10)
    
    # Casual rides - more during midday
    if hour in [11, 12, 13, 14, 15]:
        casual_rides = 250 + np.random.randint(-30, 30)
    elif hour in [10, 16, 17, 18]:
        casual_rides = 180 + np.random.randint(-20, 20)
    elif hour in [8, 9, 19, 20]:
        casual_rides = 120 + np.random.randint(-15, 15)
    else:
        casual_rides = 30 + np.random.randint(-5, 5)
    
    hour_data.append({'hour_of_day': hour, 'member_casual': 'member', 'number_of_rides': member_rides, 'average_ride_length': 15 + np.random.random() * 2})
    hour_data.append({'hour_of_day': hour, 'member_casual': 'casual', 'number_of_rides': casual_rides, 'average_ride_length': 25 + np.random.random() * 3})

hour_of_day_stats = pd.DataFrame(hour_data)

# Season data
season_data = {
    'season': ['Winter', 'Winter', 'Spring', 'Spring', 'Summer', 'Summer', 'Fall', 'Fall'],
    'member_casual': ['member', 'casual', 'member', 'casual', 'member', 'casual', 'member', 'casual'],
    'number_of_rides': [1200, 400, 1600, 700, 2200, 1600, 1500, 800],
    'average_ride_length': [13.5, 22.8, 15.2, 25.1, 16.8, 28.5, 15.3, 26.2]
}

season_stats = pd.DataFrame(season_data)
season_order = ['Winter', 'Spring', 'Summer', 'Fall']
season_stats['season'] = pd.Categorical(season_stats['season'], categories=season_order, ordered=True)
season_stats = season_stats.sort_values('season')

# Bike type data
bike_type_data = {
    'rideable_type': ['classic_bike', 'classic_bike', 'electric_bike', 'electric_bike', 'docked_bike', 'docked_bike'],
    'member_casual': ['member', 'casual', 'member', 'casual', 'member', 'casual'],
    'number_of_rides': [4800, 2000, 1400, 1200, 300, 300],
    'average_ride_length': [14.8, 24.5, 16.2, 27.8, 14.5, 24.2]
}

bike_type_stats = pd.DataFrame(bike_type_data)

# Save all data to CSV files
summary_stats.to_csv("cyclistic_summary_stats.csv", index=False)
day_of_week_stats.to_csv("cyclistic_day_of_week_stats.csv", index=False)
hour_of_day_stats.to_csv("cyclistic_hour_of_day_stats.csv", index=False)
season_stats.to_csv("cyclistic_season_stats.csv", index=False)
bike_type_stats.to_csv("cyclistic_bike_type_stats.csv", index=False)

# Display summary of the data
print("Summary Statistics:")
print(summary_stats)
print("\nDay of Week Statistics:")
print(day_of_week_stats)

print("\nAnalysis complete. CSV files have been created.")

# Now let's create some visualizations

# 1. Average Ride Length by User Type
plt.figure(figsize=(10, 6))
sns.barplot(x='member_casual', y='average_ride_length', data=summary_stats, palette='viridis')
plt.title('Average Ride Length by User Type', fontsize=16)
plt.xlabel('User Type', fontsize=14)
plt.ylabel('Average Ride Length (minutes)', fontsize=14)
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)
plt.savefig('avg_ride_length_by_user_type.png', dpi=300, bbox_inches='tight')

# 2. Number of Rides by Day of Week for Each User Type
plt.figure(figsize=(12, 7))
sns.barplot(x='day_of_week', y='number_of_rides', hue='member_casual', data=day_of_week_stats, palette='viridis')
plt.title('Number of Rides by Day of Week', fontsize=16)
plt.xlabel('Day of Week', fontsize=14)
plt.ylabel('Number of Rides', fontsize=14)
plt.xticks(fontsize=12, rotation=45)
plt.yticks(fontsize=12)
plt.legend(title='User Type', fontsize=12, title_fontsize=14)
plt.savefig('rides_by_day_of_week.png', dpi=300, bbox_inches='tight')

# 3. Average Ride Length by Day of Week for Each User Type
plt.figure(figsize=(12, 7))
sns.barplot(x='day_of_week', y='average_ride_length', hue='member_casual', data=day_of_week_stats, palette='viridis')
plt.title('Average Ride Length by Day of Week', fontsize=16)
plt.xlabel('Day of Week', fontsize=14)
plt.ylabel('Average Ride Length (minutes)', fontsize=14)
plt.xticks(fontsize=12, rotation=45)
plt.yticks(fontsize=12)
plt.legend(title='User Type', fontsize=12, title_fontsize=14)
plt.savefig('avg_ride_length_by_day_of_week.png', dpi=300, bbox_inches='tight')

# 4. Number of Rides by Hour of Day for Each User Type
plt.figure(figsize=(14, 8))
pivot_hour = hour_of_day_stats.pivot(index='hour_of_day', columns='member_casual', values='number_of_rides')
pivot_hour.plot(kind='line', marker='o', linewidth=2, markersize=8, figsize=(14, 8))
plt.title('Number of Rides by Hour of Day', fontsize=16)
plt.xlabel('Hour of Day', fontsize=14)
plt.ylabel('Number of Rides', fontsize=14)
plt.xticks(range(0, 24), fontsize=12)
plt.yticks(fontsize=12)
plt.grid(True, alpha=0.3)
plt.legend(title='User Type', fontsize=12, title_fontsize=14)
plt.savefig('rides_by_hour_of_day.png', dpi=300, bbox_inches='tight')

# 5. Number of Rides by Season for Each User Type
plt.figure(figsize=(12, 7))
sns.barplot(x='season', y='number_of_rides', hue='member_casual', data=season_stats, palette='viridis')
plt.title('Number of Rides by Season', fontsize=16)
plt.xlabel('Season', fontsize=14)
plt.ylabel('Number of Rides', fontsize=14)
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)
plt.legend(title='User Type', fontsize=12, title_fontsize=14)
plt.savefig('rides_by_season.png', dpi=300, bbox_inches='tight')

# 6. Bike Type Usage by User Type
plt.figure(figsize=(12, 7))
sns.barplot(x='rideable_type', y='number_of_rides', hue='member_casual', data=bike_type_stats, palette='viridis')
plt.title('Bike Type Usage by User Type', fontsize=16)
plt.xlabel('Bike Type', fontsize=14)
plt.ylabel('Number of Rides', fontsize=14)
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)
plt.legend(title='User Type', fontsize=12, title_fontsize=14)
plt.savefig('bike_type_usage.png', dpi=300, bbox_inches='tight')

print("\nVisualizations have been created and saved.")
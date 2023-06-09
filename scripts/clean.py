# Library Imports
import pandas as pd # Handles data from csv's

# Method to compute cost then drop trivial columns
# Receives: df
# Returns: df
def compute_cost(df):
    df['cost'] = (df['stays_in_weekend_nights'] + df['stays_in_week_nights']) * df['avg_price_per_room']
    drop_columns = ['lead_time', 'stays_in_weekend_nights', 'stays_in_week_nights', 'market_segment_type', 'avg_price_per_room']
    df = df.drop(drop_columns, axis=1)
    return df

# Method to preprocess data
# Receives: N/A
# Returns: mergedData
def preprocess_then_merge_data():
    # Grab csv data
    hotelData = pd.read_csv('hotel-booking.csv')
    customerData = pd.read_csv('customer-reservations.csv')

    # Clean hotelData
    hotelData = hotelData[hotelData['booking_status'] == 0]
    hotelData['arrival_month'] = pd.to_datetime(hotelData['arrival_month'], format='%B').dt.month
    hotelData = compute_cost(hotelData)
    hotelData = hotelData.drop(['hotel', 'booking_status', 'arrival_date_week_number', 'arrival_date_day_of_month', 'country', 'email'], axis=1)

    # Clean customerData
    customerData = customerData[customerData['booking_status'] == 'Not_Canceled']
    customerData = compute_cost(customerData)
    customerData = customerData.drop(['Booking_ID', 'lead_time', 'arrival_date', 'market_segment_type', 'booking_status'], axis=1)

    # Merge dataframes
    mergedData = pd.concat([hotelData, customerData], ignore_index=True)

    # Additional preprocessing
    mergedData['year_month'] = mergedData['arrival_year'].astype(str) + '_' + mergedData['arrival_month'].astype(str)
    mergedData = mergedData.drop(['arrival_year', 'arrival_month'], axis=1)

    return mergedData

# Method to save the preprocessed data to a new csv
# Receives: df
# Returns: N/A (file output)
def save_preprocessed_data(df):
    df.to_csv('clean.csv', index=False)
    print(df)


# Main harness
if __name__ == "__main__":
    cleanData = preprocess_then_merge_data()
    save_preprocessed_data(cleanData)

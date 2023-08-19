import requests

# Set the input parameters for the route
latitude = 41.3176
longitude = -81.3454
week_number = 20
sf_thresh = 0.03

# Set the URL of your Bottle app
url = 'http://192.168.1.75:7600/predictedspecies'

# Send a GET request with the parameters
response = requests.get(url, params={
    'latitude': latitude,
    'longitude': longitude,
    'week_number': week_number,
    'sf_thresh': sf_thresh
})

# Check if the request was successful
if response.status_code == 200:
    # Print the results
    print(response.json())
else:
    print(f"Error: {response.status_code}")

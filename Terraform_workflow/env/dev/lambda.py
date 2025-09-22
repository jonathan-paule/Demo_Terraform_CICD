import json

# Sample data (hardcoded for now)
ROOMS = {
    "mumbai": [
        {"hotel": "Sea Breeze", "room": "Deluxe", "price": 4500},
        {"hotel": "Skyline Inn", "room": "Standard", "price": 3200}
    ],
    "delhi": [
        {"hotel": "Capital Comfort", "room": "Deluxe", "price": 4000},
        {"hotel": "Rajpath Residency", "room": "Standard", "price": 2800}
    ]
}

def lambda_handler(event, context):
    # event = request info from API Gateway
    query = event.get("queryStringParameters") or {}
    city = (query.get("city") or "").lower()

    if not city:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Please provide ?city=cityname"})
        }

    return {
        "statusCode": 200,
        "body": json.dumps({
            "city": city,
            "rooms": ROOMS.get(city, [])
        })
    }


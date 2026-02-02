"""
Test script for the Employability Prediction API
"""
import requests
import json

# API endpoint
url = "http://localhost:8000/api/employability/predict/"

# Test cases
test_students = [
    {
        "name": "High Performer",
        "data": {
            "cgpa": 3.8,
            "aptitude_score": 90,
            "coding_skill": 9,
            "communication": 8,
            "internships": 3
        }
    },
    {
        "name": "Average Student",
        "data": {
            "cgpa": 3.0,
            "aptitude_score": 70,
            "coding_skill": 6,
            "communication": 6,
            "internships": 1
        }
    },
    {
        "name": "Low Performer",
        "data": {
            "cgpa": 2.5,
            "aptitude_score": 55,
            "coding_skill": 4,
            "communication": 5,
            "internships": 0
        }
    }
]

print("Testing Employability Prediction API")
print("=" * 50)

for student in test_students:
    print(f"\nTesting: {student['name']}")
    print(f"Input: {json.dumps(student['data'], indent=2)}")
    
    try:
        response = requests.post(url, json=student['data'])
        
        if response.status_code == 200:
            result = response.json()
            print(f"✓ Prediction successful!")
            print(f"  Logistic Regression: {'Employable' if result['logistic_regression'] == 1 else 'Not Employable'}")
            print(f"  Decision Tree: {'Employable' if result['decision_tree'] == 1 else 'Not Employable'}")
        else:
            print(f"✗ Error: {response.status_code}")
            print(f"  {response.json()}")
    except Exception as e:
        print(f"✗ Connection error: {e}")
        print("  Make sure the Django server is running!")

print("\n" + "=" * 50)

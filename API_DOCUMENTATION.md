# Employability Prediction API - Complete Documentation

## Base URL
```
http://localhost:8000/api/employability/
```

## Endpoints

### 1. Prediction Endpoint

#### GET `/predict/`
Returns API information, usage instructions, and model details.

**Response:**
```json
{
    "message": "Employability Prediction API",
    "version": "1.0.0",
    "description": "Predicts student employability using Logistic Regression and Decision Tree models",
    "endpoints": {
        "predict": {
            "url": "/api/employability/predict/",
            "methods": ["GET", "POST"],
            "description": "Make employability predictions"
        },
        "model_info": {
            "url": "/api/employability/model-info/",
            "methods": ["GET"],
            "description": "Get information about trained models"
        },
        "sample": {
            "url": "/api/employability/sample/",
            "methods": ["GET"],
            "description": "Get sample request data"
        }
    },
    "usage": {
        "method": "POST",
        "content_type": "application/json",
        "required_fields": {
            "cgpa": "float (0.0 - 4.0) - Grade Point Average",
            "aptitude_score": "float (0 - 100) - Aptitude test score",
            "coding_skill": "float (0 - 10) - Coding skill rating",
            "communication": "float (0 - 10) - Communication skill rating",
            "internships": "integer (0+) - Number of internships"
        },
        "example_request": {
            "cgpa": 3.5,
            "aptitude_score": 85,
            "coding_skill": 8,
            "communication": 7,
            "internships": 2
        },
        "example_response": {
            "logistic_regression": 1,
            "decision_tree": 1,
            "note": "1 = Employable, 0 = Not Employable"
        }
    },
    "models": {
        "logistic_regression": {
            "name": "Logistic Regression",
            "description": "Binary classification model with feature scaling",
            "features": "Uses StandardScaler for normalization",
            "file": "logistic_model.pkl",
            "exists": true,
            "last_trained": "2026-01-16 18:40:52"
        },
        "decision_tree": {
            "name": "Decision Tree Classifier",
            "description": "Tree-based model for non-linear pattern recognition",
            "features": "Provides interpretable decision rules",
            "file": "decision_tree_model.pkl",
            "exists": true,
            "last_trained": "2026-01-16 18:40:52"
        }
    }
}
```

**PowerShell Example:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Get
```

---

#### POST `/predict/`
Makes an employability prediction for a student.

**Request Body:**
```json
{
    "cgpa": 3.5,
    "aptitude_score": 85,
    "coding_skill": 8,
    "communication": 7,
    "internships": 2
}
```

**Field Descriptions:**
| Field | Type | Range | Description |
|-------|------|-------|-------------|
| cgpa | float | 0.0 - 4.0 | Grade Point Average |
| aptitude_score | float | 0 - 100 | Aptitude test score |
| coding_skill | float | 0 - 10 | Coding skill rating |
| communication | float | 0 - 10 | Communication skill rating |
| internships | integer | 0+ | Number of internships completed |

**Response:**
```json
{
    "logistic_regression": 1,
    "decision_tree": 1
}
```

**Response Values:**
- `1` = Employable
- `0` = Not Employable

**PowerShell Example:**
```powershell
$body = @{
    cgpa = 3.5
    aptitude_score = 85
    coding_skill = 8
    communication = 7
    internships = 2
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Post -Body $body -ContentType "application/json"
```

**Error Response (400 Bad Request):**
```json
{
    "cgpa": ["This field is required."],
    "aptitude_score": ["This field is required."]
}
```

---

### 2. Model Information Endpoint

#### GET `/model-info/`
Returns detailed information about the trained machine learning models.

**Response:**
```json
{
    "logistic_regression": {
        "name": "Logistic Regression",
        "description": "Binary classification model with feature scaling",
        "features": "Uses StandardScaler for normalization",
        "file": "logistic_model.pkl",
        "exists": true,
        "last_trained": "2026-01-16 18:40:52"
    },
    "decision_tree": {
        "name": "Decision Tree Classifier",
        "description": "Tree-based model for non-linear pattern recognition",
        "features": "Provides interpretable decision rules",
        "file": "decision_tree_model.pkl",
        "exists": true,
        "last_trained": "2026-01-16 18:40:52"
    }
}
```

**PowerShell Example:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8000/api/employability/model-info/" -Method Get
```

---

### 3. Sample Data Endpoint

#### GET `/sample/`
Returns sample student data that can be used for testing the prediction endpoint.

**Response:**
```json
{
    "message": "Sample student data for testing",
    "samples": {
        "high_performer": {
            "description": "Student with high academic performance and skills",
            "data": {
                "cgpa": 3.8,
                "aptitude_score": 90,
                "coding_skill": 9,
                "communication": 8,
                "internships": 3
            },
            "expected_prediction": "Employable (1)"
        },
        "average_student": {
            "description": "Student with average performance",
            "data": {
                "cgpa": 3.0,
                "aptitude_score": 70,
                "coding_skill": 6,
                "communication": 6,
                "internships": 1
            },
            "expected_prediction": "May vary (0 or 1)"
        },
        "low_performer": {
            "description": "Student with lower academic performance",
            "data": {
                "cgpa": 2.5,
                "aptitude_score": 55,
                "coding_skill": 4,
                "communication": 5,
                "internships": 0
            },
            "expected_prediction": "Not Employable (0)"
        }
    },
    "usage": "Copy any 'data' object and POST to /api/employability/predict/"
}
```

**PowerShell Example:**
```powershell
# Get sample data
$samples = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/sample/" -Method Get

# Use high performer sample for prediction
$body = $samples.samples.high_performer.data | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Post -Body $body -ContentType "application/json"
```

---

## Complete Usage Examples

### Example 1: Get API Information
```powershell
# Get API info and available endpoints
$info = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Get
Write-Host "API Version: $($info.version)"
Write-Host "Available Endpoints:"
$info.endpoints.PSObject.Properties | ForEach-Object {
    Write-Host "  $($_.Value.url) - $($_.Value.description)"
}
```

### Example 2: Check Model Status
```powershell
# Check if models are trained and when
$models = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/model-info/" -Method Get
Write-Host "Logistic Regression: $(if ($models.logistic_regression.exists) {'Trained'} else {'Not Trained'})"
Write-Host "Decision Tree: $(if ($models.decision_tree.exists) {'Trained'} else {'Not Trained'})"
```

### Example 3: Test with Sample Data
```powershell
# Get sample data and make prediction
$samples = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/sample/" -Method Get
$testData = $samples.samples.high_performer.data | ConvertTo-Json

# Make prediction
$result = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Post -Body $testData -ContentType "application/json"
Write-Host "Logistic Regression: $(if ($result.logistic_regression -eq 1) {'Employable'} else {'Not Employable'})"
Write-Host "Decision Tree: $(if ($result.decision_tree -eq 1) {'Employable'} else {'Not Employable'})"
```

### Example 4: Custom Prediction
```powershell
# Create custom student data
$student = @{
    cgpa = 3.2
    aptitude_score = 78
    coding_skill = 7
    communication = 6
    internships = 1
} | ConvertTo-Json

# Get prediction
$prediction = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Post -Body $student -ContentType "application/json"

# Display results
Write-Host "Prediction Results:"
Write-Host "  Logistic Regression: $($prediction.logistic_regression)"
Write-Host "  Decision Tree: $($prediction.decision_tree)"
```

---

## Testing Scripts

### Test All GET Methods
```powershell
powershell -ExecutionPolicy Bypass -File test_get_methods.ps1
```

### Test POST Predictions
```powershell
powershell -ExecutionPolicy Bypass -File test_api.ps1
```

---

## Error Handling

### 400 Bad Request
Returned when required fields are missing or invalid.

**Example:**
```json
{
    "cgpa": ["This field is required."],
    "coding_skill": ["A valid number is required."]
}
```

### 404 Not Found
Returned when accessing an invalid endpoint.

### 405 Method Not Allowed
Returned when using an unsupported HTTP method on an endpoint.

### 500 Internal Server Error
Returned when models are not trained or there's a server error.

**Solution:** Run the training script:
```powershell
python Employee_details/train.py
```

---

## Browser Access

You can also access GET endpoints directly in your browser:

- **API Info:** http://localhost:8000/api/employability/predict/
- **Model Info:** http://localhost:8000/api/employability/model-info/
- **Sample Data:** http://localhost:8000/api/employability/sample/

---

## Model Details

### Logistic Regression
- **Type:** Binary Classification
- **Preprocessing:** StandardScaler (feature normalization)
- **Use Case:** Linear relationships between features
- **Advantages:** Fast, interpretable coefficients
- **Output:** Probability-based prediction

### Decision Tree
- **Type:** Tree-based Classification
- **Preprocessing:** None required
- **Use Case:** Non-linear patterns and interactions
- **Advantages:** Interpretable rules, handles non-linearity
- **Output:** Rule-based prediction

---

## Training Data

The models are trained on student data with the following features:
- CGPA (2.3 - 3.9)
- Aptitude scores (50 - 95)
- Coding skills (3 - 10)
- Communication skills (4 - 9)
- Internships (0 - 3)

**Training set:** 30 samples
**Test split:** 20%

---

## Retraining Models

To retrain with new data:

1. Update `Employee_details/sample_data.csv` with your data
2. Run training script:
   ```powershell
   python Employee_details/train.py
   ```
3. Server will auto-reload with new models

---

## Support

For issues or questions, check:
- `QUICK_START.md` - Quick start guide
- `README_DJANGO.md` - Full documentation
- Server logs - Check terminal where server is running

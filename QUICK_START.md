# Quick Start Guide - Employability Prediction API

## ✅ System is Ready and Running!

Your Django REST API for employability prediction is now live at:
**http://localhost:8000/api/employability/predict/**

## What's Working

✅ Models trained successfully (Logistic Regression + Decision Tree)
✅ Django server running on port 8000
✅ API endpoint responding correctly
✅ All test cases passing

## Test Results

| Student Profile | CGPA | Aptitude | Coding | Communication | Internships | LR Prediction | DT Prediction |
|----------------|------|----------|--------|---------------|-------------|---------------|---------------|
| High Performer | 3.8  | 90       | 9      | 8             | 3           | ✅ Employable | ✅ Employable |
| Average        | 3.0  | 70       | 6      | 6             | 1           | ❌ Not Employable | ❌ Not Employable |
| Low Performer  | 2.5  | 55       | 4      | 5             | 0           | ❌ Not Employable | ❌ Not Employable |

## How to Use

### 1. Make a Prediction (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -File test_api.ps1
```

### 2. Make a Prediction (Manual)

Create a JSON file `student.json`:
```json
{
    "cgpa": 3.5,
    "aptitude_score": 85,
    "coding_skill": 8,
    "communication": 7,
    "internships": 2
}
```

Then use PowerShell:
```powershell
$body = Get-Content student.json
Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Post -Body $body -ContentType "application/json"
```

### 3. Response Format

```json
{
    "logistic_regression": 1,
    "decision_tree": 1
}
```

Where:
- `1` = Employable
- `0` = Not Employable

## Input Fields

| Field | Type | Range | Description |
|-------|------|-------|-------------|
| cgpa | float | 0.0 - 4.0 | Grade Point Average |
| aptitude_score | float | 0 - 100 | Aptitude test score |
| coding_skill | float | 0 - 10 | Coding skill rating |
| communication | float | 0 - 10 | Communication skill rating |
| internships | integer | 0+ | Number of internships |

## Project Structure

```
Employee_Built/
├── Employee_details/          # Django app
│   ├── modules.py            # ML model logic
│   ├── serializers.py        # Data validation
│   ├── Views.py              # API endpoints
│   ├── Urls.py               # URL routing
│   ├── sample_data.csv       # Training data (30 samples)
│   ├── train.py              # Model training script
│   ├── logistic_model.pkl    # Trained LR model
│   └── decision_tree_model.pkl # Trained DT model
├── project_config/            # Django project settings
├── manage.py                  # Django management
├── test_api.ps1              # PowerShell test script
└── README_DJANGO.md          # Full documentation
```

## Models

### Logistic Regression
- Uses StandardScaler for normalization
- Binary classification
- Good for linear relationships
- Fast predictions

### Decision Tree
- No feature scaling needed
- Captures non-linear patterns
- Interpretable rules
- Feature importance available

## Training Data

The system was trained on 30 student records with features:
- CGPA (2.3 - 3.9)
- Aptitude scores (50 - 95)
- Coding skills (3 - 10)
- Communication skills (4 - 9)
- Internships (0 - 3)

## Next Steps

1. **Add more training data**: Replace `Employee_details/sample_data.csv` with your own data
2. **Retrain models**: Run `python Employee_details/train.py`
3. **Restart server**: The server will auto-reload
4. **Test predictions**: Use `test_api.ps1` to verify

## Stopping the Server

Press `CTRL+C` in the terminal where the server is running, or close the terminal window.

## Troubleshooting

**Server not responding?**
- Check if server is running: Look for "Starting development server" message
- Verify port 8000 is not in use by another application

**Models not found?**
- Run training script: `python Employee_details/train.py`
- Check that `.pkl` files exist in `Employee_details/` folder

**Import errors?**
- Install dependencies: `python -m pip install django djangorestframework scikit-learn pandas joblib`

## API Documentation

See `README_DJANGO.md` for complete API documentation and advanced usage.

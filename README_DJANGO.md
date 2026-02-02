# Employability Prediction API

A Django REST Framework API that predicts student employability using Logistic Regression and Decision Tree models.

## Setup Instructions

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Train the Models

```bash
cd Employee_details
python train.py
cd ..
```

This will create two model files:
- `logistic_model.pkl` - Logistic Regression model
- `decision_tree_model.pkl` - Decision Tree model

### 3. Run the Django Server

```bash
python manage.py runserver
```

The server will start at `http://localhost:8000`

## API Usage

### Endpoint

```
POST http://localhost:8000/api/employability/predict/
```

### Request Body

```json
{
    "cgpa": 3.5,
    "aptitude_score": 85,
    "coding_skill": 8,
    "communication": 7,
    "internships": 2
}
```

### Response

```json
{
    "logistic_regression": 1,
    "decision_tree": 1
}
```

Where `1` = Employable, `0` = Not Employable

### Field Descriptions

- **cgpa**: Grade Point Average (0.0 - 4.0)
- **aptitude_score**: Aptitude test score (0 - 100)
- **coding_skill**: Coding skill rating (0 - 10)
- **communication**: Communication skill rating (0 - 10)
- **internships**: Number of internships completed (0+)

## Testing the API

### Using the Test Script

```bash
python test_api.py
```

### Using curl

```bash
curl -X POST http://localhost:8000/api/employability/predict/ \
  -H "Content-Type: application/json" \
  -d '{
    "cgpa": 3.8,
    "aptitude_score": 90,
    "coding_skill": 9,
    "communication": 8,
    "internships": 3
  }'
```

### Using Postman

1. Set method to POST
2. URL: `http://localhost:8000/api/employability/predict/`
3. Headers: `Content-Type: application/json`
4. Body (raw JSON):
```json
{
    "cgpa": 3.5,
    "aptitude_score": 85,
    "coding_skill": 8,
    "communication": 7,
    "internships": 2
}
```

## Project Structure

```
.
├── Employee_details/
│   ├── modules.py          # ML model training and prediction logic
│   ├── serializers.py      # DRF serializers for validation
│   ├── Views.py            # API views
│   ├── Urls.py             # URL routing
│   ├── sample_data.csv     # Training data
│   └── train.py            # Model training script
├── project_config/
│   ├── settings.py         # Django settings
│   ├── urls.py             # Main URL configuration
│   └── wsgi.py             # WSGI configuration
├── manage.py               # Django management script
├── requirements.txt        # Python dependencies
└── test_api.py            # API testing script
```

## Models

### Logistic Regression
- Uses StandardScaler for feature normalization
- Binary classification (employable/not employable)
- Good for linear relationships

### Decision Tree
- No feature scaling required
- Captures non-linear patterns
- Provides interpretable decision rules

## Sample Data

The `sample_data.csv` contains 30 training examples with features:
- CGPA, aptitude scores, coding skills, communication skills, internships
- Binary target: employable (1) or not employable (0)

## Troubleshooting

### Models not found error
Run the training script first:
```bash
cd Employee_details
python train.py
```

### Port already in use
Change the port:
```bash
python manage.py runserver 8001
```

### Import errors
Make sure all dependencies are installed:
```bash
pip install -r requirements.txt
```

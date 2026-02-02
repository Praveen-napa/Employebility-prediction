# Employee Employability Prediction System

A Django-based web application that predicts student employability using Machine Learning models (Logistic Regression and Decision Tree) with a beautiful, interactive UI.

## 🚀 Features

- **Dual ML Models**: Logistic Regression and Decision Tree predictions
- **Comprehensive Eligibility Criteria**: Multi-factor assessment system
- **Beautiful UI**: Gradient backgrounds with responsive design
- **Real-time Predictions**: Instant employability assessment
- **Sample Data**: Pre-loaded test cases for different performance levels
- **REST API**: Full API endpoints for integration

## 📋 Eligibility Criteria

Students must meet ALL of the following requirements to be eligible for employment:

- **CGPA**: ≥ 5.5 (out of 10.0)
- **Aptitude Score**: > 38 (out of 100)
- **Coding Skill**: > 4 (out of 10)
- **Communication**: > 6 (out of 10)
- **Internships**: ≥ 2 certificates

## 🛠️ Tech Stack

- **Backend**: Django 6.0.1, Django REST Framework
- **ML Libraries**: scikit-learn, pandas, joblib
- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Styling**: Custom CSS with gradients and animations
- **API**: RESTful endpoints with JSON responses

## 📦 Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Employee_Built
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Run the development server**
   ```bash
   python manage.py runserver
   ```

4. **Access the application**
   - Web UI: http://127.0.0.1:8000/
   - API Documentation: http://127.0.0.1:8000/api/employability/predict/

## 🎯 Usage

### Web Interface

1. Navigate to `http://127.0.0.1:8000/`
2. Fill in the employee details form:
   - CGPA (0.0 - 10.0)
   - Aptitude Score (0 - 100)
   - Coding Skill (0 - 10)
   - Communication (0 - 10)
   - Internships (0+)
3. Click "Predict Employability" or use sample buttons
4. View results with eligibility status and ML predictions

### API Endpoints

#### POST /api/employability/predict/
Make employability predictions

**Request Body:**
```json
{
    "cgpa": 8.5,
    "aptitude_score": 85,
    "coding_skill": 8,
    "communication": 7,
    "internships": 2
}
```

**Response:**
```json
{
    "logistic_regression": 1,
    "decision_tree": 1,
    "eligibility_status": "Eligible",
    "all_criteria_met": true,
    "requirements": {
        "cgpa": "✓ Met (≥ 5.5)",
        "aptitude_score": "✓ Met (> 38)",
        "coding_skill": "✓ Met (> 4)",
        "communication": "✓ Met (> 6)",
        "internships": "✓ Met (≥ 2)"
    }
}
```

#### GET /api/employability/model-info/
Get information about trained models

#### GET /api/employability/sample/
Get sample test data

## 🧪 Sample Test Cases

The application includes three pre-configured test cases:

1. **High Performer**: CGPA 9.2, Aptitude 90, Coding 9, Communication 8, Internships 3
2. **Average Student**: CGPA 7.5, Aptitude 70, Coding 6, Communication 6, Internships 1
3. **Low Performer**: CGPA 5.5, Aptitude 55, Coding 4, Communication 5, Internships 0

## 📁 Project Structure

```
Employee_Built/
├── core/                   # Django core configuration
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── Employee_details/       # Main application
│   ├── templates/
│   │   └── index.html     # Beautiful UI template
│   ├── modules.py         # ML prediction logic
│   ├── Views.py           # API views
│   ├── Urls.py            # URL routing
│   ├── serializers.py     # Data validation
│   ├── train.py           # Model training
│   ├── sample_data.csv    # Training data
│   ├── logistic_model.pkl # Trained LR model
│   └── decision_tree_model.pkl # Trained DT model
├── manage.py              # Django management
├── requirements.txt       # Dependencies
└── README.md             # This file
```

## 🎨 UI Features

- **Gradient Background**: Purple to pink gradient design
- **Responsive Layout**: Works on desktop and mobile
- **Interactive Forms**: Real-time validation and feedback
- **Visual Results**: Color-coded prediction cards
- **Loading Animation**: Spinner during prediction
- **Sample Buttons**: Quick test data loading
- **Error Handling**: Clear error messages and validation

## 🔧 Configuration

### CORS Settings
The application is configured to allow cross-origin requests for API access.

### Model Training
Models are pre-trained on sample data. To retrain:

```python
from Employee_details.modules import train_models
train_models('Employee_details/sample_data.csv')
```

## 🚦 API Response Codes

- **200**: Successful prediction
- **400**: Invalid input data
- **500**: Server error

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is for educational purposes.

## 🆘 Troubleshooting

### Common Issues

1. **Server won't start**: Check if port 8000 is available
2. **Model not found**: Ensure .pkl files exist in Employee_details/
3. **CORS errors**: Verify corsheaders is installed and configured
4. **Template not found**: Check TEMPLATES setting in core/settings.py

### Support

For issues or questions, please check the API documentation at `/api/employability/predict/` when the server is running.

---

**Built with ❤️ using Django and Machine Learning**
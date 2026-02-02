import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline
import joblib
import os
from datetime import datetime

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

MODEL_LR = os.path.join(BASE_DIR, "logistic_model.pkl")
MODEL_DT = os.path.join(BASE_DIR, "decision_tree_model.pkl")

def train_models(csv_path):
    data = pd.read_csv(csv_path)

    X = data.drop("employable", axis=1)
    y = data["employable"]

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

    lr_pipeline = Pipeline([
        ('scaler', StandardScaler()),
        ('model', LogisticRegression())
    ])

    dt_model = DecisionTreeClassifier()

    lr_pipeline.fit(X_train, y_train)
    dt_model.fit(X_train, y_train)

    joblib.dump(lr_pipeline, MODEL_LR)
    joblib.dump(dt_model, MODEL_DT)

    return "Models trained successfully"

def predict_employability(input_data):
    # Extract all criteria values
    cgpa = input_data.get('cgpa', 0)
    aptitude_score = input_data.get('aptitude_score', 0)
    coding_skill = input_data.get('coding_skill', 0)
    communication = input_data.get('communication', 0)
    internships = input_data.get('internships', 0)
    
    # Check all eligibility criteria
    eligibility_checks = {
        'cgpa': cgpa >= 5.5,
        'aptitude': aptitude_score > 38,
        'coding': coding_skill > 4,
        'communication': communication > 6,
        'internships': internships >= 2
    }
    
    # Build failure reasons
    failed_criteria = []
    if not eligibility_checks['cgpa']:
        failed_criteria.append(f"CGPA must be at least 5.5 (Current: {cgpa})")
    if not eligibility_checks['aptitude']:
        failed_criteria.append(f"Aptitude score must be greater than 38 (Current: {aptitude_score})")
    if not eligibility_checks['coding']:
        failed_criteria.append(f"Coding skill must be greater than 4 (Current: {coding_skill})")
    if not eligibility_checks['communication']:
        failed_criteria.append(f"Communication skill must be greater than 6 (Current: {communication})")
    if not eligibility_checks['internships']:
        failed_criteria.append(f"Must have at least 2 internships (Current: {internships})")
    
    # If any criteria fails, student is not eligible
    if failed_criteria:
        return {
            "logistic_regression": 0,
            "decision_tree": 0,
            "eligibility_status": "Not Eligible",
            "failed_criteria": failed_criteria,
            "requirements": {
                "cgpa": "≥ 5.5",
                "aptitude_score": "> 38",
                "coding_skill": "> 4",
                "communication": "> 6",
                "internships": "≥ 2"
            }
        }
    
    # If all criteria pass, proceed with ML predictions
    lr_model = joblib.load(MODEL_LR)
    dt_model = joblib.load(MODEL_DT)

    df = pd.DataFrame([input_data])

    lr_pred = lr_model.predict(df)[0]
    dt_pred = dt_model.predict(df)[0]

    return {
        "logistic_regression": int(lr_pred),
        "decision_tree": int(dt_pred),
        "eligibility_status": "Eligible",
        "all_criteria_met": True,
        "requirements": {
            "cgpa": "✓ Met (≥ 5.5)",
            "aptitude_score": "✓ Met (> 38)",
            "coding_skill": "✓ Met (> 4)",
            "communication": "✓ Met (> 6)",
            "internships": "✓ Met (≥ 2)"
        }
    }

def get_model_info():
    """
    Returns information about the trained models
    """
    info = {
        "logistic_regression": {
            "name": "Logistic Regression",
            "description": "Binary classification model with feature scaling",
            "features": "Uses StandardScaler for normalization",
            "file": "logistic_model.pkl",
            "exists": os.path.exists(MODEL_LR)
        },
        "decision_tree": {
            "name": "Decision Tree Classifier",
            "description": "Tree-based model for non-linear pattern recognition",
            "features": "Provides interpretable decision rules",
            "file": "decision_tree_model.pkl",
            "exists": os.path.exists(MODEL_DT)
        }
    }
    
    # Add file modification times if models exist
    if info["logistic_regression"]["exists"]:
        mod_time = os.path.getmtime(MODEL_LR)
        info["logistic_regression"]["last_trained"] = datetime.fromtimestamp(mod_time).strftime("%Y-%m-%d %H:%M:%S")
    
    if info["decision_tree"]["exists"]:
        mod_time = os.path.getmtime(MODEL_DT)
        info["decision_tree"]["last_trained"] = datetime.fromtimestamp(mod_time).strftime("%Y-%m-%d %H:%M:%S")
    
    return info

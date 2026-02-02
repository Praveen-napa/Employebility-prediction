from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import StudentSerializer
from .modules import predict_employability, get_model_info
from django.shortcuts import render
import os

def home_view(request):
    """
    Renders the beautiful UI homepage
    """
    return render(request, 'index.html')

class EmployabilityPredictionView(APIView):
    """
    API endpoint for employability prediction
    
    GET: Returns API information and usage instructions
    POST: Makes employability predictions for a student
    """

    def get(self, request):
        """
        Returns API information, model details, and usage instructions
        """
        return Response({
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
                    "cgpa": "float (0.0 - 10) - Grade Point Average",
                    "aptitude_score": "float (0 - 100) - Aptitude test score",
                    "coding_skill": "float (0 - 10) - Coding skill rating",
                    "communication": "float (0 - 10) - Communication skill rating",
                    "internships": "integer (0+) - Number of internships"
                },
                "example_request": {
                    "cgpa": 8.5,
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
            "models": get_model_info()
        }, status=status.HTTP_200_OK)

    def post(self, request):
        """
        Makes employability prediction for a student
        """
        serializer = StudentSerializer(data=request.data)

        if serializer.is_valid():
            result = predict_employability(serializer.validated_data)
            return Response(result, status=status.HTTP_200_OK)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ModelInfoView(APIView):
    """
    API endpoint for model information
    """

    def get(self, request):
        """
        Returns detailed information about the trained models
        """
        model_info = get_model_info()
        return Response(model_info, status=status.HTTP_200_OK)


class SampleDataView(APIView):
    """
    API endpoint for sample data
    """

    def get(self, request):
        """
        Returns sample student data for testing
        """
        samples = {
            "high_performer": {
                "description": "Student with high academic performance and skills",
                "data": {
                    "cgpa": 9.2,
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
                    "cgpa": 7.5,
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
                    "cgpa": 5.5,
                    "aptitude_score": 55,
                    "coding_skill": 4,
                    "communication": 5,
                    "internships": 0
                },
                "expected_prediction": "Not Employable (0)"
            }
        }
        
        return Response({
            "message": "Sample student data for testing",
            "samples": samples,
            "usage": "Copy any 'data' object and POST to /api/employability/predict/"
        }, status=status.HTTP_200_OK)

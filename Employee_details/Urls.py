from django.urls import path
from .Views import EmployabilityPredictionView, ModelInfoView, SampleDataView

urlpatterns = [
    path('predict/', EmployabilityPredictionView.as_view(), name='predict-employability'),
    path('model-info/', ModelInfoView.as_view(), name='model-info'),
    path('sample/', SampleDataView.as_view(), name='sample-data'),
]

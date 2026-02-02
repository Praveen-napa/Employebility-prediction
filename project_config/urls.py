"""
URL configuration for employability prediction project.
"""
from django.urls import path, include
from Employee_details.Views import home_view

urlpatterns = [
    path('', home_view, name='home'),
    path('api/employability/', include('Employee_details.Urls')),
]

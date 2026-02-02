# Test script for GET methods

Write-Host "Testing Employability Prediction API - GET Methods" -ForegroundColor Cyan
Write-Host "==================================================`n" -ForegroundColor Cyan

# Test 1: Main API endpoint (GET)
Write-Host "1. Testing GET /api/employability/predict/" -ForegroundColor Yellow
try {
    $response1 = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Get
    Write-Host "Success!" -ForegroundColor Green
    Write-Host "Message: $($response1.message)" -ForegroundColor White
    Write-Host "Version: $($response1.version)" -ForegroundColor White
    Write-Host "`nAvailable Endpoints:" -ForegroundColor White
    $response1.endpoints.PSObject.Properties | ForEach-Object {
        Write-Host "  - $($_.Name): $($_.Value.url)" -ForegroundColor Gray
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n--------------------------------------------------`n"

# Test 2: Model Info endpoint
Write-Host "2. Testing GET /api/employability/model-info/" -ForegroundColor Yellow
try {
    $response2 = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/model-info/" -Method Get
    Write-Host "Success!" -ForegroundColor Green
    Write-Host "`nLogistic Regression Model:" -ForegroundColor White
    Write-Host "  Name: $($response2.logistic_regression.name)" -ForegroundColor Gray
    Write-Host "  Status: $(if ($response2.logistic_regression.exists) {'Trained'} else {'Not Found'})" -ForegroundColor Gray
    if ($response2.logistic_regression.last_trained) {
        Write-Host "  Last Trained: $($response2.logistic_regression.last_trained)" -ForegroundColor Gray
    }
    
    Write-Host "`nDecision Tree Model:" -ForegroundColor White
    Write-Host "  Name: $($response2.decision_tree.name)" -ForegroundColor Gray
    Write-Host "  Status: $(if ($response2.decision_tree.exists) {'Trained'} else {'Not Found'})" -ForegroundColor Gray
    if ($response2.decision_tree.last_trained) {
        Write-Host "  Last Trained: $($response2.decision_tree.last_trained)" -ForegroundColor Gray
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n--------------------------------------------------`n"

# Test 3: Sample Data endpoint
Write-Host "3. Testing GET /api/employability/sample/" -ForegroundColor Yellow
try {
    $response3 = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/sample/" -Method Get
    Write-Host "Success!" -ForegroundColor Green
    Write-Host "`nAvailable Sample Data:" -ForegroundColor White
    
    Write-Host "`n  High Performer:" -ForegroundColor Cyan
    Write-Host "    CGPA: $($response3.samples.high_performer.data.cgpa)" -ForegroundColor Gray
    Write-Host "    Aptitude: $($response3.samples.high_performer.data.aptitude_score)" -ForegroundColor Gray
    Write-Host "    Expected: $($response3.samples.high_performer.expected_prediction)" -ForegroundColor Gray
    
    Write-Host "`n  Average Student:" -ForegroundColor Cyan
    Write-Host "    CGPA: $($response3.samples.average_student.data.cgpa)" -ForegroundColor Gray
    Write-Host "    Aptitude: $($response3.samples.average_student.data.aptitude_score)" -ForegroundColor Gray
    Write-Host "    Expected: $($response3.samples.average_student.expected_prediction)" -ForegroundColor Gray
    
    Write-Host "`n  Low Performer:" -ForegroundColor Cyan
    Write-Host "    CGPA: $($response3.samples.low_performer.data.cgpa)" -ForegroundColor Gray
    Write-Host "    Aptitude: $($response3.samples.low_performer.data.aptitude_score)" -ForegroundColor Gray
    Write-Host "    Expected: $($response3.samples.low_performer.expected_prediction)" -ForegroundColor Gray
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n==================================================`n" -ForegroundColor Cyan
Write-Host "All GET method tests completed!" -ForegroundColor Green

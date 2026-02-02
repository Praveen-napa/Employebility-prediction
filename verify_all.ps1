# Complete API Verification Script

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  API VERIFICATION TEST" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$allPassed = $true

# Test 1: GET /predict/
Write-Host "Test 1: GET /api/employability/predict/" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Get
    if ($response.message -eq "Employability Prediction API") {
        Write-Host "  PASS - API info retrieved successfully" -ForegroundColor Green
    } else {
        Write-Host "  FAIL - Unexpected response" -ForegroundColor Red
        $allPassed = $false
    }
} catch {
    Write-Host "  FAIL - $($_.Exception.Message)" -ForegroundColor Red
    $allPassed = $false
}

# Test 2: GET /model-info/
Write-Host "`nTest 2: GET /api/employability/model-info/" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/model-info/" -Method Get
    if ($response.logistic_regression.exists -and $response.decision_tree.exists) {
        Write-Host "  PASS - Both models are trained" -ForegroundColor Green
        Write-Host "    LR trained: $($response.logistic_regression.last_trained)" -ForegroundColor Gray
        Write-Host "    DT trained: $($response.decision_tree.last_trained)" -ForegroundColor Gray
    } else {
        Write-Host "  FAIL - Models not found" -ForegroundColor Red
        $allPassed = $false
    }
} catch {
    Write-Host "  FAIL - $($_.Exception.Message)" -ForegroundColor Red
    $allPassed = $false
}

# Test 3: GET /sample/
Write-Host "`nTest 3: GET /api/employability/sample/" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/sample/" -Method Get
    if ($response.samples.high_performer -and $response.samples.average_student -and $response.samples.low_performer) {
        Write-Host "  PASS - Sample data retrieved" -ForegroundColor Green
    } else {
        Write-Host "  FAIL - Incomplete sample data" -ForegroundColor Red
        $allPassed = $false
    }
} catch {
    Write-Host "  FAIL - $($_.Exception.Message)" -ForegroundColor Red
    $allPassed = $false
}

# Test 4: POST /predict/ - High Performer
Write-Host "`nTest 4: POST /api/employability/predict/ (High Performer)" -ForegroundColor Yellow
try {
    $body = @{
        cgpa = 3.8
        aptitude_score = 90
        coding_skill = 9
        communication = 8
        internships = 3
    } | ConvertTo-Json
    
    $response = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Post -Body $body -ContentType "application/json"
    
    if ($response.logistic_regression -eq 1 -and $response.decision_tree -eq 1) {
        Write-Host "  PASS - Predicted as Employable (1, 1)" -ForegroundColor Green
    } else {
        Write-Host "  WARNING - Unexpected prediction ($($response.logistic_regression), $($response.decision_tree))" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  FAIL - $($_.Exception.Message)" -ForegroundColor Red
    $allPassed = $false
}

# Test 5: POST /predict/ - Low Performer
Write-Host "`nTest 5: POST /api/employability/predict/ (Low Performer)" -ForegroundColor Yellow
try {
    $body = @{
        cgpa = 2.5
        aptitude_score = 55
        coding_skill = 4
        communication = 5
        internships = 0
    } | ConvertTo-Json
    
    $response = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Post -Body $body -ContentType "application/json"
    
    if ($response.logistic_regression -eq 0 -and $response.decision_tree -eq 0) {
        Write-Host "  PASS - Predicted as Not Employable (0, 0)" -ForegroundColor Green
    } else {
        Write-Host "  WARNING - Unexpected prediction ($($response.logistic_regression), $($response.decision_tree))" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  FAIL - $($_.Exception.Message)" -ForegroundColor Red
    $allPassed = $false
}

# Test 6: POST /predict/ - Invalid Data
Write-Host "`nTest 6: POST /api/employability/predict/ (Invalid Data)" -ForegroundColor Yellow
try {
    $body = @{
        cgpa = 3.5
        # Missing required fields
    } | ConvertTo-Json
    
    $response = Invoke-RestMethod -Uri "http://localhost:8000/api/employability/predict/" -Method Post -Body $body -ContentType "application/json" -ErrorAction Stop
    Write-Host "  FAIL - Should have returned validation error" -ForegroundColor Red
    $allPassed = $false
} catch {
    if ($_.Exception.Response.StatusCode -eq 400) {
        Write-Host "  PASS - Validation error returned (400 Bad Request)" -ForegroundColor Green
    } else {
        Write-Host "  FAIL - Unexpected error: $($_.Exception.Message)" -ForegroundColor Red
        $allPassed = $false
    }
}

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
if ($allPassed) {
    Write-Host "  ALL TESTS PASSED!" -ForegroundColor Green
    Write-Host "  Your API is working perfectly!" -ForegroundColor Green
} else {
    Write-Host "  SOME TESTS FAILED" -ForegroundColor Red
    Write-Host "  Please check the errors above" -ForegroundColor Red
}
Write-Host "========================================`n" -ForegroundColor Cyan

# Display endpoints
Write-Host "Available Endpoints:" -ForegroundColor Cyan
Write-Host "  GET  http://localhost:8000/api/employability/predict/" -ForegroundColor White
Write-Host "  POST http://localhost:8000/api/employability/predict/" -ForegroundColor White
Write-Host "  GET  http://localhost:8000/api/employability/model-info/" -ForegroundColor White
Write-Host "  GET  http://localhost:8000/api/employability/sample/" -ForegroundColor White
Write-Host ""

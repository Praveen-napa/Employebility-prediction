# Test script for the Employability Prediction API

$url = "http://localhost:8000/api/employability/predict/"

# Test case 1: High Performer
Write-Host ""
Write-Host "Testing: High Performer" -ForegroundColor Cyan
$body1 = @{
    cgpa = 3.8
    aptitude_score = 90
    coding_skill = 9
    communication = 8
    internships = 3
} | ConvertTo-Json

try {
    $response1 = Invoke-RestMethod -Uri $url -Method Post -Body $body1 -ContentType "application/json"
    Write-Host "Success! Prediction complete" -ForegroundColor Green
    Write-Host "  Logistic Regression: $($response1.logistic_regression)"
    Write-Host "  Decision Tree: $($response1.decision_tree)"
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Test case 2: Average Student
Write-Host ""
Write-Host "Testing: Average Student" -ForegroundColor Cyan
$body2 = @{
    cgpa = 3.0
    aptitude_score = 70
    coding_skill = 6
    communication = 6
    internships = 1
} | ConvertTo-Json

try {
    $response2 = Invoke-RestMethod -Uri $url -Method Post -Body $body2 -ContentType "application/json"
    Write-Host "Success! Prediction complete" -ForegroundColor Green
    Write-Host "  Logistic Regression: $($response2.logistic_regression)"
    Write-Host "  Decision Tree: $($response2.decision_tree)"
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Test case 3: Low Performer
Write-Host ""
Write-Host "Testing: Low Performer" -ForegroundColor Cyan
$body3 = @{
    cgpa = 2.5
    aptitude_score = 55
    coding_skill = 4
    communication = 5
    internships = 0
} | ConvertTo-Json

try {
    $response3 = Invoke-RestMethod -Uri $url -Method Post -Body $body3 -ContentType "application/json"
    Write-Host "Success! Prediction complete" -ForegroundColor Green
    Write-Host "  Logistic Regression: $($response3.logistic_regression)"
    Write-Host "  Decision Tree: $($response3.decision_tree)"
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

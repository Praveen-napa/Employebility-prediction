"""
Script to train the employability prediction models
"""
import os
from modules import train_models

if __name__ == "__main__":
    # Get the path to sample data
    current_dir = os.path.dirname(os.path.abspath(__file__))
    csv_path = os.path.join(current_dir, "sample_data.csv")
    
    print("Training models...")
    result = train_models(csv_path)
    print(result)
    print(f"Models saved in: {current_dir}")

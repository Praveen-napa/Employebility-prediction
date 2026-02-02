from rest_framework import serializers

class StudentSerializer(serializers.Serializer):
    cgpa = serializers.FloatField()
    aptitude_score = serializers.FloatField()
    coding_skill = serializers.FloatField()
    communication = serializers.FloatField()
    internships = serializers.IntegerField()

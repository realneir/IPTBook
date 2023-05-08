from django.contrib.auth.models import User
from rest_framework import generics
from .models import UserProfile
from .serializers import UserProfileSerializer, UserRegistrationSerializer

class UserProfileListCreateView(generics.ListCreateAPIView):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer

class UserRegistrationView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserRegistrationSerializer

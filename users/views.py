from django.contrib.auth import authenticate
from django.contrib.auth.models import User
from rest_framework import generics, status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from .models import UserProfile
from .serializers import UserProfileSerializer, UserRegistrationSerializer
from rest_framework.permissions import AllowAny

class UserProfileListCreateView(generics.ListCreateAPIView):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer
    authentication_classes = []
    permission_classes = []

class UserRegistrationView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserRegistrationSerializer
    authentication_classes = []  # No authentication is required for registration
    permission_classes = []  # No permissions are required for registration

class LoginView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        user = authenticate(request, username=username, password=password)
        
        if user is not None:
            token, created = Token.objects.get_or_create(user=user)
            user_profile = UserProfile.objects.get(user=user)  # get the user profile
            return Response({
                'token': token.key,
                'user_id': user.pk,
                'user_profile_id': user_profile.pk,  # return the user profile id
                'email': user.email,
                'is_staff': user.is_staff,
            })
        else:
            return Response({'error': 'Invalid Credentials'}, status=status.HTTP_400_BAD_REQUEST)

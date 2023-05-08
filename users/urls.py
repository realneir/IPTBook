from django.urls import path
from .views import UserProfileListCreateView, UserRegistrationView

urlpatterns = [
    path('register/', UserRegistrationView.as_view(), name='user_registration'),
    path('', UserProfileListCreateView.as_view(), name='user_profile_list_create'),
]

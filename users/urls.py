from django.urls import path
from .views import UserProfileListCreateView, UserRegistrationView, LoginView

urlpatterns = [
    path('register/', UserRegistrationView.as_view(), name='user_registration'),
    path('login/', LoginView.as_view(), name='login'),
    path('', UserProfileListCreateView.as_view(), name='user_profile_list_create'),
]

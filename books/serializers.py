from rest_framework import serializers
from users.models import UserProfile
from .models import Book, Rental
from users.serializers import UserProfileSerializer

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = ('title', 'author', 'available_copies')

class RentalSerializer(serializers.ModelSerializer):
    user_profile = serializers.PrimaryKeyRelatedField(queryset=UserProfile.objects.all())
    book = serializers.PrimaryKeyRelatedField(queryset=Book.objects.all())

    class Meta:
        model = Rental
        fields = ('user_profile', 'book', 'rental_days', 'rental_date', 'price')

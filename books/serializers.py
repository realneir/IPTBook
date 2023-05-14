from rest_framework import serializers
from .models import Book, Rental
from users.serializers import UserProfileSerializer

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = ('title', 'author', 'available_copies')
        

class RentalSerializer(serializers.ModelSerializer):
    user_profile = UserProfileSerializer()
    book = BookSerializer()

    class Meta:
        model = Rental
        fields = ('user_profile', 'book', 'rental_days', 'rental_date', 'price')
        
    def create(self, validated_data):
        price_per_day = validated_data.pop('price_per_day')
        rental = Rental(**validated_data)
        rental.calculate_price(price_per_day)
        rental.save()
        return rental
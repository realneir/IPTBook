from django.db import models
from users.models import UserProfile

class Book(models.Model):
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=200)
    available_copies = models.IntegerField()

class Rental(models.Model):
    user_profile = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    book = models.ForeignKey(Book, on_delete=models.CASCADE)
    rental_days = models.IntegerField()
    rental_date = models.DateField(auto_now_add=True)
    price = models.DecimalField(max_digits=5, decimal_places=2)
    def calculate_price(self, price_per_day):
        self.price = self.rental_days * price_per_day
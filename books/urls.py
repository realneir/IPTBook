from django.urls import path
from .views import BookListCreateView, RentalListCreateView

urlpatterns = [
    path('', BookListCreateView.as_view(), name='book_list_create'),
    path('rentals/', RentalListCreateView.as_view(), name='rental_list_create'),
]

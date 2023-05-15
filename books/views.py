from rest_framework import generics
from rest_framework.authentication import TokenAuthentication
from .models import Book, Rental
from .serializers import BookSerializer, RentalSerializer

class BookListCreateView(generics.ListCreateAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer
    authentication_classes = []
    permission_classes = [] 

class RentalListCreateView(generics.ListCreateAPIView):
    queryset = Rental.objects.all()
    serializer_class = RentalSerializer
    authentication_classes = []
    permission_classes = [] 

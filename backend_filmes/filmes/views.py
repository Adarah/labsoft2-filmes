from rest_framework import generics

from .models import User, Movie, UserRating
from .serializers import UserSerializer, MovieSerializer, UserRatingSerializer


class ListUser(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class DetailUser(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class ListMovie(generics.ListCreateAPIView):
    queryset = Movie.objects.all()
    serializer_class = MovieSerializer


class DetailMovie(generics.RetrieveUpdateDestroyAPIView):
    queryset = Movie.objects.all()
    serializer_class = MovieSerializer


class ListUserRating(generics.ListCreateAPIView):
    queryset = UserRating.objects.all()
    serializer_class = UserRatingSerializer


class DetailUserRating(generics.RetrieveUpdateDestroyAPIView):
    queryset = UserRating.objects.all()
    serializer_class = UserRatingSerializer

# Create your views here.

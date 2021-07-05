from rest_framework import generics, filters
import django_filters.rest_framework

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
    filter_backends = [filters.SearchFilter]
    search_fields = ['id', 'title', 'year']


class DetailMovie(generics.RetrieveUpdateDestroyAPIView):
    queryset = Movie.objects.all()
    serializer_class = MovieSerializer


class UserRecommendations(generics.ListCreateAPIView):
    queryset = Movie.objects.all()
    serializer_class = MovieSerializer
    user_id = None

    def get_queryset(self):
        user = User.objects.get(pk=self.kwargs['user_id'])
        streamings = user.streamings.all()
        queryset = Movie.objects.filter(streamings__in=streamings)
        return queryset


class ListUserRating(generics.ListCreateAPIView):
    queryset = UserRating.objects.all()
    serializer_class = UserRatingSerializer


class DetailUserRating(generics.RetrieveUpdateDestroyAPIView):
    queryset = UserRating.objects.all()
    serializer_class = UserRatingSerializer

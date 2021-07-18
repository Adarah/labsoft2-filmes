from rest_framework import generics, filters
import django_filters.rest_framework
import random
from datetime import date

from .models import User, Movie, UserRating, RecommendationHistory
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

class SearchMovie(generics.ListCreateAPIView):
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

    def _check_past_recommendations(self, user, today):
        year = today.year
        month = today.month
        day = today.day
        user_id = user.id
        past_recommendation = RecommendationHistory.objects.filter(created_at__year=year,
                                                           created_at__month=month,
                                                           created_at__day=day,
                                                           user__id=user_id)
        return past_recommendation

    def get_queryset(self):
        user = User.objects.get(pk=self.kwargs['user_id'])
        today = date.today()
        past_recommendation = self._check_past_recommendations(user, today)
        if len(past_recommendation) > 0:
            movie_id = past_recommendation.first().movie.id
            return Movie.objects.filter(id=movie_id)
        streamings = user.streamings.all()
        queryset = Movie.objects.filter(streamings__in=streamings)
        index = random.randint(0, len(queryset)-2)
        queryset = queryset[index:index+1]
        movie = queryset[0]
        recommendation = RecommendationHistory(user=user, movie=movie, created_at=today)
        recommendation.save()
        return queryset

class UserPremieres(generics.ListCreateAPIView):
    queryset = Movie.objects.all()
    serializer_class = MovieSerializer

    def get_queryset(self):
        user = User.objects.get(pk=self.kwargs['user_id'])
        today = date.today()
        year = today.year
        streamings = user.streamings.all()
        queryset = Movie.objects.filter(streamings__in=streamings, year=year)
        return queryset

class ListUserRating(generics.ListCreateAPIView):
    queryset = UserRating.objects.all()
    serializer_class = UserRatingSerializer


class DetailUserRating(generics.RetrieveUpdateDestroyAPIView):
    queryset = UserRating.objects.all()
    serializer_class = UserRatingSerializer

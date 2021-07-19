from rest_framework import generics, filters
from django.http import HttpResponse
import django_filters.rest_framework
import random
from datetime import date

from .models import User, Movie, UserRating, RecommendationHistory
from .serializers import UserSerializer, MovieSerializer, UserRatingSerializer, SingleUserRatingSerializer


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
            movie_ids = []
            for recommendation in past_recommendation:
                movie_id = recommendation.movie.id
                movie_ids.append(movie_id)
            return Movie.objects.filter(id__in=movie_ids)
        streamings = user.streamings.all()
        queryset = Movie.objects.filter(streamings__in=streamings)
        index = random.randint(0, len(queryset)-5)
        queryset = queryset[index:index+4]
        movies = list(queryset)
        for movie in movies:
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

class DetailUserRating(generics.RetrieveUpdateDestroyAPIView):
    queryset = UserRating.objects.all()
    serializer_class = UserRatingSerializer
    lookup_field = 'user_id'

    def get_queryset(self):
        user = User.objects.get(pk=self.kwargs['user_id'])
        movie = Movie.objects.get(pk=self.kwargs['movie_id'])
        queryset = UserRating.objects.filter(user=user, movie=movie)
        return queryset

    def patch(self, request):
        return super().patch(request)

class ListUserRating(generics.ListCreateAPIView):
    queryset = UserRating.objects.all()
    serializer_class = UserRatingSerializer

    def get_queryset(self):
        if 'user_id' in self.kwargs:
            user = User.objects.get(pk=self.kwargs['user_id'])
            queryset = UserRating.objects.filter(user=user)
            return queryset
        else:
            return User.objects.all()

class PostUserRating(generics.ListCreateAPIView):
    queryset = UserRating.objects.all()
    serializer_class = SingleUserRatingSerializer

    def post(self, request, user_id):
        movie = Movie.objects.get(id=request.POST['movie'])
        user = User.objects.get(pk=user_id)
        rating = UserRating.objects.filter(user=user, movie=movie)
        if len(rating) > 0:
            return DetailUserRating(kwargs={'user_id':user_id,'movie_id':request.POST['movie']}, format_kwarg=None, request=request).patch(request)
        return super().post(request, user_id)
        

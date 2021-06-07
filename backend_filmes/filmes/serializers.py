from rest_framework import serializers
from .models import User, Movie, UserRating


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'username',
            'email',
            'age',
        )
        model = User

class MovieSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'imdb_id',
            'title',
            'release_year',
            'plot',
            'director',
            'rotten_rating',
            'metacritic_rating',
            'country',
        )
        model = Movie

class UserRatingSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'user',
            'movie',
            'rating',
            'review',
            'created_at'
        )

        model = UserRating
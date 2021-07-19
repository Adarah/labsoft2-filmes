from rest_framework import serializers

from .models import User, Movie, UserRating


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'username',
            'email',
            'streamings',
        )
        model = User


class MovieSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'url',
            'title',
            'runningTimeInMinutes',
            'year',
            'rating',
            'ratingCount',
            'topRank',
            'metaScore',
            'userScore',
            'currentRank',
            'genres',
            'tmdbRating',
            'countries',
            'cast',
            'significants',
            'overview',
            'tagline',
            'age',
            'originalLanguage',
            'streamings',
            'streamingLinks',
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
        depth = 1

from django.contrib.postgres.fields import ArrayField
from django.db import models


class StreamingService(models.Model):
    title = models.CharField(max_length=200, null=False, blank=False)
    img_url = models.TextField(max_length=200, null=False, blank=False)

    def __str__(self):
        return self.title


class User(models.Model):
    id = models.CharField(primary_key=True, null=False, blank=False, max_length=20)
    username = models.CharField(max_length=200, null=False, blank=False)
    email = models.CharField(max_length=200, null=False, blank=False)
    age = models.IntegerField(null=False, blank=False)
    streamings = models.ManyToManyField(StreamingService, blank=True)

    def __str__(self):
        return self.username


class Movie(models.Model):
    # dados retirados da API IMDB
    id = models.CharField(primary_key=True, null=False, blank=False, max_length=20)
    url = models.CharField(max_length=200, null=False, blank=False)
    title = models.CharField(max_length=200, null=False, blank=False)
    runningTimeInMinutes = models.IntegerField(null=False, blank=False)
    year = models.IntegerField(null=False, blank=False)
    rating = models.FloatField(null=True, blank=False)
    ratingCount = models.IntegerField(null=False, blank=False)
    topRank = models.IntegerField(null=False, blank=False)
    metaScore = models.IntegerField(null=True, blank=True)
    userScore = models.FloatField(null=True, blank=True)
    currentRank = models.IntegerField(null=True, blank=True)
    genres = ArrayField(models.CharField(max_length=200), null=True, blank=True)
    # dados retirados da API Streaming Results
    tmdbRating = models.IntegerField(null=True, blank=True)
    countries = ArrayField(models.CharField(max_length=200), null=True, blank=True)
    cast = ArrayField(models.CharField(max_length=200), null=True, blank=True)
    significants = ArrayField(models.CharField(max_length=200), null=True, blank=True)
    overview = models.TextField(null=True, blank=True)
    tagline = models.TextField(null=True, blank=True)
    age = models.IntegerField(null=True, blank=True)
    originalLanguage = models.CharField(max_length=200, null=True, blank=True)
    # estes campos deve ser processados
    streamings = models.ManyToManyField(StreamingService, blank=True)
    streamingLinks = ArrayField(models.CharField(max_length=200), null=True, blank=True)

    def __str__(self):
        return self.title


class UserRating(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    rating = models.FloatField()
    review = models.TextField()
    created_at = models.DateTimeField()

class RecommendationHistory(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    created_at = models.DateTimeField()
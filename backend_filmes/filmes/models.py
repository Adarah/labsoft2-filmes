from django.db import models

class User(models.Model):
    username = models.CharField(max_length=200, null=False, blank=False)
    email = models.CharField(max_length=200, null=False, blank=False)
    age = models.IntegerField()

    def __str__(self):
        return self.username

class Movie(models.Model):
    imdb_id = models.IntegerField(primary_key=True, null=False, blank=False)
    title = models.CharField(max_length=200, null=False, blank=False)
    release_year = models.IntegerField(null=False, blank=False)
    plot = models.TextField()
    director = models.CharField(max_length=200, null=False, blank=False)
    rotten_rating = models.IntegerField()
    metacritic_rating = models.IntegerField()
    country = models.CharField(max_length=200, null=False, blank=False)

    def __str__(self):
        return self.title

class UserRating(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    rating = models.FloatField()
    review = models.TextField()
    created_at = models.DateTimeField()


from django.db import models

class User(models.Model):
    username = models.CharField(max_length=200)
    email = models.CharField(max_length=200)
    age = models.IntegerField()

    def __str__(self):
        return self.username

# Create your models here.

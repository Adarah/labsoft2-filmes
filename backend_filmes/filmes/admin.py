from django.contrib import admin
from .models import User, Movie, UserRating, StreamingService

# Register your models here.

admin.site.register(User)
admin.site.register(Movie)
admin.site.register(UserRating)
admin.site.register(StreamingService)
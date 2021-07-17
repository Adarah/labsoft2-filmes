from django.contrib import admin

from .models import User, Movie, UserRating, StreamingService, RecommendationHistory

# Register your models here.

admin.site.register(User)
admin.site.register(Movie)
admin.site.register(UserRating)
admin.site.register(StreamingService)
admin.site.register(RecommendationHistory)

from django.urls import path
from django.conf.urls import url

from . import views

urlpatterns = [
    path('user', views.ListUser.as_view()),
    path('user/<pk>', views.DetailUser.as_view()),
    url(r'^recommendations/(?P<user_id>[0-9a-zA-Z-]+)$', views.UserRecommendations.as_view()),
    url(r'^premieres/(?P<user_id>[0-9a-zA-Z-]+)$', views.UserPremieres.as_view()),
    path('movie', views.ListMovie.as_view()),
    path('movie/<int:pk>', views.DetailMovie.as_view()),
    url('movie_search', views.SearchMovie.as_view()),
    url(r'^rating/(?P<user_id>[0-9a-zA-Z-]+)$', views.ListUserRating.as_view()),
    path('rating/<str:user_id>/<str:movie_id>', views.DetailUserRating.as_view())
]

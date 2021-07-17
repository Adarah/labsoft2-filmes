from django.conf.urls import url

from . import views

urlpatterns = [
    url('user', views.ListUser.as_view()),
    url('user/<pk>/', views.DetailUser.as_view()),
    url(r'^recommendations/(?P<user_id>[0-9a-zA-Z-]+)$', views.UserRecommendations.as_view()),
    url('movie', views.ListMovie.as_view()),
    url('movie/<int:pk>/', views.DetailMovie.as_view()),
    url('rating', views.ListUserRating.as_view()),
    url('rating/<int:pk>/', views.DetailUserRating.as_view()),
]

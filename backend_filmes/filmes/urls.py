from django.urls import path

from . import views

urlpatterns = [
    path('user', views.ListUser.as_view()),
    path('user/<int:pk>/', views.DetailUser.as_view()),
    path('movie', views.ListMovie.as_view()),
    path('movie/<int:pk>/', views.DetailMovie.as_view()),
    path('rating', views.ListUserRating.as_view()),
    path('rating/<int:pk>/', views.DetailUserRating.as_view()),
]
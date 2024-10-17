from django.urls import path
from . import views

urlpatterns = [
    path('popular/', views.PopularFoodList.as_view(), name='popular-list'),
    path('recommended/', views.RecommendedFoodList.as_view(), name='recommended-list'),
]

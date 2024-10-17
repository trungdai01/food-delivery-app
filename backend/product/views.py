import random
from django.db.models import Count
from rest_framework import generics, status
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import FoodSerializer
from .models import Food

# Create your views here.


class PopularFoodList(generics.ListAPIView):
    serializer_class = FoodSerializer
    queryset = Food.objects.filter(type_id=1)

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)

        response_data = {
            "total_size": queryset.count(),
            "type_id": 1,
            "offset": 0,
            "products": serializer.data,
        }
        return Response(response_data)


class RecommendedFoodList(generics.ListAPIView):
    serializer_class = FoodSerializer
    queryset = Food.objects.filter(type_id=2)

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)

        response_data = {
            "total_size": queryset.count(),
            "type_id": 2,
            "offset": 0,
            "products": serializer.data,
        }
        return Response(response_data)

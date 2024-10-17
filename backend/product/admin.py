from django.contrib import admin
from . import models

# Register your models here.


@admin.register(models.FoodType)
class FoodTypeAdmin(admin.ModelAdmin):
    list_display = ('id', 'title')


@admin.register(models.Food)
class FoodAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'type_id')

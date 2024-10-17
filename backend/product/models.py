from django.db import models
from django_extensions.db.models import TimeStampedModel
from django.core.validators import MinValueValidator, MaxValueValidator

# from utils import Model

# Create your models here.


class FoodType(TimeStampedModel, models.Model):

    class Meta:
        verbose_name_plural = "Food types"
        ordering = ['id']

    title = models.CharField(max_length=100, unique=True)
    description = models.CharField(max_length=255)

    def __str__(self) -> str:
        return self.title


class Food(TimeStampedModel, models.Model):

    class Meta:
        verbose_name = 'Food'
        ordering = ['created']

    name = models.CharField(max_length=100)
    description = models.CharField(max_length=5000)
    price = models.IntegerField(default=0, blank=False)
    stars = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)])
    img = models.ImageField(
        default='images/default_food_img.jpg',
        upload_to='images',
        null=True,
        blank=True,
    )
    location = models.CharField(max_length=100)
    type_id = models.ForeignKey(FoodType, on_delete=models.CASCADE)

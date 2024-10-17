# Generated by Django 5.1.2 on 2024-10-15 16:46

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('product', '0003_alter_food_img'),
    ]

    operations = [
        migrations.AlterField(
            model_name='food',
            name='price',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='food',
            name='stars',
            field=models.IntegerField(validators=[django.core.validators.MinValueValidator(1), django.core.validators.MaxValueValidator(5)]),
        ),
    ]

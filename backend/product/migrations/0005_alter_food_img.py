# Generated by Django 5.1.2 on 2024-10-15 16:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('product', '0004_alter_food_price_alter_food_stars'),
    ]

    operations = [
        migrations.AlterField(
            model_name='food',
            name='img',
            field=models.ImageField(blank=True, default='images/default_food_img.jpg', null=True, upload_to='images'),
        ),
    ]

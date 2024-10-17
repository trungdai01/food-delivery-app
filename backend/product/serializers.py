from rest_framework import serializers
from .models import Food, FoodType


class FoodSerializer(serializers.ModelSerializer):
    """
    SerializerMethodField() allows us to define method in our serializer to determine
    how the field should be represented. The method name must follow the format
    get_<field_name>
    """

    img = serializers.SerializerMethodField()

    def get_img(self, obj):
        """
        obj.img.url in this case will give the relative path to the media root.
        """
        if obj.img:
            full_url = obj.img.url
            return full_url.replace('/uploads/', '')
        return None

    class Meta:
        model = Food
        fields = (
            'id',
            'name',
            'description',
            'price',
            'stars',
            'img',
            'location',
            'created',
            'modified',
            'type_id',
        )

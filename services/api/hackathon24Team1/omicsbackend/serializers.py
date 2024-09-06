from rest_framework import serializers
from omicsbackend.models import *


class OrderSerializer(serializers.ModelSerializer):

    class Meta:
        model = Order
        exclude = ('id',)


class SampleSerializer(serializers.ModelSerializer):
    order = OrderSerializer()

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        order_obj = representation.pop('order')

        for key in order_obj:
            representation[key] = order_obj[key]

        return representation

    class Meta:
        model = Sample
        exclude = ('id',)


class SampleSerializerDeep(serializers.ModelSerializer):
    order = OrderSerializer()

    class Meta:
        model = Sample
        exclude = ('id', )

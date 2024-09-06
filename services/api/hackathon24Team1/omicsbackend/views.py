from django.db.models import Q, Count

from rest_framework import generics
from rest_framework.response import Response

from omicsbackend.models import Sample, Order
from omicsbackend.serializers import SampleSerializer
from omicsbackend.paginators import Paginator

import re


def get_q_objs(obj: dict):
    q_objects = Q()

    for key in obj.keys():
        if obj[key]:
            if obj[key][0] != '':
                if hasattr(Sample, key):
                        q_objects |= (Q(**{f'{key}__in': obj[key]}))
                elif hasattr(Order, key):
                        q_objects |= (Q(**{f'order__{key}__in': obj[key]}))

    return q_objects

class ListSamples(generics.GenericAPIView):
    serializer_class = SampleSerializer
    pagination_class = Paginator

    def get_queryset(self):
        queryset = Sample.objects.all()

        sortlist = ['-srm_sample']

        if 'sort_by' in self.request.data.keys():
            sortlist = []
            for sortval in self.request.data['sort_by']:
                if len(re.split(r'\.', sortval)) > 1:
                    column = re.split(r'\.', sortval)[0]

                    if hasattr(Order, column):
                        column = f'order__{column}'

                    direction = re.split(r'\.', sortval)[1]

                    if direction == 'asc':
                        sortlist.append(column)
                    if direction == 'desc':
                        sortlist.append('-' + column)

        if 'filters_depth1' in self.request.data.keys():
            q_objects = get_q_objs(self.request.data['filters_depth1'])
            queryset = queryset.filter(q_objects)

        if 'filters_depth2' in self.request.data.keys():
            q_objects = get_q_objs(self.request.data['filters_depth2'])
            queryset = queryset.filter(q_objects)

        queryset = queryset.order_by(*sortlist)

        return queryset

    def post(self, request, *args, **kwargs):
        print(request.data)

        queryset = self.filter_queryset(self.get_queryset())
        page = self.paginate_queryset(queryset)

        if page:
            serializerpage = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializerpage.data)

        nolimitset = self.get_serializer(queryset.filter()[:1000], many=True)

        if nolimitset:
            return Response({'results': nolimitset.data})

        else:
            return Response({})

class FilterValues(generics.GenericAPIView):

    def post(self, request, *args, **kwargs):
        print(request.data)

        queryset = Sample.objects.all()

        if 'filters' in request.data.keys():
            q_objects = get_q_objs(self.request.data['filters'])
            queryset = queryset.filter(q_objects)

        assays = queryset.values('assay').annotate(total=Count('assay')).order_by('assay')

        return Response(assays)

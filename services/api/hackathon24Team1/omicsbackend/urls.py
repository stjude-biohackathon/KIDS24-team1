from django.urls import path
from omicsbackend import views

urlpatterns = [
    path('listsamples/', views.ListSamples.as_view()),
    path('filtervalues/', views.FilterValues.as_view()),

]
import psutil
from django.http import HttpResponseServerError
from django.shortcuts import render


def index(request):
    names = []
    try:
        for user in psutil.users():
            names.append(user.name)
        context = {
            'names': names,
        }
        return render(request, 'index.html', context)
    except Exception:
        return HttpResponseServerError()

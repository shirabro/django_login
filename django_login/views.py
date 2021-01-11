
import psutil
from django.shortcuts import render


def index(request):
    names = []
    for user in psutil.users():
        names.append(user.name)
    context = {
        'names': names,
    }
    return render(request, 'index.html', context)


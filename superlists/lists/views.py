from django.shortcuts import redirect, render
from django.http import HttpResponse

from lists.models import Item, List


def home_page(request):
    return render(request, 'home.html')


def view_list(request, list_id):
    _list = List.objects.get(id=list_id)
    return render(request, 'list.html', {'list': _list})


def new_list(request):
    _list = List.objects.create()
    Item.objects.create(text=request.POST['item_text'], list=_list)
    return redirect('/lists/%d/' % (_list.id))


def add_item(request, list_id):
    _list = List.objects.get(id=list_id)
    Item.objects.create(text=request.POST['item_text'], list=_list)
    return redirect('/lists/%d/' % (_list.id,))

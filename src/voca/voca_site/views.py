from django.shortcuts import redirect, render
from .forms import LoginForm, PspageEditForm, SendMessageForm, ChangePasswordForm, SearchForm
from django.contrib.auth import login, logout
from voca_site.admin import UserCreationForm
from django.contrib.auth.decorators import login_required
from .models import Pspage, Univs, Position, UserUnivsAttend, UserUnivsGra, User, UserMessages, PspageUserVisit, Depart, Orgniza, SearchView
from django.core.exceptions import ObjectDoesNotExist
from django.urls import reverse
from django.shortcuts import get_object_or_404
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.forms.formsets import formset_factory
from itertools import repeat
from django.http.response import HttpResponse
import pymysql
from voca.settings import DATABASES


# Create your views here.


def home_page(request):

    return render(request, 'voca_site/home.html')


def cover_page(request):
    user = request.user
    if user.is_authenticated:
        try:
            user.my_pspage
        except ObjectDoesNotExist:
            pspage = Pspage(user=user, email=user.email)
            pspage.save
    return render(request, 'voca_site/cover.html')


def signin_page(request):

    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            user = form.cleaned_data.get('user')
            login(request, user)
            return redirect(reverse('cover'))
        else:
            return render(request, 'voca_site/signin.html', {'form': form})

    form = LoginForm()
    return render(request, 'voca_site/signin.html', {'form': form})


def signup_page(request):

    if request.method == 'POST' and request.user.is_authenticated() == False:
        form = UserCreationForm(request.POST)
        if form.is_valid():

            user = form.save()
            login(request, user)
            return redirect(reverse('success'))
        else:
            return render(request, 'voca_site/signup.html', {'form': form})

    form = UserCreationForm()
    return render(request, 'voca_site/signup.html', {'form': form})


def search_page(request):
    if request.method == "POST":
        return HttpResponse("Unexpected error occurred, please contact wbh_19981254@outlook.com")
    else:
        search_text = request.GET['search_text_']
        mydbinfo = DATABASES['default']
        mydb = pymysql.connect(
            mydbinfo['HOST'], mydbinfo['USER'], mydbinfo['PASSWORD'], mydbinfo['NAME'])
        cursor = mydb.cursor(cursor=pymysql.cursors.DictCursor)
        args = (search_text)
        proc = "procedure_search"
        cursor.callproc(proc, args=(search_text,))
        all_row = cursor.fetchall()
        # 建个空查询表
        set = SearchView.objects.filter(id=-1)

        for r in all_row:
            temp = SearchView.objects.filter(id=r['id'])
            set = set | temp
        cursor.close()
        mydb.close()
        result_list = set.all()
        result_list.order_by('id')
        paginator = Paginator(result_list, 6)
        page = request.GET.get('page')

        try:
            results = paginator.page(page)
        except PageNotAnInteger:
            # If page is not an integer, deliver first page.
            results = paginator.page(1)
        except EmptyPage:
            # If page is out of range (e.g. 9999), deliver last page of
            # results.
            results = paginator.page(paginator.num_pages)

        if request.user.is_authenticated():
            pspage = request.user.my_pspage
        else:
            pspage = None

        return render(request, 'voca_site/search.html', {'results': results, 'search_text': search_text, 'pspage': pspage})


@login_required
def change_password_page(request, user_id):
    user = User.objects.get(id=user_id)
    if request.user != user:
        return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))
    if request.method == 'POST':
        mypost = request.POST.copy()
        mypost['email_'] = user.email
        form = ChangePasswordForm(data=mypost)
        if form.is_valid():

            return redirect(reverse('password_change_success'))
        else:
            return render(request, 'voca_site/change_password.html', {'form': form, 'user_': user})

    form = ChangePasswordForm()
    return render(request, 'voca_site/change_password.html', {'form': form, 'user_': user})


@login_required
def operation_success_page(request):
    return render(request, 'voca_site/success.html')


def password_change_success_page(request):
    return render(request, 'voca_site/password_change_success.html')


@login_required
def log_out(request):
    logout(request)
    return render(request, 'voca_site/cover.html')


def personal_page(request, pspage_id_):
    pspage_ = get_object_or_404(Pspage, pspage_id=pspage_id_)
    if request.user != pspage_.user:
        pspage_.visitor_cnt += 1
        pspage_.save()
        if request.user.is_authenticated() == True:
            visit = PspageUserVisit(pspage=pspage_, user=request.user)
            visit.save()
    return render(request, 'voca_site/personal_page.html', {'pspage': pspage_})


@login_required
def pspage_update_page(request, pspage_id_):
    pspage_ = Pspage.objects.get(pspage_id=pspage_id_)
    user = pspage_.user
    user_haschange = False
    pspage_haschange = False
    gender = {1: '男', 2: '女', None: None}
    initial_data = {'email': pspage_.email,
                    'univs_attend': user.univs_attend.all(), 'univs_gra': user.univs_gra.all(),
                    'position': user.position, 'depart': user.depart, 'orgniza': user.orgniza, 'info': pspage_.info, 'gender': (user.gender, gender[user.gender])}
    if request.user != pspage_.user:
        return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))

    elif request.method == 'POST':
        genderset = {1: 1, 2: 2, '男': 1, '女': 2, '1': 1, '2': 2}

        form = PspageEditForm(request.POST, initial=initial_data)

        if form.is_valid() and form.has_changed():
            clean_data = form.clean()
            for data in form.changed_data:
                if data == 'email' or data == 'info' or data == 'joborein':
                    setattr(pspage_, data, clean_data.get(data))
                    pspage_haschange = True
                elif data == 'gender':
                    user.gender = genderset[clean_data.get(data)]
                    user_haschange = True
                elif data == 'univs_attend':
                    dataset = clean_data.get(data)
                    for d in dataset:
                        ua = UserUnivsAttend.objects.get_or_create(
                            user=user, univs=d)
                        if ua[1] == False:
                            ua[0].save()
                elif data == 'univs_gra':
                    dataset = clean_data.get(data)
                    for d in dataset:
                        ug = UserUnivsGra.objects.get_or_create(
                            user=user, univs=d)
                        if ug[1] == False:
                            ug[0].save()
                else:
                    setattr(user, data, clean_data.get(data))
                    user_haschange = True
            if user_haschange:
                user.save()
            if pspage_haschange:
                pspage_.save()
            return redirect(reverse('success'))
        else:
            return render(request, 'voca_site/pspage_update.html', {'form': form, 'pspage': pspage_})
    form = PspageEditForm(initial=initial_data)
    return render(request, 'voca_site/pspage_update.html', {'form': form, 'pspage': pspage_})


@login_required
def friend_page(request, pspage_id_):
    if request.method == 'GET':
        pspage_ = Pspage.objects.get(pspage_id=pspage_id_)
        user = pspage_.user
        if request.user != user:
            return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))

        friend_list = user.friend.all()
        paginator = Paginator(friend_list, 5)
        page = request.GET.get('page')

        try:
            friends = paginator.page(page)
        except PageNotAnInteger:
            # If page is not an integer, deliver first page.
            friends = paginator.page(1)
        except EmptyPage:
            # If page is out of range (e.g. 9999), deliver last page of
            # results.
            friends = paginator.page(paginator.num_pages)

        message_forms = []
        message_ = SendMessageForm()
        n = user.friend.all().count()
        for i in range(n):
            message_forms.append(message_)
        return render(request, 'voca_site/friend.html', {'pspage': pspage_, 'friends': friends, 'message_forms': message_forms})


@login_required
def friend_delete(request, pspage_id_, friend_id):
    if request.method == 'GET':
        return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))
    pspage_ = Pspage.objects.get(pspage_id=pspage_id_)
    user = pspage_.user
    user.friend.remove(User.objects.get(id=friend_id))
    return redirect(reverse('friend', args=[pspage_id_]))


@login_required
def delete_message(request, pspage_id_, message_id):
    if request.method == 'GET':
        return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))
    message_ = UserMessages.objects.get(id=message_id)
    message_.delete()

    return redirect(reverse('message', args=[pspage_id_]))


@login_required
def set_read_message(request, pspage_id_, message_id):
    if request.method == 'GET':
        return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))
    message_ = UserMessages.objects.get(id=message_id)
    message_.message_read = True
    message_.save()

    return redirect(reverse('message', args=[pspage_id_]))


@login_required
def set_to_read_message(request, pspage_id_, message_id):
    if request.method == 'GET':
        return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))
    message_ = UserMessages.objects.get(id=message_id)
    message_.message_read = False
    message_.save()

    return redirect(reverse('message', args=[pspage_id_]))


@login_required
def confirm_friend_apply(request, pspage_id_, message_id):
    if request.method == 'GET':
        return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))
    message_ = UserMessages.objects.get(id=message_id)
    pspage_ = Pspage.objects.get(pspage_id=pspage_id_)
    user = pspage_.user
    applyer = message_.message_sender
    user.friend.add(applyer)
    message_.delete()

    message_ = UserMessages(
        message_sender=user, message_receiver=applyer, message="我接受了你的申请，我们是朋友了！")
    message_.save()

    return redirect(reverse('success'))


@login_required
def friend_apply(request, pspage_id_):
    if request.method == 'GET':
        return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))
    pspage_ = Pspage.objects.get(pspage_id=pspage_id_)
    user = request.user
    apply_to = pspage_.user
    friend_apply_key = "ladskfjlaksdjflasijflienlknlknlaskdvklasjdklfj0192u091u2asjkdbk68a4df34a/sdf7-/70adlf;j02f0hisakbjkb"
    message_ = UserMessages(
        message_sender=user, message_receiver=apply_to, message=friend_apply_key)
    message_.save()

    return redirect(reverse('success'))


@login_required
def friend_add(request, pspage_id_):
    #     if request.method == 'GET':
    #         return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))
    #     pspage_ = Pspage.objects.get(pspage_id=pspage_id_)
    #     user = pspage_.user
    #     me = request.user
    #     me.friend.add(user)
    pass


@login_required
def send_message(request, pspage_id_, receiver_id):
    if request.method == 'GET':
        return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))
    pspage = Pspage.objects.get(pspage_id=pspage_id_)
    sender = pspage.user
    receiver = User.objects.get(id=receiver_id)
    form = SendMessageForm(request.POST)
    if form.is_valid():
        cleaned_data = form.clean()
        message_text = cleaned_data.get('message')
        message = UserMessages(message_sender=sender,
                               message_receiver=receiver, message=message_text)
        message.save()
        return redirect(reverse('success'))
    else:
        return redirect(reverse('friend', args=[pspage_id_]))


@login_required
def message_page(request, pspage_id_):
    if request.method == 'GET':
        pspage_ = Pspage.objects.get(pspage_id=pspage_id_)
        user = pspage_.user
        if request.user != user:
            return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))

        message_set = pspage_.get_message_set()

        paginator = Paginator(message_set, 10)
        page = request.GET.get('page')

        try:
            messages = paginator.page(page)
        except PageNotAnInteger:
            # If page is not an integer, deliver first page.
            messages = paginator.page(1)
        except EmptyPage:
            # If page is out of range (e.g. 9999), deliver last page of
            # results.
            messages = paginator.page(paginator.num_pages)

        friend_apply_key = "ladskfjlaksdjflasijflienlknlknlaskdvklasjdklfj0192u091u2asjkdbk68a4df34a/sdf7-/70adlf;j02f0hisakbjkb"

        message_forms = []
        message_ = SendMessageForm()
        n = message_set.count()
        for i in range(n):
            message_forms.append(message_)
        return render(request, 'voca_site/message.html', {'pspage': pspage_,
                                                          'messages': messages, 'message_forms': message_forms, 'friend_apply_key': friend_apply_key})


@login_required
def visitor_detail_page(request, pspage_id_):
    if request.method == 'GET':
        pspage_ = Pspage.objects.get(pspage_id=pspage_id_)
        user = pspage_.user
        if request.user != user:
            return redirect(reverse('pspage', args=[request.user.my_pspage.pspage_id]))

        visit_set = pspage_.clean_visit_record()
        paginator = Paginator(visit_set, 5)
        page = request.GET.get('page')

        try:
            visits = paginator.page(page)
        except PageNotAnInteger:
            # If page is not an integer, deliver first page.
            visits = paginator.page(1)
        except EmptyPage:
            # If page is out of range (e.g. 9999), deliver last page of
            # results.
            visits = paginator.page(paginator.num_pages)

        message_forms = []
        message_ = SendMessageForm()
        n = pspage_.visitor.all().count()

        for i in range(n):
            message_forms.append(message_)
        return render(request, 'voca_site/visitor_detail.html', {'pspage': pspage_, 'visits': visits, 'message_forms': message_forms})

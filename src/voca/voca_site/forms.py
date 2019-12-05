from django import forms
from django.contrib.auth import authenticate
from .models import User, Univs, Depart, Orgniza, Position
from django.utils.translation import ugettext as _
from django.forms.fields import ChoiceField
from django.forms.utils import ErrorList
from django.forms.forms import BaseForm


class LoginForm(forms.Form):

    email = forms.EmailField(required=True, label='Email', max_length=100, widget=forms.EmailInput(attrs={
                             'class': "form-control", 'required': 'autofocus'}))
    password = forms.CharField(
        required=True, label='Password', max_length=100, widget=forms.PasswordInput(attrs={
                             'class': "form-control", 'required': 'True'}))

    def clean(self):
        cleaned_data = super().clean()
        email_ = cleaned_data.get('email')
        password = cleaned_data.get('password')

        user = authenticate(email=email_, password=password)

        cleaned_data['user'] = user

        if user is None:
            email_set = User.objects.filter(email=email_)
            if email_set.count() == 0:
                msg = _("邮箱未注册!")
                self.add_error('email', msg)
            else:
                msg = _("密码错误!")
                self.add_error('password', msg)

        return cleaned_data


class PspageEditForm(forms.Form):

    email = forms.EmailField(required=True, label='Email', max_length=100, widget=forms.EmailInput(attrs={
        'class': "form-control"}))

    gender = forms. ChoiceField(
        required=True, label='性别', choices=[(1, '男'), (2, '女')], widget=forms.Select(attrs={
            'class': "form-control selectpicker"}))

    info = forms.CharField(required=False, label='个人简介', max_length=1000, widget=forms.Textarea(attrs={
        'class': "form-control"}))

    univs_attend = forms.ModelMultipleChoiceField(queryset=Univs.objects.all(), required=False, label='曾就读院校', widget=forms.SelectMultiple(attrs={
        'class': "form-control selectpicker",  'multiple data-live-search': "true", 'data-selected-text-format': "count > 3"}))

    univs_gra = forms.ModelMultipleChoiceField(queryset=Univs.objects.all(), required=False, label='毕业院校', widget=forms.SelectMultiple(attrs={
        'class': "form-control selectpicker",  'multiple data-live-search': "true", 'data-selected-text-format': "count > 3"}))

    position = forms.ModelChoiceField(queryset=Position.objects.all(), required=False, label='职位', widget=forms.Select(attrs={
        'class': "form-control selectpicker",  'multiple data-live-search': "true"}))

    orgniza = forms.ModelChoiceField(queryset=Orgniza.objects.all(), required=False, label='所属组织', widget=forms.Select(attrs={
        'class': "form-control selectpicker",  'multiple data-live-search': "true"}))

    depart = forms.ModelChoiceField(queryset=Depart.objects.all(), required=False, label='所属部门', widget=forms.Select(attrs={
        'class': "form-control selectpicker",  'multiple data-live-search': "true"}))

    joborein = forms.CharField(required=False, label='求职意向', max_length=700, widget=forms.Textarea(attrs={
        'class': "form-control"}))

    def clean(self):
        cleaned_data = super().clean()
        position = cleaned_data.get('position')
        joborein = cleaned_data.get('joborein')
        orgniza = cleaned_data.get('orgniza')
        depart = cleaned_data.get('depart')
        msg = _("职位或所属组织或部门存在的情况下，请不要填写求职意向")
        if joborein and joborein != '':
            if position is not None or orgniza is not None or depart is not None:
                self.add_error('joborein', msg)

        return cleaned_data


class SendMessageForm(forms.Form):

    message = forms.CharField(
        required=True, label='消息', max_length=100, widget=forms.Textarea())


class SearchForm(forms.Form):

    search_text = forms.CharField(
        required=True, label='', max_length=100, widget=forms.TextInput(attrs={'class': "form-control mr-sm-2", 'type': "text", 'placeholder': "Search",
                                                                               'aria-label': "Search"}))


class ChangePasswordForm(forms.Form):

    old_password = forms.CharField(
        required=True, label='旧密码', max_length=100, widget=forms.PasswordInput)
    password1 = forms.CharField(
        required=True, label='新密码', max_length=100, widget=forms.PasswordInput)
    password2 = forms.CharField(
        required=True, label='新密码确认', max_length=100, widget=forms.PasswordInput)

    def clean_password2(self):
        # Check that the two password entries match
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            self.add_error('password2', "密码不一致！")
        return password2

    def clean(self):
        cleaned_data = super().clean()
        old_password = cleaned_data.get('old_password')
        password1 = cleaned_data.get('new_password1')
        password2 = cleaned_data.get('new_password2')
        email_ = self.data['email_']
        user = User.objects.get(email=email_)

        user = authenticate(email=email_, password=old_password)
        if user is None:
            self.add_error('old_password', "旧密码错误！")
        else:
            user = User.objects.get(email=email_)
            user.set_password(cleaned_data["password1"])
            user.save()

        return cleaned_data

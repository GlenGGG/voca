# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or
# field names.
from __future__ import unicode_literals
from django.contrib.auth.models import (
    BaseUserManager, AbstractBaseUser
)
from django.db import models
from django.core import validators
from django.urls import reverse
import datetime


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()


class Depart(models.Model):
    name=models.CharField(max_length = 50, validators = [
        validators.RegexValidator(r'^[\w]+$',
                                  ('请不要包含特殊字符 '
                                   '输入英文或中文字符 .'), 'invalid'),
    ], unique = True)

    def __str__(self):
        return self.name


class Orgniza(models.Model):
    name=models.CharField(max_length = 50, blank = True, null = True, validators = [
        validators.RegexValidator(r'^[\w]+$',
                                  ('请不要包含特殊字符 '
                                   '输入英文或中文字符 .'), 'invalid'),
    ], unique = True)
    location=models.CharField(max_length = 100, blank = True, null = True, validators = [
                                validators.RegexValidator(r'^[\w]+$',
                                                          ('请不要包含特殊字符 '
                                                           '输入英文或中文字符 .'), 'invalid'),
                                ])

    def __str__(self):
        return self.name


class Position(models.Model):
    name=models.CharField(max_length = 15, validators = [
        validators.RegexValidator(r'^[\w]+$',
                                  ('请不要包含特殊字符 '
                                   '输入英文或中文字符 .'), 'invalid'),
    ], unique = True)

    def __str__(self):
        return self.name


class Univs(models.Model):
    univs_id=models.CharField(primary_key = True, max_length = 8)
    name=models.CharField(max_length = 50, validators = [
        validators.RegexValidator(r'^[\w]+$',
                                  ('请不要包含特殊字符 '
                                   '输入英文或中文字符 .'), 'invalid'),
    ], unique = True)

    def __str__(self):
        return self.name


class MyUserManager(BaseUserManager):
    def create_user(self, email, name, password = None):
        """
        Creates and saves a User with the given email and password.
        """
        if not email:
            raise ValueError('邮箱为必填项')

        user=self.model(
            email = self.normalize_email(email),
            name = name,
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, name, password):
        """
        Creates and saves a superuser with the given email, name and password.
        """
        user = self.create_user(email, name, password=password)
        user.is_admin = True
        user.save(using=self._db)
        return user


class User(AbstractBaseUser):
    email = models.EmailField(
        verbose_name='email address',
        max_length=255,
        unique=True,
    )
    # mysql using utf8mb4 supports a max length of 191
    name = models.CharField(max_length=30,
                            help_text=('请输入你的姓名.'),
                            validators=[
                                validators.RegexValidator(r'^[\w]+$',
                                                          ('请输入合法的姓名 '
                                                           '输入英文或中文字符 .'), 'invalid'),
                            ])
    choice_sex = (
        (1, '男'),
        (2, '女')
    )
    gender = models.IntegerField(choices=choice_sex, blank=True, null=True)
    friend = models.ManyToManyField(
        "self", blank=True, related_name='my_friend')
    date_of_register = models.DateField(auto_now_add=True)
    depart = models.ForeignKey(Depart, blank=True, null=True, default=None)
    orgniza = models.ForeignKey(
        Orgniza, blank=True, null=True, default=None)
    position = models.ForeignKey(
        Position, blank=True, null=True, default=None)
    univs_attend = models.ManyToManyField(
        Univs, blank=True, through='UserUnivsAttend', related_name='attend_students')
    univs_gra = models.ManyToManyField(
        Univs, blank=True, through='UserUnivsGra', related_name='gra_strudents')
    message_receiver = models.ManyToManyField(
        "self", blank=True, symmetrical=False, through='UserMessages', related_name='message_sender')
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    objects = MyUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name']

    def get_full_name(self):
        # The user is identified by their email address
        return self.email

    def get_short_name(self):
        # The user is identified by their email address
        return self.email

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        """Does the user have a specific permission?"""
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        """Does the user have permissions to view the app `app_label`?"""
        # Simplest possible answer: Yes, always
        return True

    def get_change_password_url(self):
        return reverse('change_password', args=[self.id])

    @property
    def is_staff(self):
        """Is the user a member of staff?"""
        # Simplest possible answer: All admins are staff
        return self.is_admin


class Pspage(models.Model):
    pspage_id = models.AutoField(primary_key=True)
    info = models.TextField(max_length=10000, blank=True, null=True)
    email = models.EmailField(
        verbose_name='email address in personal page',
        max_length=255,
    )
    joborein = models.TextField(max_length=800, blank=True, null=True)
    user = models.OneToOneField(
        'User', on_delete=models.CASCADE, related_name='my_pspage')
    visitor = models.ManyToManyField(
        User, through='PspageUserVisit', related_name='visitor_set')
    update_time = models.DateTimeField(auto_now=True)

    visitor_cnt = models.IntegerField(default=0)

    def __str__(self):
        return str(self.pspage_id)

    def get_absolut_url(self):
        return reverse('pspage', args=[self.pspage_id])

    def get_friend_url(self):
        return reverse('friend', args=[self.pspage_id])

    def get_edit_url(self):
        return reverse('pspage_update', args=[self.pspage_id])

    def get_message_url(self):
        return reverse('message', args=[self.pspage_id])

    def get_visitor_detail_url(self):
        return reverse('visitor_detail', args=[self.pspage_id])

    def get_message_sender_set(self):
        user = self.user
        message_sender_set = user.message_sender.all()
        return message_sender_set

    def get_message_set(self):
        message_set = UserMessages.objects.filter(
            message_receiver=self.user)
        friend_apply_key = "ladskfjlaksdjflasijflienlknlknlaskdvklasjdklfj0192u091u2asjkdbk68a4df34a/sdf7-/70adlf;j02f0hisakbjkb"
        message_friend_apply_set = message_set.filter(message=friend_apply_key)
        for message_ in message_friend_apply_set:
            if message_.message_sender in message_.message_receiver.friend.all():
                message_.delete()
        message_set = UserMessages.objects.filter(
            message_receiver=self.user)
        message_set = message_set.order_by('message_read',
                                           '-message_sent_time')

        return message_set

    def clean_visit_record(self):
        visit_set = PspageUserVisit.objects.filter(
            pspage=self).order_by('-visit_time')[30:]
        for v in visit_set:
            v.delete()
        visit_set = PspageUserVisit.objects.filter(
            pspage=self).order_by('-visit_time')

        return visit_set


class PspageUserVisit(models.Model):
    pspage = models.ForeignKey(Pspage, on_delete=models.CASCADE)
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    visit_time = models.DateTimeField(auto_now=True)

    class Meta:

        db_table = 'voca_site_pspage_user_visit'
        unique_together = (('pspage', 'user', 'visit_time'),)

    def __str__(self):
        return self.user.name + " visited " + self.pspage.user.name + "'s pspage" + "at " + str(self.visit_time)


class UserUnivsAttend(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    univs = models.ForeignKey(Univs, on_delete=models.CASCADE)
    enroll_time = models.DateTimeField(blank=True, null=True)

    class Meta:

        db_table = 'voca_site_user_univs_attend'
        unique_together = (('user', 'univs'),)

    def __str__(self):
        return self.user.name + " attended " + self.univs.name


class UserUnivsGra(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    univs = models.ForeignKey(Univs, on_delete=models.CASCADE)
    grad_time = models.DateTimeField(blank=True, null=True)

    class Meta:

        db_table = 'voca_site_user_univs_gra'
        unique_together = (('user', 'univs'),)

    def __str__(self):
        return self.user.name + " graduated from " + self.univs.name


class UserMessages(models.Model):
    message_sender = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='sent_messages')
    message_receiver = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='received_messages')
    message = models.TextField(max_length=1000, default='')
    message_sent_time = models.DateTimeField(
        auto_now_add=True)
    message_read = models.BooleanField(default=False)

    class Meta:

        db_table = 'voca_site_user_user_message'

    def __str__(self):
        return self.message_sender.name + " sent message to " + self.message_receiver.name + " at " + str(self.message_sent_time)


class SearchView(models.Model):
    id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=30, blank=True, null=True)
    email = models.EmailField(max_length=255, blank=True, null=True)
    info = models.TextField(max_length=1000, blank=True, null=True)
    joborein = models.TextField(max_length=800, blank=True, null=True)
    firm = models.CharField(max_length=50, blank=True, null=True)
    location = models.CharField(max_length=100, blank=True, null=True)
    pspage_id = models.IntegerField(blank=True, null=True)
    department = models.CharField(max_length=50, blank=True, null=True)
    position_name = models.CharField(max_length=15, blank=True, null=True)
    univs_name = models.CharField(max_length=50, blank=True, null=True)

    class Meta:

        db_table = 'voca_site_search_view_combine'
        managed = False

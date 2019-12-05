# -*- coding: utf-8 -*-
# Generated by Django 1.11.13 on 2018-07-08 23:37
from __future__ import unicode_literals

from django.conf import settings
import django.core.validators
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('email', models.EmailField(max_length=255, unique=True, verbose_name='email address')),
                ('name', models.CharField(help_text='请输入你的姓名.', max_length=30, validators=[django.core.validators.RegexValidator('^[\\w]+$', '请输入合法的姓名 输入英文或中文字符 .', 'invalid')])),
                ('gender', models.IntegerField(blank=True, choices=[(1, '男'), (2, '女')], null=True)),
                ('date_of_register', models.DateField(auto_now_add=True)),
                ('is_active', models.BooleanField(default=True)),
                ('is_admin', models.BooleanField(default=False)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Depart',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50, unique=True, validators=[django.core.validators.RegexValidator('^[\\w]+$', '请不要包含特殊字符 输入英文或中文字符 .', 'invalid')])),
            ],
        ),
        migrations.CreateModel(
            name='DjangoMigrations',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('app', models.CharField(max_length=255)),
                ('name', models.CharField(max_length=255)),
                ('applied', models.DateTimeField()),
            ],
        ),
        migrations.CreateModel(
            name='Orgniza',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, max_length=50, null=True, unique=True, validators=[django.core.validators.RegexValidator('^[\\w]+$', '请不要包含特殊字符 输入英文或中文字符 .', 'invalid')])),
                ('location', models.CharField(blank=True, max_length=100, null=True, validators=[django.core.validators.RegexValidator('^[\\w]+$', '请不要包含特殊字符 输入英文或中文字符 .', 'invalid')])),
            ],
        ),
        migrations.CreateModel(
            name='Position',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=15, unique=True, validators=[django.core.validators.RegexValidator('^[\\w]+$', '请不要包含特殊字符 输入英文或中文字符 .', 'invalid')])),
            ],
        ),
        migrations.CreateModel(
            name='Pspage',
            fields=[
                ('pspage_id', models.AutoField(primary_key=True, serialize=False)),
                ('info', models.TextField(blank=True, max_length=10000, null=True)),
                ('email', models.EmailField(max_length=255, verbose_name='email address in personal page')),
                ('joborein', models.TextField(blank=True, max_length=800, null=True)),
                ('update_time', models.DateTimeField(auto_now=True)),
                ('visitor_cnt', models.IntegerField(default=0)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='my_pspage', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='PspageUserVisit',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('visit_time', models.DateTimeField(auto_now=True)),
                ('pspage', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='voca_site.Pspage')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'voca_site_pspage_user_visit',
            },
        ),
        migrations.CreateModel(
            name='Univs',
            fields=[
                ('univs_id', models.CharField(max_length=8, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=50, unique=True, validators=[django.core.validators.RegexValidator('^[\\w]+$', '请不要包含特殊字符 输入英文或中文字符 .', 'invalid')])),
            ],
        ),
        migrations.CreateModel(
            name='UserMessages',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('message', models.TextField(default='', max_length=1000)),
                ('message_sent_time', models.DateTimeField(auto_now_add=True)),
                ('message_read', models.BooleanField(default=False)),
                ('message_receiver', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='received_messages', to=settings.AUTH_USER_MODEL)),
                ('message_sender', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sent_messages', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'voca_site_user_user_message',
            },
        ),
        migrations.CreateModel(
            name='UserUnivsAttend',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('enroll_time', models.DateTimeField(blank=True, null=True)),
                ('univs', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='voca_site.Univs')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'voca_site_user_univs_attend',
            },
        ),
        migrations.CreateModel(
            name='UserUnivsGra',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('grad_time', models.DateTimeField(blank=True, null=True)),
                ('univs', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='voca_site.Univs')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'voca_site_user_univs_gra',
            },
        ),
        migrations.AddField(
            model_name='pspage',
            name='visitor',
            field=models.ManyToManyField(related_name='visitor_set', through='voca_site.PspageUserVisit', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='user',
            name='depart',
            field=models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='voca_site.Depart'),
        ),
        migrations.AddField(
            model_name='user',
            name='friend',
            field=models.ManyToManyField(blank=True, related_name='_user_friend_+', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='user',
            name='message_receiver',
            field=models.ManyToManyField(blank=True, related_name='message_sender', through='voca_site.UserMessages', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='user',
            name='orgniza',
            field=models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='voca_site.Orgniza'),
        ),
        migrations.AddField(
            model_name='user',
            name='position',
            field=models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='voca_site.Position'),
        ),
        migrations.AddField(
            model_name='user',
            name='univs_attend',
            field=models.ManyToManyField(blank=True, related_name='attend_students', through='voca_site.UserUnivsAttend', to='voca_site.Univs'),
        ),
        migrations.AddField(
            model_name='user',
            name='univs_gra',
            field=models.ManyToManyField(blank=True, related_name='gra_strudents', through='voca_site.UserUnivsGra', to='voca_site.Univs'),
        ),
        migrations.AlterUniqueTogether(
            name='userunivsgra',
            unique_together=set([('user', 'univs')]),
        ),
        migrations.AlterUniqueTogether(
            name='userunivsattend',
            unique_together=set([('user', 'univs')]),
        ),
        migrations.AlterUniqueTogether(
            name='pspageuservisit',
            unique_together=set([('pspage', 'user', 'visit_time')]),
        ),
    ]
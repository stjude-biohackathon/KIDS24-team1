# Generated by Django 4.2.16 on 2024-09-05 14:28

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('omicsbackend', '0004_rename_humanderived_sample_ishumanderived'),
    ]

    operations = [
        migrations.AddField(
            model_name='sample',
            name='order',
            field=models.ForeignKey(default=9999999999999, on_delete=django.db.models.deletion.CASCADE, to='omicsbackend.order'),
            preserve_default=False,
        ),
    ]
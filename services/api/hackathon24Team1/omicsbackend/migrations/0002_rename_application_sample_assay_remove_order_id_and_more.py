# Generated by Django 4.2.16 on 2024-09-04 19:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('omicsbackend', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='sample',
            old_name='application',
            new_name='assay',
        ),
        migrations.RemoveField(
            model_name='order',
            name='id',
        ),
        migrations.RemoveField(
            model_name='sample',
            name='srm_order',
        ),
        migrations.AddField(
            model_name='order',
            name='srm_order',
            field=models.IntegerField(default=9999999999999, primary_key=True, serialize=False),
            preserve_default=False,
        ),
    ]
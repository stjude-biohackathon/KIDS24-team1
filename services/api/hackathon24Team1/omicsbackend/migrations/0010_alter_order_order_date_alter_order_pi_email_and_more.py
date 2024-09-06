# Generated by Django 4.2.16 on 2024-09-06 03:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('omicsbackend', '0009_alter_sample_assay'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='order_date',
            field=models.DateField(db_index=True),
        ),
        migrations.AlterField(
            model_name='order',
            name='pi_email',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='order',
            name='pi_firstname',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='order',
            name='pi_lastname',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='order',
            name='requestor_email',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='order',
            name='requestor_firstname',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='order',
            name='requestor_lastname',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='order',
            name='srm_order',
            field=models.IntegerField(db_index=True, unique=True),
        ),
        migrations.AlterField(
            model_name='sample',
            name='bampath',
            field=models.TextField(blank=True, db_index=True, null=True),
        ),
        migrations.AlterField(
            model_name='sample',
            name='ishumanderived',
            field=models.BooleanField(db_index=True),
        ),
        migrations.AlterField(
            model_name='sample',
            name='readlength',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='sample',
            name='referencegenome',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='sample',
            name='runtype',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='sample',
            name='samplename',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='sample',
            name='sequencer',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='sample',
            name='sjuid_sample',
            field=models.CharField(blank=True, db_index=True, max_length=64, null=True),
        ),
        migrations.AlterField(
            model_name='sample',
            name='sjuid_subject',
            field=models.CharField(blank=True, db_index=True, max_length=64, null=True),
        ),
        migrations.AlterField(
            model_name='sample',
            name='srm_sample',
            field=models.IntegerField(db_index=True, unique=True),
        ),
        migrations.AlterField(
            model_name='sample',
            name='tb_number',
            field=models.CharField(db_index=True, max_length=64),
        ),
    ]

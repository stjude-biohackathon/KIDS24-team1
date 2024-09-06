from django.db import models


class Order(models.Model):
    srm_order = models.IntegerField(blank=False, null=False, unique=True, db_index=True)
    requestor_firstname = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    requestor_lastname = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    requestor_email = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    pi_firstname = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    pi_lastname = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    pi_email = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    order_date = models.DateField(blank=False, null=False, db_index=True)


class Sample(models.Model):
    order = models.ForeignKey(Order, related_name = 'samples', on_delete=models.CASCADE,
                              null=False, blank=False, db_index=True)
    srm_sample = models.IntegerField(blank=False, null=False, unique=True, db_index=True)
    samplename = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    assay = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    sequencer = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    runtype = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    readlength = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    referencegenome = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    ishumanderived = models.BooleanField(blank=False, null=False, db_index=True)
    tb_number = models.CharField(max_length=64, blank=False, null=False, db_index=True)
    sjuid_sample = models.CharField(max_length=64, blank=True, null=True, db_index=True)
    sjuid_subject = models.CharField(max_length=64, blank=True, null=True, db_index=True)
    compbioid = models.CharField(max_length=64, blank=True, null=True, db_index=True)
    bampath = models.TextField(blank=True, null=True, db_index=True)

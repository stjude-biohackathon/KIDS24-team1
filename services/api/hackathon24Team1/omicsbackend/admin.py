from django.contrib import admin
from .models import *
from import_export.admin import ImportExportModelAdmin


@admin.register(Sample)
class SampleAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('id', 'srm_sample', 'samplename', 'assay', 'sequencer', 'runtype', 'readlength', 'compbioid',
                    'referencegenome', 'ishumanderived', 'tb_number', 'sjuid_subject', 'sjuid_sample', 'bampath')
    search_fields = ('id', 'srm_sample', 'samplename', 'assay', 'sequencer', 'runtype', 'readlength', 'compbioid',
                    'referencegenome', 'ishumanderived', 'tb_number', 'sjuid_subject', 'sjuid_sample', 'bampath')


@admin.register(Order)
class OrderAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('id', 'srm_order', 'requestor_firstname', 'requestor_lastname', 'requestor_email', 'pi_firstname',
                    'pi_lastname', 'pi_email', 'order_date')
    search_fields = ('id', 'srm_order', 'requestor_firstname', 'requestor_lastname', 'requestor_email', 'pi_firstname',
                     'pi_lastname', 'pi_email', 'order_date')

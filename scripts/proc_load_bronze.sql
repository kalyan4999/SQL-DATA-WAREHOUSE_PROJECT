
CREATE OR ALTER PROCEDURE bronze.load_bronze as
BEGIN
    declare @start_time datetime,@end_time datetime,@batch_start_time Datetime,@batch_end_time Datetime;
    begin try
    SET NOCOUNT ON;
    set @batch_start_time=GETDATE()
    print'========================================';
    print'loading bronze layer';
    print'========================================';

    print'----------------------------------------';
    print 'loading crm tables';
    print'----------------------------------------';

    set @start_time=GETDATE();
    print'>Truncating Table into:bronze.crm_cust_info'
    TRUNCATE TABLE bronze.crm_cust_info;
    print'Insering Data into:bronze.crm_cust_info'
    BULK INSERT bronze.crm_cust_info
    FROM 'C:\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );
    set @end_time=GETDATE();
    PRINT'>>Load Duration:'+ cast(datediff(second,@start_time,@end_time) as nvarchar)+ 'seconds';
    print'>>--------------';

    set @start_time=GETDATE();
     print'>Truncating Table into:bronze.crm_prd_info'
    TRUNCATE TABLE bronze.crm_prd_info;
    print'Insering Data into:bronze.crm_prd_info'
    BULK INSERT bronze.crm_prd_info
    FROM 'C:\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );
    set @end_time=GETDATE();
    print'>>Load Duration:'+ cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';


     set @start_time=GETDATE();
     print'>Truncating Table into:bronze.crm_sls_info'
    TRUNCATE TABLE bronze.crm_sls_info;
     print'Insering Data into:bronze.crm_sls_info'
    BULK INSERT bronze.crm_sls_info
    FROM 'C:\sql-data-warehouse-project\datasets\source_crm\sls_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );
    set @end_time=GETDATE();
    print'>> Load Duration:'+  cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';

    print'----------------------------------------';
    print 'loading erp tables';
    print'----------------------------------------';


    set @start_time=GETDATE();
    print'>Truncating Table into:bronze.erp_cust_az12'
    TRUNCATE TABLE bronze.erp_cust_az12;
     print'Insering Data into:bronze.erp_cust_az12'
    BULK INSERT bronze.erp_cust_az12
    FROM 'C:\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );
    set @end_time=GETDATE();
    print'>> Load Duration:'+   cast (datediff(second,@start_time,@end_time) as nvarchar)+'seconds';


    set @start_time=GETDATE();
    print'>Truncating Table into:bronze.erp_loc_a101'
    TRUNCATE TABLE bronze.erp_loc_a101;
    print'Insering Data into: bronze.erp_loc_a101'
    BULK INSERT bronze.erp_loc_a101
    FROM 'C:\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );
    set @end_time=GETDATE();
    print'>> Load Duration:'+ cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';



    set @start_time=GETDATE();
     print'>Truncating Table into:bronze.erp_px_cat_g1v2'
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    print'Insering Data into: bronze.erp_px_cat_g1v2'
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'C:\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );
    set @end_time=GETDATE();
    print'>>Load Duration:' + cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';

    set @batch_end_time=getdate();
    print'=============================='
    print 'Loading Bronze Layer is Completed';
    print '  - total Load Duration:' + cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar)+'seconds';
    print'=============================='
    end try
    begin catch
        print'========================';
        print'error occured during loading bronze layer'
        print'error message'+ error_message();
        print'error message'+ cast(error_number() as nvarchar);
        print'========================';
    end catch
END;
GO

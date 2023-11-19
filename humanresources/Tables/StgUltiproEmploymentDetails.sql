﻿CREATE TABLE [humanresources].[StgUltiproEmploymentDetails] (
    companyID VARCHAR(10)
    , companyCode VARCHAR(10)
    , companyName VARCHAR(50)
    , employeeID VARCHAR(15)
    , jobDescription VARCHAR(250)
    , payGroupDescription VARCHAR(100)
    , primaryJobCode VARCHAR(20)
    , orgLevel1Code VARCHAR(20)
    , orgLevel2Code VARCHAR(20)
    , orgLevel3Code VARCHAR(20)
    , orgLevel4Code VARCHAR(20)
    , originalHireDate DATETIME
    , lastHireDate DATETIME
    , fullTimeOrPartTimeCode VARCHAR(10)
    , primaryWorkLocationCode VARCHAR(10)
    , languageCode VARCHAR(5)
    , primaryProjectCode VARCHAR(20)
    , workPhoneNumber VARCHAR(20)
    , workPhoneExtension VARCHAR(20)
    , workPhoneCountry VARCHAR(20)
    , dateInJob DATETIME
    , dateLastWorked DATETIME
    , dateOfBenefitSeniority DATETIME
    , dateOfSeniority DATETIME
    , deductionGroupCode VARCHAR(10)
    , earningGroupCode VARCHAR(10)
    , employeeTypeCode VARCHAR(10)
    , employeeStatusCode VARCHAR(5)
    , employeeNumber VARCHAR(10)
    , jobChangeReasonCode VARCHAR(10)
    , jobTitle VARCHAR(250)
    , leaveReasonCode VARCHAR(20)
    , supervisorID VARCHAR(15)
    , supervisorFirstName VARCHAR(100)
    , supervisorLastName VARCHAR(100)
    , autoAllocate VARCHAR(20)
    , clockCode VARCHAR(20)
    , dateLastPayDatePaid DATETIME
    , dateOfEarlyRetirement DATETIME
    , dateOfLocalUnion DATETIME
    , dateOfNationalUnion DATETIME
    , dateOfRetirement DATETIME
    , dateOfSuspension DATETIME
    , dateOfTermination DATETIME
    , datePaidThru DATETIME
    , statusStartDate DATETIME
    , hireSource VARCHAR(50)
    , isAutoAllocated VARCHAR(5)
    , isAutopaid VARCHAR(5)
    , isMultipleJob VARCHAR(5)
    , jobGroupCode VARCHAR(20)
    , mailstop VARCHAR(250)
    , okToRehire VARCHAR(5)
    , payGroup VARCHAR(10)
    , payPeriod VARCHAR(10)
    , plannedLeaveReason VARCHAR(250)
    , positionCode VARCHAR(20)
    , salaryOrHourly VARCHAR(5)
    , scheduledAnnualHrs FLOAT
    , scheduledFTE FLOAT
    , scheduledWorkHrs FLOAT
    , shift VARCHAR(15)
    , shiftGroup VARCHAR(15)
    , termReason VARCHAR(15)
    , terminationReasonDescription VARCHAR(250)
    , termType VARCHAR(15)
    , timeclockID VARCHAR(50)
    , unionLocal VARCHAR(50)
    , unionNational VARCHAR(50)
    , weeklyHours FLOAT
    , dateTimeCreated DATETIME
    , dateTimeChanged DATETIME
    , supervisorEmployeeNumber VARCHAR(50)
    , supervisorCOID VARCHAR(50)
    , supervisorCompanyCode VARCHAR(50)
    , companyGLSegment VARCHAR(50)
    , locationGLSegment VARCHAR(50)
    )
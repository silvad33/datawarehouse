﻿CREATE TABLE [dbo].[VendVendorV2Staging] (
    [ISOWNERDISABLED]                                        INT             NOT NULL,
    [ETHNICORIGINID]                                         NVARCHAR (15)   NOT NULL,
    [ISWOMANOWNER]                                           INT             NOT NULL,
    [ISVENDORLOCALLYOWNED]                                   INT             NOT NULL,
    [ISMINORITYOWNED]                                        INT             NOT NULL,
    [TAX1099FEDERALTAXID]                                    NVARCHAR (11)   NOT NULL,
    [ISSERVICEVETERANOWNED]                                  INT             NOT NULL,
    [DEFAULTLEDGERDIMENSIONDISPLAYVALUE]                     NVARCHAR (500)  NOT NULL,
    [DEFAULTOFFSETLEDGERACCOUNTDISPLAYVALUE]                 NVARCHAR (500)  NOT NULL,
    [ADDRESSBOOKS]                                           NVARCHAR (200)  NOT NULL,
    [ADDRESSLOCATIONROLES]                                   NVARCHAR (100)  NOT NULL,
    [VENDORPARTYTYPE]                                        NVARCHAR (13)   NOT NULL,
    [PRIMARYEMAILADDRESSPURPOSE]                             NVARCHAR (100)  NOT NULL,
    [PRIMARYFAXNUMBERPURPOSE]                                NVARCHAR (100)  NOT NULL,
    [PRIMARYPHONENUMBERPURPOSE]                              NVARCHAR (100)  NOT NULL,
    [PRIMARYTELEXPURPOSE]                                    NVARCHAR (100)  NOT NULL,
    [PRIMARYURLPURPOSE]                                      NVARCHAR (100)  NOT NULL,
    [COMPOSITIONSCHEME]                                      INT             NOT NULL,
    [FOREIGNVENDOR]                                          INT             NOT NULL,
    [GTAVENDOR]                                              INT             NOT NULL,
    [PREFERENTIALVENDOR]                                     INT             NOT NULL,
    [SSIVENDOR]                                              INT             NOT NULL,
    [NATUREOFASSESSEE]                                       INT             NOT NULL,
    [PANNUMBER]                                              NVARCHAR (10)   NOT NULL,
    [PANREFERENCENUMBER]                                     NVARCHAR (10)   NOT NULL,
    [PANSTATUS]                                              INT             NOT NULL,
    [SSIVALIDITYDATE]                                        DATETIME        NOT NULL,
    [TCSGROUP]                                               NVARCHAR (10)   NOT NULL,
    [TDSGROUP]                                               NVARCHAR (10)   NOT NULL,
    [ELECTRONICLOCATIONID]                                   NVARCHAR (30)   NOT NULL,
    [VENDORACCOUNTNUMBER]                                    NVARCHAR (20)   NOT NULL,
    [VENDORPAYMENTFINECODE]                                  NVARCHAR (10)   NOT NULL,
    [VENDORPAYMENTFINANCIALINTERESTCODE]                     NVARCHAR (10)   NOT NULL,
    [BIRTHPLACE]                                             NVARCHAR (60)   NOT NULL,
    [BIRTHCOUNTYCODE]                                        NVARCHAR (3)    NOT NULL,
    [RESIDENCEFOREIGNCOUNTRYREGIONID]                        NVARCHAR (10)   NOT NULL,
    [FISCALDOCUMENTINCOMECODE]                               NVARCHAR (10)   NOT NULL,
    [PRIMARYFACEBOOKPURPOSE]                                 NVARCHAR (100)  NOT NULL,
    [PRIMARYLINKEDINPURPOSE]                                 NVARCHAR (100)  NOT NULL,
    [PRIMARYTWITTERPURPOSE]                                  NVARCHAR (100)  NOT NULL,
    [DUNSNUMBER]                                             NVARCHAR (9)    NOT NULL,
    [ADDRESSCOUNTRYREGIONISOCODE]                            NVARCHAR (2)    NOT NULL,
    [DEFINITIONGROUP]                                        NVARCHAR (60)   NOT NULL,
    [EXECUTIONID]                                            NVARCHAR (90)   NOT NULL,
    [ISSELECTED]                                             INT             NOT NULL,
    [TRANSFERSTATUS]                                         INT             NOT NULL,
    [WITHHOLDINGTAXGROUPCODE]                                NVARCHAR (10)   NOT NULL,
    [DEFAULTPAYMENTTERMSNAME]                                NVARCHAR (10)   NOT NULL,
    [LINEDISCOUNTVENDORGROUPCODE]                            NVARCHAR (10)   NOT NULL,
    [BANKACCOUNTID]                                          NVARCHAR (10)   NOT NULL,
    [CENTRALBANKPURPOSECODE]                                 NVARCHAR (10)   NOT NULL,
    [CENTRALBANKPURPOSETEXT]                                 NVARCHAR (140)  NOT NULL,
    [HASONLYTAKENBIDS]                                       INT             NOT NULL,
    [ONHOLDSTATUS]                                           INT             NOT NULL,
    [VENDORHOLDRELEASEDATE]                                  DATETIME        NOT NULL,
    [CASHDISCOUNTCODE]                                       NVARCHAR (10)   NOT NULL,
    [ISPURCHASEORDERCHANGEREQUESTOVERRIDEALLOWED]            INT             NOT NULL,
    [ISCHANGEMANAGEMENTACTIVATED]                            INT             NOT NULL,
    [ISCHANGEMANGEMENTOVERRIDEBYVENDORALLOWED]               INT             NOT NULL,
    [CISCOMPANYREGISTRATIONNUMBER]                           NVARCHAR (8)    NOT NULL,
    [CISNATIONALINSURANCENUMBER]                             NVARCHAR (9)    NOT NULL,
    [CISSTATUS]                                              INT             NOT NULL,
    [CISUNIQUETAXPAYERREFERENCE]                             NVARCHAR (10)   NOT NULL,
    [CISVERIFICATIONDATE]                                    DATETIME        NOT NULL,
    [CISVERIFICATIONNUMBER]                                  NVARCHAR (13)   NOT NULL,
    [CLEARINGPERIODPAYMENTTERMSID]                           NVARCHAR (10)   NOT NULL,
    [COMMERCIALREGISTERNAME]                                 NVARCHAR (40)   NOT NULL,
    [COMMERCIALREGISTERINSETNUMBER]                          NVARCHAR (10)   NOT NULL,
    [COMMERCIALREGISTERSECTION]                              NVARCHAR (10)   NOT NULL,
    [COMPANYCHAINNAME]                                       NVARCHAR (20)   NOT NULL,
    [SIRETNUMBER]                                            NVARCHAR (14)   NOT NULL,
    [COMPANYTYPE]                                            INT             NOT NULL,
    [PRIMARYCONTACTPERSONID]                                 NVARCHAR (20)   NOT NULL,
    [CREDITLIMIT]                                            NUMERIC (32, 6) NOT NULL,
    [CREDITRATING]                                           NVARCHAR (10)   NOT NULL,
    [UNIQUEPOPULATIONREGISTRYCODE]                           NVARCHAR (18)   NOT NULL,
    [CURRENCYCODE]                                           NVARCHAR (3)    NOT NULL,
    [TAX1099DOINGBUSINESSASNAME]                             NVARCHAR (60)   NOT NULL,
    [DEFAULTINVENTORYSTATUSID]                               NVARCHAR (10)   NOT NULL,
    [DESTINATIONCODE]                                        NVARCHAR (10)   NOT NULL,
    [DIOTCOUNTRYCODE]                                        NVARCHAR (10)   NOT NULL,
    [DEFAULTDELIVERYMODEID]                                  NVARCHAR (10)   NOT NULL,
    [DEFAULTDELIVERYTERMSCODE]                               NVARCHAR (10)   NOT NULL,
    [DEFAULTTOTALDISCOUNTVENDORGROUPCODE]                    NVARCHAR (10)   NOT NULL,
    [FACTORINGVENDORACCOUNTNUMBER]                           NVARCHAR (20)   NOT NULL,
    [FISCALCODE]                                             NVARCHAR (16)   NOT NULL,
    [ISFOREIGNENTITY]                                        INT             NOT NULL,
    [FOREIGNVENDORTAXREGISTRATIONID]                         NVARCHAR (40)   NOT NULL,
    [UPSFREIGHTZONE]                                         NVARCHAR (10)   NOT NULL,
    [ISVENDORLOCATEDINHUBZONE]                               INT             NOT NULL,
    [AREPRICESINCLUDINGSALESTAX]                             INT             NOT NULL,
    [DEFAULTPROCUMENTWAREHOUSEID]                            NVARCHAR (10)   NOT NULL,
    [DEFAULTPURCHASESITEID]                                  NVARCHAR (10)   NOT NULL,
    [INVOICEVENDORACCOUNTNUMBER]                             NVARCHAR (20)   NOT NULL,
    [BUYERGROUPID]                                           NVARCHAR (10)   NOT NULL,
    [LINEOFBUSINESSID]                                       NVARCHAR (10)   NOT NULL,
    [CHARGEVENDORGROUPID]                                    NVARCHAR (10)   NOT NULL,
    [VENDORINVOICELINEMATCHINGPOLICY]                        INT             NOT NULL,
    [NOTES]                                                  NVARCHAR (MAX)  NULL,
    [MULTILINEDISCOUNTVENDORGROUPCODE]                       NVARCHAR (10)   NOT NULL,
    [NAMECONTROL]                                            NVARCHAR (4)    NOT NULL,
    [NATIONALITY]                                            NVARCHAR (50)   NOT NULL,
    [NUMBERSEQUENCEGROUPID]                                  NVARCHAR (10)   NOT NULL,
    [DEFAULTOFFSETACCOUNTTYPE]                               INT             NOT NULL,
    [ISONETIMEVENDOR]                                        INT             NOT NULL,
    [DIOTOPERATIONTYPE]                                      INT             NOT NULL,
    [NATIONALREGISTRYNUMBERID]                               NVARCHAR (10)   NOT NULL,
    [DEFAULTPAYMENTDAYNAME]                                  NVARCHAR (10)   NOT NULL,
    [PAYMENTID]                                              NVARCHAR (200)  NOT NULL,
    [DEFAULTVENDORPAYMENTMETHODNAME]                         NVARCHAR (10)   NOT NULL,
    [DEFAULTPAYMENTSCHEDULENAME]                             NVARCHAR (30)   NOT NULL,
    [PAYMENTSPECIFICATIONID]                                 NVARCHAR (10)   NOT NULL,
    [PRICEVENDORGROUPID]                                     NVARCHAR (10)   NOT NULL,
    [WILLPURCHASEORDERINCLUDEPRICESANDAMOUNTS]               INT             NOT NULL,
    [PURCHASEWORKCALENDARID]                                 NVARCHAR (10)   NOT NULL,
    [DEFAULTPURCHASEORDERPOOLID]                             NVARCHAR (10)   NOT NULL,
    [RFCFEDERALTAXNUMBER]                                    NVARCHAR (13)   NOT NULL,
    [ISFLAGGEDWITHSECONDTIN]                                 INT             NOT NULL,
    [BUSINESSSEGMENTCODE]                                    NVARCHAR (20)   NOT NULL,
    [ISSMALLBUSINESS]                                        INT             NOT NULL,
    [STATEINSCRIPTION]                                       NVARCHAR (30)   NOT NULL,
    [BUSINESSSUBSEGMENTCODE]                                 NVARCHAR (20)   NOT NULL,
    [DEFAULTSUPPLEMENTARYPRODUCTVENDORGROUPID]               NVARCHAR (10)   NOT NULL,
    [PURCHASEREBATEVENDORGROUPID]                            NVARCHAR (20)   NOT NULL,
    [TAX1099NAMETOUSE]                                       INT             NOT NULL,
    [ISREPORTINGTAX1099]                                     INT             NOT NULL,
    [SALESTAXGROUPCODE]                                      NVARCHAR (10)   NOT NULL,
    [TAX1099IDTYPE]                                          INT             NOT NULL,
    [ISWITHHOLDINGTAXCALCULATED]                             INT             NOT NULL,
    [DEFAULTCASHDISCOUNTUSAGE]                               INT             NOT NULL,
    [TAXEXEMPTNUMBER]                                        NVARCHAR (20)   NOT NULL,
    [VENDORGROUPID]                                          NVARCHAR (10)   NOT NULL,
    [PRODUCTDESCRIPTIONVENDORGROUPID]                        NVARCHAR (10)   NOT NULL,
    [DIOTVENDORTYPE]                                         INT             NOT NULL,
    [VENDORPRICETOLERANCEGROUPID]                            NVARCHAR (10)   NOT NULL,
    [ISW9RECEIVED]                                           INT             NOT NULL,
    [ISW9CHECKINGENABLED]                                    INT             NOT NULL,
    [OURACCOUNTNUMBER]                                       NVARCHAR (20)   NOT NULL,
    [NAFCODE]                                                NVARCHAR (5)    NOT NULL,
    [VENDORINVOICEDECLARATIONID]                             NVARCHAR (10)   NOT NULL,
    [PAYMENTTRANSACTIONCODE]                                 NVARCHAR (2)    NOT NULL,
    [MAINCONTACTPERSONNELNUMBER]                             NVARCHAR (25)   NOT NULL,
    [TAX1099BOXID]                                           NVARCHAR (10)   NOT NULL,
    [TAX1099TYPE]                                            INT             NOT NULL,
    [VENDOREXCEPTIONGROUPID]                                 NVARCHAR (10)   NOT NULL,
    [ADDRESSDESCRIPTION]                                     NVARCHAR (60)   NOT NULL,
    [ADDRESSCITY]                                            NVARCHAR (60)   NOT NULL,
    [ADDRESSCOUNTRYREGIONID]                                 NVARCHAR (10)   NOT NULL,
    [ADDRESSCOUNTYID]                                        NVARCHAR (10)   NOT NULL,
    [ADDRESSDISTRICTNAME]                                    NVARCHAR (60)   NOT NULL,
    [ADDRESSLATITUDE]                                        NUMERIC (32, 6) NOT NULL,
    [ADDRESSLOCATIONID]                                      NVARCHAR (30)   NOT NULL,
    [ADDRESSLONGITUDE]                                       NUMERIC (32, 6) NOT NULL,
    [ADDRESSSTATEID]                                         NVARCHAR (10)   NOT NULL,
    [ADDRESSSTREET]                                          NVARCHAR (250)  NOT NULL,
    [ADDRESSBUILDINGCOMPLIMENT]                              NVARCHAR (60)   NOT NULL,
    [ADDRESSSTREETNUMBER]                                    NVARCHAR (20)   NOT NULL,
    [ADDRESSTIMEZONE]                                        INT             NOT NULL,
    [ADDRESSVALIDFROM]                                       DATETIME        NOT NULL,
    [ADDRESSVALIDTO]                                         DATETIME        NOT NULL,
    [ADDRESSZIPCODE]                                         NVARCHAR (10)   NOT NULL,
    [ADDRESSPOSTBOX]                                         NVARCHAR (20)   NOT NULL,
    [ADDRESSCITYINKANA]                                      NVARCHAR (60)   NOT NULL,
    [ADDRESSSTREETINKANA]                                    NVARCHAR (250)  NOT NULL,
    [ADDRESSBRAZILIANCNPJORCPF]                              NVARCHAR (20)   NOT NULL,
    [ADDRESSBRAZILIANIE]                                     NVARCHAR (20)   NOT NULL,
    [FORMATTEDPRIMARYADDRESS]                                NVARCHAR (250)  NOT NULL,
    [VENDORKNOWNASNAME]                                      NVARCHAR (100)  NOT NULL,
    [LANGUAGEID]                                             NVARCHAR (7)    NOT NULL,
    [VENDORORGANIZATIONNAME]                                 NVARCHAR (100)  NOT NULL,
    [VENDORSEARCHNAME]                                       NVARCHAR (60)   NOT NULL,
    [ORGANIZATIONABCCODE]                                    INT             NOT NULL,
    [ORGANIZATIONNUMBER]                                     NVARCHAR (25)   NOT NULL,
    [ORGANIZATIONEMPLOYEEAMOUNT]                             INT             NOT NULL,
    [ORGANIZATIONPHONETICNAME]                               NVARCHAR (100)  NOT NULL,
    [VENDORPARTYNUMBER]                                      NVARCHAR (40)   NOT NULL,
    [PERSONANNIVERSARYDAY]                                   INT             NOT NULL,
    [PERSONANNIVERSARYMONTH]                                 INT             NOT NULL,
    [PERSONANNIVERSARYYEAR]                                  INT             NOT NULL,
    [PERSONBIRTHDAY]                                         INT             NOT NULL,
    [PERSONBIRTHMONTH]                                       INT             NOT NULL,
    [PERSONBIRTHYEAR]                                        INT             NOT NULL,
    [PERSONCHILDRENNAMES]                                    NVARCHAR (150)  NOT NULL,
    [PERSONGENDER]                                           INT             NOT NULL,
    [PERSONHOBBIES]                                          NVARCHAR (150)  NOT NULL,
    [PERSONFIRSTNAME]                                        NVARCHAR (25)   NOT NULL,
    [PERSONMIDDLENAME]                                       NVARCHAR (25)   NOT NULL,
    [PERSONLASTNAMEPREFIX]                                   NVARCHAR (25)   NOT NULL,
    [PERSONLASTNAME]                                         NVARCHAR (25)   NOT NULL,
    [PERSONINITIALS]                                         NVARCHAR (10)   NOT NULL,
    [PERSONMARITALSTATUS]                                    INT             NOT NULL,
    [PERSONPERSONALSUFFIX]                                   NVARCHAR (50)   NOT NULL,
    [PERSONPERSONALTITLE]                                    NVARCHAR (50)   NOT NULL,
    [PERSONPHONETICFIRSTNAME]                                NVARCHAR (25)   NOT NULL,
    [PERSONPHONETICLASTNAME]                                 NVARCHAR (25)   NOT NULL,
    [PERSONPHONETICMIDDLENAME]                               NVARCHAR (25)   NOT NULL,
    [PERSONPROFESSIONALSUFFIX]                               NVARCHAR (50)   NOT NULL,
    [PERSONPROFESSIONALTITLE]                                NVARCHAR (50)   NOT NULL,
    [PRIMARYEMAILADDRESS]                                    NVARCHAR (255)  NOT NULL,
    [PRIMARYEMAILADDRESSDESCRIPTION]                         NVARCHAR (60)   NOT NULL,
    [ISPRIMARYEMAILADDRESSIMENABLED]                         INT             NOT NULL,
    [PRIMARYFAXNUMBER]                                       NVARCHAR (255)  NOT NULL,
    [PRIMARYFAXNUMBERDESCRIPTION]                            NVARCHAR (60)   NOT NULL,
    [PRIMARYFAXNUMBEREXTENSION]                              NVARCHAR (10)   NOT NULL,
    [PRIMARYPHONENUMBER]                                     NVARCHAR (255)  NOT NULL,
    [PRIMARYPHONENUMBERDESCRIPTION]                          NVARCHAR (60)   NOT NULL,
    [ISPRIMARYPHONENUMBERMOBILE]                             INT             NOT NULL,
    [PRIMARYTELEX]                                           NVARCHAR (255)  NOT NULL,
    [PRIMARYTELEXDESCRIPTION]                                NVARCHAR (60)   NOT NULL,
    [PRIMARYURL]                                             NVARCHAR (255)  NOT NULL,
    [PRIMARYURLDESCRIPTION]                                  NVARCHAR (60)   NOT NULL,
    [PRIMARYFACEBOOK]                                        NVARCHAR (255)  NOT NULL,
    [PRIMARYFACEBOOKDESCRIPTION]                             NVARCHAR (60)   NOT NULL,
    [PRIMARYLINKEDIN]                                        NVARCHAR (255)  NOT NULL,
    [PRIMARYLINKEDINDESCRIPTION]                             NVARCHAR (60)   NOT NULL,
    [PRIMARYTWITTER]                                         NVARCHAR (255)  NOT NULL,
    [PRIMARYTWITTERDESCRIPTION]                              NVARCHAR (60)   NOT NULL,
    [WILLPURCHASEORDERPROCESSINGSUMMARYUPDATEPURCHASEORDER]  INT             NOT NULL,
    [WILLPRODUCTRECEIPTPROCESSINGSUMMARYUPDATEPURCHASEORDER] INT             NOT NULL,
    [WILLRECEIPTSLISTPROCESSINGSUMMARYUPDATEPURCHASEORDER]   INT             NOT NULL,
    [WILLINVOICEPROCESSINGSUMMARYUPDATEPURCHASEORDER]        INT             NOT NULL,
    [ISCUSIPIDENTIFICATIONNUMBERAPPLICABLE]                  INT             NOT NULL,
    [CUSIPIDENTIFICATIONNUMBER]                              NVARCHAR (9)    NOT NULL,
    [CUSIPDETAILS]                                           NVARCHAR (60)   NOT NULL,
    [OIDINVESTORTYPE]                                        INT             NOT NULL,
    [OIDNOMINEEDETAILS]                                      NVARCHAR (60)   NOT NULL,
    [ISNATIONALREGISTRYNUMBER]                               NVARCHAR (10)   NOT NULL,
    [WITHHOLDINGTAXVENDORTYPE]                               INT             NOT NULL,
    [PURCHASEORDERCONSOLIDATIONDAYOFMONTH]                   INT             NOT NULL,
    [PAYMENTFEEGROUPID]                                      NVARCHAR (20)   NOT NULL,
    [ISVENDORPAYINGBANKPAYMENTFEE]                           INT             NOT NULL,
    [BRAZILIANCCM]                                           NVARCHAR (20)   NOT NULL,
    [BRAZILIANCNPJORCPF]                                     NVARCHAR (20)   NOT NULL,
    [BRAZILIANCNAE]                                          NVARCHAR (10)   NOT NULL,
    [FOREIGNERID]                                            NVARCHAR (20)   NOT NULL,
    [BRAZILIANIE]                                            NVARCHAR (20)   NOT NULL,
    [BRAZILIANNIT]                                           NVARCHAR (14)   NOT NULL,
    [FISCALOPERATIONPRESENCETYPE]                            INT             NOT NULL,
    [ISSERVICEDELIVERYADDRESSBASED]                          INT             NOT NULL,
    [ISPURCHASECONSUMED]                                     INT             NOT NULL,
    [BRAZILIANINSSCEI]                                       NVARCHAR (15)   NOT NULL,
    [ISINCOMINGFISCALDOCUMENTGENERATED]                      INT             NOT NULL,
    [ISICMSCONTRIBUTOR]                                      INT             NOT NULL,
    [VENDORPORTALCOLLABORATIONMETHOD]                        INT             NOT NULL,
    [PRIMARYPHONENUMBEREXTENSION]                            NVARCHAR (10)   NOT NULL,
    [ZAKATREGISTRATIONNUMBER]                                NVARCHAR (25)   NOT NULL,
    [ZAKATFILENUMBER]                                        NVARCHAR (15)   NOT NULL,
    [ISSUBCONTRACTOR]                                        INT             NOT NULL,
    [ZAKATSERVICETYPE]                                       NVARCHAR (25)   NOT NULL,
    [ISGSTCOMPOSITIONSCHEMEENABLED]                          INT             NOT NULL,
    [BANKTRANSACTIONTYPE]                                    NVARCHAR (10)   NOT NULL,
    [BANKORDEROFPAYMENT]                                     NVARCHAR (2)    NOT NULL,
    [FOREIGNRESIDENT]                                        INT             NOT NULL,
    [INVENTORYPROFILE]                                       NVARCHAR (10)   NOT NULL,
    [INVENTORYPROFILETYPE]                                   INT             NOT NULL,
    [SEPARATEDIVISIONID]                                     NVARCHAR (20)   NOT NULL,
    [STRUCTUREDEPARTMENT]                                    NVARCHAR (30)   NOT NULL,
    [TAXOPERATIONCODE]                                       NVARCHAR (10)   NOT NULL,
    [TAXPARTNERKIND]                                         INT             NOT NULL,
    [TAXAGENT]                                               INT             NOT NULL,
    [PARTITION]                                              NVARCHAR (20)   NOT NULL,
    [DATAAREAID]                                             NVARCHAR (4)    NOT NULL,
    [SYNCSTARTDATETIME]                                      DATETIME        NOT NULL,
    CONSTRAINT [PK_VendVendorV2Staging] PRIMARY KEY CLUSTERED ([VENDORACCOUNTNUMBER] ASC, [EXECUTIONID] ASC, [DATAAREAID] ASC, [PARTITION] ASC)
);


# frozen_string_literal: true

require_relative "employment_employee"
require_relative "employment_pay_period"
require_relative "employment_pay_frequency"
require_relative "employment_pay_currency"
require_relative "employment_pay_group"
require_relative "employment_flsa_status"
require "date"
require_relative "employment_employment_type"
require_relative "remote_data"
require "json"

module Merge
  module Hris
    # # The Employment Object
    #
    # ### Description
    #
    # The `Employment` object is used to represent a job position at a company.
    #
    # Please note: When there is a change in pay or title, integrations with historical data will create new Employment objects while integrations without historical data will update existing ones.
    #
    # ### Usage Example
    #
    # Fetch from the `LIST Employments` endpoint and filter by `ID` to show all employees.
    class Employment
      attr_reader :id, :remote_id, :employee, :job_title, :pay_rate, :pay_period, :pay_frequency, :pay_currency,
                  :pay_group, :flsa_status, :effective_date, :employment_type, :remote_was_deleted, :created_at, :modified_at, :field_mappings, :remote_data, :additional_properties

      # @param id [String]
      # @param remote_id [String] The third-party API ID of the matching object.
      # @param employee [Hris::EmploymentEmployee] The employee holding this position.
      # @param job_title [String] The position's title.
      # @param pay_rate [Float] The position's pay rate in dollars.
      # @param pay_period [Hris::EmploymentPayPeriod] The time period this pay rate encompasses.
      #   - `HOUR` - HOUR
      #   - `DAY` - DAY
      #   - `WEEK` - WEEK
      #   - `EVERY_TWO_WEEKS` - EVERY_TWO_WEEKS
      #   - `SEMIMONTHLY` - SEMIMONTHLY
      #   - `MONTH` - MONTH
      #   - `QUARTER` - QUARTER
      #   - `EVERY_SIX_MONTHS` - EVERY_SIX_MONTHS
      #   - `YEAR` - YEAR
      # @param pay_frequency [Hris::EmploymentPayFrequency] The position's pay frequency.
      #   - `WEEKLY` - WEEKLY
      #   - `BIWEEKLY` - BIWEEKLY
      #   - `MONTHLY` - MONTHLY
      #   - `QUARTERLY` - QUARTERLY
      #   - `SEMIANNUALLY` - SEMIANNUALLY
      #   - `ANNUALLY` - ANNUALLY
      #   - `THIRTEEN-MONTHLY` - THIRTEEN-MONTHLY
      #   - `PRO_RATA` - PRO_RATA
      #   - `SEMIMONTHLY` - SEMIMONTHLY
      # @param pay_currency [Hris::EmploymentPayCurrency] The position's currency code.
      #   - `XUA` - ADB Unit of Account
      #   - `AFN` - Afghan Afghani
      #   - `AFA` - Afghan Afghani (1927–2002)
      #   - `ALL` - Albanian Lek
      #   - `ALK` - Albanian Lek (1946–1965)
      #   - `DZD` - Algerian Dinar
      #   - `ADP` - Andorran Peseta
      #   - `AOA` - Angolan Kwanza
      #   - `AOK` - Angolan Kwanza (1977–1991)
      #   - `AON` - Angolan New Kwanza (1990–2000)
      #   - `AOR` - Angolan Readjusted Kwanza (1995–1999)
      #   - `ARA` - Argentine Austral
      #   - `ARS` - Argentine Peso
      #   - `ARM` - Argentine Peso (1881–1970)
      #   - `ARP` - Argentine Peso (1983–1985)
      #   - `ARL` - Argentine Peso Ley (1970–1983)
      #   - `AMD` - Armenian Dram
      #   - `AWG` - Aruban Florin
      #   - `AUD` - Australian Dollar
      #   - `ATS` - Austrian Schilling
      #   - `AZN` - Azerbaijani Manat
      #   - `AZM` - Azerbaijani Manat (1993–2006)
      #   - `BSD` - Bahamian Dollar
      #   - `BHD` - Bahraini Dinar
      #   - `BDT` - Bangladeshi Taka
      #   - `BBD` - Barbadian Dollar
      #   - `BYN` - Belarusian Ruble
      #   - `BYB` - Belarusian Ruble (1994–1999)
      #   - `BYR` - Belarusian Ruble (2000–2016)
      #   - `BEF` - Belgian Franc
      #   - `BEC` - Belgian Franc (convertible)
      #   - `BEL` - Belgian Franc (financial)
      #   - `BZD` - Belize Dollar
      #   - `BMD` - Bermudan Dollar
      #   - `BTN` - Bhutanese Ngultrum
      #   - `BOB` - Bolivian Boliviano
      #   - `BOL` - Bolivian Boliviano (1863–1963)
      #   - `BOV` - Bolivian Mvdol
      #   - `BOP` - Bolivian Peso
      #   - `BAM` - Bosnia-Herzegovina Convertible Mark
      #   - `BAD` - Bosnia-Herzegovina Dinar (1992–1994)
      #   - `BAN` - Bosnia-Herzegovina New Dinar (1994–1997)
      #   - `BWP` - Botswanan Pula
      #   - `BRC` - Brazilian Cruzado (1986–1989)
      #   - `BRZ` - Brazilian Cruzeiro (1942–1967)
      #   - `BRE` - Brazilian Cruzeiro (1990–1993)
      #   - `BRR` - Brazilian Cruzeiro (1993–1994)
      #   - `BRN` - Brazilian New Cruzado (1989–1990)
      #   - `BRB` - Brazilian New Cruzeiro (1967–1986)
      #   - `BRL` - Brazilian Real
      #   - `GBP` - British Pound
      #   - `BND` - Brunei Dollar
      #   - `BGL` - Bulgarian Hard Lev
      #   - `BGN` - Bulgarian Lev
      #   - `BGO` - Bulgarian Lev (1879–1952)
      #   - `BGM` - Bulgarian Socialist Lev
      #   - `BUK` - Burmese Kyat
      #   - `BIF` - Burundian Franc
      #   - `XPF` - CFP Franc
      #   - `KHR` - Cambodian Riel
      #   - `CAD` - Canadian Dollar
      #   - `CVE` - Cape Verdean Escudo
      #   - `KYD` - Cayman Islands Dollar
      #   - `XAF` - Central African CFA Franc
      #   - `CLE` - Chilean Escudo
      #   - `CLP` - Chilean Peso
      #   - `CLF` - Chilean Unit of Account (UF)
      #   - `CNX` - Chinese People’s Bank Dollar
      #   - `CNY` - Chinese Yuan
      #   - `CNH` - Chinese Yuan (offshore)
      #   - `COP` - Colombian Peso
      #   - `COU` - Colombian Real Value Unit
      #   - `KMF` - Comorian Franc
      #   - `CDF` - Congolese Franc
      #   - `CRC` - Costa Rican Colón
      #   - `HRD` - Croatian Dinar
      #   - `HRK` - Croatian Kuna
      #   - `CUC` - Cuban Convertible Peso
      #   - `CUP` - Cuban Peso
      #   - `CYP` - Cypriot Pound
      #   - `CZK` - Czech Koruna
      #   - `CSK` - Czechoslovak Hard Koruna
      #   - `DKK` - Danish Krone
      #   - `DJF` - Djiboutian Franc
      #   - `DOP` - Dominican Peso
      #   - `NLG` - Dutch Guilder
      #   - `XCD` - East Caribbean Dollar
      #   - `DDM` - East German Mark
      #   - `ECS` - Ecuadorian Sucre
      #   - `ECV` - Ecuadorian Unit of Constant Value
      #   - `EGP` - Egyptian Pound
      #   - `GQE` - Equatorial Guinean Ekwele
      #   - `ERN` - Eritrean Nakfa
      #   - `EEK` - Estonian Kroon
      #   - `ETB` - Ethiopian Birr
      #   - `EUR` - Euro
      #   - `XBA` - European Composite Unit
      #   - `XEU` - European Currency Unit
      #   - `XBB` - European Monetary Unit
      #   - `XBC` - European Unit of Account (XBC)
      #   - `XBD` - European Unit of Account (XBD)
      #   - `FKP` - Falkland Islands Pound
      #   - `FJD` - Fijian Dollar
      #   - `FIM` - Finnish Markka
      #   - `FRF` - French Franc
      #   - `XFO` - French Gold Franc
      #   - `XFU` - French UIC-Franc
      #   - `GMD` - Gambian Dalasi
      #   - `GEK` - Georgian Kupon Larit
      #   - `GEL` - Georgian Lari
      #   - `DEM` - German Mark
      #   - `GHS` - Ghanaian Cedi
      #   - `GHC` - Ghanaian Cedi (1979–2007)
      #   - `GIP` - Gibraltar Pound
      #   - `XAU` - Gold
      #   - `GRD` - Greek Drachma
      #   - `GTQ` - Guatemalan Quetzal
      #   - `GWP` - Guinea-Bissau Peso
      #   - `GNF` - Guinean Franc
      #   - `GNS` - Guinean Syli
      #   - `GYD` - Guyanaese Dollar
      #   - `HTG` - Haitian Gourde
      #   - `HNL` - Honduran Lempira
      #   - `HKD` - Hong Kong Dollar
      #   - `HUF` - Hungarian Forint
      #   - `IMP` - IMP
      #   - `ISK` - Icelandic Króna
      #   - `ISJ` - Icelandic Króna (1918–1981)
      #   - `INR` - Indian Rupee
      #   - `IDR` - Indonesian Rupiah
      #   - `IRR` - Iranian Rial
      #   - `IQD` - Iraqi Dinar
      #   - `IEP` - Irish Pound
      #   - `ILS` - Israeli New Shekel
      #   - `ILP` - Israeli Pound
      #   - `ILR` - Israeli Shekel (1980–1985)
      #   - `ITL` - Italian Lira
      #   - `JMD` - Jamaican Dollar
      #   - `JPY` - Japanese Yen
      #   - `JOD` - Jordanian Dinar
      #   - `KZT` - Kazakhstani Tenge
      #   - `KES` - Kenyan Shilling
      #   - `KWD` - Kuwaiti Dinar
      #   - `KGS` - Kyrgystani Som
      #   - `LAK` - Laotian Kip
      #   - `LVL` - Latvian Lats
      #   - `LVR` - Latvian Ruble
      #   - `LBP` - Lebanese Pound
      #   - `LSL` - Lesotho Loti
      #   - `LRD` - Liberian Dollar
      #   - `LYD` - Libyan Dinar
      #   - `LTL` - Lithuanian Litas
      #   - `LTT` - Lithuanian Talonas
      #   - `LUL` - Luxembourg Financial Franc
      #   - `LUC` - Luxembourgian Convertible Franc
      #   - `LUF` - Luxembourgian Franc
      #   - `MOP` - Macanese Pataca
      #   - `MKD` - Macedonian Denar
      #   - `MKN` - Macedonian Denar (1992–1993)
      #   - `MGA` - Malagasy Ariary
      #   - `MGF` - Malagasy Franc
      #   - `MWK` - Malawian Kwacha
      #   - `MYR` - Malaysian Ringgit
      #   - `MVR` - Maldivian Rufiyaa
      #   - `MVP` - Maldivian Rupee (1947–1981)
      #   - `MLF` - Malian Franc
      #   - `MTL` - Maltese Lira
      #   - `MTP` - Maltese Pound
      #   - `MRU` - Mauritanian Ouguiya
      #   - `MRO` - Mauritanian Ouguiya (1973–2017)
      #   - `MUR` - Mauritian Rupee
      #   - `MXV` - Mexican Investment Unit
      #   - `MXN` - Mexican Peso
      #   - `MXP` - Mexican Silver Peso (1861–1992)
      #   - `MDC` - Moldovan Cupon
      #   - `MDL` - Moldovan Leu
      #   - `MCF` - Monegasque Franc
      #   - `MNT` - Mongolian Tugrik
      #   - `MAD` - Moroccan Dirham
      #   - `MAF` - Moroccan Franc
      #   - `MZE` - Mozambican Escudo
      #   - `MZN` - Mozambican Metical
      #   - `MZM` - Mozambican Metical (1980–2006)
      #   - `MMK` - Myanmar Kyat
      #   - `NAD` - Namibian Dollar
      #   - `NPR` - Nepalese Rupee
      #   - `ANG` - Netherlands Antillean Guilder
      #   - `TWD` - New Taiwan Dollar
      #   - `NZD` - New Zealand Dollar
      #   - `NIO` - Nicaraguan Córdoba
      #   - `NIC` - Nicaraguan Córdoba (1988–1991)
      #   - `NGN` - Nigerian Naira
      #   - `KPW` - North Korean Won
      #   - `NOK` - Norwegian Krone
      #   - `OMR` - Omani Rial
      #   - `PKR` - Pakistani Rupee
      #   - `XPD` - Palladium
      #   - `PAB` - Panamanian Balboa
      #   - `PGK` - Papua New Guinean Kina
      #   - `PYG` - Paraguayan Guarani
      #   - `PEI` - Peruvian Inti
      #   - `PEN` - Peruvian Sol
      #   - `PES` - Peruvian Sol (1863–1965)
      #   - `PHP` - Philippine Peso
      #   - `XPT` - Platinum
      #   - `PLN` - Polish Zloty
      #   - `PLZ` - Polish Zloty (1950–1995)
      #   - `PTE` - Portuguese Escudo
      #   - `GWE` - Portuguese Guinea Escudo
      #   - `QAR` - Qatari Rial
      #   - `XRE` - RINET Funds
      #   - `RHD` - Rhodesian Dollar
      #   - `RON` - Romanian Leu
      #   - `ROL` - Romanian Leu (1952–2006)
      #   - `RUB` - Russian Ruble
      #   - `RUR` - Russian Ruble (1991–1998)
      #   - `RWF` - Rwandan Franc
      #   - `SVC` - Salvadoran Colón
      #   - `WST` - Samoan Tala
      #   - `SAR` - Saudi Riyal
      #   - `RSD` - Serbian Dinar
      #   - `CSD` - Serbian Dinar (2002–2006)
      #   - `SCR` - Seychellois Rupee
      #   - `SLL` - Sierra Leonean Leone
      #   - `XAG` - Silver
      #   - `SGD` - Singapore Dollar
      #   - `SKK` - Slovak Koruna
      #   - `SIT` - Slovenian Tolar
      #   - `SBD` - Solomon Islands Dollar
      #   - `SOS` - Somali Shilling
      #   - `ZAR` - South African Rand
      #   - `ZAL` - South African Rand (financial)
      #   - `KRH` - South Korean Hwan (1953–1962)
      #   - `KRW` - South Korean Won
      #   - `KRO` - South Korean Won (1945–1953)
      #   - `SSP` - South Sudanese Pound
      #   - `SUR` - Soviet Rouble
      #   - `ESP` - Spanish Peseta
      #   - `ESA` - Spanish Peseta (A account)
      #   - `ESB` - Spanish Peseta (convertible account)
      #   - `XDR` - Special Drawing Rights
      #   - `LKR` - Sri Lankan Rupee
      #   - `SHP` - St. Helena Pound
      #   - `XSU` - Sucre
      #   - `SDD` - Sudanese Dinar (1992–2007)
      #   - `SDG` - Sudanese Pound
      #   - `SDP` - Sudanese Pound (1957–1998)
      #   - `SRD` - Surinamese Dollar
      #   - `SRG` - Surinamese Guilder
      #   - `SZL` - Swazi Lilangeni
      #   - `SEK` - Swedish Krona
      #   - `CHF` - Swiss Franc
      #   - `SYP` - Syrian Pound
      #   - `STN` - São Tomé & Príncipe Dobra
      #   - `STD` - São Tomé & Príncipe Dobra (1977–2017)
      #   - `TVD` - TVD
      #   - `TJR` - Tajikistani Ruble
      #   - `TJS` - Tajikistani Somoni
      #   - `TZS` - Tanzanian Shilling
      #   - `XTS` - Testing Currency Code
      #   - `THB` - Thai Baht
      #   - `XXX` - The codes assigned for transactions where no currency is involved
      #   - `TPE` - Timorese Escudo
      #   - `TOP` - Tongan Paʻanga
      #   - `TTD` - Trinidad & Tobago Dollar
      #   - `TND` - Tunisian Dinar
      #   - `TRY` - Turkish Lira
      #   - `TRL` - Turkish Lira (1922–2005)
      #   - `TMT` - Turkmenistani Manat
      #   - `TMM` - Turkmenistani Manat (1993–2009)
      #   - `USD` - US Dollar
      #   - `USN` - US Dollar (Next day)
      #   - `USS` - US Dollar (Same day)
      #   - `UGX` - Ugandan Shilling
      #   - `UGS` - Ugandan Shilling (1966–1987)
      #   - `UAH` - Ukrainian Hryvnia
      #   - `UAK` - Ukrainian Karbovanets
      #   - `AED` - United Arab Emirates Dirham
      #   - `UYW` - Uruguayan Nominal Wage Index Unit
      #   - `UYU` - Uruguayan Peso
      #   - `UYP` - Uruguayan Peso (1975–1993)
      #   - `UYI` - Uruguayan Peso (Indexed Units)
      #   - `UZS` - Uzbekistani Som
      #   - `VUV` - Vanuatu Vatu
      #   - `VES` - Venezuelan Bolívar
      #   - `VEB` - Venezuelan Bolívar (1871–2008)
      #   - `VEF` - Venezuelan Bolívar (2008–2018)
      #   - `VND` - Vietnamese Dong
      #   - `VNN` - Vietnamese Dong (1978–1985)
      #   - `CHE` - WIR Euro
      #   - `CHW` - WIR Franc
      #   - `XOF` - West African CFA Franc
      #   - `YDD` - Yemeni Dinar
      #   - `YER` - Yemeni Rial
      #   - `YUN` - Yugoslavian Convertible Dinar (1990–1992)
      #   - `YUD` - Yugoslavian Hard Dinar (1966–1990)
      #   - `YUM` - Yugoslavian New Dinar (1994–2002)
      #   - `YUR` - Yugoslavian Reformed Dinar (1992–1993)
      #   - `ZWN` - ZWN
      #   - `ZRN` - Zairean New Zaire (1993–1998)
      #   - `ZRZ` - Zairean Zaire (1971–1993)
      #   - `ZMW` - Zambian Kwacha
      #   - `ZMK` - Zambian Kwacha (1968–2012)
      #   - `ZWD` - Zimbabwean Dollar (1980–2008)
      #   - `ZWR` - Zimbabwean Dollar (2008)
      #   - `ZWL` - Zimbabwean Dollar (2009)
      # @param pay_group [Hris::EmploymentPayGroup] The employment's pay group
      # @param flsa_status [Hris::EmploymentFlsaStatus] The position's FLSA status.
      #   - `EXEMPT` - EXEMPT
      #   - `SALARIED_NONEXEMPT` - SALARIED_NONEXEMPT
      #   - `NONEXEMPT` - NONEXEMPT
      #   - `OWNER` - OWNER
      # @param effective_date [DateTime] The position's effective date.
      # @param employment_type [Hris::EmploymentEmploymentType] The position's type of employment.
      #   - `FULL_TIME` - FULL_TIME
      #   - `PART_TIME` - PART_TIME
      #   - `INTERN` - INTERN
      #   - `CONTRACTOR` - CONTRACTOR
      #   - `FREELANCE` - FREELANCE
      # @param remote_was_deleted [Boolean] Indicates whether or not this object has been deleted in the third party platform.
      # @param created_at [DateTime]
      # @param modified_at [DateTime] This is the datetime that this object was last updated by Merge
      # @param field_mappings [Hash{String => String}]
      # @param remote_data [Array<Hris::RemoteData>]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Hris::Employment]
      def initialize(id: nil, remote_id: nil, employee: nil, job_title: nil, pay_rate: nil, pay_period: nil,
                     pay_frequency: nil, pay_currency: nil, pay_group: nil, flsa_status: nil, effective_date: nil, employment_type: nil, remote_was_deleted: nil, created_at: nil, modified_at: nil, field_mappings: nil, remote_data: nil, additional_properties: nil)
        # @type [String]
        @id = id
        # @type [String] The third-party API ID of the matching object.
        @remote_id = remote_id
        # @type [Hris::EmploymentEmployee] The employee holding this position.
        @employee = employee
        # @type [String] The position's title.
        @job_title = job_title
        # @type [Float] The position's pay rate in dollars.
        @pay_rate = pay_rate
        # @type [Hris::EmploymentPayPeriod] The time period this pay rate encompasses.
        #   - `HOUR` - HOUR
        #   - `DAY` - DAY
        #   - `WEEK` - WEEK
        #   - `EVERY_TWO_WEEKS` - EVERY_TWO_WEEKS
        #   - `SEMIMONTHLY` - SEMIMONTHLY
        #   - `MONTH` - MONTH
        #   - `QUARTER` - QUARTER
        #   - `EVERY_SIX_MONTHS` - EVERY_SIX_MONTHS
        #   - `YEAR` - YEAR
        @pay_period = pay_period
        # @type [Hris::EmploymentPayFrequency] The position's pay frequency.
        #   - `WEEKLY` - WEEKLY
        #   - `BIWEEKLY` - BIWEEKLY
        #   - `MONTHLY` - MONTHLY
        #   - `QUARTERLY` - QUARTERLY
        #   - `SEMIANNUALLY` - SEMIANNUALLY
        #   - `ANNUALLY` - ANNUALLY
        #   - `THIRTEEN-MONTHLY` - THIRTEEN-MONTHLY
        #   - `PRO_RATA` - PRO_RATA
        #   - `SEMIMONTHLY` - SEMIMONTHLY
        @pay_frequency = pay_frequency
        # @type [Hris::EmploymentPayCurrency] The position's currency code.
        #   - `XUA` - ADB Unit of Account
        #   - `AFN` - Afghan Afghani
        #   - `AFA` - Afghan Afghani (1927–2002)
        #   - `ALL` - Albanian Lek
        #   - `ALK` - Albanian Lek (1946–1965)
        #   - `DZD` - Algerian Dinar
        #   - `ADP` - Andorran Peseta
        #   - `AOA` - Angolan Kwanza
        #   - `AOK` - Angolan Kwanza (1977–1991)
        #   - `AON` - Angolan New Kwanza (1990–2000)
        #   - `AOR` - Angolan Readjusted Kwanza (1995–1999)
        #   - `ARA` - Argentine Austral
        #   - `ARS` - Argentine Peso
        #   - `ARM` - Argentine Peso (1881–1970)
        #   - `ARP` - Argentine Peso (1983–1985)
        #   - `ARL` - Argentine Peso Ley (1970–1983)
        #   - `AMD` - Armenian Dram
        #   - `AWG` - Aruban Florin
        #   - `AUD` - Australian Dollar
        #   - `ATS` - Austrian Schilling
        #   - `AZN` - Azerbaijani Manat
        #   - `AZM` - Azerbaijani Manat (1993–2006)
        #   - `BSD` - Bahamian Dollar
        #   - `BHD` - Bahraini Dinar
        #   - `BDT` - Bangladeshi Taka
        #   - `BBD` - Barbadian Dollar
        #   - `BYN` - Belarusian Ruble
        #   - `BYB` - Belarusian Ruble (1994–1999)
        #   - `BYR` - Belarusian Ruble (2000–2016)
        #   - `BEF` - Belgian Franc
        #   - `BEC` - Belgian Franc (convertible)
        #   - `BEL` - Belgian Franc (financial)
        #   - `BZD` - Belize Dollar
        #   - `BMD` - Bermudan Dollar
        #   - `BTN` - Bhutanese Ngultrum
        #   - `BOB` - Bolivian Boliviano
        #   - `BOL` - Bolivian Boliviano (1863–1963)
        #   - `BOV` - Bolivian Mvdol
        #   - `BOP` - Bolivian Peso
        #   - `BAM` - Bosnia-Herzegovina Convertible Mark
        #   - `BAD` - Bosnia-Herzegovina Dinar (1992–1994)
        #   - `BAN` - Bosnia-Herzegovina New Dinar (1994–1997)
        #   - `BWP` - Botswanan Pula
        #   - `BRC` - Brazilian Cruzado (1986–1989)
        #   - `BRZ` - Brazilian Cruzeiro (1942–1967)
        #   - `BRE` - Brazilian Cruzeiro (1990–1993)
        #   - `BRR` - Brazilian Cruzeiro (1993–1994)
        #   - `BRN` - Brazilian New Cruzado (1989–1990)
        #   - `BRB` - Brazilian New Cruzeiro (1967–1986)
        #   - `BRL` - Brazilian Real
        #   - `GBP` - British Pound
        #   - `BND` - Brunei Dollar
        #   - `BGL` - Bulgarian Hard Lev
        #   - `BGN` - Bulgarian Lev
        #   - `BGO` - Bulgarian Lev (1879–1952)
        #   - `BGM` - Bulgarian Socialist Lev
        #   - `BUK` - Burmese Kyat
        #   - `BIF` - Burundian Franc
        #   - `XPF` - CFP Franc
        #   - `KHR` - Cambodian Riel
        #   - `CAD` - Canadian Dollar
        #   - `CVE` - Cape Verdean Escudo
        #   - `KYD` - Cayman Islands Dollar
        #   - `XAF` - Central African CFA Franc
        #   - `CLE` - Chilean Escudo
        #   - `CLP` - Chilean Peso
        #   - `CLF` - Chilean Unit of Account (UF)
        #   - `CNX` - Chinese People’s Bank Dollar
        #   - `CNY` - Chinese Yuan
        #   - `CNH` - Chinese Yuan (offshore)
        #   - `COP` - Colombian Peso
        #   - `COU` - Colombian Real Value Unit
        #   - `KMF` - Comorian Franc
        #   - `CDF` - Congolese Franc
        #   - `CRC` - Costa Rican Colón
        #   - `HRD` - Croatian Dinar
        #   - `HRK` - Croatian Kuna
        #   - `CUC` - Cuban Convertible Peso
        #   - `CUP` - Cuban Peso
        #   - `CYP` - Cypriot Pound
        #   - `CZK` - Czech Koruna
        #   - `CSK` - Czechoslovak Hard Koruna
        #   - `DKK` - Danish Krone
        #   - `DJF` - Djiboutian Franc
        #   - `DOP` - Dominican Peso
        #   - `NLG` - Dutch Guilder
        #   - `XCD` - East Caribbean Dollar
        #   - `DDM` - East German Mark
        #   - `ECS` - Ecuadorian Sucre
        #   - `ECV` - Ecuadorian Unit of Constant Value
        #   - `EGP` - Egyptian Pound
        #   - `GQE` - Equatorial Guinean Ekwele
        #   - `ERN` - Eritrean Nakfa
        #   - `EEK` - Estonian Kroon
        #   - `ETB` - Ethiopian Birr
        #   - `EUR` - Euro
        #   - `XBA` - European Composite Unit
        #   - `XEU` - European Currency Unit
        #   - `XBB` - European Monetary Unit
        #   - `XBC` - European Unit of Account (XBC)
        #   - `XBD` - European Unit of Account (XBD)
        #   - `FKP` - Falkland Islands Pound
        #   - `FJD` - Fijian Dollar
        #   - `FIM` - Finnish Markka
        #   - `FRF` - French Franc
        #   - `XFO` - French Gold Franc
        #   - `XFU` - French UIC-Franc
        #   - `GMD` - Gambian Dalasi
        #   - `GEK` - Georgian Kupon Larit
        #   - `GEL` - Georgian Lari
        #   - `DEM` - German Mark
        #   - `GHS` - Ghanaian Cedi
        #   - `GHC` - Ghanaian Cedi (1979–2007)
        #   - `GIP` - Gibraltar Pound
        #   - `XAU` - Gold
        #   - `GRD` - Greek Drachma
        #   - `GTQ` - Guatemalan Quetzal
        #   - `GWP` - Guinea-Bissau Peso
        #   - `GNF` - Guinean Franc
        #   - `GNS` - Guinean Syli
        #   - `GYD` - Guyanaese Dollar
        #   - `HTG` - Haitian Gourde
        #   - `HNL` - Honduran Lempira
        #   - `HKD` - Hong Kong Dollar
        #   - `HUF` - Hungarian Forint
        #   - `IMP` - IMP
        #   - `ISK` - Icelandic Króna
        #   - `ISJ` - Icelandic Króna (1918–1981)
        #   - `INR` - Indian Rupee
        #   - `IDR` - Indonesian Rupiah
        #   - `IRR` - Iranian Rial
        #   - `IQD` - Iraqi Dinar
        #   - `IEP` - Irish Pound
        #   - `ILS` - Israeli New Shekel
        #   - `ILP` - Israeli Pound
        #   - `ILR` - Israeli Shekel (1980–1985)
        #   - `ITL` - Italian Lira
        #   - `JMD` - Jamaican Dollar
        #   - `JPY` - Japanese Yen
        #   - `JOD` - Jordanian Dinar
        #   - `KZT` - Kazakhstani Tenge
        #   - `KES` - Kenyan Shilling
        #   - `KWD` - Kuwaiti Dinar
        #   - `KGS` - Kyrgystani Som
        #   - `LAK` - Laotian Kip
        #   - `LVL` - Latvian Lats
        #   - `LVR` - Latvian Ruble
        #   - `LBP` - Lebanese Pound
        #   - `LSL` - Lesotho Loti
        #   - `LRD` - Liberian Dollar
        #   - `LYD` - Libyan Dinar
        #   - `LTL` - Lithuanian Litas
        #   - `LTT` - Lithuanian Talonas
        #   - `LUL` - Luxembourg Financial Franc
        #   - `LUC` - Luxembourgian Convertible Franc
        #   - `LUF` - Luxembourgian Franc
        #   - `MOP` - Macanese Pataca
        #   - `MKD` - Macedonian Denar
        #   - `MKN` - Macedonian Denar (1992–1993)
        #   - `MGA` - Malagasy Ariary
        #   - `MGF` - Malagasy Franc
        #   - `MWK` - Malawian Kwacha
        #   - `MYR` - Malaysian Ringgit
        #   - `MVR` - Maldivian Rufiyaa
        #   - `MVP` - Maldivian Rupee (1947–1981)
        #   - `MLF` - Malian Franc
        #   - `MTL` - Maltese Lira
        #   - `MTP` - Maltese Pound
        #   - `MRU` - Mauritanian Ouguiya
        #   - `MRO` - Mauritanian Ouguiya (1973–2017)
        #   - `MUR` - Mauritian Rupee
        #   - `MXV` - Mexican Investment Unit
        #   - `MXN` - Mexican Peso
        #   - `MXP` - Mexican Silver Peso (1861–1992)
        #   - `MDC` - Moldovan Cupon
        #   - `MDL` - Moldovan Leu
        #   - `MCF` - Monegasque Franc
        #   - `MNT` - Mongolian Tugrik
        #   - `MAD` - Moroccan Dirham
        #   - `MAF` - Moroccan Franc
        #   - `MZE` - Mozambican Escudo
        #   - `MZN` - Mozambican Metical
        #   - `MZM` - Mozambican Metical (1980–2006)
        #   - `MMK` - Myanmar Kyat
        #   - `NAD` - Namibian Dollar
        #   - `NPR` - Nepalese Rupee
        #   - `ANG` - Netherlands Antillean Guilder
        #   - `TWD` - New Taiwan Dollar
        #   - `NZD` - New Zealand Dollar
        #   - `NIO` - Nicaraguan Córdoba
        #   - `NIC` - Nicaraguan Córdoba (1988–1991)
        #   - `NGN` - Nigerian Naira
        #   - `KPW` - North Korean Won
        #   - `NOK` - Norwegian Krone
        #   - `OMR` - Omani Rial
        #   - `PKR` - Pakistani Rupee
        #   - `XPD` - Palladium
        #   - `PAB` - Panamanian Balboa
        #   - `PGK` - Papua New Guinean Kina
        #   - `PYG` - Paraguayan Guarani
        #   - `PEI` - Peruvian Inti
        #   - `PEN` - Peruvian Sol
        #   - `PES` - Peruvian Sol (1863–1965)
        #   - `PHP` - Philippine Peso
        #   - `XPT` - Platinum
        #   - `PLN` - Polish Zloty
        #   - `PLZ` - Polish Zloty (1950–1995)
        #   - `PTE` - Portuguese Escudo
        #   - `GWE` - Portuguese Guinea Escudo
        #   - `QAR` - Qatari Rial
        #   - `XRE` - RINET Funds
        #   - `RHD` - Rhodesian Dollar
        #   - `RON` - Romanian Leu
        #   - `ROL` - Romanian Leu (1952–2006)
        #   - `RUB` - Russian Ruble
        #   - `RUR` - Russian Ruble (1991–1998)
        #   - `RWF` - Rwandan Franc
        #   - `SVC` - Salvadoran Colón
        #   - `WST` - Samoan Tala
        #   - `SAR` - Saudi Riyal
        #   - `RSD` - Serbian Dinar
        #   - `CSD` - Serbian Dinar (2002–2006)
        #   - `SCR` - Seychellois Rupee
        #   - `SLL` - Sierra Leonean Leone
        #   - `XAG` - Silver
        #   - `SGD` - Singapore Dollar
        #   - `SKK` - Slovak Koruna
        #   - `SIT` - Slovenian Tolar
        #   - `SBD` - Solomon Islands Dollar
        #   - `SOS` - Somali Shilling
        #   - `ZAR` - South African Rand
        #   - `ZAL` - South African Rand (financial)
        #   - `KRH` - South Korean Hwan (1953–1962)
        #   - `KRW` - South Korean Won
        #   - `KRO` - South Korean Won (1945–1953)
        #   - `SSP` - South Sudanese Pound
        #   - `SUR` - Soviet Rouble
        #   - `ESP` - Spanish Peseta
        #   - `ESA` - Spanish Peseta (A account)
        #   - `ESB` - Spanish Peseta (convertible account)
        #   - `XDR` - Special Drawing Rights
        #   - `LKR` - Sri Lankan Rupee
        #   - `SHP` - St. Helena Pound
        #   - `XSU` - Sucre
        #   - `SDD` - Sudanese Dinar (1992–2007)
        #   - `SDG` - Sudanese Pound
        #   - `SDP` - Sudanese Pound (1957–1998)
        #   - `SRD` - Surinamese Dollar
        #   - `SRG` - Surinamese Guilder
        #   - `SZL` - Swazi Lilangeni
        #   - `SEK` - Swedish Krona
        #   - `CHF` - Swiss Franc
        #   - `SYP` - Syrian Pound
        #   - `STN` - São Tomé & Príncipe Dobra
        #   - `STD` - São Tomé & Príncipe Dobra (1977–2017)
        #   - `TVD` - TVD
        #   - `TJR` - Tajikistani Ruble
        #   - `TJS` - Tajikistani Somoni
        #   - `TZS` - Tanzanian Shilling
        #   - `XTS` - Testing Currency Code
        #   - `THB` - Thai Baht
        #   - `XXX` - The codes assigned for transactions where no currency is involved
        #   - `TPE` - Timorese Escudo
        #   - `TOP` - Tongan Paʻanga
        #   - `TTD` - Trinidad & Tobago Dollar
        #   - `TND` - Tunisian Dinar
        #   - `TRY` - Turkish Lira
        #   - `TRL` - Turkish Lira (1922–2005)
        #   - `TMT` - Turkmenistani Manat
        #   - `TMM` - Turkmenistani Manat (1993–2009)
        #   - `USD` - US Dollar
        #   - `USN` - US Dollar (Next day)
        #   - `USS` - US Dollar (Same day)
        #   - `UGX` - Ugandan Shilling
        #   - `UGS` - Ugandan Shilling (1966–1987)
        #   - `UAH` - Ukrainian Hryvnia
        #   - `UAK` - Ukrainian Karbovanets
        #   - `AED` - United Arab Emirates Dirham
        #   - `UYW` - Uruguayan Nominal Wage Index Unit
        #   - `UYU` - Uruguayan Peso
        #   - `UYP` - Uruguayan Peso (1975–1993)
        #   - `UYI` - Uruguayan Peso (Indexed Units)
        #   - `UZS` - Uzbekistani Som
        #   - `VUV` - Vanuatu Vatu
        #   - `VES` - Venezuelan Bolívar
        #   - `VEB` - Venezuelan Bolívar (1871–2008)
        #   - `VEF` - Venezuelan Bolívar (2008–2018)
        #   - `VND` - Vietnamese Dong
        #   - `VNN` - Vietnamese Dong (1978–1985)
        #   - `CHE` - WIR Euro
        #   - `CHW` - WIR Franc
        #   - `XOF` - West African CFA Franc
        #   - `YDD` - Yemeni Dinar
        #   - `YER` - Yemeni Rial
        #   - `YUN` - Yugoslavian Convertible Dinar (1990–1992)
        #   - `YUD` - Yugoslavian Hard Dinar (1966–1990)
        #   - `YUM` - Yugoslavian New Dinar (1994–2002)
        #   - `YUR` - Yugoslavian Reformed Dinar (1992–1993)
        #   - `ZWN` - ZWN
        #   - `ZRN` - Zairean New Zaire (1993–1998)
        #   - `ZRZ` - Zairean Zaire (1971–1993)
        #   - `ZMW` - Zambian Kwacha
        #   - `ZMK` - Zambian Kwacha (1968–2012)
        #   - `ZWD` - Zimbabwean Dollar (1980–2008)
        #   - `ZWR` - Zimbabwean Dollar (2008)
        #   - `ZWL` - Zimbabwean Dollar (2009)
        @pay_currency = pay_currency
        # @type [Hris::EmploymentPayGroup] The employment's pay group
        @pay_group = pay_group
        # @type [Hris::EmploymentFlsaStatus] The position's FLSA status.
        #   - `EXEMPT` - EXEMPT
        #   - `SALARIED_NONEXEMPT` - SALARIED_NONEXEMPT
        #   - `NONEXEMPT` - NONEXEMPT
        #   - `OWNER` - OWNER
        @flsa_status = flsa_status
        # @type [DateTime] The position's effective date.
        @effective_date = effective_date
        # @type [Hris::EmploymentEmploymentType] The position's type of employment.
        #   - `FULL_TIME` - FULL_TIME
        #   - `PART_TIME` - PART_TIME
        #   - `INTERN` - INTERN
        #   - `CONTRACTOR` - CONTRACTOR
        #   - `FREELANCE` - FREELANCE
        @employment_type = employment_type
        # @type [Boolean] Indicates whether or not this object has been deleted in the third party platform.
        @remote_was_deleted = remote_was_deleted
        # @type [DateTime]
        @created_at = created_at
        # @type [DateTime] This is the datetime that this object was last updated by Merge
        @modified_at = modified_at
        # @type [Hash{String => String}]
        @field_mappings = field_mappings
        # @type [Array<Hris::RemoteData>]
        @remote_data = remote_data
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of Employment
      #
      # @param json_object [JSON]
      # @return [Hris::Employment]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        id = struct.id
        remote_id = struct.remote_id
        if parsed_json["employee"].nil?
          employee = nil
        else
          employee = parsed_json["employee"].to_json
          employee = Hris::EmploymentEmployee.from_json(json_object: employee)
        end
        job_title = struct.job_title
        pay_rate = struct.pay_rate
        if parsed_json["pay_period"].nil?
          pay_period = nil
        else
          pay_period = parsed_json["pay_period"].to_json
          pay_period = Hris::EmploymentPayPeriod.from_json(json_object: pay_period)
        end
        if parsed_json["pay_frequency"].nil?
          pay_frequency = nil
        else
          pay_frequency = parsed_json["pay_frequency"].to_json
          pay_frequency = Hris::EmploymentPayFrequency.from_json(json_object: pay_frequency)
        end
        if parsed_json["pay_currency"].nil?
          pay_currency = nil
        else
          pay_currency = parsed_json["pay_currency"].to_json
          pay_currency = Hris::EmploymentPayCurrency.from_json(json_object: pay_currency)
        end
        if parsed_json["pay_group"].nil?
          pay_group = nil
        else
          pay_group = parsed_json["pay_group"].to_json
          pay_group = Hris::EmploymentPayGroup.from_json(json_object: pay_group)
        end
        if parsed_json["flsa_status"].nil?
          flsa_status = nil
        else
          flsa_status = parsed_json["flsa_status"].to_json
          flsa_status = Hris::EmploymentFlsaStatus.from_json(json_object: flsa_status)
        end
        effective_date = (DateTime.parse(parsed_json["effective_date"]) unless parsed_json["effective_date"].nil?)
        if parsed_json["employment_type"].nil?
          employment_type = nil
        else
          employment_type = parsed_json["employment_type"].to_json
          employment_type = Hris::EmploymentEmploymentType.from_json(json_object: employment_type)
        end
        remote_was_deleted = struct.remote_was_deleted
        created_at = (DateTime.parse(parsed_json["created_at"]) unless parsed_json["created_at"].nil?)
        modified_at = (DateTime.parse(parsed_json["modified_at"]) unless parsed_json["modified_at"].nil?)
        field_mappings = struct.field_mappings
        remote_data = parsed_json["remote_data"]&.map do |v|
          v = v.to_json
          Hris::RemoteData.from_json(json_object: v)
        end
        new(id: id, remote_id: remote_id, employee: employee, job_title: job_title, pay_rate: pay_rate,
            pay_period: pay_period, pay_frequency: pay_frequency, pay_currency: pay_currency, pay_group: pay_group, flsa_status: flsa_status, effective_date: effective_date, employment_type: employment_type, remote_was_deleted: remote_was_deleted, created_at: created_at, modified_at: modified_at, field_mappings: field_mappings, remote_data: remote_data, additional_properties: struct)
      end

      # Serialize an instance of Employment to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "id": @id,
          "remote_id": @remote_id,
          "employee": @employee,
          "job_title": @job_title,
          "pay_rate": @pay_rate,
          "pay_period": @pay_period,
          "pay_frequency": @pay_frequency,
          "pay_currency": @pay_currency,
          "pay_group": @pay_group,
          "flsa_status": @flsa_status,
          "effective_date": @effective_date,
          "employment_type": @employment_type,
          "remote_was_deleted": @remote_was_deleted,
          "created_at": @created_at,
          "modified_at": @modified_at,
          "field_mappings": @field_mappings,
          "remote_data": @remote_data
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.id&.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.remote_id&.is_a?(String) != false || raise("Passed value for field obj.remote_id is not the expected type, validation failed.")
        obj.employee.nil? || Hris::EmploymentEmployee.validate_raw(obj: obj.employee)
        obj.job_title&.is_a?(String) != false || raise("Passed value for field obj.job_title is not the expected type, validation failed.")
        obj.pay_rate&.is_a?(Float) != false || raise("Passed value for field obj.pay_rate is not the expected type, validation failed.")
        obj.pay_period.nil? || Hris::EmploymentPayPeriod.validate_raw(obj: obj.pay_period)
        obj.pay_frequency.nil? || Hris::EmploymentPayFrequency.validate_raw(obj: obj.pay_frequency)
        obj.pay_currency.nil? || Hris::EmploymentPayCurrency.validate_raw(obj: obj.pay_currency)
        obj.pay_group.nil? || Hris::EmploymentPayGroup.validate_raw(obj: obj.pay_group)
        obj.flsa_status.nil? || Hris::EmploymentFlsaStatus.validate_raw(obj: obj.flsa_status)
        obj.effective_date&.is_a?(DateTime) != false || raise("Passed value for field obj.effective_date is not the expected type, validation failed.")
        obj.employment_type.nil? || Hris::EmploymentEmploymentType.validate_raw(obj: obj.employment_type)
        obj.remote_was_deleted&.is_a?(Boolean) != false || raise("Passed value for field obj.remote_was_deleted is not the expected type, validation failed.")
        obj.created_at&.is_a?(DateTime) != false || raise("Passed value for field obj.created_at is not the expected type, validation failed.")
        obj.modified_at&.is_a?(DateTime) != false || raise("Passed value for field obj.modified_at is not the expected type, validation failed.")
        obj.field_mappings&.is_a?(Hash) != false || raise("Passed value for field obj.field_mappings is not the expected type, validation failed.")
        obj.remote_data&.is_a?(Array) != false || raise("Passed value for field obj.remote_data is not the expected type, validation failed.")
      end
    end
  end
end

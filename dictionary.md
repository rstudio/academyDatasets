academyDatasets Data
================

-   [`covid`](#covid-19-us-historical-data-by-state)
-   [`encounters`](#patient-encounter)
-   [`fda_adverse_daily`](#daily-counts-of-fda-drug-adverse-event-reports)
-   [`fda_pt_drugs`](#patient-and-drug-information-for-fda-drug-adverse-events)
-   [`flu`](#protein-sequences-of-influenza-b-virus-strains)
-   [`mdrd`](#modification-of-diet-in-renal-disease)
-   [`mdrd_supplemental`](#modification-of-diet-in-renal-disease---supplemental)
-   [`medications`](#patient-medication)
-   [`ny_air`](#daily-predicted-new-york-air-quality)
-   [`sdtm_adverse_events`](#sdtm-formatted-adverse-event)
-   [`sdtm_concomitant_meds`](#sdtm-formatted-concomitant-medication)
-   [`sdtm_demographics`](#sdtm-formatted-demographic)
-   [`sdtm_lab_results`](#sdtm-laboratory-test-results)
-   [`sdtm_subject_visits`](#sdtm-subject-visits)
-   [`sdtm_vital_signs`](#sdtm-vital-signs)
-   [`vaccines`](#covid-19-vaccine-allocation)

## COVID-19 US Historical Data by State

`covid` has 6 columns and 20,780 rows.

| Column           | Type    | Description                                                                                                                                                         |
|:-----------------|:--------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| date             | double  | NA                                                                                                                                                                  |
| state            | integer | Two-letter abbreviation for the state or territory.                                                                                                                 |
| tests            | double  | Daily increase in totalTestResults, calculated from the previous day’s value. (Original: totalTestResultsIncrease)                                                  |
| cases            | double  | The daily increase in API field positive, which measures Cases (confirmed plus probable) calculated based on the previous day’s value. (Original: positiveIncrease) |
| hospitalizations | double  | Daily increase in hospitalizedCumulative, calculated from the previous day’s value. (Original: hospitalizedIncrease)                                                |
| deaths           | double  | Daily increase in death, calculated from the previous day’s value. (Original: deathIncrease)                                                                        |

    ── Data Summary ────────────────────────
                               Values
    Name                       covid 
    Number of rows             20780 
    Number of columns          6     
    _______________________          
    Column type frequency:           
      Date                     1     
      factor                   1     
      numeric                  4     
    ________________________         
    Group variables            None  

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min        max        median     n_unique
    1 date                  0             1 2020-01-13 2021-03-07 2020-09-03      420

    ── Variable type: factor ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate ordered n_unique top_counts                        
    1 state              2153         0.896 FALSE         50 WA: 420, MA: 411, VA: 406, FL: 404

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable    n_missing complete_rate    mean      sd      p0   p25   p50    p75   p100 hist 
    1 tests                    0             1 17508.  33586.  -130545 1206.  6125 19086. 473076 ▁▇▁▁▁
    2 cases                    0             1  1384.   3024.    -7757   65    435  1335.  71734 ▇▁▁▁▁
    3 hospitalizations         0             1    37.4   208.   -12257    0      0    36   16373 ▁▁▇▁▁
    4 deaths                   0             1    24.8    60.2    -201    0      6    24    2559 ▇▁▁▁▁

## Patient encounter

`encounters` has 15 columns and 53,346 rows.

| Column              | Type      | Description                                                                                                                             |
|:--------------------|:----------|:----------------------------------------------------------------------------------------------------------------------------------------|
| id                  | character | Primary Key. Unique Identifier of the encounter.                                                                                        |
| start               | double    | The date and time the encounter started.                                                                                                |
| stop                | double    | The date and time the encounter concluded.                                                                                              |
| patient             | character | Foreign key to the Patient.                                                                                                             |
| organization        | character | Foreign key to the Organization.                                                                                                        |
| provider            | character | Foreign key to the Provider.                                                                                                            |
| payer               | character | Foreign key to the Payer.                                                                                                               |
| encounterclass      | character | The class of the encounter, such as ambulatory, emergency, inpatient, wellness, or urgentcare                                           |
| code                | double    | Encounter code from SNOMED-CT                                                                                                           |
| description         | character | Description of the type of encounter.                                                                                                   |
| base_encounter_cost | double    | The base cost of the encounter, not including any line item costs related to medications, immunizations, procedures, or other services. |
| total_claim_cost    | double    | The total cost of the encounter, including all line items.                                                                              |
| payer_coverage      | double    | The amount of cost covered by the Payer.                                                                                                |
| reasoncode          | double    | Diagnosis code from SNOMED-CT, only if this encounter targeted a specific condition.                                                    |
| reasondescription   | character | Description of the reason code.                                                                                                         |

    ── Data Summary ────────────────────────
                               Values    
    Name                       encounters
    Number of rows             53346     
    Number of columns          15        
    _______________________              
    Column type frequency:               
      character                8         
      numeric                  5         
      POSIXct                  2         
    ________________________             
    Group variables            None      

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable     n_missing complete_rate   min   max empty n_unique whitespace
    1 id                        0         1        36    36     0    53346          0
    2 patient                   0         1        36    36     0     1171          0
    3 organization              0         1        36    36     0     1103          0
    4 provider                  0         1        36    36     0     1104          0
    5 payer                     0         1        36    36     0       10          0
    6 encounterclass            0         1         8    10     0        6          0
    7 description               0         1         6    70     0       50          0
    8 reasondescription     39569         0.258     4    69     0       80          0

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable       n_missing complete_rate    mean      sd         p0         p25         p50         p75    p100 hist 
    1 code                        0         1     2.68e 8 1.57e 8 22298006   162673000   185347001   390906007   7.03e 8 ▁▇▃▁▁
    2 base_encounter_cost         0         1     1.29e 2 4.58e 0       77.5       129.        129.        129.  1.29e 2 ▁▁▁▁▇
    3 total_claim_cost            0         1     1.29e 2 4.58e 0       77.5       129.        129.        129.  1.29e 2 ▁▁▁▁▇
    4 payer_coverage              0         1     6.20e 1 4.36e 1        0          17.5        69.2        89.2 1.29e 2 ▅▁▇▃▃
    5 reasoncode              39569         0.258 1.25e12 1.20e13  6072007    55822004    72892002   195967001   1.24e14 ▇▁▁▁▁

    ── Variable type: POSIXct ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min                 max                 median              n_unique
    1 start                 0             1 1912-07-21 19:05:21 2020-04-28 18:58:37 2011-08-08 08:50:18    50029
    2 stop                  0             1 1912-07-21 19:20:21 2020-04-28 19:28:37 2011-08-17 13:30:04    52461

## Daily counts of FDA drug adverse event reports

`fda_adverse_daily` has 3 columns and 5,968 rows.

| Column       | Type   | Description                                                               |
|:-------------|:-------|:--------------------------------------------------------------------------|
| receive_date | double | Date that the report was first received by FDA.                           |
| public       | double | Number of reports that were submitted directly by a member of the public. |
| manufacturer | double | Number of reports that were submitted through a drug manufacturer.        |

    ── Data Summary ────────────────────────
                               Values           
    Name                       fda_adverse_daily
    Number of rows             5968             
    Number of columns          3                
    _______________________                     
    Column type frequency:                      
      Date                     1                
      numeric                  2                
    ________________________                    
    Group variables            None             

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min        max        median     n_unique
    1 receive_date          0             1 2004-01-01 2020-12-31 2012-10-28     5968

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate  mean    sd    p0   p25   p50   p75  p100 hist 
    1 public                0             1  123.  111.     0   39    102  171    751 ▇▂▁▁▁
    2 manufacturer          0             1 2044. 2058.     0  436.  1294 3457. 23015 ▇▁▁▁▁

## Patient and drug information for FDA drug adverse events

`fda_pt_drugs` has 17 columns and 5,765 rows.

| Column          | Type      | Description                                                                                                                                                                                                      |
|:----------------|:----------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| report_id       | character | The 8-digit Safety Report ID number, also known as the case report number or case ID. Can be used to identify or find a specific adverse event report.                                                           |
| receive_date    | double    | Date that the report was first received by FDA.                                                                                                                                                                  |
| receipt_date    | double    | Date that the most recent information in the report was received by FDA.                                                                                                                                         |
| country         | character | The name of the country where the adverse event occurred.                                                                                                                                                        |
| reporter        | character | Category of individual who submitted the report: physician, pharmacist, other health professional, laywer or consumer/non-health professional.                                                                   |
| age             | double    | Age of the patient when the adverse event first occured.                                                                                                                                                         |
| sex             | character | The sex of the patient.                                                                                                                                                                                          |
| weight          | double    | The patient weight, in kilograms (kg).                                                                                                                                                                           |
| drug            | character | Drug name. This may be the valid trade name of the product (e.g. “advil” or “aleve”) or the generic name (e.g. “ibuprofen”).                                                                                     |
| dosage          | double    | The number portion of a dosage; when combined with `dosage_unit` the complete dosage information is represented.                                                                                                 |
| dosage_unit     | character | The drug dosasge unit: kilograms (kg), grams (g), milligrams (mg) or micrograms (ug).                                                                                                                            |
| indication      | character | Indication for the drug’s use.                                                                                                                                                                                   |
| drug_start_date | double    | Date the patient began taking the drug.                                                                                                                                                                          |
| drug_end_date   | double    | Date the patient stopped taking the drug.                                                                                                                                                                        |
| serious         | logical   | A logical value indicating whether or not the adverse event was serious, i.e. resulted in death, a life threatening condition, hospitalization, disability, congenital anomaly, or some other serious condition. |
| reaction        | character | Patient reaction, as a term from the Medical Dictionary for Regulatory Activities, encoded in British English.                                                                                                   |
| outcome         | character | Outcome of the patient reaction at the time of last observation: recovered, recovering, not recovered, recovered with sequelae (consequent health issues), fatal or unknown.                                     |

    ── Data Summary ────────────────────────
                               Values      
    Name                       fda_pt_drugs
    Number of rows             5765        
    Number of columns          17          
    _______________________                
    Column type frequency:                 
      character                9           
      Date                     4           
      logical                  1           
      numeric                  3           
    ________________________               
    Group variables            None        

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    1 report_id             0             1     8     8     0      851          0
    2 country               0             1     2     2     0       41          0
    3 reporter              0             1     6    11     0        5          0
    4 sex                   0             1     4     6     0        2          0
    5 drug                  0             1     2    46     0      653          0
    6 dosage_unit           0             1     1     2     0        3          0
    7 indication            0             1     4    57     0      370          0
    8 reaction              0             1     4    57     0     1058          0
    9 outcome               0             1     5    23     0        6          0

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable   n_missing complete_rate min        max        median     n_unique
    1 receive_date            0             1 2019-01-01 2019-01-10 2019-01-04       10
    2 receipt_date            0             1 2019-01-01 2021-03-15 2019-01-18      209
    3 drug_start_date         0             1 2002-08-01 2019-10-29 2018-06-22      582
    4 drug_end_date           0             1 2002-08-01 2019-11-20 2018-10-11      514

    ── Variable type: logical ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate  mean count              
    1 serious               0             1 0.942 TRU: 5433, FAL: 332

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate  mean    sd    p0   p25   p50   p75   p100 hist 
    1 age                   0             1  56.9  19.4  0     45      60    71    95  ▁▂▃▇▃
    2 weight                0             1  68.7  20.2  0.72  56.8    64    81   200. ▁▇▃▁▁
    3 dosage                0             1 257.  698.   0.02  15      80   300 18400  ▇▁▁▁▁

## Protein Sequences of Influenza B Virus Strains

`flu` has 16 columns and 130,560 rows.

| Column              | Type      | Description                                                                                                                                                                                  |
|:--------------------|:----------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| protein             | character | Abbreviation of viral protein                                                                                                                                                                |
| sequence_accession  | character | Unique identifier given to the protein sequence record to allow for tracking of different versions of that sequence.                                                                         |
| complete_genome     | character | Is the viral strain’s complete genome known?                                                                                                                                                 |
| complete_sequence   | character | Is the complete sequence of this viral protein known?                                                                                                                                        |
| segment             | double    | One of eight single-stranded RNA segments that encodes the viral protein                                                                                                                     |
| segment_length      | double    | Number of RNA nucleotides in segment                                                                                                                                                         |
| collection_date     | double    | Date of sample collection                                                                                                                                                                    |
| host_species        | character | Species that the viral strain infects                                                                                                                                                        |
| country             | character | Country of strain origin                                                                                                                                                                     |
| state_province      | character | State or province of origin if applicable                                                                                                                                                    |
| geographic_grouping | character | Geographic origin of viral strain                                                                                                                                                            |
| flu_season          | character | For geographic regions in the northern hemisphere, the two digit year for the fall and winter season when the strain was recorded.                                                           |
| strain_name         | character | Name of viral strain                                                                                                                                                                         |
| sequence            | character | Protein sequence in amino acid                                                                                                                                                               |
| submission_date     | double    | Date of entry submission                                                                                                                                                                     |
| passage_history     | character | An indicator of what cell line was used for culturing the virus. Nomenclature for passage history is notoriously unstandardized. See <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6599686/> |

    ── Data Summary ────────────────────────
                               Values
    Name                       flu   
    Number of rows             130560
    Number of columns          16    
    _______________________          
    Column type frequency:           
      character                12    
      Date                     2     
      numeric                  2     
    ________________________         
    Group variables            None  

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
       skim_variable       n_missing complete_rate   min   max empty n_unique whitespace
     1 protein                  3729         0.971     2     3     0       11          0
     2 sequence_accession          0         1         6     8     0    96956          0
     3 complete_genome             0         1         2     3     0        2          0
     4 complete_sequence           0         1         8     8     0        1          0
     5 host_species               13         1.00      5    11     0        3          0
     6 country                    11         1.00      3    14     0       53          0
     7 state_province          31140         0.761     4    20     0       52          0
     8 geographic_grouping         2         1.00      4    13     0        6          0
     9 flu_season              35537         0.728     5     5     0       29          0
    10 strain_name                 0         1         7    39     0    15091          0
    11 sequence                    1         1.00     99   771     0    19936          0
    12 passage_history         56199         0.570     2    30     0     1658          0

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable   n_missing complete_rate min        max        median     n_unique
    1 collection_date        22          1.00 0001-02-23 2186-07-07 2016-07-05     4084
    2 submission_date         2          1.00 1993-08-02 2020-04-29 2017-08-24      394

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable  n_missing complete_rate    mean     sd    p0   p25   p50   p75  p100 hist 
    1 segment                0             1    5.19   2.25     1     3     6     7     8 ▃▂▅▅▇
    2 segment_length         0             1 1628.   480.    1024  1154  1530  2181  2396 ▇▅▃▁▆

## Modification of Diet in Renal Disease

`mdrd` has 10 columns and 1,988 rows.

| Column         | Type   | Description                                                                                                      |
|:---------------|:-------|:-----------------------------------------------------------------------------------------------------------------|
| ptid           | double | Patient identifier                                                                                               |
| gfr            | double | Glomerular filtration rate in milliliters per minute. A measure of how much blood the kidneys filter per minute. |
| months         | double | Number of months after the start of the study that the measurement was taken.                                    |
| dietl_normbp   | double | Was the participant assigned to the low-protein, normal-blood pressure diet? (0 = No, 1 = Yes)                   |
| dietl_lowbp    | double | Was the participant assigned to the low-protein, low-blood prssure diet? (0 = No, 1 = Yes)                       |
| dietk_normbp   | double | Was the participant assigned to the very low-protein, normal-blood pressure diet? (0 = No, 1 = Yes)              |
| dietk_lowbp    | double | Was the participant assigned to the very low-protein, low-blood pressure diet? (0 = No, 1 = Yes)                 |
| log_protein    | double | Logarithm of the grams of protein consumed per day.                                                              |
| followupmonths | double | Number of months until patient follow-up.                                                                        |
| dropout        | double | Did the patient drop out of the study? (0 = No, 1 = Yes)                                                         |

    ── Data Summary ────────────────────────
                               Values
    Name                       mdrd  
    Number of rows             1988  
    Number of columns          10    
    _______________________          
    Column type frequency:           
      numeric                  10    
    ________________________         
    Group variables            None  

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
       skim_variable  n_missing complete_rate    mean     sd    p0   p25    p50    p75   p100 hist 
     1 ptid                   0             1 127.    73.5    1    64    128    192    255    ▇▇▇▇▇
     2 gfr                    0             1  17.1    6.09   2.38 12.7   16.5   20.6   58.4  ▃▇▂▁▁
     3 months                 0             1  13.6   11.5    0     3.65  12.0   20.6   44.5  ▇▃▂▂▁
     4 dietl_normbp           0             1   0.243  0.429  0     0      0      0      1    ▇▁▁▁▂
     5 dietl_lowbp            0             1   0.263  0.440  0     0      0      1      1    ▇▁▁▁▃
     6 dietk_normbp           0             1   0.239  0.427  0     0      0      0      1    ▇▁▁▁▂
     7 dietk_lowbp            0             1   0.255  0.436  0     0      0      1      1    ▇▁▁▁▃
     8 log_protein            0             1  -0.552  1.41  -3.58 -1.77  -0.34   0.69   1.97 ▃▇▆▇▆
     9 followupmonths         0             1  30.1    9.42   4.47 21.6   32.2   38.0   44.5  ▁▅▃▇▇
    10 dropout                0             1   0.279  0.448  0     0      0      1      1    ▇▁▁▁▃

## Modification of Diet In Renal Disease - Supplemental

`mdrd_supplemental` has 5 columns and 255 rows.

| Column | Type      | Description        |
|:-------|:----------|:-------------------|
| ptid   | double    | Patient identifier |
| sex    | character | Sex                |
| age    | double    | Age (years)        |
| height | double    | Height (meters)    |
| weight | double    | Weight (kilograms) |

    ── Data Summary ────────────────────────
                               Values           
    Name                       mdrd_supplemental
    Number of rows             255              
    Number of columns          5                
    _______________________                     
    Column type frequency:                      
      character                1                
      numeric                  4                
    ________________________                    
    Group variables            None             

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    1 sex                   0             1     1     1     0        2          0

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   mean     sd    p0   p25    p50    p75   p100 hist 
    1 ptid                  0             1 128    73.8    1    64.5  128    192.   255    ▇▇▇▇▇
    2 age                   0             1  68.8   5.37  55.0  64.9   69.1   73.0   83.3  ▂▆▇▆▁
    3 height                0             1   1.68  0.104  1.42  1.60   1.67   1.75   1.96 ▂▇▇▆▂
    4 weight                0             1  80.7  19.7   45.0  65.9   79.4   93.5  157.   ▆▇▅▁▁

## Patient medication

`medications` has 13 columns and 42,989 rows.

| Column            | Type      | Description                                                                  |
|:------------------|:----------|:-----------------------------------------------------------------------------|
| start             | double    | The date and time the medication was prescribed.                             |
| stop              | double    | The date and time the prescription ended, if applicable.                     |
| patient           | character | Foreign key to the Patient.                                                  |
| payer             | character | Foreign key to the Payer.                                                    |
| encounter         | character | Foreign key to the Encounter where the medication was prescribed.            |
| code              | double    | Medication code from RxNorm.                                                 |
| description       | character | Description of the medication.                                               |
| base_cost         | double    | The line item cost of the medication.                                        |
| payer_coverage    | double    | The amount covered or reimbursed by the Payer.                               |
| dispenses         | double    | The number of times the prescription was filled.                             |
| totalcost         | double    | The total cost of the prescription, including all dispenses.                 |
| reasoncode        | double    | Diagnosis code from SNOMED-CT specifying why this medication was prescribed. |
| reasondescription | character | Description of the reason code.                                              |

    ── Data Summary ────────────────────────
                               Values     
    Name                       medications
    Number of rows             42989      
    Number of columns          13         
    _______________________               
    Column type frequency:                
      character                5          
      numeric                  6          
      POSIXct                  2          
    ________________________              
    Group variables            None       

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable     n_missing complete_rate   min   max empty n_unique whitespace
    1 patient                   0         1        36    36     0     1107          0
    2 payer                     0         1        36    36     0       10          0
    3 encounter                 0         1        36    36     0    27269          0
    4 description               0         1        15   113     0      134          0
    5 reasondescription     11117         0.741     4    69     0       36          0

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable  n_missing complete_rate    mean      sd          p0        p25       p50        p75    p100 hist 
    1 code                   0         1     6.44e 5 4.92e 5   105078      309362     583214     865098  2.12e 6 ▇▆▂▁▁
    2 base_cost              0         1     3.20e 2 7.73e 2        0.99       65.8      263.       263. 7.02e 3 ▇▁▁▁▁
    3 payer_coverage         0         1     1.47e 2 6.29e 2        0           0          0        188. 6.95e 3 ▇▁▁▁▁
    4 dispenses              0         1     1.05e 1 4.04e 1        1           1          5         12  8.85e 2 ▇▁▁▁▁
    5 totalcost              0         1     2.33e 3 1.26e 4        0.99      263.       527.      3162. 1.30e 6 ▇▁▁▁▁
    6 reasoncode         11117         0.741 1.32e11 2.99e12 10509002    55822004   59621000  233678006  6.78e13 ▇▁▁▁▁

    ── Variable type: POSIXct ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min                 max                 median              n_unique
    1 start                 0         1     1913-06-17 04:54:18 2020-04-28 18:58:37 2005-03-19 21:31:22    25996
    2 stop               1895         0.956 1913-06-24 04:54:18 2020-04-28 18:58:37 2005-05-27 20:51:21    24778

## Daily predicted New York air quality

`ny_air` has 4 columns and 22,692 rows.

| Column      | Type   | Description                                    |
|:------------|:-------|:-----------------------------------------------|
| date        | double | Date                                           |
| county      | double | County                                         |
| pm25_max    | double | Maximum predicted value of PM2.5 concentration |
| pm25_median | double | Median predicted value of PM2.5 concentration  |

    ── Data Summary ────────────────────────
                               Values
    Name                       ny_air
    Number of rows             22692 
    Number of columns          4     
    _______________________          
    Column type frequency:           
      Date                     1     
      numeric                  3     
    ________________________         
    Group variables            None  

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min        max        median     n_unique
    1 date                  0             1 2016-01-01 2016-12-31 2016-07-01      366

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate  mean    sd    p0   p25   p50   p75  p100 hist 
    1 county                0             1 62    35.8  1     31    62    93    123   ▇▇▇▇▇
    2 pm25_max              0             1  7.05  3.52 0.753  4.56  6.37  8.82  31.0 ▇▆▁▁▁
    3 pm25_median           0             1  6.55  3.31 0.629  4.20  5.91  8.23  30.1 ▇▅▁▁▁

## SDTM formatted Adverse Event

`sdtm_adverse_events` has 14 columns and 357 rows.

| Column   | Type      | Description                                                                                            |
|:---------|:----------|:-------------------------------------------------------------------------------------------------------|
| USUBJID  | character | Unique Subject Identifier                                                                              |
| AESEQ    | double    | Sequence Number                                                                                        |
| AESTDT   | double    | Start date of the adverse event                                                                        |
| AESTDY   | double    | The number of days the subject had been enrolled in the study when the adverse event began.            |
| AEENDT   | double    | End date of the adverse event                                                                          |
| AEENDY   | double    | The number of days the subject had been enrolled in the study when the adverse event ended.            |
| AETERM   | character | The reported term for the adverse event, i.e. how the reporter described the adverse event.            |
| AEDECOD  | character | The official term for the adverse event, i.e. the dictionary derived description of the adverse event. |
| AEBODSYS | character | Body system or organ class involved in the adverse event.                                              |
| AESER    | character | Was the adverse event serious? `Y` = Yes, `N` = No.                                                    |
| AEONGO   | character | Is the adverse event ongoing? `Y` = Yes, `N` = No.                                                     |
| AESEV    | character | Severity of the adverse event.                                                                         |
| AEREL    | character | The investigator’s opinion as to whether or not the adverse event was related to the study treatment.  |
| AEOUT    | character | Outcome of the adverse event.                                                                          |

    ── Data Summary ────────────────────────
                               Values             
    Name                       sdtm_adverse_events
    Number of rows             357                
    Number of columns          14                 
    _______________________                       
    Column type frequency:                        
      character                9                  
      Date                     2                  
      numeric                  3                  
    ________________________                      
    Group variables            None               

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    1 USUBJID               0             1     6     6     0      114          0
    2 AETERM                0             1     4   227     0      286          0
    3 AEDECOD               0             1     4    37     0      286          0
    4 AEBODSYS              0             1    13    66     0       25          0
    5 AESER                 0             1     1     1     0        2          0
    6 AEONGO                0             1     1     1     0        2          0
    7 AESEV                 0             1     4     8     0        3          0
    8 AEREL                 0             1    11    18     0        5          0
    9 AEOUT                 0             1     9    25     0        4          0

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min        max        median     n_unique
    1 AESTDT                0             1 2015-02-05 2016-12-05 2015-12-19      272
    2 AEENDT                0             1 2015-03-25 2016-12-10 2016-02-29      248

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   mean     sd    p0   p25   p50   p75  p100 hist 
    1 AESEQ                 0             1   2.39   1.26     1     1     2     3     5 ▇▆▆▃▂
    2 AESTDY                0             1 175.   103.       1    87   175   261   364 ▇▇▇▇▆
    3 AEENDY                0             1 265.    84.1     19   203   286   337   365 ▁▂▃▅▇

## SDTM formatted Concomitant Medication

`sdtm_concomitant_meds` has 12 columns and 307 rows.

| Column   | Type      | Description                                                                                          |
|:---------|:----------|:-----------------------------------------------------------------------------------------------------|
| USUBJID  | character | Unique Subject Identifier                                                                            |
| CMSEQ    | double    | Sequence Number                                                                                      |
| CMSTDT   | double    | Start date of the concomitant medication                                                             |
| CMSTDY   | double    | The number of days the subject had been enrolled in the study when the concomitant medication began. |
| CMENDT   | double    | End date of the concomitant medication                                                               |
| CMENDY   | double    | The number of days the subject had been enrolled in the study when the concomitant medication ended. |
| CMTRT    | character | Reported name of the concomitant medication, i.e concomitant treatment                               |
| PREFTERM | character | The nonproprietary, i.e. generic, name of the concomitant medication                                 |
| ATCTEXT2 | character | Anatomical Therapeutic Chemical (ATC) of the concomitant medication                                  |
| CMONGO   | character | Is the concomitant medication ongoing? `Y` = Yes, `N` = No                                           |
| CMDOSE   | double    | Amount of concomitant medication taken per administration (dose)                                     |
| CMROUTE  | character | Route of administration of the concomitant medication                                                |

    ── Data Summary ────────────────────────
                               Values               
    Name                       sdtm_concomitant_meds
    Number of rows             307                  
    Number of columns          12                   
    _______________________                         
    Column type frequency:                          
      character                6                    
      Date                     2                    
      numeric                  4                    
    ________________________                        
    Group variables            None                 

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    1 USUBJID               0             1     6     6     0      104          0
    2 CMTRT                 0             1     3    37     0      251          0
    3 PREFTERM              0             1     7    40     0      236          0
    4 ATCTEXT2              0             1    11    36     0       14          0
    5 CMONGO                0             1     1     1     0        2          0
    6 CMROUTE               0             1     6    14     0        5          0

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min        max        median     n_unique
    1 CMSTDT                0             1 2015-01-23 2016-12-22 2015-12-27      234
    2 CMENDT                0             1 2015-01-28 2016-12-27 2016-03-16      222

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   mean     sd    p0   p25   p50   p75  p100 hist 
    1 CMSEQ                 0             1   2.26   1.18     1     1     2    3      5 ▇▆▅▃▁
    2 CMSTDY                0             1 173.   110.       1    76   170  270.   365 ▇▆▇▆▆
    3 CMENDY                0             1 262.    85.9      9   206   281  337    365 ▁▂▃▅▇
    4 CMDOSE                0             1   2.92   1.45     1     2     3    4      5 ▇▇▆▆▇

## SDTM formatted Demographic

`sdtm_demographics` has 14 columns and 150 rows.

| Column   | Type      | Description                                                                                                                                                                                                                      |
|:---------|:----------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| USUBJID  | character | Unique Subject Identifier                                                                                                                                                                                                        |
| SITE     | character | Name of study site                                                                                                                                                                                                               |
| SITEID   | character | Study Site Identifier                                                                                                                                                                                                            |
| AGE      | double    | Age of subject                                                                                                                                                                                                                   |
| SEX      | character | Sex of subject                                                                                                                                                                                                                   |
| RACE     | character | Race of subject                                                                                                                                                                                                                  |
| ARM      | character | Treatment arm that subject is assigned to                                                                                                                                                                                        |
| ARMCD    | character | Code for treatment arm that subject is assigned to                                                                                                                                                                               |
| SBJTSTAT | character | Subject status in study                                                                                                                                                                                                          |
| RFSTDTC  | double    | Reference start date. Usually the day the subject begins treatment.                                                                                                                                                              |
| RFENDTC  | double    | Reference end date. Usually the day the subject takes their last treatment.                                                                                                                                                      |
| RFENDY   | double    | The number of days after the RFSTDTC that the RFENDTC occurred, i.e. the number of days the subject spent in the study/in treatment                                                                                              |
| SAFFL    | character | Safety population flag. Did the subject actually receive a treatment (including placebo) and should therefore be included in the population of subjects studied to determine the safety of the treatment? `Y` = Yes and `N` = No |
| SAFFN    | double    | Numeric coding of safety population flag. `Y` = Yes and `N` = No                                                                                                                                                                 |

    ── Data Summary ────────────────────────
                               Values           
    Name                       sdtm_demographics
    Number of rows             150              
    Number of columns          14               
    _______________________                     
    Column type frequency:                      
      character                9                
      Date                     2                
      numeric                  3                
    ________________________                    
    Group variables            None             

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    1 USUBJID               0             1     6     6     0      150          0
    2 SITE                  0             1    16    16     0        5          0
    3 SITEID                0             1     2     2     0        5          0
    4 SEX                   0             1     1     1     0        2          0
    5 RACE                  0             1     5    11     0        4          0
    6 ARM                   0             1     7    14     0        4          0
    7 ARMCD                 0             1     4     8     0        4          0
    8 SBJTSTAT              0             1     7    17     0        4          0
    9 SAFFL                 0             1     1     1     0        2          0

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min        max        median     n_unique
    1 RFSTDTC               0             1 2015-01-06 2015-12-29 2015-06-18      123
    2 RFENDTC               0             1 2015-01-18 2016-12-24 2015-12-30      134

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate  mean      sd    p0   p25   p50   p75  p100 hist 
    1 AGE                   0             1  34.7  10.9      18  25.2    35   43     55 ▇▇▆▆▅
    2 RFENDY                0             1 202.  131.        1  91.5   211  338.   375 ▆▃▅▃▇
    3 SAFFN                 0             1   0.9   0.301     0   1       1    1      1 ▁▁▁▁▇

## SDTM Laboratory Test Results

`sdtm_lab_results` has 11 columns and 13,708 rows.

| Column   | Type      | Description                                            |
|:---------|:----------|:-------------------------------------------------------|
| USUBJID  | character | Unique Subject Identifier                              |
| VISIT    | character | Protocol defined text description of the visit         |
| VISITNUM | double    | Visit number                                           |
| LBDT     | double    | Date of specimen collection                            |
| LBDY     | double    | Study day of specimen collection                       |
| LBCAT    | character | Category of the lab test performed                     |
| LBTEST   | character | Name of the lab test performed                         |
| LBSTRESU | character | Standard units for lab test result (LBSTRESN)          |
| LBSTRESN | double    | Lab test result in standard units                      |
| LBSTNRLO | double    | Lower limit of normal range lab test result            |
| LBSTNRHI | double    | Upper (high) limit of normal range for lab test result |

    ── Data Summary ────────────────────────
                               Values          
    Name                       sdtm_lab_results
    Number of rows             13708           
    Number of columns          11              
    _______________________                    
    Column type frequency:                     
      character                5               
      Date                     1               
      numeric                  5               
    ________________________                   
    Group variables            None            

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    1 USUBJID               0             1     6     6     0      135          0
    2 VISIT                 0             1     7    17     0       17          0
    3 LBCAT                 0             1     5     5     0        3          0
    4 LBTEST                0             1     3    33     0       23          0
    5 LBSTRESU              0             1     3    14     0       10          0

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min        max        median     n_unique
    1 LBDT                  0             1 2015-01-06 2016-12-31 2015-10-28      375

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   mean     sd    p0   p25    p50   p75  p100 hist 
    1 VISITNUM              0         1       2.39   2.17   0   0.175   2      4      7  ▇▂▅▁▂
    2 LBDY                  0         1     129.   115.     1   9     109    222    375  ▇▂▃▂▂
    3 LBSTRESN           1765         0.871  42.1   67.9    0   0.897   5.33  70.8  531. ▇▁▁▁▁
    4 LBSTNRLO              0         1      28.4   44.4    0   0.5     3.5   61.9  150  ▇▁▂▁▁
    5 LBSTNRHI              0         1      48.8   79.4    0.4 1.45    7.1  106    350  ▇▂▁▁▁

## SDTM Subject Visits

`sdtm_subject_visits` has 6 columns and 1,202 rows.

| Column   | Type      | Description                                                                       |
|:---------|:----------|:----------------------------------------------------------------------------------|
| USUBJID  | character | Unique Subject Identifier                                                         |
| VISIT    | character | Protocol defined text description of the visit                                    |
| VISITNUM | double    | Visit number                                                                      |
| SVDT     | double    | Subject visit date                                                                |
| SVDY     | double    | Study day of subject visit                                                        |
| SVSTATUS | character | Status of subject visit: Completed, Terminated, Missed, Expected, Overdue, Failed |

    ── Data Summary ────────────────────────
                               Values             
    Name                       sdtm_subject_visits
    Number of rows             1202               
    Number of columns          6                  
    _______________________                       
    Column type frequency:                        
      character                3                  
      Date                     1                  
      numeric                  2                  
    ________________________                      
    Group variables            None               

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    1 USUBJID               0             1     6     6     0      150          0
    2 VISIT                 0             1     7    17     0       17          0
    3 SVSTATUS              0             1     6    10     0        6          0

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min        max        median     n_unique
    1 SVDT                  0             1 2015-01-06 2016-12-31 2016-01-04      538

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   mean     sd    p0   p25   p50   p75  p100 hist 
    1 VISITNUM              0             1   3.44   2.31     0   1     3.1   5.1     7 ▇▃▇▃▇
    2 SVDY                  0             1 188.   124.       1  62.2 174   287     375 ▇▃▆▆▇

## SDTM Vital Signs

`sdtm_vital_signs` has 11 columns and 3,170 rows.

| Column   | Type      | Description                                                       |
|:---------|:----------|:------------------------------------------------------------------|
| USUBJID  | character | Unique Subject Identifier                                         |
| VISIT    | character | Protocol defined text description of the visit                    |
| VISITNUM | double    | Visit number                                                      |
| VSDT     | double    | Date vital signs were collected                                   |
| VSDY     | double    | Day of study when vital signs were collected                      |
| VSCAT    | character | Category of vital signs test                                      |
| VSTEST   | character | Name of vital signs test                                          |
| VSSTRESU | character | Standard units of vital signs test result                         |
| VSSTRESN | double    | Result of vital signs test in standard units                      |
| VSSTNRLO | double    | Lower limit of normal range for result of vital signs test        |
| VSSTNRHI | double    | Upper (high) limit of normal range for result of vital signs test |

    ── Data Summary ────────────────────────
                               Values          
    Name                       sdtm_vital_signs
    Number of rows             3170            
    Number of columns          11              
    _______________________                    
    Column type frequency:                     
      character                5               
      Date                     1               
      numeric                  5               
    ________________________                   
    Group variables            None            

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    1 USUBJID               0             1     6     6     0      128          0
    2 VISIT                 0             1     7    17     0       18          0
    3 VSCAT                 0             1    11    11     0        1          0
    4 VSTEST                0             1    10    24     0        5          0
    5 VSSTRESU              0             1     2    14     0        4          0

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min        max        median     n_unique
    1 VSDT                  0             1 2015-01-06 2016-12-18 2015-11-06      402

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   mean     sd    p0   p25   p50   p75  p100 hist 
    1 VISITNUM              0         1       2.46   2.14   0     1     2     4      7  ▇▃▅▂▂
    2 VSDY                  0         1     133.   113.     1    50   112   222    375  ▇▃▃▂▂
    3 VSSTRESN            314         0.901  58.0   31.1   11.6  36.7  56.9  78.9  153. ▇▃▅▂▁
    4 VSSTNRLO              0         1      50.5   24.6   16    36.6  50    60     90  ▃▃▇▁▃
    5 VSSTNRHI              0         1      67.4   35.4   20    37    80    80    120  ▇▁▇▁▃

## COVID-19 Vaccine Allocation

`vaccines` has 5 columns and 3,591 rows.

| Column       | Type      | Description                      |
|:-------------|:----------|:---------------------------------|
| jurisdiction | character | State or territory               |
| vaccine      | character | Vaccine type                     |
| week         | double    | Week the vaccines were allocated |
| first_dose   | double    | Number of first doses allocated  |
| second_dose  | double    | Number of second doses allocated |

    ── Data Summary ────────────────────────
                               Values  
    Name                       vaccines
    Number of rows             3591    
    Number of columns          5       
    _______________________            
    Column type frequency:             
      character                2       
      Date                     1       
      numeric                  2       
    ________________________           
    Group variables            None    

    ── Variable type: character ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    1 jurisdiction          0             1     4    20     0       63          0
    2 vaccine               0             1     6     7     0        3          0

    ── Variable type: Date ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate min        max        median     n_unique
    1 week                  0             1 2020-12-14 2021-05-31 2021-03-15       25

    ── Variable type: numeric ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      skim_variable n_missing complete_rate   mean     sd    p0   p25   p50   p75   p100 hist 
    1 first_dose            0         1     52049. 71512.     0  9600 29100 67500 672600 ▇▁▁▁▁
    2 second_dose         504         0.860 56286. 73696.     0 11700 34200 72100 672600 ▇▁▁▁▁

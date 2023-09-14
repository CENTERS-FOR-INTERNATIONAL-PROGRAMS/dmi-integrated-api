DECLARE @CurrentMonth INT;
DECLARE @CurrentYear INT;
DECLARE @LastDayOfPreviousMonth INT;
SET @CurrentMonth = MONTH(getdate()) - 1;
SET @CurrentYear = YEAR(getdate());
SET @LastDayOfPreviousMonth = DAY(EOMONTH(GETDATE()))
DECLARE @PreviousMonthLastDateIdInString VARCHAR(10);
DECLARE @PreviousMonthLastDateIdInINT INT;
SET @PreviousMonthLastDateIdInString = CAST(@CurrentYear AS VARCHAR) + CASE
        WHEN @CurrentMonth < 10 THEN + '0' + CAST(@CurrentMonth AS VARCHAR)
        ELSE CAST(@CurrentMonth AS VARCHAR)
    END + CAST(@LastDayOfPreviousMonth AS VARCHAR);
SET @PreviousMonthLastDateIdInINT = CAST(@PreviousMonthLastDateIdInString AS INT)
SELECT SUM(TotalScreened) TotalScreened,
    SUM(TotalScreenedLastMonth) TotalScreenedLastMonth,
    SUM(Eligible) Eligible,
    SUM(EligibleLastMonth) EligibleLastMonth,
    SUM(Enrolled) Enrolled,
    SUM(EnrolledLastMonth) EnrolledLastMonth,
    SUM(Tested) Tested,
    SUM(TestedLastMonth) TestedLastMonth,
    SUM(Positive) Positive,
    SUM(PositiveLastMonth) PositiveLastMonth
FROM (
        SELECT CASE
                WHEN Screened = 1 THEN 1
                ELSE 0
            END TotalScreened,
            CASE
                WHEN Screened = 1
                and ReviewDate < = @PreviousMonthLastDateIdInINT
                and ReviewDate is not null then 1
                else 0
            end TotalScreenedLastMonth,
            CASE
                WHEN Eligible = 1 THEN 1
                ELSE 0
            END Eligible,
            CASE
                WHEN Eligible = 1
                and ReviewDate < = @PreviousMonthLastDateIdInINT
                and ReviewDate is not null then 1
                else 0
            end EligibleLastMonth,
            CASE
                WHEN Enrolled = 1
                and Enrolled is not null
                and barcode is not null then 1
                else 0
            end Enrolled,
            CASE
                WHEN Enrolled = 1
                and enrolled is not null
                and barcode is not null
                and ReviewDate < = @PreviousMonthLastDateIdInINT
                and ReviewDate is not null then 1
                else 0
            end EnrolledLastMonth,
            CASE
                WHEN SampleTested = 1
                and SampleTested is not null
                and barcode is not null then 1
                else 0
            end Tested,
            CASE
                WHEN SampleTested = 1
                and SampleTested is not null
                and barcode is not null
                and ReviewDate < = @PreviousMonthLastDateIdInINT
                and ReviewDate is not null then 1
                else 0
            end TestedLastMonth,
            CASE
                WHEN Covid19Positive = 1
                and SampleTested is not null
                and barcode is not null then 1
                else 0
            end Positive,
            CASE
                WHEN Covid19Positive = 1
                and SampleTested is not null
                and barcode is not null
                and ReviewDate < = @PreviousMonthLastDateIdInINT
                and ReviewDate is not null then 1
                else 0
            end PositiveLastMonth,
            P.Facility as FacilityId,
            P.ReviewDate,
            p.EpiWeek
        FROM [dbo].[FactMortality] p
    ) A
    INNER JOIN DimDate D On A.ReviewDate = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId --{{WHERE}}--
;
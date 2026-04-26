SELECT
    b.operator,
    b.row_number,
    b.height,
    b.avg_height,
    b.stddev_height,
    b.ucl,
    b.lcl,

    CASE
        WHEN b.height NOT BETWEEN b.lcl AND b.ucl THEN TRUE
        ELSE FALSE
    END AS alert

FROM (
    SELECT
        a.*,
        a.avg_height + 3 * a.stddev_height / SQRT(5) AS ucl,
        a.avg_height - 3 * a.stddev_height / SQRT(5) AS lcl
    FROM (
        SELECT 
            operator,
            item_no,
            height,

            ROW_NUMBER() OVER (
                PARTITION BY operator
                ORDER BY item_no
            ) AS row_number,

            AVG(height) OVER (
                PARTITION BY operator
                ORDER BY item_no
                ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
            ) AS avg_height,

            STDDEV(height) OVER (
                PARTITION BY operator
                ORDER BY item_no
                ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
            ) AS stddev_height

        FROM manufacturing_parts
    ) AS a
    WHERE a.row_number >= 5
) AS b
ORDER BY b.operator, b.row_number;
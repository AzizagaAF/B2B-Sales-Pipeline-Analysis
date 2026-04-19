![Dashboard Preview](dashboard_preview.png)
<img width="1507" height="787" alt="Screenshot 2026-04-19 161854" src="https://github.com/user-attachments/assets/3fe86fe4-157b-4d09-8faf-555d7b380c52" />
1. Layihənin İcmalı (Project Overview)
Bu layihə uydurma bir kompüter avadanlığı şirkətinin B2B satış məlumatlarını təhlil etmək üçün hazırlanmışdır. Əsas məqsəd satış komandasının performansını izləmək, məhsulların satış səmərəliliyini (Win Rate) qiymətləndirmək və gəlir itkilərinin qarşısını almaq üçün rəhbərliyə interaktiv bir həll təqdim etməkdir.

2. SQL ilə Məlumatların İşlənməsi (Data Engineering & SQL)
Məlumat bazası üzərində aşağıdakı texniki işlər görülmüşdür:

Data Cleaning: Məlumat bazasındakı təkrarlanan sətirlərin silinməsi və boş (NULL) dəyərlərin (məsələn, məhsul adları və ya tarixlər) təmizlənməsi.

Table Joins: sales_pipeline, products, accounts və sales_teams cədvəllərinin SQL JOIN funksiyaları ilə əlaqələndirilməsi.

Aggregate Functions: Satış agentləri və regionlar üzrə toplam gəliri (SUM), uğurlu satışların sayını (COUNT) və ortalama sövdələşmə dəyərini hesablamaq üçün mürəkkəb sorğuların yazılması.

Feature Engineering: SQL vasitəsilə rüblər (Quarters) və satış mərhələləri (Deal Stages) üzrə qruplaşdırmalar aparılaraq analitika üçün hazır vəziyyətə gətirilməsi.

3. Excel ilə Analiz və Dashboard-un Qurulması (Data Visualization)
Datanın vizuallaşdırılması zamanı aşağıdakı analitik alətlərdən istifadə edilmişdir:

Dinamik Dashboard: Menecerlərə (məsələn, Melvin Marxen) və rüblərə görə süzgəclənən (Slicers) interaktiv interfeys.

KPI Metrikləri:

Won Revenue vs. Potential Revenue: Qazanılmış və hələ potensial mərhələdə olan gəlirlərin müqayisəsi.

Win Rate & Loss Rate: Satışların uğur və uğursuzluq faizlərinin dinamik hesablanması (DAX/Measures vasitəsilə).

Vizual Analizlər:

Gauge Chart: Satış hədəflərinin icra vəziyyətinin "Sürətölçən" qrafiki ilə vizuallaşdırılması.

Top/Bottom Performers: Ən yaxşı və ən zəif nəticə göstərən satış agentlərinin müəyyən edilməsi.

Product Statistic: Məhsullar üzrə satış trendləri və fürsətlərin (Opportunities) analizi.

4. Əsas Analitik Nəticələr (Insights)
Məhsul Səmərəliliyi: Hansı məhsulların (məsələn, GTX seriyası) daha yüksək "Win Rate"-ə malik olduğu və bazarın hansı seqmentində daha çox tələbat gördüyü müəyyən edildi.

Performans Boşluqları: "Lagging Behind" olan agentlərin müəyyən edilməsi ilə onlara yönəlik təlim ehtiyacları aşkarlandı.

Gəlir İtkisi: "Loss Rate" analizi vasitəsilə satışın hansı mərhələsində ən çox itki yaşandığı (məsələn, Prospecting və ya Engaging) təsbit edildi.

5. İstifadə Olunan Texnologiyalar
SQL: Data Extraction, Joins, Aggregations.

MS Excel: Pivot Tables, Power Pivot, DAX (Data Analysis Expressions), Advanced Charting, Slicers & Timeline.

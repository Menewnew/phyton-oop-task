# phyton-oop-task

## TASK 1 BASIC OPP 
Buatlah class MarketingDataETL yang memiliki tiga metode:
- extract(): akan membaca data dari sebuah file CSV (Misalkan, marketing_data.csv)
- transform(): akan melakukan pembersihan dan transformasi sederhana pada data (seperti mengubah format tanggal atau membersihkan nilai yang kosong)
- store(): akan menyimpan data yang telah ditransformasi ke dalam struktur data DataFramet.

```py
import pandas as pd
```
```
Data berhasil disimpan di transformed_marketing_data.csv.
```
```py
class MarketingDataETL:
    def __init__(self, file_path):
        self.file_path = file_path
        self.data = None

    def extract(self):
                self.data = pd.read_csv(self.file_path, delimiter=';')
                return self.data

    def transform(self):
                self.data['purchase_date'] = pd.to_datetime(self.data['purchase_date'], format='%d/%m/%y')
                self.data.dropna(inplace=True)
                return self.data

    def store(self, output_file):
                self.data.to_csv(output_file, index=False)
                print(f"Data berhasil disimpan di {output_file}.")

data_marketing = MarketingDataETL('marketing_data.csv')
data_marketing.extract()
data_marketing.transform()
data_marketing.store('transformed_marketing_data.csv')
```

```py
pd.read_csv('transformed_marketing_data.csv')
```
| | customer_id	| purchase_date |	product_category |	amount_spent |
| ------ | ------ | ------ | ------ | ------ | 
| 0	| C001	| 2023-03-01	| Electronics	| 250.00 |
| 1	| C002	| 2023-03-02	| Books	| 45.50 |
| 2	| C003	| 2023-03-03	| Home & Garden	| 150.75 |
| 3	| C001	| 2023-03-04	| Books	| 20.00 |
| 4	| C002	| 2023-03-05	| Electronics	| 525.00 |
| 5	| C005	| 2023-03-07	| Beauty	| 75.00 |

## TASK 2 INHERITANCE & POLYMORPHISM 
- Gunakan inheritance untuk membuat class TargetedMarketingETL yang mewarisi dari MarketingDataETL.
- Tambahkan metode segment_customers() yang mengelompokkan pelanggan berdasarkan kriteria tertentu (misalnya, pengeluaran total atau kategori produk yang dibeli).
- Demonstrasi polymorphism dengan meng-override metode transform() dalam TargetedMarketingETL untuk menambahkan logika segmentasi pelanggan ke dalam proses transformasi.

```py
class MarketingDataETL:

    def __init__(self, file):
        self.file = file

    def extract(self):
        df = pd.read_csv(f'{self.file}', sep=';')

        return df

    def transform(self):
        df = self.extract()
        df['purchase_date'] = pd.to_datetime(df['purchase_date'], format='%d/%m/%y')
        df.dropna(inplace=True)
        df.reset_index(drop=True, inplace=True)

        return df

    def store(self):
        df = self.transform()
        df = pd.DataFrame(df)

        return df
```
```py
data_marketing = MarketingDataETL('marketing_data.csv')
data_marketing.extract()
data_marketing.transform()
data_marketing.store()
```

|  | customer_id | purchase_date | product_category | amount_spent |
|--------|-------------|---------------|------------------|--------------|
|   0    | C001        | 2023-03-01    | Electronics      | 250.00       |
|   1    | C002        | 2023-03-02    | Books            | 45.50        |
|   2    | C003        | 2023-03-03    | Home & Garden    | 150.75       |
|   3    | C001        | 2023-03-04    | Books            | 20.00        |
|   4    | C002        | 2023-03-05    | Electronics      | 525.00       |
|   5    | C005        | 2023-03-07    | Beauty           | 75.00        |

```py
class TargetedMarketingETL(MarketingDataETL):
    def segment_customer(self, amount_spent):
        if amount_spent > 500:
            return 'Kelas A'

        elif amount_spent > 200 and amount_spent <= 500:
            return 'Kelas B'

        elif amount_spent > 0  and amount_spent <= 200:
            return 'Kelas C'

        else:
            return 'unknown'

    def transform(self):
        df = self.extract()
        df['purchase_date'] = pd.to_datetime(df['purchase_date'], format='%d/%m/%y')
        df.dropna(inplace=True)
        df.reset_index(drop=True, inplace=True)
        df['segment'] = df['amount_spent'].apply(self.segment_customer)

        return df
```

```py
target_marketing = TargetedMarketingETL('marketing_data.csv')
target_marketing.transform()
```

|  | customer_id | purchase_date | product_category | amount_spent | segment |
|--------|-------------|---------------|------------------|--------------|---------|
| 1      | C001        | 2023-03-01    | Electronics      | 250.00       | Kelas B |
| 2      | C002        | 2023-03-02    | Books            | 45.50        | Kelas C |
| 3      | C003        | 2023-03-03    | Home & Garden    | 150.75       | Kelas C |
| 4      | C001        | 2023-03-04    | Books            | 20.00        | Kelas C |
| 5      | C002        | 2023-03-05    | Electronics      | 525.00       | Kelas A |
| 6      | C005        | 2023-03-07    | Beauty           | 75.00        | Kelas C |

```py
class MarketingDataETL:
    def transform(self, data):
        # Base transformation logic
        transformed_data = []
        for row in data:
            transformed_data.append(self.transform_row(row))
        return transformed_data

    def transform_row(self, row):
        # Base transformation logic for each row
        return row

class TargetedMarketingETL1(MarketingDataETL):
    def transform_row(self, row):
        # Add customer segmentation logic
        if row['spending'] > 1000:
            row['segment'] = 'high value'
        elif row['spending'] > 500:
            row['segment'] = 'mid value'
        else:
            row['segment'] = 'low value'
        return row
```

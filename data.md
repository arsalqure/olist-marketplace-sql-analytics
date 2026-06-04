# Dataset

This project uses the **Olist Brazilian E-Commerce Public Dataset**.

The raw CSVs are **not** committed to this repo (they are large and best obtained
from the original source). Download them here:

➡️ https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

You need these 8 files:

- `olist_customers_dataset.csv`        → import as table `customers`
- `olist_orders_dataset.csv`           → import as table `orders`
- `olist_order_items_dataset.csv`      → import as table `order_items`
- `olist_order_payments_dataset.csv`   → import as table `order_payments`
- `olist_order_reviews_dataset.csv`    → import as table `order_reviews`
- `olist_sellers_dataset.csv`          → import as table `sellers`
- `olist_products_dataset.csv`         → import as table `products`
- `product_category_name_translation.csv` → import as table `category_translation`

The Colab notebook (`notebooks/olist_analysis_colab.ipynb`) loads these
automatically once you drop them into the file panel.

License: the dataset is provided by Olist on Kaggle under its own terms; please
review the Kaggle page before redistributing.


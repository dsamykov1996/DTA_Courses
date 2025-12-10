import pandas as pd

data = {
    'product_id': [0, 1],
    'store1': [95,70],
    'store2': [100, ""],
    'store3': [105, 80] 
}

df = pd.DataFrame(data)

print(df)

df_stack = df.set_index('product_id').stack().reset_index()

# df_stack.columns = ['product_id', 'store', 'price']

print(df_stack)
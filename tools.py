def get_dataframe_size(df):
    size = 0

    while True:
        try:
            df.iloc[size]
            size += 1
        except:
            return size
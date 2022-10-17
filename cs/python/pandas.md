# python-pandas

## Setup Example

```python
    import pandas as pd
    import numpy as np
    import matplotlib as mp; mp.use('Agg')
    import matplotlib.pyplot as plt

    from sklearn.linear_model import LinearRegression

    pd.options.display.max_columns =  100
    pd.options.display.max_rows = 100
    pd.options.display.width = 132
    plt.style.use('ggplot')
```

## Read CSV

```python
df = pd.read_csv(inputfile, sep='|', parse_dates=['Start','End'], dtype={ 'AllocCPUs': pd.numerical } )
```

## Create Dataframe

```python
df = {'AAA' : [4,5,6,7], 'BBB' : [10,20,30,40], 'CCC' : [100,50,-30,-50]}) # AAA, BBB, CCC are column names
df = df.set_index('AAA') # or...
df = df.set_index(df.columns[0])
```

## Quick Ref

- `df.apply(f)` - apply function row-wise
- `df.applymap(f)` - apply function element-wise (per row/column)
- `df.columns` - show columns
- `df.count()` - number of non-na values
- `df.cumsum()`
- `df.describe()`
- `df.index` - describe index
- `df.info()` - info on dataframe
- `df.mean/df.median()`
- `df.min()/df.max()`
- `df.shape` - shows nubmer of rows, columns
- `df.sum()`



## List unique values in a DataFrame column

```python
pd.unique(df.column_name.ravel())
```

## Convert Series datatype to numeric, getting rid of any non-numeric values

```python
df['col'] = df['col'].astype(str).convert_objects(convert_numeric=True)
```

## Grab DataFrame rows where column has certain values

```python
valuelist = ['value1', 'value2', 'value3']
df = df[df.column.isin(valuelist)]
```

## Grab DataFrame rows where column doesn't have certain values

```python
valuelist = ['value1', 'value2', 'value3']
df = df[~df.column.isin(value_list)]
```

## Delete column from DataFrame

```python
del df['column']
```

## Select from DataFrame using criteria from multiple columns

```python
newdf = df[(df['column_one']>2004) & (df['column_two']==9)]
# (use `|` instead of `&` to do an OR)
```

## Rename several DataFrame columns

```python
df = df.rename(columns = {
    'col1 old name':'col1 new name',
    'col2 old name':'col2 new name',
    'col3 old name':'col3 new name',
})
```

## Lower-case all DataFrame column names

```python
df.columns = map(str.lower, df.columns)
```

## Even more fancy DataFrame column re-naming (lower-case all DataFrame column names)

```python
df.rename(columns=lambda x: x.split('.')[-1], inplace=True)
```

## Loop through rows in a DataFrame (if you must)

```python
for index, row in df.iterrows():
    print index, row['some column']
```

## Slice values in a DataFrame column (aka Series)

```python
df.column.str[0:2]
```

## Lower-case everything in a DataFrame column

```python
df.column_name = df.column_name.str.lower()
```

## Get length of data in a DataFrame column

```python
df.column_name.str.len()
```

## Sort dataframe by multiple columns

```python
df = df.sort(['col1','col2','col3'],ascending=[1,1,0])
```

## Get top n for each group of columns in a sorted dataframe (make sure dataframe is sorted first)

```python
top5 = df.groupby(['groupingcol1', 'groupingcol2']).head(5)
```

## Grab DataFrame rows where specific column is null/notnull

```python
newdf = df[df['column'].isnull()]
```

## Select from DataFrame using multiple keys of a hierarchical index

```python
df.xs(('index level 1 value','index level 2 value'), level=('level 1','level 2'))
```

## Change all NaNs to None (useful before loading to a db)

```python
df = df.where((pd.notnull(df)), None)
```

## Get quick count of rows in a DataFrame

```python
len(df.index)
```

## Pivot data

```python
pd.pivot_table(
  df,values='cell_value',
  index=['col1', 'col2', 'col3'], #these stay as columns; will fail silently if any of these cols have null values
  columns=['col4']) #data values in this column become their own column
```

# Change data type of DataFrame column
```python
df.column_name = df.column_name.astype(np.int64)
```

## Get rid of non-numeric values throughout a DataFrame:

```python
for col in refunds.columns.values:
  refunds[col] = refunds[col].replace('[^0-9]+.-', '', regex=True)
```

## Set DataFrame column values based on other column values (h/t: @mlevkov)

```python
df.loc[(df['column1'] == some_value) & (df['column2'] == some_other_value), ['column_to_change']] = new_value
```

## Clean up missing values in multiple DataFrame columns

```python
df = df.fillna({
    'col1': 'missing',
    'col2': '99.999',
    'col3': '999',
    'col4': 'missing',
    'col5': 'missing',
    'col6': '99'
})
```

## Concatenate two DataFrame columns into a new, single column

```python
df['newcol'] = df['col1'].map(str) + df['col2'].map(str)
```

## Doing calculations with DataFrame columns that have missing values

In example below, swap in 0 for df['col1'] cells that contain null:
```python
df['new_col'] = np.where(pd.isnull(df['col1']),0,df['col1']) + df['col2']
```

## Split delimited values in a DataFrame column into two new columns
```python
df['new_col1'], df['new_col2'] = zip(*df['original_col'].apply(lambda x: x.split(': ', 1)))
```

## Collapse hierarchical column indexes
```python
df.columns = df.columns.get_level_values(0)
```

## Convert Django queryset to DataFrame
```python
qs = DjangoModelName.objects.all()
q = qs.values()
df = pd.DataFrame.from_records(q)
```

## Create a DataFrame from a Python dictionary
```python
df = pd.DataFrame(list(a_dictionary.items()), columns = ['column1', 'column2'])
```

## Get a report of all duplicate records in a dataframe, based on specific columns
```python
dupes = df[df.duplicated(['col1', 'col2', 'col3'], keep=False)]
```

## Set up formatting so larger numbers aren't displayed in scientific notation (h/t @thecapacity)
```python
pd.set_option('display.float_format', lambda x: '%.3f' % x)
```

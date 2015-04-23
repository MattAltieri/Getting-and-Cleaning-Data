# tidry Walkthrough

## Scenario 1 - values in column names

``` r
students
```
``` r
  grade male female
1     A    1      5
2     B    5      0
3     C    5      2
4     D    5      5
5     E    7      4
```

Step 1: Gather

`gather`
>Gather takes multiple columns and collapses into key-value pairs, duplicating all other columns as needed. You use gather() when you notice that you have columns that are not variables.

``` r
gather(students, sex, count, -grade)
```
``` r
   grade    sex count
1      A   male     1
2      B   male     5
3      C   male     5
4      D   male     5
5      E   male     7
6      A female     5
7      B female     0
8      C female     2
9      D female     5
10     E female     4
```

## Scenario 2 - multiple variables stored in one column, and values in column names

``` r
students2
```
``` r
  grade male_1 female_1 male_2 female_2
1     A      3        4      3        4
2     B      6        4      3        5
3     C      7        4      3        8
4     D      4        0      8        1
5     E      1        1      2        7
```

Step 1: Gather

``` r
res <- gather(students2, sex_class, count, -grade)
res
```
``` r
   grade sex_class count
1      A    male_1     3
2      B    male_1     6
3      C    male_1     7
4      D    male_1     4
5      E    male_1     1
6      A  female_1     4
7      B  female_1     4
8      C  female_1     4
9      D  female_1     0
10     E  female_1     1
11     A    male_2     3
12     B    male_2     3
13     C    male_2     3
14     D    male_2     8
15     E    male_2     2
16     A  female_2     4
17     B  female_2     5
18     C  female_2     8
19     D  female_2     1
20     E  female_2     7
```

Step 2: Separate

`separate`
>Given either regular expression or a vector of character positions, separate() turns a single character column into multiple columns.

``` r
separate(res, sex_class, c("sex", "class"))
```
``` r
   grade    sex class count
1      A   male     1     3
2      B   male     1     6
3      C   male     1     7
4      D   male     1     4
5      E   male     1     1
6      A female     1     4
7      B female     1     4
8      C female     1     4
9      D female     1     0
10     E female     1     1
11     A   male     2     3
12     B   male     2     3
13     C   male     2     3
14     D   male     2     8
15     E   male     2     2
16     A female     2     4
17     B female     2     5
18     C female     2     8
19     D female     2     1
20     E female     2     7
```

## Scenario 3 - variables stored in both rows and columns

``` r
students3
```
``` r
    name    test class1 class2 class3 class4 class5
1  Sally midterm      A   <NA>      B   <NA>   <NA>
2  Sally   final      C   <NA>      C   <NA>   <NA>
3   Jeff midterm   <NA>      D   <NA>      A   <NA>
4   Jeff   final   <NA>      E   <NA>      C   <NA>
5  Roger midterm   <NA>      C   <NA>   <NA>      B
6  Roger   final   <NA>      A   <NA>   <NA>      A
7  Karen midterm   <NA>   <NA>      C      A   <NA>
8  Karen   final   <NA>   <NA>      C      A   <NA>
9  Brian midterm      B   <NA>   <NA>   <NA>      A
10 Brian   final      B   <NA>   <NA>   <NA>      C
```

Step 1: Gather

``` r
students3 <- gather(students3, class, grade, -(name:test), na.rm=T)
students3
```
``` r
    name    test  class grade
1  Sally midterm class1     A
2  Sally   final class1     C
3  Brian midterm class1     B
4  Brian   final class1     B
5   Jeff midterm class2     D
6   Jeff   final class2     E
7  Roger midterm class2     C
8  Roger   final class2     A
9  Sally midterm class3     B
10 Sally   final class3     C
11 Karen midterm class3     C
12 Karen   final class3     C
13  Jeff midterm class4     A
14  Jeff   final class4     C
15 Karen midterm class4     A
16 Karen   final class4     A
17 Roger midterm class5     B
18 Roger   final class5     A
19 Brian midterm class5     A
20 Brian   final class5     C
```

Step 2: Spread

`spread`
>Spread a key-value pair across multiple columns.

``` r
students3 <- spread(students3, test, grade)
students3
```
``` r
    name  class final midterm
1  Brian class1     B       B
2  Brian class5     C       A
3   Jeff class2     E       D
4   Jeff class4     C       A
5  Karen class3     C       C
6  Karen class4     A       A
7  Roger class2     A       C
8  Roger class5     A       B
9  Sally class1     C       A
10 Sally class3     C       B
```

Step 3: Extract Numeric

`extract_numeric`
>This uses a regular expression to strip all non-numeric character from a string and then coerces the result to a number. This is useful for strings that are numbers with extra formatting (e.g. $1,200.34).

``` r
mutate(students3, class=extract_numeric(class))
```
``` r
    name class final midterm
1  Brian     1     B       B
2  Brian     5     C       A
3   Jeff     2     E       D
4   Jeff     4     C       A
5  Karen     3     C       C
6  Karen     4     A       A
7  Roger     2     A       C
8  Roger     5     A       B
9  Sally     1     C       A
10 Sally     3     C       B
```

## Scenario 4 - multiple observational units in the same table

``` r
students4
```
```
    id  name sex class midterm final
1  168 Brian   F     1       B     B
2  168 Brian   F     5       A     C
3  588 Sally   M     1       A     C
4  588 Sally   M     3       B     C
5  710  Jeff   M     2       D     E
6  710  Jeff   M     4       A     C
7  731 Roger   F     2       C     A
8  731 Roger   F     5       B     A
9  908 Karen   M     3       C     C
10 908 Karen   M     4       A     A
```

Step 1: Create a unique students table

``` r
student_info <- unique(select(students4, id, name, sex))
student_info
```
``` r
   id  name sex
1 168 Brian   F
3 588 Sally   M
5 710  Jeff   M
7 731 Roger   F
9 908 Karen   M
```

Step 2: Create a grades table

``` r
gradebook <- select(students4, id, class, midterm, final)
gradebook
```
``` r
    id class midterm final
1  168     1       B     B
2  168     5       A     C
3  588     1       A     C
4  588     3       B     C
5  710     2       D     E
6  710     4       A     C
7  731     2       C     A
8  731     5       B     A
9  908     3       C     C
10 908     4       A     A
```

## Scenario 5 - single observational unit in multiple tables

``` r
passed
```
``` r
   name class final
1 Brian     1     B
2 Roger     2     A
3 Roger     5     A
4 Karen     4     A
```
``` r
failed
```
``` r
   name class final
1 Brian     5     C
2 Sally     1     C
3 Sally     3     C
4  Jeff     2     E
5  Jeff     4     C
6 Karen     3     C
```

Step 1: Add status column to each table

``` r
passed <- mutate(passed, status="passed")
failed <- mutate(failed, status="failed")
```

Step 2: Bind rows

`bind_rows`
>This is an efficient implementation of the common pattern of do.call(rbind, dfs) or do.call{cbind, dfs} for binding many data frames into one. combine() acts like c() or unlist() but uses consistent dplyr coercion rules.

``` r
bind_rows(passed, failed)
```
``` r
Source: local data frame [10 x 4]

    name class final status
1  Brian     1     B passed
2  Roger     2     A passed
3  Roger     5     A passed
4  Karen     4     A passed
5  Brian     5     C failed
6  Sally     1     C failed
7  Sally     3     C failed
8   Jeff     2     E failed
9   Jeff     4     C failed
10 Karen     3     C failed
```
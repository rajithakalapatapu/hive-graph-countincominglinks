drop table graph;

create table graph (
  x int,
  y int)
row format delimited fields terminated by ',' stored as textfile;

load data local inpath '${hiveconf:G}' overwrite into table graph;

drop table output;

create table output
row format delimited fields terminated by '\t' stored as textfile
AS select y, count(*) as c from graph group by y order by c DESC;

select concat_ws(',', cast(y as string), cast(c as string)) from output;
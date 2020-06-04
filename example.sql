CREATE TABLE test
(
    test_date DateTime,
    random_int UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/{shard}/test', '{replica}')
PARTITION BY toYYYYMM(test_date)
ORDER BY (test_date);

CREATE TABLE test_all (
    test_date DateTime,
    random_int UInt32
) ENGINE = Distributed('ck_cluster', 'default', 'test', random_int);

INSERT INTO test_all VALUES ('2020-01-01 01:01:01', 1);
INSERT INTO test_all VALUES ('2020-02-02 02:02:02', 2);

-- select * from system.clusters
-- select hostName(), * from test_all

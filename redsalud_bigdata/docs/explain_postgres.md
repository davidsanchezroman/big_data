=== 4. EXPLAIN ANALYZE ===
                                                                    QUERY PLAN                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=1373.22..1377.76 rows=1815 width=236) (actual time=15.519..15.522 rows=12 loops=1)
   Sort Key: (count(*)) DESC
   Sort Method: quicksort  Memory: 25kB
   ->  HashAggregate  (cost=1247.75..1274.98 rows=1815 width=236) (actual time=15.498..15.509 rows=12 loops=1)
         Group Key: a.region, a.tipo_atencion
         Batches: 1  Memory Usage: 73kB
         ->  Hash Join  (cost=26.98..1186.19 rows=6156 width=200) (actual time=0.020..12.993 rows=12282 loops=1)
               Hash Cond: (a.id_medico = m.id_medico)
               ->  Hash Join  (cost=13.82..1156.54 rows=6156 width=204) (actual time=0.013..11.596 rows=12282 loops=1)
                     Hash Cond: (a.id_paciente = p.id_paciente)
                     ->  Seq Scan on atenciones_medicas a  (cost=0.00..1126.21 rows=6156 width=208) (actual time=0.007..9.806 rows=12282 loops=1)
                           Filter: (fecha_atencion >= (now() - '90 days'::interval))
                           Rows Removed by Filter: 37743
                     ->  Hash  (cost=11.70..11.70 rows=170 width=4) (actual time=0.003..0.004 rows=20 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                           ->  Seq Scan on pacientes p  (cost=0.00..11.70 rows=170 width=4) (actual time=0.001..0.002 rows=20 loops=1)
               ->  Hash  (cost=11.40..11.40 rows=140 width=4) (actual time=0.005..0.005 rows=4 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 9kB
                     ->  Seq Scan on medicos m  (cost=0.00..11.40 rows=140 width=4) (actual time=0.002..0.002 rows=4 loops=1)
 Planning Time: 0.244 ms
 Execution Time: 15.560 ms
(21 rows)
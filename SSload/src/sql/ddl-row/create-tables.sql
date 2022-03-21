CREATE TABLE ${schema}trip_info${org}  ( 
	distance_miles	INTEGER,
	duration_seconds	INTEGER,
	vehicle_id	INTEGER ${shardkey})
;


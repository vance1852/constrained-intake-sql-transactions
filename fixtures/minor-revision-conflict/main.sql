BEGIN TRANSACTION;
CREATE TABLE "live_checks" (check_id TEXT PRIMARY KEY, proof_id TEXT, institution TEXT);
CREATE TABLE "live_proofs" (proof_id TEXT PRIMARY KEY, institution TEXT, revision INTEGER, valid_from INTEGER, valid_to INTEGER, state TEXT);
INSERT INTO "live_proofs" VALUES('p0','east',1,9,30,'valid');
CREATE TABLE "supplies" (institution TEXT PRIMARY KEY, joint_scope TEXT);
INSERT INTO "supplies" VALUES('east','one');
COMMIT;

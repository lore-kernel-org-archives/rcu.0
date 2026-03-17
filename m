Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BE3921DB;
	Tue, 17 Mar 2026 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782594; cv=fail; b=JXwzC9TXNYcNshR5rwlNCHQdRhB1kM/H+VATTb+co5jEQ/8X+DRDL2wsy2jGe5r7pY0Vh6afo8tGXPZJpVw5xy2M1zTEE2Me7jqmRkbl91pwpVkD1udUaTkrbl4gMD+CWwC+0yF1uCiD27yxbEUhTDjB/4H8U3TDvNiw5MgRhbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782594; c=relaxed/simple;
	bh=VQ+H7pkGgvdkvSpZDifH+Z42FMcjYMAJHBOqmVZJXwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fj96KshM7L2gr0IK04yxpCcmkkkeodrRYEpY/IxWras6Kbc8qVeEik3zi/Vj27F/Aq07gB5zFX9aGCD1S382k61uPqoE4DLbsvRhIKVL+1WRwlkt++JZ1ciD6Wzzq6u+DubGCjTh+FvhBPUb6Q7DSM+/lVSGV4DG3wtmefVoavA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WMbQswbV; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WMbQswbV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZo0ImeRhHgkNoPsc2+KhrBocBVmtobn+nc4rXcthkEWGICJlsAeegMUsOT9SybbMqd/vItfh5dNU4l3/ebE2N8Hfi0vuTPhy6HXMXSukIuI12nIv0QEUMqeqicv21LPDCBFAV6xKoNxAUISSwTBwLC7k8lB/+WUN2GmRJXJyCDIlN8lIFqXVw4pqILPnusLSLFD9XZfGlVhEUD/ReBVpbnUffG93FNcwxNPr4wwqQVIrbxgBNjJ+M/4EXeiZaglrpfohTO4aHmzU4aIEpXrgwa6JYQfALtvguTFhmaGDDVd+BgtYSBYcTyIoBjSaZ8TUtUT5FsDDouMqFgqaj3xtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O98uJ5zgYnRp69aqt4JKcStMeCwNu7WCTUVtdOOteJM=;
 b=qlNzKlyaX5wJbRr2L5VNOvfF5YBkflWMCWNn+PLbz8Rn7VPy1t+gQvLNwC6S+7Ex32W5kgLbHytQVgUEPRj5yOAMpexIkqgx54Q3NNXnv+kcbz1kpUAY4KOiHnDhbqExj/ZTjB/k/R6Es0XaXUQQnJrZ9nXhi2lDxZbtM6GyxjwW72hO2PNIHwyCoMsNi/w3DhS5WiXoFXUdxaQ0rCha/IJ9FScsnV+twHp+EokXewIKe1jDm4IjLyWEFaxwuxYaryWcf35lE0GfF8WWk5gj1ZoVIlnVqBw2nqMX60ol215LV6lhBR2sRB8KpfWuMJZP7yGVm5yLujB7dVO9BCh8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O98uJ5zgYnRp69aqt4JKcStMeCwNu7WCTUVtdOOteJM=;
 b=WMbQswbVhISq+Af6ouZampjYzVvY2/bDzlQ3Kg+hIGxFVh7IdSz4I+aE7uP6Y4SDiEDllbK7QfemSI+fiXBmzn+kdvFkoPS8Xkwkz4AZMSi9w+1RUm9sHolgHiJbv+asFRoxynyoGHNNKB3dmr3x6SEvofX3hSB+7u08x5llSc8NjDcv/03BWRwxriqvGSB8Ugt8QSGmH0hJVL27Qk/EeFgY7bsDqmrE8rEhyEBCelAVkC/MS3ommbDWuymQd5gdHzINWpcNWVaaniIxjEm0H3fC1GEDgOxepjjqg1R4uO8jw/LYrJs9B75mwF4RETJrHqVZ0j+XAvd+0L/8bbBIBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:03 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:03 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH -next v1 07/16] rcuscale: Ditch rcu_scale_shutdown in favor of torture_shutdown_init()
Date: Tue, 17 Mar 2026 17:22:08 -0400
Message-Id: <20260317212217.1527644-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: aff43b36-b5f8-43cf-f539-08de846b5fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	05UlmLDRJ3o4UVTnnGM0F9h1oHZKiRjxeGzTOM6IsPqweFn//W29Rq+COYNrwBrqOpv9yjsyD0a1O2efn2RjA3qCRyaD2JudJt0Ku0lrq/8T2UhLn3hpbSIRBmk47DzCDiyM7YPUlQQMKwQRYc0922MQwDoDLZqBvi9uaNF05z2ZgCy48Ggs61pilmwpXfoxMiqhUwSt+PSZVB/o4gY+tdmwypTT2gcsu162TsFegI1wHZlfsvUYgUn4Z9iNDjqAQ9pn9JxS1SKNhObPKzyl//j4OQDBSDSsMul+NnDR68IjOtdv206CTvU0K6EZqFOl+qIg/1Atpi6/FmLu53Hj78kcfB5IJe4ZtlrY/gqV0KoV5wzU4CvEogcTy/X2jDCfNBKcS1opbuhYnekK/aZaDcuC7PKXsdsuzT9Gkfvs+kcvRjIfK3JzJ1hk/IUcoF6xz8HOzlVyn1MQ+dmreTmXLK4SSVRct9PXTRjJKbk7zI2Rjic7Fb59qCAZHZACQj0/HuXX4qfZRjBvPkbNGHWVBA42srzS5YejFUuqwHx4i/r8J4gUhJES3v49XcnOtum0we5hanxUGROSetzbD/cIy7aj8Ygh1OwDEnOqMrpIHlfKqCVDrr4UpJshb9Sx9KKDsBexB3G4V31zh+nB7SchxHXsYRhdoM8/5/5wVCC4zvFPcmSHKd1/hknIjAtzhyhnh5Vc8mLX8TdNuinjnF+dElLvdIu9W1hcSIvkiATmu7d9+OV7GtBJ+7E2wBIAfn7If8xi2u1bgds97ch7VLi/gA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rp9JYd4PdTBx6WBRzktZOW7E51+B7gc5J3cvgaDqrTRfNq+/Lv+0SOdiTCWr?=
 =?us-ascii?Q?fQvJRlWN3h0fdebUZJdGnXWQfL6fVn7sEnjISM2Sloq/4+ojfYVDFNeDJbbB?=
 =?us-ascii?Q?qEpfmM6gL/76t0hM94khruBOT6Ga0ACrjhSzVaNDBfgeMtq4eCoSh5T+cT6/?=
 =?us-ascii?Q?ngcIFmPHvu0uttTB4VL/X/TcqadOqtyM/qsJxsXQEDfUUztrn5QN401TkCTW?=
 =?us-ascii?Q?MvsPKbgu8WoG14aA8K3DH3xig0uJpJBm9PHUvQ9kUK184fn2Fn54HG9boHwo?=
 =?us-ascii?Q?XgNNGhBJLpToYb3bjyJD+D9a08Hukwaiqi9mvDzNE6Re3CgHM8xD+xYHzX0Q?=
 =?us-ascii?Q?UoCKqMBCCgVVnQ+kn3sN7A1onWMiIxgrT4R28o7PY8y7qSG1szYF6x5lw8YC?=
 =?us-ascii?Q?k0C83eEkq8HRwZ9NlKHdus01cwgEPubTtWlmOGjB2bSq/hDrnqa7bBTYhuMm?=
 =?us-ascii?Q?IKSOd8dVhOqLgeeB7O+xTUiu3xkqP7/UF6RL2OkQiMDV6ZLS/n7w/wBudzGG?=
 =?us-ascii?Q?TZAruu0siHrsZ/jObDg3Q5lgJP3s3IkOPrOayux+R9SB9BOr3GBzjw+Qmu65?=
 =?us-ascii?Q?j8VokbNKKeukjZwWjWRezW7PM12lZk3xt1x3lmhSCMdFmEoZX47OxIW6eHod?=
 =?us-ascii?Q?u0QfdIGxr5NTyp2Jvy5I1zOPWEExhl5X2HL8wMWi+pndScVSoBSXQpCb9ZUT?=
 =?us-ascii?Q?hRlV6msTfEoSeLjtIbOpzjD1pLbo7VwV3m/acXssSDa0FnGddasjMCz/HTc6?=
 =?us-ascii?Q?41mv6Uv8wrs9R4L38zpkFXiJl4C7pG+rsGyGuE1+wo+lK1QLck6rb8/oEN5R?=
 =?us-ascii?Q?fvTR69Dpwv5u46DquH5VfGv17+IKkewizToMBcWfxxTHN1TsOujU8xG09ITJ?=
 =?us-ascii?Q?uT423GYhEFMoNX+6Y0mHx4bq6bV6XY1Hhsd+981CKzp5Il191iw9Q6c4tPHh?=
 =?us-ascii?Q?jgINgDLHYs6yj4wVIonNr+6ceseo5L6O4IPc1t+obA7hWjOUxMSkVUgwsFAq?=
 =?us-ascii?Q?Atw2jUP1+gX6nJPXRKe1mmQS+SywX9iT3v02ANosJBPFl0EaXohcycvNyfnw?=
 =?us-ascii?Q?7svuOFeefEuLX9ghVhIxv+HgmzhrMZl79SPY3TMGHVdInJAprZrO55XcQ0kX?=
 =?us-ascii?Q?69Lqr/HI8pTHDUy7wIYq5x+onlnFrzo8XtYVTXVmtxP9TOcS7fp6kfvE/o/z?=
 =?us-ascii?Q?4I6SkVApoT4G1qUHYO5LngpjXMuHwWmRApXsOdKzMSnk5SBAorYzfNbtPqd6?=
 =?us-ascii?Q?19lMJ0YFUSEY8RPbbixRL6ER4xx9dzU7sKIzYy5MFT23Tz+B4oMsutKSya2k?=
 =?us-ascii?Q?IxTAbnT1pMokZ5NjK4jTMw9bxw4+U+ldySoOt9ZgyJTGsQbfgTXp4uoLJVvi?=
 =?us-ascii?Q?kEcEHG2qmm8wWZdJL6RdcFSHECYxc//C9XYwCZJ1IJKT4hnmE0jaPvKXxfZ3?=
 =?us-ascii?Q?mnI/Ik2Sev64h3p1gC9s9BudxttJ0u/G9swUbXGEdXbGSRgAGitWoOWV1o8o?=
 =?us-ascii?Q?3b7sWn7CVau0+MQJQAn6Vm/P/fevbJUuM9ZKzWoKEHB/7xwcRzlVC1vjGEr6?=
 =?us-ascii?Q?ThwDHzOljBAieFcnM0wWzvQaT/86lM6wQ8HimOA1aG/OKsbT4WFDhnfVR0mV?=
 =?us-ascii?Q?cZe4iWJVcHjtJAH2+sPQfYtZsRkNMdiyTPWXIL4IBgNDJTA5HbUBeIetMZFv?=
 =?us-ascii?Q?D4pKNs+8smw8ONLjscNIhAcRUf1o2igtsYBlys3HY3pcHDdVo3ioqhPnKKrn?=
 =?us-ascii?Q?5cBz+EmmDg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff43b36-b5f8-43cf-f539-08de846b5fa3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:03.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GR22orVpuJJ6QnosiZe9xW7OJQapV9ATD+L7Glv3VxS/zrpMT87QC+2BqfZkZQ1seD4QiP5cNn7og1NYX9vNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: "Paul E. McKenney" <paulmck@kernel.org>

The torture_shutdown_init() function spawns a shutdown kthread in
a manner very similar to that implemented by rcu_scale_shutdown().
This commit therefore re-implements rcu_scale_shutdown() in terms of
torture_shutdown_init().

This patch was generated by Claude given as input the patch making the
same transformation of ref_scale_shutdown().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcuscale.c                         | 78 +++++--------------
 .../configs/rcuscale/ver_functions.sh         |  2 +-
 2 files changed, 22 insertions(+), 58 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 4ac2b134a983..ac0b1c6b7dae 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -79,12 +79,6 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
  * test-end checks, and the pair of calls through pointers.
  */
 
-#ifdef MODULE
-# define RCUSCALE_SHUTDOWN 0
-#else
-# define RCUSCALE_SHUTDOWN 1
-#endif
-
 torture_param(bool, gp_async, false, "Use asynchronous GP wait primitives");
 torture_param(int, gp_async_max, 1000, "Max # outstanding waits per writer");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
@@ -92,8 +86,8 @@ torture_param(int, holdoff, 10, "Holdoff time before test start (s)");
 torture_param(int, minruntime, 0, "Minimum run time (s)");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, nwriters, -1, "Number of RCU updater threads");
-torture_param(bool, shutdown, RCUSCALE_SHUTDOWN,
-	      "Shutdown at end of scalability tests.");
+torture_param(int, shutdown_secs, !IS_MODULE(CONFIG_RCU_SCALE_TEST) * 300,
+	      "Shutdown at end of scalability tests or at specified timeout (s).");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, writer_holdoff_jiffies, 0, "Holdoff (jiffies) between GPs, zero to disable");
@@ -123,7 +117,6 @@ static int nrealreaders;
 static int nrealwriters;
 static struct task_struct **writer_tasks;
 static struct task_struct **reader_tasks;
-static struct task_struct *shutdown_task;
 
 static u64 **writer_durations;
 static bool *writer_done;
@@ -132,7 +125,6 @@ static int *writer_n_durations;
 static atomic_t n_rcu_scale_reader_started;
 static atomic_t n_rcu_scale_writer_started;
 static atomic_t n_rcu_scale_writer_finished;
-static wait_queue_head_t shutdown_wq;
 static u64 t_rcu_scale_writer_started;
 static u64 t_rcu_scale_writer_finished;
 static unsigned long b_rcu_gp_test_started;
@@ -519,6 +511,8 @@ static void rcu_scale_async_cb(struct rcu_head *rhp)
 	rcu_scale_free(wmbp);
 }
 
+static void rcu_scale_cleanup(void);
+
 /*
  * RCU scale writer kthread.  Repeatedly does a grace period.
  */
@@ -622,9 +616,11 @@ rcu_scale_writer(void *arg)
 					b_rcu_gp_test_finished =
 						cur_ops->get_gp_seq();
 				}
-				if (shutdown) {
+				if (shutdown_secs) {
+					writer_tasks[me] = NULL;
 					smp_mb(); /* Assign before wake. */
-					wake_up(&shutdown_wq);
+					rcu_scale_cleanup();
+					kernel_power_off();
 				}
 			}
 		}
@@ -668,8 +664,8 @@ static void
 rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" SCALE_FLAG
-		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d writer_holdoff=%d writer_holdoff_jiffies=%d verbose=%d shutdown=%d\n",
-		 scale_type, tag, gp_async, gp_async_max, gp_exp, holdoff, minruntime, nrealreaders, nrealwriters, writer_holdoff, writer_holdoff_jiffies, verbose, shutdown);
+		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d writer_holdoff=%d writer_holdoff_jiffies=%d verbose=%d shutdown_secs=%d\n",
+		 scale_type, tag, gp_async, gp_async_max, gp_exp, holdoff, minruntime, nrealreaders, nrealwriters, writer_holdoff, writer_holdoff_jiffies, verbose, shutdown_secs);
 }
 
 /*
@@ -722,6 +718,8 @@ static void kfree_call_rcu(struct rcu_head *rh)
 	kfree(obj);
 }
 
+static void kfree_scale_cleanup(void);
+
 static int
 kfree_scale_thread(void *arg)
 {
@@ -791,9 +789,11 @@ kfree_scale_thread(void *arg)
 		       rcuscale_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
 		       PAGES_TO_MB(mem_begin - mem_during));
 
-		if (shutdown) {
+		if (shutdown_secs) {
+			kfree_reader_tasks[me] = NULL;
 			smp_mb(); /* Assign before wake. */
-			wake_up(&shutdown_wq);
+			kfree_scale_cleanup();
+			kernel_power_off();
 		}
 	}
 
@@ -820,22 +820,6 @@ kfree_scale_cleanup(void)
 	torture_cleanup_end();
 }
 
-/*
- * shutdown kthread.  Just waits to be awakened, then shuts down system.
- */
-static int
-kfree_scale_shutdown(void *arg)
-{
-	wait_event_idle(shutdown_wq,
-			atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
-
-	smp_mb(); /* Wake before output. */
-
-	kfree_scale_cleanup();
-	kernel_power_off();
-	return -EINVAL;
-}
-
 // Used if doing RCU-kfree'ing via call_rcu().
 static unsigned long jiffies_at_lazy_cb;
 static struct rcu_head lazy_test1_rh;
@@ -895,13 +879,10 @@ kfree_scale_init(void)
 
 	kfree_nrealthreads = compute_real(kfree_nthreads);
 	/* Start up the kthreads. */
-	if (shutdown) {
-		init_waitqueue_head(&shutdown_wq);
-		firsterr = torture_create_kthread(kfree_scale_shutdown, NULL,
-						  shutdown_task);
+	if (shutdown_secs) {
+		firsterr = torture_shutdown_init(shutdown_secs, kfree_scale_cleanup);
 		if (torture_init_error(firsterr))
 			goto unwind;
-		schedule_timeout_uninterruptible(1);
 	}
 
 	pr_alert("kfree object size=%zu, kfree_by_call_rcu=%d\n",
@@ -1058,20 +1039,6 @@ rcu_scale_cleanup(void)
 	torture_cleanup_end();
 }
 
-/*
- * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
- * down system.
- */
-static int
-rcu_scale_shutdown(void *arg)
-{
-	wait_event_idle(shutdown_wq, atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
-	smp_mb(); /* Wake before output. */
-	rcu_scale_cleanup();
-	kernel_power_off();
-	return -EINVAL;
-}
-
 static int __init
 rcu_scale_init(void)
 {
@@ -1121,13 +1088,10 @@ rcu_scale_init(void)
 
 	/* Start up the kthreads. */
 
-	if (shutdown) {
-		init_waitqueue_head(&shutdown_wq);
-		firsterr = torture_create_kthread(rcu_scale_shutdown, NULL,
-						  shutdown_task);
+	if (shutdown_secs) {
+		firsterr = torture_shutdown_init(shutdown_secs, rcu_scale_cleanup);
 		if (torture_init_error(firsterr))
 			goto unwind;
-		schedule_timeout_uninterruptible(1);
 	}
 	reader_tasks = kzalloc_objs(reader_tasks[0], nrealreaders);
 	if (reader_tasks == NULL) {
@@ -1201,7 +1165,7 @@ rcu_scale_init(void)
 unwind:
 	torture_init_end();
 	rcu_scale_cleanup();
-	if (shutdown) {
+	if (shutdown_secs) {
 		WARN_ON(!IS_MODULE(CONFIG_RCU_SCALE_TEST));
 		kernel_power_off();
 	}
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
index 28070b43f017..b78ddc243d89 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
@@ -11,7 +11,7 @@
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo	rcuscale.shutdown=1 \
+	echo	rcuscale.shutdown_secs=$3 \
 		rcuscale.verbose=0 \
 		$1
 }
-- 
2.34.1


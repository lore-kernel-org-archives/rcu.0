Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238AE37CD51;
	Tue, 17 Mar 2026 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782587; cv=fail; b=Bk3Tqs3AxxMwhwWg6MJ+2jApYZAWq32pgeJsj+BNDaINlKwSJqbMLau52yVtqELJAEr6V2fKR4lGidhfzcAO2QSiv4vTWNCjr1PNDjlj05VjMYorTpg4gV7PDEvHjrvcfOZVtHvrFT7k2yi0BTYbc3EV6tJyVAgynqPIkk6E0jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782587; c=relaxed/simple;
	bh=ngn3/HzMYWUBsJGVqwPYaoNJeRbVaq60AaUNVBDu4pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpKTdsgcp+LJb7XCFfkkwXVCSW85aGrOP1VDlC8GzeLqwvk3jtDrUhne6GlFZUILyNu4RnhlkbRP1R9jhjB1mKaXAWIJqVBzimZkAcmrpbMp0JqB/gdx+taIH46B29A3h6mH8YC7rq539iUjquO4O46WJtzwFjKE1HgNl2ht3S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pZ5/NyY2; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pZ5/NyY2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Egdwybq0aiw03f4Xd6CrV579KX6dFdBDBddRDzuNLheurvK/+wLRXrQ0jZTEuWT0wcNg96SBpZqy6yxAFax6qA1FE84dcfyXvxsv55CoJZR29E2kv5rZWO70pjAiFRYB2fWLquyOWwhjCEy7JJaIxxuubZLmiAnaSZZqEVK/vbWadRfLSkcv7aVMCRh47oRk7LmWzzSaR3zxyxMyYtdUKQNMd42zqBTUXkre60mdNQ6RGpwgN/YrUotFXHYwqVhm9ny6aYKbWHsKN1Tf0ZrXeMbVei4GoC7erQYkVyAqE68WWRscKEMVGSQ/kYYc4lXYK9lQjqYWMU8fmGbO+pTdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFGs3NhXlINvzuw4/EGjx2uplPnoAAPEwc9U3/HlK7o=;
 b=AaRCMKw5MrHYH3EweckEDZot1JP8KhYbbpXWXgRllZ667l01YUN039gy5Rl94M81Cpor85EpEZerMGfEtMN9So7EY7hf2tCfYDa5ZM7KsnLkSiD8m7B8Yqov30CBE2sSxEJkvekf6XFIln/9LqbXrgpXBXIzmbqx/Lw+lPti/e5dJGgI8LUDOcELLH75/G9RVmclfkZRtc/OnucCu/lFw1RlINz6nbJ1pI5aGq4/rrE6IQwqyaujAPM51HRpVnpcoiG7xjnJnmzPzus9QxOMTkGb5N0eP/u+KaZEfQUK7KHP/edRc+pyny5UDIfe9WV2dm9LtdnmPQscZll7n6fe+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFGs3NhXlINvzuw4/EGjx2uplPnoAAPEwc9U3/HlK7o=;
 b=pZ5/NyY2drxV/00oAfgvlKFXZG2gxn7Zblex1uXvyZ56Iw8xrmTdreRpZT8tks0FsySR+dH3uWoIrjxga899hA1ojQ1qAkSySu+KMlCuCTIffkNpAzt7HqVLrtrm5ocWRMoSpYa8kBK/ZRReoWaA9lLJVWn/RjvStd/Ryh/UoZxJoqPHte2EmByebqo6QTPSeF4MaWr8J5fWUBPHSNCzzKxZADZV0uaFPyxh6cTmPBbX1SUGVdvBNalXaw/ywiCoymXPhgPMbmlwBkA47gjxKfWl5mP4bbJbOISCHzXJCGjph5VVkRhrT0TNNl2LXRDbm29vAH8shC8MAyuoahYRow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:01 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:01 +0000
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
Subject: [PATCH -next v1 06/16] refscale: Ditch ref_scale_shutdown in favor of torture_shutdown_init()
Date: Tue, 17 Mar 2026 17:22:07 -0400
Message-Id: <20260317212217.1527644-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:208:32a::6) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7f6658-7f16-467d-5bfc-08de846b5e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	IafaZoHw8IUcidWpB60W0c4qkZJ/6eI/NQpCM3jS8Uxs3Uj9Kq9MRfWYYyfc7iQ1TRHOLyO+x9aMh9C5FqoK9bfZMBVPi5RRP/41uzSzAasofV9j8+otLaXqzlDV9mvhgfCsqdfim77OMlGdTz7qKI2A3g8dfNYgcyNby8++Qb3MkZNewnJYswvvbcfW+o7SOWNkAzmxJfH9HnHErTcXl6J8GLUUu8quawgdu9DpfGjveVRhqmwbpn//LB0WYRzOhH1opg97on0fZb0fkQ7Nw4d8X3bIFGM5MeNaOH6QfsCgesrsU/VsV0tdSz3UhFHQqDCUainq0Zax3ZkxEKi6Bd/4S/dwtVtydUgdJbhXkoqu7VejDNIFY3g3Iu2X2VoPXro8bboC7sZ+sC9Czhdui/+6aeWTFc4mHJGtrjmniKlCH9HQw8c2G/rhrCVqQJeINeS2n5uQLf93PnqdSXiLOQVQpVFHDmyD1Hm/BvDrNn9RobaDPIXkV8/nKPkJD/8l0ou5NtjAHd2EXsT9kHpx9rAlIqnUqtg2wdTKBcYF++dAMfcSkZhJxbij/thLYUohIY1RHQkAwT8bxgSHFQWgHgHobA8iHwl3Zypn0lExNVxGbWZRlAtXmwFsoO43VuWbQp5v0Kuqkx/K3i1cm7/LGB1FC6ggx1lsY2zgu5bnwQa1/W9TJekcZHcPRrbJSrFp/884nMWZPI4BAp1JQ316UkHlhBqIaT+NQfMwAKZHw7ncyTUwLKHvJesFS3PHUhz745XdQTI4jkCcrLLWTGwlsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3W2TYb2GtWxrsGWTPKkJ0mIQUOWa5xoIZ3CXrW0SW6PuZrZDRoPhaM3Mx3Tz?=
 =?us-ascii?Q?fmWyW+92MBuVkoPz0fdYGcDPQ7ehBKRmB+GoP7D3ZebVf3Murli3KMnYAQ61?=
 =?us-ascii?Q?yvsOR5NMtSejnwwucfxqptoNXH6h3eGVoCQ+paG/IdQpUQ/Y5u4Z21N6BPcR?=
 =?us-ascii?Q?YYvwxZv5ia4Z7AbpjCFCkmOYLjlKV0MCyE65gkCutbzzzku28+9z9oTFb6hH?=
 =?us-ascii?Q?XGB2WDY8e+SPwTYt5N+RTKdp8J2AcQctmenwewbxZA+hASFyqNX1NNp+Zx0E?=
 =?us-ascii?Q?/QF6Vrp1ww3zT1LcJwBI/9JPCcLwOA4TK75+vVFiLgBSJWW/xpcT0Pos3+ki?=
 =?us-ascii?Q?ahhxUEtPErTm7K5Z6zYsShEFQv7HGmreVU4JNXO7m5hyOGjT9l4GM8CFoMS5?=
 =?us-ascii?Q?LZcBaqyGoNV5tZkIFQce59n0+9/Y2vxvOBaBlGi9m6MTErUvAs3bQOutBIOf?=
 =?us-ascii?Q?rePfINudQGyT1oZYAFsrowkwL/Q6Ysr2PAhOdSJUxCjkMMo6KQz8IlvrxDP6?=
 =?us-ascii?Q?FyxyRaXqeGFRFNzTnyhzvwpJh1vfAHcLuJL4egdX0xy/WMJrpWY7LtjFM6e8?=
 =?us-ascii?Q?aqMmF99jkHZ6obgLrB8xO72AYv/7H9Os5H9/1ugqegKDo++WWcOiQsSSvz3d?=
 =?us-ascii?Q?8q0X7I5kYDCTbVSgP0FU5tktdl6TyHKscmmW2afM8RNPNe13NNOS0I6khEDI?=
 =?us-ascii?Q?ICHVYmxcrNa3Nh29QR+H1sdJV2YmYm/6Zllb84wdQ5r713Xy2bwB10atttZ4?=
 =?us-ascii?Q?SO9O56JPJvnW0E+k7AR01E4/5P8Cg6uM13lh+k/ClyjmX0Qr9cTf4boelLlu?=
 =?us-ascii?Q?fci+7w1xmeoVsY++lgYfuu82B76BUQFoEDY+h6WOFRRz+m+zOpXHQ22HGMSt?=
 =?us-ascii?Q?QiW36l9f8JDdwXRN3Jr+QbRLrTyy1DDB1WBHY3ErHKbc+KD3Fw1P9xO9m2qU?=
 =?us-ascii?Q?4eVGqQB02602wdC4bSICJsWG/N63Zn1mPD0AP4cb/5DY0z6KFMR4VzQjFKhr?=
 =?us-ascii?Q?tbGyUlQR8bdcF6o28gu907pelP1DwM6lR0e4Sx9dSoItXk+CezuQE7UOeFGs?=
 =?us-ascii?Q?YGvgYSM0J9NN6JTPsoV4kaqB1XCgYQttozO/yW833G6/JdHy8gdGY3Bbbyju?=
 =?us-ascii?Q?Fk38mdY4qMElqrvxdP6igLq0RiuYFbafceESsQEXAsKyUJL4pc3+XxZmJJxr?=
 =?us-ascii?Q?stoUH2A7aftRFpdPlziqN5g4WxBevOuSnDQhB99OJ8RnZCX/FcPmwZM9PWaF?=
 =?us-ascii?Q?pRew9pDJrWZX5+0wXQJN7mdKwgNeeRBU+B6MYx/H5MbavoZjFRzq6o0IYP9U?=
 =?us-ascii?Q?6/uy0MRqqnyYnhMyOe0+C9uWE+IO2GaM/f2WKJoprPz/4NdGy/QqMASc1A+4?=
 =?us-ascii?Q?7F80s8oSCO+vvagMh9J9L42CMCWAm7FBW5y96uIqqCjq30QtifEAjSltPHNu?=
 =?us-ascii?Q?34VwIuXieiNwSTGOdzlVDmz7K0zRFxCrb1oxHgzmMSTZIhOWcyy3PB76phWj?=
 =?us-ascii?Q?1YgikohcRr4EKIqL3qxvHhClMnntAF1aXPLwq6AEEASSl6a/10a0XySEx39V?=
 =?us-ascii?Q?dQ5KvjKAP+uTUaG4MrunQ2UJEfqLhK/h+MN9jtwUpfbSfjCz0HGptwrgbCuj?=
 =?us-ascii?Q?/EKfSrfbY7M8QLMVq/nFpiSRg7ezrfChF/glNpTl91wr7rQEG1tQ/fzrjq9M?=
 =?us-ascii?Q?3MgCquoof0KkxZsHy/AaQGwDx4YVPrATEEktWBLAE02OsOa4TrQEzf/UAijq?=
 =?us-ascii?Q?h1f5nXnIpA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7f6658-7f16-467d-5bfc-08de846b5e74
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:01.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NW43hyond9UiE8BDtU94csaINWUIEUulrqG4tNClXh+/YCxCfFmtHJM1Hk/TXa+2cy7X6O3AVlXHXGjO5DLseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: "Paul E. McKenney" <paulmck@kernel.org>

The torture_shutdown_init() function spawns a shutdown kthread in
a manner very similar to that implemented by ref_scale_shutdown().
This commit therefore re-implements ref_scale_shutdown in terms of
torture_shutdown_init().

The initial draft of this patch was generated by version 2.1.16 of the
Claude AI/LLM, but trained and configured for use by my employer, and
prompted to refer to Linux-kernel source code.  This initial draft failed
to provide a forward reference to ref_scale_cleanup(), passed zero to
torture_shutdown_init() for an unwelcome insta-shutdown, and failed to
pass the kvm.sh --duration argument in as a refscale module parameter.
On the other hand, it did catch the need to NULL main_task on the
post-test self-shutdown code path, which I might well have forgotten
to do.

This version of the patch fixes those problems, and in fact very little
of the initial draft remains.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/refscale.c                         | 51 +++++--------------
 .../configs/refscale/ver_functions.sh         |  2 +-
 2 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index c158b6a947cd..a2d9d75d88a1 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -92,15 +92,9 @@ torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
 torture_param(int, nruns, 30, "Number of experiments to run.");
 // Reader delay in nanoseconds, 0 for no delay.
 torture_param(int, readdelay, 0, "Read-side delay in nanoseconds.");
-
-#ifdef MODULE
-# define REFSCALE_SHUTDOWN 0
-#else
-# define REFSCALE_SHUTDOWN 1
-#endif
-
-torture_param(bool, shutdown, REFSCALE_SHUTDOWN,
-	      "Shutdown at end of scalability tests.");
+// Maximum shutdown delay in seconds, or zero for no shutdown.
+torture_param(int, shutdown_secs, !IS_MODULE(CONFIG_REPRO_TEST) * 300,
+	      "Shutdown at end of scalability tests or at specified timeout (s).");
 
 struct reader_task {
 	struct task_struct *task;
@@ -109,12 +103,8 @@ struct reader_task {
 	u64 last_duration_ns;
 };
 
-static struct task_struct *shutdown_task;
-static wait_queue_head_t shutdown_wq;
-
 static struct task_struct *main_task;
 static wait_queue_head_t main_wq;
-static int shutdown_start;
 
 static struct reader_task *reader_tasks;
 
@@ -1357,6 +1347,8 @@ static u64 process_durations(int n)
 	return sum;
 }
 
+static void ref_scale_cleanup(void);
+
 // The main_func is the main orchestrator, it performs a bunch of
 // experiments.  For every experiment, it orders all the readers
 // involved to start and waits for them to finish the experiment. It
@@ -1443,9 +1435,10 @@ static int main_func(void *arg)
 
 oom_exit:
 	// This will shutdown everything including us.
-	if (shutdown) {
-		shutdown_start = 1;
-		wake_up(&shutdown_wq);
+	if (shutdown_secs) {
+		main_task = NULL;  // Avoid self-kill deadlock.
+		ref_scale_cleanup();
+		kernel_power_off();
 	}
 
 	// Wait for torture to stop us
@@ -1463,8 +1456,8 @@ static void
 ref_scale_print_module_parms(const struct ref_scale_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" SCALE_FLAG
-		 "--- %s:  verbose=%d verbose_batched=%d shutdown=%d holdoff=%d lookup_instances=%ld loops=%d nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
-		 verbose, verbose_batched, shutdown, holdoff, lookup_instances, loops, nreaders, nruns, readdelay);
+		 "--- %s:  verbose=%d verbose_batched=%d shutdown_secs=%d holdoff=%d lookup_instances=%ld loops=%d nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
+		 verbose, verbose_batched, shutdown_secs, holdoff, lookup_instances, loops, nreaders, nruns, readdelay);
 }
 
 static void
@@ -1497,19 +1490,6 @@ ref_scale_cleanup(void)
 	torture_cleanup_end();
 }
 
-// Shutdown kthread.  Just waits to be awakened, then shuts down system.
-static int
-ref_scale_shutdown(void *arg)
-{
-	wait_event_idle(shutdown_wq, shutdown_start);
-
-	smp_mb(); // Wake before output.
-	ref_scale_cleanup();
-	kernel_power_off();
-
-	return -EINVAL;
-}
-
 static int __init
 ref_scale_init(void)
 {
@@ -1553,13 +1533,10 @@ ref_scale_init(void)
 	ref_scale_print_module_parms(cur_ops, "Start of test");
 
 	// Shutdown task
-	if (shutdown) {
-		init_waitqueue_head(&shutdown_wq);
-		firsterr = torture_create_kthread(ref_scale_shutdown, NULL,
-						  shutdown_task);
+	if (shutdown_secs) {
+		firsterr = torture_shutdown_init(shutdown_secs, ref_scale_cleanup);
 		if (torture_init_error(firsterr))
 			goto unwind;
-		schedule_timeout_uninterruptible(1);
 	}
 
 	// Reader tasks (default to ~75% of online CPUs).
@@ -1604,7 +1581,7 @@ ref_scale_init(void)
 unwind:
 	torture_init_end();
 	ref_scale_cleanup();
-	if (shutdown) {
+	if (shutdown_secs) {
 		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
 		kernel_power_off();
 	}
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
index 748465627601..219fac070af2 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
@@ -11,7 +11,7 @@
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo	refscale.shutdown=1 \
+	echo	refscale.shutdown_secs=$3 \
 		refscale.verbose=0 \
 		$1
 }
-- 
2.34.1


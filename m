Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47854225405;
	Fri, 18 Apr 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992674; cv=fail; b=gq8WYS2ZbMU1p1RubKgpsUaFHNR29F3AO5XiuKEzBY5lcKPGWOLHxdBAlDuvEdOHcmTdwLwtKx4I/QWPkYSA908hTTpHybG78jowolhH6Zc0oZltcPTj9NG82Zthr92y3YcKy/YonEJyWyKIFzpV550RlKvVgJ8m/AK8T+GT0qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992674; c=relaxed/simple;
	bh=d71YRLve32MsFx+UTDRArVLNdPD2yvUsrctWzW3piqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lmw3ZsvVjbj+/aFCs+3yw8AYZpQSQP7jBgAbXpAhwktzDPANCnDahg51PdW4wiJO0iEYbDQcoSBN7ArZcIrrBA5TveMEbU46kVtWa50c4WHnuvYQ5qbeY3524fBfbLlJHFFY9blu2L7J/820Bf3V1NJ7mG3pUfke2GhaeLYADVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RhiC5n99; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RhiC5n99"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbaVFKN1Tfpvj0ZP3hPxrEIQRqFhaCDdSqPkK4l1xd0zukb/CBNxODDxzS+zVS8beLfxt0jLnvYYWAcA7ChR0xKTQJErpJN0j011yZTLQQuiIQSy31ogs2evYMxVrWHfe13Lo8NdfqvoakwJkb6M6q1FBGztt8vca2ATZz80nnEUi/kDyj307oIqcypdMNmCoSs2EeKfobAy2+vd+60IXOhiQrM3o86b5rXdVJqQfC5ukY1hVjs3EzNm4zEW7UoxqRdYFX7tcZGLDuThf1jSX5kyf2xvOw9m1sjEdexzOJrJrCyk/iUWwAmOvXsViD301NCnG+oPqKAdwAuCjv7Xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1v754Ow3u5cYq0mL3m2Vg3oeSxRac/bUHEjIQn9ht7A=;
 b=jrpYXUatG0uDjKeZbzJoVkhGPwOPnu/PmMp9MXUVDduVEgO3evEPRyYR1wpZl/LKseDSrJ7nvie3hJAw2mV4j4kkNtcdcBwUTIZaUipUCFR6Lsgg07zg44OC1tdVAODYa4RP+tr3N/ZEB2lmT0NOgWN0Sq2UYEw39roPWuf/JY1hZs2nLPxNe05TsRAFvlgBAAOXZCK/tiq4Zdc0208E0c1mAKU8cLhQLPNk+sl19YKw3Tl2IQVkg+amxitX1SlSwqfFHs+tNEbW5Q+xKtFLpgjWDhq7PWong6Qq5wH/Z40A375et0P4sC9cIA7yutnWf3qdb5LgBoT2m14DX1Gd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v754Ow3u5cYq0mL3m2Vg3oeSxRac/bUHEjIQn9ht7A=;
 b=RhiC5n99cf4VevlrV2vK2J2cy7XibYIb0wR8VlN78ixqZtEt0S8ObkmQNWnCPeUG+JT20cqG9325kzv3X6LokvlXLiQvgnXb90y2hA7R/G+ZLzljv1zpP5174HopCxiEg+ypn9oBuA/lJYqLEtxmme/bvX5HFQo6+p8msWEM3QxtFZOKWnUqvj+ki7LBQU7pAXgGFzIPfSzaVvCWHe9XJJlB0GFBZkily8hlHq14JryAr2fzwYf4DqRni/LQKeha+8jRmgsHZgxy376TYJ6b0boqnqOcKJaoVVGtyloD3OTMyo2VBKulz5lnM3jozzBvTGBwljkuM8ZoC8H6q5ITQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:11:04 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:11:04 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 06/12] rcutorture: Pull rcu_torture_updown() loop body into new function
Date: Fri, 18 Apr 2025 12:09:52 -0400
Message-ID: <20250418161005.2425391-21-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR15CA0064.namprd15.prod.outlook.com
 (2603:10b6:408:80::41) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d901b6-c9e1-4e21-c1ed-08dd7e939ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PmcMXqsN730xkzlr61mUqZzzz0uVIY3ad3rl8jxUKsfwCVYg2BWfPbWJ2jh5?=
 =?us-ascii?Q?3uONNt97ghir4ymDFQYt/8xNe+dUyyZ1DqkmKKGcHfCnkiapkdu94/fRVWFT?=
 =?us-ascii?Q?2cawv7EbS5cbRaOKDiIejnzY3pkZgZaKCOi/C3cLhMHmUz0hw2cmxgjkmTda?=
 =?us-ascii?Q?bO0vQQTR3iznW1Bgrh30v0pe+8AhL61fxN32vZbAI2mtGO6g2g/Gkqdpb5UO?=
 =?us-ascii?Q?br/ViCSNa5IoUUXJUx0+4UVEo8ENqh21p6EmU0sXiJI9qt/rs8TCCoTcVl7/?=
 =?us-ascii?Q?0DByOE07T6dWWrGNpzGvKXw5QKQzyR3rwzIsoZU2KDpkjINcOB52VhmlKPvT?=
 =?us-ascii?Q?dm1pRHrPlEXyKK3+NTtP2aOVQjv8OpV/P7XLnZJtAT2likolTLdTMibAl1HZ?=
 =?us-ascii?Q?pNxJUbUSfoCMG05uWn+TlhoebXbPAMwwIfKrtHA2wcko6WgfNPIwl7VT8h5o?=
 =?us-ascii?Q?sJ0en67oFGEtZ+5dnTZe9TNAIcnvH2l8j5vSZskIjRPkRW0JgQL/vgl1+E4w?=
 =?us-ascii?Q?zFecAx29ETRqJFadVPQNc48Iho2s8wjh3q8CTEkzH8rSBIUiqNoJ2v6bXUfZ?=
 =?us-ascii?Q?ADQmSGGyUr/SEB+LyPocqqVC1HRkFXxxkA48DgqPXYwdqaivU7WsCht/SLt/?=
 =?us-ascii?Q?U57bexEP/dQV02TLiyW8eCU8rbt16tC2JgdR31zJNtt8HRRPe/AJ2rYU5F8C?=
 =?us-ascii?Q?esjcFlxZRU72K2LjELZgvbCsGviwB7/tnjjpqV5OUj7LErC1muCgU5524joC?=
 =?us-ascii?Q?FD2Tq9cQ+498f2FEnoCIAyCFnXV5R1ywaAef84lkISlkGiPbWkKmZTs+UaaZ?=
 =?us-ascii?Q?I+JN56JGJrQxia857yhQ8DSnateq/5WOxQVPLODAV5TIKnUSQ9WR4GDxTwtY?=
 =?us-ascii?Q?O3LRQa8CPJK1+ab9QYvH0sjrjEORJSFcLL0LZKWeO+tyOwIqJIoTT2Uq+EPF?=
 =?us-ascii?Q?L+FMM+T0Cz5wKRoTUSfw799SvLAGlw+6cGiWBEdv5SzUajIuYXh5ptv4EN8f?=
 =?us-ascii?Q?Asyvu0FmpBXg1LpjG8ZX72QXCaPZ5SAZTmIK799GkjV8ZTjEGLyk5WVMFmJC?=
 =?us-ascii?Q?mYUVcbzRgPQ4OnBAbmfihsEvrfULAWetTHKRMwltIZIPXmQAwoiqDemF3jHD?=
 =?us-ascii?Q?yqeRUlKyqGTCshlJQRJF9gbzpw1WmhOp/07CeYmNbWyF800hzTElC0a4tzee?=
 =?us-ascii?Q?6gPuYErVgb+aq0vGk/GpvvW4/X3IEHX4rZXapJP/lE/ZhNbtRAopR+dB0SMw?=
 =?us-ascii?Q?W5GZPM37YfCXcasq6gShJmOFw8XdpSCl10r3MlpOjZAsRbODHyJDECqlEdJB?=
 =?us-ascii?Q?8EB44HBiZxgWfIdVw6q61aJvAtGVujl/wBfXo5z5S2wUfD0b0j0qD+q28UZ/?=
 =?us-ascii?Q?4gGvoQyNGHcZLMwCpuSn3h2zKSjZJlJPcnK+7wHSyVQszWuUQE4o/IkS3adD?=
 =?us-ascii?Q?X5gAT6r4tPtkmUDm/eJmEDHF4oqNnGwoScuIR4Xv7pSlKq2IXLBeSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NLCwESrOHfOtZpJQWHz3joVWmAjOIy4t7m2PVpc3wkLzjIpiZ/RVubMhc+hv?=
 =?us-ascii?Q?L9GyL0IecL4kSwbl0AS9vCxSe5/89OpFPBsJL+99XXQf6VqLvCJ0Zn3JYAYP?=
 =?us-ascii?Q?/pAyK4o4/VhKVW4yAPQKXlmSURUK7K+GuUuGT/4isCdlydj54eu2hHeuzB7T?=
 =?us-ascii?Q?JEhVdhjObpSVxmAFZt5A0/U325rvJ/+Ba+vTXq61snSvS4++vtrwn+BYVv1o?=
 =?us-ascii?Q?xpdvmX/mv+bKpz/DeBMlZee05SRvudTjw9PSbHgZLNzi4IQiXcc1KOc9xuzP?=
 =?us-ascii?Q?+Vj4U4y+cKxyDfkibfzlofikZ2K9eNDSP4qS6yOATL8a13S0bWuzOYkEPwBA?=
 =?us-ascii?Q?3GmmRM7b4KU/Bsdn9Yql/cGef5KT63e7Pfz298COU0rg/nAxJaWSvPhf2Mh8?=
 =?us-ascii?Q?nmlI+m0OP5zkADBhw4anCsFPh7ge6SZzV8qlKTT6enSUQoNNMgDd7HRiwr0Z?=
 =?us-ascii?Q?iJLxPBVZ0aIikKgvBAMfdyplRK1+HBYWRNDxpjdZ4LnRSuzGCQesSw7SjLQ0?=
 =?us-ascii?Q?QyW2kKiXkp6mBbIOntPEIKNvktc4xG1Ul3z+YPzEoARSI5iSZwwMvhotiEWV?=
 =?us-ascii?Q?qH+qXJPOSXa6B8p2/y4PcYPC7DToTFUwDvRypST+wMazbrfnI8cJS2F7Hnmj?=
 =?us-ascii?Q?XA4Th2aSbV/eLDTuBN6w81tBxR1XmgQhM2FLzCpAHIV5XYolkKcKrcf55arV?=
 =?us-ascii?Q?ob1J9II0czDeKaTAvnMxf1NmmgvD8ZolWqk+4KfdY8R5wxNB7jqfDRdLGTL4?=
 =?us-ascii?Q?1q6RBxcpOcfirJ+2o9HeiWdc+ykSUGlENoBruPn3gu7BFrJXpP0cxkSrP/mD?=
 =?us-ascii?Q?8KjfCP3ZtEz//RtnSSbUMlUpA+OUiV3xDK60JgFaRC68GrorNJaqucBbygW4?=
 =?us-ascii?Q?QMW4QwSxq6giWG2iBrZuArXFmMy8hQzyjshcSJIowC8knHVvlKnFg7m+RDwb?=
 =?us-ascii?Q?c0CEkAzMmrMcdKY0m5/bf8++P1bqk74PQkCkAqRndgE25tUBzmpYD83tvaIV?=
 =?us-ascii?Q?ps9hXlzIHGyDAtq4IYzv3EQY6iPTXw76tTJGr6XosBFZCvhzMIxcj4IP2dOK?=
 =?us-ascii?Q?dQQXN5rkGkaeXOwqWFcQAer2u0dzYRQEyuUSLmOPo2ISjzl6DnBkPVjEIXQo?=
 =?us-ascii?Q?GQJy3+WJ3DuwsQXstw7+zTJZwNcYw6hhsWmKSWQspsVALl/pe9kD5XdID+wR?=
 =?us-ascii?Q?AkvXQiQ7+DS3zJQRth8oqS0moKn3uX/R3bjlTxCVpOIRJ7Ah0vMge2EMTXSQ?=
 =?us-ascii?Q?O+fW0YuRJh4tpiU+LG5Ib6/l4k0bW5UHYue6VHcuLLdso4ZTQ3zkyRsBlmFp?=
 =?us-ascii?Q?4ynZS29wzq/T4Q9ae3S9tTSZomj74MoJFuDIvgY6qVPK4hksCIyN8okUOTek?=
 =?us-ascii?Q?DmIo5Lna1T0h2ObLC2PpzrCkFiUnkNJxhmKQpwlNTtt+ylLszI/hya1jPbM9?=
 =?us-ascii?Q?4VhAubjLhkjeD1uOTyZc4FSF6Cc6TBvIOCnSGtvbkKmJS/hzy1e/3vAc9XF3?=
 =?us-ascii?Q?DJ+g3AxNb7EWkLFGwqOVMo1sxRqp4BpVKNAXoLh+ndtDIfEguX/ztVKfYEJx?=
 =?us-ascii?Q?8KlGoM4EqIjK4oqz+lWk8mEz3j/uH2rNWwp+3+Zw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d901b6-c9e1-4e21-c1ed-08dd7e939ee7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:11:04.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoPp7y5/gQmP4K8a9VDfNS6hCoA5fg9z7PffQ6J/O8SZXOOT8MFnGpunahCuz3d8FFYTL3xUhyBic/FV/JhI/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

This is strictly a code-movement commit, pulling that part of
the rcu_torture_updown() function's loop body that processes
one rcu_torture_one_read_state_updown structure into a new
rcu_torture_updown_one() function.  The checks for the end of the
torture test and the current structure being in use remain in the
rcu_torture_updown() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 46 ++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e7f0521c56d0..7eccc74e60a7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2505,6 +2505,30 @@ static void rcu_torture_updown_cleanup(void)
 	updownreaders = NULL;
 }
 
+// Do one reader for rcu_torture_updown().
+static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rtorsup)
+{
+	int idx;
+	int rawidx;
+	ktime_t t;
+
+	init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
+	rawidx = cur_ops->down_read();
+	idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
+	rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
+	rtorsup->rtorsu_rtors.rtrsp++;
+	if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1)) {
+		cur_ops->up_read(rawidx);
+		schedule_timeout_idle(HZ);
+		return;
+	}
+	smp_store_release(&rtorsup->rtorsu_inuse, true);
+	t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
+	if (t < 10 * 1000)
+		t = 200 * 1000 * 1000;
+	hrtimer_start(&rtorsup->rtorsu_hrt, t, HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+}
+
 /*
  * RCU torture up/down reader kthread, starting RCU readers in kthread
  * context and ending them in hrtimer handlers.  Otherwise similar to
@@ -2513,10 +2537,7 @@ static void rcu_torture_updown_cleanup(void)
 static int
 rcu_torture_updown(void *arg)
 {
-	int idx;
-	int rawidx;
 	struct rcu_torture_one_read_state_updown *rtorsup;
-	ktime_t t;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_updown task started");
 	do {
@@ -2525,24 +2546,7 @@ rcu_torture_updown(void *arg)
 				break;
 			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
 				continue;
-			init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors,
-							&rtorsup->rtorsu_trs);
-			rawidx = cur_ops->down_read();
-			idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
-			rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
-			rtorsup->rtorsu_rtors.rtrsp++;
-			if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors,
-							&rtorsup->rtorsu_trs, -1)) {
-				cur_ops->up_read(rawidx);
-				schedule_timeout_idle(HZ);
-				continue;
-			}
-			smp_store_release(&rtorsup->rtorsu_inuse, true);
-			t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
-			if (t < 10 * 1000)
-				t = 200 * 1000 * 1000;
-			hrtimer_start(&rtorsup->rtorsu_hrt, t,
-				      HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+			rcu_torture_updown_one(rtorsup);
 		}
 		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
 		stutter_wait("rcu_torture_updown");
-- 
2.43.0


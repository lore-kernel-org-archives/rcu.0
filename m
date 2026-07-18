Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59525B0A8;
	Sat, 18 Jul 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394955; cv=fail; b=Lw+E4BWp7gvSgUxjDySu6NR3ZXdf+XhWp2/kKG/WletMG/dKDMqpuFYP793/Jp0xQ2AzNpdSEIRarwaJD4ctBhhecD5pjovcjF6uj+h/gTUUXtzaJS+9394CLuTcBhxDHRQC0NegR0yH1Xxq0Z4hfdCIf9ex5RvbIGaDm06/CNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394955; c=relaxed/simple;
	bh=PBAy84dMWZhOYbTjFpc0Yxn2uZ9pxYLShLttP+gGge0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuDT23jBaC1nnR5EAwfT4t9gfBFjcQHf3gn7DRoyoYVZyhKnUZiKQJvi3FYy7+O9PQk/EgLEkeKfEnJwLrwxEhD9jqqRwTmMdE6oi1jPvZHjyM2mTlYnkWpfT+QQmHguoqDYD/LRdcXgLSZQIrvzGVDCoJMwscyMg7VO5KpvHCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kIkZcAlf; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kIkZcAlf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dz5r5D0x8eQ1czM7s++T3h1/sMAI3W1owcF4LVgb09F1Zr706fpyEVuBLLSIx7uJMDgBhdMYDYZRjQ2nQ8BlbRTdh5S6NzQjEKzPz9Qn1WomM1vf76Vr42QkU7XP25kLyLrpDu0yzgLrxca0GUaEKIsAHCqwl9qpbJSspaTMtuYlgGXf7UHTDvG15YB0n37FivoSQxzLmfl6ThCnnMEb3pRpifBSVksRGDKCJvje9oTSQJpXRMMlBOpXoauS8R1e8lO33pTorYJvCWBM5ASliwD80Ng3PyH+u2R4/Rc8iw+Bo8pinufD3tpuOsImMBZsNJq5BbXVH5mtxBin/Qp06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VJKC2dEPNA56Bm52vzsOQmmjObCh+OFRvv/Q2pci9I=;
 b=LW5IGLxANsnJ5MfD/rjZu3qvqZlu3hAb1uk+j39mQQA9TgHtUs80q6QfCgK8hGGE/X2qNuv8SW4NukDDtBt1Tk9tLjDo+oUIHNrek2qnF2VOBVMjbamkBkK90/mJsRmRmNRYRaepilHgVhiSEKWgDcsXUTZl8mNLlcyA7bKj3H/rUPqhSQzFbvoqYvsueu3/hJ9gZBWLN/NzXgkVjbOnqzC+33szy8O6rnBqGAZpan2eKPPuid/+xA3S1Pk9WOYiO6f8lzuu3iYqzAlByrUu2rrOkgOdu1Dct8qCH0n2zalmvieia1BQXqXA37Og642bSdFQ+Uv3F7vCiXP4CkjLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VJKC2dEPNA56Bm52vzsOQmmjObCh+OFRvv/Q2pci9I=;
 b=kIkZcAlfZorWSKjoluWyTZesv4VDGiNH++i7nc9wPMSiodTysFG1UtMdIeFcZQ3Zdd41eiCEYV8+VQ9KuHC4wPdMxX2qt9i+jEAt65klS24X381VfLGyTAqNVx0FqiMsIjzN+Z903gJ150RMFQVEd4/ezv/V9ZYufRSWnlPmDcbsS1+A92M+k6zlbBtZhQ562zn4P2LAJ78eAni7AUDgvvthKNVUUcEJztTC/w1wB1Mx7EPppMPFqTCGQ9JmMiVaJ6rUJmv33gtYC3pzuGYFbAkGkMTz+1KrFyDMssWrKmKVqVuKCHXsJcC2F2ei7j02WP+hLRp7Gi7a6JjRM88cQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.13; Sat, 18 Jul 2026 17:15:50 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 17:15:50 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH v1 3/6] rcu: Remove unused func parameter from callback-enqueue functions
Date: Sat, 18 Jul 2026 13:15:34 -0400
Message-Id: <20260718171539.3781595-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260718171539.3781595-1-joelagnelf@nvidia.com>
References: <20260718171539.3781595-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:52f::30) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 4351233b-796c-4a7a-3731-08dee4f03770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|921020|10067099003|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Bgiz3wF/KMW++JjYMbBsXI70y1OTNUnVF4YOLU08tqmM/KKHuVcgqZ6VjVvNFedBywQoGnoMxMNKDBQy8/Z4ZNBeqXd3FpOAdf1aA885BBL6ugGfwCxcCrEcTDwVOgVwZVYTV7+8gKRlGNb/eUlmhwM6cHWCxZJfzXULjqCWq5YxtiKa03z282Bz+9ZY8BCWjwNka3nTKcPFyODKF5Tv855dr+ZXyUE+9iOpJtmWyboEa7TOaXv06NhJQRKVHrsiruHqwgx/9/UbkdEcQ6SNFzkFz9Iq2pMsIHyo0+TTK6o7z59bGkaKzoSJEvJBoaNxNkXm/VrcCkxAaNUelX+Amf+RgrjV7mmCVC1uPl1T7V3k760I2rTQB2XItrfwUcMvrLpqQR9VuyLG5ncHPOuEOYGuOjUH7foKPiT5v3nu6VQyUmdMF4ErnAKkZEC860iAZfrIT7Qfw0W4rMqSKP5lmCwof4Lx1+UTLYuB+IYy8RfUgYywCVstutBiXaxeDjzkKkU8wMXLaSuh9lkhoZfB+QA9LK3fNzgUjBRJ3WtoPWNuxI6lyssOHGz7RIizOKiC3UP/yeEB7e3DBJvAyogMsz4SK7ksOMcJ4EpWehtjGzx9ejKMzUpE1SjKUCzKdvvYyE05bxrq7m1tVLm+6cRWlO1eXgt3yV/l9rD4coKIkwbFFm4apQ//nVY87r5RYJoHu21qIXQ3wr63ZyySya3qBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9q5ec3EvlfoG1Nt4YPVxNE5h5rzFZJQBDLxMkdWctndcOCIFnEP4REhQNtuF?=
 =?us-ascii?Q?1TPlrhnhYt9bPa+xJhqILoSkDTDmu8G9bgMLaNJh4Qhr8mIc5O1JgcAMZAN+?=
 =?us-ascii?Q?NIZw6wurCULYbaRzRSvTgCh1Epayqsz6HWzYg6/7Ob5B3rTWzDkl4mAGlNKL?=
 =?us-ascii?Q?a11I2fmKC7kZNGXOPUTMDWgtisaQTad3rJn2E+pG1AW4aB73sMKtCGIo3fI6?=
 =?us-ascii?Q?yweC489WGbXKz7mDctTOvsUrcQ9ZgFwSw9vbQTHo96VJU09VlbrF2SI/Intx?=
 =?us-ascii?Q?t6dHObwehxBq28fx6vr9Qa17xBJcc5eq8/cEgYiPQ1fW9tLKWjiAdCrPCvz5?=
 =?us-ascii?Q?zdonO8wkacTC48ztL/8JtH/e+fHnfpnoZnU7D3Qs62z9Wsu4nfYWSkG8SiRe?=
 =?us-ascii?Q?CxWqIPJdoo0KdeSWN6Rkk5QpZ2kcpQDj0c3o+Zflej+3kPDHlso2tHiMSc8y?=
 =?us-ascii?Q?rdHUM8LdBYRqRKjy4yAFO/OKUfgk2s0onYRgq8hp2JnWyNbbuzsSvwulq+v5?=
 =?us-ascii?Q?AjwH3uEcB0cQ86vL1HTISr7HEiL3gb0zG6MHWGd5+EpGTVzLOJbT9COS+n6d?=
 =?us-ascii?Q?XQHeRDD2vZ9GvwFpSR/5uO7pEjX+NFwKt9Xf7kNDIuqkWvDnf+fniCwdEzSP?=
 =?us-ascii?Q?GtSOLic8ftypkHjd5f5TMYIPN+uwMZF3iZl+jbkcGXUODJWWHpf+2uvxpEjF?=
 =?us-ascii?Q?M8rUMJCltpsS+r5mTyZo7ujFLhllRZ0Y7kDL1ka/x9QppojhSht22YGP6Zqm?=
 =?us-ascii?Q?bSqDZ8d09mkpWHcMy1o23FQ9+67KZGaiXQU9PWz4i4n7Yru6kjNtb1wWV0wu?=
 =?us-ascii?Q?SwVzMIsn9J727w3sMqkZeianJhfPDH8CHBdLCGZ/FNcGDeAiNL+u+uwJsfim?=
 =?us-ascii?Q?zHlbq2nOfC9ZX1F3nmovkEY//zX/96+/fD3EjL0uxd6yAsKBvCEN4cMBPkfe?=
 =?us-ascii?Q?XkVWa+3SM878Q/QbwzvTq3WrVYCyMJkibKejvSlyeBiA0mMtUtkby5S/ZHFV?=
 =?us-ascii?Q?6Cqq9mB/4fu+t1IkzCdD3/FBbp6c8pgBMjZtQJZloEGy/C8B5dHMIbmy7MgR?=
 =?us-ascii?Q?8exxxMXcXdiZI1WdjQ0WHxAT76L5v+1NPQmy5QsOPht133bKrZWFtw/omiKl?=
 =?us-ascii?Q?NUTbWOnoAXwR/2x2DbhvURRkm9OrzixIB0Cz154JhbXb3t5ra79vGNxhqpYl?=
 =?us-ascii?Q?ImRx5Wvmvq5p2PHf3+l8Bmc2DlCtl/w6PRGh8cukfjKyQn/UO9h2mQmQWzOL?=
 =?us-ascii?Q?dw/cg5dYS4SgQmhDaRBsE/4dnz6OkGsfBQoNJlJBDbrRT0BMXNczlaZj7qT3?=
 =?us-ascii?Q?VHPxN+TdqJYNTOiaow7thMrAFCcQU2GujNlYgpP9gktCBr5TIsHdgJk907wA?=
 =?us-ascii?Q?hahI/TIMPnGDdjSHH9ZfLiiKp7cdQpYoFHwd4cOchM0EXbCd/nMPaOP8kkvH?=
 =?us-ascii?Q?L3OliwxwlgvB5hXuhkutCDisVG5hvW2rS6056lcrZRcCq2mT3S7EioFadRoW?=
 =?us-ascii?Q?537S0hZoeNWcrLW+/60wD0QBuwlLyQ/V3U3TfFVYk/3kLg4Til/Gb39RKKqY?=
 =?us-ascii?Q?ysRA6FguVTFgYUVqELEACmgULGqXyOBvJIS9uPvI/zMgiPJ9kWhQFA0U8AIa?=
 =?us-ascii?Q?sOYZGk71t6foVLJ4rEOd/mGk5aQ2pFdixlSuJUnsuxJpnmvZ057fd1HASCNG?=
 =?us-ascii?Q?rv+/YGFX8HZEkKbhbt8gvNT1Rc9MrN11/F27vRiNp24qHsOUgYQDPoT1EDdN?=
 =?us-ascii?Q?tUaqsJF4fw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4351233b-796c-4a7a-3731-08dee4f03770
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 17:15:50.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlPvRJgJ5UMluCh/+Hc+0hD33vSVQZwz6HTkV6FUJ9Wt4ze4EheG3gw5yrsXhuKn86ACMMRH3cU6neSVoy3WeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

Ever since the kvfree_rcu() tracing moved out of the callback-enqueue
path, rcutree_enqueue() no longer looks at the callback function
pointer:  By the time it is invoked, __call_rcu_common() has already
stored the function into rhp->func, and the enqueue path only adds
the rcu_head to the segmented callback list and emits tracepoints
that do not take the function pointer.

Nevertheless, the function pointer is still threaded through
call_rcu_core(), call_rcu_nocb(), and rcutree_enqueue(), forcing
each level to carry a dead argument.

Remove the parameter from all three functions, from the no-CBs stub,
and from the corresponding declarations.  Anything needing the
callback function can still get it from rhp->func.

No functional change.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      | 10 +++++-----
 kernel/rcu/tree.h      |  2 +-
 kernel/rcu/tree_nocb.h |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ef553189ee24..f741654e80e1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3020,7 +3020,7 @@ static int __init rcu_spawn_core_kthreads(void)
 	return 0;
 }
 
-static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head, rcu_callback_t func)
+static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head)
 {
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	trace_rcu_callback(rcu_state.name, head,
@@ -3032,9 +3032,9 @@ static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head, rcu_cal
  * Handle any core-RCU processing required by a call_rcu() invocation.
  */
 static void call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
-			  rcu_callback_t func, unsigned long flags)
+			  unsigned long flags)
 {
-	rcutree_enqueue(rdp, head, func);
+	rcutree_enqueue(rdp, head);
 	/*
 	 * If called from an extended quiescent state, invoke the RCU
 	 * core in order to force a re-evaluation of RCU's idleness.
@@ -3175,9 +3175,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	check_cb_ovld(rdp);
 
 	if (unlikely(rcu_rdp_is_offloaded(rdp)))
-		call_rcu_nocb(rdp, head, func, flags, lazy);
+		call_rcu_nocb(rdp, head, flags, lazy);
 	else
-		call_rcu_core(rdp, head, func, flags);
+		call_rcu_core(rdp, head, flags);
 	local_irq_restore(flags);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index beb86e39909a..aaccc57e75b1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -502,7 +502,7 @@ static bool wake_nocb_gp(struct rcu_data *rdp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
-			  rcu_callback_t func, unsigned long flags, bool lazy);
+			  unsigned long flags, bool lazy);
 static void __maybe_unused __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 						unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index c4a5b4662b3a..9e5757e6f875 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -603,13 +603,13 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 }
 
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
-			  rcu_callback_t func, unsigned long flags, bool lazy)
+			  unsigned long flags, bool lazy)
 {
 	bool was_alldone;
 
 	if (!rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy)) {
 		/* Not enqueued on bypass but locked, do regular enqueue */
-		rcutree_enqueue(rdp, head, func);
+		rcutree_enqueue(rdp, head);
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	}
 }
@@ -1666,7 +1666,7 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
-			  rcu_callback_t func, unsigned long flags, bool lazy)
+			  unsigned long flags, bool lazy)
 {
 	WARN_ON_ONCE(1);  /* Should be dead code! */
 }
-- 
2.34.1


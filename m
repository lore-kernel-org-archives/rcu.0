Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44420394795;
	Tue, 17 Mar 2026 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782611; cv=fail; b=YvxEvCC4NbKFyBr0/fEAXjMUzgR5FfEgN50nf8xX+VTEe2zYf6Pbva44PA400hi3ZvG62OQSu15W8taXVNq3tP7cxIMjcHjK+PZJXI3LBhEh4NLBxrYmhe8KJD4RZNR8i+4OKxT6JPwDK9hzVWt++vXhEr+JuAv5PKz+2wWLaS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782611; c=relaxed/simple;
	bh=b+Cj1/okJvsyosGoq+DYfcPgFfZ5N6HxfLeSUEJUDek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PZyVbo3oOXv08SVWITOBeGUQGNc6iUcG7VFK76Kyy7Giu9Aujwi71s/gif8bPSetpvITLPqel3uXIj6idCgaQx71FHCrtzjIyuyGBT6q7L7VrMkTEW5gyuh/0G8lQgNMLuCphtmeKRDZlBT2GymqE61LPEJK18kANQdD9WfT28U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aVaA5Qwn; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aVaA5Qwn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFJ60IU3oEcrRbAumK3ZDsuS1t2xuMlwhjzJRhHUZtXXC2bkQRi52K5wlmOT9BGiquREfoLyHwlsHBYW+IZopnyEbg/GC6dkSFiEvARSxL/DCtRGtlmYpQKd+eh8lu8sbKHUrHq0ZHAvTSdp99M3IsY8m6zRKCpHL3fDLid0BgB4dYzHx7NvpCUZGa6Wr2qBR+6yq2J+Ap0PGNPplvCQySU/ZURR02sEu4W+saOKDXlmvOi3H9tX1ak8BKNgLc9xBakiU7ofHvUftpGZB6gDzwtdS3nQn+dNjXoZ35JqdMn9KPQiEZSatcD57iNY7uXfOwxKpjSGvXKchwhkar+v0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywweWZmKFSG9fF3zL3ywGg3JgjMP4RUkqbg5f99GnBw=;
 b=x+TLI5ew0Fue0y5hXFrfO0xevCrm+Z+BNlTxAJqwbS9EP9seMAD8pWqM5qPmPxLmOBizOIPARA57BpSqQSbIbdu98xPisGU81RuTporcJvUFac+4jf9YQseK2pdKA97vnKFzNAXEHltEqWYM7ODbMs7GFYnPXXwdQJy0bf9lhChmiDdtFzmCWdAK2S5RCAPJAwSf5RltbQ2NHWx1StWcFK/4b6L0/xlQ7jtSMfyBqhlzXGwcGJjHv/V6BvFpYcPOtjHAPlEdbqgC4bM9lOS1CjsU27zvurQteTZhMBe/SUZixS6crBqaOEkl00QrP70OKa/GlRMWfhYf2Go40W+VVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywweWZmKFSG9fF3zL3ywGg3JgjMP4RUkqbg5f99GnBw=;
 b=aVaA5Qwn8iN5whj68bSrChVNWbq7LmbvHnEp7IRxaFGxh8HjtmwGHQfDT12ssMoZYjeD1DFhW41Qtw/PxmNzH6hQPH7bB61E2JD+3w6vUXaCR+M4nMqn1abt5+Qz8OZPqfdoTc86VEYQnSkFyG8EWxD2xYOTSXaodZZS8rl2fWxN+jpt/fbObzFjJmqNxgJfArvUlpI5OIAACP3pOX6/WZ44+jcoJ+8a0XP0WSjVh7nGqqBvTQLNMNe8TUK9z44IhpB54mfwq2t4XsWuAP7gTUx2FuXEfra6tgV6iHXPx/MfN91fnAhyNEPKwwjwaIhmvyWU7S4ntwGj8nTmPNloQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:23 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:23 +0000
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
Subject: [PATCH -next v1 15/16] rcu/nocb: Extract nocb_bypass_needs_flush() to reduce duplication
Date: Tue, 17 Mar 2026 17:22:16 -0400
Message-Id: <20260317212217.1527644-16-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR19CA0111.namprd19.prod.outlook.com
 (2603:10b6:930:64::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ae5972-2c5b-41b4-6546-08de846b6b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	nF8QVIZK0Uwi+fN3ZzqdzxE9jZz5fbRS3pwd/yPf7n4f5qR75jFPjjBpay17kKge/cqsUa+CH9kQJG9lPwHp+sTugiqcEi0f5UusPPqJjEbhCrpFT9M5AxI32t3qptN1hgOAPkkxToVFpY/1dXqoSjH/+nfA7V13PgvNxAOjaS+ACOsghCgIp9VCZzJe8D/pagdUsK+RMyjNpAT6fqxf9SRWFt3lZUXfKV3d2aNLd0cDrYQKNmgQpMKdEoCYrw5VgQEwaOFuM8bmIspDwTxZjFqSajsxKztP8iQq1TfvQhyMKbSpfMFJTJxtbAfRVup0EtEvsF58KmOtCFisMftKvZqzdtb9sGHIbT57czBwl0u4gZAcp1m7kuWn1x7YQtwQgHCh3dFzPYRwZbrHQOGN3Oiv1f2HUrgy+2ZEYChaLv8KZwtJ9oEYhcOIX6dZT5tQJP8e91ipoSveok5D3+OQqP8u6T5HQ8kw0DVAfl0W5G+Z0vdrwGQjsprHo32RxYvf6wKIcO60nPfBSJCpx/wmBzJRVhkuAI4KZH4rxnoYjgnHbEokqTwkYpazBhZpA0Fmj1MuHix7cGjPcNTQ4m8urVoT4ciS611x7/voq5W0GWuzegmXUe0SOF8/JMeQsPaIXnhxZ0tGH5CjNKqjdglbxgFm8tHWu4cHHNRrptb/kdR1806E4srElFwuU43VUPZHtlVjxCJqCzYWaJutLy4db04cLlCOU8086xvKJ1gmsHcef9FN63fR3ln2zIyTH3R8nACJycvn6tsb+IGEM4QNDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PVGgho/RujZ4rgpVsbmuR083uUm2snOSYrHfUH7cWqAkJTkxAmLRW65pH6iE?=
 =?us-ascii?Q?yEcJRdfF5EThSsJoczHjG8wi2sMzNXmTS2QsSH6O9qP8n6jVZfQeqLl0vMAS?=
 =?us-ascii?Q?UW18u1dnGl3x7o0/OXG4m+IC3yYhcRw+LYQ2a73e1n8whAn1pGzkTMilrZYC?=
 =?us-ascii?Q?gBMY1EdfqLdjnrAaH/nWKIbbAI+Eh8GHbC+B2v39Ir1L+RkiNFqbwClmfOg3?=
 =?us-ascii?Q?l9+WyHIwtA2h1QnrOWbRGf86pM2ppFvqp8+9ETxwv4XOxbodZdvw6fh0xjwb?=
 =?us-ascii?Q?tOJbiOmveWNLGHQxyl/GJiaPd3yeIfRTT9VP0ybpo9hGRN52slDneOJAu2qQ?=
 =?us-ascii?Q?92Xh16/+prFLB4zHJc7yXKxNdyHSJjpZ6rVkorNCQcjAFNybeK0rPo6hvULo?=
 =?us-ascii?Q?Kyo8zUXXZW6zSI0p3LWhQB5gB+288whyVjX7RnCGCxO8xTYQZOZb/NtssFil?=
 =?us-ascii?Q?9itkQ4Qnk8dchi47zmaEpKOF0Vlk5JvM8n34Fm49p1t0fBMliG2Z/V7FZh/O?=
 =?us-ascii?Q?i4BE2/4S1Ta34bsOHpBMJuiam0ePBmiKf8tmOvCmhddt1IIBhCIb9w/B4gl5?=
 =?us-ascii?Q?bucUOuK+r0OQa9hO4Ixd7zwRQ5iQ5jfQYBm7xhD76WGX7/aT8iPnITbcRG0r?=
 =?us-ascii?Q?nmsS1cZj0Br6BG92LSvgJYdEl5PIYQXU4877X94Z6mWT3HSTBF/BV4UsqdEe?=
 =?us-ascii?Q?kHxns5N+19ybFVl1NzhwYgzKu+khQM4Ln9uWWgzrV+wXTh1izCrEbh6qjQKz?=
 =?us-ascii?Q?bPAytsYthhhhiNR350fz/KvB7H0w0yJ5S1i8EBohjP05tV573g7rRRWUbG3Z?=
 =?us-ascii?Q?c1dVrydU4zpw/0sOPVuKzKabe0TXe/nr7mDxhCh8UA05hEw0ejfHE5/b8+e3?=
 =?us-ascii?Q?yDl+Q27WVe74HR5bIHI671FZCN24RHE6Rf3j8Ay5hcJ83uxf4p06TJJmVtLa?=
 =?us-ascii?Q?0TIBhEf0HPs7pJEhg9jvVgspAnWrmfPzP6X7oBSwQ2lj/GNPt2Gg82woPLHv?=
 =?us-ascii?Q?2CE5or5wTdtMfHEE51Blh4KcSKjKF0qf4gAO/4q5EZSMy7wSNd4p96XubOQ1?=
 =?us-ascii?Q?xIp44476r7d/ukwxMEBC6/5dUsgrctfa4aLqC7VMAGH/IYSatFim7SOVpjFn?=
 =?us-ascii?Q?aP9a4vbHdHfleF9bKD2ts63bCfwq//ILub5ZupbaKGuQ82N1AZbeq2shibFv?=
 =?us-ascii?Q?aFxgLa2C9LSuQ5z4hFmCWbyefntGDSbTqE6zY7BxxOhbu2oyMutaOk3PX1Lt?=
 =?us-ascii?Q?QZL4U1FWDCEbRwr178h4NmdwhxgEv8oSNpqDldUuMTl9Jn6H1mCrW2eGa07B?=
 =?us-ascii?Q?7lpoWvVAQGBrxub5mmGW6B5zKobMPDIz8wC5f8Zk4zuULwAM6iP+W5a9iqvS?=
 =?us-ascii?Q?uFtDuqXmIAfeufBElYIJ6hk2LvJrzABdsAQilGgFDo6keE5VKksv0U1oYOGA?=
 =?us-ascii?Q?rbGMV7gNJPRxSxKfPz3PnPX3Fmq79oAJVnD0AFStife1JfynkVfQ2H5Fj2A1?=
 =?us-ascii?Q?i6pXzjfHHuPO3UjtpDksyvbL2EXLL74l4j8RBoJqIgCEF7Eq3X4SXB/5YBwn?=
 =?us-ascii?Q?Ei6QjSnydL9qHKNu1b/mxmWSgLUyvTX747JLqsSpV7FoAqCD0M8I5ChG1M3U?=
 =?us-ascii?Q?b+ZEuHOdG84wim8NRSEEkvk47hy8JrSoTIO9aSI1i9XuOwyj9njFpiwncaJc?=
 =?us-ascii?Q?OcLF0Yo8shZqPIpwZHlVl+i6nkZfpTImQtAxhih008euS3+gxTZtT59gJIwS?=
 =?us-ascii?Q?Cse8jkKAHg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ae5972-2c5b-41b4-6546-08de846b6b3f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:23.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikuzpwneAqn6P7sktAeVL7XX+sBB27fzSTrK6QlG7gbFjx7Pw0W551lq+LPn7geOZz5EEYKnywFxlHR7kEV04w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

The bypass flush decision logic is duplicated in rcu_nocb_try_bypass()
and nocb_gp_wait() with similar conditions.

This commit therefore extracts the functionality into a common helper
function nocb_bypass_needs_flush() improving the code readability.

A flush_faster parameter is added to controlling the flushing thresholds
and timeouts. This design was in the original commit d1b222c6be1f
("rcu/nocb: Add bypass callback queueing") to avoid having the GP
kthread aggressively flush the bypass queue.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 51 ++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index d5e4d23090e8..1047b30cd46b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -378,6 +378,38 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
 }
 
+/*
+ * Determine if the bypass queue needs to be flushed based on time and size.
+ * For lazy-only bypass queues, use the lazy flush timeout; otherwise flush
+ * based on jiffy advancement. The flush_faster controls flush aggressiveness.
+ */
+static bool nocb_bypass_needs_flush(struct rcu_data *rdp, long bypass_ncbs,
+				    long lazy_ncbs, unsigned long j,
+				    bool flush_faster)
+{
+	bool bypass_is_lazy;
+	unsigned long bypass_first;
+	unsigned long flush_timeout;
+	long qhimark_thresh;
+
+	if (!bypass_ncbs)
+		return false;
+
+	qhimark_thresh = flush_faster ? qhimark : 2 * qhimark;
+	if (bypass_ncbs >= qhimark_thresh)
+		return true;
+
+	bypass_first = READ_ONCE(rdp->nocb_bypass_first);
+	bypass_is_lazy = (bypass_ncbs == lazy_ncbs);
+
+	if (bypass_is_lazy)
+		flush_timeout = rcu_get_jiffies_lazy_flush();
+	else
+		flush_timeout = flush_faster ? 0 : 1;
+
+	return time_after(j, bypass_first + flush_timeout);
+}
+
 /*
  * See whether it is appropriate to use the ->nocb_bypass list in order
  * to control contention on ->nocb_lock.  A limited number of direct
@@ -404,7 +436,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	unsigned long cur_gp_seq;
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-	bool bypass_is_lazy = (ncbs == READ_ONCE(rdp->lazy_len));
+	long lazy_len = READ_ONCE(rdp->lazy_len);
+	bool bypass_is_lazy = (ncbs == lazy_len);
 
 	lockdep_assert_irqs_disabled();
 
@@ -456,10 +489,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 
 	// If ->nocb_bypass has been used too long or is too full,
 	// flush ->nocb_bypass to ->cblist.
-	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
-	    (ncbs &&  bypass_is_lazy &&
-	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + rcu_get_jiffies_lazy_flush()))) ||
-	    ncbs >= qhimark) {
+	if (nocb_bypass_needs_flush(rdp, ncbs, lazy_len, j, true)) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 
@@ -673,15 +703,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		lazy_ncbs = READ_ONCE(rdp->lazy_len);
 
-		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + rcu_get_jiffies_lazy_flush()) ||
-		     bypass_ncbs > 2 * qhimark)) {
-			flush_bypass = true;
-		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
-		     bypass_ncbs > 2 * qhimark)) {
-			flush_bypass = true;
-		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
+		flush_bypass = nocb_bypass_needs_flush(rdp, bypass_ncbs, lazy_ncbs, j, false);
+		if (!flush_bypass && !bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue; /* No callbacks here, try next. */
 		}
-- 
2.34.1


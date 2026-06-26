Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95C2BEC45;
	Fri, 26 Jun 2026 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434602; cv=fail; b=Q7ZFLapA9TIt/6in1srzTaysnvZ3CLHgKHqW9vsnXPGP+usUxOFU6jDh+NcAEbDlW+YHYlatRT/dZs5hy+dGcuhrXJE4PNqi5YmIXBtlMFL+cqWKlMBlaMZS1uLXRMY7NZb202EJ45zL/XCKNjAl1D/+VDzbgV0TvJzX6kAcP1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434602; c=relaxed/simple;
	bh=iMhheCaqZd+D9i21LpQB9z7cqlxuarlpSpEWG7CiUEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H5q3pEoodMCZgplcpTD/Nfw5MTdVHHWvaqqbq1Jz7jZTmfPksnOPWu70MUOG2sgtv+X7iF1iw/uuYFHJU75lvaW3eWDdmpx6S831ethckNQrXcP7CewteoSvyxosQ2nE/f7mAYq2fKIW1re+pzBYZ1B0s6f8nexF0GIF4hdWRm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aeFi4szR; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aeFi4szR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zN32/U4BKgMqtP/IehIuq960Y4G82U2veWAReOb0aki5UkBDojX7sQqv4R5xfoc7q34Hg3BVUZYcmdOB7CkmQ8DLqCo10KolriVfNC/0A+sS9yj08TLtciyDmqzugC7PpGrv4IMSWJCq0/3v9rlSN0GH7fLqhFpDd/pSWY/KuLPbeN+27sCJnuulvygKSm2GvuljC6hxFHQags7VfFYy+i1pRhXiegWX8IXe131vd8uchdd2J8Vuc0UekvyLZIVlLqd92KO4uUQlmDKBpun3btwbQRBU1SBxb0NsoaKCncrS0iEmGV1zHJTYbSalcg8spHXJInc/zJrMskXEhjqIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOeWpqwXS1favuSU+xfNK3XlmxZXJAT1V7BEfBhxgi0=;
 b=n5jT7FosQ+8pQVWQxTmRK/DCltlbCPom+nei9r18+CyJiY5qmtLcXIiNzQG1QJZCTSXLtG2uVa9+UCqD1wSbnpVKuepklfy+P11Fbmtc1wn+H45FjC7eUwVQdtDCv2E3fIDe3NyEjSoFvRtonCQpUQCf4Spw6FujKFVEao5bj9CVzssPWDAiVzcm6DcjdGBMJDJvFPXAKI2zXuavfFkXO4cjIrtZgSZpKBiIGUvbBHXL4zLhqQ7rquTavzheF5yyZZxqR32TrzGMM12djP/odHO21wJ4pyqEFjOYuWHMio3Tnt9+ZExSqdmiIKSrNEhfrBHYvcAGri4NcNw0Te/07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOeWpqwXS1favuSU+xfNK3XlmxZXJAT1V7BEfBhxgi0=;
 b=aeFi4szRDioaZNzQp74t9uS4OgFeRSX21AEX0aMhgqSoUolqpcpKCYUkoMNSwCxvJ7F9PBVxjgcwNeDu/mVfB6RYHNSNRGFHsBD/HqIOJ6RFn7eSEZTmmtavF3NIN346K0tS1x8xfKqmMj8dnMc+tUjy8geKGg5Tt7P2tyNOfpesh5KCwcyUF/onGpI84DpnFrmmYArlcDSNos4hFhxDRVYMFxRAuwVzip09F+fBg2c302BKTLkIy3PmprrFJke39Q95GcE4nhHxacL0p7kpAUQGIo3RbXdwjxI70r7E2VoCXDhoqnkZLx3xR3ta18NSYmhb8RDfptTVwrfQZlelVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Fri, 26 Jun 2026 00:43:11 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 00:43:11 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v4 3/8] rcu: clear defer_qs_pending in handler for compounded sections
Date: Thu, 25 Jun 2026 20:42:56 -0400
Message-Id: <20260626004301.1632168-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626004301.1632168-1-joelagnelf@nvidia.com>
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::10) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b3dd83-fad1-4f0d-94c8-08ded31be580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rqUHEQKqAI8NJzSzU1RWvnYwVQw61pMN/JZ/kWPczAyNND8lDS2Ru2w36NV3bUrB3WyK+E3rh+doAQ5QGjRx7nsQg3n2ZUbBKuDLZXiMLFctCtVsT/3oZxF0lPMsYkEGgPt47f4qg9raC0rTs0Mq63obhYGCf7rQdzCrgxqDVbmaaM4KY40OkMWnQO8L1U6hcN1Uy9MsMuObaXsGV5MJi2g3+lTxwzaVx+SgGFEibsdlLWaEiVe+NIiYrMgveLiUNpRgwKZbe1KoIW6PKej9nzYCrb3G54l8QqSSO5lGtGBr0ZbBYhIG+REy8lQoeuVsXa83/dbkjrzt4jrf/nwzPeHse3glJVmKedNKNY+YXn6bzs6RZD2Ul28gb98jL7qpfq7wUJEc01OF4EYgy4LeYQK2TcWom88CcsuiJ+8Hs/O6ic8B6FyowGaiYZ3ApqOaqvUjLaCzmNzGNJ69xD0FIHoofWzPxi1mFIunSmld0hKsXjiQ17fBaxaynm2UmAKxrd2D1ARrwFLQTWwoVwEvY9fgdpOA5jII7KJEdQT3uF9S3Mjfn7APhb56q4+CJ+YdC/sPQArefDh7QZA4litaT78pi+qP8vIqkdA9HgmZLqcZii5qg3U09y5XPcYHbHH23i6PFKEdK4bw1dyBIc7hvjerO/Y5qyWGZlHwy3Gikks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vo7mS75hotm4CGVdPabCf8Efmlzygdom+liX58OXL0GN+iUvz0U+Vby363Tw?=
 =?us-ascii?Q?wjjF78zO70XKWsVaWl4wbVCVEgPNHBQf8KBa0qrn0g6ruPLGdeTwvrid0T4R?=
 =?us-ascii?Q?wkKkDW49hBCi+vrfkZp/0AhsDivct9eK0y+F+IGMRx6EpsyuMwUHFmpZ2Wjx?=
 =?us-ascii?Q?0oqAmKPsLwxjE86q57MN6UNIuw9JeK8TnG/F/DK2Bn9xUJ9YqsqlRb5OAam5?=
 =?us-ascii?Q?8M4V2iHjzqnH2ceZFCiBMq39LF+N+Vz2XGnEHb/tuUwh5QiTeOVMUmYzT2Ak?=
 =?us-ascii?Q?r99L3EVqKRjiei0fdgxSfSraeSWtgPgfdkELp8fUTmtxiY7kYrYMoNMVobl7?=
 =?us-ascii?Q?yX+qR2QGpdXsQXXKeCR/BQLz3cW9sGodKB6qATRcW/YLTviHMPYg6pWjN8yy?=
 =?us-ascii?Q?6NsU3O9tQ/wNK9O8oXRwfENjcOQr6d4r29yGQ/JMX8Mia+kWGnhPYn64AH80?=
 =?us-ascii?Q?koICsEGkScOOY7GpNO227nPHXtYYSkWAZnUYsMnXBdKAku8vQ8OKE359q5g6?=
 =?us-ascii?Q?0cjO0Q9uAZ+DVck3m7VgirqdTuT4fV7mHR11AJ0nBY+Mt9kRSPPupMzPU3vY?=
 =?us-ascii?Q?xhak0UyG8iXPaTZVJG32cVwgfD4hJq6Apeyt5zsybxwIsSYRgYswFjtIOMAn?=
 =?us-ascii?Q?mO3v4g0JjvtXB9fDb9x2AxXEB4CXF0ewh2kPGx2F62ppJFrbEpeF9P0lgovY?=
 =?us-ascii?Q?m7NjeoyYFxo2g1PdKZ8UdpOyc/CfPc+0IaIBTSpMPHs5jZRM8VgqcaB86PO3?=
 =?us-ascii?Q?pBFIFD5F7+vw38Gc39FlmUYpye1erDfRKR4lNxef0pIVrrLgekDwjaRnG8Uh?=
 =?us-ascii?Q?e4/TEWiyCclW54lrKBSH0C/kP6rrvGdWJUOW9rLLTfZtIOfltnsgoxcpYOrH?=
 =?us-ascii?Q?FRP0IHWCoWJkswTl3cBJ72sY/yWVOE0dee747KBkyZffTv1K9Bl3duSe5vF+?=
 =?us-ascii?Q?FJikmSC/qxvZxgKgU5nIGYBem4/S6mntlGwtPUkVqOqWsw2NSFX3DASTwyJu?=
 =?us-ascii?Q?a4a9QdpwyeW22DVuelAEOyDqkRgknxvrQFEbt8l2OT36qyrB+wHBUB2XCwNC?=
 =?us-ascii?Q?88R9xsp3LJuzW/Bo60imZ3aBoKRGs93rJv5GONOrAAtMXs7KumRHaGMpv3YF?=
 =?us-ascii?Q?U7oMLD20YCeZfQSyLcNz/XJelOjKCbj+IQfVGNSWNptKnLMCEVBUL1hL02Qh?=
 =?us-ascii?Q?nPywjP2EjyZvoWDhWMFaMHZW8txbZAD+gfYSHsvyHI4X0WYwZluwQE+fn2FK?=
 =?us-ascii?Q?kElM8UEMrpC/0qtZaeYpsVfmnQOXLYxMS1a02hgPk+Ss4XsHs2YIBRYmI7UG?=
 =?us-ascii?Q?CzQk1ySfsRvQVI2GmjgOpUXY6gWTU2IgoLbo54t1ZZVy1IQTu1FYHOkmdi6R?=
 =?us-ascii?Q?pxPrSXgwCGdGJ1bjcqIxMCrgX/TLOgRI1xXmOb3yL7S5NkFmFzhmQTFowd9L?=
 =?us-ascii?Q?H9hxusIsTPHR+ypQt54pwkpddr8RqQf9lfXmriM9bkaUVPA2+iqEoeDf9s6o?=
 =?us-ascii?Q?yXO1Ixq4sbmbLDqaWGKskqVNaYRHcKmxAFmfuOyG4dJFqNegWiZ78xYiXTqi?=
 =?us-ascii?Q?QQZ9Bx2LSE8O8n121qlejwkLhEuJQXRKLg9NGT4sLskm4PaW2VHA+TYfftMs?=
 =?us-ascii?Q?8/aPCJBvBKPMMsoicM/XXluMYvnag428ZtJrIIbR+UdSHlsVrgIuHlDTyX88?=
 =?us-ascii?Q?niQr/cYd3rd8z5hmb8bzDN0dpamw0RJie/SluE9Da92VcV0QZ1sjNITHIiIo?=
 =?us-ascii?Q?jgAYlw37Wg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b3dd83-fad1-4f0d-94c8-08ded31be580
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 00:43:10.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6yZWS8/U3GyV6mafSCV2BAfqdPOiicOsucbn8cTvVtBVV+XK1D5+q81V9ycRWmAvitFgd+x0M3MU6e6mr7PBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

The deferred-QS irq-work handler previously cleared defer_qs_pending
only when the handler ran inside an active rcu_read_lock() critical
section (rcu_preempt_depth() > 0).  Paul McKenney pointed out a common
multi-segment compound pattern where the handler fires between
segments and segment N+1's arming attempt is silently suppressed by
the rcu_read_unlock_special() pending-gate:

    rcu_read_lock();           // segment 1 starts
    // may be preempted/boosted here
    local_irq_disable();
    rcu_read_unlock();          // segment 1 ends; arms defer_qs_pending
    preempt_disable();
    local_irq_enable();         // handler MAY fire here: depth==0, but
                                // but preempt is disabled, so it cant
                                // nudge.

    rcu_read_lock();            // segment 2 starts
    preempt_enable();
    local_irq_disable();
    rcu_read_unlock();     // arming attempt suppressed incorrectly -- (1)
    local_irq_enable();

Waiting for the next __note_gp_changes() clear is too slow for the
compound case, we need the deferred QS report sooner.

Therefore, make the irq_work handler clear defer_qs_pending whenever
rcu_in_compounded_section() is true so that (1) can do the arming.

In addition, introduce rcu_preempt_deferred_qs_try_report(), a small
helper that reports the deferred QS (and releases any RCU priority
boost) directly, but only from a clean, non-reader/compound context.
When the handler lands in such a clean context it now reports the QS
directly instead of merely nudging the scheduler: this makes the
irq_work robust under preempt=none / voluntary, where a
set_need_resched() nudge would not enter __schedule() at IRQ exit and
the QS would otherwise wait for the next tick.  When still compounded,
the handler falls back to clearing defer_qs_pending as before.  The
bounded-delay rescue hrtimer added in a later patch reuses this same
helper.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 46 ++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7555022bf38a..7768a40677a4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -702,7 +702,32 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 }
 
 /*
- * Minimal handler to give the scheduler a chance to re-evaluate.
+ * Report a deferred quiescent state but only from a safe context.
+ *
+ * Both callers (the irq_work handler and the bounded-delay rescue hrtimer)
+ * run in hardirq context, so preempt_count() always has the HARDIRQ bit set;
+ * the compound-section check below deliberately inspects only the
+ * PREEMPT_MASK | SOFTIRQ_MASK bits, which reflect the INTERRUPTED caller's
+ * state, not ours.
+ */
+static bool rcu_preempt_deferred_qs_try_report(struct task_struct *t)
+{
+	unsigned long flags;
+
+	if (rcu_preempt_depth() > 0 ||
+	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))
+		return false;
+
+	if (rcu_preempt_need_deferred_qs(t)) {
+		local_irq_save(flags);
+		rcu_preempt_deferred_qs_irqrestore(t, flags);
+	}
+	return true;
+}
+
+/*
+ * Minimal handler to give the scheduler a chance to re-evaluate, and to
+ * report the deferred QS directly when the handler lands in a clean context.
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
@@ -712,19 +737,14 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
 
 	/*
-	 * If the IRQ work handler happens to run in the middle of RCU read-side
-	 * critical section, it could be ineffective in getting the scheduler's
-	 * attention to report a deferred quiescent state (the whole point of the
-	 * IRQ work). For this reason, requeue the IRQ work.
-	 *
-	 * Basically, we want to avoid following situation:
-	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
-	 * 2. CPU enters new rcu_read_lock()
-	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
-	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
-	 * 5. Deferred QS reporting does not happen.
+	 * If the handler fired in a clean context, report the deferred QS
+	 * directly.  This makes the irq_work robust under preempt=none /
+	 * voluntary, where the set_need_resched() nudge would not enter
+	 * __schedule() at IRQ exit.  Otherwise we are still inside a reader /
+	 * compound section: just clear defer_qs_pending so the next
+	 * rcu_read_unlock() can rearm.
 	 */
-	if (rcu_preempt_depth() > 0)
+	if (!rcu_preempt_deferred_qs_try_report(current))
 		rcu_defer_qs_clear(rdp);
 }
 
-- 
2.34.1


Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9F3DFC92;
	Thu, 18 Jun 2026 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808698; cv=fail; b=dOHVZoTIvY99YjtFYE6l3dw/tuCsS0D0xbOKe6eBrtPNPSPXVQLkkxed7gzrTegSjWy3hnHOiL6dKtkNPT8U1UvoX9BkS/TII7/Qhr3gl1OlfaUTWOgOXAgt0M2NrxrwVv6+KfMVuZFhTRDTjioftOOjNjNZNCLIABIcTeeMZ7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808698; c=relaxed/simple;
	bh=lYjVxYIahHTUqooR1UEDCIWgJ688/uDMM9omQu6aZ98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r+6ejkDkutg9HqXA3HDFO4FJjOrC3JGaDOD6za5p3Jm/m9qKpreQ5hJz9TI+vcKWXVH+Y+kqTMToakP+qBwPlHJVAvbFYqFVJhtnZWp35hrd2HSWa/t/NkztQnUrd0uCHMQyKMOh/2epc3CpnIJXVJ8ZTI6nA9YUfEATHeN5P+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDLkVU5B; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDLkVU5B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbWhMoyzQGJ6c72Qd8GlvDlHX9fbnjBaG9nry3WZgVcP7rk7pi5Ka22zgwfmDdqSqcg+nZUXfKoOcmGnZPXLNqv/ZQw+td2ZBswJ133JtNtlJBHToS4oLCDNJ6g4ti8f9eevig8og8DwlsqMKhkSgsFATe+OFBt8CRPVm5vnT/px5sMYIyQ21POYrUvNoDJ+fqAN+YD1jl6cGhtqUKJu3mi0drvuYBmkH0yNWUcLPJvq2+RLNrpLTT2SB8+GEW/MDT5xqbxBuOM9/mc7IZRi8wXaUd3/MURWzPKIa93JigNFW1axp8LaKAvhvFAVkOPh/EqjylCPbsqBejO5GQO4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvNJnyvkEY6K8b0i4OwloqIjSuUPMOakwNnpRlI3qns=;
 b=OPoEFLvymCLiVUtsn1U/k0PC0jZeZyFyljZLZg4FV6jhe/OQudXvEbmLGwCMQ5IPJrmzah1t8Zs3245Pg3ur+C8dcygIGXtQd+rON54Vu1vlt3mJKBb5d29Zo6PiBTjJoC2MLg9T2kJQcGkSAnbUXWkhayBS7MavXbcrTXe8TvJ4up/MqKRX+qVkgHonqw4xar5IW2SSps0Q5Y+CAA2zQtf5UwpPUaetObJkk+Xjx2pFWtrHZ0jFkRAqcRWZCV7cIYzVI8T1uJ7Fd8lWklAAFo6WAOdzzAneM0UVujNFVS+M73OlKIl3t44joqv/AccyK22hT7C52durtCOxiCnz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvNJnyvkEY6K8b0i4OwloqIjSuUPMOakwNnpRlI3qns=;
 b=ZDLkVU5BeYjSKshUZcEPRai6+xqJvUzWHt27coEfQajNp9XzzVUlJSbwobpInzRLoXW4vgttk5WNJofLE3SMYjRnIq5bO7bgLH/V4iI2X15VNYd7qhYtUr0/zpngscBPYwa+aLTwbLTYH1qf4QS8WhRaG3dAnozUYEI5jwRih7TdALvaPwc3BS2Lav1pzd31lTQamQVjYLG/trzfaESv1Uo6hLU2FReMd7mfIAz3HkTHiRQ0URBDwOXXsFII1pAPaIO4gwd+iln2XQm17cSU/NY6S59b2RfJdhi/DZ3ra/aSam5O0DJXdgFiBIS0G+pCQzCTlR1eezuhEZ3m7g19vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:24 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:24 +0000
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
	Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH v3 07/14] rcu: clear defer_qs_pending in deferred-QS bail when nesting > 0
Date: Thu, 18 Jun 2026 14:50:23 -0400
Message-Id: <20260618185030.376450-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:52f::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb63984-57d3-489d-da76-08decd6a97be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BJSsT0jnqBtDbAEx7B1kvhD5I4cSeVSXA5BnoAwvcHcuuF/VqI6gx+1gIdKLrot+3VyaZlh5JMUI9AtGQNLC7rSLflB5EICcaJbsrtnp45nN8122fs+lXY1I6OBvrCHfhgmB54AJjfjUMgObbuM9kArFDka4G6RtAQFK/zJGvb28Qfi5zMpv4S/gzsN/mycMnI3mgg+rjPFVPA1XYKaMqH7ZMIas4hw2k9aD83Ey3dH4fc4qIMZqakJjUWg4VQsGIifWOwszNu1R9684jLCIe8koLBe4p+ZgFp+SiSiZ56+25OdI9YNTurZFRJVVQ0XZc/N7J4+7vl3w5BXyym0W9qtADkKz9jiaBtyui4jdfh2ORFRJhl+6/V8sqwE8SfbNa3jD1JiUxlgNSUiDJ7QpTc4CSXldJpT7ZK7Pce1DNHb56nswugb5mAm9sCGv1ClEsUjJet+D2UIhF3IOYzUXFQWVm+eEoevLGviYNQe36/Cc0jklfHVh2LZwwA3PtKXI/26zOtTU+pqKzuF98uhnOnVhCW64hpu4v8Mk7bUPK4nCFiFfvaIgfkyLqNI9s3sMtHmQJiDIqtK9UaR7v2+Zv6p85tEjnl3GIcM/Gg1aug/F3h/7R83bcs9KSXk72o+BJCHd08pOEqOcDLGQeiibeTaRb1hFml6J6BJvyyd79BKHZWRZfAWSRlCjGOMNBAo8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBEMe7Gf0bAe0cqltlJJ5T8PP2vaje5bdSz0OsCtLRwzYTw2AVzBq4HuR7uu?=
 =?us-ascii?Q?ZSTZRuBjBsrbITJoKx/JtW7e4KMM/xxqupmXYsF+0Rh698a1AhQ8qpBzJA0h?=
 =?us-ascii?Q?rnvJVLRpoBYu59cPHxdFixqzFVSAAdXQRAo9KAuYwXNkEpFUcjPeNaA7LrgX?=
 =?us-ascii?Q?lv0ytZbS3QKxw/AFKupHLN7+j9iNQc45FmNBAXBuaViIOL66M5Zt2JX4la0/?=
 =?us-ascii?Q?gns35hnFkl8LCAbQNgQQMeL3yZ32hOqAeijZqGfs7oYbTdrPzB19ljH4FhWF?=
 =?us-ascii?Q?W5aWA05P8GA/nlwLdTMcvtYLp0wIjVLb6p7DP8OoWhATkuc/DK4xi6SdGD37?=
 =?us-ascii?Q?UxsmFU3ziOW4Y3pwdMZh1PfbGT0ZCF+miYSdPqcGvmmeDmApmpCH0TjDGlw5?=
 =?us-ascii?Q?8vgyZfxjHRP2hx7UbNwt10DGUhi06fWQM3h1t33imgVX1YV2h2O4yLW7ct/1?=
 =?us-ascii?Q?lnAYTcSD0vgDJR+iwf/smwlagi5XxdTwRI9FPxBqoag7jSzqkvnIVUpqhImf?=
 =?us-ascii?Q?95tv3HdMhMalwC8K4BM31yt8lj+XuZ62mVkQ/boEITfj9X44lN1HwG8LCg0K?=
 =?us-ascii?Q?o31tl4Ff/4bSjVwq+3mVu+grhtcQVPw34NVtW8wI74v7k+qia+Pjt50qfdSQ?=
 =?us-ascii?Q?czjxWvaeUNojX16EVKW0SjiAmIVHv0oGb8EkrmbT33Vu40Tkik94eSCcu2oB?=
 =?us-ascii?Q?dB3R1wxHLcAq2EyBwWd8djWaZF/9YM8Nh9+nzGVhyVJC8nIBitdX9OjK2PXG?=
 =?us-ascii?Q?wM6wSDTidsMAyki+7Y5B+gKU/5dBSTvFfsp6dyl0V69n6Kkc/MVMDLygHiLY?=
 =?us-ascii?Q?E+jU6B4iu9XF+zxHxhUdYubTKEdVSCXCXE7cYCbb3Yw2R1B9/7UkoRaNEfuR?=
 =?us-ascii?Q?LNSQQpmkSwQvt4Wpf0hAL5O9TcSR/KHSTn2Ie16xLo/3x2PxHJsvgV1Ce2Sc?=
 =?us-ascii?Q?B0VMxNOBRC5s3+8Ich4lwPvocyz8BfX632xVAuNoE+iogtJrUudu/J0/TfN6?=
 =?us-ascii?Q?k0FpXlTHG+zvg8OHpSwKd5GlK3UcF8dNqeiOLjhjyBs1P4TaiJjUngl49jYC?=
 =?us-ascii?Q?D6oRHlss/DWT6KkWpuixfmJMrn8AqZDiG76/TpljyIHh8HFTg04m53ApLSNd?=
 =?us-ascii?Q?9gF5rSpoXLbkb0cC5Po1saLWoWn8xCIkFDM9LebWazBtOX7CYupu8+gbX6u0?=
 =?us-ascii?Q?mN6fAXkX3PvOQNb0MM4mLhT6Pe0vG7+z5eXTNuo6b9YH4KGlHmHB2q4CUG4B?=
 =?us-ascii?Q?sjbz7mgiO1LBA2QYbKO0VVdOVuSnLSR2uaEvM9pWguc0HnpBSqL1Ep/YN1Rx?=
 =?us-ascii?Q?JZkf4eKR+Wde61w6OadZYr/x9dd5uS+b8E3s2BiExksiXzXu+vck1/mE83Gt?=
 =?us-ascii?Q?blnCw3FtqNvi9HlZ8gERZZOFabFrCycQBx4qWuY9MD4ep29/3+k3XatXp7m3?=
 =?us-ascii?Q?A87WQXNf35o6yZzhK7yyfxDswi02xSYlDhwZJU0wGrtDRAfTYQNGPUJhPjce?=
 =?us-ascii?Q?l2AIvQiWeFq3gssE6fPtwvYz/TggMHpiUblNA4LnfcpbrRHteLTfEHREsYhC?=
 =?us-ascii?Q?eO9WOcJn9ZKG1Fn3znybZfXLeqlIEK7uuLMzjBJ7GevypiSeXPoTMqHClcce?=
 =?us-ascii?Q?7ZyTma7q2hycBjOEBDcgYn2t061r7gZ+PwzOX8xy+5Kb+gVRayA4RVm54HM4?=
 =?us-ascii?Q?MfDfSfo+t7YUk8cCyX2Lu3xSCMbIh5Jqpuwri+GpCvsYCpegftrPe8qCBmMQ?=
 =?us-ascii?Q?Y23XZo0RdA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb63984-57d3-489d-da76-08decd6a97be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:23.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NICwMYkUnf+tHqjHQxpEHgPOWzLVnxFOLk9LgpDeBNakJvD+MnbWV9NaBS6QO4oVEBN6Iw4In694kekJuUgy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

Paul McKenney noted that a softirq (or irq_work) handler arming for a
deferred QS can fire and find rcu_preempt_depth() > 0 -- the task is
still inside its outer reader, so rcu_preempt_need_deferred_qs() bails
without reporting the QS.  At that point the queued mechanism has been
consumed but ->defer_qs_pending stays in DEFER_QS_PENDING.

In the meantime, the only remaining path back to a quiescent state on
this CPU may be a local_irq_disable()/_enable() pair that does not
call preempt_check_resched() (it is just `sti`/`cli`).  patch 6's
unconditional set_need_resched_current() makes need_resched true, but
without an irq_work being raised the next outer rcu_read_unlock_special()
hits the P-gate at the arming code:

    if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
        rdp->defer_qs_pending = DEFER_QS_PENDING;
        irq_work_queue_on(...);                 // <-- skipped
    }

so no irq_work is queued for the hardirq-exit preempt_schedule_irq()
path either.  The deferred QS now waits until the next timer tick (or
similar preempt-safe boundary), needlessly extending expedited grace
period latency.

Clear ->defer_qs_pending in the bail-out path of rcu_preempt_deferred_qs()
when rcu_preempt_depth() > 0.  The recursion guard semantics introduced
by commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ
work").

The clear is also safe against fresh recursion at this exact program
point: rcu_preempt_depth() > 0 guarantees we are still inside an outer
reader, so any inner rcu_read_unlock() from tracing infrastructure
brings nesting back to outer (>0), never to 0.  The slow path of
rcu_read_unlock_special() is structurally unreachable under that
condition, so no recursive raise_softirq_irqoff()/irq_work_queue_on()
can be triggered by the clear. Essentially, the mechanism will work to
prevent the following recursion which Xiongfeng had previously reported:

irq_exit() -> __irq_exit_rcu()
  -> tick_irq_exit() -> tick_nohz_irq_exit() -> tick_nohz_stop_sched_tick()
    -> trace_tick_stop()                    // BPF prog hooked here
      -> rcu_read_unlock_special()
        -> irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu)   // self-IPI re-enters irq_exit

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7045f0deee17..960a45631098 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -612,9 +612,35 @@ static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
+	struct rcu_data *rdp;
 
-	if (!rcu_preempt_need_deferred_qs(t))
+	if (!rcu_preempt_need_deferred_qs(t)) {
+		/*
+		 * If we got here from a softirq/irq_work that fired while
+		 * rcu_preempt_depth() > 0, the deferred-QS mechanism has been
+		 * consumed without doing any work: rcu_preempt_need_deferred_qs()
+		 * just returned false because the task is still in a reader, so
+		 * the actual QS report has to wait for the next
+		 * rcu_read_unlock().
+		 *
+		 * Clear ->defer_qs_pending here so the next outer
+		 * rcu_read_unlock_special() can re-arm a fresh mechanism (in
+		 * particular the irq_work path, which the local_irq_enable()
+		 * recovery boundary cannot itself reschedule from).
+		 *
+		 * Recursion safety: rcu_preempt_depth() > 0 means we are inside
+		 * an outer reader, so any inner rcu_read_unlock() reached via
+		 * tracing (bpf programs attached to trace points) brings
+		 * nesting to outer (> 0), never to 0, so no recursive
+		 * raise_softirq_irqoff()/irq_work_queue_on() can be triggered
+		 * by this clear.
+		 */
+		if (rcu_preempt_depth() > 0) {
+			rdp = this_cpu_ptr(&rcu_data);
+			rcu_defer_qs_clear(rdp);
+		}
 		return;
+	}
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
-- 
2.34.1


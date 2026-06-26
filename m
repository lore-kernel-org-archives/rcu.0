Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52C2848A8;
	Fri, 26 Jun 2026 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434615; cv=fail; b=KxSCwFa6P3oO6ezxSxQzYl2L8JLxTzuE8Fn6j+XkmE3Yk9XNMY6dLGNdS2NbL6PM4XJzslByBkaJ8Ha9LU7e/Q5HZleh7+gq1xE+i2t/95Mtcd2/edEdu0jRyLofRKAl4GAFK08DaWWJEDgZRovpDlkEUmD5w2qu3H90GfGV3Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434615; c=relaxed/simple;
	bh=4zz0m0l/zpLJuhph1L8DKf5UxYebdqoXdp5M0Im4414=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LOYi+rx3AATNrK78jhN+QJlu5wtSRwO4lbZdBZ8CS7GFxHtLREegws2H5bpTjmbDZNhwDTUaItijj+KyDvDw7CZ/erh6c/mPvtQ/X/92b3Ss+QvW8fUeoGBHiAWH4kehiHWH5Hwih1JNsoronDluu13axwzWFXOKiH6Luh2e+lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fjx6To5r; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fjx6To5r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNeeGmJK0tDKCg814/lKNz/jTgUGROcPdS6iSqmxSkn260qyi/14/nulmYMtCsmTE6m2SeopJObAlfpORySZhaevnYkB0n9mLBk43kBXVZ4+NBgLB8CebFNur4qDhAKUI/X+cqp3CLGNCVdsiNLWjaeuyZrCnYDnnQZvzRJ/lwG6Hwbgc+R3uoJAP7y+Uew9joiu30VpoyWyllbTL7BAFwragM2aooWOcijBNi2Q91FZbAKG7DrFSn47FFbJD9f8U3x3ucAvhoL762VFkhgCEBfRCcZUZ0umX9AE8KR7KYIh9GO8GWej5ilPTEBmay9Pk3pOABSsi4wfvwHrmXDL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBWdInBqJL65An4xqlvLCURU1O8eJPscO7QTMg2H5S0=;
 b=fjoAJZSiglLZ19j9U6dt8PuA//POqKplKzN1pV0DYl3XdPtZXdiDBaU7j9//GB4QuKa9HiCzcl+S1TBR4WdicmTB6VdGP/9C5iNJt0uqQlcjKByYtPVacTywJAB5mW2ePvLgxd6wDIGt0FltYwfgp8jRSGuGPDI4U1D7MDS2qfHjVnYBO1by6o9z1fT9h7h35B6ZID3EhUNLnfO3dzCEsHQ1QScRmXk27cvmZXhLNmrvVH/a0nyUb7oPx+33kdsrLzsfraa3gxgE6Rwo2mkiIPTsN2P4e6NzkpB8VKaqY/FRx9xfSrMbHQdYbtUs+i9JeBqbYl1QZtMv9USdvh4DaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBWdInBqJL65An4xqlvLCURU1O8eJPscO7QTMg2H5S0=;
 b=Fjx6To5rKE81aCfoC2Z7xlC8ZC6TwVFfT9HRnXJE5IXkfg9COJSKKYzQmWZe+Mi18Qwoqd4u3wRqroj6QnFPm7jgMUY7VGLY8WGb+bLJEIOGSerfRsPjdAxEAhvudA/Dvk4CSFumm+Pn0XL+fE/ciTfXFjrQBjnxSF7BN6WY//esmnJEkTNLSl4V0B0dYLhAnQ/JerXRXrOEBTadz1AViCAqp//dWsNx59UbWU9sc7kkoGlRWBF7Iez9ERgR+QTVsJS75nTCXhhTJ4EA7QcbtmWkHWDLnP0GSyDtfM1HpEp4qoi3XEUVwzSfz/RB/9OK/CCQ+QEsQZJxokdEftA4jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Fri, 26 Jun 2026 00:43:15 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 00:43:15 +0000
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
Subject: [PATCH v4 7/8] rcu: clear defer_qs_pending in deferred-QS bail when nesting > 0
Date: Thu, 25 Jun 2026 20:43:00 -0400
Message-Id: <20260626004301.1632168-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626004301.1632168-1-joelagnelf@nvidia.com>
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:208:32a::24) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 22133265-f6e8-411d-5822-08ded31be8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yXVPgraBwf2LpFrUJgk0LKS+/IBArS4WIoNi3a4DucxP6/Xz6cVOytZV8awXkoR0lrg8+8gAk+qWRi518anV9KBbzFjrtLQUbyTJDlr3WoVTI0D788UJnTs+iqJ6hrCvhqY4kBKgFuj7iFRJ7Uo5qwKhdl5P9C5RVv8wmyRjbi5i53UQmdnEUKD9hY1iuOR5YlxobAslJonvqB6wCtQSAEge3M2XvbqykhrQopme3Lx/wbd6Dpp6Bfxw+sYmfrvl77ls9y55yhUlWa+LBKUTzSrIGEDxuN7+qLSVftui/GPfn8F4vWZfMVaIBIB+56OUznKOZSFVVirPWBY6Tyjc45Y7O4eNK9jiPEU4Nc4bzbSUivGvYJOn7i1CgLjpc4NvLqOEBbxJQeqSPiC0bp/imLdG7KuN77b7smzJCA5CeDI0adtu9eJgiZRA3Vwoo2huDg8ZTH0GGtrGwMgM2YJK15cuPs30H3R7b00Hy42WTmvVKp66SNsDAKHIQRYTh989VV2SQd0JILrfOS89Mg3BdGXJTcI3WKkKdaiFqbnccY55Me8nakFNkX8dht1SAEf1Yzd4NRbKoNOR+HyQLhTcunFRwtrqa51qHyms9Qyx8jWpvgZ4iDkuB89zKoUJt9L1mXyQU/BIUExxMvZIX93V+Fm6tYhwhL+eXSLsHDchDjo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Us1AGtrgbRZ5caM5LHl/q0v0XSIrAjjwreywMobs7BsBBMqG8doQi6Trmrq8?=
 =?us-ascii?Q?uiLbzX8Hd6tipMpxtyliR+F1m4Wmln5BCcpnSEEoatLUl0v0xN/BMUOz3uoK?=
 =?us-ascii?Q?881QtnoejzIVapGmUP8vWDwUN3RNncLF5ZchGLvYJ4WIZj7gpbBShG2TZ762?=
 =?us-ascii?Q?lF5vkMV+t5jxVlgzjF7NDAg536liUjc6iJno0cM8SrWXXr4AtR1JM25efCX8?=
 =?us-ascii?Q?E1eZtfOCWlv6CV/nyRcGDDhm/ad3VLLF2ht0Frb9wm0NMnAlrWL3yqWte07M?=
 =?us-ascii?Q?0BlEh4j4BW9T/66Wu7lwT2gY6YhvlonwS4UleCQ/Q9ApkSPRb/P7eJpKYJuJ?=
 =?us-ascii?Q?vp6k0IheQedOciApbmI4MAjgOyipedV/9Qal4053TnH3F+4BAZZtEUuWYZEW?=
 =?us-ascii?Q?3pDsI7YsskdiAfUfwj0UTvyQfwpDh79ihsXiPVXDVkCyK7uOmbptVz8ZRcet?=
 =?us-ascii?Q?AV1eD5Ust7crfx8w4gP8ECuuDGGuBil72psWPGPF7hvDhtegVrrXkJ27n0uj?=
 =?us-ascii?Q?AVhGIx1DPu+ajOYk08E1d7t6FYrpUMoCW3a+WmgLnWWldLG8c8saN48MCASY?=
 =?us-ascii?Q?Gt0oVr5cIYMQP/8AWLyj5dJzqUQGKK/QCEsikKEEvvUi6IU2NjvX7fvVNpof?=
 =?us-ascii?Q?Gq451a2BCunzaz05tn75XdIn1okomATKI5MAqI2qCGT5TQtWzQGc9Vnr4cd+?=
 =?us-ascii?Q?3Tk9zDyv9J0176HLS0qVfLJa8DzP/LgJqko2uZan+GSuPi23ZqEcgDAH0jjV?=
 =?us-ascii?Q?d6m9I7ZS5xkGzJlGYM0jnyUqPT9MCb7+ybKhh7Ol6+T2qSyIVE1rjtduQ6nc?=
 =?us-ascii?Q?66oGaP5fFPaPPfp1hB5MyxabQDYu0xsHfpS4OtLPU9lbWxjJUmkHviWb8a4Z?=
 =?us-ascii?Q?3ytlLS47x44f5VXc1xXIYz/TbqN9sWQtITSOYKDFeRu1H6hyaIbAmarRaIKs?=
 =?us-ascii?Q?z0xznu6J7zsok7C7RMEKqs2EplwHx61aPi7jmB1kDbsZS7esIVE4vq4Qs0VE?=
 =?us-ascii?Q?nVj8CGjDAyblplXvmcl4MRC48ehXii+Tqd4sUw6Wl4U35+zR6N00Vl1sWnhR?=
 =?us-ascii?Q?5i3fhVLdFbQh81rAo2pLu43oDAU+0wHgqSpK64c3csB/NLaKRqLWYLe5oBtD?=
 =?us-ascii?Q?q33hP4EJd29VYElO1KZ5tM6FIfn2xlibDUKO4vv/yUIrtq1b/IIqiFLJJl51?=
 =?us-ascii?Q?mImo+5Hi6dmkSGwG1MOsCq39GUbwqHxQqMC7SxJlowAq9tP3QYSsTisYVmyA?=
 =?us-ascii?Q?IamIXSMNTc1bDKdclro4tMpSL+vfQXJRGklCCwbO4TATGVqLZuIU/bXMTLHb?=
 =?us-ascii?Q?9QhYw7DtaPCPaI0JNNAkO0Q96dFB8N8VYXnLjoWTVXdR0vMnsTNzWHSBcG1i?=
 =?us-ascii?Q?rwUhhrWC/YEL0rSX2QxmYpDvo3CCAXLWWKBhWBx+9bVAfq0qJBMZsKWaHUJk?=
 =?us-ascii?Q?lHJykC19pDM9A/Yeb7LSkldpNtp81jE2JK7R1fk8JT03UEUfsW7AFW5HOf+2?=
 =?us-ascii?Q?P+YowzA8VZ64vExhVT65viu2lFT8QsdDpaGst6DdkNJF6Bt6ebXFX8jWXxLs?=
 =?us-ascii?Q?I6pPBcYfXyNUPk7BzKrB0cKxvdLytOeR1i7QvGqFJ6xplJm2mblhg9W6CU3O?=
 =?us-ascii?Q?9YR+xETeE6R7t9WYArwC6tZOl8VXX3eNG36zuNWqfCID89VZAVAx1AHjiNBc?=
 =?us-ascii?Q?uEt5qfXMAlqXdFLQepFEl8llhK/cwyC4R/ZCkAaYzZN6gAb7WUlky12lzQ+2?=
 =?us-ascii?Q?LtTjtJqndQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22133265-f6e8-411d-5822-08ded31be8bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 00:43:15.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utVA7yTFUSrJmW3Al4lNObTxi5/lgE0nUqw1z+ZLGlsZ0ptfgymnJwEBf1Fv52vQ3cvkCGAitHdbdfndqREaYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

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
index f58ae29acdef..6f5d31e3f1a3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -692,9 +692,35 @@ static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
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


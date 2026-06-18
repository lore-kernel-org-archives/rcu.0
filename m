Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53D40E8CA;
	Thu, 18 Jun 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808685; cv=fail; b=DEpCMGoBPyLIhTxoAf8iO+rA/RgKY++Bb32XK+MEkCZDnl7h24SGCOWt0z4ahClmdSX5PowSvVYuhpE8jhBVpxwLorOlffSsqpSRkuzgG1p5/7ubj8R/3She6ob8K7WW7Szv3g1MrZynvctmHURBKhjcjifmzOIN2mFoxgqCkaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808685; c=relaxed/simple;
	bh=BBEZH3O1qM2hM4y7WRW0gw24728CaZ794sqD02d4kJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CXs7Nh5imNm6xHsrYE9IMkPBH40htoJMuKXmVo7u7n6D3HXpKB0JfQ8DOuOJMEUvKrP1K5Mtl8hwvMAjn9quOgcQQpS0j+2cC4T1yY3WJtZxHWxNerTROp+DV3fEewyvqKbAaU+hcY9Y7oBRUV6BaZVxv5vBcuIiugHyK51f7nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GlGI2bjk; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GlGI2bjk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrQ325db1IHPSqkDcrqv00DDqWCL52oPr7RTpXuF+c4VlMm2XLyBRTN12FljQOW1zzKEJrLnhxIAIKQ8/XZqMB1hvxEa/RoP7LG/YiCNXqx3D3jTSAhFaNMxEoSSh2U/ksi9W7en1LTOeoVOSHYnAwt1l0j+umy20Mpst1bzI1qM9jPAE2MvRhUvJ53AJLeus5BszdrXDCebZQxxnjaOrnOigZR/spJGru4VhxiCrFf3d/8A8jGG4ab4LV6dFybM5E67dezL09MdAjg8xEFUDSpzzM3YdWB66rRdVW0aSr7HO6sPc/fzzhHMLAo1cWnSb+vOytd6TDSovYRn9PumHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smlFomTC3pzasK2wt1oTzht4FRu+sErJZM2n20Al2JU=;
 b=jjml5iXx7ahAt9ZaL6ZzYgtTeY6mjj6XX/9Qd3iKcdC3a6YPhLx8fHh2jX/iMwBUmEAZOhW/eFkuZL9pgg7FzPDa+spe8wGVa3ChcD51zLHDiMXy9uDdNAdDJksmH0NqxxClJkCLvS263GACmlqwyfYdrD72Ri8kHEDFvwn/2EOxXxDVxEpJmFe+Cfe2uQIkOewehDi+xJLUssHMIR60+K0kzAS56kUaIVgMm459LoVRM2n2n2ho0e55mQjcGD2GwERMqrkH4gaZlSaKR+VD05QFALLkqmzhxqPDddilYc8DzKfixGwfygf/jMNpaW/Ow+R5Z4fWCf8KY8Q0VJjsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smlFomTC3pzasK2wt1oTzht4FRu+sErJZM2n20Al2JU=;
 b=GlGI2bjkwSRHc/Xk04W05igCWvo56NiYz5U91xd7v2H/EdYUEmvgdTIS4gtL8AFsklEbzU7wCqtK5vN/qNuowqwaEM3cF8a/R7rmzOWojGxjLparlWLmGVqwIm5u7Ll4a/WLyRnMHS68K3S54u4uAKLFyw7CiVoQTR2TsSrI4vHVu+yrvjDxuKg2XjShJcpFj3GhxKS0ULKn3GdLNJ/xnkWaPHoDNLJbFDz84KSQzsEa28gMoz4yqAYrIyeam6jzjJKYTl+sBpLg7SBtmUAjpeHnuhRTYpRpA2Wh3OboAWbHWuC6y9z74bxM+BPwfd5Ujqy7PjcgswUVz6IKexBIRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:17 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:16 +0000
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
Subject: [PATCH v3 03/14] rcu: clear defer_qs_pending in handler for compounded sections
Date: Thu, 18 Jun 2026 14:50:19 -0400
Message-Id: <20260618185030.376450-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0344.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b08b881-7da0-4925-f609-08decd6a9343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3DUrlYCAp2o3kDLOISIoc5mbInaqX3+zWQ0hkfowJ8NYytOVcjz4F7I/9fGC4TjRB3Xcc+93wk9agFNMn/yykZa6oTcbFu5bVyX+az4LriclTeJVjkGHmTqM1XOtF8wV9pEfa1V9xOByH8LEQmx8Ioh4rOJJBRgErQx9eyK6YJ/43Ui/GjJF+P3J12A5fMxJeNR+8X5UDRv7kScskuNQA5O7o6AVnBnAtLDGiqQ/AI+w0IksuYMHQHc3LgY1jPdeVnUx/uzS/qRjytcD1UjKARMFydU1ZpLSZUG/up8UmzZ5EicD/HFEC1AqJBK027891XPY90bEeTLluyxXHWYUYevY00Gwl08+rQqcEuAHI3OjBeKy+nhavMw0Wz7YXWB6sL2+j+9GugTWSwFsUbMiFVq5nmhGln8DpDo0vnNIwWXLddExBjq5D6ZPOp7Yk4faV3GXPIXrS0f90QdkOh15v3cyj7wXKX3691EyY0qZ/voclcNdPziLkiG8cz5/ReH5KCVgAbENh3B/IojOY7hMN9VwZ9SuQJrHoHxfAvCodrU0kYBZKJLlQRIaEUIT+Yj8pO7LdxXeLjGEzE8ZX+jaYeGvz0KOeHmx7bipz7s71UcwLy4UvDBJabw9wOecoFFJiYUkYixbqPk3T3k7OCttb3lqEvtKCykBUdt7Zox0N76ZQcTxo7RWe5eOJjofXu7Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GwxEwEtCmf3ZH8gTZWn3V3c4cieSqwz2ouDB8sONvdoCXmOeq6apRmi4JssI?=
 =?us-ascii?Q?K6uyj38IudvPViAU1TfuBRrvoSKwLOGeQ0dOFTIBDJMbUA9qTXHGnBN8TEd1?=
 =?us-ascii?Q?LfGBRwwMzEupZ4WZh+sABuljsNL2hjMdn+jynd082OVymcfNupgEKiJ40iFH?=
 =?us-ascii?Q?6nhO2jtEwg1CJxP5JN1JfJJHCHhCa9hcZdvzTXpb2RSQg5U4ldvROLSbIeAS?=
 =?us-ascii?Q?0BpRR1/yKuwBxDxXyyL53c7bHBtZRzMgH1oUn/euKP/DBSguPo15KBbxCIY+?=
 =?us-ascii?Q?yJ2Irm5CX7r3bHZRFGJSOU+ljRvPG+IfpYzhtPtZ5eIZcPdlgnHIERUdCW92?=
 =?us-ascii?Q?jjTQLXKH0oYM7S/UZT5MiZcM1UgCvVMqUTTu4b+G/P4hG8XO1Lr9D5qKVwYP?=
 =?us-ascii?Q?GyeqbVrm0zPQdHoxJ9kuQ0uDtyNcSLTqT0NcAHSCarVzwaJPn5lNO+nGbWHu?=
 =?us-ascii?Q?bAsCgLvmR/IkgZI63uB/A1bHdDia8S9uRQ6J2t6rTjXoo7kkpxSroWe9DvNQ?=
 =?us-ascii?Q?SMtorfCAEIUWlUmSbdNEvAXwpPTfId4iLzCogBAfXc3MFOE5YQKPAbxJqLmT?=
 =?us-ascii?Q?7wUqH97gC0JqA6ik9LVEzuwXgxLQYqDavpeqrMNTJ4/f5P4UiUbsjHGyH/jA?=
 =?us-ascii?Q?H5hSuYzfa0/JdjshIsx2L6uDsMWOb0KC26LjxNY6jt/T11SBRdJVyIRBu45T?=
 =?us-ascii?Q?NVBQ4r97Ler2j1iFyz+ewunrmxSuRlUk7Z+XbWJZF1t/NFsSnov9M69bZnDC?=
 =?us-ascii?Q?6lmg1vFI6hFadBBBQnXWU+7w/utYMieYTvhM2ZyouKcQTbrncH4/feOGYuZy?=
 =?us-ascii?Q?yDuqrtSJa0wCFxPqd9a66mNUQO8zo9MYMGF+vJhTHHLdrpjxQzPhvtNDRCDy?=
 =?us-ascii?Q?bkWtfG4+zq0h4LtVY5xXspq5RozaGrK+9lQQAS5B60ZXm32HuwP8p3s3TNEW?=
 =?us-ascii?Q?isZTI54h/dVsoIfHL8eQ/N6jbnNSq3GiKUWWkfh7IYmQridBuxYZCaFz7EG+?=
 =?us-ascii?Q?JhZyjNYDvRJ/m0/Bf7lqOccsE7FLlFIagaN6tNoBIM/pnP5frUJ2DuRBjp8w?=
 =?us-ascii?Q?gSpo0TqgoLxezRpl97K2MfYM8slLwn04s3BCGSig8hgz289XPpeSW9h3NZcb?=
 =?us-ascii?Q?NcjvlvGtkFocM6t2/N0woUjucXrJ5t8vqeVs4LXUc96QSRNmh/kR7+EnB+2r?=
 =?us-ascii?Q?o6sHFzkz0Ypf5+mgkOU38rQHDvxks5Iet16K7zXVG+iN/+eF8D7xnhd4ac/l?=
 =?us-ascii?Q?xN1Mhkg/aFenD9z1l4SkGXnkkt78f2Y30FPQunSp6g4sL6WefF1TwU0w5wUx?=
 =?us-ascii?Q?Je8tYgFMXP3a6DWkqCSLE9u8qMGgVFaauChb/IOQzBJ4LzLdHgHSEzdFbBos?=
 =?us-ascii?Q?a1eV9nnRo9REXOQzmtbhaiktpZ04ZU2Fu0c0pluf7R9kxu1JcoVqZNVtZ4EP?=
 =?us-ascii?Q?m4xVrJwP7n/OZGk7vRHnX1cKSNoKPRt68qynLV4Xn3biERIxZF05+AfrMmD8?=
 =?us-ascii?Q?ir1q/QWCMmEfaekLujC+orKiHQelnzV+TfNES98fgqCqk5RCX1GhOAPGumH5?=
 =?us-ascii?Q?tK/ORHU+gkrQz9tBhamyGJ5AYtHDNVaG21af/6Z+hteNKPygU4VeHFQbvduq?=
 =?us-ascii?Q?ijPFdGAlDe1fIXo8deUAZ4t5onjhjymO1izw1ic5+AwUsJc9AWVSBiX6mT0K?=
 =?us-ascii?Q?GsUPAf1DjhYESJb+DlSqL5o0x6ixpTa+7mJixAgi9ROQoMEMj0IDfhF1RHHe?=
 =?us-ascii?Q?cBYWB1ujDg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b08b881-7da0-4925-f609-08decd6a9343
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:15.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqGPnfDSbVKyaV2c+QcrvF9/bU1Owsfgr/UPIAeyzf2yBhrvz4hGWcP6qgQWr0lA1/QjjKhhwk64v2vTFA6KDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

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
index 8637f405cb47..9b167eaf8e0d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -622,7 +622,32 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
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
@@ -632,19 +657,14 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
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


Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CA411666;
	Thu, 18 Jun 2026 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808700; cv=fail; b=Ehh3FranKt8BWg4+ehuipSfV+Ps74haU2xyM4bajo5ncvgdRh4DwDtuUUHUJcMY9VzX4yPP/D7Cshj8r28wRV8+SZNYlPDcNJs4tdDvCSpfJWg2j1QhKoBiPaJ0eo+6PtVFJ9mZTEfyb//0rqQL1qZ7F2oSfYNdg7H6gFE2CS7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808700; c=relaxed/simple;
	bh=JI3s+1vMm4kXN5Im67Ajov7giBg+LkfJZPikI+ElU0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GTpdBJMpFSePb2d9LibP+7DhHMx0NnXuoPAl22U/VvEUR4tHrpgouYMagskY9JBgNNxn4Eu0pOeHi657f6WUjTvRWmL3XEYgciPrkNjaWTkPc8l58cBj0Hgi0JpOsoVMX6hSw7+IoPysIcPBn3vEqv/5zzIt5AYv7YRuz+qgt6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YkfTA5OV; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YkfTA5OV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tigT3vSmGghKlWiIO89aWP9lzPxiy5WAW8l9Xn32yCybYvf7ESQF1V0T5k+NRvW7sWQ1lNfFhkczESg5bXrTfc21Gmr0QV3azglVRDfcY4IkpFaIabecNbXzSKlwEix7xsYn7tMmZ5BG2wmzSQFi8kdHgRyxxnjescnq/RepXbc2e31pykk9Pq8gvREcV+C9ha+I0JsoX31l63pY73XyfEI2CN5UYr8h7+TMQWRibNdpsvsq4pI7bul3zQGPyhCXR3aBFfE1iSAFXpcEfK9x99U9McLHPHgRaZ5GXfFxgAwZLePGepYXrgcI459NeNmXqmzkIhczoLZDSax4ia/HYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oubCPYwIIsAcnJtJJlZd6ViCo3HKToxwNO7gQJdPFVg=;
 b=kpi6Yvx+MAvfNsv1SVqxFQT2FRhGsiP5FIdZiFlacc/udfZTflAhqjMwbuHrYbVGINypTkTZLa6MznQ0AQ19FStFsh4uHW0GSYIEVIF7hsOQ9QBcTczdKIJoFd6PQbUO9rCZD1QyWR1QMpXSKQaTTSyURHpe9U9sf4re2f3eVP+yh7XT3Ad5HurIA8UT8SjfxkZiDuVn+h3BplG8iD23/5iQMEByIhNdAucQHr+7Wx8fLzLDeam3i60QuDfTHXzInhxpsg4A+nDqMItoH85EWQEznk3j6RbQOX1aJBUnUdIVJhJjo5UpnpV9AVpyvgpjDhlJt1165F9q5FrDoBf3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oubCPYwIIsAcnJtJJlZd6ViCo3HKToxwNO7gQJdPFVg=;
 b=YkfTA5OVHrLTBgVYkw/XNwBpiOWWMl2NKJUHnubbcYPnZJsQ1Rr55zYpUumJJ4HT07zDfclFF+kqVRdsmBFl+4sOtbiC/+azch9P+o3QDy4pV0v5FoPTKfHJtZnq0cf1V1D+vQyME4ua9Er3+QpG2hb59hlQpu/LX9/UlvxCtcqku3zUA9RNeKjaPMm7DZvIcgF0ObyeLkcJrFCsW37Wu56rXuJj9DA3/XuuvXsNRZPE+2Q8Ge2jXjtSvMlYrV2sF6HTlm3Roi/VjvhMu3C0rXi9K6+VxJlDUYNxsI1lAvQvFtB80kWN8nT8zsZd8xnQPZYbORipQAy5Y8pyB5UcxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:26 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:26 +0000
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
Subject: [PATCH v3 08/14] rcu: add per-CPU rescue hrtimer for deferred-QS reporting
Date: Thu, 18 Jun 2026 14:50:24 -0400
Message-Id: <20260618185030.376450-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1d6e7e-80b0-4c42-2efb-08decd6a9961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eAZ6mn+ZSwdCjnsfvgj0ZscHZVWDRg6tuKYRGd/Z0FpOTdN+hgrvjZoX5MddGfxjMC1pxISItMrD1NAA4ndV35OBbHGZx3rNxAtZTW10/kzw1Rha62vsEDd2vjHzYqLctYX0Xhlaf9LfWDt2q6rjepkZoLIVe3wFqZceb4ooNhwbjDaPPY4Enf4zncw0gBDbUAQHFBEOvIPkQah+El2hCvP+0Fe24Tv7I8k9+ZVDOVOE/KqESA9InPa2vaAilqojIEy3mzneNM7nburzRZxwYHODbvA33mwnLCukRymXqccSrGgSWK8Vwd99N3BzIorg6F9KDuXcQg06fxXXgwubM6ixAbExS8GKn69aEG3Ssv4Sj9spAZi1GGOGnQS78HSvqRss8FzuJTz/vdmA9jWwro8UCLPyvzC/IgtJoMSKAQAXrATzbQRZ8jg48w/S1ppdlNLwOcG9U37HfdYxV4CuPhFUkren853eqT7j50QbCaTgIbq4sQdWkyH2igHfFbKP4s1sqVaOu4fnCYSqpbZZcGTb4DOh4l5l0/KXDtCe/RqdRrYZQLm+ksA9RZaLxess2cowIRE/lTv/Pry2nJ7rftRVD2wNtP7SMpBS/37uFVt1/wRYxMb0FXAkcENIA169EE6t++Qeh4Bg7YLyxY+g3o5qC74wYX9Ujv/d/oWzbqEDA706z2IQTH/sHp5NeCbq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4jyOkSDf2f8z9fXSx72zvu2FnLFU5tOuQ8Ye+TW+Vc3kwngchIMvYP0u5isH?=
 =?us-ascii?Q?nKQikmc6Ln/8u1tQLzwHjG3CwhxLHu+CwLA43C5O+8JA84p4ry6ajJhxiavl?=
 =?us-ascii?Q?eC/VraVHqBBk15qp2znoUbJmOLKtwlHm4dT9wunLsXV8ETQtzdmM+9TFOwBT?=
 =?us-ascii?Q?vHQqVS22/jc7a0IFfGAMnIx0Bx47htFQTbUkdartj9aP6e46nj+vvimOKAJx?=
 =?us-ascii?Q?ZN+VP5EMERPdN89PnR0OEdPhvE1bgtgCFamF5pqAvOKOlw+WT6Jj0dQ7BbWs?=
 =?us-ascii?Q?I4t+bRs68xEtT4LmZltB5Il+a9m860KAdhO47bGlhXBiCRe1VNCvBNRFFR17?=
 =?us-ascii?Q?gpJP4Ip3Qhphy1FCKM5vSSv0jMkuCVFRSHj1LYWlr0i2d3qebtz45kEsy3AP?=
 =?us-ascii?Q?YJeLJRQ1Q95PS5ESrv2USflJvwL+woosgOd4FNWE4mh3JZt+EVdO8AmkyhJb?=
 =?us-ascii?Q?QgF01taZ34+xll06QxvuuYSmCtjwlA2QyKUX/k1TQeBRCtxp06uKKQWoH7g4?=
 =?us-ascii?Q?SrnPzYeKXRpi/se+u0A5r2NXfMqAEEqF+ErWiKPTOFN0bbTJ2wmd1XK7HumG?=
 =?us-ascii?Q?7UjK1ZZZh4bCmraz8oDxsnztMfq5D8t5iFrt52nXeP0zGGXqE8I08KW5GIcz?=
 =?us-ascii?Q?I8EByXESfi9d88jrmBP1HepT6cF0unyD+k5WJUgwpdB+0dqJAxShw6kIiZHq?=
 =?us-ascii?Q?XuJ0bjDCuROBBYArmXB+2VjTE7DuMV/0n1OdObkps2vOGalMmTFsmdww5AO+?=
 =?us-ascii?Q?tFpzn3oT0twV/IF3tiUYHwgImTy+dWkWfdAnsKJkr+8LoZbrXhcu2SahR223?=
 =?us-ascii?Q?WcJprZDCzEUpBwpIptOqGNk/1mUcyWR0Cm/Dwewwx5s3fWtxNwU2oDjXSBeb?=
 =?us-ascii?Q?drgYUF7dLLb6vCSq2Bl+LWWBX7tCZXlT4/Ydjo71smGxtM5UuKhJoHx9MIaT?=
 =?us-ascii?Q?8+X1T5h129uGo4mqSyvR/qhHj33vSTXS608fExRhWxQbahcuhmQwtd6aLmVH?=
 =?us-ascii?Q?P9qJOx4B0l+2Z9GQx2GEzLKuy80lBT1OU7moh6R1nwIjddw6DoUapoJlM64D?=
 =?us-ascii?Q?8BtQkXoP3uQ6/CpCwv1KqZ0kAPM4o+GoFa5uLzOj5aFh7on0YOkxOoVuPK2w?=
 =?us-ascii?Q?6T4lUX0rXbHuQg+ATT9CiLLfwnP41Q/JpDWrgB8EIrLpGgHQvpkMu40alVHz?=
 =?us-ascii?Q?7kZGGVn2HYJIVcdnv5yn3DifKtigFFR2ejs/6TS976TzCTiDKAR9fewEdbbP?=
 =?us-ascii?Q?j2w57+gqWl7KqTNgVcxJGY7NycBco+KjY9nrLPDgN/gyDVVZne7vdmbue8vT?=
 =?us-ascii?Q?3m9gmu+Usa8LUVoGtf2tymz0hBfSpUHGrDhYteXo5KLOWFfsyRPJ7yyE6WeI?=
 =?us-ascii?Q?gldSXQJBGzSrKYJmxBbcdIwxnXXpOfJZlrav/EGkw+FZipdTo8iQ7e+OZPjm?=
 =?us-ascii?Q?a5hPlHsnC59OdFuqVZ/bUGLBUk6S6sqlHYVvXvAjIacQQNdHm5f7c8g14Yw8?=
 =?us-ascii?Q?PHQ4h5gbOJ94yGnT7V73orWTly5FNj+/aPfFZ8e0FP5nW9AzbzfB/EqsqbGW?=
 =?us-ascii?Q?auflaob51NtZTbx/7b3yX+MWa0xyuNq4HUbjmGWMG/vl9ng4LRwU3c7g5uHr?=
 =?us-ascii?Q?MsR2B6HYEj0Mm5wUTdHMgyMLH5zGHz2FwO/up4bMQNcPNg3y6QlR1+ER7ZxS?=
 =?us-ascii?Q?NAcNVDbVSJIq4zjmQzGRhjJdFC4r7Q8Xq0+a7JaeeGhWq70j1OWgkMxBesrb?=
 =?us-ascii?Q?/J7HCnvA+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1d6e7e-80b0-4c42-2efb-08decd6a9961
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:26.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SDwkfwiZixk0xOGIQPKxvG2WO+a+4AOJNiYOgb968Q9xZU94e2rzy0LfallVYqfYDgmpB3tiAVeymy8HLk2KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

The compound branch of rcu_read_unlock_special() arms either the
scheduler, RCU_SOFTIRQ (raise_softirq_irqoff) or irq_work_queue_on() inorder
to report a deferred QS at a later time.

However, that is not enough as in scenarios where local_irq_disable()d
sections span the preempt_enable() call of a preempt-disabled section:

 rcu_read_lock();
 // receive IPI for exp GP
 preempt_disable();
 rcu_read_unlock();    // Set the "need reschedule" flag.
 local_irq_disable();
 preempt_enable();     // Cannot reschedule as IRQs are off.
 local_irq_enable();
 // Now outside the compount RCU read-side critical section
 // however, expedited GP is still help up.

Therefore, introduce a rescure timer, firing every 50 micro seconds
after the last rcu_read_unlock() call, to fix this.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c        |  1 +
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h | 58 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d0816468ffee..8fd62775c176 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -27,6 +27,7 @@
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/nmi.h>
+#include <linux/hrtimer.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/export.h>
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4069132f9d44..3da43935f5e0 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -203,6 +203,7 @@ struct rcu_data {
 					/*  during and after the last grace */
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
+	struct hrtimer defer_qs_iw_rescue;/* Rescue timer for deferred-QS. */
 	int defer_qs_pending;		/* irqwork or softirq pending? */
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 960a45631098..f906d5d59b7f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -692,6 +692,54 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 		rcu_defer_qs_clear(rdp);
 }
 
+/*
+ * Bounded-delay rescue timeout for the deferred-QS reporting.
+ *
+ * The compound branch of rcu_read_unlock_special() arms either the
+ * scheduler, RCU_SOFTIRQ (raise_softirq_irqoff) or irq_work_queue_on() inorder
+ * to report a deferred QS at a later time. 
+ *
+ * However, that is not enough as in scenarios where local_irq_disable()d
+ * sections span the preempt_enable() call of a preempt-disabled section:
+ *
+ *  rcu_read_lock();
+ *  // receive IPI for exp GP
+ *  preempt_disable();
+ *  rcu_read_unlock();    // Set the "need reschedule" flag.
+ *  local_irq_disable();
+ *  preempt_enable();     // Cannot reschedule as IRQs are off.
+ *  local_irq_enable();
+ *  // Now outside the compount RCU read-side critical section
+ *  // however, expedited GP is still help up.
+ *
+ * Introduce a rescue timer, firing every 50 micro seconds after the last
+ * rcu_read_unlock() call, to fix this.
+ */
+static int defer_qs_rescue_delay_us = 50;
+module_param(defer_qs_rescue_delay_us, int, 0644);
+MODULE_PARM_DESC(defer_qs_rescue_delay_us,
+		 "Microseconds before the rescue timer fires a deferred-QS report.");
+
+static enum hrtimer_restart
+rcu_preempt_deferred_qs_rescue(struct hrtimer *hrtp)
+{
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Still inside a reader / compound section: deboosting is unsafe, so
+	 * rearm and retry after a bounded delay.  Once clean,
+	 * rcu_preempt_deferred_qs_try_report() reports the deferred QS and
+	 * releases any boost in the current task's context (or is a no-op if
+	 * natural recovery already landed).
+	 */
+	if (!rcu_preempt_deferred_qs_try_report(current)) {
+		hrtimer_forward_now(hrtp,
+				    us_to_ktime(defer_qs_rescue_delay_us));
+		return HRTIMER_RESTART;
+	}
+	return HRTIMER_NORESTART;
+}
+
 /*
  * Check if expedited grace period processing during unlock is needed.
  *
@@ -811,6 +859,13 @@ static void rcu_read_unlock_special(struct task_struct *t)
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
+		// Bounded-delay rescue: arm whenever the compound branch
+		// entered with a pending deferred-QS / deboost obligation,
+		// regardless of which mechanism above was chosen.
+		if (needs_exp && cpu_online(rdp->cpu))
+			hrtimer_start(&rdp->defer_qs_iw_rescue,
+				      us_to_ktime(defer_qs_rescue_delay_us),
+				      HRTIMER_MODE_REL_PINNED_HARD);
 		local_irq_restore(flags);
 		return;
 	}
@@ -947,6 +1002,9 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp)
 {
 	rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
+	hrtimer_setup(&rdp->defer_qs_iw_rescue,
+		      rcu_preempt_deferred_qs_rescue,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
 }
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
-- 
2.34.1


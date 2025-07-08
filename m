Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F642E06C3;
	Tue,  8 Jul 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984568; cv=fail; b=h14+orD3RZP1aPalCHtgrYg3DokTd+NmqXDbfOSYHURe6egszYmIa/uVbS+VG0rSeQIlEvgLlvhGexfRJSlzQ7J+TzszWwzU1UnPOhr8ZcZiwhJ6BgnrzbCptYjPHhYX5EzbY1fIbzFD0AdIs2FoM/KhvyAtLz8a7hxEyULj53U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984568; c=relaxed/simple;
	bh=z09n3/Ugf/huroPYmmZeGEgjUYJ5LmaJ/jpelxpyy4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=soiSf+EBQ4e8KdtbbEYjXSVZXwqjTf2Rk3OsprWqjN9cdmBVIPW7PFlet1lFWEGxnPhkH2iAQNiFwVCBCNinLoWHOQKwFi/VDACXdBAVP6BeVv2n7NRJX9oZokeZNjBShIfJc71DA7PcfF58NcCquGsXxhvcz+ZwbgPg+HQFjv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8yPYrOE; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8yPYrOE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2MYCuRNSz0r5Fh99/0ludjkTUWiDfSHast4COAsuYjSs4WEdHYB5spsjduBZAOlKggHsZPYK386WacPEzQieJCJU+yFrMf8uDf2FDsKfekNHCNtk0QdNHxzXnrPnzKs3FUevncL1w0a/0oLYry1Myv2lJTLI4RIWj5PCCgL1gsvmcPJlgN4gLqQNY09+v2f9KI46cvNgRTtSAZzUjP447C0AqYdsvitItv3b3PcxpR4qWUMwA0WXHiX/WniPVSWJp5vMGajctgZU7qUsIgZBqQG58KGA1zIErxyARds0deT9du4RzHPtbVORMq2HP4TqjnF8woSct+xfYVpxKkzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRpjPY4lmp4Pybtvg92F/7K02eBeJGCpy1hvhJnlybs=;
 b=PaaA44FvnhyZPfeeBVpVZuhSQUe+/jYu184pn2J+GvVWnJX0GWt7IByapcOaG0W4oRYttjJJR2X6U+NSbnAqAqqboceW+f50pPxIL0YGUHkmO6lmpW2Og1X73sKqhP6NZaXfGol+CuEcF562F6rNJrXtmrhkG9gQ7o52l+Rmq1qHiQGYc/Uyfp3/H5IhL0VhWw4tHT/aQCtTPjbKl5qtLA1a+Yj0yr6eecazt3UFZwOoEqvHMlYA3CnMKhJruYrF2Q1/FQLHwazNGt9gTQZbJXH9FHUXD7UAIxFZHH0CSDcMZcURgs7nif2d/nlAB/bfP5s/O5SYdAmXSEKdeIgDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRpjPY4lmp4Pybtvg92F/7K02eBeJGCpy1hvhJnlybs=;
 b=T8yPYrOEVbUgfXH1EgSB8cbh/qMpcnXbNtMgfOpTbhXzvswb58dvnllbS4uzObAZHbhhpKg1YJDrUhCwHDniNgws/J9SAJxlYd57CPMeUdyDlJF9W0A0QU2LsEmqVW7zyuDNmnKFX7ffak1xFOFZjJkX41GQ6ayds7mg6btzn0iAFSRkL6v15ibhO7lWG4/LvVSRoUDb2zB4CvcZWPCSHghmjzB+y75w/0ZIH3Q9JeRYfAwYJTyy7c2nzZ2CuzwCG7Ta+09BNGao1OUiLvlsiAT9NXiD3lhHnV7IjP/Dh3dwtCa8r40WUyQnw0PZPoyD/lqYSMCHOcCSK0jaVq3Gwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:22:43 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 8 Jul 2025
 14:22:43 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Cc: rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH -rcu -next 3/7] rcu: Refactor expedited handling check in rcu_read_unlock_special()
Date: Tue,  8 Jul 2025 10:22:20 -0400
Message-Id: <20250708142224.3940851-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708142224.3940851-1-joelagnelf@nvidia.com>
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0004.prod.exchangelabs.com
 (2603:10b6:207:18::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 45859a66-79cc-49f6-0034-08ddbe2ae736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1hDWQQrYSMptsZlp+/y/E6DDCNcU63MS4llRm3+PbfRfKo7vAIwKpdXoFGB7?=
 =?us-ascii?Q?gkjVtD4E1Z9Vzcj5j5eK3NzIeZ7gr1QCe00Vwem/3ctHkWsj9MSI8fXu6a5o?=
 =?us-ascii?Q?t5jxMTeHDyE1l+Ap3+SnBGz3+taUyR6wNgDk8MFeMkI47Q7xFsH7FCCjvAdQ?=
 =?us-ascii?Q?8Lvwt2GMmQHbXEoIcmuxqzDY2AhdqG1Lfl6yPx5yAXlduGdL5D39VVppWP36?=
 =?us-ascii?Q?PBobgQ1AVBFNYtU/TKFFAdrDCedbIhseJwOcdRiCEFKcff5mTIrKM3jzHZQt?=
 =?us-ascii?Q?r+O6JttJ8IAiMgCv0uBYQZa4Q9nyvMaOpYzqOosdFVW+lHDk/D+Gi7V5b3qk?=
 =?us-ascii?Q?kgw9lND6VuuyjfWQqnoFn74PdRylfs/seOtPuUM7gnuyQOHU3Sr6jbr3xDwL?=
 =?us-ascii?Q?z+6KTXmJhvgGbd7EvpumBfaSzjM7nNx6lX0RWfWGC0hPG8haGa6Q6oglPe+k?=
 =?us-ascii?Q?jUFZ2Fp3znj+pTQVBpLoLlMMTM5fr/mZ2lXY8au2E6LXipfyO6BPuYLScNl5?=
 =?us-ascii?Q?dugd2wx4qXV9D0XwKNxnXB3y+gZg9sK7v5NzQ1fbOFRRLSdnHOY/z1hiA+0X?=
 =?us-ascii?Q?lMS3V7aHcriwdNRRyCS06ESooXeO6BHtyiTwR1AAJsluzwKeXc5JWxawRhOZ?=
 =?us-ascii?Q?68ZLzsAslmXqqO9Nl0nx7zGG92dyZF/cIY4we9xjhEE2DFHjPXsWJJB0jmvf?=
 =?us-ascii?Q?sNibeg9ofgCmZ2Ii6eKSgiNLodq9jHZhVIDwky5ryhm5ospggp+P1M3zVlf8?=
 =?us-ascii?Q?so9wcIOfKUEYLt53kj+QxMt6M3pKuOimMDHynsQYEGxxTVCYh4L5IbqDFYY+?=
 =?us-ascii?Q?Z0jYCRVwxTmnD6DC4HXLUZPcsVoo2cmmUZM2n2gbFKzPPy8qRfH0kxPLCuv3?=
 =?us-ascii?Q?CjlC2ylnDGcIrL5Wo20YfIFPcs7sQxIj1n0PmWsLqZuvNr1YZlR0In8T4LFU?=
 =?us-ascii?Q?b9nfbuIeDs21kEYgdrIZc7UBDqTCoNTfNk6asc4c1Eyictf59GpdOE4HZL1B?=
 =?us-ascii?Q?xWct5h9oxLksd31c6HS0odFkTc8LcylyPEHmzuw0SsNSRC2z2eyV0oztkE8/?=
 =?us-ascii?Q?8x0zWIh+0K7pswPxFlGExDEvyWpqA37iTzC7IOh7DkvGa452elsowbspk1PH?=
 =?us-ascii?Q?jQZWG3oi+jYMhQPVEUxURQBhtvUVjK8qdOo5dndfhVdjQ8yhAah4vGnL8+Ll?=
 =?us-ascii?Q?eVxMurfU9NTj8R7shX9hN4x1GCcBuriYpqA3rwZKURE5gT2NfarIevZ2L/Xt?=
 =?us-ascii?Q?YuwREsrIe09dkl8kpedmh4hfoYbazhhvmZasxelIIEljqI69Ozlp84g8dV2d?=
 =?us-ascii?Q?i6lWzK3NRDq5+X4aSW3zOnF714iWDA5Y9HV0W+/3sztnEnBk0Y0xx398FqWl?=
 =?us-ascii?Q?knQWT6fsbGj4Uj7RDGqOtLngut+FfXyrEVl4Cq16PE37bkRfBB8FyOZyoBCF?=
 =?us-ascii?Q?H5njw/d1KoMDy2hZT+f3wg1XH9iMeHWTC2UMjIPiHD5Wx8AFVH/YuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i5bDkfmcPlTusld6O6syUz/PGodgMbew1/PUY230VzdmTwrMTOPWnEA5wuxT?=
 =?us-ascii?Q?N8fBDRlfTfw0RcJj0/qjYZYxkVcxZDHjf9almRbGrDqC9hYVQUSAULqL8ZPB?=
 =?us-ascii?Q?EVSBDqpwuhHmIYcRHCrrwOkZP5d85TZbaMT7JytIf1UzrYTxNmofDAIKKbNY?=
 =?us-ascii?Q?ramENjavFZXlfz+siD4ptOEYVL8caMUko9iUnkYRXCaXo6l+NO3Fl6PlPR6i?=
 =?us-ascii?Q?+Qg2S4Jxc/wlzNnQ8q38G12jxINjyh1xIINvARNG+csrXst9DdC9q3u7phLz?=
 =?us-ascii?Q?uVwQH0UdBzF9pporMBwPEVs4wk3gN/u9A42875zrMBq58ISeYLBSdr9Y2wCC?=
 =?us-ascii?Q?tDUR6hk4Nongs4peWqSd+v+Dlk7EV2DykEkzWvkxvQyQ1bm+EKXKKQ26/D+2?=
 =?us-ascii?Q?UhidOg5zz+yyIqv/Ie89Z4xBRsnEyx8e8Puf3r3sVLHT568XO4mKPK3yY8Lk?=
 =?us-ascii?Q?SpH2VTIqAUzV/0I1F9j7N4QBOsW/Jl2LiNHWfKmYQkVlYLAjYoJAniPX0dDA?=
 =?us-ascii?Q?Aac+9sq0mlrIKgb7VYxHyDVU8rb5ATQrVxXkPdIrKU72nSBSkKcVZ0i5f7jS?=
 =?us-ascii?Q?21Ug2e63jnw5yEumzmgv3k1HQRl+PTT+HYAjLaGPqtI8LH/8ic67D1XGxHgH?=
 =?us-ascii?Q?MEvRNlZ2Pb3mHgKJTrjU+Dd4psJOy2GZ4CXP/BMf6m64JmbrWQj+rnVU721c?=
 =?us-ascii?Q?7uLRG7botpeUZaJMO3SGdVIIwSRZQCmVzogrTpCcM+VwaUID1lEnysqgZ3qI?=
 =?us-ascii?Q?753vE1R5j4E3ix3kTepgQn/0FHgmV74MO6/5j4YyA+YXeLLq1Os/65ixhZI/?=
 =?us-ascii?Q?IGaHE5JOmULlriY/4PrBa2eVEE4qMqZG/LZqS8CJ/h2r4ERVdOVhKkdTYr33?=
 =?us-ascii?Q?CS3uOrZ5A6gy9jEuilbRdchr5u+4WLWi6cCUFimqOwWU/WFfTJJ7hzkI1nqO?=
 =?us-ascii?Q?5xnWQ5bUBcHVQTuiDQqTjG3iqqrDsHg1FGR4FhOzeZapz2rqlu2Y7l5mCRIJ?=
 =?us-ascii?Q?eWj8L43yau75Tk2tYOZotpAz+GqTPtfn9fNj97St8q1HneE09+UpHeY963H6?=
 =?us-ascii?Q?31vdBXsC4+wnkKwCJykLCpikLNiuoZjeCuF5SMOGnBb8+asv3EQpzPU9c70y?=
 =?us-ascii?Q?f3R1540SWi+FhU6NbfkUKVBB3W/7R9NgRO/oY/tFUk+EHHX6E0YIDpiGMkR5?=
 =?us-ascii?Q?I61Ah5UZkiag5XQdV/Pc9If+LNdvBWRiqxmHeuBR+ZAlvxucAdueg7+iS407?=
 =?us-ascii?Q?BbPbw/6ck9/JuQTYBN7cOHEdL+xWGbRPvWJpXNY6lA13IqVQJqEgAKdlygK2?=
 =?us-ascii?Q?BSPKm6IgXtUvPW7CgAy8oN4vd/uiWGxgxSxqAhTrokiKkAIakNEu0fTwFg4x?=
 =?us-ascii?Q?cxiYvo4Copd6a78JxWp2zwhsZMPI9mXOKOuYCyThHVj9kK1LiG/iO5MiN5xF?=
 =?us-ascii?Q?p7/raXMhTH9RRYvyAz17QyDwSkbZeDDSYkvJvHNnAkna4Tbre7Yp3n6jlqGo?=
 =?us-ascii?Q?4JGF8EyXhwhcJTi1OmPWRwYG00GP++D7CMa1jUUwLmJFLzox3/3JA6GuyOGj?=
 =?us-ascii?Q?RTdfZWRnX28DXczF+WmuTMMWu1rJ4wrGtCIkeWkv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45859a66-79cc-49f6-0034-08ddbe2ae736
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:22:43.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7nC5qdFQeWTjiy7FhUEGM1BkWmOFJHONDh5nFgXOIwweHIVrPwIuRzH6wskkh21gTXXhgUrsy9wdJ+nm4f8nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

Extract the complex expedited handling condition in rcu_read_unlock_special()
into a separate function rcu_unlock_needs_exp_handling() with detailed
comments explaining each condition.

This improves code readability. No functional change intended.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 83 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fa7b0d854833..e20c17163c13 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -646,6 +646,75 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	local_irq_restore(flags);
 }
 
+/*
+ * Check if expedited grace period processing during unlock is needed.
+ *
+ * This function determines whether expedited handling is required based on:
+ * 1. Task blocking an expedited grace period (based on a heuristic, could be
+ *    false-positive, see below.)
+ * 2. CPU participating in an expedited grace period
+ * 3. Strict grace period mode requiring expedited handling
+ * 4. RCU priority deboosting needs when interrupts were disabled
+ *
+ * @t: The task being checked
+ * @rdp: The per-CPU RCU data
+ * @rnp: The RCU node for this CPU
+ * @irqs_were_disabled: Whether interrupts were disabled before rcu_read_unlock()
+ *
+ * Returns true if expedited processing of the rcu_read_unlock() is needed.
+ */
+static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
+				      struct rcu_data *rdp,
+				      struct rcu_node *rnp,
+				      bool irqs_were_disabled)
+{
+	/*
+	 * Check if this task is blocking an expedited grace period. If the
+	 * task was preempted within an RCU read-side critical section and is
+	 * on the expedited grace period blockers list (exp_tasks), we need
+	 * expedited handling to unblock the expedited GP. This is not an exact
+	 * check because 't' might not be on the exp_tasks list at all - its
+	 * just a fast heuristic that can be false-positive sometimes.
+	 */
+	if (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks))
+		return true;
+
+	/*
+	 * Check if this CPU is participating in an expedited grace period.
+	 * The expmask bitmap tracks which CPUs need to check in for the
+	 * current expedited GP. If our CPU's bit is set, we need expedited
+	 * handling to help complete the expedited GP.
+	 */
+	if (rdp->grpmask & READ_ONCE(rnp->expmask))
+		return true;
+
+	/*
+	 * In CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, all grace periods
+	 * are treated as short for testing purposes even if that means
+	 * disturbing the system more. Check if either:
+	 * - This CPU has not yet reported a quiescent state, or
+	 * - This task was preempted within an RCU critical section
+	 * In either case, require expedited handling for strict GP mode.
+	 */
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
+	    ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node))
+		return true;
+
+	/*
+	 * RCU priority boosting case: If a task is subject to RCU priority
+	 * boosting and exits an RCU read-side critical section with interrupts
+	 * disabled, we need expedited handling to ensure timely deboosting.
+	 * Without this, a low-priority task could incorrectly run at high
+	 * real-time priority for an extended period degrading real-time
+	 * responsiveness. This applies to all CONFIG_RCU_BOOST=y kernels,
+	 * not just to PREEMPT_RT.
+	 */
+	if (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled && t->rcu_blocked_node)
+		return true;
+
+	return false;
+}
+
 /*
  * Handle special cases during rcu_read_unlock(), such as needing to
  * notify RCU core processing or task having blocked during the RCU
@@ -665,18 +734,14 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	local_irq_save(flags);
 	irqs_were_disabled = irqs_disabled_flags(flags);
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
-		bool expboost; // Expedited GP in flight or possible boosting.
+		bool needs_exp; // Expedited handling needed.
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
-			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
-			   (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
-			   ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node)) ||
-			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
-			    t->rcu_blocked_node);
+		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp, irqs_were_disabled);
+	
 		// Need to defer quiescent state until everything is enabled.
-		if (use_softirq && (in_hardirq() || (expboost && !irqs_were_disabled))) {
+		if (use_softirq && (in_hardirq() || (needs_exp && !irqs_were_disabled))) {
 			// Using softirq, safe to awaken, and either the
 			// wakeup is free or there is either an expedited
 			// GP in flight or a potential need to deboost.
@@ -689,7 +754,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
+			    needs_exp && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
 			    cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-- 
2.34.1


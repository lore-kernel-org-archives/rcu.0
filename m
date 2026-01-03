Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289922370A;
	Sat,  3 Jan 2026 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399844; cv=fail; b=C/2sm1fslQ63W3G/DKru5A7xgUYo213LRdVIX80lvaIEYY4nQ5CJKQnEtXZ8wHU2rCu6+mBqhrPvZ3nkqoDGmDxXC10k1HfkEtWrv39f9SD/GYkVQlDleBBlH3RhoQ4uPoKeLbDc8ohAMSrHiDmIBdS/mxQcv/uaEIfdgPyTGt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399844; c=relaxed/simple;
	bh=TFqodCAeZo1Ogkm0r0Im9Ln16atkSOpInZPpjXXepxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmMLYg58yYOnDyInp0OrYc63JVoJ8oqlGdMYR0tTArnWFBNwYQpPMCxoMWq4sSBgJAstNu0OPonTa09BmSXoSIwDISQIe4EctWlzVxBB3CB/Rsbwmzn4RV6+JqOAHKZ7n5vMs4jxmSPKnk+bx3Xb0byQaqkVnfyKGlzteTW0ACg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KpoI5gv2; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KpoI5gv2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snUTo+oqEKYRQGD22NifRVVLuu1JVjhUtJYqU0deYZmA8nDLD+xXBnJtUHV6Es8cXth2xcw5GXUl+yNC5YymnkkjBtu5gkTfqAjhJZKp58/kXqEAC0u6wIi2a8fBJoKcWtbarWpIYQJvbXDEkN2aLRpacMWanMY+ybjuXzIFZbSuyc6pycRyVX5ZoBR6gsy+qHxyZbNYjMUbB12Wjp3yvp5KGSQxP4+IjJGGJm0XzC6eqwOXFlGAO+Mui3kwDDRulU1NmMR+Prr0POG7pp/qIoAxkoxImQ883kZipW2iXSqLDZei8YEok+Wn/6CupGch6R4AiRdDEONjVB549qsfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2lo6cA9yYpv3Dg7pG7VtvfShhErAmK5ziF796zGRy4=;
 b=IkT+zeOy2NrxdnvKxrJwGnqMh5HycbU1vGnMwXdr/iJrYnXWCyfb5m6sqJ2dcYmNVH7FZba9Q3HRl89Ceu8Y8EaY4+UeGDlTPVpfH55ktjAWI3SsrOeEU1Y2CAgTyymLNMLKhS9NeWgVi4liSgvpxIW56pXQ6ZS3/g2CDCFbDrlJkTKdYwV2hznBJOpYdQpVKTLowMpscbWgbRypO/5q2pvUMOA+JJAWNRtMUnOx1ScCV6tam/znAd5NeIUZuvN5a2+5vyjUqbyOxjtKlWOF5DmsIO9tDzIjUsQAEmL8TOBIvfB00NLinndIzll4DfqM0ngshZdIxywJz0WkbX0EjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2lo6cA9yYpv3Dg7pG7VtvfShhErAmK5ziF796zGRy4=;
 b=KpoI5gv26sEm4OeBWoBnXqMrDPjeC7RNzGIv6nTyYQlhN5SxHKnUysikbPXozeUemPBcZ3/L0fqRMlIQzyJNpZV9WecHVMheoprg87O+1ffZHT6W5yGORbkHDsVZNQ5pj9ru8vmnHn572sOxWtWnaU/4d5u+gWYSOhvoY33n0l4UL/66d5ry+41BnlyCr2afDJkcINAp4Y9/dFEtgy5u02j2eurDsENqYBE0JwCwhZuip1utK43XQmLs9ApLXTAUl5jjcsSNKSTr76aE+e6Qmpq9EoaMS5Tr4E5xrrivJHqckg0zPwkGEJxwFfF6EW9tZPqLvaAZxDv4T1oCVZiQEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:23:58 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:23:58 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Uladzislau Rezki <urezki@gmail.com>,
	joel@joelfernandes.org,
	rcu@vger.kernel.org
Subject: [PATCH RFC 04/14] rcu: Promote blocked tasks from per-CPU to rnp lists
Date: Fri,  2 Jan 2026 19:23:33 -0500
Message-Id: <20260103002343.6599-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d1a058-4b4b-4501-7576-08de4a5e6365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gV7PzrWS6Z8CVqJi8S/+74zU5Pt+dWs4U8fzC7+1mtDWUaojhO+No7qHP/Gl?=
 =?us-ascii?Q?AjSsQkNpORsD7VbF+4gYJLiTMD96DcOT81AZPeTDq/s8BitRg5Nm0an6DYvV?=
 =?us-ascii?Q?H+olDaxWa6uh6YDF3/LXdvZS7bW4on+pkbWSoNSvZoZCqNH7jK8m7NWcjVC6?=
 =?us-ascii?Q?nv9KM6qIJb7lirTBrA/UT0ttJiVDA+br7AVLYgH/COPrmOodF7NE5CTrZ+lo?=
 =?us-ascii?Q?LrIvdq1Ynu2tpVnby+vlEAp9FUyZNIoktjizBRMGfV94lPKsG8H4Nka19fXR?=
 =?us-ascii?Q?g5rJKWLt2CuRrBm4mT6NwbgmbnTAOiIXyW655GVsApB5IhkaevDL061Itufd?=
 =?us-ascii?Q?GFa2n3yu+NIrnRqdzGX3vHZq+guAQkaje8o042gN352KAJxTkJQ8OKRkyUM8?=
 =?us-ascii?Q?VBPwUcnBAHTXfnSFd5GKdUjaFnrHjNyb+Qz+TSAJ+fRuyAmZhq1N3qrT1+wr?=
 =?us-ascii?Q?ON7X3jvVPHfWo+iho8K5DtNvmrl+BTwf5fqYVOtWu37x6OhVhoDsVYH78vjW?=
 =?us-ascii?Q?mZJ4pm9p0wjw1iDJCqajmBs0eFJGIMI4wq51OH1nXVkS3wmHQ/hdUKuk1GQr?=
 =?us-ascii?Q?2+lBtXPRWcaPPCwVSGweKaAHN295TFViaHAM7yJsTSsW7mdEg0wOzdUjhggC?=
 =?us-ascii?Q?MgACwrOgQOIztRVTrh6wV0TJF0DZVU/0rYrgr6P7pa91V8+epMHtIbImlppM?=
 =?us-ascii?Q?kdsndAdTl/JiKP4XjOl58c/g34gRjR2swXF7Szbf11L+EbvPs913D8GzBvDZ?=
 =?us-ascii?Q?LceL8JUq0gQGalYkr1z4x7uCMtALisCL2Tyq+mSJv/j/3LSq34ySmXQtAz8j?=
 =?us-ascii?Q?F4qweo6a1nJSjp6otSBDz8onPiEnjJ3oikbhDV4L2hFfXQBhNrbcOj/LEqkL?=
 =?us-ascii?Q?V853cEPclVyTxMQb7st4ZY6N3Hh+Wr57jtb4JyDjetGtWPHuUITgHuNED54w?=
 =?us-ascii?Q?YG4b0XKtfayT8I5tg4vnQjAO4bvnCDrzaIhIjGgg4IWgoBBPVTzX3TZBx0WP?=
 =?us-ascii?Q?vbRtfaCkRis+6Jg9CiOfaFBSnIJQHZKid/6Rzetv1tHUTUvDovgEcQpkMefn?=
 =?us-ascii?Q?I7ywZ2RnFYCwv+QRs3ZiOiH6HLj2WRaX7zUOYz7+Oja8NIb9NuTk2F/G6EZT?=
 =?us-ascii?Q?8u+u0BsF1MkypvEO/Ccs4eiuPN9IWqPZ3hIVRZTJZioZqlFhVF8beLUUbHFO?=
 =?us-ascii?Q?fYutRsLCI86B9chFL52HiWVtwFoeB/os3BP8dM7+i/OwJ638uke2YXIIpIbQ?=
 =?us-ascii?Q?SPmqH7HIWEXuZ0hKY46p5B3ceG3Z6bOsy2Z+gjIgD5Df5JTz+Ng6iufBxTIL?=
 =?us-ascii?Q?VX7uIWqwOvvHcUYh2nJYwXW98RvnA1mTcKiffGf2v/1G96XRFyxtSD033E/w?=
 =?us-ascii?Q?UfXwyDCbu8OQKCKKjTe9IMf1Ul1Wp/ZsVeYKe5XmwoZbPbUPQIJXmPBnOyBH?=
 =?us-ascii?Q?9z0hv3rP8BB8Cx2g3MSFCPhEYK0WKLtj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ZfpUPfivA9rsKZm6Mkx5FN9SLyIfNXYqtnDEpIBDVYJ/BoJB3F4eteLbKrh?=
 =?us-ascii?Q?jAy5LjKd9ok8m9pUxN28TTverNjtJLH5w/0404YHp24FqFgF6AL0hPy6EY1E?=
 =?us-ascii?Q?EWirkBgR4AbH2dkv4Da5ss57Y6xmqR8GcrGMC2Ygt83Lb0dN5oJrdrfGH58x?=
 =?us-ascii?Q?9GxOZrvu+Qpi9vaaYZ0foKKhSHtYhRuUlNQ5g/8FvcCn0M2xarwVFwYv3riv?=
 =?us-ascii?Q?voxiT47CouFeJFB9rr0hmKssQcWzZcxWKNgompb7wmfRdLzJG/Pi/N2YSDpc?=
 =?us-ascii?Q?eRRCRhFfFLfZK3bARG4aJAiqXxkBGQfp3/C8kxNHX4mBKYhvqHNDHA8wxtsB?=
 =?us-ascii?Q?O31FpgolFITboPJE1bYMsSsz96zszE6fhKCV/iWqGyrxvJ+3kcCuNWE744h+?=
 =?us-ascii?Q?VEC2OnEEsaCDYTbYd2zKnx5W0/zzvZ9lr4IEvBAr2Z/3g9YVlrq4XlH9gc/R?=
 =?us-ascii?Q?KI3LAWZ4578vWrOtD0sYM8c1XS71/XB71zUGX9PXXMVtQQq+w6Q+iAVlaWyD?=
 =?us-ascii?Q?iA7kOucUdHRnvch29yrwpPktmJZXEK5zmxdRJ3yGrYdxzel5pN+y0AhP8LT9?=
 =?us-ascii?Q?O+loc6anrtYR/f/D+j/ZALnNDOCxFUeyeRxn7Ic/dTNjp/F8n67TDYJppKDk?=
 =?us-ascii?Q?CgRTSKJMi6CnEz4nhXbWKewK3wPfivsKXQUKzHARm4JuG+0BRqVyk84A06Xd?=
 =?us-ascii?Q?a3nAUxkJ3vb79xk8pt15F8dKv7lyeK8TNVAuJBpjHja2wF5gG56UjDU6o1db?=
 =?us-ascii?Q?uoXQS97SNgX5ORw7b+Y4N4eb4Pamj8F16PasceRTc3r3sFJfEtyJZRIsygFf?=
 =?us-ascii?Q?PvpEXs+5sjnBazEqMLb8y3ohsp7qQN1+f0qjtJndy0b56OF91hqzbvYqLqfg?=
 =?us-ascii?Q?kyf9qAQtN6zwDUHF/UZlQcncf6244lGoSgs49tfKKIwNmLamUlgBmILu/wIL?=
 =?us-ascii?Q?GsA1TqJMXWqFQExCWVotxiJMfnPyINkE4ANaXbU8HSZPRCW287Wh621mc2Yo?=
 =?us-ascii?Q?eVxce19hQ3LAaTL4SpJ9/IoLUP4ljN7N6CAAk7G5M5C/f/uVhTZmyY5srNtI?=
 =?us-ascii?Q?i8prdeGFMrAWRL8RxMjEqjrZmL9DMlg+XSrlqWj4Whh9RjhfMp094SyqwBwQ?=
 =?us-ascii?Q?RtG1NoeNKgnOBk3t6WYdCXV3vK/K9XumbNTGUV6cNQaK4/7ShUcC/N5V+sBV?=
 =?us-ascii?Q?BYAPMFN5dnPvF5uPle+BaPK+20o72qv1abLZGs9BcZ9DMQN+y7XJpfUioFh6?=
 =?us-ascii?Q?0pFfioDydK66aPQf2eUHVUM0Cj4ASAUtoP3E2I+KZUMYD/O/wSd/APX1mUmA?=
 =?us-ascii?Q?eLO3B40CQuiX14IjX2Wnx+HCU4kCp61LlyDSTOkBBiltr6o/hS5HBqlUymGn?=
 =?us-ascii?Q?8uaS1PKjtX6bn7O33GIjd7cPWgi72OTdE+d+pqpPiIWlzpYZzcBKQN3BcL6X?=
 =?us-ascii?Q?8gyis8ulMdRZcqfxmCoaa7lyEg3nYXRhguN77aAdRKUMnFZrd/wyZv9K5dAS?=
 =?us-ascii?Q?MR3hy3lkhZVL9g8/lN0tw1ocwMYFAk6MZLObSKQBOAPeFg/CZ+rLOAItdoPc?=
 =?us-ascii?Q?K2nukLdnnM5cJrnMIf64hMslBDmGYiBGnxJ5lDvDuhXgaKvsRVU5r7sNe+tq?=
 =?us-ascii?Q?yQ7JlEYg+2mUv176xQxZkiyuCYzyDZ3tmFZQOBMnSRVj319QiW+QaK8AYJrB?=
 =?us-ascii?Q?qzeHp02vzvfjGMzZ2+7xg90yoiPTFCC8+3M6ZFVjx8r7pXus7Dcv/Le6xmM1?=
 =?us-ascii?Q?WHOqm02wdQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d1a058-4b4b-4501-7576-08de4a5e6365
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:23:58.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qDJ65VLJkzUBV34C+oI7ihfUB/wqp3lR5CBp/HUamoBkvrycoDYLP9e1NRkaV9tMdelOv4w6yqwKAjxoIv21g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

Add rcu_promote_blocked_tasks() helper that moves blocked tasks from
per-CPU rdp->blkd_list to the rcu_node's blkd_tasks list during grace
period initialization. This is a prerequisite for deferring rnp list
addition until gp_init.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c        |  2 +
 kernel/rcu/tree_plugin.h | 80 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e2b6a4579086..5837e9923642 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1899,6 +1899,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 		 */
 		arch_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_rcu_node(rnp);
+		rcu_promote_blocked_tasks(rnp);
 #ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
 		/*
 		 * Verify rdp lists consistent with rnp list. Since the unlock
@@ -1982,6 +1983,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 		rcu_gp_slow(gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rdp = this_cpu_ptr(&rcu_data);
+		rcu_promote_blocked_tasks(rnp);
 		rcu_preempt_check_blocked_tasks(rnp);
 		rnp->qsmask = rnp->qsmaskinit;
 		WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ee26e87c72f8..6810f1b72d2a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -806,6 +806,84 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+/*
+ * Promote blocked tasks from a single CPU's per-CPU list to the rnp list.
+ *
+ * If there are no tracked blockers (gp_tasks NULL) and this CPU
+ * is still blocking the corresponding GP (bit set in qsmask), set
+ * the pointer to ensure the GP machinery knows about the blocking task.
+ * This handles late promotion during QS reporting, where tasks may have
+ * blocked after rcu_gp_init() or sync_exp_reset_tree() ran their scans.
+ */
+static void rcu_promote_blocked_tasks_rdp(struct rcu_data *rdp,
+					  struct rcu_node *rnp)
+{
+	struct task_struct *t, *tmp;
+
+	raw_lockdep_assert_held_rcu_node(rnp);
+
+	raw_spin_lock(&rdp->blkd_lock);
+	list_for_each_entry_safe(t, tmp, &rdp->blkd_list, rcu_rdp_entry) {
+		/*
+		 * Skip tasks already on rnp list. A non-NULL
+		 * rcu_blocked_node indicates the task was already
+		 * promoted or added directly during blocking.
+		 * TODO: Should be WARN_ON_ONCE() after the last patch?
+		 */
+		if (t->rcu_blocked_node != NULL)
+			continue;
+
+		/*
+		 * Add to rnp list and remove from per-CPU list. We must add to
+		 * TAIL so that the task blocks any ongoing GPs.
+		 */
+		list_add_tail(&t->rcu_node_entry, &rnp->blkd_tasks);
+		t->rcu_blocked_node = rnp;
+		list_del_init(&t->rcu_rdp_entry);
+		t->rcu_blocked_cpu = -1;
+
+		/*
+		 * Set gp_tasks if this is the first blocker and
+		 * this CPU is still blocking the corresponding GP.
+		 */
+		if (!rnp->gp_tasks && (rnp->qsmask & rdp->grpmask))
+			WRITE_ONCE(rnp->gp_tasks, &t->rcu_node_entry);
+	}
+	raw_spin_unlock(&rdp->blkd_lock);
+}
+
+/*
+ * Promote blocked tasks from per-CPU lists to the rcu_node's blkd_tasks list.
+ * This is called during grace period initialization to move tasks that were
+ * blocked on per-CPU lists to the rnp list where they will block the new GP.
+ * rnp->lock must be held by the caller.
+ */
+static void rcu_promote_blocked_tasks(struct rcu_node *rnp)
+{
+	int cpu;
+	struct rcu_data *rdp_cpu;
+
+	raw_lockdep_assert_held_rcu_node(rnp);
+
+	/*
+	 * Only leaf nodes have per-CPU blocked task lists.
+	 * TODO: Should be WARN_ON_ONCE()?
+	 */
+	if (!rcu_is_leaf_node(rnp))
+		return;
+
+	for (cpu = rnp->grplo; cpu <= rnp->grphi; cpu++) {
+		rdp_cpu = per_cpu_ptr(&rcu_data, cpu);
+		rcu_promote_blocked_tasks_rdp(rdp_cpu, rnp);
+	}
+}
+#else /* #ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS */
+static inline void rcu_promote_blocked_tasks_rdp(struct rcu_data *rdp,
+						 struct rcu_node *rnp) { }
+static void rcu_promote_blocked_tasks(struct rcu_node *rnp) { }
+#endif /* #else #ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS */
+
 /*
  * Check that the list of blocked tasks for the newly completed grace
  * period is in fact empty.  It is a serious bug to complete a grace
@@ -1139,6 +1217,8 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 
 static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp) { }
 
+static void rcu_promote_blocked_tasks(struct rcu_node *rnp) { }
+
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 /*
-- 
2.34.1


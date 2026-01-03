Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE0209F43;
	Sat,  3 Jan 2026 00:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399849; cv=fail; b=UZoABGr1d6rqNsZ7N/3F7LQtUuTQban/t6dML3QfWlQbtKt2e9YndbYqmR70xoYyylb672jbrjXTPtdMsUJUj7qeJIdYJrcz20pcDpnw/RupRymLZVVuowNyFHHLEzXF8xDMN6NkZlNjMYoDDOiJ1jyH4RatLegQzAHmg0tnYrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399849; c=relaxed/simple;
	bh=gDMUMcMoeaJzV9MPVFUWcQsM2xWLYbhjMazIrIlTqVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iLuvNIw4HLiz3qdkaHalXnPPTKdijR9dptPOhOz2zryObnEh7Z5Rt0Vn8UmxoMh0UrvXf+M0rgSP7YUl4sLw5+Z91MfnZCIUQsexVfiTFqFYP43vsxra/cH8/Ml5oDv8bUtaRaViC4SQn1widTkQlm8bZ4Te3mLgavRaprGrANE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K5ccbA6k; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K5ccbA6k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo31ccyfAY84BcBnDoEo63d/wlHrDYM+Ru3Wa66U9ndTqAblhO6GnKiXCD7dNEVSrEG5I2CGi+8+Y2GhuZw3liF28OmEdbb9oYN0Xk9xvx0CNlBtG6OhWur0hxqbSsXaP7n7oGNvPd1m+KjLhjLs+LlDOhrkrGClz5Vty+Tk63u88eMdLbzdXETW432f0nYAIGuf693HBqRO1ib5LEFkXUKd0E4q9GFcASSY4Qmj4FwDDM8yMzFEx5NqbDsDcZfCvk1V7QAMzoQxUxoX0kDcWE/i5uHfb8mzXrkwwKJnAfnY4dI1cKiCzZtoOCUGVeY6M6jN2CdY3aDZLE5qdYEP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0fs3VuuDbaSEzz79VIjVpmfRvpDUT2HcWXnuI7kxr0=;
 b=jFB0EiM5I1cqifb3l68f0gWb2QBkus1F6I9NynDOcWF0aKJmgfHHigVixzbnOY7HNwuerHKvYhRBQmpnpdLBdSmY1MIg+9kTff82KlJtftwFcJOiMNPnQWK3jZaYM0gaLfnvNBImVMgDyOajxN6BN7VZwRBc0Dfl384+0K3Lmuq+mApTBLplskssOwUD+6qTJTcBbTTGTpKykgdogup/aFAJWci9DBWji0eWWLkn3tWq77PABQlAFoKCepBBAM80BGwTh9Ti8ienMAkztbMBfu/jBUNqPGTAxXpsBrFHgpMgro8gANO1bkUgwTyM/2kDts4Xp1EuCnpUx2Psu9DFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0fs3VuuDbaSEzz79VIjVpmfRvpDUT2HcWXnuI7kxr0=;
 b=K5ccbA6kiItqWDdB3kZa4BgsoDCr+6PXU4yhVlnVQmGTVtpSRVqVUnw1WWZ492LEMaBOBj5wSYCHhluvewqWdPyuUVg2aCq9EYIhvW7Z5w8p+o2QbHnBFdfFMQkC7DhSVQL1cp34pySw+4Ihz2hAtCVv3FVP4QksoBiM0h5BEyabFuoi27MTeGnUmC1T7mar9tOvDE+9H1yUrJphlyspeNVhCqy9FY1bxt1HQAxzzsiSIJmdkTCd0KDnWgjPVb1KeODwDt11UK171qO5pPLp0h40z8kYlFVmt20bQPijr4YGlTDUtXd1vBeDxCGm6tiRJPLg9PjtS4r3qMKhzKDexQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:24:00 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:24:00 +0000
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
Subject: [PATCH RFC 05/14] rcu: Promote blocked tasks for expedited GPs
Date: Fri,  2 Jan 2026 19:23:34 -0500
Message-Id: <20260103002343.6599-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:32b::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b649807-8dba-47b7-c2a8-08de4a5e6482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pf9HrEI9BPG0SsUG07rYhzc9DfWk0mUfQaznw9UrS/zqBgnibIrl1Efv9ZmK?=
 =?us-ascii?Q?S6FDWQwhFGhtBViQ7B+Bh6HrB3GxlhUTk7pS26VpPYkhREJ9Zr7lRGY0XF5Q?=
 =?us-ascii?Q?apj6xacBPAoJXK2Xg8wCl4iDYUws7bkfUJ64y9phABRLIFZH0QAugMKja0An?=
 =?us-ascii?Q?OKizaZZDvQ8Vajjy8fHUnrarcQywCgr9gQP/MkA46nQEnIz3n1MyS22vc7Pl?=
 =?us-ascii?Q?flSf2/+05Q5hwvZLrg4cD+gygt1if9ZDNV6zysa3OmKNHyQR5GjnXFDqt/Qq?=
 =?us-ascii?Q?P/786VkcH4K5DjEig35yiaTD2t5G5TAo78efqU8Yia5VL6Kzz6cDH3Dhh6WB?=
 =?us-ascii?Q?QXrMiWkNVTwR0RsVigxm815JEPsgmFMawXo0mVVrAoaLQYEqSOPMjfOOWoXg?=
 =?us-ascii?Q?EyATOqcwvzVKDsFQ2DyI7b3Lan68iroLTUzbagvJQ732fJ9T/ncunxNal//c?=
 =?us-ascii?Q?XFIbV2a5roRzk+BfYLAzzqDsN7t1hoA6TYo4qLBOqQvEo5zpjGtJK5UwS4Bl?=
 =?us-ascii?Q?FpmWGHCrGGXr4ChL7T7eRiF1AEaETGF++6dCY4q2RNGyMdcMqm43eAfEnFvI?=
 =?us-ascii?Q?W89MdMCZmyWjMQ48R2myLnhH1jOynStdIC5XhFlvdsj2+1NKFgmsb5pRvwoG?=
 =?us-ascii?Q?oL6e7cdNxSNGRApTsV/FU2EHluA9BK0dGAzqQWFm3q9Jgf8j4V4OiZ/kEvCH?=
 =?us-ascii?Q?uTL5xqsaZiISRvMfn47lLJEluGcl9XzGsYNT04mrt2sTE+RGqTXBIHQrxkV7?=
 =?us-ascii?Q?s00etAMHperwQsBhdR9JwABjuKprf9laa7r0gI9Cai51eS31lOjfsMkTLNjB?=
 =?us-ascii?Q?gQkuJh/4yvh49AkghGqxWp5eTfLd3E8I9+a2h48ovg4f3VAPGLQKK2PFeVic?=
 =?us-ascii?Q?OcN+Ii0O7OEKFb2QZphjR6t9MU7/qdz89zOz3lcVsAoWJUpwHJgwzXPKlVgN?=
 =?us-ascii?Q?8hQ+Q+1h/LJWf9T74bmBcSJMwLtzaZx1Y1J773V4rGCM6OxRBBbaWHKaU+vD?=
 =?us-ascii?Q?+xauVXqsUzo0FT05e3Ipmg1Vq7YDbdRAK/1yGmr07aTq9myjSKfDO27anKDr?=
 =?us-ascii?Q?QfaDbgoDo4Dr6JjwbaoG8uY+coi2vviRpNYzgmf2/yWx5z/1yKLqQKJEMW8b?=
 =?us-ascii?Q?62doLCUSHEsVdjVnkrvoIlH0FGMS4u6OSOjDo20HnHARGr3Gcf71qjbcR3tZ?=
 =?us-ascii?Q?qdJdPlGGlP2oPcuxb5nIM/5XRjD9ZRMYHpEg5WOlos2aC+IX/YmV70uPXtsi?=
 =?us-ascii?Q?ClDdFIxMDvlxm6x3oz1tZa5tNJR16zAFDNrQtyRBz0H4R9Y6vbgvndVgTucY?=
 =?us-ascii?Q?+Spfm6/DPMLrL8wmUmpRfdDt0jGp42kSMca7kEookHOkCyprnMJ6GJA2pG8f?=
 =?us-ascii?Q?10Bn6bOvJJvQSAZvw6+XeDWCeCbuw0+SPFeDsV1Ip9R0rgVHkro0o8UFfsgb?=
 =?us-ascii?Q?e7yLITooVqrRT3V33pjn0FyO5G9Q/3uz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMgwoo0u0K3OWVO5yCAMwlXttIxSpYwgXqD9BfquZrCwGCxK4++EljUpD+VW?=
 =?us-ascii?Q?3bG634w266IKsaERufxHOTDyEHmFUpJ6CzK2B9DtkbMbGPkrPMGod1/UYcKJ?=
 =?us-ascii?Q?4G7Hg6zsELnzZ87FGuoH2VfxckltsI0wRVBHqbgEJloI7maCKWdFHFxQSUuA?=
 =?us-ascii?Q?54llvrR7lhaAcX+1JfhMhgLDXGbMxWC00gdlYu/Hb2ERvluVQBnJMv5L0MZU?=
 =?us-ascii?Q?yoUPCfWMYEps/pb7sX+StPv0VyilE8Y/CyNudXBQ8Pn0x1IDyHxIkWFSLzAB?=
 =?us-ascii?Q?fvuYDSUqhL0WkJDz0nzuASD/PJ8QWbelZceLLX7hUUKePFL4KcR1Z3xezvzk?=
 =?us-ascii?Q?chFDVVTtMHnSMCMDn9I0sllniYfHUUOQ/8AaxCPk09JoaLmUm5kY5fgpwC2p?=
 =?us-ascii?Q?ZcIpqX+gHQmsL82X/8S/URy8mjkbvbGbYZ5+w32fSY8D8WKkLGeDmqi+R07e?=
 =?us-ascii?Q?fDOr5xh+EGD78r3pYW9m4+SYmOxkeTxIEA1jF6kbw/7S4aLMkYxc3AGo/RQH?=
 =?us-ascii?Q?RYCkLElPidIU9c5qbVtST7z2HprCeuXaD4ddhqKEfQ8/FFPrDbZBqVDUc6Lv?=
 =?us-ascii?Q?fxKVjDLpOTYvDZTIZMtSBGSXrBdPv+HIanIX0Zg+YB+/0mfqmobGB4B3W6hi?=
 =?us-ascii?Q?kjcJV6ItqkPWhcIQK62O8tiHtsIQ1g1XaheFdBXDNy2ucJUkxnApeYlkxVrq?=
 =?us-ascii?Q?4Sc4sqKaR/qGGK2/hnG3PEjCVQGqiS24plmyEf6Oaq4YoKVdwbvaX9dbA7si?=
 =?us-ascii?Q?/fkcxk2VtRVTaao68zgXeEPVNHmFXFL4XeT8clG333l9BRLJUsrCpPRcTDFs?=
 =?us-ascii?Q?BnAhJHj2pcp9pvKKLl6pCZpi2L4+81Q8pyB2pkyqHhNmNbbnb8ssojrGk4on?=
 =?us-ascii?Q?pT7BbO0hzNnXEqsueIkF+YVCKdpQAVtaKUJEQlr3Pt5itOOLeYMTi11GImId?=
 =?us-ascii?Q?7ApnT2Bg3nAGilBEHQFl/y5xlW4WoWcs2tnPrBoQc97gKxOQV92cGDy5uOsl?=
 =?us-ascii?Q?s3AG3N19AKvuil5iDCNZ4LQdkUJZX7Hj52hkoj3GuDoL+pzkzFE/JESHfVU1?=
 =?us-ascii?Q?SDDAiw1CoiVj6pPkZv2r7ELdkw3J+xCqYKe0n6RUGiCDZxPaB2aGZQ7+l2p+?=
 =?us-ascii?Q?b7CBchTitQL8cUxpf+gy6LPQhgTvXLTqX7xuPx8d/L7EOmNq1XF6aLWZRioP?=
 =?us-ascii?Q?lW1g6DJOsSCHFhxOlKBIv7DP8pqLhZvDy/R654kGZ/gWS9RWuSo5ESIP4sVI?=
 =?us-ascii?Q?x6wevmtMYvak6aidsOkNlhK2wVUXfkRzLN5xBwBp5db8cwwSpnW0gxU/WrzZ?=
 =?us-ascii?Q?SD0Ibx3f3mJNauBfO7MmCIVr02OgOmcYbMdp6oKLxUferfUy2cg/xFvxnkyo?=
 =?us-ascii?Q?26RdLLDXfo97n0IHbNvJfGPcTjcBLPOlkTNZNC1D8k2ryMOS2j+fI6Vj/1Oj?=
 =?us-ascii?Q?yxpP4sNmGABkTAtzoMp0WPnvMKTEkmTw3CaM8T4BPDvrNGMKZF42N9T2Nz0T?=
 =?us-ascii?Q?pk8n+eD1c6K0YRa7agvUkgAKtpAOby0feXWCrOOwLQONCpqTkyL3mxmVIufm?=
 =?us-ascii?Q?+xSRJZ7M9CLUeUCTPwlPxnNUmte7833+OFqA47/l2U9cT6sFJdcM7qXekOvW?=
 =?us-ascii?Q?+349RSTE6P6TZj3jCovJ+2FG99yLu3vVlI2atgtZLkQiiuQIxYFFywkzD5Lo?=
 =?us-ascii?Q?NLURzD4IZKGAgiA0/aaJWek6CT1nF4Kz8VW/nVuXXg4oP1FO7kucr5L8REsw?=
 =?us-ascii?Q?kzN00b0h5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b649807-8dba-47b7-c2a8-08de4a5e6482
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:24:00.7489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6ALlCReZxjqF/cDCn/yp1u7MzftEZdk4AZvsAUDeb5iYtboOXIYg0sn0odUcxFCFZfXNnZg7h/31BpXonGA/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

Add a call to rcu_promote_blocked_tasks() in sync_exp_reset_tree()
before checking for blocked tasks. This ensures that expedited grace
periods properly wait for tasks that were blocked on per-CPU lists
before the expedited GP was initiated.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h        | 1 +
 kernel/rcu/tree_exp.h    | 5 +++++
 kernel/rcu/tree_plugin.h | 8 +++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 13d5649a80fb..b71c6c1de8d3 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -501,6 +501,7 @@ static bool rcu_is_callbacks_kthread(struct rcu_data *rdp);
 static void rcu_cpu_kthread_setup(unsigned int cpu);
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
+static void rcu_promote_blocked_tasks(struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 96c49c56fc14..f6cb0e3147c4 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -141,6 +141,11 @@ static void __maybe_unused sync_exp_reset_tree(void)
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		WARN_ON_ONCE(rnp->expmask);
 		WRITE_ONCE(rnp->expmask, rnp->expmaskinit);
+		/*
+		 * Promote tasks from per-CPU lists before checking blkd_tasks.
+		 * This ensures expedited GPs see tasks blocked.
+		 */
+		rcu_promote_blocked_tasks(rnp);
 		/*
 		 * Need to wait for any blocked tasks as well.	Note that
 		 * additional blocking tasks will also block the expedited GP
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6810f1b72d2a..ad33fdd0efe8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -810,8 +810,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 /*
  * Promote blocked tasks from a single CPU's per-CPU list to the rnp list.
  *
- * If there are no tracked blockers (gp_tasks NULL) and this CPU
- * is still blocking the corresponding GP (bit set in qsmask), set
+ * If there are no tracked blockers (gp_tasks/exp_tasks NULL) and this CPU
+ * is still blocking the corresponding GP (bit set in qsmask/expmask), set
  * the pointer to ensure the GP machinery knows about the blocking task.
  * This handles late promotion during QS reporting, where tasks may have
  * blocked after rcu_gp_init() or sync_exp_reset_tree() ran their scans.
@@ -844,11 +844,13 @@ static void rcu_promote_blocked_tasks_rdp(struct rcu_data *rdp,
 		t->rcu_blocked_cpu = -1;
 
 		/*
-		 * Set gp_tasks if this is the first blocker and
+		 * Set gp_tasks/exp_tasks if this is the first blocker and
 		 * this CPU is still blocking the corresponding GP.
 		 */
 		if (!rnp->gp_tasks && (rnp->qsmask & rdp->grpmask))
 			WRITE_ONCE(rnp->gp_tasks, &t->rcu_node_entry);
+		if (!rnp->exp_tasks && (rnp->expmask & rdp->grpmask))
+			WRITE_ONCE(rnp->exp_tasks, &t->rcu_node_entry);
 	}
 	raw_spin_unlock(&rdp->blkd_lock);
 }
-- 
2.34.1


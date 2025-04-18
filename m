Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5321C19F;
	Fri, 18 Apr 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993255; cv=fail; b=W/YCJtGO0OumgWvY6sXQzVVsVUW/3JixLgodajucRUgKOoHNikvGuogQUnTkxnWyvn0ce+wFxtB2NPL9vrvHKuZtssFgwzMprLbtRJrhDBwxEsBwR/KcfYEhMLaMyoWoNyHqk5K4NKe8WFTpVkufJIgxVwLtuYvF2/nz4+Ja1/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993255; c=relaxed/simple;
	bh=L1/IuZPvUtqdKAuVx57AXttu6SfeSMIZ0n9wAA3z6xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aS8QXAeh5+N4V0Rx3m5tj4S7Bi6avtst6S/n7qBB8BGZUSItLQh9emdnOzNADB1TTPlNcheKyD+rcWiMv/1Ap9Cn7b1/oSPmwI7UcRYCawzcWBqE/PmVKjt2eYeBZbats14lnSXx7xQw4DUqy56exikpZnOvgEiNK8m9NTQ2xzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dN5wVI8/; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dN5wVI8/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOkLDFwpTFnIvn+hoH54gfps5n7dJKc9vtPorKPSXg2CbjozPg4xnZSCrBvGH5PCJTUNWKU884cnvDlGFKkyzdh0XZaWRzjNOiXb4PCd0J74YD+IN2vmI5gYSxAmphqYcyRPZ+BQpnuo6lOQQXZMsP6KK/nWmLOhhcZbEEYX9Njb+VjQGa6/U3lmeAPCmLTboN2fTBOYG+207OJCqB8NGu2AHabsSGwPeUGD6P1IQAtHboGVt90ORmzoNO+j8NfNS0BTZaFGFW1NkfYRiYz2FEJ02sYteFDNaKGdF/69lqqT31UtubgAG0eNaqDdvUYxXGN+Ox0/avbJiwmNOcSPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKo2vQwJ8/X4AfNkPGU6QW7cAxl+DPzoNvzJlZrpwbg=;
 b=Gw6/ObIErxAGjGBSiKcRQG4wzJHxUsLBh9SE24lp1wfhDw+XO80b+Ca4RPQQcEPYFDQkti1G1FJxwCujPdwhJbGMq7YULOmH0gn8et6Or6ViMIeHjMjQNRladIbzFGtdKJG0ZR8b4nkFgBcryIEYIb/661UtTUEkMXn/iwoMQVKxiNStwjnny3VrgGKvNpSbrDxknkIUtaK7JGlbMOM7vwfw+mj3Q2/b7ilQtx4y7ZwO4ZHHRB8bVrMocVYcbi9BKhGVgbAXmjmkuQnSSBDmph9xqbKn0fiOVfBN/Th2weW3SqaHvZqHwmtJH+qjLnyelCQCXHo48+Zqoie4O6y5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKo2vQwJ8/X4AfNkPGU6QW7cAxl+DPzoNvzJlZrpwbg=;
 b=dN5wVI8/B8NuSRYgfeFQtEDx2zdkQC7bSqs2qkNNPto9VWSLcOFPa4oG5z/gsbn0MAMDieKC1Sgn9fQGFwY1PdZbNhc+44VfwvoOlNZvvT5q4I4BTOXdKizoAKlakTPWPhz39ybXmJ3l32cqUc+wmWFgEL00mGJ8PXWTY/ir/bpR1BtYhbhR0n49au9+sq+mKRvRZVI/7/gVxVO2UNKDjhWhHRodREA3JY1F2h52OPuzPwo/Jnen28/BRN43k7HN6YYBf3z2mkoQWBakzFcSM8XkGgm2pGSWd9BEoQYFVYtlKN6SxPELoy9Z6RjoNICI69lGwYpCia5zEUvzIzEEVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 18 Apr
 2025 16:20:51 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:20:51 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 2/4] rcu: Add warning to ensure rcu_seq_done_exact() is working
Date: Fri, 18 Apr 2025 12:20:38 -0400
Message-ID: <20250418162041.2436282-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418162041.2436282-1-joelagnelf@nvidia.com>
References: <20250418162041.2436282-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0333.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::8) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cadd40f-f79d-46a0-237d-08dd7e94fc89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NPQgroSIs65QgbMqMCni1NT6ffZhwycX30t5zMgKeMpE69SSt+i8bLaBcIAQ?=
 =?us-ascii?Q?9JRK/OtjkTV/2V8x3WrPGFkunGjwOKxYWAyNQ8s1XQc4yB+6rq2zF21xixxR?=
 =?us-ascii?Q?gz+FuUZsialSjS1KMuB0gSQaiKDG3NV/UgyZYb+HwDSkjQPXzlfqRMoTqyqn?=
 =?us-ascii?Q?6GC1Dzzy6ncu27Lkkw1NWOg1eoH7Ut8Zqw1cl31ssczOaZD96Vqpb51igVMU?=
 =?us-ascii?Q?ee1cJz1eekAZcWYHgOPWta+2yfL6TxzU+yNx12SkX/AGW+lATvSfhsy33N4R?=
 =?us-ascii?Q?WPOIcU9w4J69C+At7l30CB68F8ZNMCX5s2vpSbqGuEXAxQ6sfwJKvq5J5uAZ?=
 =?us-ascii?Q?kNYwQxXEJMrHshIVaopD9o5SwBkvowUWaR0vR9Gfb0aN2Mpghbt4Ky5s0bty?=
 =?us-ascii?Q?Uo9eIi1hUMrXrNtOd7hKpQPy8Powih0K57kg/qOUdBJfG3Ss8FjlDcYJziay?=
 =?us-ascii?Q?T63vIT0phoR4cWaMyJkRY6tgWiGFMkdH/V9za7fM70a8oKvPYzbUH9S4Rdmq?=
 =?us-ascii?Q?4q8yxscr8QLRlRL4ifqi66Z9WkFMtg0tvemWQFnm+2Un7V/zGbk0i+ZVLfzd?=
 =?us-ascii?Q?n8xqWz0rdmwRvVLIc3mWlhB+W8WkM0JBF/Xae6u+p4xYfTFByL5ku08FKdbp?=
 =?us-ascii?Q?2/e+s9wikSBGfsISHYt2vuOTcTiwlKpTt0bT1FD3nwl6EGytepqOo9dMVqEs?=
 =?us-ascii?Q?Tuq5nnErUmUTD2NZSHYhU8EO8HuQtPxGsUNds/nkxaQcWp4xmbQdz752hTc8?=
 =?us-ascii?Q?hMoZCAUiwpWduKB/yrwaJzlfDuC4J3GNoAVsNNqn9KMVbtnyvdQodEFcQI8T?=
 =?us-ascii?Q?F4SGcgArAm7e7ajVEC4eOMcldoKXmpGCXrUykAYXNjfWL0e9lEk2UlaplXdC?=
 =?us-ascii?Q?iNC+ke1hMTPN7TOrfGXFJ7yuasTz5mIJmeEV0kpstWMGh2LNC4sgO1C5RZvg?=
 =?us-ascii?Q?jsv33YlM4PrX/g0fJeCn739E6M4SlKgckoKTnWvKwtiRZiFPCXidMescIU2Y?=
 =?us-ascii?Q?OcawHBpJ3PeZGIqovQL2slX5toS7UqPAvnv9pRx562bln1yBZz8hT8cwBofx?=
 =?us-ascii?Q?kKL1UXfssJy/2S41n1KWwBv0ler0mqVHfzTJq+jgTEJdH79sSeT2U4H4Gg1c?=
 =?us-ascii?Q?9unejAcx42AxVPjMO847RT5IUY6nAVArJqwVMeUUote5j6fZOYFuZYc2vX7E?=
 =?us-ascii?Q?JClUPPT/0P/s0TKQ/gOuufs/6xejJnQd7qLLtrjm4ozPNwLPUtewUJ+4I54X?=
 =?us-ascii?Q?7q1CqKCCrbZEj4amZjjI1l6IePsLUm0jY5mARE+z/BOVyjAZ99FuVGEiuOqx?=
 =?us-ascii?Q?h7SrDHIVgUp2VGpjBKCzLfdJWZpk3E+LiK72uDiyG/R0nelyVnmLGu4ci0PB?=
 =?us-ascii?Q?CU1bUg5xvg2n1OcEdjBqZbhMB/yX6BfXt2anJNDR5+kcvA6XX2FGfujjwCAZ?=
 =?us-ascii?Q?6me2ATbUKvbk2o71i/hhaJ/3rlzdce9jJCsqCBKwENAiGNtzDB4imA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7XbXz3nNZMGWNK7CLIfH8zTb/iYGvUJ2Uihgl+IIBt2e3pxq+TfqSdg+rXe?=
 =?us-ascii?Q?FPj3TCIS+m64FIf22e+zPq/DH7+crfV9aUqTRXtgiPU06TUZ1pOFgM8pK7/A?=
 =?us-ascii?Q?1oHM0iC/kM1WmqPFf649CSdZNb0NbBh8tDUOIXyo8dleUvZJGl61wN3N7Jkv?=
 =?us-ascii?Q?D2DqDetMWTMmSYzqTF17s0x+mTlXkTSzycHXQIx2Or/pJuM5FbwyL2eWqWSY?=
 =?us-ascii?Q?tqrzCgAii7wQdzkpUJW2+LpLcAbjMiVPK1C0tvAs/2ZAazv/w3kNbfeS46Wc?=
 =?us-ascii?Q?PTgyIjkd2/lbhGjuAg3n6dEfjFt7yW+i7ItW0EW6xL5FUA2OIcv8xlWnf+WF?=
 =?us-ascii?Q?zhOPC2oK1wQGPDq3CNvrgDr04aUKA1Mxl+RLqhW3/Grrux3CkVdlywa0tuyr?=
 =?us-ascii?Q?s/3BPoYn7a6nOaH1OKtZ+sE//QiRc7r4oUk97crYHNjhKV/7mne577IiC5pt?=
 =?us-ascii?Q?+WXC4I9XIAF4HkWYbV1dkJhnDv491qdRN/o+2k98vDULCLIpH7LyrEaKctvi?=
 =?us-ascii?Q?rczV7ZzHID3vHBfPE4WaC4ZO3iFlEGkLTqr96EXWfoYfJEBvaAtLphbxuJlm?=
 =?us-ascii?Q?lAcyUWn1LIvAgqNUvDAMM7CgK7EJfLmjlI4891NectL4SNFJN9JxSmNBT66o?=
 =?us-ascii?Q?nG8S/bFl9UMotIcSVY5kcTWBQzWbOCtAXMXlpvPlrZMfoLMFTrIwVa3TlZ4v?=
 =?us-ascii?Q?5rwBPSADfBMt2gurW5Z362lOd4bfdvVRYe+r6RZKpdE2y8xEMIsV12v5n9pX?=
 =?us-ascii?Q?zuEjQSmazNxTN6AqMBN7abL2RQI6DNlnQJ6F2i9kDBeAKtUPrebN5mAzzqzT?=
 =?us-ascii?Q?eMubYsP72RkW/13P8aoNO4efeZ8L2lzFrRKE/4b+UC9OyHc8NayCKuXWzavM?=
 =?us-ascii?Q?cpuEKiW1Nj5+iu0C/HJV8EZQSf1wwfbhQPy0oQ0V8mcHYe2Mrjbg3ktHsFd+?=
 =?us-ascii?Q?RmUw1joX1lGzJhbWf/ts2SP7u0pABw0V/4MztgAWM8Cogsj5WIrLAf14Efpe?=
 =?us-ascii?Q?7OMALhaPpoU0zgHRXJVI9EwLvb1p4Bwz1UFDzXId1LfRKK3N8oVV8gQ9/bpM?=
 =?us-ascii?Q?AVCUjrcsphgtDIVT5G9t1YKKTIg9+ldSwMN/y6fsDDmmTj6xTHEIwEotvPHM?=
 =?us-ascii?Q?1+m7CNOc6XjwB1IDt8ovxMWSRDfFHJJTCE1tbr70+ofYHDqeeg7QhofiDL9L?=
 =?us-ascii?Q?aTXdZJ0qXFlj9ggplCo1FzZ6Di7biERUToSJB5ZJ1Lw6E36/UDJeExnJ5eP+?=
 =?us-ascii?Q?GJIbsKDugCvkg2r0BZ2w+J3PqiXCNCSAd+RGJPh5VQo9Ys/bVUeLMtOCKSnZ?=
 =?us-ascii?Q?3RnmyIm30M/5BbjRCzGLEYF9+ZTYU0jSjyZF72nvewGZL/THBq6KM8eAau86?=
 =?us-ascii?Q?U2QESv7Y1d4fYiBGZXmF9kCcSwjNnxoxC19xxRqLKDWOfL241ASqrLyD86ck?=
 =?us-ascii?Q?Pv8OCqOXaFdUu1jiEdfE85eVO5378vPSnS3uspcFIQloodOzIZ5fVwQfh5iy?=
 =?us-ascii?Q?c648hyhmoOyUezFlJvgTNcoTVYRagpdHcnfpwDbvGNJt7GXDVVr7tOXzd4FS?=
 =?us-ascii?Q?D4YilVO6J7isbC7Sr8wIAhwsaL5TfyNB1ptjCq4n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cadd40f-f79d-46a0-237d-08dd7e94fc89
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:20:51.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSKRjcN2ig3NAf1S67es1XJy68El2vhucpwvNm9Fan+yx1RFYrWJFsGr1zX8I3SP4VbxykPiiWLeVuWQyK4MXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289

The previous patch improved the rcu_seq_done_exact() function by adding
a meaningful constant for the guardband.

Ensure that this is working for the future by a quick check during
rcu_gp_init().

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 659f83e71048..6b1bb85b2a56 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1798,6 +1798,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root();
 	bool start_new_poll;
+	unsigned long old_gp_seq;
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
@@ -1825,7 +1826,12 @@ static noinline_for_stack bool rcu_gp_init(void)
 	 */
 	start_new_poll = rcu_sr_normal_gp_init();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
+	old_gp_seq = rcu_state.gp_seq;
 	rcu_seq_start(&rcu_state.gp_seq);
+	/* Ensure that rcu_seq_done_exact() guardband doesn't give false positives. */
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
+		     rcu_seq_done_exact(&old_gp_seq, rcu_seq_snap(&rcu_state.gp_seq)));
+
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
-- 
2.43.0


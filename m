Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C30185955;
	Sun,  6 Jul 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751822375; cv=fail; b=ZWlvfB19QCOioYrm3vFyNZ/Tw6LmxWQ204ujlhadAseQwHq5VN5lGGJlUKBNXv10ojIHcSet1gsuHmFscDRmTpga+0xN9KiIxxbqefkcIvwYjxLCqKvWMTFqNJJT8cYSStC/SRB2IYO3pUdL2znUIIp6W2zKoA4K9wfuVn5lYzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751822375; c=relaxed/simple;
	bh=DfdzGmSMjQ8/RsDCEZHapgWxYUU1+IXXqkVwpaT9OMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qyLHXFON92Bus1im8Fo4Ur2UK0QvSYYmgRIcGZd9hvYaSnVAOO6QCQ2vUXN500Im1V/TY3DYQnxlNKCUtj8uZiUGFlsbCD3EVkKrPgpXnD+c6mUtqOgZYYSSq68DNNYkaoHUBJxhppJZkh/Ihzb6ZD957IhU4pJeKdpe2dJkD+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sn+pjT8G; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sn+pjT8G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYH8xp6AuqoDa0+PtPsL70hdVxYl9egeRtQMrF9pURO8SJFt8a6mDwvR5aGPUIqNS/W8WaLYsBbzailAQpRWr1adOlvMkdjpfup/GIOwTyD/5ksqtTbR/aP0whBJquhHo/WpEFWcoOe+ns/lqcZ/5dfF16a7CFZUlc+eEqqITXp6qZ9Ht9Nh0Z9LB3vf1M1piPjmYcDzl19La+PDrAPdk/5UwgycOgEpJSdas3tMr7FP6EwDzzkdr67BIxdkV6q44FUpg6B3OG6LgOkUHFwQjfHCFJc+0IJfzCCXtjmIIOyTZfRgSlhPC92nyvU8NqctEMfxQRYnlQsA1tMLR+s7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAn5rF3RNdavKt1Q4ZAs+EaGh9ofytJA8Jmo5DBUiQ0=;
 b=Zn6d4o9CL7lmCB+TMJMZG0QEu95zCmfH2gOT+leEghD0bCVgvss6QNPvsMNraNmlI/ZZatVnkbQ/B/D5xbINeU8zztDIBvfxbv4Zi8Bry+HsgGqlQ1EWTWp4w+clR/fRxDvPVSw3uMVSiH+ne77UuiKog6pGRDpQushxaS3BYPgwyUQbZ8C2hixEU5LEEk/F5e9A/yDsOBhqU0x/EY9vDD7kxHWCy+5bdKQTv3y9ZxlbUK9E0HncY3ib6AFnPjfc95GNVbezQrVeb5YJOom5mBCh3cHXfyDbTifoZBE/pIp53vc5P81zi0DWyJ4XDwIsrbeusWHbaR2nuk51JZm/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAn5rF3RNdavKt1Q4ZAs+EaGh9ofytJA8Jmo5DBUiQ0=;
 b=sn+pjT8GJTPrjA2lHfXxDu1Pf1wNGo/uD91jLF7PiSN0eWvfnwcXPLN4tyoKy9YBFI4yCOSqJSzoC9+PVQe/4v78ViQE6mXs4Zuxy0u69SmdBS5nD67czbVgBbftGA/DLEXxNaXmk1pz2WNoBfNU7V3id41gxtOT90UbYBZR00Hlvgcdg5fPnzT/oqGluDPBAtjtUGyvC30rHPNXWXwhuU2qzk11Mwxn5Cpp3fyPkROe4FY/SzMwRSn0e2h5FaUFrXlen0xhq8r3b2ypXFYLNZEKHE0Yz2SeqjRIi8Ps2g9p8TWED1Qd9NTfQSJY4LtKFB7z1nMpgtQWRYHkEAk3PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Sun, 6 Jul
 2025 17:19:30 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sun, 6 Jul 2025
 17:19:29 +0000
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
	Jonathan Corbet <corbet@lwn.net>
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] rcu: Document GP initialization vs hotplug ordering requirements
Date: Sun,  6 Jul 2025 13:19:20 -0400
Message-ID: <20250706171922.235086-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0431.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3b099e-842c-474e-5691-08ddbcb14447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b7wdHYzP/qgRHtyP3hPLb8/pYmLPXTTmjYCdKBFA29lfu5oojwoZx060LiDO?=
 =?us-ascii?Q?VJRBjxzKBH98AJeJ8cUvGC8k/oTRxY+LXRBG0M4kSLTR2O8bL7ppZboEUkYb?=
 =?us-ascii?Q?VeHAGUIYambSK3mbjGQdvgu/lN+NAgCaNCXfZTfVXfuH3AacHvvcCxuxmuj5?=
 =?us-ascii?Q?Vp+MDL2wzqFqiGbtZxPJMkrvH4f5wGFCu6MaP+rzYmPfv+5w+6ubOOo3tvuk?=
 =?us-ascii?Q?CEgPsNzuGcVhk7fnCoCL3sf0qsBhZO5rxbVEbmHHuORMrcmm5xWY2cxYMaEV?=
 =?us-ascii?Q?43/DLro7mR10hYwstydauktjmba+Oy8Wj+fQR3Zn1bYyPoai0iuB/OlLWDKu?=
 =?us-ascii?Q?9n5yTxMAsBs/BU14im4UUAqwHz7F4H0Em7FOKblpywRJIgO93+7mN3eo4TtU?=
 =?us-ascii?Q?EdpO0N/5ZYHfzwX5w2M0zd01U3UxPOnA0i8GEdOxUNBl+GXeoa5OvFmNpsbP?=
 =?us-ascii?Q?Xyu78c6PUEXnOBazKnj9KRHYFuRuYR0v//GNb8Jr+QLSK4Y4tMxi1qlPmfuc?=
 =?us-ascii?Q?9I2tPh0iZJhLZfQE4WwivdQUVIy/AmckL5XV2CZMvcXHTJOjuQdCAPTphBWn?=
 =?us-ascii?Q?gCqHjIH5fP/YJ55tabwTiDJrye1c4DAVAKBvMdcGXP2wuqpS7xg0yBU7zmjT?=
 =?us-ascii?Q?zzcsQyI3uOugXYSjJv1qf5HMv+7X1kZaEpLI2wutGnbPOxsylio8UcqHIT2j?=
 =?us-ascii?Q?szOwQQeOPaPUnZ6ZtnmvrZ3YcgyKHhFfvWHMDGf9PthfECqaceF13eEq+7Us?=
 =?us-ascii?Q?+oZ+2/aT3Wb4Z6LDXA+/zZPPI6HFCXJtwB/dHdFhlUcvFIqGEIZlBrLAKbo5?=
 =?us-ascii?Q?PXaWqfgd/LA5NZcWyNIsf1m6efCGvhUUu17jrAtT2iP9Qa5zE2ESlZDDmLgz?=
 =?us-ascii?Q?GFI6/i7Phu6YXal2Yinutxvi1Uxf6RfC7azAzrQGCKLD0+rZNu0ihoix7gSY?=
 =?us-ascii?Q?eSKu0URlCLUc2WYhTN74SV/Mzsv1m/Z2UjTKae/WaJ40aEzVAk3InCZXoF7q?=
 =?us-ascii?Q?ewltUtLTl1hvxB4jHO7bC+YSPBFn6kXIAgWpHYH2WS1JQ4h+Gx2Fas4v7OQY?=
 =?us-ascii?Q?jQSigTnC3QQuUnVTxJ1ajXh5heNwyuFHlrQRBwQDiX8hq5Og7eWvXM1kMG/C?=
 =?us-ascii?Q?rTmIPqif2k9nkPoz3PUxSCS5G1spLOS8ut5DlKpkPHs/eMwtmBJWRu0xPMG6?=
 =?us-ascii?Q?gm0JVFLrktZnxq9ZBLqvknLEQ3IrJu/MpdIsnRvp4sh8lMoi/4Jxn65XzWUC?=
 =?us-ascii?Q?9rqv+tQHvxJmXR1ia45g4WNnE7CXCmWTkyUaiBP8jv0XDlCR+y2wG6tRoEge?=
 =?us-ascii?Q?nV9PErsVVmcQtGRUiHGr/glBmOm+V+Rjc2lAjIXIfuEq6phXnfJjAldJSKMA?=
 =?us-ascii?Q?O5Wta9UVrv4UW+qTNzD9OWsH3ELaSztVBdN3RiDApqGT2wWQbgtL/k0erUzz?=
 =?us-ascii?Q?7Jwxy7Jt0tc2vrZbM4jGgON3Fd6he3BbOri6fgpMYbOONO1+0lJOKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWUtX3ZVILLN4ZK75RpoRxaisbmD0EyKQW3bYng34QU6ski5ENgN5/qmmTw9?=
 =?us-ascii?Q?fXpJNXIvoosIh+F0bDWs3tQJK5yC5wqlTfMtNHkA/ujCYZbYKvIa/8/I8ewJ?=
 =?us-ascii?Q?Rmddytr2nuFrNtvv50vIeJZIEJy6FXcPorWaged4wFLqtj62yKNPr/vu73Ss?=
 =?us-ascii?Q?LcvuQymiS4N/PNKmsWkJnN6qGme7S7Fp0MeEC2GEuwGzY4mYvZYM95YIYytY?=
 =?us-ascii?Q?6JIiQtQiEEB8DwvaxZL5kU1Av+RyNy97kjRf9viN3+dJs+i9Pr8QH7orFlbB?=
 =?us-ascii?Q?T0L+YgqK4d6VWJUMM+fh5hC4VNR1lACK/62PLUoefFlm7DUELxX9inoiSMqH?=
 =?us-ascii?Q?VdEBh+GPTJtuLQ+ds6p3uIi8U3z4P1JbwP3xCDX2J9NvFz6fyq59n/XxfEVt?=
 =?us-ascii?Q?vGWYwfeySHt+LKbQgxlAJPGFBkRJk+tkRzWexvfWBXUDAiPDvYC+FrG0c7ka?=
 =?us-ascii?Q?iiMtIXaItWoFVXDVWjXYACyVRvxdQlKL0YpFbvESaQAFzwYhuJ70j68EwrPX?=
 =?us-ascii?Q?RB/j7KlpMVd60pf43CRIYkC3zIE47H78FUda+FOb8tBfJn25eWPmVwMXYRBk?=
 =?us-ascii?Q?gMlkKpmRfA+SFRK1scMoMcE69SdfFAz33JotKceBKpHXCcLghgv9oxQ/7StH?=
 =?us-ascii?Q?ZaDjrkA69cS3RNlo4FquHvqf/e1E7zczIfe8awECLGrAFiuWsNliTfDOBJDu?=
 =?us-ascii?Q?gQKFGAHM2m/GJ3klkCs4Nexra6/vtqbBdTuGHhzJ5yjdYEv9gLE9+Ffx2pWI?=
 =?us-ascii?Q?BUpHUd++2q1cOxNe4dMITA1NJifJOWaIQ25qPNLdgpB/fumtm6Hte3fLzS23?=
 =?us-ascii?Q?D700x7t9rHPYXC+q/p3drcylGdn2VhfghUues9/Yx7UdNfAgeUVUz7EfUy/b?=
 =?us-ascii?Q?f8ZcX5jCl15zBpmhXr+tHxrgOsNzymcsd8prmR2dCMZFRygRenO1OpcgluyR?=
 =?us-ascii?Q?F+vsO4Z4IGbMeQAlxxfWDo6fNjXJSRoE80KBLDSOqaold3TwmRYFv9WJ+grd?=
 =?us-ascii?Q?tC75EwyRA7eYcVvOd1FCczOoOWYsGi1OEx3Hiqrkct/Oz2IjlFNwkwP6+jgj?=
 =?us-ascii?Q?4CVH8u3zgV7jTlzjBUPOOD/uDcdjlGuaA2vHHG6WM6aGB8jTAwjNMfsB3mRX?=
 =?us-ascii?Q?gfw/VClLRpjR+fUDTz2RIzv4en5JFUWc7BWYO5DA1SK9TcO+1aXbqvekUbJf?=
 =?us-ascii?Q?+WmDgxKqTLPd3eAhMGUXhKz3peoeXwgHs7vLh2KyGNoXKt4yBMKALqSNeuv8?=
 =?us-ascii?Q?fVJCvh7fGAOF5QxvSk8KAnxjeL2d8CT5czztn/bv6/ZQuqA1ezYdrfEKYdHX?=
 =?us-ascii?Q?qOMcIyXHuMcMCD8+pfrDwQlEsOzAMX7Hvzq6u0oYD9E26eE8sdEE3lUecTvE?=
 =?us-ascii?Q?6UTZQAICE0WaF5wUKgPUhlw1NX6GoYF+74FN4hdr0rI3f8zU/yebU21Z78ja?=
 =?us-ascii?Q?SpYzp+gUlsxf/KtxnqGuX+1f1IRyaIZQOjCqa63zQ2KvKlZ0qCcjcsiH+n/2?=
 =?us-ascii?Q?uZGfIr+u3ydOkOJQjEs9k7hrLhBRF1Kld1NMV2pEC1IMu7W/UzqTnL7sBaWP?=
 =?us-ascii?Q?ILBP5MTDwszWNqZ4SCypjrLb0ZUsBpXvP8jvyLQS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3b099e-842c-474e-5691-08ddbcb14447
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2025 17:19:29.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUxgKwMmkGQ+BjBTzyA4OhdKk+IEz2XrxVmwH2wHmXn6Cy/0AlrFLYN+aajsSRr/pIBISzHWwoksW5XhZ9JBfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251

Add detailed comments explaining the critical ordering constraints
during RCU grace period initialization, based on discussions with
Frederic.

Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../RCU/Design/Requirements/Requirements.rst  | 41 +++++++++++++++++++
 kernel/rcu/tree.c                             |  8 ++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 6125e7068d2c..771a1ce4c84d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1970,6 +1970,47 @@ corresponding CPU's leaf node lock is held. This avoids race conditions
 between RCU's hotplug notifier hooks, the grace period initialization
 code, and the FQS loop, all of which refer to or modify this bookkeeping.
 
+Note that grace period initialization (rcu_gp_init()) must carefully sequence
+CPU hotplug scanning with grace period state changes. For example, the
+following race could occur in rcu_gp_init() if rcu_seq_start() were to happen
+after the CPU hotplug scanning.
+
+.. code-block:: none
+
+   CPU0 (rcu_gp_init)                   CPU1                          CPU2
+   ---------------------                ----                          ----
+   // Hotplug scan first (WRONG ORDER)
+   rcu_for_each_leaf_node(rnp) {
+       rnp->qsmaskinit = rnp->qsmaskinitnext;
+   }
+                                        rcutree_report_cpu_starting()
+                                            rnp->qsmaskinitnext |= mask;
+                                        rcu_read_lock()
+                                        r0 = *X;
+                                                                      r1 = *X;
+                                                                      X = NULL;
+                                                                      cookie = get_state_synchronize_rcu();
+                                                                      // cookie = 8 (future GP)
+   rcu_seq_start(&rcu_state.gp_seq);
+   // gp_seq = 5
+
+   // CPU1 now invisible to this GP!
+   rcu_for_each_node_breadth_first() {
+       rnp->qsmask = rnp->qsmaskinit;
+       // CPU1 not included!
+   }
+
+   // GP completes without CPU1
+   rcu_seq_end(&rcu_state.gp_seq);
+   // gp_seq = 8
+                                                                      poll_state_synchronize_rcu(cookie);
+                                                                      // Returns true!
+                                                                      kfree(r1);
+                                        r2 = *r0; // USE-AFTER-FREE!
+
+By incrementing gp_seq first, CPU1's RCU read-side critical section
+is guaranteed to not be missed by CPU2.
+
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 327848f436e7..32fdb66e9c9f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1835,6 +1835,14 @@ static noinline_for_stack bool rcu_gp_init(void)
 	start_new_poll = rcu_sr_normal_gp_init();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	old_gp_seq = rcu_state.gp_seq;
+	/*
+	 * Critical ordering: rcu_seq_start() must happen BEFORE the CPU hotplug
+	 * scan below. Otherwise we risk a race where a newly onlining CPU could
+	 * be missed by the current grace period, potentially leading to
+	 * use-after-free errors. For a detailed explanation of this race, see
+	 * Documentation/RCU/Design/Requirements/Requirements.rst in the
+	 * "Hotplug CPU" section.
+	 */
 	rcu_seq_start(&rcu_state.gp_seq);
 	/* Ensure that rcu_seq_done_exact() guardband doesn't give false positives. */
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
-- 
2.43.0


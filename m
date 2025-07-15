Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEEF285CAF;
	Tue, 15 Jul 2025 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609762; cv=fail; b=qmJ2Dh59JQeAFE8VHe53emj5hRrkIk88w/snYZqi+5Q00mrFUI0SVzkgZpgSm5sE/Q+DvZ0DQPsBTpbjofuX+GI0EGthNbekOlwECe24gYsodPZllVfthOrLP52JnliTDbr3vMf28mHbTIoFSV1ZPTN7hpduOb8ek77FPVbXdfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609762; c=relaxed/simple;
	bh=QJpr/TDGm8E/EQmfJZ4z3BxWvQtDSqRZnFQ7peH+60E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MdDdVurTmd2AsvnOD6/GjwRs0AWLA78BGGZzNlDwhS53TMr6WDT4VrMjjS7muf1px/OolN/0IsUXZlKGUiJb1J/mtCLwuugW5+9Z0lMviJY12oiFtDUQ8OWe+znykzQ6l869y7NRO5862XTqOY+Ebto0uxY1sT2TmIJb6tIBKTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gunVe18w; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gunVe18w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIFo7fuQaur5XRvyggRYsgAy0mQ+Y5SmfUpvZBI9NWlGYb7Z07zI1wWQBuNt9t0DIAFjDPZWHmRJHk6Q0BLIFf2DtExIv/IKfShN5ivUtddHVGurArjZ2yKXsmLNjuWWc9Wsqv4q8cFQ//VfkX5ERc7lLpPuDefqp4TTvb1L+/8E5mJmisvsyldg0Z7/Ugp3tYtiN+icohFdKBORe9IzLfVTQv6a1o7eYAqIsMfpEp5/jrnMy0/F8tKSQUrQvsD5dTxiqaXX0TDrZM9Kezc261uuObD4GcVPBbxNgQgflgrxstRPZDUyuivOSO4ixyEwis+F7Ef1jMuQ3dZioDDQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQPMC+1ew8p1kEWGqaAo6UPDR1H3fjRnIU5QzV37Byw=;
 b=QXPgv3MfzTilOHDbSuTBYpIW7gxm+yBUGoCr2W7G+/ug76Ftq/B2fYQyfW1c7CCH/25ByF5N13m2atiDVba8RT0ap0FNGAuQE5gByxAAoTwtMEoDzQs5I1oH4Ea/FXKrFe9BGqrZhE+BCcE2u05ptpv68K43EvwzI5tNJP1Qqvw4H/ntTr9x/cZiJztdO0a5x3DHm277ZEMHBDP57wD1x5b2EYDt9b1tkEKE/WrM6+T2tOLYJB4ZRuYpdUqM+MpKrvfCtQNDm/fFmQZahh9HOGf3tDyKB9YzU4GSmem9qIgL/FhWvop8AzaAZ05mjIyse1++lvZj9qnSk64za+6irw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQPMC+1ew8p1kEWGqaAo6UPDR1H3fjRnIU5QzV37Byw=;
 b=gunVe18w8JN3pvXZRcNptYYW7arTfAd/UhIajVqeFNBTFbdAK81073vA+nRoL8djCRmpcSQ0V3H/GjwULaX3EVv8megrL48PeLkvxcTj48KD5BKDzZ+MjOAwTzrw4lXAfS0mjxzx4MUf2LuupXGtvWU1Qk1/zpwCl3KMoUDGIr5/xKiSXIQ4I3dQyWJsiFHdXM1YljUvXPEugK+L5vliSn+uVGPUiqV9FE84dJBQWIUic+xA3vghXYlvLDL190xR3B+9/23vD0IU4nkBnEMPTohspg0r4qXE9PF/1HU4jmSrvqRflJ5sVx7lCpzpkjboiWNv8VZFcuXAXvAFbNYdQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 20:02:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 20:02:29 +0000
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
	neeraj.iitr10@gmail.com,
	linux-doc@vger.kernel.org
Subject: [PATCH -next 5/6] rcu: Document concurrent quiescent state reporting for offline CPUs
Date: Tue, 15 Jul 2025 16:01:55 -0400
Message-Id: <20250715200156.2852484-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715200156.2852484-1-joelagnelf@nvidia.com>
References: <20250715200156.2852484-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0c6031-1eb7-4f30-ae1b-08ddc3da8746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VIYDdbi5rkfRZ5mw6bgQciTwBWHE+F9k8HMyCshLNpSTq9H1sMASIkvaqPtI?=
 =?us-ascii?Q?TXQsaYbS0GRJkS1kcnDF606KG8Koecb0qwbKVBgMdOOw2aY1SBeurz5mONQK?=
 =?us-ascii?Q?dFiIBBEGe1t3j9538i/5pc32XbhjqAA5NjpX0rgYjmQF65BRVLPQxUidLw4p?=
 =?us-ascii?Q?a82bv25dM+2qmyJ9hTPcXL6NXy49G+bJK5gee8IQSlJ0qcXNaiya63eEdGIa?=
 =?us-ascii?Q?g7jLZmol9cjX3gg6gjoZnTD3GwQ+2DHNdN9VvQgqU7tXPTv5Sd3UqamBJxcU?=
 =?us-ascii?Q?pEJaibKA2lbe0/fblaG3pEAv7VAw/oArIv21Ly7mzViOlH07LEEsokMOnD5V?=
 =?us-ascii?Q?o1SdK/JJQGp0RhpEIUxBp9dpU8KIP3FLBCYcikE6K9WJgAA61hYD2BgWNyM1?=
 =?us-ascii?Q?28HytoWIwHJNnO4600Q3ECjd57oRZWY2XqNGQDqJDA9dC/KZoPtM1hg9yPvZ?=
 =?us-ascii?Q?6KMo9nD1PRLvG4DYxSV+h8FeRlF2CKRfR4MSDo+FnQy+SA7caTrQgj5qP7lx?=
 =?us-ascii?Q?OLapEgQ5WPpdkpnzANevnENqhA15L2vuShuqeT1Rwg7EQXXtS0HNWXfkzpMy?=
 =?us-ascii?Q?2V6M9B3Dj/7d2poFwOs0zlUX0Wpp4f5m7nYEQskvWeZu51BLlxIb2ZDYSAXd?=
 =?us-ascii?Q?6+ZWDlBn0dlSlUGrkP2t/RPCCaY/9jOABO4cDc2YWE7dzx5ZjnNAcRcG2x06?=
 =?us-ascii?Q?I5U/bmjhh7FpIsibJxSElBahS5Ym0UHuxAIskiVE0Z8M9ffNM/gjrXc6FVVb?=
 =?us-ascii?Q?rrrqOuHTRxX3FGft81Y3sUMIQgxuY098n507ninvIzFy8zvQF/XKWXiZNL3p?=
 =?us-ascii?Q?BjZe7ZG24i5ofkwTLq6BhXl2Ipxuxzv6dd1rjdXfQpD/rsWScAf0Op7r4T74?=
 =?us-ascii?Q?ZzP+/Fk37vs+6xzjt/3dolsKTaKnoPrmV52VdxctetC6LzLuiNMJS6w/BwYp?=
 =?us-ascii?Q?HtF0CjefBz02m3Gm8oga8b+sh/shki7+42/rglrr9ZUEWa8+HEcAA1jBZK5B?=
 =?us-ascii?Q?5CZcmzBUdMZCeIqAnQdoP3jW+HwuAwlUzoaAJ27DDuHwPdq8L71a0gQ7YLRA?=
 =?us-ascii?Q?cBSwM75p/qoZypbIYka6yVLjTDBcL/oCEUk3YDxwKQ1tkOzmeSa+PpZCiCPP?=
 =?us-ascii?Q?BnBSU3YmcI1CkNmpq8sTjM776GW1i8LDlMxM1CLavTGjtW1OYErtBg/8KS1L?=
 =?us-ascii?Q?JW0q/Xht6dCcKZHfDAvZvkS/zd6ghxQgxrr3dh4l4+XqVJzKSp5mn2GvXbPm?=
 =?us-ascii?Q?2ZVgJ6zidFmI8BQMCnz+ib54CFMe+fT2rhq1ug1sSZy8j0R02hD6c6v4YVkB?=
 =?us-ascii?Q?EQzv0uFe6O2yvCF0R5Ev6Ani78bFSOILJstrUwC5wUKm0DHjtq/QUhJ5hOSt?=
 =?us-ascii?Q?tHCK/JylxWVWf38AHk+JOAi7jYGcQrvgNI+h7z8ho5I35vQN/50N9aNa3Rl6?=
 =?us-ascii?Q?8t6O6llTg+SGvw6lwnn8zcWtUL3gXhzfuVnbTJBZe4Azca71n1GAKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1RjihZSBZfGKocYkU2LVQg5qJ2rqSg6IrxolknM7SI8QqElBoivLqaWGjm1n?=
 =?us-ascii?Q?akAKJXrYV1cGJxaw69zUHCVzClu4GF4cKAQ0HtAQcI6o1WX8gHI8NdqqPr0D?=
 =?us-ascii?Q?cF8WtNVkgLEokvtFjlVAM24j+iN9IbLIc6tWd+4T/8a7gGHTgMU6yS9GYDRo?=
 =?us-ascii?Q?Hl1coAgShlAZl4XYCnvmgtXPdKw7dfWcfpVt91wUhWmTPSccBjhdOxqpwgm0?=
 =?us-ascii?Q?Mw1gJdNwCylUs2VdMw5Q6lXOaLfNfHpVLDG35SbSYxtg4f/UofmdDnh3+ql3?=
 =?us-ascii?Q?kSDIpz3ulkvA0Vyx2dsDMmUbZsqNKT0I/w/GJkXyZNIREuPp3DaKxTCEeAmX?=
 =?us-ascii?Q?6fqmwNW9yXYKQYbMr3vjPJR4NinPIXKTAkfjCngRTESsHRdFJIVrFrttYZvn?=
 =?us-ascii?Q?YUesbQlINou3IAfepaynNHzjJ/a8G5trH8Thk7hzODVYQb4QY9lIctr5MZe+?=
 =?us-ascii?Q?sLpIEsxao/soeYyb7+C5tIY5V5RsRk+SK4DMmMXKgpeA/4gpSdyLY4C8Ewa3?=
 =?us-ascii?Q?0Q3MjDQUUgE2lj8RSasuOkY4V7nSFo9Sq++e+CBnmudf5jiBpe7LQoTxJaYo?=
 =?us-ascii?Q?EMT+e1zw9yzNAcJk/Wz22cuL5hpSbGNrZehpEV5qRZaQO5hQZgo11Raf/CW6?=
 =?us-ascii?Q?lratQqRVwtKuK2txNbmEBMWfSYPDfw3q2L/eJzytWLnybPyYDmg8fozEJdqV?=
 =?us-ascii?Q?PpFszWGtaGr0M7Koj1LyL9ghUvXVBjhtYvwSVxQG4/l8+1ue7kUrYZ1SGzVm?=
 =?us-ascii?Q?AQRAdxA0PglgFJdf5kaS0ZrKv+3mJlc+Fbvfi6BDfL35WjM8yGHCB3mq0PiO?=
 =?us-ascii?Q?MUrcoJvqF21QWgfvhc7tVNw1JiuDmlT1Oy1kdeEACJQglKWTT8Gx6Z9pli2j?=
 =?us-ascii?Q?skokR5Ja34/FiuyJew3zoQdm/p0LAsT62GeNi4vbcnEvPrtHfaQzx8H0EKh5?=
 =?us-ascii?Q?aMvv5VWod1temS64bvObJe6I1EOBqFMwBSeFtO/yFAv1qocSYvHKw/tu/iL1?=
 =?us-ascii?Q?gR9u+0ReKREqKoDNjbVfjWuWpjzlBLZjRDDrCwSirrg0VNuWV9djaWVYaTOm?=
 =?us-ascii?Q?VqTGB5PbN+TmTFbHZeFS17/QG65ef1RWlqEC8CYJ5prn+3pr1IVi08PkCLXC?=
 =?us-ascii?Q?GKB3PqNGTncU7l6a04bVN52E8TaMtUpdEgHJMrMGstty/YIxr3hC/AlOfPak?=
 =?us-ascii?Q?EUQKwVAFy4/6ODXWXnlhTv/a7CzDkPLzCvXtgRJzO4yWKjSRFRoBraVn+7ql?=
 =?us-ascii?Q?zqha7RyJFoXZwVl9QixprDWHbxK9DxBr3hOTSxtT4lknNDizJPP0hNnUV4lY?=
 =?us-ascii?Q?jdxXV55b1ZL0C+RE5lIm0gNrLE8QnCxPLh3gt9AjRsth/vdpvCcyNCt9l+y+?=
 =?us-ascii?Q?FzGCg+4wKXSgpaKCT/ZyFBYPIbM88IgaR+EvF8QakubYZDWQVJzV8mKUErM+?=
 =?us-ascii?Q?AYJNgb7lyiMg/y3vZcUXpLQckXhP++DrFOfEaPkTvlc02jgaZMwKsWDIlzXF?=
 =?us-ascii?Q?3CLVZz2mC/PI9DqJjuE6ZqgL1Xc0cGeVV8xXZsyVJvsjTkVj6GEtP6cSM6cG?=
 =?us-ascii?Q?kW4hHelbQIiT13dPkBhlY2pUXDdak7vxNHx3AaAk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0c6031-1eb7-4f30-ae1b-08ddc3da8746
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 20:02:29.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pg7ROdzZxs4pFedmBv76uDo0bDXjKG1YlYFUyEF/oyq3worE+hv06iM/dG/Of96MRBSp91EKEcMtVEDXlw3Apg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

The synchronization of CPU offlining with GP initialization is confusing
to put it mildly (rightfully so as the issue it deals with is complex).
Recent discussions brought up a question -- what prevents the
rcu_implicit_dyntick_qs() from warning about QS reports for offline
CPUs (missing QS reports for offline CPUs causing indefinite hangs).

QS reporting for now-offline CPUs should only happen from:
- gp_init()
- rcutree_cpu_report_dead()

Add some documentation on this and refer to it from comments in the code
explaining how QS reporting is not missed when these functions are
concurrently running.

I referred heavily to this post [1] about the need for the ofl_lock.
[1] https://lore.kernel.org/all/20180924164443.GF4222@linux.ibm.com/

[ Applied paulmck feedback on moving documentation to Requirements.rst ]

Link: https://lore.kernel.org/all/01b4d228-9416-43f8-a62e-124b92e8741a@paulmck-laptop/
Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../RCU/Design/Requirements/Requirements.rst  | 87 +++++++++++++++++++
 kernel/rcu/tree.c                             | 19 +++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 771a1ce4c84d..841326d9358d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2011,6 +2011,93 @@ after the CPU hotplug scanning.
 By incrementing gp_seq first, CPU1's RCU read-side critical section
 is guaranteed to not be missed by CPU2.
 
+**Concurrent Quiescent State Reporting for Offline CPUs**
+
+RCU must ensure that CPUs going offline report quiescent states to avoid
+blocking grace periods. This requires careful synchronization to handle
+race conditions
+
+**Race condition causing Offline CPU to hang GP**
+
+A race between CPU offlining and new GP initialization (gp_init) may occur
+because `rcu_report_qs_rnp()` in `rcutree_report_cpu_dead()` must temporarily
+release the `rcu_node` lock to wake the RCU grace-period kthread:
+
+.. code-block:: none
+
+   CPU1 (going offline)                 CPU0 (GP kthread)
+   --------------------                 -----------------
+   rcutree_report_cpu_dead()
+     rcu_report_qs_rnp()
+       // Must release rnp->lock to wake GP kthread
+       raw_spin_unlock_irqrestore_rcu_node()
+                                        // Wakes up and starts new GP
+                                        rcu_gp_init()
+                                          // First loop:
+                                          copies qsmaskinitnext->qsmaskinit
+                                          // CPU1 still in qsmaskinitnext!
+                                          
+                                          // Second loop:
+                                          rnp->qsmask = rnp->qsmaskinit
+                                          mask = rnp->qsmask & ~rnp->qsmaskinitnext
+                                          // mask is 0! CPU1 still in both masks
+       // Reacquire lock (but too late)
+     rnp->qsmaskinitnext &= ~mask       // Finally clears bit
+
+Without `ofl_lock`, the new grace period includes the offline CPU and waits
+forever for its quiescent state causing a GP hang.
+
+**A solution with ofl_lock**
+
+The `ofl_lock` (offline lock) prevents `rcu_gp_init()` from running during
+the vulnerable window when `rcu_report_qs_rnp()` has released `rnp->lock`:
+
+.. code-block:: none
+
+   CPU0 (rcu_gp_init)                   CPU1 (rcutree_report_cpu_dead)
+   ------------------                   ------------------------------
+   rcu_for_each_leaf_node(rnp) {
+       arch_spin_lock(&ofl_lock) -----> arch_spin_lock(&ofl_lock) [BLOCKED]
+       
+       // Safe: CPU1 can't interfere
+       rnp->qsmaskinit = rnp->qsmaskinitnext
+       
+       arch_spin_unlock(&ofl_lock) ---> // Now CPU1 can proceed
+   }                                    // But snapshot already taken
+
+**Another race causing GP hangs in rcu_gpu_init(): Reporting QS for Now-offline CPUs**
+
+After the first loop takes an atomic snapshot of online CPUs, as shown above,
+the second loop in `rcu_gp_init()` detects CPUs that went offline between
+releasing `ofl_lock` and acquiring the per-node `rnp->lock`. This detection is
+crucial because:
+
+1. The CPU might have gone offline after the snapshot but before the second loop
+2. The offline CPU cannot report its own QS if it's already dead
+3. Without this detection, the grace period would wait forever for CPUs that
+   are now offline.
+
+The second loop performs this detection safely:
+
+.. code-block:: none
+
+   rcu_for_each_node_breadth_first(rnp) {
+       raw_spin_lock_irqsave_rcu_node(rnp, flags);
+       rnp->qsmask = rnp->qsmaskinit;  // Apply the snapshot
+       
+       // Detect CPUs offline after snapshot
+       mask = rnp->qsmask & ~rnp->qsmaskinitnext;
+       
+       if (mask && rcu_is_leaf_node(rnp))
+           rcu_report_qs_rnp(mask, ...)  // Report QS for offline CPUs
+   }
+
+This approach ensures atomicity: quiescent state reporting for offline CPUs
+happens either in `rcu_gp_init()` (second loop) or in `rcutree_report_cpu_dead()`,
+never both and never neither. The `rnp->lock` held throughout the sequence
+prevents races - `rcutree_report_cpu_dead()` also acquires this lock when
+clearing `qsmaskinitnext`, ensuring mutual exclusion.
+
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aa6cbd1501cb..174ee243b349 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1885,6 +1885,10 @@ static noinline_for_stack bool rcu_gp_init(void)
 	/* Exclude CPU hotplug operations. */
 	rcu_for_each_leaf_node(rnp) {
 		local_irq_disable();
+		/*
+		 * Serialize with CPU offline. See Requirements.rst > Hotplug CPU >
+		 * Concurrent Quiescent State Reporting for Offline CPUs.
+		 */
 		arch_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
@@ -1959,7 +1963,12 @@ static noinline_for_stack bool rcu_gp_init(void)
 		trace_rcu_grace_period_init(rcu_state.name, rnp->gp_seq,
 					    rnp->level, rnp->grplo,
 					    rnp->grphi, rnp->qsmask);
-		/* Quiescent states for tasks on any now-offline CPUs. */
+		/*
+		 * Quiescent states for tasks on any now-offline CPUs. Since we
+		 * released the ofl and rnp lock before this loop, CPUs might
+		 * have gone offline and we have to report QS on their behalf.
+		 * See Requirements.rst > Hotplug CPU > Concurrent QS Reporting.
+		 */
 		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
 		rnp->rcu_gp_init_mask = mask;
 		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
@@ -4390,6 +4399,13 @@ void rcutree_report_cpu_dead(void)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
+
+	/*
+	 * Hold the ofl_lock and rnp lock to avoid races between CPU going
+	 * offline and doing a QS report (as below), versus rcu_gp_init().
+	 * See Requirements.rst > Hotplug CPU > Concurrent QS Reporting section
+	 * for more details.
+	 */
 	arch_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
@@ -4400,6 +4416,7 @@ void rcutree_report_cpu_dead(void)
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
+	/* Clear from ->qsmaskinitnext to mark offline. */
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	arch_spin_unlock(&rcu_state.ofl_lock);
-- 
2.34.1


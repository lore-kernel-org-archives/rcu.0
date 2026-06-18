Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B027D3D75D7;
	Thu, 18 Jun 2026 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808712; cv=fail; b=kIs6jYgJuynKSpHUcg49iZzTk+AmEfCNPKv1ztWoIwvEpulcPsF7K0Cfwrj3VLFXGW3HXCBVzrUCdqxFAK08KsI4DlAK2JxthAYt3CTZczzjAywrdZkTPf8wVwOKSONpqR9B0RXN08xswhz0I2BxXKK4GhAv3kGkIWpy4FEbiAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808712; c=relaxed/simple;
	bh=nbzoIBo8oLFXrhXhre9h6NqOGBJIP0b9FgbLK0Qb8Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tf1jQZA7UDrOn3YQ0zqgsVOiAV1QSkqO7SF4h5dxhNQLvrwSrk84d/nyBeQbEpOqNxVRjYHDpWEJX1gNErJXa7HMQlEheQOHgUC4k85Gs0F1rWSDgx+9lnjwhcSH5jkylrbUSqdja0Fx+LuBV2AwS9u++U6e3ALB85aoAFsmNP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SV3ii8ib; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SV3ii8ib"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhx2wNuc7RawA9AEhzd5UGiD8A0GRfIPj73mFqR3k7elMZhH3F9A7yXzg4yaoqmcUG0H8J5cyUq/JnMK4CEadb8YAV9lwa9WBpnGfGtErIRS2oj3asuq04N0/7bFxzzYqm9lQljXG920TL2oD9EoeQ22qUuVNyprTJAIURnQcNCeeTzswytWPW5JYCCVNVsTnkUzc6l7ucSRSrXPABg/nKAoeFDm6f8haqDW6auVvw/9hHtNcNk10boY/JL6JGgIQJMfMs8ZLVb7nVcpx4d71dIsZLce/FlexJXMVy3cWoM6DlTNTVmqxuITs/aBmFGGdVm4wtlvziNz7OUQU3yCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgQY8F2BuSYa4PE+Fmh5nAsoE9Qza7c4CyJtv7eycp4=;
 b=PFm2Dx3TmB1IPpE6Q60iBqEiuAZJhkQRhrdylFlb5ekbqNtAcJGoEP9w59PwpCHl2hq5Et9kJ2wk8X1/h2talxLUJ3ff2140VyDE/OtVlPZeRidq23bP8aWiP744+61jHJAXXBSHkCke4sJS3GGzF5v+4ZpxjI7gtr/jSzrRTTP2QSZkRny0tCtfbfPFTJJbnRnVmcFoFUp0IpCigQFBW+ouMZdtUynrg7FYc77kfkbv9L+ZpAjGKWGuJ3iQ6dxhkoG/4eLVWuWlDhOY7H7WBjgvRtDYuhEQn3YoVHNQdRW4HE417Sa//4Eu0Hu8ssomMzWY4motdxINj+T2zFXvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgQY8F2BuSYa4PE+Fmh5nAsoE9Qza7c4CyJtv7eycp4=;
 b=SV3ii8ibvS9PVIrzYGrAk/RE2ktiqbqJkvxj59ptIy8ilsVZXyZLijb7s+5oHiJdLcGWJeOHf2fUM2jS9ECBI6DD512adxOtqd7VBVMYJSDRBAgUujXsVV0dddZm2sd5gkLSgvL0PTSqMndWHbgpNSXrHubNZk5J7ReWhs/zKxOBH/gpLKxHw7DBePMvyqVJNWUgL1vLjj4RvemFmn+AuBPrY7bGm8b7py75Z+G1Xh1Jv8geNS5O/c21hU8mrVIfGPVe/6pn1DYVQfbKEYOun4T4FvxKQTLnAkFcVtTtIc5fdrYxm6kQwAKRUGuUVx7lvYeH0NgwXwGbDawCFGvK2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:35 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:35 +0000
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
Subject: [PATCH v3 13/14] rcutorture: give async deboost mechanisms up to 500us before WARN
Date: Thu, 18 Jun 2026 14:50:29 -0400
Message-Id: <20260618185030.376450-14-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:208:32f::21) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 698863a7-fff5-4e3d-e6b0-08decd6a9f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2zx6mpwAvEAhOEBV6Yfr+XldTXGSI+b5Kv1gsbDmAOnHs30yHG2buQNpaP7x+hUw+/fR8K8L+yD7ScNGIXlWSvpHO79XnSlDLNKJ+vMISZftGqX3bmRskA7B6cdrtYDuPj2RI+l/5Rbc3DGvi/Y9cNUoWIuO8FC6UZHKDK6A+utyFGf6fwaqJRnwgzQtJug+/N4/lPDwwip76Ih9TlSiu28f86XSt7o2ocauELbTCn4nAuOM+Je9rbFjo17a2MGpnPkugugGEu0xO/+W7YLmKmvUJh7xyh5ZZ7ubZCsuxz7giq5CT699tsf+hs7L2InokJq3yGakRPFaEVfQSzqPGA9Ak3sV/YycHuZ7KtnsjThzjgy+JT12hBmF+fFnLsJCVIntLy2EmENR45Ryj/us4y3P5jr/UKNdGKblEZ3ZQCuJCCeCNiWe020y5z5Rbpm3KM2WzKKw1UbxELF1j6Z3jLUJqNNJEOmcltfCXKAeX/sqUZe8kxcC0hpZFY8ljwzybUGTtVzlrUUPQspw6hI9039Z2NGogSHiwPoxrzdunEm5yVMcJvXLn0K/+cT28OENL0ZrlD0HPQ20+zytnlwCsl3aRkAbVjOU6QuUsn47jJNkEit0n7IJbaD+S6kB0yRj2BJj16nqo9LUZKiwx2y6iVshV24KxtlKSKQqbuFSGwURzPijTP6xDVuAr+mgBJtO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4nlxFGCQ2ticWiNtsl6lMdAbGWL1utu6wSCs0bCRkRIB17VCd1IE+5pRwlkI?=
 =?us-ascii?Q?hb1RYRwgPUBi84lCAyfJGEwboJBdFSbaNfaQl3InsrOk9nty2iQrA+2SlxmG?=
 =?us-ascii?Q?GwDBc2t+4fFY3J8QT+ZGUJyW5363byWi81N6Iu1ztEQYkRZkX6lzntcOZjYV?=
 =?us-ascii?Q?3V7ByxJIA9p5AbfrpE+S9pN1M3ddwSW2PxinUWSWM3JxcIU7WcF+LdBAqE5J?=
 =?us-ascii?Q?aKVCV//44DpCG5WkSZHF7AOzApIfFMezCJ/R6gzjCq/qu71UtKMwEZ5lAeoJ?=
 =?us-ascii?Q?hlUPYM+8PaMZazeWDoPBQOqiIB38MnF2Zj7U0KaNDapBVL6C7+G4IK42zZOM?=
 =?us-ascii?Q?McRb//LPjFqK1peZlB4ezvCtkWAcYINf/XRYj+72+U5Uq+mKde2yF2eRLkbJ?=
 =?us-ascii?Q?izXxiiX9hvTNyZNItIbblyUAMH+HHOER+BmbYwYb1jh9+irYGRTeYC1f3zFq?=
 =?us-ascii?Q?1bdZsb3GHEm4WXkMrk08X3mhgjmFSNh7HNDtrxEquS/QWJTWJXvNqhjzo6ZX?=
 =?us-ascii?Q?weKzEEoYWliT4H8I2SPcYok5s277uxcRbKgUGcwCIn4/eIllqdd754LN8hrs?=
 =?us-ascii?Q?VfEjRD2fSkvNE3WsgnJ5sSCovawtEOv0h/CUodr+koQXxwsNN3BoALguIze+?=
 =?us-ascii?Q?BgHBNquAy5kGBTQTrkYdZRhzBZy4WFpcmsj6dXJU3HdIxAOkqFaWTJ8IBi2y?=
 =?us-ascii?Q?suLaEKpM8a3S48ul5Hgh2JBwnz4cGLM+qGiW68KjtaQr565jxqW/eD0+FXen?=
 =?us-ascii?Q?3Sdl+ZbEfbXO0lJKu0SG4st6R2/dylgFlqUNg/4s55wF2QYKRcO41euXGw8Y?=
 =?us-ascii?Q?tW2wOmiI4YOWCfznPTePn9tc14ZECeDNC3GPtBJO2FDMKX9eDwCZkCgLtDh4?=
 =?us-ascii?Q?TUvQLkI2syQb7nTRVVIFYDELVUu655rBI8XJYO9arIsSRyjsbrelsCC8wwNK?=
 =?us-ascii?Q?8EVx5c9L2jKhTDCE5kxzAH0ymLj6s+BGGMWp0rRx4doI88SJ0Owj/jWUnuEC?=
 =?us-ascii?Q?Q0usnBs84Bs2d8Eyt20WA1iX49pYSxpbmZS7vTMsX+cznd0KRVNtfKFf/ljh?=
 =?us-ascii?Q?zpV1U4qv2IOKT2Mk+fmuGUh8nSPuKIIGjBRVcZNjo2gbodY0RCFOL4aRkFkM?=
 =?us-ascii?Q?OwHdrRk2/7/1DYaT8tSxigIn9xJh+uBHET+yjFeUK5J+CopX29OPbew9wL9p?=
 =?us-ascii?Q?nFcWg7JC5/+dH1EfKqNeGVf2WrFWKCYsqr7O68yqB4ChW2lG0sF0YCW0J/Jc?=
 =?us-ascii?Q?h7lJ1E1OoKBkLs6JC9EAW0eS5l8OFi6tOuRXJwlQHq8Bq0vYVtclrQKsNu21?=
 =?us-ascii?Q?MqhSFDKMtVzY5A0ThW06/gUIpjKGymspLuvHGuxxgh5Z5nzHazmVwDutUGct?=
 =?us-ascii?Q?OMHxvHsPYNMClOk5xe2knY9FemKjA+MgRCN+ZYhAe6nDrlmnmoyDr+0i9LLv?=
 =?us-ascii?Q?eCwEAdoCm4gFBejk6WbGzhmB9629VYdFmIOmRldyLGozFrl0b5gdx9QkW/p0?=
 =?us-ascii?Q?WGWvJt9Knq4WHorbH5f/qlpjuu096aMNDxIvNDI8NZurYZQkBHnFVPDpsywz?=
 =?us-ascii?Q?EeDYB3t5g6MOX5VmdoeKpanSVZPtO/ILgwv2bd/ysY6IqrkRCHR91lrDxUMF?=
 =?us-ascii?Q?KSWTTQHBL2xu23Iv5xvuK73ifl8/te55hJf5PWiYy0u832M6AUZRVfDoUimU?=
 =?us-ascii?Q?cIJHlJmBtmwsgFBuBY4qrbf2GIOxCrzDhptqP8nq3YmY5kQgoiN/blR5GaIt?=
 =?us-ascii?Q?fpEkKzZwCw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698863a7-fff5-4e3d-e6b0-08decd6a9f15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:35.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JN2bC2XDWaCbisu6xdfcuuDrcM9//IpWpNlXv2J2rDjrqtNV1c7Ldq14/MN2gFOYqtQd+O6ttfDa2nmDtjnSlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

The Slow-deboost detector in rcu_torture_one_read() checks for a still-
boosted task immediately after the outer rcu_read_unlock() returns.
Sub-microsecond checking is unrealistic for any async deboost mechanism
(irq_work, softirq dispatch).  As, even with a delay in deboosting of
just 50us, the check beats  it.

Therefore, poll the boost state for up to 500us before declaring the
deboost tardy.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e0bea4039c42..12813b5381d6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2601,15 +2601,26 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	// of arch_irq_work_raise()).  On such systems, RCU cannot
 	// guarantee to immediately deboost RCU readers when the outermost
 	// rcu_read_unlock() does not end the full segmented RCU read-side
-	// critical section.
-	if (WARN_ON_ONCE(cur_ops->is_task_rcu_boosted && cur_ops->is_task_rcu_boosted() &&
-			 preempt_count() == 0 && !irqs_disabled() &&
-			 rcu_preempt_depth() == 0) &&
-	    READ_ONCE(firsttime) && xchg(&firsttime, 0)) {
-		nsegs = rtors.rtrsp - rtors.rtseg;
-		nsegs = clamp_val(nsegs, 0, RCUTORTURE_RDR_MAX_SEGS);
-		pr_alert("Slow-deboost rcutorture reader segments:\n");
-		rcu_torture_dump_read_segs(rtors.rtseg, nsegs);
+	// critical section.  Allow up to 500us for an async deboost
+	// mechanism (e.g. rescue hrtimer, default 50us) to fire before
+	// declaring the deboost tardy.
+	if (cur_ops->is_task_rcu_boosted && cur_ops->is_task_rcu_boosted() &&
+	    preempt_count() == 0 && !irqs_disabled() &&
+	    rcu_preempt_depth() == 0) {
+		int wait_us;
+
+		for (wait_us = 0; wait_us < 500; wait_us += 10) {
+			udelay(10);
+			if (!cur_ops->is_task_rcu_boosted())
+				break;
+		}
+		if (WARN_ON_ONCE(cur_ops->is_task_rcu_boosted()) &&
+		    READ_ONCE(firsttime) && xchg(&firsttime, 0)) {
+			nsegs = rtors.rtrsp - rtors.rtseg;
+			nsegs = clamp_val(nsegs, 0, RCUTORTURE_RDR_MAX_SEGS);
+			pr_alert("Slow-deboost rcutorture reader segments:\n");
+			rcu_torture_dump_read_segs(rtors.rtseg, nsegs);
+		}
 	}
 	return true;
 }
-- 
2.34.1


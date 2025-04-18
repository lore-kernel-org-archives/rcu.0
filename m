Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC621ABBF;
	Fri, 18 Apr 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992643; cv=fail; b=i7sqVkOsxOKNdOZ7saD7JjqWMIIG6FbMnBe+SP0sR45R+gsFqVYmxwQIxzXUJP8/epQuX7TJEvuYfsHVvA3VIKbocCUc3bze1bXgN0NXLuJ6H89uLPoQgP9aZc2hf2sJHDr/H/tGpiUk5OOrnlP1ycy+XvyQiBirCXdzLfuKpbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992643; c=relaxed/simple;
	bh=PqtN2QnGKl/krGrQk0cT4xSg2yfLHxR6io4qg6Xt9cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r2R8EiJZnm/n6AZxbyhNottpZ27HBGmYskZIgK8uB/K4FH9L5tAOb2nmEXqUzZok8JXw5eGKp7kCoCzp5QAZHAMxDmNpYmitM0MRWJHlh5j2rr2Fm1WVH1AJK+vATLjlEtocFNgSXMXzMeCQKIXbys2dEu8R/xoawf6y/48ykaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OhtdWp40; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OhtdWp40"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U67Alxq+sYquVmcEBtRJQ4QF4qX/KqmMUIBzyBLqvRxtJa6nAvtHfoqFNY1xP+bbKaSPoIjM/PWT/1rHtgnbP6EeEuABJjbihsnCfOzW8BY209A43UvQ7R7JCGYesLgzFlFmHNopgjNDX/kJJ3q5WMvAFEkthSoFmgw0xaMbYkjLpT9Es8pjmgGUsQ+BdWMkdtrSXbP5w7LPGd/xeh9DXmMxKNOdoUk6ZvxwHl/vJWdL4OWk/rCg2GhWL/GCzZVRSFtaonC+C6CBTIQsrWQSXxI08z2lSkz0KMWSpfd8CC1MDwWVD2xmjkUb8IEtP+2qO3iHj2g7Iy3/qe9DlCCfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3bOLnChhjF3b/lbnBuRjx4odslbvia9Tu78li7EAxU=;
 b=ROhpyo+7OL/gWIdB+/+v0V986KRQiWmYILpcUT4ET7CzE3A5LFkWzdXItOzueJttFFmwLVwV5dWCZRfOQZbE4ns4dHIl3lX1fM/fmBqkg+bvu7FbHODdqYRFYzpam3FBqV0EIbjHogVN7QJ/FDQEJBUj39I1Ay57LvG+ftlkPJMrL8j0Wdl8v08vKLBp60+0kKkq9EUXQstWajePz00ygrCKKJDM+kuiCbD6H2EljPP/+uUoI/WtQPL6rLZ6c3fkga+9AjGLOzyNxzZe1hd8AJWkjMy5Nu4jfYwwIrAm/WdyGyuo/7PbkvB2ugxrDk7f3ju+6+cmOTTxiFywgxRlmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3bOLnChhjF3b/lbnBuRjx4odslbvia9Tu78li7EAxU=;
 b=OhtdWp405q45G2YFD9PQnAFzqFt4nmLuZWwXlX+OR/4Dl1y+Wh7pM64s1cvTu1UB2FwEiSiPjOy0n6Sb3UZH0TDnbumjasTDFlgM8nNB3zWnzgIURl6yPxGur22QF44yYK2RLnD5C3Ap02ifnly1BGnJsgDx87TaEGBf59X+0USkWTRW0V10uBlYHOimoAP3WnGh9hPoSBuPc9zosRZFVmZO5uxz0D/iE0QgEoLFkE9u99T7lTQ/LnAOvKmJTXADZ2tXqkX1dFsNm+ZgJw0IykzG2Y3UGTav4oFMbA8LFP2ubeelYXTTVUzGGbxX0Q7PmrAFa+WsqdgegHx3HIkuDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Fri, 18 Apr
 2025 16:10:39 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:39 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 09/14] rcutorture: Check for ->up_read() without matching ->down_read()
Date: Fri, 18 Apr 2025 12:09:41 -0400
Message-ID: <20250418161005.2425391-10-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: db93520b-32a4-47c0-8aa6-08dd7e938fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qi+bkJGhaeTEewWh9RiDqZ/zFF9adCYEsNeot2LmaNSQZpXFHt8HqHWzD7z9?=
 =?us-ascii?Q?4w4lCvBGc5GmR9BxqhyMVga30IgqUNxVjHveF48/MCETTJNPTcKTWvsX67Yn?=
 =?us-ascii?Q?6Sy4DNzM3WErFmDGRZGJOo6WXdsYbmRDuvMwiKDSDo8MOqdLwj12VuRV+lFN?=
 =?us-ascii?Q?uGE2EK7zzzi3WCJ+tHIjSyqbGn9yqL7Ugr4TvnzIof4ZMPpfBt89ZKhRiNg4?=
 =?us-ascii?Q?i2TilHtj/HHtjTnYxs3pvwvyuwOsSD2nkd0wZ3GQWBjqpKbR6oPJ6cXP8YVp?=
 =?us-ascii?Q?fW9zK0n2up/YLMlnzGUCtz+DptzOB+6LwX6ilUq9tJlCw+zWvoKyQgtVxw2J?=
 =?us-ascii?Q?NkL6Hx6v5Y90zQJEzCB/Qz4IPMbw1AipU+60w+A6hdWV8NK2LPTM1skiZ2G9?=
 =?us-ascii?Q?atV+7Ie4RBUaa9g707d5N66E7L0YfUbw3TWkYMDYyI0PQxTzswvOi2bZw64/?=
 =?us-ascii?Q?33MePXhJ6rM+WUVG1T6FCr2DOqFQ4ZQsF3qHPpDPDosv/iH4jGoqYK2EdqOd?=
 =?us-ascii?Q?1yUNMT40oBZapPA/P4ytYAKX6MPdyiMjB2pC2RYiap7GKWUcAaJ4TECmaPKG?=
 =?us-ascii?Q?U+kVMYr8lwWYs+/pltVqY4UB75v2YnDfBSVvXXXMRjBdjMNMnCIpMptGNhKO?=
 =?us-ascii?Q?LKH9G6LwJBM7FTYzNUAxyAMvelyjOt0md4bm5po7i3pQONTpbSqplxEYPXmU?=
 =?us-ascii?Q?TvYJCUiNsyFHVQE4Jg0AxZfmtHWLx7MO1nDbCwiRbpKva0v/ppnKPh6tkPgS?=
 =?us-ascii?Q?vvX59ge+l330EAAN+fdh3e2bsMb7qv7diNrWg53MKwiczJAARbULWvb/F8WF?=
 =?us-ascii?Q?cCwj7EqOQLrKIxKKjju1i4PW2ERrEriGKqmGCYQOdE5cHoOcoy4QGFf9LquU?=
 =?us-ascii?Q?pLDZdEhqFQnZiOPZTr/EqCY1fYdcwScO9tZwc1SFggSIdGaXQ4ZDqLTqBqCq?=
 =?us-ascii?Q?xFNNqepg2UR4xe8hANGLBcxDx1ZgIOUnqB4j2a28tvHK3tsvpVX8Sx/zxMk0?=
 =?us-ascii?Q?AUUcJD5na+QNTjVLX2hM+gztvHZXlqvEWOap00wIQETNdBQWYaFppa2IMPHe?=
 =?us-ascii?Q?IOZwX2aBP0DDs8z6F2YyE6BZo3SBz839/lsqpD4tG+M0kM0oVVw+7dlc1nQG?=
 =?us-ascii?Q?IeO5mQcHYGKNzcHZBxgv9JZIo1xifKbaXoOR6EwuRSbF8/Jegal1njm3khuv?=
 =?us-ascii?Q?mQHEpae3+51USR6ZCIoWUD7qToNjZqwMwwfTua6pg4vb5ukMbS3Q4C5b9lrt?=
 =?us-ascii?Q?9qVTrigZNZv5VG8H5ovojFSrYXUZY2u0MPWuymHch8ghC+mzSiik5ca2cb7+?=
 =?us-ascii?Q?aZHXAq3Dx43lf2ufYsJwejf/6jUbgu+xzAAHhUjn8uLUpMhoLJxROS6UohRn?=
 =?us-ascii?Q?B607sWLJsjwE2HSlYMhegzyYC28PMZ6VFUv+GOI41QPDP0XHPTQW3sofDYL1?=
 =?us-ascii?Q?K4wWEeiP3TUu4bHDMXLXIcTuKBxBkAH6uWyp8g0+TFcYQffx+SlseQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZRagwQYzatjBbBj0rYkmmcmemO5ieVD1qxUatM/tdE8KHcDuXHVDh0FAW02?=
 =?us-ascii?Q?oSv4jbiX2fJiWTSWmh1zOryAHWx78wkiZNZ65LAAsn6dOnynGL80p2IgYZC0?=
 =?us-ascii?Q?j3xzPCzVy9k3wsQK/Np4Txz7UBvRyZGhlYG1myuUWNOEZud5+I2vb2EU15Ye?=
 =?us-ascii?Q?bwPR5jHLRhghdiBMk1NccWwJCZAQ0VgXENhYXebJRs5TuuhZNYo81qqNAu+t?=
 =?us-ascii?Q?FC04rA2KMrRLgyXRAgbTno/pZ8rMi3a77ROOWPL5/x5r79JumliFCm0gN959?=
 =?us-ascii?Q?tkGcF31epjo2D3GRVANP+x7FQkEGR88GMc6wATOUvxzfmf7GsA2yrssOIVut?=
 =?us-ascii?Q?jf/ed8FWhifOWdkRf3T4g8BbMIcG3agtjPE+/9qfD7gDv8UbtlG3LMskGsHc?=
 =?us-ascii?Q?Ab1auRqD2223bF/bo4gDqb3muRQT75oIRVoBrCwwNiDyh7cVYnt7fM1SjWQN?=
 =?us-ascii?Q?vGZ1gB4sgHIsf4ZDzOGWZXmwZXpJPc5rsW8kcYenep3EKDDOKHRQiYcrzpZF?=
 =?us-ascii?Q?oRSpxSRAAJ/sv5fFUAoQPxbeHauqlR46+P2tztdQOyIavo5cd5MGmVdB4WA6?=
 =?us-ascii?Q?CGH+rlb1PDx5GiXVtPhUoVpTxYedvgzTYohXg9jg7SBuOzMsouZk70Ly4Gwe?=
 =?us-ascii?Q?XnBxW8mi8+PqW/1GxbFAr9B6UGTwoTtRS/bmZaNbqxjtGSj77Qc6nKZIc7nJ?=
 =?us-ascii?Q?hUZAhgbTIASPhOjsuEXByzzziFCmA9gqsEeDVmvux1o9XOix5D+sj+W3BpZn?=
 =?us-ascii?Q?DXZX5EYeu1gKw1DaMrsSFhMuVZE4CraZPRREObXTRjUt22NgbXi67A7zel4H?=
 =?us-ascii?Q?08aRy7V54h9buI5YrDDg7Z0nOOLjQf3ykJNdXrLUDJPzJAvbHGZ3dpw19vSh?=
 =?us-ascii?Q?47fKwwnaaieg+mnwq2m7Lu3ukZ7Q0DkWxHm6W+Wt90VH6d4U9s763gnRUpwe?=
 =?us-ascii?Q?KJR+aM5YzN8dhwa4Y4RSG0KHiCP33zws3T85V8hSZCB53nnLoiibQ1QXmuSL?=
 =?us-ascii?Q?Wrjrc4lsfkhhAIKqBkic/YSrdKSf28KOKMH206fM81b6XdsHmSFjegZZG6y9?=
 =?us-ascii?Q?7D3TCahlykkIehtKQXy8WM2HDpLEvL11fx44YCiKFCId29e4RjsomdQobAn4?=
 =?us-ascii?Q?P8KKcHO/RGZW9pYizJLtHszOPs9+dKzY0Bgl07MDDH1WazHPePVo+s+hu7Ys?=
 =?us-ascii?Q?32MDyeeqzv4OXEUhREK7hlNFZOkFsGOM6Td23f/ZSbbdSyUxwgMUwqRVCOBP?=
 =?us-ascii?Q?knHmYKYXCLDzrWLCeJXSbD/mg3Rpir5SmgQGOUZ3HsY+3P0xCYLR0dk73R+P?=
 =?us-ascii?Q?dG9Y9i8svh5yG+ik3i/6+FgCCR6qQjmSKc+TDHEnC2iYFDAvcYEkAp8Qvw6h?=
 =?us-ascii?Q?/oTbEM2EPHS81wDA5r2eGH8iL8LsW8LHPCtS4gFP0i3mVBuKdnl9gYa6B4hN?=
 =?us-ascii?Q?SYPBcnRCbmGI4Ogn/4vPS5MKTrBO8ZXNWxpxOKI83xyxQ2roBnDq9g5vj/zR?=
 =?us-ascii?Q?IJkmoRj4BFo7iVWmzPnOj/7Ty9O/Gq2py8OV9yPRCsUUxEQSC8OdFIke0dIp?=
 =?us-ascii?Q?/DqXx5aI6Gcyv49ook/Kg2I83uRs1rURx676v8G1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db93520b-32a4-47c0-8aa6-08dd7e938fc5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:39.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Yvr3NhfG2u6sTWnOFyEXSCUhWVcq64uHyFtdn1WZzcasE7XC1NVBf/uaif+aKcOE0C3LwmL/Q8D+b47qR6vZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit creates counters in the rcu_torture_one_read_state_updown
structure that check for a call to ->up_read() that lacks a matching
call to ->down_read().

While in the area, add end-of-run cleanup code that prevents calls to
rcu_torture_updown_hrt() from happening after the test has moved on.  Yes,
the srcu_barrier() at the end of the test will wait for them, but this
could result in confusing states, statistics, and diagnostic information.
So explicitly wait for them before we get to the end-of-test output.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0b998609c7dc..402b9979e95a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2439,6 +2439,8 @@ struct rcu_torture_one_read_state_updown {
 	struct hrtimer rtorsu_hrt;
 	bool rtorsu_inuse;
 	unsigned long rtorsu_j;
+	unsigned long rtorsu_ndowns;
+	unsigned long rtorsu_nups;
 	struct torture_random_state rtorsu_trs;
 	struct rcu_torture_one_read_state rtorsu_rtors;
 };
@@ -2453,6 +2455,8 @@ static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
 
 	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
 	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+	WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
+	rtorsup->rtorsu_nups++;
 	smp_store_release(&rtorsup->rtorsu_inuse, false);
 	return HRTIMER_NORESTART;
 }
@@ -2497,8 +2501,12 @@ static void rcu_torture_updown_cleanup(void)
 	for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
 		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
 			continue;
-		if (!hrtimer_cancel(&rtorsup->rtorsu_hrt))
-			WARN_ON_ONCE(rtorsup->rtorsu_inuse);
+		if (hrtimer_cancel(&rtorsup->rtorsu_hrt) || WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
+			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+			WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
+			rtorsup->rtorsu_nups++;
+			smp_store_release(&rtorsup->rtorsu_inuse, false);
+		}
 
 	}
 	kfree(updownreaders);
@@ -2514,10 +2522,13 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 
 	init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
 	rawidx = cur_ops->down_read();
+	rtorsup->rtorsu_ndowns++;
 	idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
 	rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
 	rtorsup->rtorsu_rtors.rtrsp++;
 	if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1)) {
+		WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
+		rtorsup->rtorsu_nups++;
 		schedule_timeout_idle(HZ);
 		return;
 	}
-- 
2.43.0


Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A051304BB2;
	Wed, 14 Jan 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411947; cv=fail; b=em8WzEfA7hd0DYV+cRIxXRAR0/OmQZlFusHVuaCMiN9XuAVtggOqWd9GVUornvYzjJ7xWJDLaDeDJZN6ZQLiFATQnJ4KdT51FgW3+Hr90bLzHaVnrh3RKC/nLX8X4IOgDcta8w2aD1etI5jK8MMY4hnLDScs7sjmF3yKikd7cNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411947; c=relaxed/simple;
	bh=kK3Es8ZAxcI2Mr5DlNRoTUVsVOAZKhv1sERaQ4+YS5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eixm4ds601WwJ82VAezA2uGkyOt3XMBNQAAU9qOfANY0HjNXygE33X46v1ueC73yarfA82j3qTiNBwixXlbR2+bso8P98b6pydotRsQtpfaisalHG9AC5DvrXH+3R5k7NqQI4bmZq0G6M3vnYBojrNCERL2NYbjVL9Q2pDyeaqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dPtShuQm; arc=fail smtp.client-ip=40.93.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dPtShuQm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXLEP2AADReDWFubXlrof7JLa9/hcKp5Po43JUGMzZZos4W2q9+2z98eVxTUh2sI/ZRp9aL6Nz2Cj4pKSkv2X5lxwvF8FkYp1437n8DfvwAqMydT4Z2NVoiVMnI+YvFlhQAM4HPttvI3MlseTjANovGXBZtu/zIfxIhc4/1pmHe/VbsqWU7tmRF4/18Z1RGdvSguQBcuisjtXoMxaxo1UDy6QQjQdtzM6BHj7t+GMcIVS8heusXG4Tz5WhN2wtPk4keQaDAd6nn28uSLK1tYM72kl8uWE2E8cpLXGdA5V7qg7LW2nRuorrZqgBw7qmf51uhHmJ2Y27TZcK0gkxKAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8HCxq6FeGSkD9eM6ooDHJ8QYRaO6ycFBfPcJkgZbB4=;
 b=uft1sgcj69MLLssM9jQnIaNxZmK5NPwD4X54hJ/ihs0Fv4ZtViK7LIhOfiW/bsxjS323aoUXtKxjWMfjiKMKG54MDS/tFSV2rJT/SC8+QfWDvDREPFxqL/RT0a/u6xNZQ/bwBCzUfjdAXzD6njad8vJFQdpjdxzxpk9RY+ntAqmetCbs7ghWYnz+aRcPb5b39gZD3Ne0bg5uJ70tOKN2roeoEjduxedsOVDjNQC0OrObQ9OH3XlkQ6mM61gJhZPVHaf7Qtrk51b8EaE4ahiuBLc+0q0GlI1bvSNEmCzFAzg2nsGiCXzyhB0z81rl7C5hGq/S5AdwqyAuVLJvQnJNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8HCxq6FeGSkD9eM6ooDHJ8QYRaO6ycFBfPcJkgZbB4=;
 b=dPtShuQmOjllArp6CDD6l6LtJsNkbnNjwNkQp+7DwB2NzDoIsUeG6XJNXebRpsNETe1dsojy/rPo3jBMHantFObgZReLHeHkYJ6uotVq1Cic/Qac336Mqa3zQME+5RwD2GUxWcIzDozSim9wTIddn0DFq5ZQLcH2WUIaKsjfoXR2dKexhZbPpliHptlxge7thOHQ3g5q3EwqtdVicLzh5l+cAnQ6WJ3D5QVU9exIcT7jlobbEHh+mOyjcmb9eq95X/lKgcCBmAIbF4hczhArXU+mbuhAxgncH833wU+4g7YhHxn7lNTHYl9YLtUNqBraYZFRR8rnlK9Vfg9u3qoEmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:32:21 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::f071:99a4:121:353a]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::f071:99a4:121:353a%6]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 17:32:21 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next v2 3/4] rcu/nocb: Add warning to detect if overload advancement is ever useful
Date: Wed, 14 Jan 2026 12:31:53 -0500
Message-Id: <20260114173154.1701056-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114173154.1701056-1-joelagnelf@nvidia.com>
References: <20260114173154.1701056-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:208:329::26) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: b440a175-7c83-4c35-f3de-08de5392df82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Jgx3xmFke3EBo3oMt65o/Jaip8c8IiGPrWRqPWXasoYb05VEfry8itgkTD9?=
 =?us-ascii?Q?02j5KuJmOkTMicmZhSlkQHlaKPbLfZLsrUso4ImvgW+g9ulqVushbqcaPz/p?=
 =?us-ascii?Q?PHTOgc7ibzsmis45eTspQ3OLpWCTYs/wwxNY10JDvUyews5YmGeW5eEF1xJE?=
 =?us-ascii?Q?nRb1Q4+IvasP7XRr40HfGQqWGx5u/+kXP6w9KJ094GoMcq0uclJWPmiglLjh?=
 =?us-ascii?Q?QK5oj7A4AwuF7eY1WDxCe077bru9ZERKWxMFNWhU20otzLBtT0RvtAMOQXOX?=
 =?us-ascii?Q?Xm6Dak4vdXmXX9MaOneh2iBZH+qgI7+sGRPjK3zNhBtMjfuJD26tfDQs/FRu?=
 =?us-ascii?Q?YqMEHKLyz17dK/zZxQtFam0L8c3jpVQZVbqvHFxWZH8mLraasWiZgOY4nmRn?=
 =?us-ascii?Q?fg6XNXA95zJ4jFLhjnB9h9dXNQItAo91v+69MNUMNDWRm+GVFTqBaBTkkPe7?=
 =?us-ascii?Q?Q8+cPCVyFhyhHgMGCIqXdWbE5N3RdTGpg775FTuc/e5yujDYhEqIQNRCBmZ7?=
 =?us-ascii?Q?O6gTeJT/DaKRHfOKK8jl+A7dOjql0LSYdsT3/2pX9IgVzbpTAIbBjulrxysJ?=
 =?us-ascii?Q?oK5UsMk9qRohGMciA2pr7ietu2iray5zTPxxY806tlCXGEVERRhWmfjK+fOQ?=
 =?us-ascii?Q?q6t3ZJA7KE+ksITfaRFTjyEU5FciRNdh1SkhPNWHG0JrXp/P7vlNi69fAnqp?=
 =?us-ascii?Q?XZ8UGJrQE/p3dxDrygcXLCPnzjqEV6v31cxO8C1uPSE8vshzitqwjRZ7w6bm?=
 =?us-ascii?Q?XaE6Dn//iMIU8PTF0zgcbVNMssDCLh4TFznQ0I3JNgrPSUdM+ZB9SDjS4X7M?=
 =?us-ascii?Q?SUzVHzAyVDDaj2GHx8qa7gSYKGiZRnDZtqFA4D3XSPkqibEtwblLd/Sktqwh?=
 =?us-ascii?Q?ipEDnEP+6Qk0g3/9uSDavac335ySk+YNcGGrbrCXJVgY4AJsCe8VWdp28Q5W?=
 =?us-ascii?Q?P6inUGvDE9AVgaSSRKGkwdxg6HxKNmxxp+7C5/4F7ob8qiWy197kdLhCX6Gu?=
 =?us-ascii?Q?XWiKQEwplNpwdbucqgDfj7kJCxX7yAU6mVHtUaocBEvlSTKInidZm0n+Wyey?=
 =?us-ascii?Q?I/2GtA3ET/VZf421z4KLrirnejupKwl4+B/1JW5w95ZwuvdGIGxRItGlgcpx?=
 =?us-ascii?Q?Zm77+yO7MRnUnCsRA9ex7/5Zf3AX1uEYuk+v50jiRFj/1oLrdpVmRsptUls3?=
 =?us-ascii?Q?pUNvAwPOT3nP3V/WbqYQUrdTQmpo9NicuQLRGUZa3AxGmPzzOzSrqRBQwgfD?=
 =?us-ascii?Q?UF81f3qEnLj5UCv6Bi1y/C+GRYrHLTlWcrohhz5LdR5nIpZ1hvC/ojcZV2CV?=
 =?us-ascii?Q?4fILXyVU/3tcYl1VYRLoTIuVpE/HpvKSfgk7ya0G8MRlDVb7XP8kYNca4Uou?=
 =?us-ascii?Q?CdrI9d8T3XwW6L0gaxSAsUJ8DrlWsrDO/JgT8Yd7ZUDmgyFm8jXyo3goFuI5?=
 =?us-ascii?Q?C60AcecN9tY/afH1RdwVaB11BE6vDS2gucFH5Z6Sl/pp0fNDLTMFl32xSDJF?=
 =?us-ascii?Q?Z/C2cqFKPoGQA0B508k9ZH4R6+Yt1yhsHnYPufxLNdMVCwjPoSeKh4ZBSN1s?=
 =?us-ascii?Q?VGVpoCRH1AG6aAgbNPM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jx0U2zKn2K0bRy/y8sWNUHHhleSdgCKIldyMfi7q9PWipkE29xq2C7Jwj6sM?=
 =?us-ascii?Q?A0eHAhNy9E6sPTd+wG8NcdoM7k6gxFhKnEii9CPbUqnMukTncc6OuXknLmoR?=
 =?us-ascii?Q?WdCOFpO3ovw0eHx3XRDitfZ24pm4O4RYGkzgrFoU7UW03LRH0oq93YDakQOJ?=
 =?us-ascii?Q?7DbL1+YE7sKCpovwQExJUv17duaXK4KCQgMs25xdy7Q5V4Y/id6RitYaB8TK?=
 =?us-ascii?Q?mUO8eWpEANTTemgYGehPQ/8zxud+o2iiKmItrVBNH+OZSeLtqUVn6E43gdsK?=
 =?us-ascii?Q?XqL0tZ08LAfv8dtMO9+YYJEof2funmF3HQcR72tgJQR0Qh7BQzyAJ5DztSk2?=
 =?us-ascii?Q?MsKbmB+bcJgw0RgcTQcD6U/+d48fEuO8jfM5Mx3ysAlBKGPRt2l/6Aq4fdli?=
 =?us-ascii?Q?q/QLSSq0Cc20kBXizrYUKB1NaVB9zniEXCWvIY20PB4HN0S50QLSoPE/Kk0I?=
 =?us-ascii?Q?JGfRG0sAYcQdQyxbQ4shIi+iMSp7zTOibAzbHx1+bejdvmZFb7tnr5vHQFds?=
 =?us-ascii?Q?rOS6Lewudzo+wCpym57uOO79U6Q+7WVFUXSs7mI32xWwVVilKgv1PD3g7pPm?=
 =?us-ascii?Q?8XA3KlUU2yfOtklHCQlrgUos9xS/kJiz9wGj8KCVF6TlUcvdAjF+iUvwHaPa?=
 =?us-ascii?Q?BifloLl3hmNdqZXBFD9J9VRiJftuQJk+ChJ+iQPPYkw6XT2JoQGvBbodFT3j?=
 =?us-ascii?Q?Ud02cI6xu3TOQVhr2e3hey7f1buHMVVCAQXDz5IlE+qsgT2diPkDjIc524cI?=
 =?us-ascii?Q?hYQx5+D0pkhJfE44DIzbXxY0fSFUwGJgTTnGyU9N9d+q5aauWBYN1JnZBFbG?=
 =?us-ascii?Q?UABVMQE7PwyZAbmAOI5A9GP5ZaoAhzFE3Ya2LZniWrHZuAWH5YXkPJjpPJWA?=
 =?us-ascii?Q?PwzACqsdqnwhuTvkglG9nVQlgqOJy/TiMlClTlWz1DyKfKekGHvlYZ83xHty?=
 =?us-ascii?Q?I++wFTQGbEoDkEZxK5HiHxqES8ruIJESGYC/qLEgIR1elOnApyo9vEaGRn/c?=
 =?us-ascii?Q?WOCTyeci/XVLk9VpQk57uoNmpiMGzxsZCCVz7S91m/9PCkT8NMmHDaUW1Ni1?=
 =?us-ascii?Q?3F6IBvgqE9kBz56FF+x1Le/zZw1DqSJdaplnJm0/3KODsZizu9ZE56b917dF?=
 =?us-ascii?Q?va3J2l+b31DAOLUnkR0KS5QejuFlLqStHMHqkSIEMZYjh4I9KDKQu7uODxkP?=
 =?us-ascii?Q?G7EllgDcrIeAoSlHDhP6JMfnopX0T0R6+IlVJTVUDQcbA747RfbGra2qAirB?=
 =?us-ascii?Q?UIX1c3nXJ1un9vkGZzvhvX9NsEW6qeyifdkRHhxfKAt0dF8SOGWDHaKIJj8s?=
 =?us-ascii?Q?YxNO0vCCuSbKh8TnStFsUeud89heVAbrOdSe2EPZREzQPLy1/n2KwiSLd47H?=
 =?us-ascii?Q?NqqnZpFTVuCy7QJUTdHXsabVrmIEmGF0MbZhsxyAaEt9D3nIqMrzSQqlSAbc?=
 =?us-ascii?Q?OhqS1BwJ4u+jWvkBJQX1eSZP5o0UBLu4DGqzcVIqLo8ulza1iIacsXh4Z0F7?=
 =?us-ascii?Q?IjN1/ymWDBVVTLsPEZaREeIy9PaKsHn2wMRcPAVW/SevkQMhAJmYX8WGFhIi?=
 =?us-ascii?Q?Fis1oOFB1jQV5OgEIOBzV9mYAqcSUmnIgB0n7z+oZN+z8N3hfjtVtkegaV+4?=
 =?us-ascii?Q?FA79LC7ANZFOE/Vw6TU/8YzoboItsvZFUZUdmDBYhek4p9M6EdO/nj74Uz2N?=
 =?us-ascii?Q?qMAdM0+AQqxhUL1CzqRuVL3ABDCQUx7X+HRfRtJjLDD1ut7r2CGXkPFoYlIk?=
 =?us-ascii?Q?GPhQimCkIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b440a175-7c83-4c35-f3de-08de5392df82
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:32:21.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywXTlik+aar8RPcT8f94IRSfLaWrpq873T9X8al9JkjJkAv0myXvu578NW0E4Bg0fd87gZYrCPfGEzRdIzCZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

During callback overload, the NOCB code attempts an opportunistic
advancement via rcu_advance_cbs_nowake().

Analysis via tracing with 300,000 callbacks flooded shows this
optimization is likely dead code:
- 30 overload conditions triggered
- 0 advancements actually occurred
- 100% of time no advancement due to current GP not done.

I also ran TREE05 and TREE08 for 2 hours and cannot trigger it.

When callbacks overflow (exceed qhimark), they are waiting for a grace
period that hasn't completed yet. The optimization requires the GP to be
complete to advance callbacks, but the overload condition itself is
caused by callbacks piling up faster than GPs can complete. This creates
a logical contradiction where the advancement cannot happen.

In *theory* this might be possible, the GP completed just in the nick of
time as we hit the overload, but this is just so rare that it can be
considered impossible when we cannot even hit it with synthetic callback
flooding even, it is a waste of cycles to even try to advance, let alone
be useful and is a maintenance burden complexity we don't need.

I suggest deletion. However, add a WARN_ON_ONCE for a merge window or 2
and delete it after out of extreme caution.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index acca24670a8c..702ede003dce 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -571,8 +571,20 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		if (j != rdp->nocb_gp_adv_time &&
 		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
 		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
+			long done_before = rcu_segcblist_get_seglen(&rdp->cblist, RCU_DONE_TAIL);
+
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
+
+			/*
+			 * The advance_cbs call above is not useful. Under an
+			 * overload condition, nocb_gp_wait() is always waiting
+			 * for GP completion, due to this nothing can be moved
+			 * from WAIT to DONE, in the list. WARN if an
+			 * advancement happened (next step is deletion of advance).
+			 */
+			WARN_ON_ONCE(rcu_segcblist_get_seglen(&rdp->cblist,
+				     RCU_DONE_TAIL) > done_before);
 		}
 	}
 
-- 
2.34.1


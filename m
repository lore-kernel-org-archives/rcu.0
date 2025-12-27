Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4C819E839;
	Sat, 27 Dec 2025 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766794380; cv=fail; b=h0NY3AUA7pirNHqfCUNTgbB3WiF7Au5DWFhU6PERwc9t5EOZmAYLJWDCVJGYlGM31faXOPIIP1/jCL+rZF6QW/V5u5xR/yjGWYv+MsM56Jezgt3BUREgcXFCddoCXnn2+O2nNQd0+w2rYp4EUf59HdjDbkcgVG4QBkYDwQjB7C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766794380; c=relaxed/simple;
	bh=KyF0xXKvBwAN+yiv1dgAfGAxaYaLnKvQedIJO5nqKRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WDyeFLaieB6lnJSwsfBdNyQLhN4L6ZcYzumjKWEh5+KoMkZRDg+Ul5fDVAZlYnVe4bSZCnMmd6MC1/4WG0AiHj5uAfj1btiuJYI/17MlvHFlDFqA9x9T/Ay6mE/l8I7gMz1g2iSYSXdtxQo6A7pWg6eYh6IVRj/Hd+YikuJLklA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YB3isls9; arc=fail smtp.client-ip=40.93.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YB3isls9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzGqmcjmcH3EvJw0Rk3E6Hq6OF98MrBOkp9S5K5xnQZ62RjEABz7NlbmDEYYrkNDjfDqJ1FO/xZT3ODvvwEyPqEH+x4uv3LLYGF5pd6prBAvpjXp1QXugNbe/E9m5N2FpnnNAtaoqrinhWBh+atP9p6rhK/WThQ76ZA+b0o2lsjhTwFcW9mG+xDhC4INPIdGo0z8QrbtmLcaZPbLjFWfmLQf45YyNDwOHjRJzClndorIylW9KaiXopfY6aVMY0eBcD7FDsj3InvYhQnnY2Q+k9Rwmkp6oOKy3tkL5MieEikzP+h2WE86GaF+wb0SQBX0kUBPufsKI+JejH/t7l+hfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//zyC2NyEe7TuAV4RkC3qdrK/3/JJhsjQUiqoQdogJ8=;
 b=NbvUFfydQhxGO5rAnB8/rspWF3FHPclntywu172pHouDuJ0fND9GovOiX8TShI+jdEH5Di9zRwK6+hwhA2XI7jKPT/PAhdArHn6FWalp84Fua2Dh0oqjlGsHiYK5hYGSo1bWyiWIJtn3/2OZZxBMKGJ/v2hcc/7vmSt8ORX0wY8WyYs/zOBuufdScXK9gKZpHo97/IbdB2IQs5iBY8QR7+FQLawiqOgr5jbSx3HjmSQLKaXS8XuqftEwYKci6XHtkQ3/cbFKFcjddNQo0xWyMmhUD5QTgmCSIR3vukyAgKjq6m38EFc6Dn79H7xVzQpxvfnfMMZQZ5xnB6prRt81wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//zyC2NyEe7TuAV4RkC3qdrK/3/JJhsjQUiqoQdogJ8=;
 b=YB3isls9SSrcXaGAbqFY76ewI1cf3FR1UFpJKorpiPGIpI+z+zRAhp6vFtOV1JHQ9L5H6K3zXGmvwSILFunTC2NGkylJQA+JwGh1H8TiaqVh1xJBmoSpKFujP9wo8W7eL7ZYUBF8NFFZZ7B8bqRvfujC/rLtq3LmNRxF6L1pQjfpB0VpjlO+NpeQGNDJO9ba1ODjxxoxmkiXiOaXjo4RdP9sOauS5oX1Ds2PhUmNbqcTLYb+U2Xu+aJxMK3tqBm2kbZacp3dZlL31uRsDErUU3ZL3aEJb4fsOnb/3eIpt0EAb//rWQvc9yqhSVipw5L6PVceIiGweJ4ONSvZo1tOow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Sat, 27 Dec
 2025 00:12:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.008; Sat, 27 Dec 2025
 00:12:53 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v2 3/3] rcu/nocb: Add warning to detect if overload advancement is ever useful
Date: Fri, 26 Dec 2025 19:12:39 -0500
Message-Id: <20251227001239.405644-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251227001239.405644-1-joelagnelf@nvidia.com>
References: <20251227001239.405644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0076.namprd02.prod.outlook.com
 (2603:10b6:208:51::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: d885fcc4-7dd8-4303-2913-08de44dcae0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VIbPiRupKpnV8LMYMBx6rWutROR0E7gLtDt+tgopbbA4b7Lp9w7vosq2oyyl?=
 =?us-ascii?Q?fFcHJxaxLIQdKtDastxl+ry/Xk6m2AJZhRFd+Bm2cAKk9zx3XEPCruQnHGCE?=
 =?us-ascii?Q?EgITKJbfxghdMQPQYg4Shy3zx8ldleSOU1S7UHfjZ8md8Fy2GopAdyllsVzB?=
 =?us-ascii?Q?I/MKHGC5zSZdcarPaKIDoVoSMI4nIH8zSk67SA5RA9ISIwLpuTstHIMwAOiI?=
 =?us-ascii?Q?a59HabHKOP8GiNr57F04kZCviw+gGktILJnIcI8yIAoWDpxgWJitVkuuPHGT?=
 =?us-ascii?Q?9tw9lBUqIBI7lxuHezNOKzKwDsEOjv7JBw/NQZiTK8o6657G0IPRlb8BLcUW?=
 =?us-ascii?Q?LH48M8E8SPKuFrLejcK4gCzCcahJQiE8lDhSlqgTPSX+/S33ItjvySDgAR3U?=
 =?us-ascii?Q?NbAgRGVm2sLlRmWPsGEW8SkaprHwdmUl/SQqUBUUDcw12PeaZkhWHI4vI8J2?=
 =?us-ascii?Q?qPWo48zEx03//l/3bPejGu22z+AYt6ooYib5txnLzGCrnx1ZPy9yAuKB/Ejf?=
 =?us-ascii?Q?WbeOUV3mGE8GsYisHmW7k2DbV8VAHIvT4KeelBczRYFkfpCktoUM2v479dFw?=
 =?us-ascii?Q?/X3BDje0wqGHtBByDEHWuhYr8XaoYq5RQtG1jQJw2QpyMKfPllTyb451DZqC?=
 =?us-ascii?Q?kGpmnysQaf8TJsoRC34Luv4VFHER3kIk/4CTJ8pBJ/0NDdndemWmjAVwguIG?=
 =?us-ascii?Q?uj5M+Vs9bp4QPAEbMFOi5tlFHpmfjSc+3mGWHZqgnKGPzI+/LVefr2JWPqTU?=
 =?us-ascii?Q?35XfwziAmiXm2Yjalaeo1v1ybf/nM6BqALmppCi2WWMl/epimPgMnxUT2FpO?=
 =?us-ascii?Q?nUeFK97FZkf1eXBqayTP5o3qC3PmdIbypUlBl6GM5Loafta53idAFOLQTn6b?=
 =?us-ascii?Q?Jh8F6sM8QExDp414v129DLadUxT/kKSRA2sgRf8yN2RLA6UNmBQafxkOFpAV?=
 =?us-ascii?Q?9GnG+oUcvKfTGZ20QF8ZndYccfp60Sr6DpgZ/Ca9P7+aS6Jr4TBkvwK+JAxt?=
 =?us-ascii?Q?MQBbvIx5eHpZTMtsYvguBfM3hMgrbH9NRxyfxsZk18wR2RrNm6jonlfekQX6?=
 =?us-ascii?Q?M3YeucidZjbAg/V3GQkNXE+Ad5gO1nTIK7UpqvQGjQ++zlPFzDQRvvclhJq/?=
 =?us-ascii?Q?vYWSktIOI9It7G/+6SD9rtGoIdkJzCZpkiPFF9nl0EI9Tj/zjOTeHTkW0bGf?=
 =?us-ascii?Q?YgKiBy2s+7PVxORqCzT5xPFdhkKNodf3BxL5T7uxiL7nn2b6NkiLEDRrGW1n?=
 =?us-ascii?Q?ECsj88JkiUcL3H/lio21DrZbZFgEYyk+854Rtf6wZdaIAIibHBlP8Z6HL5EK?=
 =?us-ascii?Q?Qgopary4JGOToCPJQWtAYK5fE8SD8DTmhMPyR9VQdcEy/Ik8Q9s5NDQQY0Yo?=
 =?us-ascii?Q?QM09U3bH0/7Yb5VxAUWRR/kOyEKkf3+C7OStULwf2FV/oxsE9PdaPw24UFvx?=
 =?us-ascii?Q?yXrCG8IAASEGo4VED9gERk8iKgNn9f7vUbaVmMkrEnjirCR6QwkFwGAYeRN+?=
 =?us-ascii?Q?IGsDuYhXs1Em6Ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PAD5y6H32BcR4o7VJm7UTWziENA7hIlTUyabyKAmrOkUSEgfLBWoZTnS1Lo0?=
 =?us-ascii?Q?BWqTNHpcbMBOqWycXxXxGHW6n9u8YbKnnu/Y4IZfRKxyppVT1VSJhuu9h6Qw?=
 =?us-ascii?Q?cGE7MMKzyhOjrAbDgGY6WPItvHENF5/M3giDp3YQAgVn5TaUQEaqnfGRWf1S?=
 =?us-ascii?Q?XDsADURoSZZDTnElnS/aTDHcbYmF6Ab3hcu9aYvCmbrkhp68C8xb1ZbB6ObC?=
 =?us-ascii?Q?hz65gr9qGTaXfj+wXYBo/ZREZ8rii2XdgPpdF6nygOg2zUgfvTtxhIDb5V5i?=
 =?us-ascii?Q?+H0CfbN3kiTR6lccEMmYpXWiO+KPFa6gbE8wnx8gK87e9hlRQLCPwNEwdGwa?=
 =?us-ascii?Q?SZ6d7ujI4pyr+UGJHmTZDdkDAsdM7osiF0udvADHP+Crs2Mof9eEXmekH04P?=
 =?us-ascii?Q?wTueqC9g3kU4WvRfBRm6qByvDsFBBgdK2J/O1b8FYU+XOAXAA3fA55VabFLW?=
 =?us-ascii?Q?gNvAK/sWvdr+nsW1JomQBcFESzOhRDqTlxbRBwD3tp8EAxqBon81b7Kv7Cr5?=
 =?us-ascii?Q?jHC04MLYYzHj+hRUMRtu7zxOa3QSK2gIAEPzbl4KvWTfm/R4fFbzVi9H9Gkl?=
 =?us-ascii?Q?G0K+HPeau6nOy1kKx5fdyFD8Rm4J4y6o0qvp5xM7dl8EZfq/BDGugBQCw1ho?=
 =?us-ascii?Q?nYbUvIEIyEjZ/1J9ZAgvWbSufA4bT+2B9pHklB0m+e8s20EYBR8aebAPqn7Z?=
 =?us-ascii?Q?VoBPl2+ufE/IXYwqFcnt+wLvawtT7LJZqqLTZS12FHIgXS9Y+cGbETrRZeLE?=
 =?us-ascii?Q?CRh9oi0dGeGbWoufjmkVOh9zzm+lShmT2hBDS/Jeq+pDZyvrgizOK0/hJfQ/?=
 =?us-ascii?Q?YQj0itzNRcaqvJTZ2GifD6DKZszgtBp7geZmj3D5vfGu7zU9wiBRBQKbzdxe?=
 =?us-ascii?Q?5g+anN3whI3dbhB+Yq2VtYLVsuM2YaxLG1QwvBjv9yBDnEesYzzm858G+EfE?=
 =?us-ascii?Q?El/li+0NCTTdjE6yUtFuUz6J/q6CS/FE+KsDlHZu1BOucixDtxeku5Plkx/b?=
 =?us-ascii?Q?DnDZ6r1DJYYsQIPyb6J91pf5xSRIUyGjq6CvAc1NPwdrcIDj8yd1wo1ic/oF?=
 =?us-ascii?Q?4FHf8gAP9O/XCFx9MidY1Ex30TldqiYCJG3f5Lb0bpxAgAMcJHNebth0sej4?=
 =?us-ascii?Q?4EMH66DKkn3jOg+pmoHPj54EeIHsiNZTOXSECZTkeLpSD8ehxGN+dt0XAoxh?=
 =?us-ascii?Q?Y6esKVqKnVEjcXSX2bId52UobMM5GYOijVD6BfJLifQsNxNwRqPKezt/R0qY?=
 =?us-ascii?Q?P2NBiGPRnC37ydQCKn/Hq+RWPHMTZE1YQQfeh0Tl+81lQbPHxgoURTxIAbqY?=
 =?us-ascii?Q?DM7nCQkxPw0oUlEpqVNLI+FUiZZqVClq79ekgyH1RoD1m+LKb5Lw1MgRDYxc?=
 =?us-ascii?Q?PBNJshuy9RNu0Xsu60NjIsfmCnXLGaWQ7FvjdkxZXUIv4ZRT+WwUyMOzaZ98?=
 =?us-ascii?Q?31BzULTQzTqYXp9uHqXkVhBcsrBsiy0i/SGYRTeQ4dOYSIV/YJWiCNEZzdYV?=
 =?us-ascii?Q?foybQKw1OvR670jWCSI2uOkdYi3EQFh7TQCIyJ9O8Fvq9cvFF+2MYyYU/cdm?=
 =?us-ascii?Q?/CD23PAysxAwd5qx8xcUB9oRC1a5fMwRVSScam9+wBJi30O8B+EmrV/O9TdX?=
 =?us-ascii?Q?7GJvICe2AtIDtSSkqA8adB8UCBCSmE8q38BDml0+IUtwvBS+jthfU480qvY0?=
 =?us-ascii?Q?kijRMnj/G1G65imfelkmmaPEwyam7VX/Eg+6YePGwq6ZJyW3SVifh2MqcGYf?=
 =?us-ascii?Q?NubrGdN0Gg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d885fcc4-7dd8-4303-2913-08de44dcae0c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 00:12:53.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fn7m2oWD/21AZpK3nkGC3xjpkGipRQ047RVGWI+Wbub7yFfAqLraRgT3nAGN9dyMGCOb4PPIpJ3jMYLWqNB+Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

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
index 7e9d465c8ab1..d3e6a0e77210 100644
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


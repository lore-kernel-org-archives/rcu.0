Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B235E221DB9;
	Sat,  3 Jan 2026 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399855; cv=fail; b=rAHsblZIQG9YT9BnuGhR0R40JNdYghTTi9tWHVeCpdj3Av8FeZSfZcHkwCAKRLEEOpwkduhxAqvdqBuvDOSpEo+5qugYUOeHhPGDv1a3+WIQWXWeFNtCsKsGN94tosv0viWoAzyPr+G1N7bSzRFtEsX6c8rftvM24VpuDrPLTSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399855; c=relaxed/simple;
	bh=WvbXjEMy8QsIs5sGAeuW9GMNfQmjUUYd+FRZjaOGRgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cz6YuPyBU5A7VHk4idYuIB/3sVXQAl8Fk+qKb8cYd3m+g4x5sxgWe7nPz7CEffsdiR2BPspGvGhHXGS7bUH8X6vb+lhn8uCECFslPcDPlt9eIDnVtHZh7By2Akvu5Q602x9ouxcGMhpsxNsWUpnk14Q+YdJq0B3/+0jaWm/wtyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ux6Cdj+l; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ux6Cdj+l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzppuMBtB9LjwlKQILWUacM/fUv8Z0z7jMpS1UVJPgjB7Q1X+SCYVjZHqiblP2+621TzNUR1nCPqf+7V6otxoRMHNQzpCu/Ksv4KJRKJwWPWt9nVBg2WtIk0IB2qHo6EU3MZD9cImvUBBcvI//oBsUL5rRPVF18DN1PArOwk9jKNdTgZ/KSISmXsH8pk2B0tYr70eijoowGdDGImewoNTZfU9ikehocAwajAuk7dZN3qHkSOtLjjp46syuKz3tVW21Uw/d4B62MzIBTwKM/iWrrvbYBDl4vG+TGHGfAdoJhX1Ol0gMLsEWjaKXWO+kDKVGDk3XE3e6rurxcfs0GlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HHUbotGhN7nmfwLlZe853APgpUr+MDloD9ZjD/nP9M=;
 b=PSD+xTEq9E4KKEEDDTHPpIRbLE5w9O6VvMQ9ulCiAXw0yJVi78jmXa3lIDN8+MqtxBm46AuDn54MkoELmV5d1iagtxJ20bZrAzORBnK7yTrmdWfehBU2LnAOkYXqx07h+ybGrBd/1aEKf1ynaRP+Q/vpyWp/oOEJczM/r9HSWNks6MDqv0sETL9FJLPPp476k+v2flnaufR+nXCXw1Z076siXw9lzCs5ve8x9fNMg2lR7bYGQ56jA73f4hYT4xClvqTTt4CDHX4+yc+dcs/cnur81HbJUNO0ElWjKSULPt2JOStzG6AGtdKL6FjKkTXfxnlSyuwC9mtm4i2MssSPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HHUbotGhN7nmfwLlZe853APgpUr+MDloD9ZjD/nP9M=;
 b=Ux6Cdj+lshzIkh0gLoVIGy7AMVGSiH6LYJsrwtAnJpacwq8iRQliq7wXX9PaNnUit6f/tMyVkT3Gg5AORiRqXWQO5DKbXA4i7cwN/GZsO2emdpZAZLlDGsmNDj5n137xMNdO5DNB3QYQg9kX+BfkwBmGolDIKarC7KiCrrgoVnb5nYKZZmqLgjGswmY0oEuif+Rk5+HX5JzIBmK42zz2CC0TBVSawJSEfmp2EWHDHEVPWMv9sGTXLwbyrPX8KyMSeFO51VIXI+AHEZ/VjZFvLuAwIfG/4mBzJOVjX3BHAtR4H2jy0Lh7dTV0KdPC+pCmkKpMdgln95o1Fe6npednjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:24:07 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:24:07 +0000
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
Subject: [PATCH RFC 08/14] rcu: Promote blocked tasks before QS report in force_qs_rnp()
Date: Fri,  2 Jan 2026 19:23:37 -0500
Message-Id: <20260103002343.6599-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:52f::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 026b9a54-23b5-47dd-b49a-08de4a5e682e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h8W0nt09pXrIFWAZyZgAY72hsT4kYUsXgdxBDmwYM5dsUEpVWptLMQnavPiN?=
 =?us-ascii?Q?DZ08D1O+nMkXfnT05vhKVax2u7wMVuaT+cpBnhREfyDJG9glnJpZ1IBw7j5R?=
 =?us-ascii?Q?y9xTTg8iF9LF52l2LewcwbodiMHbKfy9j/bWCla7Lw7opC+fpB/vH4wS5FaW?=
 =?us-ascii?Q?YyBysyb4WWPkz0xHYnQVcxRKPVk3jXTYjm+zKObTFivEXyV2waShmZ+wsdaX?=
 =?us-ascii?Q?EIiQxwurDN8lqx5DGYqvAh2OxeENmTN1YNxsmnN0TvLi5tp1DXTytIIQFAiE?=
 =?us-ascii?Q?L0WbWiey1vjwrz+fDUGtzro3pE3bcus4cqrAaPfR6T7erbQYER3S8ojl9bVW?=
 =?us-ascii?Q?hd9CTQq1o9zcCGqsTOZoeE5HEPHjLCaACH0QPwzwaUh4OaqPgIxhdy3/OYQP?=
 =?us-ascii?Q?k5R6+DKeDoesVFnbJ+6Yhqynmk97VcrNBn8opci6tpCtbdsGHQyzdVTvXNml?=
 =?us-ascii?Q?D6vAcu7waO8Q9ES1AI3RR0jdrhSOA2FMgDGsQ515qbSVLrF5ZEcFK/lQELzi?=
 =?us-ascii?Q?DBG+TpKumJz54gmJDpHIZULIZSiebrWafa6xnIgXtjV4OgGbCneViHuNnqHS?=
 =?us-ascii?Q?9gmVGWKKgsRnFZsEHnajBSqG0qMDdLuJUiedq/cJkYzceU4PE+4nb7t8Fo21?=
 =?us-ascii?Q?0mb8h78LnYAvW4Qwurxf+Uzr1F+0wKgm4SSm3OPYJthsSWPuQdsfMpjjFNfQ?=
 =?us-ascii?Q?MOQTHPvUlTVUSiYpMI1qdsZVNG/dHI55Hut7AVbg+lqevaAa+oEXe8TnTCDS?=
 =?us-ascii?Q?nHl2i9uo5uj0mr46VAJiev8YhqdFL7BeupIZLrPOMdLYNTSaXD91jS3xIHZ9?=
 =?us-ascii?Q?VO9ueqbI+UIVjInxC0BDtS4JgwdsmF+/6tRafVSVRuPBZ451H3i88Db98ER5?=
 =?us-ascii?Q?iPJO3OgFqTXNUhggd1nIfD6Uil1q/PzGXjMioks9+bKIswtbDfVQG5pc1OBc?=
 =?us-ascii?Q?EhZn4Cv7M4M4tOLqrb94LnwTZhvWHkWeVVBzNByzlKdaKGhBnkA9+OmybdOV?=
 =?us-ascii?Q?9ZA9PmNbdE2O1nUkMsnXbtGh50oV3j6RUTj4d8GLBuVsoA1b7eN22yZCtyiZ?=
 =?us-ascii?Q?LXTiufcmSw5KIyORjLS7o51b2pop05SyyUejXGKUDu7z1rA1jlGALRxHzk8w?=
 =?us-ascii?Q?3VKZEIVJ0X3M5G3evlp3UI0FjMYoSSMgFvrsxemnSHrvozhd1TjIRHWHoMft?=
 =?us-ascii?Q?4KeDVAGxm/e0hrnGAHyA3hzimVgtqimD/ExvHLYjEmHBzn3FAgDUTSinAWWE?=
 =?us-ascii?Q?5ZFa8lhqRI7E+4Cyy40QULt7/pF/ZuwrCu4PvQnYrLQC9nhVI/Ndanjx4ePh?=
 =?us-ascii?Q?ix5LWl1CW7zyIk5Pomgo860AR81IRlnS/PnC/90BAcz5mkIs+xWUXr8hs6XG?=
 =?us-ascii?Q?gjCRu1uDehnXQXIG5AQCDut5d43xDddMAud43ziUgmGDSWx2pAWMUC5Eb/1S?=
 =?us-ascii?Q?TZUNGCOg6iOzTMuvLjyZ1KAE+dgcqcqt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5HSAynQkSp/tOXXIXXUMxgmCnzIKF7W4sJLLjor1hM1paKCadKc7GlJ8DnTH?=
 =?us-ascii?Q?699X1fpDUP3oT0sJs8wF4QF21oL3itHMvZo7kViTuxsjBBUddB5M6L1QCzjI?=
 =?us-ascii?Q?3EBJ9fjeGTgK5MKUyBh7Lfq4kLbOYZjY1KoOcLYLKzQ6g56JFWMxKF0O3Tt4?=
 =?us-ascii?Q?48dHTKSBaI5doAOgGJMPmaBauaBoMhRffaQ5fTZfhrbIcOd3jjZWfI3k/2Uj?=
 =?us-ascii?Q?9u23CkuBJhyKF97QOB7yC60ld4pB5srjxOeQM4ksy9X9Zu3scAl1aU2b8bqq?=
 =?us-ascii?Q?gsPZNlm/FA3MzwDm31xVZOUxtpLYCm2lApK7WSxuotatKv8sYvdDYHhI9+BM?=
 =?us-ascii?Q?vtgwy3+ywPP+N+dzr/C3c5D7lZT7tXxsabHt/vPQUGbSDgQHh42iTxdGUl/g?=
 =?us-ascii?Q?6MqhvVgyXXiNwZ+YJqy/qVDdYMRrSWYVR2FUjiWRKQtkVM4LLOEX6uJw2CbN?=
 =?us-ascii?Q?Q8Ho/jT5q2oGDTatvheOWQYM43xSRpwfUv5pGA4cPxJE3yqeGpuoAQcHIveV?=
 =?us-ascii?Q?x7dPpn/hN6HuGOJCiQP3uWZF6c7bhFpoR3Y3xLqBkuSqon5zOKd8O3omoGBO?=
 =?us-ascii?Q?J7H0mNUotRN/DxrTY6mkD3wm597HR/dS1CM0LC7tDo9G101//Tobv867Ndt8?=
 =?us-ascii?Q?bdxIxpOQ0uZgNNkzNWC/wdaRB5RrNYvvvCATUtaALsmx/vaW2dECHkDXpgG1?=
 =?us-ascii?Q?X/0hBrSTJcPgrS1AkYWY2Y/1b3sKk4PPTjD6/MPog+7rTEs/v0jW8CRWUBqn?=
 =?us-ascii?Q?VXsV1v1rd0Qc9omLgTHUKhxsVLyvnHHfennh7e1XutFUJ1dJdnzdA11hjU14?=
 =?us-ascii?Q?RAMD3VPHVgi9sRgqoRrek7rFaKPZWiOUkgQPDIeXy1xGnYX02JY17gseYqIf?=
 =?us-ascii?Q?44VgYkkYXl63UoL4tODp29kYlIlpS87FivTnom0F3bYxb8DjZmmbo+Vp38xI?=
 =?us-ascii?Q?mTnRvH6vAHrVcPaQXzQNcawJx+WMCyNuRtTTguxg4wW6Ic+OIEIuJ8hn/Igx?=
 =?us-ascii?Q?njao4aVpyblH7u1fuyZNqDw/QCf67zUZalwtp5b8Wv+jt2wNf5hmMj8d2G7v?=
 =?us-ascii?Q?brJbRrb8BNLiAKcXgwaNBnUqrGWI0+5T7ZsVUSOnj3CSJe6KInWdO1d/WTGp?=
 =?us-ascii?Q?4jFL1xPzEjQwrXifdviBVoUq9OngsVBn1B8Yp8m2jK+6zoppwbnA87yYRexq?=
 =?us-ascii?Q?sNcriaUQSyCNNRbY0z7jDdOYKK+PX+zfDADDPX86Uqn5FhqbIKu1BUSlhg07?=
 =?us-ascii?Q?h1q2/AM5Nb0hUaAnJPWOTs+wLp0FfG4qXjI0Ow+UboBbQJe2Km16ApwZCU8d?=
 =?us-ascii?Q?87YV0cAjvjZm4E94Zd61njNyvt4nPhPi7uGDCJn6DHMd5yYKtf47zdnaZEtl?=
 =?us-ascii?Q?+SzEAY+k/tK8wIwQ0qgVFwMGc18dqt5yaq/PVo1EBGwujwjmvPN655n9HgBf?=
 =?us-ascii?Q?KfQ07mBVxxXsJ/bTFD5aPG4Riz3+pvSQ2O3kNn5Xmoo4/d0Ue6kMtp3BomjK?=
 =?us-ascii?Q?61q0Zr1xncz/PrAUeZt3SZ/QtVfBqbsYWIzygn9uXNi5IGWI3vxY+MLAQyJO?=
 =?us-ascii?Q?6mSuhe+EGGVHYTKseaccueLONnyxG+Q9CLwNdIULdbFNM6Arhaw3/p4I5sXF?=
 =?us-ascii?Q?DhGdaoxmijpSfiEwTNg5l713fRdZoi77MeYvrVe2ff63Oe2IOgTq0xCOQVMr?=
 =?us-ascii?Q?XcMCOdWh0r7fix8h5YMZYkvJDHpPjF92jPGBoeS+9jS2Rms86/lY1VhodvKw?=
 =?us-ascii?Q?XizdAGqJOA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026b9a54-23b5-47dd-b49a-08de4a5e682e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:24:06.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFSyDmvHgfir+kOUo6Q4Fiqj46jnie4WIoNa4eAMThfnjR8QYY0PKSo8IusetLyHpHqhXoyJlmSJPCWZJsUi3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

When force_qs_rnp() forces quiescent states for idle or offline CPUs,
any tasks blocked on those CPUs' per-CPU blocked lists must first be
promoted to the rcu_node's blkd_tasks list.

Without this promotion, blocked tasks on per-CPU lists won't have
gp_tasks point to them, so the GP machinery won't wait for them. This
can cause "Wrong-GP reads" errors where a GP completes while readers
are still in their critical sections.

Therefore, call rcu_promote_blocked_tasks_rdp() before reporting QS.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2a20b1a8c5d3..19fd13c1e6be 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2790,6 +2790,11 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 			rdp = per_cpu_ptr(&rcu_data, cpu);
 			ret = f(rdp);
 			if (ret > 0) {
+				/*
+				 * Promote blocked tasks before reporting QS.
+				 * Otherwise tasks on per-CPU list aren't tracked.
+				 */
+				rcu_promote_blocked_tasks_rdp(rdp, rnp);
 				mask |= rdp->grpmask;
 				rcu_disable_urgency_upon_qs(rdp);
 			}
-- 
2.34.1


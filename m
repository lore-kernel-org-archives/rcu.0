Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981AB2DA749;
	Mon, 19 Jan 2026 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768864354; cv=fail; b=ui0kAyYJQpRhGG14t8tUyqDIzajmUHbwlMjcMvHiUxg8k9kzfj7AaVsdfaTsNSZHrUP8xTcXWSjMxLjo4ft7EqVZ2UPvuSK7t2qtwwHZfhMZJw0vzkChmHAU1gFdS1ALBGszVSYoBg6KzPTggDPZ/9RSJcbluwu2hZFXA71IGlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768864354; c=relaxed/simple;
	bh=srBC7XP9mED593MWDYPFgzXKaiBbdE3Eg3kA9wJa+Jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sDP942f2LxyolGwPMCcBVN9SVe+okakanf83r5qjRB3WY9Q4CCqWd9UGgJ50B38XRAL+TDxyTkLVDsBdKea/tRQBLtOGxI/DRbCoK49EgPgLMI/ZZnnHazH7gFLzPr9Is5+zl0ik/WdeUus5ehkj6AHvaHa9BCZ/nNvwbDUcmzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hhvvXtC7; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hhvvXtC7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+/iGzX3f/RvR5YMzJSzEm6Nf5QZmXkI1n1MZkW6KDYky24WGx8dLo56IgSrvYmDE9zcGC12hH9bY/NtXdmAlhoyYGY76gGNte3BvmGfHauikxfYXDw5SAVPrqUvrAEGp+AofM1cdh/oS6yFzbWR9swhOUxPnXKDuDwi99rs9YrlhRsV5CB6higIYg2fI9vkjDTaMxNpy9c5kJL1tCnKOOlY8HEbyvjZMqtAwNjhmQQSpyiBWLhobqqIMRwkOSQWAyKHXRC1y11dnr9xs7/HzC4TicQusIGW5zqQmqKNmVJZL8hciDmn72YZKeK/23mJZY/mgNHl3kgqNjYfnZUFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcW0OqbomH3vjXMSithCbJ4DqfKVE1Rk2swn+kr2o5g=;
 b=GVLA9wS0KdVb+VqpkrUQL+o26mQ2gVXcCm/HNgGQXINVClHYouUiCTB2Dro5zY2r4Fnx2eLGYD3E9mdtSoXHvzxo7Uqv8+g1hi0EiGn+CtGsOyS2eNtKcVuFrikMqb2TjvB3dYd5QZXeS7WCBVGb9uxYiv4vH0WjsKLcOAu94l8TmaGndT2JkuFh9rg/FjIP9x8CqkkTvOW4w2o61mgI5U/kQ5E1xTQql6GsGYUVhX3ylmKmElalD4weA20XV6/LSGuoOGi9kLXjqP6sa30flnJuvz92YXhMdT9iyEbrs8W89fvG8AN7/8klicGuC30l6yu34knHuBX8Q7TVbBKe9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcW0OqbomH3vjXMSithCbJ4DqfKVE1Rk2swn+kr2o5g=;
 b=hhvvXtC7T4LY4o6ZqJwb4g4DxN0sMmiodsKh9ON1FPFK5dYrwOUHSXxjRdZ2RPmW+UFPurJPWZ1gV2V05PkoeU7FzOujhYoTbdVqsOwYJ2zcAt1mXUjXONDgpCp+TeCwqq2JiU7kqupWqP9ToU/dZCVqS5nNbBSDdL25paPM3ULIX6Na1vxqhqMnJoGRfgy8oc/LTxGlNmGoyPSoIS0GInpTNWZF4Xs5Ylb4lUQi1h2zEavNXfMCcbK+WS68Ecch+90L1GzuOuaKKoKgibt3RszLhbyEklVsbb9FzQHgeNyA+k8nr0UYTTRFksyGB+n7TgkyF+nmcTzYTFlUgr3rtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.10; Mon, 19 Jan 2026 23:12:29 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 23:12:29 +0000
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
Subject: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload handling
Date: Mon, 19 Jan 2026 18:12:22 -0500
Message-Id: <20260119231223.989409-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119231223.989409-1-joelagnelf@nvidia.com>
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:208:32d::21) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: b2221631-e9a4-4ba0-d7b3-08de57b037a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RtI91XiFedaPcb/PHjLw30hNR5fGhlufNXOSh57Mr7Xfe4cL89FPEnm3H5G9?=
 =?us-ascii?Q?udZ3USMYN7OP2IdypLn1kUa7CghWy2D1X5bOMkB8I9PU3s6mzZc5GTLj5hMo?=
 =?us-ascii?Q?GG6atp41R35X9g+W35xqAa1LdYo/4fFrMM/TUvgZZEtlCBKpiirP/oy9qkQr?=
 =?us-ascii?Q?rlIFTB8s3PW3xBVdkul0yikL1hN4EPr/8dUGKi2qo748TV5jlHtl3+BvVNLw?=
 =?us-ascii?Q?HuSebL8ppgrFUqp9Z70k2poTOTSdOopH8LPzyDe17D/4S8AowyyHti49sl4M?=
 =?us-ascii?Q?0jlYqkfhlq9YKpfS8bx5BmXcFV+s8nfJmAcke9cL/C6FSkFEmGSX7eqRPHfZ?=
 =?us-ascii?Q?jDt+pKzCM5JMOxrzYE5Awtp+csNPgV959GlFh9Z56Mkek5fLBy1NLe+FpOhG?=
 =?us-ascii?Q?yUAr696PpTYemA1w1bXwlKWFCV2yRL9hZkYUMr7ot38vmV3+CcPCikJKwYaR?=
 =?us-ascii?Q?oDrJVQ+vh9xN1+9JV6iUNjoL0K41vxDHiUNlFO9ZaJVihHSanyENCnN3oo1s?=
 =?us-ascii?Q?M4uVxTmXEeMsFwZprXVQK7INz2qM2u+lwj78D+vHheBGHCBo0X1RNpn1ymDe?=
 =?us-ascii?Q?oUIMmzWNZ3ficm1Uweb5X5bXCJrlJYAStnQM1f6P2wvCcobRHWctOyGnDLIw?=
 =?us-ascii?Q?stpqTTGZkUkH9kSQvclt6iWdrNs6rOcl/tdqrhqCd+g8IjNjND9jRE5bW/SE?=
 =?us-ascii?Q?MCMb3MH7hRoiCiTXyDFVKeYIP5gy/BYUTMRRQjusdhw5ZsIdlpXkOR8iMif6?=
 =?us-ascii?Q?Q62WFSneuoOrC4YfqI2cKing9iX9FRqceaqbMr+0nMX9Tn/+VnUryDPWBo4/?=
 =?us-ascii?Q?99m/lMizwaToEyKRwjKM6/dFEcjLl+PjAwgy8SehPoJPd0XyTQQrR2TeQC/m?=
 =?us-ascii?Q?BPEBeUSB2zdWjL93vQ7ugP8U0WOUposKcWwOTGd3bFkFkDHnVkg2YCFebf9S?=
 =?us-ascii?Q?OXKESmHI3jFZj9urDanU2Xu9FIhbwA4nKECk1kAkFwpTU+4xUuNR6TPHXByx?=
 =?us-ascii?Q?N4796Ki4APvNmdlvuMuvvDYvo7oStbjbKn5nPT+ArlUbJYlylgZagSfWlvHx?=
 =?us-ascii?Q?/2kuvaNHNPY6LQZQOHzfmNRxzkWT1iPU0y4tFsQqB4VWxDF1jU2dQPLCgS6Q?=
 =?us-ascii?Q?vVHAUG9/OHFTjT59Z3jOOn8TMh7UIzgajWKxhXTnRM+AyN9BP0/pJ7lxnrrj?=
 =?us-ascii?Q?DIRcDKHXmlqd39JgSreqekplHxjH0J4sjglFqfjnXcJTrrgX6ypofs2126Xt?=
 =?us-ascii?Q?QGSphgEUgMCs2n5KB/wOyx8YrSorRAZZSqmcEaM6LT8/WEGWWLybcMj4MWf+?=
 =?us-ascii?Q?DwUKUUxhhGhA/1QbnM91+QesyMtKwRTuNw1iyWbqOxiH5iGbzwsMO/cZGcU5?=
 =?us-ascii?Q?AxptFDu4pjjdM/1FqWS0f1Ioitw49YaphhbMEZwXO0sAgWF6iqrD7UVqjjNj?=
 =?us-ascii?Q?JEK6v7jFur5le91CG70XIhlPt++n7J5uRf8frMuNqPMsoPo6CoJvbSh9s7FI?=
 =?us-ascii?Q?oWvXhJobbnDGkbCb7kbDNysN+/r6y1yUpROb2eD3AW72uKtrbgLZIUPuveJz?=
 =?us-ascii?Q?YyJVahLH1SoTlo6hnBY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wLpdL+TDbelsJq21PXr0aiphSoGgkuAQX/+wuDkz6NBDIBmWB1L28DafaiZ?=
 =?us-ascii?Q?vixqE2ZhDAepcYQs5An5R3HUuhcatlONle83RDSpfWMdwWqftSiUxI4StjwU?=
 =?us-ascii?Q?xcdSajL671BfhYIJc5rmeziFz8SBSzEUwGclxZ4sn7tiYCJ10IXJT1E1E5q5?=
 =?us-ascii?Q?xBvJHVmDORBzPT2FhaTj8YPh9zuunRTeUKos+F1JSI7A5SsOEPHWxgcs/Bbb?=
 =?us-ascii?Q?I2nl8L2G0bzyir6c0SQe95oC0jsVTXLQ+bjdgNlvPiwZJi53cSyOE0Tr+iFY?=
 =?us-ascii?Q?fv9GZvMMptJLL7qyZfWCp9Qxb84mGzgupere3CmU3WVOPekic04Q8bXYR7pW?=
 =?us-ascii?Q?9szpti4mPN/cMbT2VB0RJrCHNHmNasyFta2L7SboJ9X78ZodFs2Q8Wr3txGh?=
 =?us-ascii?Q?EbWeaKwsGu2GiEe8X/vxtcThea83qUzpcmXYMZFwJRngmWQVue6Ud3isZ1J7?=
 =?us-ascii?Q?PljrfppeKseIZ57lIvyRfhPonrYAuDWSawoz9Ek4TxWaBcl0yLIP1JQJMggD?=
 =?us-ascii?Q?mGejpCsLiHMuE7XEseqbUUyOl4VbaC3LTHAtpweFFiEGytF7iHkcRkuGlqjQ?=
 =?us-ascii?Q?8YWZfmFqs6NRCGGcqKqUh6RIQ2Rt/0n7bVC5J7EU/8kh83cgI9z28l8Czz1h?=
 =?us-ascii?Q?b+G7GbpaC2ptGDVcmHcYJyfuNIS6nVongPNlR0fzLAAGFQjIZubzS6Is1FCg?=
 =?us-ascii?Q?S9Do8ikIArOIKDBYYW22IddVqsQVXPni8jUrrJeCdugrLUO/7P0w8b7uqQbL?=
 =?us-ascii?Q?93ByiLdNwh62y7fhbREii8rNNGVKWmvCCSj71Woht+TiwJ8AJqbTdElGx0tY?=
 =?us-ascii?Q?EXBYWrkyx/IldMwHHnHlheMEL4yRVCxK4IvkHiW0esWgA0cHAootvnCe1UJj?=
 =?us-ascii?Q?/FLuZzM9+xS/QWyvlXhOhZSV9ErTd1Ocb6VU/pikkEshFyN4+2IORDDQuTVp?=
 =?us-ascii?Q?3AbpBrZk/JewwkSqEoahup4OrErLjz56YkU0jkYi/g9W+bkVaAET2LZKZ3S3?=
 =?us-ascii?Q?d7y8Elu1XX1VKYmVN+SDMvSCBXxEGUy0x21YxbFpA02+nk/jBYyoe1KA1TtW?=
 =?us-ascii?Q?o5GHlQJOsnwStG8VuuwhueceF7/gST31EYxov4CM5c73vst6LJjyOH44m7CF?=
 =?us-ascii?Q?UKwLTjVPvgDdiqkwVFK+XpqE/c3q9xwfEGSSOuqZOJf6HU+zLwJXgRqvhxEv?=
 =?us-ascii?Q?6KnbaEihcTOpg2P2+vf/kgujJyXm3AQSykifjrzvmNyjEijJp8dWGUFvcxiI?=
 =?us-ascii?Q?kh71GKAAFkJbHP/CAWf5HossREZD2J1JkpWFzl6ho43nMAAJK6GnN+xqwVTP?=
 =?us-ascii?Q?qdSz8tKyqRy/F2viQ/ZkVM1JERJnLsl2RcI95frtX3OPxbe+2NiowPpxbT20?=
 =?us-ascii?Q?BtQr0TbIw2WrDBgA7WPBMwbh4Up7YpAeJm+aLXpbe31atyECsY8DDZsM1Gyf?=
 =?us-ascii?Q?N13I5Icg1cxfjNzzJ2p+RU2fB5HadT6ClTCMYMtOsgcsMgx9+B4xhT1CrV0L?=
 =?us-ascii?Q?XUwxtQ7y5FWV6aR72FEVzpanR0xaBx7ad0s9SLtD6/acEo2jTF9M0U6Le8is?=
 =?us-ascii?Q?LRuLlzT2FIIUUVsI+t918qkFeb80aFiMX0ijzP9s8fHxfJRZ13PGsqSLnAkU?=
 =?us-ascii?Q?Hd6EWJSBkY4qdsN/r0rkn5hLC5rIVh5aAddHpRJmIkS8jq8WMQ+yGKVlzHZP?=
 =?us-ascii?Q?f/Y7sOlgs09xAOLd4KDmdsojTaEIfRxVQ3cNJe842J6NMO1q1B0Z7R+h/Y7k?=
 =?us-ascii?Q?9FjJCw2Qug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2221631-e9a4-4ba0-d7b3-08de57b037a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 23:12:29.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0T30KFd2MnatOUrzDlZSAVpxNIus+K3TiKKp3JVYMmhRdcKNtNjTMr270fbcfIQ3ElcvYf5wF2AD2FJVQ/uPGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987

During callback overload (exceeding qhimark), the NOCB code attempts
opportunistic advancement via rcu_advance_cbs_nowake(). Analysis shows
this entire code path is dead:

- 30 overload conditions triggered with 300,000 callback flood
- 0 advancements actually occurred
- 100% of time blocked because current GP not done

The overload condition triggers when callbacks are coming in at a high
rate with GPs not completing as fast. But the advancement requires the
GP to be complete - a logical contradiction. Even if the GP did complete
in time, nocb_gp_wait() has to wake up anyway to do the advancement, so
it is pointless.

Since the advancement is dead code, the entire overload handling block
serves no purpose. Remove it entirely.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f525e4f7985b..64a8ff350f92 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -526,8 +526,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 				 __releases(rdp->nocb_lock)
 {
 	long bypass_len;
-	unsigned long cur_gp_seq;
-	unsigned long j;
 	long lazy_len;
 	long len;
 	struct task_struct *t;
@@ -562,16 +560,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		}
 
 		return;
-	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
-		/* ... or if many callbacks queued. */
-		rdp->qlen_last_fqs_check = len;
-		j = jiffies;
-		if (j != rdp->nocb_gp_adv_time &&
-		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
-		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
-			rcu_advance_cbs_nowake(rdp->mynode, rdp);
-			rdp->nocb_gp_adv_time = j;
-		}
 	}
 
 	rcu_nocb_unlock(rdp);
-- 
2.34.1


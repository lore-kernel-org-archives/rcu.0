Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209E1A23B9;
	Sat, 27 Dec 2025 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766794378; cv=fail; b=tK9W7C9twCXBWkd1XWKtTojSDfzBfxPg6hEt+RDVS5e6nqpzxpx3o3b1/SiB4Ea8W9WERQVKc0V6mBF92fQzdEqjx9+5rWK22KlM9luUZPpPlMbWPkJI7EfBk87ahwSc79OcFYHkSWA79R1BRv/1r0eudW3jzo1zwxanyfZe9aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766794378; c=relaxed/simple;
	bh=MFus641xH/6T2aWEyS9btTrPiAmkv41wi3m9ZMJV950=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IIOZJLN6QuUtcsYnKlesn/fL49KG04Xf8dIpt2/ABMpDCRNON0BCexQbRpdg7A2E9RPoQcwspKDcoZVjXK/+SpBMsQYJX4OFPWmuFbtpq+U7OskognfSsi7lzhmhdA+4frXNvTi9RVeRC2rF7zZwAHgGnxU4wdQZj+5ODrXRv4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mmvG35UK; arc=fail smtp.client-ip=40.93.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mmvG35UK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtOrF/r1faUdxVR06Wua1YuFw0lBza/ucEoMZc4BxRrn9vHaTGW03pLse6jKd70NiZx/8BoKQR4e1BxTT9UjRJg3rHhmAjlNRTZjz+3+rDEsM7FsGMtYWO4bynnjHeLD0i6urRSHuVzROS83UgqoZqA5pOOoAUUAWlfCIykylg0SCNrb+gFSXrn6AdkAaonnVGIp1y8tbJXQS2QkWjHvW6E6yTd8QcfTLAVGKeIxRpGl+P/sopmBNWNVnxm7fSBj7n8zywQ8vjDb7FffWrdNEypSVS2F4obS7UxN+GRInVrqjsHmlDyKkWz00V3nVVBkJ7/Eud733SlwzXrekQGtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeKRYCea2b4xpPa+huEYg3dsv/kSFzdBlk1JVHmTQvQ=;
 b=rlAazVmlEZZ1T7K7MLAWX62x0+mmy8qLmBYG18ORnY4QsCq8BMwfXoQRQbYzcWzSs8/pCU0bdCUc0S9i17b4DcUAjsZfrydREshrb5Xrt7APEk+E8aaNxAITmE0hWLH9AuhPbB0Oy0Dv2eirHU6F8W1N7cMYPBeS1+7S6uL3ktI3Boe8pSILmGpQXQo46XdjeZJ5nZJwg50S5vrowe2GRagLejOIdZO1Ok66JeNXzgmdUlmMXqmzibIZIhY6XDmWQvjglJg1cOFs6mva31snt9J2M7yHPHACY12KyISnD2L6TOPlHzXTf7pV2UKm/zPgAQd+id15FyRRdupMEvOlKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeKRYCea2b4xpPa+huEYg3dsv/kSFzdBlk1JVHmTQvQ=;
 b=mmvG35UKrzv9KjhsN+pywwxiMZDjtIdC27K6NSF+qlacLfKWXwB4M4hSYJxOsTILRaOWO2hlBUDAvpJ2gyG3/Vb3/6ZORo3QfnNfh40sWY389lNWOj8oA7wH5kXjhqA5W36+E/F9QbnmjJ8v1wKQhcQ2xKKcRsGpGOdMGkaYq7zVnZjyqHFUAdmtD2+HpoiXu+7l64TleRXHgbHIA01dnVTvuu4KAZilOXKBSZ8sE1McOkuR2itB3+g/0twOm8mI8I4qRa5ARN5dNlb2GY5GWWW8RBrcMXS+wjXJsEmV8q7AoSchDCNR4WIIshJ7DyfJ5pDihzwmU2fmcGUMbDmGwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Sat, 27 Dec
 2025 00:12:52 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.008; Sat, 27 Dec 2025
 00:12:52 +0000
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
Subject: [PATCH v2 2/3] rcu/nocb: Add warning if no rcuog wake up attempt happened during overload
Date: Fri, 26 Dec 2025 19:12:38 -0500
Message-Id: <20251227001239.405644-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251227001239.405644-1-joelagnelf@nvidia.com>
References: <20251227001239.405644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd7303a-531b-4db7-7d6d-08de44dcad42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NeBF+TGYBvxinFgnVVKEhdM7yqhfJwC3AVSDtMWcX+yUP2p8mPDDMfle0LEs?=
 =?us-ascii?Q?8Kw5mTcb1+00Q93mi9k9mQKXgH/N2JvvNHk+mYRvdPCNMhDdewS5rcuM6WLY?=
 =?us-ascii?Q?2oPjFNafSnVDQY5oqZcZXUAfkx8cKc2dm+EUyEXe/k2GbUXEuPhwDyBcy5UL?=
 =?us-ascii?Q?HVUycyOL3wa8oKcX14Oz7VVt+3ZVSGNBtTxzdEVh4fskMpKua13xYDAAig5P?=
 =?us-ascii?Q?/VEwt0dsmFCt9AOzjlAKkSm1KZHLJud3o4Nz+RbhKJieXozl9NkripSNR7NG?=
 =?us-ascii?Q?usV+/hJweV96Z09nRJiZY8t1wl3My642jNlScZl3OTcUm4FuGA7Cy2qBzRWv?=
 =?us-ascii?Q?HRysBphA9uY2waonQWPmjbMtOojuBzo1pMfowHCajED3ibUD2F+j+u2Kgtkb?=
 =?us-ascii?Q?kaNUvLXPLCNlRdaPbt6Vvv+/ibkJ+x+TUTFkr1/4/HUjlmKhMdYCT0IQIUNE?=
 =?us-ascii?Q?9/c1Qd+oVCYxGkpbgwaGXLppioEpY5FCjoP2deiCCbHUIoGaRtg21ZHU7Qq6?=
 =?us-ascii?Q?LKonVNwxvu7v49ThI7ppjyWf0aLnITRa+oJ/IySosUbp6LDXAOUHCsecygGL?=
 =?us-ascii?Q?EWRqNSVs066bJyu6v7wvuOQ9d87e/GNMrJbtRehaVf0C6E7/83BiipENn6JQ?=
 =?us-ascii?Q?lRaxEFrMWyhbENcfh4aQs+e0A1XTlCZrlCcIBlfexrtD7OsAlNeXLFx7aFsU?=
 =?us-ascii?Q?sNyHgQU6Sn12GWkrxUswJXyZ9C5VXU6hgWxcGXJkje+6xEFRac17tFtEeYHd?=
 =?us-ascii?Q?dgWMymYGYHZS9Z04/ccFOeIupvkUwztZUlHUDT8NxgkDOG7a++jcFa2jUaMH?=
 =?us-ascii?Q?fv3TKRnZXNtp1b3i3rtOUzyTJVBrEZ2A3eZseNyLtSKgOMBmZFHqfi2WvA8J?=
 =?us-ascii?Q?XE+e3dkNXC/naRYY1y1W71JdRayKVS0hY2gdPoIm4COV1d74FQLfE81gLGDd?=
 =?us-ascii?Q?2bK+VEGLFPs0cryr3P/L7lMiVJ+vWTZ6SWpTtfpuqAzG7DEeauDRCqj9opyr?=
 =?us-ascii?Q?36iVFEokpEAVgoieNb4hdzWD0Vd9VezVevDxI8AhnJEoR89gyS4qg/doQSkv?=
 =?us-ascii?Q?GfnBurohRHQWrqZYtCShlHDa+LeI6KCvaZa1CGsnKSc69fA0RXT2xvZ8De0l?=
 =?us-ascii?Q?fgX1f67TsfDAcwUp3oR/bjD2mGhGvaPM6DOCf/1lQi3YHzzOLC2D2/6WSvJQ?=
 =?us-ascii?Q?sBLdLYqPt9uVDtpi5a7fTiVFYr7SqyvN8iruT8YziqtdPT/B2K1pzpOiMT57?=
 =?us-ascii?Q?nB0S8Ork4ag1DlZaQpXwcUVHHCuY9L9ZKyJNjqyNyTUJpqGMK7kMRNYXSxNG?=
 =?us-ascii?Q?6mF2/nKGGoQfGOmHUW7C9Jm5wqEysWIjghLUqn/O+lY7at0k20HD78/YKGb2?=
 =?us-ascii?Q?RKmJxdIuI619PMlrQ3xl4wxeIhQ5AX7tpfj3AM7aBFkfmoeF/2OsX0HELmju?=
 =?us-ascii?Q?bIHmHo6QJEn0yTmaEf504JYV/bH8y8pkinQzxDMJubsetMtCOWrHv4KHQ2jI?=
 =?us-ascii?Q?vpKsLOz6b4ILyow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8v8Cry2hr9Q5It59Sq3EuKAn6HWdSNbNCrIx/pMQWwzYnMxK49t7qek95Gb1?=
 =?us-ascii?Q?7E42V78ELYeH85AltE2UFAzpnPFONrjjoPCqDfYL9lJ2ojZm4lBAIWrUx/6+?=
 =?us-ascii?Q?EPqwvDyGaHb1NqzdCl/nkgZcQA9n7/Amxz7DXSigoZEcx/m4g3ZvEZzV/5Uk?=
 =?us-ascii?Q?0Ngd1FBe9+S2tAlj+301hQWVrXCOL4PB+/texlhUh4staX4Rz8fz/qWpvPKh?=
 =?us-ascii?Q?DoqVyozb7otYscTCDGNWnITdwq6KweNipmwXq4leW6XcWzGHPkOwoEiKeGfT?=
 =?us-ascii?Q?t/KPoh0tUtUj1oXoSkYkZqWfDFdktsdN2f0TzL2wGQXjCE+xOHktgihSBEa7?=
 =?us-ascii?Q?Nz8k6aAO7tPsGVwhuK7FB2AxKCvt/tecpl+ZQsdcjbJzmvqKp6qKUg/yXVT+?=
 =?us-ascii?Q?YAskzxyydzzjAtE5yWLrF1kGkx3ts/Q1sYD9uN/2k/f0ZasudN8DZHe/NGxt?=
 =?us-ascii?Q?KzyTB//duPPTdDIkcek1wzbVO9gbDDI1b8bEEgrEFifh1ElrfqxDIu0L31+Z?=
 =?us-ascii?Q?w3JvfmYAt/BwdRk2OWpn3/8RyX7kpQu0Pct0dsqznox2sdx2sb5gfqrwhoz6?=
 =?us-ascii?Q?Co7XI5p3mMc/m4jIcevvrwaVvRrCXm3LpzGArzxsDrZw9h1vZfYCbm0t4fNV?=
 =?us-ascii?Q?ltcly16AOhoQ1JSDIrRQ8udHpgNMSIirkJcUDG5CnrYaY9Z1QuRBcqmA4Oqg?=
 =?us-ascii?Q?YhcLAm9bYUhRN6b37YCFv3K7HBX2qWPSD49O0mSV4xY8woHSsguk7m8Isrnb?=
 =?us-ascii?Q?6g/TOgqJWkRjGdF5izlzxP+DkbU35N1rRQkR5g4UiW1rTyJeXJg+dB+/b+ot?=
 =?us-ascii?Q?x98Asck4NObJwldHKkcetuBm0bCRpEkLvwHmKbq37jX19Y6fMWvxRz45UyDj?=
 =?us-ascii?Q?1hc8aJB+K06z0J6UaOI8t4wU63jS/gnVpwFVCI4VYzMLGiu7QRXrOzTliYuv?=
 =?us-ascii?Q?X0n/ixMqfRbKK+U7/6I9g2gdjycvsS6rkg1m5JorkF8OJ2BcKYr6MS7CIPVv?=
 =?us-ascii?Q?yapyJtCdb3ai5DY0SVtdHWv1DG7wFjPvZTj+dhr7d4nBNIzzBVxbu6LzD0N1?=
 =?us-ascii?Q?0/VQoPWlkxohqfBIyqzcURYolJ/7dtyc0liUK04wUIv4JIVJBCnbFVLRhG/e?=
 =?us-ascii?Q?2555kFfXggBmwQXoX+lLwljysRj+M6yFDlc61XNe1spub9MTXES6yuaEWGOW?=
 =?us-ascii?Q?aMyraymgog8pwN9h4pgIMxCinCFyduGILlfRtta+U1VIgKNo2Hl+8XStnqAC?=
 =?us-ascii?Q?AW6hMvK+Lb7Xiga2ZHUtrwdbq4oeiQLs4qVYJGIuZwa3QHZMy6rw92jcpvXL?=
 =?us-ascii?Q?8cc/AOPSLEHhsLgEbfpR+iE6ar0+/hwy6AldHylAhg10EvHSWkcAF0oxFaT5?=
 =?us-ascii?Q?yfzy5NaqMaxwxTXO4V23icbxyVoIm/TIuFSdb0tlLodtoZwpVd9h3R/b9Zqd?=
 =?us-ascii?Q?/zA6TZhU10Cs2cVO6DiTa2tKQjf4SjXpeeEw4lxkNQTfhFtRuQxqInKeOhWv?=
 =?us-ascii?Q?pfX35eiOk3Gc/HhQoHNOBzEQQnehvD+pvTfUpOHKCrknwgd24LvBS5r6XwZS?=
 =?us-ascii?Q?nGeVm4opgFKYCX85mA2racbKMDVYIwKMe/eQDo0pBSdUcvROVqsz8utkAnT/?=
 =?us-ascii?Q?sGKaUHwqf02ZdIGFSGCPwZzmXPEw1l2Negl8FtvlsjOAnFsokmqHMEGo+DVb?=
 =?us-ascii?Q?ekwiyQnW3GJOslJUucVXgyX9aUFnCN+mTkeJWplMB+l6TYpOkX2tcTUSkU5w?=
 =?us-ascii?Q?aVFlV1DtyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd7303a-531b-4db7-7d6d-08de44dcad42
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 00:12:52.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlebzfq/e9CjWQh8VEVnbXGWu798qCLZgho34f4ocTPJci0/9dCOJvsrtBXl3zxzcbMS5KdSeIlyumxtgCXUMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

To be sure we have no rcog wake ups that were lost, add a warning
to cover the case where the rdp is overloaded with callbacks but
no wake up was attempted.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      | 2 ++
 kernel/rcu/tree.h      | 1 +
 kernel/rcu/tree_nocb.h | 6 +++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0c7710caf041..f3f790238805 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3783,6 +3783,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
+	if (wake_nocb)
+		rdp->nocb_gp_wake_attempt = true;
 	rcu_nocb_unlock(rdp);
 	if (wake_nocb)
 		wake_nocb_gp(rdp, false);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 83773560332e..91793b6b288e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -257,6 +257,7 @@ struct rcu_data {
 	unsigned long nocb_gp_loops;	/* # passes through wait code. */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
+	bool nocb_gp_wake_attempt;	/* Was a rcuog wakeup attempted? */
 	struct task_struct *nocb_cb_kthread;
 	struct list_head nocb_head_rdp; /*
 					 * Head of rcu_data list in wakeup chain,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index daff2756cd90..7e9d465c8ab1 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -546,6 +546,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
+		rdp->nocb_gp_wake_attempt = true;
 		rcu_nocb_unlock(rdp);
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
@@ -563,7 +564,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 
 		return;
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
-		/* ... or if many callbacks queued. */
+		/* Callback overload condition. */
+		WARN_ON_ONCE(!rdp->nocb_gp_wake_attempt);
 		rdp->qlen_last_fqs_check = len;
 		j = jiffies;
 		if (j != rdp->nocb_gp_adv_time &&
@@ -688,6 +690,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		     bypass_ncbs > 2 * qhimark)) {
 			flush_bypass = true;
 		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
+			rdp->nocb_gp_wake_attempt = false;
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue; /* No callbacks here, try next. */
 		}
@@ -1254,6 +1257,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			continue;
 		}
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
+		rdp->nocb_gp_wake_attempt = true;
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
 		sc->nr_to_scan -= _count;
-- 
2.34.1


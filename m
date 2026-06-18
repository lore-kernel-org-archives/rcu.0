Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710773C3C12;
	Thu, 18 Jun 2026 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808687; cv=fail; b=WWMDcXd9oZyHJwUWUo9Y+pcVWnbWqj1NB+WoLuclNSyE1urdow1M+gjkMMTTBj0HeB7M6NmZIGsVy9CXicGn8GZbUljpTgelsSQDFMbsUq/+6+VDeD26aYqO30t5ZK8QM88dvvZKy2oirACQHAb/AVmmEZXjsEmkw1H0a8xx0iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808687; c=relaxed/simple;
	bh=sn3k9NEOD4i8LXEGO/H8ixluURtmcIrChfBQvGD/b6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQuFBp3HmEnQZSAliNGepDcxE+OHmGXH5yOR3YxEWmfO3h21nQnJygJ5n0pZWbowri4fUG7ymCCiQy9NWT/wq8kQ5nlSwT4JJ/+19JxKcYe/wOV+aGwWaEsLzF+uF12Sm1KqvUkQSqCyRKxMljkL/WIwS43Nd6X7kTWODJkQ3+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ce8EyYKH; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ce8EyYKH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsgZdRaNdbEPePgn40k54FQrbvn6JRR9aha7kJ9M0TUN6Ory/bWWYeVg8xtfDNtjRldjexMRnSaDhz/SeW9svdN7xu/iF8c3ZLgrJu/4MYIRcwZTq7SBFxn8QuFTl4n18cv79Crzv61AlnW2zv4aqDTWodzDoi4/OJjdhwJxzfhAliJ8F+reLMdqSxp3jt/JiTDERpO9k7Go48O1W2idc9VrS2MLDNUc2NxzCs6gKzX3M+M4sT8uP+gadaOVqck/H/uNsH7QCBsK2kNzccTiIYe/2eWzkNo7iYEvdifJ8EbcGU+zTUzNm61LroWPsL5gC6Du7w0wPrCt5dSYufuo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOW3NWPflT5KCuMtA3YnXBlSOeg5zLGc8rTjRQjAJOw=;
 b=H7ITRj3DzsDqQ3fMYk9rUC8Ws+4KzXuXXY2iJhvze50kADc2w5viBUGPR68W97+6AyxuEif8sTYLreJcRAGGoIX8iyq8/xxeYwNx8B3TwLqbOYQQT1gm9l1d19rWU/3QBoLPgeEzzPrbO6iYVXcMzsZf79D+nA3eoGXhCQYuuQGAsfxrKIyIJul9mm0yKLj8LS0MRORQfipi/aF6R3xctLD15r/Cod5Sm74SUqFUYK7eC3lMYSqBmhtpauYoi+EXSVrH4UQrxqqkuDl5IWOUuC7JqCmjv3pGQUMxN21/rp3211FcotWt5v1h0OEcjqKtIS25YiJvrUSEXBbdGEXGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOW3NWPflT5KCuMtA3YnXBlSOeg5zLGc8rTjRQjAJOw=;
 b=Ce8EyYKHRIEU1TzfxGXRhK8ij8BZcgwQq4TyAjvyS4CSuVEKODIwNnPhtsIdwVmumJyf5kPjg/AN6axSHEmb9zNGwwNrJyAGPzOoD1Uf5uiqm5vHv/C06QvNhjhRNosVBJDyscLdRTt69VHhG6u9xkqZA+RTR7fAFGtEUBwYpQyUIn4BqNNeR0Omr8+jehUdGFcrIlo6ApedJp5zDAcUcaORmHNriVKmEGfcGnZeUn0u3Ow902p4AzKNDaCO2mmSeii1WlYt8BnXS4Bs6mL6OulaxuS1nRg4Y8fwT3RFbIhi67NtsFlNrCABac+mnb5m/grbJGZjbJuyAieZ3gf5HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:18 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:17 +0000
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
Subject: [PATCH v3 04/14] rcu: drop redundant defer_qs_pending clear in irqrestore handler
Date: Thu, 18 Jun 2026 14:50:20 -0400
Message-Id: <20260618185030.376450-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:52f::22) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c4ef9e-eb18-4d39-5e5b-08decd6a946f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YaFrsqOsjx0l9YqJO3A0JNcAiywRCpUnOhKUnfBBtNOvFsOU3GJYgVedjdqLfmYcOWYvb59PHStjeLTn2qqRaBdqxpe9x+tvMt+LpLU1R665XgPOzi42MrAJgKzJvIsoQTrtq/BYiGFEvIGPrJRTF3ZjtdiLVXnlP0F7SaK+yJDtoloIYzmoTZg6OB05zirkeplrcsOlm/bsv0Cr36uMes73iiEQIJ3+mgQebF5rFSA8EOwk1dRW1dzrlInrhaKRhRySnMiARdZV1MM9AyEF7YC6TLizwiPNY7mfPtFEw19nZZlorrhNG2RI+mBjMfwgE3QHqCpOaHB/7YUB2A/VELLxlV3RCRH5j18Si7H9rKuREW9VVTwn07StVLp/1MhfHM3/26IdCsVzqZNvYngbRAl2TUNJIbPJK5mhWuQP61ABesRi1CIkbxS03u9HMJP+kzmRLD0f045yLMav3LVAPfkHjpwFFG2LisyJBnnwIaITrxL6qmDuvP3f/FU1z6OQ+dn2fBvUfV/+UwqPHBF3hGD8BGHk3+R6rErybwPO6jpKJbDxgtetwSmpHGd7VhWE5Ff/uO+xxe3ZoCPx02zBJ5T85uZ6bYpFo8sPAE/KD0K+yaSGkz5aXOezn+aKqXJuEzwooETrAQIvjjOL3HFf5Q0JGNVu+mov/jRT2Z0LLpsEUF/c7X7ihlaDmoWZlFcz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YbSqLDCPkbwUMSEMxvr9gNI3UUs2Myvp6VXHgE2k8EjyICvZC+5BdDaz11Eb?=
 =?us-ascii?Q?HwBJ6L9sn9Obk1QBR9iOpX/yeNp5v2xoiS0LjW+XuIiXXvtCokCzBa/565T3?=
 =?us-ascii?Q?a/RLBPbgJMGhfZzumdGQ/aG43A7hTQLR2FjiHlUTyJ6aqTvXJS7Zcc95Sa6a?=
 =?us-ascii?Q?11ZKPPe0sUOszDXMF6DSFg8rC2h/eCzoPPEYlMjmsfC4DfXT+YCK1wACp4jq?=
 =?us-ascii?Q?aWt3Kaatac8h3SRluPW920pK6BRcBCWZ57D7eg8mbGQqNaSLEsmLwelliNDr?=
 =?us-ascii?Q?i4Bs/h2cjIcNWqms98Rvt8BM3btGQwzt/U6ZQb+dzLWKW/ICJkPs9JUeB0dp?=
 =?us-ascii?Q?tdp8Lm/hsSRV1j7f8vJTRT3nL3OXzFZovdPEMUasYJbtGRn3sv71c0/XOuom?=
 =?us-ascii?Q?APoU9gPqMHZ7kJPz0NzLnYwwtuqZBSoUgtzqF263q12PX3za/2wy7mdHmptT?=
 =?us-ascii?Q?I2vXGsCxNHcSQquvziq8Yyv8QAMcoSa7aEdkg/vZ/u0EECxd7AU0k7kWvo+Q?=
 =?us-ascii?Q?W7cYyo3fKoPbHPYF2j2LZ+p8JyvOnTEsFniAZf55EbzAUiLf3AzfjF7NUIy+?=
 =?us-ascii?Q?HiObFtLeYIdrQnzQGVwkQfW/SLcWMC7EV85YsGi73BabXk++fh8RxQbf7CBt?=
 =?us-ascii?Q?aA4i7+95TwpVABeOgSio6F1oifHHm8GnR8Ta4Qrkp1eYD1faTnYgnaH1Q34b?=
 =?us-ascii?Q?NagoONhfms+0orZaqug+8i9aLlgzK2vB3JS+pxiyEVJBoFUVNkYBbE7pZ6pf?=
 =?us-ascii?Q?WBlCvAMLGjup8jK26CMQKW1y/qOdbfN/gFGfphjNPQsVLq1zRL3i3YDonK+M?=
 =?us-ascii?Q?N5lYBncsAA0lidSu/SIm1eFhYSsCKiQsIJP2k7491ZEzGhw+eRZrk6iVbuOX?=
 =?us-ascii?Q?I6NxLFBEjou+7/YGAVNpGaBk2vB56ftlB1WczQQT9oT0/LTGP0Y12qtvvy7H?=
 =?us-ascii?Q?KsTYYGgWpeVqCY19RUtuC9uEOd341LZ1pZ3q40MwVxEfqGRuMd5HjW03g6/1?=
 =?us-ascii?Q?1siMVRkx5Dd/zUQ3pE6KUFopp99243Hk0W1r8NlKHc8c34Bdu9KY74tM1wMs?=
 =?us-ascii?Q?TksAvriypqfzNSlAeoamau1hcbY5/x6SItHW2SEJLVS7iNnBr4ZlQLO9eTLG?=
 =?us-ascii?Q?q4uxuSTnpmm8ZrAKVH0g0OQyao8WBaXpE4hgRWmf5rOJqOisIjfdr6g9A5Op?=
 =?us-ascii?Q?hbyU7zEyj5xKqZY3Cvt50WLs5KJStxURmD/hZ0azNWqf9534opeth4qamuNz?=
 =?us-ascii?Q?UXkKik7/Vxcy0dfqWM7lCSdvwXPPTZmvHfy2EN4rUE5QXCBCmq3q7D3kmap/?=
 =?us-ascii?Q?Fniixr+GON6IaPeVp4Clla1N4o8WCqFrbcqPLNeu2g4KJzXxwHRi8hZlzJIJ?=
 =?us-ascii?Q?U8uFHsWcu74npPbqpKmIFyZCxi2nTO9Odb2ynKpDBz+itxIkHMQHA930TeHw?=
 =?us-ascii?Q?NWc3n/KQMNCFFqPdOrqdypSZnwlBqT0MKsxW2NVgH+EqCAf5UAlEgzlitbyO?=
 =?us-ascii?Q?yLpzcOsONzJLy97ScVvY3Bq4yayRzuI+OPPD/fbAfH3/6EigeAjoxOZLQaC7?=
 =?us-ascii?Q?9kAGBXMxbgGn188paVodNQySeC7OiwgMDnLYqqvl5EjPIri1VPIGNOGxFz0X?=
 =?us-ascii?Q?Jkyy2pDcJiasan13+Wc+WoVVp5uwo05yvP9n3UkmvPJPjV+RUqfuscJli7PA?=
 =?us-ascii?Q?XLJPt4Ym/ip4zXeGg+S1Tp9Gmm+93D+6OwhyPEJL35gxyWJ1anPJQTslyakD?=
 =?us-ascii?Q?8mZ8D2Lqnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c4ef9e-eb18-4d39-5e5b-08decd6a946f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:17.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbvFCJ/t+R9tcIb+0x7WKsyWhXAGqFuawf8a6IEu5jmjIneD85MSryILkFtxqYqXHZUfPc7hm8DFXBUW9xl9gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

With __note_gp_changes() now clearing defer_qs_pending at every
per-CPU GP advance, the per-irqrestore clear is redundant.  Remove it.

Effect: PENDING now stays set from arming until the next per-CPU GP
advance, future arming attempts on the same CPU within the same GP are
gated by the rcu_read_unlock_special().

This serves both as an optimization (should not need new irq_work again
this GP - for the compounded section case, we detect and clear it there),
and reduces risks of recursion due to clearing too aggressively.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9b167eaf8e0d..d17c2d97ebcc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -487,8 +487,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	union rcu_special special;
 
 	rdp = this_cpu_ptr(&rcu_data);
-	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
-		rcu_defer_qs_clear(rdp);
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
-- 
2.34.1


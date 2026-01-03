Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4772248A5;
	Sat,  3 Jan 2026 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399842; cv=fail; b=rml+8mH2S0k9fkafPyl9rMqCGkP4WzDABnZiYbjK9wglKhyrLhobxHfwCXX9uWrXDM+ASaLexPfIQqvOrePvzh+MX1B2iKqROFsvSTAMvXVQBmWJN1SDKfGt2ZwgeJUThhBuNaJu0jIengmHa0c48IjhNHSuhqH75oLutu4AHhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399842; c=relaxed/simple;
	bh=Y4xaspahvaqWA2tMBkQmDy8HemRYJkkNVWZQGRgXeFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SIAT2ZzjtMtFsBrGrAEvSdtriHk3lxb3lWxJw4CRdF3CEjGOsyiz9kH/2z3kMEmfj2GAK0P4mpS5eo9Z0GSiee9UksSZc51Ke4uTt7669PsP7msUVuFoYd69Hhei7Zn3lLWH0PnvB0fsqDXgZJzIzVs9EMI3ulfB+RU5nGzql4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhmEGZwn; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhmEGZwn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBVYhIxukGZzq1Hf3/YEPT4lCPi3UWgLKWbV2Vd0nrKwS2l1X9wY1LJ+Dlj7JsB/ZTGhVvktnwezuqHCGys1XwphijwyE/MIzmwanfvTnDWGovdAuWfgxwTZ5EF8cP5Bh+jDzlPtiFCMjD3jp8M0yYYGDbe9XkNZ6oIwRtgOd04e6U4P0Bug+OUUoso4Wywa+I/kQG/weMA7hHDN+PFjdRmaalVkrQlT+QHZrJVmZO2aXAdBq13mfXSLaPC0HRtrFg0DMNC4p8vvjRK6pPRrRpyahra3rNqRIqwJNHwJLhLn6WbqPCsmd9zycfZYV8hM1FumRBgrlNl/YPvRZXV9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSorV68PZBpyBabwz73RRZm/aldQEKcxT8Q+1oh4my8=;
 b=Tv49zEW9eCRBj9MdENhH/b7MbtUI/1oAp20XL2ONNJsLTOOX4QYKBqqAHKO16c1tBPcoqC4x5ZJQEqjp8cnzwpYDrQkX8Ldr6iQEUZiii21Y8mIkNTtzTa1KFzRwvrjI60XyhvjwlMINqsIfxYI4OpE2MUkKAlzPwTDVTSsjSM07YzNGUnrnweWxLdF7+oQQMKgmWM/Gy3eGGc1yrZnvqPsC9aumm0m3v4OdxDCpCtNEEvifIETggVsUemufBQa8FB53G84z0wUMK3sah5WkBO5+IWg9UXAPdU1CZZZlzUqtHQAI0rF91sHWWozHLUj8fQDoYEinbsndx2UlZYNxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSorV68PZBpyBabwz73RRZm/aldQEKcxT8Q+1oh4my8=;
 b=qhmEGZwnlvnRM5mWA+XZY7V1m/9s3uPtWhT16tcc0BoRyJf8i8q4mh6qJTHtlSmJzpQA340cPynKBNGaZSztRYwsV+kFV3JjsVZLdwh+qQTeZsSFxrb3mCQX4V2p63q6KTHmga3vyAI8mqngXrxI7wwi4vV4qoYDPWCQYsoRUwZFAyWYvXRcnV4deroBD0U3B5yuxrsVcV3JxW+uakJuicwkp43vV4+piAB9nptVScpYhF5pZHtJQNBmHmcVRM0w6+x9uJ3YCQSZd6XIfcpXbuk/RVzMEio/bGOa66F6P2uyB08u4GCWH19cXszvVsc6h+gY8FNwWYl0MMwzY84b4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:23:57 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:23:57 +0000
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
Subject: [PATCH RFC 03/14] rcu: Early return during unlock for tasks only on per-CPU blocked list
Date: Fri,  2 Jan 2026 19:23:32 -0500
Message-Id: <20260103002343.6599-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cb19bf-562a-47b4-7929-08de4a5e6241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i5oAhuliuf2+9iNK55Wwp7tmYcA8BWFKwyDYJq2f+kK1cxRvwdWw5/R9sQod?=
 =?us-ascii?Q?FQYN3IHtSD6XhwVU2V/eBE81qJXEBH6T3jYCMLaZhvw0VX4Ad8t7srFW0Y6z?=
 =?us-ascii?Q?eRswFC7ncClSYOr49FrvWcCSYSKppyWdYn7ng9xOPx1IP7sumQymZlRZJS84?=
 =?us-ascii?Q?fpGilobAXsX7SktIuZk2Eal7NaExcnIKqaFWstXgqua6sd+L+s77hLHuq4To?=
 =?us-ascii?Q?qWuNUkbrVp6gm04tPIXDzOxA49r4+rgvjYnQc2QeIWKSirgIzBm8p2v+D4ak?=
 =?us-ascii?Q?stym+vjPNl654/pgir0Q1b3wSjiUe2W8BfjAomL+LB2oNDOBWVDEHs4d/hNo?=
 =?us-ascii?Q?IGdyPoxa1ivhAXxhwffP4IA8Ps/h+tYoRlVArHFwUHQ7xTWg/6thlVoP6B0f?=
 =?us-ascii?Q?Ps2dk738xPW2VZWinuVqSk84sQIsyZvZqZQZH2orIqj2Lben977AzdPDasFA?=
 =?us-ascii?Q?tt9FGsprP7vFm5veslHzFQHn/HudIpAPx7XUuPSSbIRShTOYBZIq5MBfjQq4?=
 =?us-ascii?Q?82R2JaOiNIO8gimolpEJzUFUbg1JRqqbHSzO81yZ1SKix7in8MHPX/EI5c5E?=
 =?us-ascii?Q?+xUw7xpYc2Mf4k2YYJ2xDx7KWcw+O4ezumgJkGTIv6hwNK1GrwyZ0qHoL0+4?=
 =?us-ascii?Q?Ka+fSkbZz2dnb9WngNKkvTletQAt6gGSM0aTIPrzLWSNvQI/iA4wLzvxiM12?=
 =?us-ascii?Q?puMV38gQ+d8uzw3/Ks1b5jcDBoWXYOoRnZSBZpxF9baXA9MyiSeCSUd4Py7q?=
 =?us-ascii?Q?/n4xrl6WWDC9QHO/qeKWtAEI1w3oKotwZ34Z2PPFG9NwZSkgeO/foNcTxs5N?=
 =?us-ascii?Q?229duiItdPoBOm6EDSxqqPl8INFMK9zSn+YRWHRMC1AAxuMm8JPXaoPaYrrJ?=
 =?us-ascii?Q?8IqG8cWGxccGZmXogwPeVKabzsNF/TCakHKFcBkrhKzKimrSTMFWoZogqCMc?=
 =?us-ascii?Q?XIgvIlQCwTmOhhJrTLu0dNmWuP0rBp1E7u3VHw09Hi0yq7PMQxadmtPYPfTV?=
 =?us-ascii?Q?y3opL/zjD3he/ZRjnwQOgI+gqKL+hab6CV8uyOJ4cr3pI+2MijErDfiBeAi/?=
 =?us-ascii?Q?KTNx3owD70WZFCGZjX5z2er36HJzmSFya0fXsjUHLPrnPaAmkirIg8EyDmCQ?=
 =?us-ascii?Q?9DsnypCE/szGiBqaeE4Eniv9Cacu0sEL/khSCvET1lQlCrnSRsjhRv58SAEP?=
 =?us-ascii?Q?dn9kQxvZx0ATae3SUPxIjqNfSdLqjfF2vUCnHPo1I3Ne9aFWOeAp9MgWVo/5?=
 =?us-ascii?Q?6hTN+4xmRDaimzImXDCFs1jcZf2VxPI2Hm53T0/eeJVBCR0knzXQW7vki78d?=
 =?us-ascii?Q?0IIDgtCwz9LZbFqv9F289eRNZNmzp7UkfwVfzV6hh8+lLQfauG9uttBMWZI0?=
 =?us-ascii?Q?0gf970iFhZ2LKC0OARgiPA/zDfbGZiSyWVAv6wdh78FPVGvBiEZZ2DPwdAAA?=
 =?us-ascii?Q?6/j2SSr9zrqkdr6VpN5Ca9ARe0L5iHmN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LzF1GHO4RLRQD20oTsstLzBi4aQvAxGxYDXUpER6N0Mv54kS5nKYzI9HjCEb?=
 =?us-ascii?Q?6BPcc/No/pj1XiPyg9gghqe1TZHm5HlaqHkwTeY7X0sFAzKJM35W/bnyzUTZ?=
 =?us-ascii?Q?y/xRSeZVx9jxhCSwpI/3n8cuJrt6BLym4SchOuwu46tXcC9j8U8V7mC2+GON?=
 =?us-ascii?Q?4FtXIFHvwwNvhkcvvYlRAJNlsAxlnoP5MKWp42dUGOSXFlJplmE79W80X8lY?=
 =?us-ascii?Q?wxkLteBGgIt9Qwf07woU25Efz6oA5JNMQdUGMxvqCzQ40dcfuCiM03RIELLn?=
 =?us-ascii?Q?zPlBY8rkn3gq8eMhJHjx+aE0pc14GlSM8vHtNy1jTha94ggo8kpukk/n43qz?=
 =?us-ascii?Q?Jd0bVpODlNjBnk+7n+qQQIUVgXLBHm+AIkt9JCctw8cUVYx2yZyR2SrTn95U?=
 =?us-ascii?Q?jSrFhZBrYIIGxX5hcXozWxUy4Be7aFo9xhLhPApMpOd39M/Xcd+Edyjznv08?=
 =?us-ascii?Q?Vb26bnq+VZ+t15LYR+w56gSP+aaelH9eoytW/u7OQ9GhB+msmva4L/Dvkyk8?=
 =?us-ascii?Q?/QAaPTpyDGVPBKL7gdmQP8Qvxcqfchzr6h84RBbpgqtsTubz8J4tEF79q30q?=
 =?us-ascii?Q?6U8Votw8e2tk/PKpvEOLxpFzJ/xEfRBlsTVCLwC50RDwBbpy7rO/DVP5a+th?=
 =?us-ascii?Q?jSWhNFFxWZpjrnXQGUTQhqCaoEKVlKoc7SKKjDo2WFroSUES+2HjWWnJO2Bh?=
 =?us-ascii?Q?Ad4n78xZ46DkXEba52k1h5zxoU720fO1qC4IQFWvyin5OLq7uLgwQ9LhV4it?=
 =?us-ascii?Q?Bk3To7tjta82VUZQ3LwQmQgUdcJiNUNDHyGABaIqJqwbDQWyk/WT+rLErnco?=
 =?us-ascii?Q?4rQ5rgvX0lb9AKyMVKF7ToQTYS2r5VGfpOr15vnpUE4jbiXGjf0Afmf6fRj9?=
 =?us-ascii?Q?78JHipBIY1hV1Ona5MSCGjJown20B7HeWojn0032hM6f017k3Rr8wPCzGkvA?=
 =?us-ascii?Q?cR2YXUgVKmnLvjvXu2XLJRh/6Su0C70CPk7jZ360b/ey7bcEbAFlfDIeULM7?=
 =?us-ascii?Q?UniMEih8i8pbfGA9rFz6tyGnrQQ0fVNBzqO/ixbe7Z0yjksDeDG5Q3wz/w2Q?=
 =?us-ascii?Q?lN0U2SPsyWWJ/FxnRQOHzaxNGKURudXySWkur57I3OG6JCBZ8zmjINIsAzdh?=
 =?us-ascii?Q?UmEvgtGmdLdYSfFwWvlwoWQd2apc7c6IkmGHw0bOJmGxMvpJlRUIdSUn6xNJ?=
 =?us-ascii?Q?kDEiXe1V1vpwVwburEO90xhNMG4mu/wMhQnoPlmPthyUXV4WZoe6xLzax1ag?=
 =?us-ascii?Q?/oyrWyTMdC4d3K/2HDuya3nzF5Rkd0KIT2Dm3gQ4zzNiRbmKikp0UZ5tFH3X?=
 =?us-ascii?Q?UELdnTM8UACWB5k3REXfUpgygliDXut1ta47MS8QwaYhT0+Uh1DY4tDkmhr6?=
 =?us-ascii?Q?MYi6/g/eyKySe7ZuzdJ6ADyBhgybTXrT/nB0gU5KvUUvzK/f2vJPGnnhd/dC?=
 =?us-ascii?Q?3nAZZzk3gIOA5wMIvUEaZusJu5yDMr2TTguRIRRuwL88nG5u9VWjUKTCDVKH?=
 =?us-ascii?Q?m/GMWThm61ddfZYCPqr23Q6s2HTKPWiIqQ/9u6NR0Z2wZLeag0oOI/i2qbBY?=
 =?us-ascii?Q?kjvz7JpixE+Ij+JGwXln4Z6Xz9jQpxwc5PPqsijfMkRf82zqG5rTm+QaD3ZF?=
 =?us-ascii?Q?H0RdJMK4RAT/JmPVRkPArMme1H0Az18S7YY/DeEPUr553xgZIOaBBjcyKDSm?=
 =?us-ascii?Q?/dI/HmPovL6V/VXFUdf5fE3W08KucP7srGTewzlhtY+cadq32B3vBqEPOS2q?=
 =?us-ascii?Q?toIRub+uCw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cb19bf-562a-47b4-7929-08de4a5e6241
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:23:57.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UR3YMT01craYrUUcjQ25/RvdtCbR2ljzzmY8cMhuHp+XKDCN1bYg1tlT8iGv4WRCqYjjyYlqogjD6YOkDpcXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

Add a check for t->rcu_blocked_node being NULL after removing the task
from the per-CPU blocked list. If NULL, the task was only on the per-CPU
list and not on the rcu_node's blkd_tasks list, so we can skip all the
rnp lock acquisition and quiescent state reporting.

Currently this path is not taken since tasks are always added to both
lists. This prepares for a future optimization where tasks will initially
be added only to the per-CPU list and promoted to the rnp list only when
a grace period needs to wait for them.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5d2bde19131a..ee26e87c72f8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -549,6 +549,22 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 			list_del_init(&t->rcu_rdp_entry);
 			t->rcu_blocked_cpu = -1;
 			raw_spin_unlock(&blocked_rdp->blkd_lock);
+			/*
+			 * TODO: This should just be "WARN_ON_ONCE(rnp); return;" since after
+			 * the last patches, the task can only be in either the rdp or the rnp
+			 * list, not both. Since blocked_cpu != -1, it is clearly not in the rnp
+			 * so we activate the benefits of this patchset by removing the task
+			 * from the rdp blocked list and early returning.
+			 */
+			if (!rnp) {
+				/*
+				 * Task was only on per-CPU list, not on rnp list.
+				 * This can happen in future when tasks are added
+				 * only to rdp initially and promoted to rnp later.
+				 */
+				local_irq_restore(flags);
+				return;
+			}
 		}
 #endif
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-- 
2.34.1


Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0E381AF;
	Fri, 26 Jun 2026 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434597; cv=fail; b=PVtuLKBOhbkE7sGtk9KIh6dkqnWBgkQPwxOverB4mimMuIFTTWmgIRNWD7PcrouUeqWqSZ/3rQjfLlMG6jzeE5hq+waHoSTnA6pfsxxWoQ9WefY38mQ/880BO552dNBnVSX6GHVNMff+SeA+9wK3FLKOKDPWFF/DJBzNB/FM7Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434597; c=relaxed/simple;
	bh=DZy/S9trdye7JGkCDE1W04+NdcdL1Bpb2NTwulnOIR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fWanpLfth5QiXI4PYJEYLWWRYm/34R2psXSoTbALLQh0t5ICvxzCuH5VjXZ6op6TUKVK7E08Ig8So/lB60FwjsSe+VLTTAUGIKyZFinUv8guf33AAWWtTTEjj4WYD2CE1eG9IQc94ydIti/bi59v3cerFBHYQJduIhJd5rFj3fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jIUwVBXY; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jIUwVBXY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDMWdhlPIxmGRkxbGISuWk6f6N72RUAvrtVU5FTvr5/fxa1EYJZATwM3aGi/hq/+YmNC6PSrPpO8kHgyMwBbyMnBBh6mz1PwrW8g/5ma/r5nrEtTo9/gkbstnQCF9T1L5yu3TO97DIL/QGnjDNaIrC17dUgeIO2M/Ya8up8AjbHAJgeGK0zby+MuvBuDOBMfO6ZTY65QreTHxhcVx7czhsZoxGah0t/81Ot5fzIhJe5T8rl3uhOZRumPwQaS4SyJYJ4uDa1Gblvdtzr6xmNwxqCqyMfp25WEw6krctWLFQyyEzThkY+2XEU/9HoK4cszopkzHgcxCvuvtuJmo/wTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kXsOmunLpZ8sMirB30a1vHcfZOZDeW46zvthnKj3X4=;
 b=s1nDU95CMv8zjgYoMfm0/NgydOq6BKV1QmNwy85t3Z+SmniLAhhILDqHQU/YEq3UVdHZz7e3rGU3KcUrNFbQAFDk2xWkvWY69ZtMAUxaPLEe2OKxKl5AW0SjHxQbkwHx9Z/g1s309II2D5TarQJHrBBLgXB3FbYpdlCPWvIqbweKS2S4jz1tiq325mRpembBLwEIK1a2sywpGCLUSxUJpTqeyDn7Qi3tktk2GtAg140OseUsZHPBlF83+318AUYqZAr6w5JFCCX5cZjm4CMoOoz/wAROGQ4W7nvwff4v/bgjW/58q8FFyFGDQx5jrAmSPfHWddRZcVj4tSEaXOLm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kXsOmunLpZ8sMirB30a1vHcfZOZDeW46zvthnKj3X4=;
 b=jIUwVBXY04cfwIdgKnh+EQc/TtMN6HCivESIpzkQhxBRAU5lTLXKRORFskzktHlif7G1p21WUpaxQOnrkL6Lh5wOrNJRq7mtcxZYdna3bfAsTPAQl1LpC7CMG9gRCIxWe2LjrC4RvkyuDWMMGNrJqMja2QT+Q8cKrl9+8IFgEel92Q8Tw/MnggTjA0b9aOBHQ6bEOkMk0q35TxT8Vc5oeG35tK0APWjNW/Wt+2+4WWK9JjexG/FaIGjywgNslTK7n+3ouoqF2oEELuOuGV0JBMxahiOvAYTcWh/IligJtckP5FJJQc1OIR83AWeau+ucQwq5V285/ewhwaw/pTnjjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Fri, 26 Jun 2026 00:43:07 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 00:43:07 +0000
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
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v4 1/8] rcu: introduce rcu_defer_qs_clear() helper
Date: Thu, 25 Jun 2026 20:42:54 -0400
Message-Id: <20260626004301.1632168-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626004301.1632168-1-joelagnelf@nvidia.com>
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e5b57d-e837-4099-78f8-08ded31be3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aQP+urMkPg9kIetpZ/3xzuR7HcKU/3nZc0egF3833cvTNFSogKF31MlIgiicYOJGGTkSWEvZMLqkxea0oLgZ8r18bJ/+V05bVvPL+jYqB4/TCJhjb1vDE8uwA7/7NbE48EBm13EZO65fI1cm/lGeM/51ov5uYvVQ/rkIqjrBbnAGmzvqioYmpLRjhxZ29I60Lyt8cb9sRDrdehQnlM0HOhVnhEOTk4QA9oWOs3X/oDCMBmhEOCZP5vrLXbyIfQOVJL2IxSYsU4G8vvYDUtAAfXebKXEEnMUrB9dMzsSFcvXklcZk2BaZVNEv/YbBVqbPW3M/5qPQ0nqKQqqB3vaUm9SEJ8f0jv7fMaXhDV2XNubwK6zknAPi5nfxSImyEwI/phXe/x/fMTcUpC77WMBUL09MkTPEn9U5qcYT+MSBkvBWPOlJzcze6G9x3+DZWLHSTolav0pEgziepq4akOUFQt4SaHPmhiYvPgSDJsVP74StWyRT4fYbDodzWq4W4QcSAImK42+DZybUAXxsjF7oJjYwucNEX4Gc6Pbz8ttPR3DG6n/a/iVKIBuSnC8fNKiMUYvgmXaFQU+iAxjGkSUzb0QVY2x64JQjKlupITuB5gSWMDZw9evGDsszl1Ko2PS735QGTqcgZJpjF4iIchg8RBlFuKJsojecKRWkBIJxsYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zxAYMLsfSdvEeot9F7oVVEJfso0sUj9dF95TY5R24hHtmDO8t4Jvv1nOONtu?=
 =?us-ascii?Q?0irbYMAtz2/ElUajnmkLOfNcY0aaIhJppi3uCewsJBcFRYWzLJ12Wd/nTTY6?=
 =?us-ascii?Q?OiX24eK+9f6yBM7UtebzMtqvl6xW/1LFb28iqESGuckYsUD04uN+8U5Eolyv?=
 =?us-ascii?Q?8wqcClz1HSajZpBIzX6BKppYwR9GmYAOaQ5oI8WfLf4VdCGVixWTaRVySh1P?=
 =?us-ascii?Q?iEy8Ad9UpOUSGCbt/yjZgI/wnjjQ3zuSkP+GGVTgFT5Hb6SnHqKKXCOwUvkx?=
 =?us-ascii?Q?JVOMCUeTjVSa1W+9HwSqqfIvUk80dE0azA5yyylzUpiXPdSoC9CjIsEDsAjt?=
 =?us-ascii?Q?X3vnC3cclYqFArHuq2e2aS9d2bQ9R7jUAdgQmgqK8AQfrgw/E/EsbeTes8Bf?=
 =?us-ascii?Q?EC0y2YIQq9pfUzIprCQvnA3Ntnv9d7USdv1uljkWLc7COsfRVa+I0czBzZWK?=
 =?us-ascii?Q?4QwpV91IkA8ff13aUvrHMrjuW3+LLIdPCGnO4qV9iUHtwOkRoQfz06R1di7M?=
 =?us-ascii?Q?C/er4tfs6Ja+8o7vq1uReaK4rYznyXm2tqzs5ew3GbvQmn/U5a6kr5+0X7gZ?=
 =?us-ascii?Q?hbuQFNLOkUW91g3Y7g5ICh7SyJu6icBcj+H9yZduOLjXtq7GWqDLjtt7k8ON?=
 =?us-ascii?Q?g4SOxAEH5Quu5rfl7vR4hFaDNAVTw5sOL6GMRiiDROZ3eQShvaA+g9FjktkI?=
 =?us-ascii?Q?/4rxMIvQJOd3gKDqlwiViBbVK+x2KL1Tz4BrR369Viyqy8YTfQ07rG74OP+T?=
 =?us-ascii?Q?5pUCJs76rtrhqO85GU37WC63IAaJcfVkLLODqMwyS6ZU6Mh166sBX/quCKrO?=
 =?us-ascii?Q?R3J+vWEH920QKK2kaOWw7QATahnruUrjZYMsFfK9oJWzMCJtSzD9rmjqNYi8?=
 =?us-ascii?Q?TmVKAY1tCkvuHV+TuQyf7/31micrxmyM0t+rkysl9l65Adfl7Oned7URFrZi?=
 =?us-ascii?Q?AslovJbMnmWbA6aW9ciloms5SZm8js63x7DL0T1HCiTKJdjrvWxDw8J+a98s?=
 =?us-ascii?Q?v91BHUo3mTx1RMPi1PiJ6/nM5vXIPmVFxOpsDGZZMxhUwl86Tlh4YEFtPDJn?=
 =?us-ascii?Q?BJAszlJH8uaAMJJAQ7y/xtU88RwVkwPI5+BBwnPfxiPTNVA4PYkxTEhrWwJI?=
 =?us-ascii?Q?axVB6QHJ6ewcUbHnNZNnSUBDFa0x3XzqEfsYaCoD0+6NXlFITWQkOq0L97m3?=
 =?us-ascii?Q?KK/9NuyM2bG+K6i+hEz9qI5qmDJY0IJ4RVG2cgE5dLShpRKtbxXqsY8LVl3N?=
 =?us-ascii?Q?aSatBeGI6BPw8IlgwxNAw4GZLcZwh73NrF6lRqgK7Sd7a9WoNHIQznnB6XME?=
 =?us-ascii?Q?RLzWOUwde0Vx6Gvtb4skmTTkkX1DNfh+G2fiGEMJjV9RiNIzSpSpn+KicKTe?=
 =?us-ascii?Q?nGO/CFW/WLWLOLIFB0+iuVhmGDlFl+sQxrptU+BJtfqgempuTvOhtNszgpVL?=
 =?us-ascii?Q?YKNoHyrp7h1Zrgg//kFc0soYlfTb5rNJDbP0kCwM/xq2U+tQqX5eKe36VKV/?=
 =?us-ascii?Q?O2DL6D7IuJ3zcCxF3G3LyaHqAP1BKzeh/7xoRfb3FfqH8ctiTit7QvNntBDs?=
 =?us-ascii?Q?Eb+LBfzRivf/6TLnpfmSriiD3fNRLzhlCYdenidYzAqfBFLdsXSo8bmapr5N?=
 =?us-ascii?Q?CbFAmH9ZdT26px8YwYWmKgQXxfsS2xzlenlllUHIXVwh63m4unKnTjg+nrXG?=
 =?us-ascii?Q?OG9Koo/0p0LI3ifet8q4TP4uyZseHTeniCZw6sIkvRwXgoZfjVBE8MKGn85+?=
 =?us-ascii?Q?wnqIzj9yzw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e5b57d-e837-4099-78f8-08ded31be3d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 00:43:07.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwQyuGBXLf+sPI/JKuMqMkaVYHyVpVv7GKHcC+9nyhoVxvinEhhvypWdgkTupCm9SCC9EhloJHhOQmajWuQ8xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

Currently rdp->defer_qs_pending transitions from DEFER_QS_PENDING to
DEFER_QS_IDLE at two sites: rcu_preempt_deferred_qs_irqrestore() and
rcu_preempt_deferred_qs_handler() (depth>0 reset).  Both write the
IDLE value directly.

Introduce a single inline helper rcu_defer_qs_clear() in tree.h and
route both sites through it.  This becomes the single
PENDING->IDLE transition point for upcoming work.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h        | 5 +++++
 kernel/rcu/tree_plugin.h | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 750b98f0c6bc..dc03231b2d46 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -311,6 +311,11 @@ struct rcu_data {
 	int cpu;
 };
 
+static inline void rcu_defer_qs_clear(struct rcu_data *rdp)
+{
+	WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+}
+
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE_BYPASS	1
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c22f033e0136..7555022bf38a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -582,7 +582,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 
 	rdp = this_cpu_ptr(&rcu_data);
 	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
-		rdp->defer_qs_pending = DEFER_QS_IDLE;
+		rcu_defer_qs_clear(rdp);
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
@@ -725,7 +725,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 * 5. Deferred QS reporting does not happen.
 	 */
 	if (rcu_preempt_depth() > 0)
-		WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+		rcu_defer_qs_clear(rdp);
 }
 
 /*
-- 
2.34.1


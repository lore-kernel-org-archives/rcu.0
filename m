Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794181643;
	b=iULVoiVaaI8GD5iDo9vHiqvPYbRpMxsAgiHclCO2F6riQepNRZn+ovTUdoecnNYxn7b6
	 2ynxJq4227s1FiKTGFMKt4tT8bvAg2HJOHOvdWSpwzJTUtlmyMdKhWafRSmq3wpGoLbCe
	 ablLnnbMUUN1cM1xPaGA+6Mwo6W5dhcfBHNWVYY24YTrJPIKeP1OW+hkRpG22wiZIZK/q
	 3TKdO9YWA0wJ6tWNB0kydQHwZTT57yy9fN59CZQWtVxeTlzMEP9s4BoVRshoO4YVFMZQd
	 F+lJXehVFtgsbuO0ExLysJlOGMDt79eHKCbMMgBz9BFXZdO41ILXPcmOfSDrMO8ZuWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181643;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JPW24ng8UI3RbdNi64b/B9P9J/O1MRC1nFw7CjGwRx8=;
	b=b8rKH6BpZktJX1Km2Da14H8NR4robtGhk1c+1JjqgcQAjTZdY8bStMHGUwAHghZJWkBs
	 nostLrXa6xecotGbSZMj4Swt9BsG+yR+fEFg3W9f6G+cSqGQGpUcF2d5naWRA0duo7oa8
	 dCg8R2LbCJll56nyJccXxr2NPvKEKWKB6n9HQJnopOIyXQYkFFq86Twl9gvi92+anerGP
	 rhzn6ftbYRNC9wxGbzDoFI/y74pA1Nup4LbJ8JOi0rYVxl/GUvf4DyZBtvx6EWSA/Uytd
	 kulBSVacv7ZXaUMLVsv+4SI1k2JvzrwKUS4ZVHKnIasyMjrvbqLjx4F37XmzMSawi7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PjoG9eKH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.21
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B5606A321;
	Sun,  8 Nov 2026 23:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 977B5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PjoG9eKH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G91xFFQ+u6N7irCilFJ31A7DXWyL6rF5Wy8KGXTigvewCJoeeiqEcnDq76I3TENgyildAvWqVURBUP5XASH8lgAzbpH9aGhWe9PTFqFRValYZUcmF4TEQl35pKxX6HounNXrvL38+0UawB4XGRoR9ceNOHWj9vMUJMfYVO0WPcJClQ969SqH+AGHAdOdxnNZIMRc2fmzAFcTQgLq5TZerafE4NeLIaovl0w1M7w7NGoHQui5g2WVt4WQ4GpIwPncgyMJQltxOLN+bpuAuqktn8512Sx6AecKTbQ6dMI3OQtWnwfaShWTbdqI9XbLYML51y9GVOp2bvp1qpUWzDGXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPW24ng8UI3RbdNi64b/B9P9J/O1MRC1nFw7CjGwRx8=;
 b=ZZ46FTcgxUL7XJEDIkyOq5ygMtBFZGHnlYYsdRCac217OulSBgI56Yj37uJ6uoP9V3PuT1Zilio9Mvxh4WUHWGzU8LZje0tcC5oR228fhDqd8kpu4PHSuWsDvwjbEHX9qtfsnh2+zC7z/tmSvMp6Bxfde/kgNTsy2uAd5JS9ebcSCUhnKMi9ip5UER3xeNaMYW6RHo165GJPROrwi6VSiMRVYWX1Au6Q8moVYAVNXUC3V7OzTMPASsk4ol1dqY++y/W+ozpqU5vH+kAw2rnrY/EvkzomITf/m/Zfv61qeq46Utgk6MOHynZrV6i5VQPdDhC72mJZlIdBX/u0ZVllPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPW24ng8UI3RbdNi64b/B9P9J/O1MRC1nFw7CjGwRx8=;
 b=PjoG9eKHJi5HztO2PdmkEgXPy6aHut7K6fq7SzqfeTVGmNSRAATsSy0x8syg7kHA7P4o+Eo2paohm5C1EjHGs0isB+QjtObFDmQGLEW8sPxz02oFDJvRxklxPGqesRqIQIXtnXwucgc9gOpkO2Pgy5HTK/GgE7YYZNCUWL7B3PZKlfJd1cFskrJtOuo5PHKvLjbVp7b1ZcaAnpTaj9GCvfx9vYiqYCq/KacV/brmCysZ/WZMk4EHFt8xf5rpE+vRj/auOUHWAvkxImr06TsV43sCY/cmCBFdb01PECBXMlRx0EDBTRC5DYhfAfI0hzDyeAIS0EtDWLsIrjmhFDfdWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Sun, 8 Nov 2026
 23:47:17 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 23:47:17 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org
Subject: [PATCH 1/4] rcu-tasks: Track barrier callbacks in debugobjects
Date: Sun,  8 Nov 2026 18:47:09 -0500
Message-ID: <20261108234714.3713501-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::32) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b46e51-7ed9-436d-e5c7-08df3df29f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|921020|261021121427099003|56012099006|261022075727099003|261022105027099003|11063799006|261028144727099003|261009223027099003|261026140227099003|261026121527099003|5023799004|261102123227099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ls/jptgFTVSG4i2ZlcKAQ+mC63xsG1uyvmcFjNXcWcIvkBtWfI/zXcu4zs4lIIESMd6TJU1GVtLP3tHZsFVW4pCG8DeURDc9UWEZ5GA5DI9Y8JjT6ndQijMht9K7sgq6XZfyZOhie/0/ZdxTG689r1QtOEBxhqQosUMbG5N+yNJnkHdRt1I/HS6RFCzPzA8IpcyIdQRSXO7tj3eWbrdF9ug79W/40f6S2ZfnOxTmqHpzNnLhnjNzGksjNmvreWYVfdYglyTmnQi+G5sR/3Df8xzsLa29tZzV8eRwSgOj2uc9Kja4qjxel+FaBnwqL+bdegjow99TMSMfhrAv6jVQuKZqW1C2+iz0S9fjlOEv8eKnTIxMCJZ2qosRGirh4oNRBiUuh/xJJvtgRYj8OX1OPKAozDnXoT1DNNPezrrfb+kK4Z1WgwKx/CJYDb2YnFgfrYxvVg5aWCsT6B238OiLt39fNJ5B+iAaVp5wr1Tau9HoRhkG4UkyoDL7Gv7BrHCbJ6vxXJwVT11Y13Ztrv50gEgapqaH8JGC8beDss8TtEU5el9SYLLd7JF0cUZuXg5Gc3nJ0UMCRw5z12LufZPvnRkS8/CAXH1aX3nhBFhcVNHH+rZWJmLGNoWm9ywuPBmSJhzs+j0X8H7WB99dAl+wQwEK5ZFnDx9h6MLRm9Ucsm6/3Qqt2AZ+sy86MOO7Fv+RaQl/l99PDaD5DgtzGnX08Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(921020)(261021121427099003)(56012099006)(261022075727099003)(261022105027099003)(11063799006)(261028144727099003)(261009223027099003)(261026140227099003)(261026121527099003)(5023799004)(261102123227099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQmGcwWE0IQgMLR9WWf1Al/U5F1GASadnZOu7GhMhisRGub7ArC3FjUsSr4q?=
 =?us-ascii?Q?w33Ey73AinXi9xAt4QHEjETBFWQhzP6mL+iHNmk7Ngejb/LZKhQGSD8g1gFr?=
 =?us-ascii?Q?PmlersROB/DB7pfxqDjtPW7e5hJZcA8N/Z0ayS+iMzTQycbYE4tbZLlOKYU/?=
 =?us-ascii?Q?5coRcHbfo7tjlBVxAH5MRQX40HmhNWdGPb+93KF7UyW/nQKVjzoIvy4zhFNt?=
 =?us-ascii?Q?P5XcdXNh6weh4HhWzkghFJAKAPhX5fWYVoT53xCU3xrI+SVhfNUtYQ8DQ0at?=
 =?us-ascii?Q?lnqDpovbe5uGJWBOnQxoyw+BFh1cCfNwAtt5ikEhzpMKrJabut6ygk1YZ5am?=
 =?us-ascii?Q?PH0B9AbmfVbbI8TiziQY8/uCiqg+kjHxDy9L1/KGlRzeZVpGyBjAfdBYE0tE?=
 =?us-ascii?Q?up1oBwD7LlfpLm0Ce9kRCZafcePGlwKJNHyDnwHbdatJ1YpEtgAbrnV7Pz9f?=
 =?us-ascii?Q?QvjmXuUascZ2O+hwJo4aMzUeZ7LySrByi7JPL46uidfYijty8WDTKitJIz9L?=
 =?us-ascii?Q?VDlsmpMhoS2XOxCr2u7iYhIzXDObtgurxk0sqG6GC3dJokeznrAH8CP+3WDw?=
 =?us-ascii?Q?ODNydhSfxy5lKbK3CGnhWqPR3ZzG1HpXVHrKFAW5VQWKFSb0yiRmkMClBsVq?=
 =?us-ascii?Q?/LCRSee6jJyZF8TTvWx1biNEJl4Bs80sFCUAFSqmOYEmcXnBZ1BCCCOwGbFW?=
 =?us-ascii?Q?7sppFEA30DElg5jEAT5HR6eSDeml8bqjU87g1q3U5YWcT8v4BNevcW2ecHe3?=
 =?us-ascii?Q?itcZL9zQz8Hf6J1V6v5sZNPhrkUathRPrt1oinLu81V3aTraQ7DHtCikL29V?=
 =?us-ascii?Q?yZg9VhKJksXH2hAvpSQBKsgub5PX2gwPXN/Ml4rHtj8afjJRINdzG1/zE07h?=
 =?us-ascii?Q?3NYSfRYY3IP62xX56XYsH4+yq/ytVsoAJDbXH6SX0H9bufpUHsIylff9SsQU?=
 =?us-ascii?Q?6v1Dio362HOJ/NnUb0FJqZBibDVHt/7mmQlISEk7U/oHF6AXuIkvk0XLhmsT?=
 =?us-ascii?Q?DB2CNNvA+bxQw1KyJE+DWiPAPkBFpHt1KE6Qkt+MqqxqKPy8yjfRJVIKeNSG?=
 =?us-ascii?Q?nO74t2XucnpmgAJwmdD9XPO2+/8Pel90J97sw809U2f8enSUFdOTXCWSKzjb?=
 =?us-ascii?Q?VfLQ9gv/rkFk9c+enzqVtPRlgDqAmjTJ1dgnrZsZOB9mu03i+KkYObmtVkoF?=
 =?us-ascii?Q?YptJ+S0keeeodj0Nm5zGjOm8VdFMMPieLSDJZQrp/W4o4QqAyPHnF3adPXGK?=
 =?us-ascii?Q?IKHKDqzYKaBdFbR0szWSShujQ39xB47AnY3lsUFaVcLrTdWTQY1DrSpeGh27?=
 =?us-ascii?Q?VyMt5Uylev2dqX8brXX20saS7PEJXZXcQzsR95GeHcx6s00pi1NPXbIPImdZ?=
 =?us-ascii?Q?gc3IudpdU+wcqoYcTJzuKoyATFeYgjdPXziTB/VAdulIdlkfYymFORtuW7aX?=
 =?us-ascii?Q?h2bnWC5P2Xwwj7ujqVrxF9N2dYqaVhjTkq7hw7HysDU7/CHKF2kuxPkMxPnJ?=
 =?us-ascii?Q?8JFLqLjMIe5AQ/GI2qaLiCE6ZFFKoBUQYWWg84dTs8+Qq+u03RXHvF+UHEuM?=
 =?us-ascii?Q?1CaabErllRkOEnIaIcRfjxd52eo24gh1tBrrkH+Z5lY9IxCkOM+0sbHe8UCG?=
 =?us-ascii?Q?RdUpSglekToopNdW3bkeHX2MUHOeVB91WjY/5SW/U8kubxWdXsCrQJCO+wMz?=
 =?us-ascii?Q?bTcXVNaur0/jiIYftXEYtXq5J+0npmg78xm5AI3goIUssLiie7KBz1dXjGNa?=
 =?us-ascii?Q?e07SRc8rXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b46e51-7ed9-436d-e5c7-08df3df29f1e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 23:47:17.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vQor5CWWfHYcaM1brH4Iwxe5ncpR5i7Y6Euxwun94iWORD7bOpeZ9e+87nKQweLCW7t3E4IssscYbHTb1PfXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

rcu_tasks_invoke_cbs() now unqueues each callback from debugobjects.
However, rcu_barrier_tasks_generic() inserts its per-CPU barrier heads
directly with rcu_segcblist_entrain(), bypassing the queue hook in
call_rcu_tasks_generic(). This produces active_state and deactivate
warnings for untracked objects when a barrier callback runs.

Activate each barrier head before entrainment and undo that activation
when there are no callbacks to entrain behind. Successful entrainment
is balanced by the invocation path, as for ordinary callbacks.

The existing n_barrier_cbs=2 torture test reproduces the warnings before
this change and completes without them afterwards.

This fixes patch "rcu-tasks: Detect duplicate callback enqueue".

Cc: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tasks.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5d060a5c4b6..a20db323612b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -470,9 +470,12 @@ static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 			break;
 		rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 		rtpcp->barrier_q_head.func = rcu_barrier_tasks_generic_cb;
+		debug_rcu_head_queue(&rtpcp->barrier_q_head);
 		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		if (rcu_segcblist_entrain(&rtpcp->cblist, &rtpcp->barrier_q_head))
 			atomic_inc(&rtp->barrier_q_count);
+		else
+			debug_rcu_head_unqueue(&rtpcp->barrier_q_head);
 		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	}
 	if (atomic_sub_and_test(2, &rtp->barrier_q_count))
-- 
2.54.0


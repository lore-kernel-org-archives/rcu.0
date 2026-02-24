Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD777344DA5;
	Tue, 24 Feb 2026 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974296; cv=fail; b=aFHzz8GpQzXEXwKpV9+9rLCS0ya0uXKgUeTeUWwWVcNF69MnpRK/PL07cQ8ruP6x812dmc3mb9dRP8u6ITOweUUWvmRyfvUrQc9Vxu9t3nH1nZZNpD5ReQ12F+hE+Rg9lZOnfXuEK2gb1Ak2b9cbZ32gO/khc2RrY8fR4MubZx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974296; c=relaxed/simple;
	bh=2GeXEDTKHp2+mWI/3VALbjSFpVrvd3r/+XxWNAKYI38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIWopEvjnuvUfh5d8ihzy+M6QhVpM1xLv2lLddnEOLiCDSApxygIdNDYYwtyae+NMn2P7CQgr87227jj1BOyCqBxJGeCM7estPfx30+v84EPCZGLi4IEaPV94UiNfUn+HtnCB0O7YA/L8ciH9jPn5ibDeAzg0p3xpLOSj4SRros=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O692/lSh; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O692/lSh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDTHZ94GlgIQoaVrtAcCiCCTX2ouoZ9hPZ7GgUtDPnpSRzCKTJ7nfYjAROzWeZks/o1i7zC+1XOfzttFYFX2JUToR3XjYdLg3NiZbQ4F71fSelhnq8zt95p3V1xfHFKp4J2AMbbaYzVOc2+I+R7SHVwywULHbjcOgia09X2FOLH71t89UiHXGMNIA1qsWUW6eF76176Y8jKB75JeJGeaIuzRYb9aexNjPqixze18hRanbidDv0vHYJAbd7yZTeyuAapQcVHMxza/QUCDlHkYNidVZMpE7LIm14xOPSm+zsapyrNQkoesFDEVOdkiMyntlXSjl/58ZRZMQPiTbZI0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cg4qtQTMF+To4ZMOB4MPlgcY4bJznv5hnbX0LZx2m0=;
 b=wQ4ui9eaqNyLI+Vhh8KEO0MRQu0yddGIhLlXCRZAPysarEub6EVcpgFMfQ7fXK56BAGHyyi22u+HemgUNKTko3YvZBxbU8nG+lWrsuPLM0x4VS/2HE3UNqA151G3hjj58X+3xeDumeX6e/B9wvGCouq4c1/quS5RDo28l+Cv1UlSOpn+PmClh19bz8kwFf5jLoWQNloV8CL2T/yO4Am7ndFPVhUIriiBxy/h7Oi6BvgUqqzJ1mNPiA458pA00v1/3Gqa837J7RD8EaLkGiGwUMKKPuATXvCg75Oq6RKo99lnXgynMZXZNwHYOPecZExQOeYNufrmrVUsRorvTChf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cg4qtQTMF+To4ZMOB4MPlgcY4bJznv5hnbX0LZx2m0=;
 b=O692/lShA9PEfX3cfgf3uaEzWR8/HuMNy/0+wfXqy6NGBLMu0oGgwwwC+gog31CA7USxj+GoYYHu0OPJKE58NC9AfkXsEU72ynFNIeVc1n2mBnOCowQTtXdZE/VI/6C/s5GIvlDsrWrOFiXgYgcitEgiYJK4WrguYkqsjx0UIcqX6da1NXTTBt744GyzW5dt+Pa/QX6XeHqzavhzZ58wsnYS10YCQjSeGZrhVbIGV1Q52CR/CnQ7oK7csx1ZuhZa4jv8JUeGOSxu3MdQgzK1H3alFfB+84Tetoep8/7T8QHyPiEoOOneHU+nTcv6o27zu7wV3MX09aNlwjbdI+2Qcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.14; Tue, 24 Feb 2026 23:04:51 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 23:04:51 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v1 3/4] rcutorture: Add NOCB01 config for RCU_LAZY torture testing
Date: Tue, 24 Feb 2026 18:04:34 -0500
Message-Id: <20260224230435.3390963-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224230435.3390963-1-joelagnelf@nvidia.com>
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: f0858163-97c9-47d7-da6c-08de73f91d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VHK5BSC8N6SqWgWvpzJ5v9Oskwr0UYM79H0P+N54l1/eknntGHbkWvtP7kwF?=
 =?us-ascii?Q?SF/iWE9+fYygylpHic/4QjATP3ORx8IkO6FUl497FzhZIZj1DEKRuArsAhcQ?=
 =?us-ascii?Q?2WUz4MUKf33p/VCtRACqlkAIp6xZ8P2xj6xET/AzAmn483vRBsVQzEwT+gRm?=
 =?us-ascii?Q?yTUdJKd3FLzl263ZgWv0IAKM6jvSmHs0gvrs8LJgTcMqrqZrMp+5Xsq4EjaX?=
 =?us-ascii?Q?DhnlbYrHkIaDxvvK15PBGa+ADSFYC53tSAqynKoHn/zph0BuMOPmaut80ZVz?=
 =?us-ascii?Q?PxwLj/yXrgyIk0tLeXdlJKqusdwo6K0BnV+LBzaaXtk9y9bLT9hppkmy7Tc1?=
 =?us-ascii?Q?v1DhXC2MO1YOMxBhpCMttARDTQZD8YYX5JfaxOHPkoOh/PEBqncR5bWMLxow?=
 =?us-ascii?Q?QJJuKgzpIAu4dSZZ6WWrNMZM4EAcUDD2UDne3H4yqip4CobU8UD99xw0FiP6?=
 =?us-ascii?Q?hn6skBKgzdqwyq9150tSal5QJt+OuY5DXlYORVcH08aOyFZZSFF274CDHcxc?=
 =?us-ascii?Q?3kO10OtrErJ+q1Rb179L8lvzjJvkoXAIhKti60R1p4lEBtpvZX2I425xGxLm?=
 =?us-ascii?Q?IFst5Eu4VMgcp98uv2v6czfHSt2tgsSPqwQAjERsIDRdHW8dnEunbiP/Zub4?=
 =?us-ascii?Q?6hc/UBEjWSwQ7JdjuGGoBZPUzymETHZjIC6OzYlgjbY3v9qkEfd32nDljmUl?=
 =?us-ascii?Q?JKPJIi78DH87rjUsv4X41M4VrJZpA6tSGlxS5TyJtU0JVpaOLxy9gKGrupmg?=
 =?us-ascii?Q?eGVoLooDk5jsKiFZ9kLkxeszspcnlqB6P54PLodCIatlCfeZ2ZmqeCfDRaIL?=
 =?us-ascii?Q?2mNVC0vjEE9Oe9e9lfpPX/wLDB6mAMLlR3+EnSNhwOaksDnILIfUkCVO3vOb?=
 =?us-ascii?Q?zQO727l9/nekRZSyfb3erHJTs8NJs2gnKk3EnY0nf+4F9FOYjE3vPVc/VJTV?=
 =?us-ascii?Q?YI9XBCqgVX9kjxNUAsPDBq3s/OJ1aa33U61Wm/6Lveblf6hMfUgW08+rEyBX?=
 =?us-ascii?Q?dFiuCr/7Xvn+oNoC4HAkbaQmBEYuQM6tBrEXW+uRwknQf9Q9JgWO4FGASzoS?=
 =?us-ascii?Q?Xp18iBG4aNxv5rOSWhUpllvl8d9pnvJGL79DDbmIOXShnzZvk1Q3Ip3DgR/I?=
 =?us-ascii?Q?fKLlFr0QFPDwdY95fYC5nL+zeW2PKCIz28liKc5hU1n/dOq5mXtVTxd0C27v?=
 =?us-ascii?Q?fOR/0mGdehUfKJ5W5y9K4c1oP3IxuofSXL0crHfJ0alh8zoF7tsYNxoCQQ/J?=
 =?us-ascii?Q?eewfaBIFxCmUDsIIjwS8GP1HbHLbxX92/vMassrefg9WCJbBAWvfjB3HQdHp?=
 =?us-ascii?Q?mnIlzYC52/LHa2dMqIdpkFlyTe4wmvD1oYcQQa1OprdjW1GRlS3x7Z8IJ/w2?=
 =?us-ascii?Q?c/aNIM9LhymBLHT+cvJN0H7VyWDcsHJ8HEOmDQ2v331PRnuv7GpuY0WzJDmg?=
 =?us-ascii?Q?mINUhAwfXytvzXvweMfEELZd/rVkjF6DecNAYc9mL2wWdVCKmTRaWgp1HrQ8?=
 =?us-ascii?Q?ps0Od3v0Vf3G6gXUzHFiwIJR/Z+kdiT0kGOj/qnjwINd0QUrrHj7wBWvoWtx?=
 =?us-ascii?Q?lSJZrI0HF2LbEghgEXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C0JArJo8nwhe+XCcLeAMV2HG0BomQAx006r5jm2Jr5AhLVzHDebkk+pf7IFI?=
 =?us-ascii?Q?EAy1WT9xAzHTESO6pmrpUEFE/X4Js+hqxBi4g0J/cuDZh6utGyoJL6HBmdLX?=
 =?us-ascii?Q?/0vNpfzjvfQdqwXpDK3+K/BKbVk4P7X7TFAlB/tJJyWasHbItoTPHVdxKvOo?=
 =?us-ascii?Q?OHpxw1x1nEOVvHF6qlIkhjAoymtBsq/8NZPshSgWmPRJLYgFjBsU1EhMw0Q6?=
 =?us-ascii?Q?0PIvlrreUE6JdERFjzt4t13DJS08/L2y8ie9fBkcuuY6hiR4nwT5YDzK79ic?=
 =?us-ascii?Q?+BpxtJ+oS6lu5qjO27ntRnkktNW+lzOHyetLh4fr8r23fTXLfjVgwit+XTZ2?=
 =?us-ascii?Q?W/VrMjzvPRW2Ojift2ouS1N6qySmh6jWcG16bEIgZB/GvDrylFUunlkgzqlj?=
 =?us-ascii?Q?KmXRds16tHeFCTSM71aVVNP4ImFpKKOfE0H5MnugyvdHS/nqfwou/QwBDdIh?=
 =?us-ascii?Q?ypuT80CM02XD23TT+FSXb+iRoQ5Fm/Ukorpf60MrCBx02NgqG+bDekXnyDKw?=
 =?us-ascii?Q?sTMbfT2RPX4aet/nMp7bCsE1GxYobnk6rP0IL9M+RBipfUZ0+o0cC3e8lz33?=
 =?us-ascii?Q?9pgJxyYHq888QPZMtH7JqGxQVaGbrUYcOFHj/ZI8VJSl9t5rgwhF1WvS0Zmq?=
 =?us-ascii?Q?P3SIHQ+nyHUUfKGrzEJkty/ILmtvl9SMseGCdyk5TRMKKGGIxiO40APxtOaj?=
 =?us-ascii?Q?Y/LZU+rdjsKkF8ENgah2i+nTqupxXDXFAsGaHctAQLzQMm/krU86l75WFPQ1?=
 =?us-ascii?Q?+8KKK7uE3G4U4d0suaG12970bsQX8kQmIE+TH6NkRz7OWE4cQt8LcZX53eE9?=
 =?us-ascii?Q?VP5tKFg9wQtugnGkamd+r2Srsje06B/qiZAle+raKxKUcBls4OMbZJ3oTSjM?=
 =?us-ascii?Q?UgUvfgNcsbQeYSatqJLwMkEBUQ2qrZbFk3m1/1EwE2lXBgeR2BOCnpkurP5/?=
 =?us-ascii?Q?Ug3WqcoKvDRCfWSWWzWUDJRq1lmMYQzgsrSQVUQfT7lTBiU126qPUA/pQ2Nq?=
 =?us-ascii?Q?0/quR1/aFiqMCoypNu5OH4xZMYLba3vLPFoq9VSu+pbSkhbWbMWjdNP7SFJX?=
 =?us-ascii?Q?ohRN1fSG6Y7JyiU3hic5iP2s0D61eAC7TpM5KaMs8wjdgTV28cnmo3Ttgd69?=
 =?us-ascii?Q?gnx6jcWhUvpGSps85qVbrwU8NJD5ylwdA2TtPGSSg+Qd2eDIdKp7B9mJc0sa?=
 =?us-ascii?Q?2QhMAYAgJb8k190CZVMol5aFTPR8oG9vGiVW7DnQJozPcMZk41dbYphT7y/n?=
 =?us-ascii?Q?tw3Eld4CEPcgUvUnZvVWkDrxUaXRrT9bnlJBugeXea0vbmuiTzakqOM7chMO?=
 =?us-ascii?Q?eGHhdMUONnH3KWXGh7KNhMvDvWSjfczFKKCxmMUcJAmvSGmKrGoF5PJs2Uz6?=
 =?us-ascii?Q?sbUqBeAOtbqfrFVPsGSyXWHNoyVlQbDeLXM3PjvefEMLktmBfP4Oa8ebcKkY?=
 =?us-ascii?Q?rn8s18WxQDhN+CQjU86FzX1GWqMsvxZ0wGRfisz7NRRQqvm9qC8U+lmLCG7b?=
 =?us-ascii?Q?r87F4PUz1vmJEt3Ee0/GgOIZv54r0LhxSJkejrjvC0jjQdABO66wcNkJgXpN?=
 =?us-ascii?Q?+H1NA18X3203UzNiHz3dr9FMGeje2OI63FwhqGHVv1DJwKSHufF1Qa9bnU/i?=
 =?us-ascii?Q?sTXFHdH5111lrBBaQHltxGgxo7uIHpae13QknWUB/Pjk2+Kh7SW/2J7V0OH+?=
 =?us-ascii?Q?XjReoS7mvS3FhVvtZbJzZY97TlsNBf0KcnovIhCh4rkYKKC6mEswPyk+fqhF?=
 =?us-ascii?Q?hjXnFVJW7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0858163-97c9-47d7-da6c-08de73f91d5c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 23:04:51.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GPXu4pIjlPUzxkPr89lbAi8uH8oMUXKw122xFimDzMlhNKvXe5vOHGSmfnEAB+QhKxu109nRjIlJ/uUR2nB4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

Add new rcutorture config NOCB01 that enables CONFIG_RCU_LAZY combined
with CONFIG_RCU_NOCB_CPU to exercise the lazy callback code paths in
the NOCB implementation.

This config exercises lazy callback paths not covered by other configs,
including lazy-only wake and lazy defer logic.

This config is not added to CFLIST to avoid increasing the default
test duration; it can be run explicitly when lazy callback testing
is needed.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../selftests/rcutorture/configs/rcu/NOCB01   | 21 +++++++++++++++++++
 .../rcutorture/configs/rcu/NOCB01.boot        |  2 ++
 2 files changed, 23 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01 b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01
new file mode 100644
index 000000000000..bbe6d28210ab
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01
@@ -0,0 +1,21 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=8
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_TRACE=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_RCU_FANOUT=3
+CONFIG_RCU_FANOUT_LEAF=2
+CONFIG_RCU_NOCB_CPU=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_EQS_DEBUG=y
+CONFIG_RCU_LAZY=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
new file mode 100644
index 000000000000..5130bc84c435
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
@@ -0,0 +1,2 @@
+rcupdate.rcu_self_test=1
+rcu_nocbs=all
-- 
2.34.1


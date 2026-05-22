Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2F421F17;
	Fri, 22 May 2026 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459851; cv=fail; b=P9K/gHGeuScnBITgs5E8AaJq8WMJAOzrhNcFsSCBl+/hRhz7CHgEsaGCbBgqu3ZVCCZiHMknMX1STsGz26eC/+RaKYwg9IuJLExA0aHw+a1xk9iPZN6YrMYSpRR5OFv579DGyujdYZnT5WfKppekVobpdf6G8lRM1mhml/Kxx2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459851; c=relaxed/simple;
	bh=5cUsGHCX47yjmjJTgFNT8J8NEigkjsQ6L/A95WK4c+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CqmCOxEmq5T8M0vEIvER0clDlH0/HQOAEkp3tR2CPpfuM3oKpfROpnrLnanHpxey0Uft80whgWKubfRhoJ4kFndxQmvFADga8RxCumsRsc//RaYdzk4L2mWkzOJrqYhtsA31CMQgLyoHFikaYJZlnjxh2Gg0D1sFasN4c8SYzII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n+MU3pX0; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n+MU3pX0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQGrUj20WO5g0uxQyaSR/D2w6tvq3/rHBI5/sKQtYIkLR8IXRc5DK+Amj3tkCF63lQwpSto/prvNGSPt1mRoAxAGufnt2dA5yxjIH7m1bqMKhyGUIKJFRHUzWdHW6JaQFOKaGPuvKkBnWFu1QuvxawjSbQsfof7N78uzYf3+imaWMluBjEIWp1vnhXgHnR2AYow07Fwby9/Hj7EZOcKZlx6VzDf4Uqv8n06nD4M1AJSa5RRH5tIBVv1pqJDNDPL4V/zgKbYzpsNVOhytDJsLOc2O5k2uIVy8eL0i+quYOj5r7fJZAQjhoAG5Qo4BOiSzSLjt1cseWCMckGvSOjnkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCBFTBQm+wrHDEdstVzAFKfSRfgAapC0qWBeYstsKAE=;
 b=bmfXDPmKYr0N6/0317CWRBEv3bUvhDqtmZx0hH9LFkuw69taK32fXDRPydI9ntH5qe9U1V7FqGCcufqk4Zab+LssEIabaHYru1JC+TMKe6koRem//pB7dkUUAxev4Qkbi6mVMJzmADJZzdDDtuUCZ6Uov1mGbg2uIgUnuCpgcheBNlLjxfuQaGZmw8gaNUAyflHOQBUloqBOHT2KzoYXtkrFvYQr+odGMfwZWUkg8pMnt1AXQ2u7RaeiUqYjGunQW58is5AY0B9OI3oNAZ8kHpgjkM87xs1FuXXT2WY7v3BJUvMZZJYWh/3c2P01UGTGjaijpLdbxm7rxVSc9U8IAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCBFTBQm+wrHDEdstVzAFKfSRfgAapC0qWBeYstsKAE=;
 b=n+MU3pX06zHTme9sfneLzgDZDAMvIOG9vJgf+LrTT9SkWU5Oc64LM4rN2FKQ//cZZvDVK2cnEoFqHmk0diQA8uV5EWCEQewiOihF+AWH7Et1URZWzfeBPzLM1Cmyo0KOnBHAm0ZUe7yI39VcSBW358Xar1rHAxVupTl84idZjKkPF5fhjC9xIOz6SKqTOkMcly3VZMFhk2N8/t9hWgSl8IVwbRgGbPNb8wKWMwsCHXTAq23l/xhf0rKAXsTftSgjHosN1ZwKX2jfYiKVMqgfMh7hjJKeNltka7uDidQPgdOw199RVCUKrfyKVMASQS9CRCR3kO05XJHxa78hTMqfdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:24:03 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:24:03 +0000
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
Cc: rcu@vger.kernel.org
Subject: [PATCH RFC v1 2/6] rcu: clear defer_qs_pending when notifying GP changes
Date: Fri, 22 May 2026 10:23:36 -0400
Message-Id: <20260522142342.1536533-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522142342.1536533-1-joelagnelf@nvidia.com>
References: <20260522142342.1536533-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:236::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 46022ab6-c9c2-4cb5-c147-08deb80dc5ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|11063799006|5023799004|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XAlTPvhjHY+3+Qnmhl5GhyeydYjkxZShKMOJ88g5J3jeQTY8Zf6jIo5b1FEgeyRSJVIHceM+t/cHy/g6Uj57BYECmxkri/fuhzDWoi9aJ1PW9nC7hVHj9M8NHRsMQ+EQmQNH8pLQYmln8lAxUjpnbaVbZ+fnt02G3tUq7vB0MODzmzt/6CBbFQh6geZCgUW5MkM/Q2R8OLGMAqTmSv50Zu3B7145r8Qm94A7mh3SKsWSvsm2iQ6PnA8I1v17y5TqYCh4Y2cP5gwoYXwW2Q7zX/r7kRmTvuN0Jyxd7yF2QTU9ly4eyWLbc0QAveYS6MJwfPslTg6JNqiHIU0JDUQMqg6oVYgVBLLAHF5brAV0tSum8EHQq5ai4n/L1xWNjxaPHIJEh7iDlOF7T9m02LTAI/0U/l328VOfDx1cG7ld3Fsbg13qoS0otc/I6q7LbW6hR8Jio2uEsFExiXQ5Ifkrk0QarRHACTVIjtgNDH+stiTdjcT/635hVJCH7Dcxhwy13m3rFl8HHEgeuRArV/qA5SbJvmHEDO3SSJZYXEF5Nw08eLb+45UmTz94HJjShDCXzQs5DXmAk49f2t7527/LbffCKH14zzckdGWamWjCqoaWZp4ubrI6jlRhmNKVWiwBL48IMSpO326DaVVqtN2ZzQVIrRX46SOK4bBpkC0oDnEjB1DgPb/ih6eG9sjlaDKfyztVxIm/4h/kv5nU4F93quq6bButTiQ0tuHpJcKmylc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(11063799006)(5023799004)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Cd2Ndxtdx8S7Hq4KysHHNOA+TWaSNsQVfMdQTtvnjdLeL2aZPLsCGfDVxv6?=
 =?us-ascii?Q?r0EFBmwaSB/oiCuoPrqn9Eid5kAJZNHpz7KggsGLsQfUGaDytaT/a1nw+EZO?=
 =?us-ascii?Q?ruI23pR6J34J/986Q2T2U55lNVu0d1DnbL3leSXcnRku69sjWbdmS7yG2W5J?=
 =?us-ascii?Q?sNBmIYqJ2hbKGC+Ntt0aX2duLnPvWfyd09aUnl4+qG0yMrUl7EHDryX4J3sM?=
 =?us-ascii?Q?9wCfsY4MokpRAp1dV5BCZwzZcVXgTttdskQEf5LvZs/etbq44+tHju5KNuEp?=
 =?us-ascii?Q?gWs9ybAqZOfMBNOWI76Ukk5Wafh25cs/N41s3JsFX6oGq0CFKMsr6smFlOY8?=
 =?us-ascii?Q?hu1fZUbx/S132yZ2e1O1yQz6yiDliEvixae7HUL1gkDwMVLhbA6Sg0PxrXmr?=
 =?us-ascii?Q?4a8H0Zpy5rQEVae6a7djAJIQIynPmHIlngKxVXveJu5ZSmA0cWzdBrP3nauv?=
 =?us-ascii?Q?oH/n6jbP5dE+x+IJwu+B2EGTrtYgivBTG/clppGcuac3SPdek8aW+iGeesxg?=
 =?us-ascii?Q?AbRPFYdMzSh7tsVrYxJYs+FYQnQ1g3UY65Y2X1+lH/W4xw3MWuVZVYIC+yZE?=
 =?us-ascii?Q?5APPhQH1ostN8dbL+q99Pjw1SBj0LybnGn+/joaKrr4VhDsUeMKcpBedUWEP?=
 =?us-ascii?Q?aKkPjXearNVon+fNmMiiqefoqllmp1tDMqpkLvjrhKVL0SVUZCw+sb+EfcbV?=
 =?us-ascii?Q?hQTdfU/Ha0x2FXZBn0WwMYBNArbHRnkNGpBYmHmFgaTM0aoVAGGpaLMv6KMv?=
 =?us-ascii?Q?IFJHX0jSsYtmYHcUijhQXPnlxq7/uWC1IywnyaKqpeG6tfkaOmSMhaKUviV7?=
 =?us-ascii?Q?9v+xKg6Rg/y+Cqr5QNZ5bZjB4wgeMv5MkldVjiPBOr8oNoT4pKMFmCAg3p/X?=
 =?us-ascii?Q?7JawVvLVuSf+bKjnUJGlwZoHU7MiVBeRrmIeccKo/8brF8dcVm5R0ZS5ndFz?=
 =?us-ascii?Q?3JEyWAeORxnA0deQxnLnPU8uh7sF/OZqQUBuJSCMlz6WB49+9MP7SFJVsWnH?=
 =?us-ascii?Q?Pdb+Ri48DfvZg5NHo9jdL2aX1q5Iq5kZuZ7IZjJQBY+FD2PjjeBLegtmIHLV?=
 =?us-ascii?Q?9+rAxrYj/zWb2kQV53YpOn8JUBztWMNZ2Fkb2DFUKOrHF4arxdDbaa2OA8F7?=
 =?us-ascii?Q?8z7IqjAb08hZ16hJgdMAtyCBpJ0lgjLmPpgj7Jt1uB7l4WfUSnlF/AHcnBj6?=
 =?us-ascii?Q?YSGjk8XG05WxzdvL85pdAWnIKKuxTmsNt6mtzhm+FK5LBPZ4cROopbjlLFxN?=
 =?us-ascii?Q?plEIALriYaTcvXGvntZxdxhhXUivjyjIAqXYF9kvTtGLDSTtL/2CCz67kJHv?=
 =?us-ascii?Q?kfnmIaqjUV7kJovkQGlzdvmJHdqCAMezLPHeGrT8aYaww79seyw8PL4V4A8g?=
 =?us-ascii?Q?SZYCXrobzTyZCS5eWEG/s08s0ZJeM7P3QySyBunUWrik497ysgXCG0yTkKZr?=
 =?us-ascii?Q?yCsCTo+QTf73dnwraSGlsm+ee2Crkt3MA6m5Xg4cOowmMEHOJwJX6aoTphDJ?=
 =?us-ascii?Q?duYoebnnMtctDbzaI8Lp1Whpsmk+Pxm0BEjJ3/8mb9bNfZ8fGj5arlMZysFM?=
 =?us-ascii?Q?cLk/OgAiV/Ek1muljMYvYnScUn3NU1nhI9xfZ+IAo/d4pSlrm3rPHKGOlDyC?=
 =?us-ascii?Q?U2z7CO/U5wPP5ezugJYApUtIY3yhMMNSCK+BKhgm37RfxXuxrW1LWQ5OcpkU?=
 =?us-ascii?Q?ttD0N3F9S2rs4FTLBR6Dcc8vAvJUDpC8pKUorBZ7dE7SU5NcC7vHGlXanOeD?=
 =?us-ascii?Q?95Kh+ROLkw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46022ab6-c9c2-4cb5-c147-08deb80dc5ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:24:03.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDciI2RtVbLFRddVoDFsTOYPni/EDUTBqPfMGNdipKEahKp+XWkNuk/u96LCkQsptsLUezQuueh/PZMASnXDEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

Prior to this commit, defer_qs_pending was an unbalanced flag:
rcu_read_unlock_special() set it to PENDING whenever a deferred-QS
mechanism was scheduled, but the clear paths did not cover every
up-tree quiescent-state reporting site. In those cases the flag stays
PENDING after the QS is reported, and rcu_read_unlock_special()'s
pending-gate then silently rejects all future arming attempts.

A test patch confirms TREE03 can have get into the problematic stuck
state very quickly (< 5 minutes).

Clear the flag in __note_gp_changes(), right after the nothing-to-do
early return.  This is the natural per-CPU "GP transitioned, sync local
state" hook, called from the GP-kthread's rcu_gp_init()/rcu_gp_cleanup()
paths, and other GP advancement paths.

For dynticks-idle CPUs, they do not call __note_gp_changes(), but they
also do not arm new PENDING work (no readers running), and on wake-up,
note_gp_changes() is called before any new reader runs.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e..d0816468ffee 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1281,6 +1281,8 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (rdp->gp_seq == rnp->gp_seq)
 		return false; /* Nothing to do. */
 
+	rcu_defer_qs_clear(rdp);
+
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
 	    unlikely(rdp->gpwrap)) {
-- 
2.34.1


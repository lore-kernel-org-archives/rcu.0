Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E45661;
	Tue, 23 Dec 2025 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766449850; cv=fail; b=B4hqZDfn0q5tfiIiOPKcYUD7Fs3uOuvyQZja6eRehhBIMSFcv4XIgCeMiu1Jb35XLnPh4h4JLrrVGLb9Cvf3BAMugDJfXyg0NXl1JiApt53aqxV7n736T3IOZ1k+k2UCSSbYrJsD+rtTeoabe06SATPZPjSgbf0SArCi2vIKPZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766449850; c=relaxed/simple;
	bh=jRYIEEK578rTjmMuoZ1KyU3ayg9PcNLuZdKgjRn9FvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R0Lwycm7lkscmFQlquL3ioNs4e5j11XyMGGQYN9XGSvIXmoJQEznVZCeusuM8b46DiZ6nU5lr5L2ahlV8q0GhQbApYWgqSYOwBc3G/eN3xgISwZRtMAALsQjpN2IJSAvkUoR1s5xF2A5x/aZZ8dxXylpB2lTHJtFNRNyNPAWzLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=APYahZ7c; arc=fail smtp.client-ip=40.107.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="APYahZ7c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9eNUxFwLWUGtDBNjHeIC89CjPCJafeu0O17kxL2OvCMdnQdsE3Q7N26WKVEgFb+QCJqdF/X+A/MDs0n8D0MxAw4EFBllLlg9EJsod92FkIWvEUgl5cmF8Q5a2rwk/Bb8K6ZbSSEM1YxU5Rq63M4IxVAKXICDH1zFSLaFQLCFhIFnCFJGj6uy5M+4mvyUP+y9VBvJxchvtK+R1bLCBZ3rZXSOo7mPpi4sC+rI7WcC3GO8Ukp10GqKh3NpZpg5cqJCPXS72BoYm9thWxxtZ3HmjiTTxQUtgDaoYKGlAl+em3vL88oGqN84+7DGAWDkd2nl2Lggt8VxTTJmiD00Enqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3x/fhTloWgYlQFYv68HKkY3PFu/QDCWT5sO+qih4Rw=;
 b=bVCml/YkQzcJ3yOgBbC0dD6MloQ/VMkQjdINs3Gew6m7LWurFnRaY2PZXSQcLnhLFxGBuoCfYs2eoWNG5P8ZkMENXq9vpi01V8jBrC97evBO5y73hOBg9S676TIOYP6Cw0OmoslQ1pL/qHgrQ0VESiI1ODiFTLsh4xeQblzDLut1cO4bP0d5RVsSWYiSLKvikgb88qpu4XdTUB/yJXTl683zpVIbqlYBYCchod2vnI4gkijZYwWDGtUAVs9Kr+dFeVtZqs1liyTrnBL9YKxUCGMpfwWO0B6WVP4665pP8EN/DgAMOK+FBZ8O7ZKiWbItYY9NtU7J+HL/h8a8jpdW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3x/fhTloWgYlQFYv68HKkY3PFu/QDCWT5sO+qih4Rw=;
 b=APYahZ7ccymZCF1ASE4uaBLqe12qQMNWAVvC7JmqAMBVlrOcYbf7DnNigwtxfYB7YqF6OpzJPkWRXXyOepFBm3za0ooxUUdbOAvA66W2knmaVfTNHK3hoCI/BNGELBilPqAZPsKt5t7wxY8GVmR6XAeDhPMoa/vtUN3PCHozJW7DVfEVsWDV+nHyQzAwjNk25Z05upbKy5nJewgveE5MFSGE5qfwoPV+a1ek1TysioQ67oMgHG0OPZZRB5kqx3v6zYggFAnkju3l1xGxMJ7/mTJFoeg1f9vxWbV7W405TNtpYeCt5It5MXSS+eHjE17J5CaSOVYm7EVz+Gk/vjrg/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 00:30:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 00:30:42 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH RFC] rcu: Reduce synchronize_rcu() latency by reporting GP kthread's CPU QS early
Date: Mon, 22 Dec 2025 19:30:39 -0500
Message-Id: <20251223003039.59161-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0035.prod.exchangelabs.com
 (2603:10b6:207:18::48) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bf758c-d303-431d-123c-08de41ba819f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PT0m/RKFXDXfGsKgTHuw+Ojm/rLi0GorXusTSoEsLAga1B/ndWv+W//+svnl?=
 =?us-ascii?Q?YXANb2PotSaffcaiZFwH4wxfjOa/OTt5kQoz+CVYfCxWgE47CI7NtRjH5da+?=
 =?us-ascii?Q?Jl/Sbbpy8N7n1oTqbjupXzkkEPBDvlmTHa9xZGRHJzNdtbE7gUImzuZrFj25?=
 =?us-ascii?Q?k2Ryv6C997RlMHN4/IezZoqPXjy6caSaVyOY083vsXVME0IOkMy3ws/SK4TH?=
 =?us-ascii?Q?qmpNiGieK2MLsqETgvcKhynT65hDny6ccwbl4+wtuq7/fpjBkg12efmJXY/b?=
 =?us-ascii?Q?t/ZG12Jv4YPU8uAdBKE4zwKE1tIVDrJkfhxWxbdC316JPUoEgds6kRFI/dZE?=
 =?us-ascii?Q?KiWCAUbDDvFVu43kNv0S9QoMbQ2JqoV5X15Ri6+lZ489st42lwGnq+kM8lGd?=
 =?us-ascii?Q?6o+SKKCilw4yKT52VPRF5oBjeKJB3VOqp1nj/zbaMBD+acG3c3G0v4lzAb7V?=
 =?us-ascii?Q?eZFQbz/6CXaYP7pWq1uxJKl1fXK7FFdBs9uzba1OfupQPiitESnkIz73+bJk?=
 =?us-ascii?Q?vvaqzCSoLgJjpOCWUEZrP+X7zR8pG2rFWQ1BgS2CHVqiGilZw8gwTdiDbnzX?=
 =?us-ascii?Q?+JxJtC/fXKdERPOFRdbgWOQwWQKVT//b4ubBglL8nDerbBfC3YsPnSlcj08d?=
 =?us-ascii?Q?EoEz8ehXlMEHRRn1S+lEu9nrmK4LP86MiUIHI/J4p1MO+Qyq3Q5u95t09xHp?=
 =?us-ascii?Q?Xus64NYhZOimQorNN2TkHhNL4q31yA5J2dTPXSOzXVAGlmEAk/MBnnMhPz7K?=
 =?us-ascii?Q?52SBdthO1lrlZB7t0SjSZ1FWvnqr5f+BPaPZKqHj8BVJzW4oRZfOxF4pRilC?=
 =?us-ascii?Q?iAJllQ8RrfdmnYqqhA74D/pjEGeX1OGt8N+5ZP/ZavFjCssss7ORGN2HRmF7?=
 =?us-ascii?Q?J/ZozZ88uQ6BQ0f0AdQpF070tunbGWmKZt4o4s14RAbyZKt2EtahawQyDfI3?=
 =?us-ascii?Q?2DoIQACvKoxB+aj/toHS7UU8OIMY6N4c4a0EPfKqQzSQu7+cPRS0rte8NEOc?=
 =?us-ascii?Q?fO9jX0WbQ7b7Lm5qMbSO1usCzLJHIYP4QjmeE6ki0CXoaTKHQwVIUkJtSB+y?=
 =?us-ascii?Q?juURQXHFvD3graQadqDIlu328vpl3pbbzG/NHiiM5ne3Mk4C6bpf2f8Ghl/5?=
 =?us-ascii?Q?6Yb3+3ifwPJaiV1mFcMSao4HBTgkO91xc57SvG+yVhqi30FUZ/vs3AykVtcf?=
 =?us-ascii?Q?SPNUkK4tycKFdSWDqn9Mamk2mpDm3TxbI09tUiRaVFxXv/0IZT6y+LRPOgc+?=
 =?us-ascii?Q?AUFAN8OSgeliOu1cuApX1o7iTtZo1U2djTvoUEd6rOukuylC9G8Jqm2lK7xD?=
 =?us-ascii?Q?QHrYsbIvIsSmz4dnKbhkMJnZzez5qcAGTA6ZGQtN1JaNdPxZIcPctpidAs4l?=
 =?us-ascii?Q?MiFaNw9qlsH2tiCn5hNg/qXTjcLRdk5jbyACZmwL96rSAkbEcchH94v62kfg?=
 =?us-ascii?Q?I51YUNNg59EHCEEWGliSv9IPcEw4dwkVGZ+WqofY01SBCs3TRFAGX3HcvYfC?=
 =?us-ascii?Q?Hp5mEDK/gMw0qiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QID8iSJWBeiCEUvfir/qToCfNA+X33Tq97+WnRMPumPKuqBpfJZ8GcYp2ZVx?=
 =?us-ascii?Q?olTS2Shco0s3YBIJ55+1E8n2E2mwumASWWLvEAT59l7jfSytGdia/s+eq9aG?=
 =?us-ascii?Q?LS1c6IKNaacbmIeI6BY8eqcMDqSmqSH6HkVXvR7FkaBTuxOqoCVmd86lzjUg?=
 =?us-ascii?Q?2CARiNynn1wpZ87TER4uTxLEE9ov5FEFzYtCS3D3es3mkxhKjvmBGAwnONo6?=
 =?us-ascii?Q?ZwkN1VRgu/nd3r+piYo8AJt30Na0b2qkAOtkC28d+M4wDDpUd9LfaX+AF2d0?=
 =?us-ascii?Q?vIJR6GPZ9blDZuv/1uVs5rhByfB/XPXdKCfOHAT8oJmrV0wyuuelr8FVi8Gc?=
 =?us-ascii?Q?sJnad8e41QZ2GhFcZkhFI5tbDriKpszF/iPLC4Xo5BaggmBfhLj6syjCfag7?=
 =?us-ascii?Q?tM1T4NEThaOYy57s1dFI7znlDimXLVkSXWAz7zMv2Xz3MBKuvUT3L7XO/1yR?=
 =?us-ascii?Q?glWpWbwVqhoCe4r+RW/gZN+y5OwqChx66w43IiP8fG4sqN9hEbDyK+r8yK47?=
 =?us-ascii?Q?PzRIvCzETgSS/YjtgATGKIjXWsR3jqHr9ucgyVfB4OiiytLIt1TlprRXUjDL?=
 =?us-ascii?Q?mIIAWzIIWACkhUukB75AfiGQvwkW1wynSrs/zhHgIBALOmt70F2rjxOZiI/5?=
 =?us-ascii?Q?7Xw2JnsqFpNBmZEpWrp0OV0uLopd1VbDBCoO3sSNRWiyMj8YhJkB9i8FWl+m?=
 =?us-ascii?Q?eiwC4sfg/shgN0HmM9a411B3c/mYJUVvUIUCktJ/ziy2HlDefHcm8zidq9mh?=
 =?us-ascii?Q?89JkTLq5lNlFl8RIFSo6XAQgHMDKddSPhh03/hxDCfUM1oA3i13d7YDdsMND?=
 =?us-ascii?Q?uGJmsAS7yfz0zeVSeHN8sd0MRTulEPB5s2r4jOqM3hKYM2a9AYMLap1kGrme?=
 =?us-ascii?Q?GVyj8K+Or30g07CgCeWK2Z0w1m2GY3uv8qNiaF1DaOq85l2g09EeSMdaMMRP?=
 =?us-ascii?Q?iQBGY/lhWw9boSyQfp65fQCtEMvWj+hCnKnKSKKe4f/L/CkmLeh4T7aFeR+d?=
 =?us-ascii?Q?PHvzhWXZQ1+8Faz1st5kjp1Gm7/xSXlvpSLKCRIX60WXzax42pBHXVzo2oiT?=
 =?us-ascii?Q?DxYaEMn1M4vwXZW+9phr1FMrdjo6lSUpsAZDAeYXj2jr0EArAg1Om9o1/58D?=
 =?us-ascii?Q?cq6G9o0cQyk70NsZJlazk5Hn+t6xGvUykrVrd9Hkr+bFW02a5OGU2DcxhlEy?=
 =?us-ascii?Q?9yLDo+BtDS5bBzviFLFYpOpMfI8dcmCEF4Li7WgDMBYtUxvWeY1yfZSetaBd?=
 =?us-ascii?Q?Wm2LUfKC6lBrcrFuPFSJ97h313cY0S6AY7uv2RJM1kDGf3sWBXAyE4UDAoCI?=
 =?us-ascii?Q?lWfYf0MabcGO/V4oVvxcIsSlRNS1EHLXbIfiks83sXEnTCDFCC0+SUER4CWA?=
 =?us-ascii?Q?Y1FNFkLA47ZQ0RNcQYzMq4PpSSKbeA3fVvb/VjmCuAsxJtgfCCRkRr2yndUI?=
 =?us-ascii?Q?HiicLMXfQ9pIEA+nzX/S7zTURyR+/frWSxFkzaQxcr2cXr4yZWHtHpxJH8D7?=
 =?us-ascii?Q?QJDl3Ua0gVIx4vTzyGWconbxv9h3k//koKm792o/cHRfo5TlQxs9pYT67Xf+?=
 =?us-ascii?Q?iVUWt2u/Z+FnugbOZVgh6VyzNOqxGo4npOWUQR7qzmgfwWMZV1L3Ehrx6ski?=
 =?us-ascii?Q?alOX6Ieol3eWUddNVMU4ZcRXqKQLgJcaRMKgA4YkYP6O1RUz8xIIRznya7TB?=
 =?us-ascii?Q?YIjWvZ8o6Auyb0kcPUHszHbMjdn7Ds/f97iyeUWf7xAnAldCSe1aIv9wlcwk?=
 =?us-ascii?Q?zFexNha45A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bf758c-d303-431d-123c-08de41ba819f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 00:30:42.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sm+uFVo45fuvhpd31zF8M5IU/a4DozUyxxJ8EJtATbefyOdg5eONCzyWviFDlqZdAs+WM5ud5gBSZShEte3rUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
State) design where the first FQS saves dyntick-idle snapshots and
the second FQS compares them. This results in long and unncessary latency for
synchronize_rcu() on idle systems (two FQS waits of ~3ms each with 1000HZ)
whenever one FQS wait sufficed.

Some investigations showed that the GP kthread's CPU is the holdout CPU
a lot of times after the first FQS as - it cannot be detected as "idle"
because it's actively running the FQS scan in the GP kthread.

Therefore, at the start of the first FQS, immediately report a quiescent
state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
GP kthread cannot be in an RCU read-side critical section while running
the FQS scan, so this is safe and results in significant tail latency
improvements.

I benchmarked 100 synchronize_rcu() calls, 6 runs each showing good tail
latency improvements per synchronize_rcu() call (default settings for fqs
jiffies):

Baseline (without fix):
| Run | Mean     | Min      | Max       |
|-----|----------|----------|-----------|
| 1   | 4.036 ms | 3.509 ms | 7.973 ms  |
| 2   | 4.049 ms | 3.904 ms | 8.003 ms  |
| 3   | 4.033 ms | 1.160 ms | 10.083 ms |
| 4   | 3.993 ms | 3.145 ms | 4.093 ms  |
| 5   | 3.988 ms | 2.675 ms | 4.123 ms  |
| 6   | 4.019 ms | 3.894 ms | 5.845 ms  |

With fix:
| Run | Mean     | Min      | Max      |
|-----|----------|----------|----------|
| 1   | 3.991 ms | 2.953 ms | 4.125 ms |
| 2   | 3.995 ms | 3.439 ms | 4.081 ms |
| 3   | 3.989 ms | 2.974 ms | 4.079 ms |
| 4   | 3.997 ms | 3.667 ms | 4.072 ms |
| 5   | 4.027 ms | 2.550 ms | 7.928 ms |
| 6   | 3.989 ms | 2.886 ms | 4.076 ms |

The fix reduces worst-case latency due to the second FQS wait not
running when not needed.

Tested rcutorture TREE and SRCU configurations.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8293bae1dec1..c116ed7633d3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -160,6 +160,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
+static void rcu_report_qs_rdp(struct rcu_data *rdp);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
@@ -2032,6 +2033,17 @@ static void rcu_gp_fqs(bool first_time)
 	}
 
 	if (first_time) {
+		/*
+		 * Immediately report QS for the GP kthread's CPU. The GP kthread
+		 * cannot be in an RCU read-side critical section while running
+		 * the FQS scan. This eliminates the need for a second FQS wait
+		 * when all CPUs are idle.
+		 */
+		preempt_disable();
+		rcu_qs();
+		rcu_report_qs_rdp(this_cpu_ptr(&rcu_data));
+		preempt_enable();
+
 		/* Collect dyntick-idle snapshots. */
 		force_qs_rnp(rcu_watching_snap_save);
 	} else {
-- 
2.34.1


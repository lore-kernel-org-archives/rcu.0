Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA11DC9AA;
	Thu, 10 Apr 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297423; cv=fail; b=sIZFiY0L2IKGW7w1x6/mJXZNfH1SVgFbB3DOKFicBIprQTkxPoCA3AjMsESfkR7v63RPEg6DWX0wHEsgrtMBFf1Ysxy1YjSJ6GGI3Eni2JurIn7Kj/A039iHOwImQkEMXza4NW2pa6NBUP5QEBFmJjdxa7VL0TsTxBu9vTXI2f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297423; c=relaxed/simple;
	bh=Mg6y6MrRp0V3hOFhZPira4JNJNB7JLOI4MgRABOsE7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AKqo6HkDUCIEfIyl7QuHNp88lT76hc4aq59zoVKwRkT0JaO2d+hWq8xWvMroN0d1qzlpyeHiOcqbPDi0ZNm+ktLZieZYUwv5NHnWgiuwkUnfO6M0qpWjNKy4eyQ0JX1BqrZSmi4sE89i463bnrwSnBCFX5IR8n5ujlMJa8fkJLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KBxDrn6Q; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KBxDrn6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yd1SV5K/YVI/KR0rEoXNFHHdKj1azkd8cEWDjoMBAB/qjb8GCe8grABW9IT/9CDKMqHUWuOnI1/9kbFJ2tXMO/pFAg5HkxiK9hQgieL+yNbBMIsf7tST64qcKFTqlQJBlVMvqk0hH8UAw7ZaDC7Q1Fw04g/1397JtrMRfiJH0N6AT3uD/eG60qiqLaW75N7DmJUX7Zx6ZLo68EUjIQF5Q9RM/SMd1BgC5gQSMJ4fjTLnn4gwlWjljz6+X/sMPIXcX4rhOYD4Ee3IXXsT2tLcv0hUJurRBiEr9tMhkLubae5pDbTNYl9MgF5R1B4EzFrYIAhLX/6u0iRQoMDs4edFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga5OmsZAEfinbsg/wkXxY5pzIig1htM6TMox+zcorzg=;
 b=A3/GySksnMN/HxDUC4/ASOGqlZTj7CTDILfZwWCbEo02Im3lyl07rZ/Q1T/go54X1Sp0hTarlcC3Xona1mIbwS5kQIlfpQUt/ElORvx/BLB/nEvOyNb+GZjiwSSIrKCnPx+LFpHV/V9/Zn5W2izTCfbxSQHOjv7kPfUyAUTj3alMcG957RfxyJRoUE81QABArAvZ4j/e8TXJuowOG8H7blGB/L6g8u2+Ag9NF0gKUM555AKJaECOfj6HW1UhcXBkH2JOY5cde/AQ7+6Jt7yrpbXE0nRin5Twt7Hi04YfBqRe2K3RVLxzwnEYHYN4jrtMdzSeT3ARPvO1YkSH1U7MFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga5OmsZAEfinbsg/wkXxY5pzIig1htM6TMox+zcorzg=;
 b=KBxDrn6QRplZ/p1HVHP/BU9qluBYPp0cD0pmt4/SzUTNSGCnlWmsEAlVAaAoiRo8+Elp/j2aa6LJsdQRk2+9cHJ4TbFDcKibIPUw/ZbaEUdQVtwJqTE6k5s0de1+HAoJHsasy1rhCyFK1AI0rm4SDgn7/mOmFvfoytO+B1jngifUIv+tIgZiCEeC6KOKwkEh8izY+8uzdpiiN2PqnbPSItXDdHv9VI+Bhv+9d1yghK/DDzUb2kpCOEYFe85+UIE3w8nnj4K8rxiNeA9Y68yHuw3oLYTbrVXEMfkCh3MUnjwSMBf8Mx7r2EydMCe+v7dhNi2tzMehjTMdUIscfT/Z0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 15:03:36 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 15:03:36 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH v3 1/2] rcutorture: Perform more frequent testing of ->gpwrap
Date: Thu, 10 Apr 2025 11:03:27 -0400
Message-ID: <20250410150329.3807285-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410150329.3807285-1-joelagnelf@nvidia.com>
References: <20250410150329.3807285-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 81456a94-ae6a-45b0-f2ef-08dd7840de60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QdwepL8M6/AJl7XI1InVqN/s1cgf7DA5/E7+spPZ/SWJIVdIjEEhbQrvL+xF?=
 =?us-ascii?Q?cC8RJvIKKVB3H/6A5Li8LVUg5XA4W6eBbBYz6WFiVqnppUL/picM/NNMskzJ?=
 =?us-ascii?Q?jSnurkmEgmfVG/qHTs7zUh6iDQoVNgLmQRuQN9M6AZgFe7cKDpD0FXJv07zq?=
 =?us-ascii?Q?E2mxCGclVUq1YXXpak4v2GyduKn1N0r1jqndqTuM+q+MbvNixDYLgXchL7fn?=
 =?us-ascii?Q?g1TvQfo4bwVHIZaSSVxxSbeuWTAwRJXhM53qGkqaQtxHLYhSm6bZlFqMwmrm?=
 =?us-ascii?Q?AoP7jrAja9ziGJCtk4ko+P2kDHrWH/LVrIBabZo4Xe5NHCFPk2zBTp3pldpX?=
 =?us-ascii?Q?Y++sJpWvagyeaw/Hvf7HERwoD/Mcy+i7mD5aIswZ+YPRwK9Yz/5iL4WhsSOZ?=
 =?us-ascii?Q?XSfeAPLsR9Zte8qjtaUPS+rOfHfPtEYx1qw/FX6aAPVnnP4ETHhe/2GKk4bt?=
 =?us-ascii?Q?K/KVH8jnRdE2I3yE8cqh/uUOH2DRhl/ykyJOgBFmiF2aJmfMNjAO7kpKDza9?=
 =?us-ascii?Q?yJR19wcLoonZyWfcJLVm2Jl/P5RTng+KXvpmyphWwoLr8yIbkJcUFRwOC9TH?=
 =?us-ascii?Q?VLEEJzJm93dVggfPujhSVa+p0PBBiOicph/FeDFYPnHOLLTmPzQvyCaCU1v7?=
 =?us-ascii?Q?cTRZGLxgt+DD5yfICMViwaDNGzCTSUKO0Hw3EgA2XfQOSB3Re8sd2w3FzWRm?=
 =?us-ascii?Q?fNHv8v3UpHtaIQ5WC3CetQR+ux3zrnhqeFdE8zJcVhkIn19AYE6/FL3PigXN?=
 =?us-ascii?Q?QObVkMM2Ov8n6x+Y0Ed82kThVGgLLn/VY+uhpztS3pI0QmZ2qvztuseAIr7D?=
 =?us-ascii?Q?oGhYNcRvSkA+2Iz9i4p5NN9T7tPfHqetLPcIqjMhZPCwlZXNS0jYxG4E+5Xc?=
 =?us-ascii?Q?DPgQ4RwfxasFqxVY+bn7WW419QJt07/KtcouOUB6wf0DVC/VEFiKfqVvvUm6?=
 =?us-ascii?Q?p0ztfsPbaUX6kUcSNi2JlDc+cARNI+wI34tQPbCXFbUVWmLiR5kDPAYS+8DF?=
 =?us-ascii?Q?iHNchRz5r18y3fbmpYeLLbRYjOZ/XyKBUeEL9Cy6J/2bE4yZZIHJYazPU7m1?=
 =?us-ascii?Q?p3/Mci2Hat8j/OsdmGNE4WrfrvY6DtcJu/3y9YjzjtddGMHsgU9ZXSFV3QpH?=
 =?us-ascii?Q?lOSz6VwPOp7jHJUjWovN+kP20GBPGCranesXvt1MTcablKBWcB74m+7abq9/?=
 =?us-ascii?Q?Tm40OhrR6H7nIwfalkihBh0o42az6BHXBxMUu90j+GmVcgfd8vbXLsioJ6dW?=
 =?us-ascii?Q?6W1aGnbWnP2m2Mk8fRh4OFeU/lIRO7O05IPfRiCzQVIb2LKJBPsoS3wxccsR?=
 =?us-ascii?Q?zAHapTSXfPwYrAt3PYiH4bNK7K+VR7UBRPIlKkehV7ny5cuvSTgFP9RDbCr7?=
 =?us-ascii?Q?T6oiVF6jvulcGy1c1GmQi/h2ON1AxhitmrtJpLEbt/moeF1bxJOxxp+aSO+8?=
 =?us-ascii?Q?/6NG/KHhctI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JOeRjFaxygK96/4xqBPQKD4glBAb7VXrpGETJkrIz3gieSt84EhdLK425NE7?=
 =?us-ascii?Q?a7GHVEbvY7pdPb+YksAlX7EHkJJqOdJk3hu3QS5Git8AuO5ZoctB6jQPzJkn?=
 =?us-ascii?Q?QRaCgKGlri7DG2yW6+ikNNxomBJStQVh29irnx7bXAYSAUy3E5SvpZiYWvcT?=
 =?us-ascii?Q?2zisARfarxUsLz8TVt7y1Xqi4aSUlFHnHdaoVGkWphlNbGj6WWqJu/dnZ6ag?=
 =?us-ascii?Q?1R6v1IoDfD1LodqF/cHBg+++jgTiiV0Cq2swO67WL2Lcfguds1mN00nGcAfw?=
 =?us-ascii?Q?5FAs7C9UkgrLIS1yMFn31y2J9jW/a+Mm/wZhVwTgZFSulj/xmgouKMOHyfZ4?=
 =?us-ascii?Q?vndixQ0IOgulu0f+u/24Ru+9dsAKhCAKPKJwGmlgGop7BVbBTRDdD5XN57R1?=
 =?us-ascii?Q?P+RQav9h89BpZOujLpE4JwpaC+1/X60Fzd3Hz/D6yyq4BZ/Do5tycqL/5usy?=
 =?us-ascii?Q?0qgRROo0hBikgYavFxP8XX2OYiCXcXEH3b8kxH+aLPUx5svJPkGcKVOLMGBv?=
 =?us-ascii?Q?gC+kivDgQMx2XJxU5bGhljduwBRM9LGsVFTt84QP9L0/zCLiEQYtxnkmikuU?=
 =?us-ascii?Q?0n6sYMbMCQtquFETZ6vCAwhiqzljM4qxtIl8G6IgPNSFZmDRHaGj3RdYnp72?=
 =?us-ascii?Q?1ksRWIl7w7vo226Qx/XF1BWJ2pNjpM36v7YXNfwMfWV7ckSQB3//FCSP1DdP?=
 =?us-ascii?Q?yLeBi+g6iMLdmdekeiB4ZgucEwNMQwtvj1r6FPVtiWeYdDjkHRFRO0/DxXAJ?=
 =?us-ascii?Q?9rmPoIG3QKGYzmNqUyDokdGr6HB4nsA4fhZ226ou3MPJmjd7mzziBFZ4dauH?=
 =?us-ascii?Q?784ZNyFtaa1wcM2AbQJSuOryNG33wRx+fLUJyHxCVFlDOTHysVkwh8sFwoYc?=
 =?us-ascii?Q?HljxFyA24i+cgui6k5x5Z6DCWm6guKvxkv8kZGHHY7bdwQQalFLLKna8JP9c?=
 =?us-ascii?Q?/1MdZS6vbbqZ5oIPGjtgNe9q/7stfrXMtGuJGUMaCZTEBnAO/E8ULh216dE6?=
 =?us-ascii?Q?IAPsMu+NeIDrmkcJkTjg7U41gKnmTD2cZMZcI6PYKMMIeNB7nTICifvE8SNY?=
 =?us-ascii?Q?6RnPCiD1hStUP+fFFur9DRWBUllRu9ohZcLT4OrJrfxzAtxjdP2eXwIVOadr?=
 =?us-ascii?Q?EuTZI6NZ//hlZQbia+zJOCPJyejwDuDXirT6FvIT7MJ6BidRV0+lhJ9s/ZDY?=
 =?us-ascii?Q?+0WvpyvNTmp9y16A5l0CDUYImr5XMizlbO16kf1K0Od89cafOV8dSiYjPowc?=
 =?us-ascii?Q?oAmMtm5qN6qkqFoGI8ASrYoyKokl4aSLRUHCfAiEhy1B8oIT543/2idbr5cN?=
 =?us-ascii?Q?LOr9Wqj4nbde0JUEJouZXMa3geAY93mCwNjJlp685xWeVot2w/DEHPemrP5d?=
 =?us-ascii?Q?oqOLfocRVb//2eF1fVssGhFFZr2suvjaMo55FOPmxq2BFnio65rpp1sc6EUu?=
 =?us-ascii?Q?njWP5i7W+XkNzAWk3/Ut0OpIGAQJr6yqV4IBhfS6O+M/UWJv4wdOdln3fBg0?=
 =?us-ascii?Q?6NRGIUHfOa3uIPEXNnn8T2TZGSc3Nc0ouk/YKFD+eMmYVGExpE9dOPKVCwb7?=
 =?us-ascii?Q?H88Y1C4tw3Gnt8443YmYfgCTDwVkaZo8UbqXNxJl4iF9oYhenCJ5kPgH5u82?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81456a94-ae6a-45b0-f2ef-08dd7840de60
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:03:36.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJo4zsgME1LLT9yuVl07mXiUtqnJVsFUu7fm+HrPjG6VcLpcAwMniXWP6VNJTt3pcOFKgCIm9reu4pqwNe+nCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463

Currently, the ->gpwrap is not tested (at all per my testing) due to the
requirement of a large delta between a CPU's rdp->gp_seq and its node's
rnp->gpseq.

This results in no testing of ->gpwrap being set. This patch by default
adds 5 minutes of testing with ->gpwrap forced by lowering the delta
between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
configurable, including the active time for the setting and a full
testing cycle.

By default, the first 25 minutes of a test will have the _default_
behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
this is reasonable since we at least add a little bit of testing for
usecases where ->gpwrap is set.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcu.h        |  4 +++
 kernel/rcu/rcutorture.c | 67 ++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree.c       | 34 +++++++++++++++++++--
 kernel/rcu/tree.h       |  1 +
 4 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index eed2951a4962..516b26024a37 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c_old,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
+void rcu_set_gpwrap_lag(unsigned long lag);
+int rcu_get_gpwrap_count(int cpu);
 #else
 static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
@@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 	do { } while (0)
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
+static inline void rcu_set_gpwrap_lag(unsigned long lag) { }
+static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
 #endif
 unsigned long long rcutorture_gather_gp_seqs(void);
 void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4fa7772be183..74de92c3a9ab 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -115,6 +115,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, gpwrap_lag_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
+torture_param(int, gpwrap_lag_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
+torture_param(int, gpwrap_lag_gps, 8, "Value to set for set_gpwrap_lag during an active testing period.");
 torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
 torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
@@ -413,6 +416,8 @@ struct rcu_torture_ops {
 	bool (*reader_blocked)(void);
 	unsigned long long (*gather_gp_seqs)(void);
 	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
+	void (*set_gpwrap_lag)(unsigned long lag);
+	int (*get_gpwrap_count)(int cpu);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -619,6 +624,8 @@ static struct rcu_torture_ops rcu_ops = {
 				  : NULL,
 	.gather_gp_seqs		= rcutorture_gather_gp_seqs,
 	.format_gp_seqs		= rcutorture_format_gp_seqs,
+	.set_gpwrap_lag		= rcu_set_gpwrap_lag,
+	.get_gpwrap_count	= rcu_get_gpwrap_count,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -2394,6 +2401,7 @@ rcu_torture_stats_print(void)
 	int i;
 	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+	long n_gpwraps = 0;
 	struct rcu_torture *rtcp;
 	static unsigned long rtcv_snap = ULONG_MAX;
 	static bool splatted;
@@ -2404,6 +2412,7 @@ rcu_torture_stats_print(void)
 			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
 			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
 		}
+		n_gpwraps += cur_ops->get_gpwrap_count(cpu);
 	}
 	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
 		if (pipesummary[i] != 0)
@@ -2435,8 +2444,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
 	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
-	pr_cont("nocb-toggles: %ld:%ld\n",
+	pr_cont("nocb-toggles: %ld:%ld ",
 		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
+	pr_cont("gpwraps: %ld\n", n_gpwraps);
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -3607,6 +3617,54 @@ static int rcu_torture_preempt(void *unused)
 
 static enum cpuhp_state rcutor_hp;
 
+static struct hrtimer gpwrap_lag_timer;
+static bool gpwrap_lag_active;
+
+/* Timer handler for toggling RCU grace-period sequence overflow test lag value */
+static enum hrtimer_restart rcu_gpwrap_lag_timer(struct hrtimer *timer)
+{
+	ktime_t next_delay;
+
+	if (gpwrap_lag_active) {
+		pr_alert("rcu-torture: Disabling ovf lag (value=0)\n");
+		cur_ops->set_gpwrap_lag(0);
+		gpwrap_lag_active = false;
+		next_delay = ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0);
+	} else {
+		pr_alert("rcu-torture: Enabling ovf lag (value=%d)\n", gpwrap_lag_gps);
+		cur_ops->set_gpwrap_lag(gpwrap_lag_gps);
+		gpwrap_lag_active = true;
+		next_delay = ktime_set(gpwrap_lag_active_mins * 60, 0);
+	}
+
+	if (torture_must_stop())
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward_now(timer, next_delay);
+	return HRTIMER_RESTART;
+}
+
+static int rcu_gpwrap_lag_init(void)
+{
+	if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
+		pr_alert("rcu-torture: lag timing parameters must be positive\n");
+		return -EINVAL;
+	}
+
+	hrtimer_setup(&gpwrap_lag_timer, rcu_gpwrap_lag_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	gpwrap_lag_active = false;
+	hrtimer_start(&gpwrap_lag_timer,
+		      ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0), HRTIMER_MODE_REL);
+
+	return 0;
+}
+
+static void rcu_gpwrap_lag_cleanup(void)
+{
+	hrtimer_cancel(&gpwrap_lag_timer);
+	cur_ops->set_gpwrap_lag(0);
+	gpwrap_lag_active = false;
+}
 static void
 rcu_torture_cleanup(void)
 {
@@ -3776,6 +3834,9 @@ rcu_torture_cleanup(void)
 	torture_cleanup_end();
 	if (cur_ops->gp_slow_unregister)
 		cur_ops->gp_slow_unregister(NULL);
+
+	if (cur_ops->set_gpwrap_lag)
+		rcu_gpwrap_lag_cleanup();
 }
 
 static void rcu_torture_leak_cb(struct rcu_head *rhp)
@@ -4275,6 +4336,10 @@ rcu_torture_init(void)
 	torture_init_end();
 	if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
 		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
+
+	if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
+		goto unwind;
+
 	return 0;
 
 unwind:
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 659f83e71048..6ec30d07759d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -80,6 +80,15 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *);
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.gpwrap = true,
 };
+
+int rcu_get_gpwrap_count(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	return READ_ONCE(rdp->gpwrap_count);
+}
+EXPORT_SYMBOL_GPL(rcu_get_gpwrap_count);
+
 static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
 	.gp_state = RCU_GP_IDLE,
@@ -757,6 +766,25 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
 }
 
+/**
+ * rcu_set_gpwrap_lag - Set RCU GP sequence overflow lag value.
+ * @lag_gps: Set overflow lag to this many grace period worth of counters
+ * which is used by rcutorture to quickly force a gpwrap situation.
+ * @lag_gps = 0 means we reset it back to the boot-time value.
+ */
+static unsigned long seq_gpwrap_lag = ULONG_MAX / 4;
+
+void rcu_set_gpwrap_lag(unsigned long lag_gps)
+{
+	unsigned long lag_seq_count;
+
+	lag_seq_count = (lag_gps == 0)
+			? ULONG_MAX / 4
+			: lag_gps << RCU_SEQ_CTR_SHIFT;
+	WRITE_ONCE(seq_gpwrap_lag, lag_seq_count);
+}
+EXPORT_SYMBOL_GPL(rcu_set_gpwrap_lag);
+
 /*
  * When trying to report a quiescent state on behalf of some other CPU,
  * it is our responsibility to check for and handle potential overflow
@@ -767,9 +795,11 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + ULONG_MAX / 4,
-			 rnp->gp_seq))
+	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + seq_gpwrap_lag,
+			 rnp->gp_seq)) {
 		WRITE_ONCE(rdp->gpwrap, true);
+		WRITE_ONCE(rdp->gpwrap_count, READ_ONCE(rdp->gpwrap_count) + 1);
+	}
 	if (ULONG_CMP_LT(rdp->rcu_iw_gp_seq + ULONG_MAX / 4, rnp->gp_seq))
 		rdp->rcu_iw_gp_seq = rnp->gp_seq + ULONG_MAX / 4;
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a9a811d9d7a3..63bea388c243 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -183,6 +183,7 @@ struct rcu_data {
 	bool		core_needs_qs;	/* Core waits for quiescent state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
+	unsigned int	gpwrap_count;	/* Count of GP sequence wrap. */
 	bool		cpu_started;	/* RCU watching this onlining CPU. */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
-- 
2.43.0


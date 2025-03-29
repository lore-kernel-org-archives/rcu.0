Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168229A1;
	Sat, 29 Mar 2025 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743289315; cv=fail; b=EpeCFau5kCBNHcqkHRIxuU04NeBvcY9X5ChqVIvJ9gbzzSqU7Di4SInYrU2pIu4FPnnLuGhIS+rr+puWcso97f+VQ8SClLlZXY5cYW45fwjXGiC4v8JOgd2A7OHD4ieukpSrK/ARIWZI/2Xy1dLW7xv5SPJjKNPBHYvemq8S1zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743289315; c=relaxed/simple;
	bh=jcCG4SMfSVKBPX45URhv2oGzIJiT1eshloLEkj0QMRg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eMtpOEpCvuuU9lxYEjMWrrGAJPjmceWSMAUPJPAHKH71nmUih47XIKb5xfFF6PqJUrCeI2lqMlA5aQkykPVqOCbbhWHemr1Fk5pjexHXec5K6AglJzJBUDfTOqkjkUvvyBspS4hD0uR/PehKGrYWV/F6FBvFjgCoxFTpN8EW/cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dIFiwL4s; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dIFiwL4s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/32Gcu3MNe0E0AMtlJn+8lIsya8FXYNUIeNYetQoHY/7oyRheX8mEEgtEGtSDFXmnjmKBcJPBjMexxUQxRllAzWPfdPsf+AiATzQ6CQtrC18tCI51rAIQBlt5OfSKI0VrDd9KL6vdlgxQoLQNQXPWzMVYjrvfMkhGgoty3Lw7ZhdFwlLgEyD5Uq5+Sg5xppgC8sfEuj18gLTQtaVLGeOKXOqYiv+vBn/EODysf8AAfc4/wUDi9dewMs0+8xRuc00dilhQs4ktc22599nAxH2/0sMlhrfuSoRZQHFMPWJH2ufuUcGfFAiwJBfI/5xHqOxS+B6Evkvox8ZHIxQdfpyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX6O4ygmYt+9ArzrpZ7iHJmcUPTcbAKPXZPO3KLR8sc=;
 b=oqyJDYMy5kLLTyP+G0YtgEIijWNdprpqjnw7iJqvn1a63ttszWcXqN1D87NCaGdRdLVDKW84BI0P4NprZ/hvcj4gsoM0uoFMwmdRfAnfjN/BcHuj99j+FC9lFMaC1WOy0obAcv2KmrLZ7JjoCj/n3UM9Dh9SbzahtexeYQp9hQA7gKsnwuLOEPsrbf6c4COokkaGIJYHLiWcjZuTjYUMQ7AV2pYolkgRvLcRecjrB46gyUbjLMkdRv/5IsIykfUnxd2RkEeCG49hYh+gcYWr8RelonXwBGUfxhNGG5AmHmDSCaKzpqitjCh8FSy269rLN+JgQAj3vFrr8aHq4nnpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX6O4ygmYt+9ArzrpZ7iHJmcUPTcbAKPXZPO3KLR8sc=;
 b=dIFiwL4sKLMauwrghu+q2ojhmEr4sYulDyX8RyFsQBetBmhTuG/1ua0RAgswOaLeqWIj0r+Ohdg5NjF1h8HvSv9TJ05arrEwNvi9WtHGf/OSq6qvClAs/UMTMdxFs5adeYM8sjpCjm1xlgyLiOLOnqNmG8G3xDzQTlOwBUdK1BlSCfj7A4lMuAWqGZafBoLow3eKADU+099Hg3utNjZyxKrK+QWmscW4vAuHsviXrRCAynzEC+NIWJ2l7MpfFRm9m/JxF+VyNsbvmIIc0Yd7Y5sm3T59ZzykQQ2FrWr/+YHVI7ur8eKMK0sbiwCwSJMbjhjNl3iBSLOTf7m9ANBhnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sat, 29 Mar
 2025 23:01:50 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.043; Sat, 29 Mar 2025
 23:01:50 +0000
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
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH] rcutorture: Perform more frequent testing of ->gpwrap
Date: Sat, 29 Mar 2025 19:01:42 -0400
Message-ID: <20250329230143.62292-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:208:134::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: c52b4a55-89c9-47ba-5841-08dd6f15b09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HtHCrp1IKIiODS7K2KYWmH6aBj8TMSUVD0hZOPzN3zkMdBf5PnLt9Ed5r5w6?=
 =?us-ascii?Q?35aeYBSg8yeQubEtmZzJJeHA3tC86UMxE/E2QH5Gb3CKbAmEjqc10xARr2I/?=
 =?us-ascii?Q?LvdRwNVaVEGeCaBMkLLyQE3/f1jVrlJlhFDsYxTFc22RlITMvVlrBdZhU25Q?=
 =?us-ascii?Q?QWt8iORRC6a6fdq6VoPO3tBGSGtVzSFaEEn/hXm+qKkpldFpP43iMJRtR2eK?=
 =?us-ascii?Q?w1skthqjj6b+k5I16QPk+PTDXzAKDQ45w9An04Mx30E5zP445f5Z/lTyzg1j?=
 =?us-ascii?Q?37DUPaavyRcRhDm7ZJEBZJAz26pfHwdgSNa6/3H55Voa+vlENgaWnKZLjpEL?=
 =?us-ascii?Q?AwunEe5pBcXFW1OIPg52pkCtQVwpJoXRrlBdR2GGHziS4U/9cNi3KFitwKjy?=
 =?us-ascii?Q?5XiVhjqWCaNWbFrkHLfI50op9RoDvBGUsGnc3/CFzCHGwoZ4g3WL9c2MA417?=
 =?us-ascii?Q?CljxT1bfPD8BMN0DI3I8xK1rx4tzPXN2omLpJFL0EHf0xrWjNL4dNPGYRE3v?=
 =?us-ascii?Q?CjDMsefYYnE1GjXq/wIE5NdIOPTy86sylaE0CGz7vuiElSQgclVfyg2dvEy2?=
 =?us-ascii?Q?ISQ7H96ArvOGMsdP2HcsNQsOGfNsrEhxdpmMphLwVGkmAuXmZrV3m5NDqtj0?=
 =?us-ascii?Q?eXZNzL8IzEG5VpB4MUvftV8JkEsQlAyFP94bnHTI8QHw0YQuDq7Awrhpz0cB?=
 =?us-ascii?Q?2SMgZoJDba27Qjyr1tjuQylAIh/d6vCmxdyxzaLAFZ6FpfGFovcGCyrF9shj?=
 =?us-ascii?Q?jyU9SlP2KyOqu0ASgT0Tj0MyjBrXL+JnIJnG5xzAW4X+hsz2TIIF+VVvsVcx?=
 =?us-ascii?Q?iwSuUE3vPtuuySMTxCWnJ+4JAbJIdrqrF7ZD/byFqVtORHthwJQsYERxfLHy?=
 =?us-ascii?Q?0YTr2fYrySbs5s9k1zi3E/wjjytDGbyz63CysrV0jk2Pxsmm3HUg9hjOATkl?=
 =?us-ascii?Q?r5ajlNTQ1lGa3urdlUQ1q0wq3xl16mbds58BE4Dy0zpRLdLcJHX85tsXvfif?=
 =?us-ascii?Q?hA6lBBvOC4v08suTKWFVERb13uWOxRpOc40DsXr3eAJ0+Ycdb9VD77TFANph?=
 =?us-ascii?Q?TTJfrpdPL4+mzIonOmCbEJYtxmwqNiCgqsgyKMATIARuac3yweGkzApbW0oG?=
 =?us-ascii?Q?mEU0aEuTrJfJA4E8rLOgim38P6POAn9H6nqi8OY3pFnOW1bZDnAhJCZwjMbU?=
 =?us-ascii?Q?T1BYxgMpcoc5q7n8Zogqn9HtAskreeMy4t36Ma4qXar+7+il8wizlinxqOBr?=
 =?us-ascii?Q?U1XhZ/GOenpmlr94kEj09YgOh2QzvGoWaTeZFZC8bzrA4dromUDjetIvvU6H?=
 =?us-ascii?Q?T9T+z8veNUxx/FyycggpJqoRaQLXwvuO0VCyreYe0o7I7dBcOO7sHWhNya3u?=
 =?us-ascii?Q?lY1YEKEbbEONJRoR8+4A/6NkOzlNj3rn0K0ltG9UfOnCm4R0s8cTN9K44gdd?=
 =?us-ascii?Q?qiXUcf2+mgr8lbd7qp4QfYS5S0qZhChn1lTiSJdhcX34FjRUnfZXmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+2DJXvTIQ+NpQbwdMb6qEQv+i8Gu6Xd+k6Qs8+MXeHopKantfvb/K5EW1D3?=
 =?us-ascii?Q?KSTlyJbCc6lUaxKt1xo/AMHXemm62GHEBVlJ909YH+nZ7VsX+QQZoVoD+vvb?=
 =?us-ascii?Q?6ORB2MwOmDHWyZHpSOAUrVsOUspVp0zWCDZX0/NgtxV33VljGT3pRwf1BFZX?=
 =?us-ascii?Q?mai5lTk2iPFKXrjddTH8LJ/VVvrQJifD+i7nDxOnH4W5kvcAf5KrmikDJk2y?=
 =?us-ascii?Q?cbyK0yunSZZ4/pIQmQVcxn24GV9QLtkBvIlu9bG+G8Zazu5k/6Wr/qwV/+Rz?=
 =?us-ascii?Q?aqGPaPV6pff8NW1CfjUxxNeHjh+4mfUrj3CkVOysYHBSxPk61wWd/l3Js20E?=
 =?us-ascii?Q?pHQkK+MknwLZeoNJnJppzDa2XzJsnZExzAvnnx1ZkFHmivR6CAs6SfT+SBGc?=
 =?us-ascii?Q?81ZNo6lyu97k0701edgVljzW0yDY9l0MVMwHwxTisH+DCYIp+q5orDzikv+W?=
 =?us-ascii?Q?/ehalTvQdR9zhoTpsT1g9PlrHOWs0dWMF9y9wZ5bbDuMr/pwEv7EHFxfVUR5?=
 =?us-ascii?Q?p/sKuNFhGI4RPtzt4dcM/0MT6MY6DIlq634ZHNef4Y2PK5okRr9X+VhFHjbR?=
 =?us-ascii?Q?w3WXwpBbgrMc13MhGcUJKstN5O1IAllIW284nZww3/S3eCuP19W9mhmT0K59?=
 =?us-ascii?Q?qCYRpMR9bmH0cAIIvuLNEyyRxbguz1yNiygNj/osaChWgPuml/oaE4f3vz9H?=
 =?us-ascii?Q?lLEj0cURLXSkHhSEuuArd+RNbzACpZhz+HGyO9Ldo/ctcmr/OLt9Xq2ceaDv?=
 =?us-ascii?Q?yrGRB4ZnBxY0itGPl3x+OlFB9SVDra/FBh39kMCIPDYT4m+KJWvufEfwHJJa?=
 =?us-ascii?Q?ojnL20UIE/8GimFQcfBI8PjA+FqzPC2noUkUsM/6Df1aAW4MYBpiTqrDw92A?=
 =?us-ascii?Q?KTYz1lWu+ZrSnpcq3j5AerP/rXWOyVgDc4/MUjLX8gbLNwFirIzJAHDZVzW9?=
 =?us-ascii?Q?sERg+i9/z+BlPihVVx5YDILIhjSfkncHEkRuWir99mhamJ2+2VJSXxikpDk7?=
 =?us-ascii?Q?9rjGhEP8A8ddaUnoV8IPgLkhj3EgrY3kLPC46gOmW3OaNcZmMWRY2eyRkRXW?=
 =?us-ascii?Q?LpEYpeUCL+NbjRUim80BabWGZIGlfSeFlYpLAITPxFdDCdr19jwdd9Fm05Tw?=
 =?us-ascii?Q?OyFWMe1FXQwvWw1Jt/3ZXnqtPv32f0E69T19XC0hV0TyKOh5uNU0mROYmbXm?=
 =?us-ascii?Q?fcb7jtlWxTZ+87WfvWNDypm9yl1hQH6x4THIKMNAeWN2nMi9whE8PAA9bUd7?=
 =?us-ascii?Q?C7s2dh9gVQxrq3rHUCi+2E5WjDWfSpWPlNglWS1KxH7R3eDg/WotfCWZAPRW?=
 =?us-ascii?Q?/e3P5w34EI1BV7cc2lD7ZxsXy6AzdU2vUWx5++x1IjgQ/fopKWCwyMBFLeAs?=
 =?us-ascii?Q?c7mbdl6lXhtXSXPqv8mpgeRMjUvFgjQCttDmwsMa3rVs64Fv1fH27kOdcTLI?=
 =?us-ascii?Q?Bwq4gpPxVoKU3guPRWv2c+PBx34U8jUuythYOMkVPDL5FSfUcJQhv/NwMXNn?=
 =?us-ascii?Q?bigH6dicjXjbgtx8V3eFbowihVxzE22+LvX2kzA3Ym2MUCFSKm76QqRfgzKY?=
 =?us-ascii?Q?gaBN+3Z0dI3F7YaKWkSYUQMYNAr0XUX4EyAVzvxo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52b4a55-89c9-47ba-5841-08dd6f15b09b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2025 23:01:50.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8TK6pyfnmpE61EIIXo6k6309EEIxJeA1ehRZKpkJWF/GGcZ6NW4b7DA5uFIGBgNT3awzAbNy4XK3RIbXZJDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515

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
 kernel/rcu/rcutorture.c | 64 +++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.c       | 34 ++++++++++++++++++++--
 kernel/rcu/tree.h       |  1 +
 4 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index eed2951a4962..9a15e9701e02 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c_old,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
+void rcu_set_torture_ovf_lag(unsigned long lag);
+int rcu_get_gpwrap_count(int cpu);
 #else
 static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
@@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 	do { } while (0)
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
+static inline void rcu_set_torture_ovf_lag(unsigned long lag) { }
+static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
 #endif
 unsigned long long rcutorture_gather_gp_seqs(void);
 void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 895a27545ae1..79a72e70913e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -118,6 +118,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, ovf_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
+torture_param(int, ovf_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
+torture_param(int, ovf_lag_gps, 8, "Value to set for set_torture_ovf_lag during an active testing period.");
 torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
 torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
@@ -2629,6 +2632,7 @@ rcu_torture_stats_print(void)
 	int i;
 	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+	long n_gpwraps = 0;
 	struct rcu_torture *rtcp;
 	static unsigned long rtcv_snap = ULONG_MAX;
 	static bool splatted;
@@ -2639,6 +2643,7 @@ rcu_torture_stats_print(void)
 			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
 			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
 		}
+		n_gpwraps += rcu_get_gpwrap_count(cpu);
 	}
 	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
 		if (pipesummary[i] != 0)
@@ -2672,6 +2677,7 @@ rcu_torture_stats_print(void)
 	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
 	pr_cont("nocb-toggles: %ld:%ld\n",
 		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
+	pr_cont("gpwraps: %ld\n", n_gpwraps);
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -3842,6 +3848,58 @@ static int rcu_torture_preempt(void *unused)
 
 static enum cpuhp_state rcutor_hp;
 
+static struct hrtimer ovf_lag_timer;
+static bool ovf_lag_active;
+
+/* Timer handler for toggling RCU grace-period sequence overflow test lag value */
+static enum hrtimer_restart rcu_torture_ovf_lag_timer(struct hrtimer *timer)
+{
+	ktime_t next_delay;
+
+	if (ovf_lag_active) {
+		pr_alert("rcu-torture: Disabling ovf lag (value=0)\n");
+		rcu_set_torture_ovf_lag(0);
+		ovf_lag_active = false;
+		next_delay = ktime_set((ovf_cycle_mins - ovf_active_mins) * 60, 0);
+	} else {
+		pr_alert("rcu-torture: Enabling ovf lag (value=%d)\n", ovf_lag_gps);
+		rcu_set_torture_ovf_lag(ovf_lag_gps);
+		ovf_lag_active = true;
+		next_delay = ktime_set(ovf_active_mins * 60, 0);
+	}
+
+	if (torture_must_stop())
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward_now(timer, next_delay);
+	return HRTIMER_RESTART;
+}
+
+static int rcu_torture_ovf_lag_init(void)
+{
+	if (ovf_cycle_mins <= 0 || ovf_active_mins <= 0) {
+		pr_alert("rcu-torture: lag timing parameters must be positive\n");
+		return -EINVAL;
+	}
+
+	hrtimer_init(&ovf_lag_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ovf_lag_timer.function = rcu_torture_ovf_lag_timer;
+	ovf_lag_active = false;
+	hrtimer_start(&ovf_lag_timer,
+		      ktime_set((ovf_cycle_mins - ovf_active_mins) * 60, 0), HRTIMER_MODE_REL);
+
+	return 0;
+}
+
+static void rcu_torture_ovf_lag_cleanup(void)
+{
+	hrtimer_cancel(&ovf_lag_timer);
+
+	if (ovf_lag_active) {
+		rcu_set_torture_ovf_lag(0);
+		ovf_lag_active = false;
+	}
+}
 static void
 rcu_torture_cleanup(void)
 {
@@ -4015,6 +4073,8 @@ rcu_torture_cleanup(void)
 	torture_cleanup_end();
 	if (cur_ops->gp_slow_unregister)
 		cur_ops->gp_slow_unregister(NULL);
+
+	rcu_torture_ovf_lag_cleanup();
 }
 
 static void rcu_torture_leak_cb(struct rcu_head *rhp)
@@ -4508,6 +4568,10 @@ rcu_torture_init(void)
 	torture_init_end();
 	if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
 		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
+
+	if (rcu_torture_ovf_lag_init())
+		goto unwind;
+
 	return 0;
 
 unwind:
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b77ccc55557b..7b17b578956a 100644
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
@@ -778,6 +787,25 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
 }
 
+/**
+ * rcu_set_torture_ovf_lag - Set RCU GP sequence overflow lag value.
+ * @lag_gps: Set overflow lag to this many grace period worth of counters
+ * which is used by rcutorture to quickly force a gpwrap situation.
+ * @lag_gps = 0 means we reset it back to the boot-time value.
+ */
+static unsigned long seq_ovf_lag = ULONG_MAX / 4;
+
+void rcu_set_torture_ovf_lag(unsigned long lag_gps)
+{
+	unsigned long lag_seq_count;
+
+	lag_seq_count = (lag_gps == 0)
+			? ULONG_MAX / 4
+			: lag_gps << RCU_SEQ_CTR_SHIFT;
+	WRITE_ONCE(seq_ovf_lag, lag_seq_count);
+}
+EXPORT_SYMBOL_GPL(rcu_set_torture_ovf_lag);
+
 /*
  * When trying to report a quiescent state on behalf of some other CPU,
  * it is our responsibility to check for and handle potential overflow
@@ -788,9 +816,11 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + ULONG_MAX / 4,
-			 rnp->gp_seq))
+	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + seq_ovf_lag,
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


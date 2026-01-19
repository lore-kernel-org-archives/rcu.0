Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A411DFD96;
	Mon, 19 Jan 2026 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768864353; cv=fail; b=fOD2RDA6Wb/uD2VTmL84ENizOUxS+TDsh5cAKV97WkWM5gRQqkrP+AlyYpHzG22NEwUzLBc+Hcoqhjk3im+KVzJpAE9VsoL07dg0fP0PDf2RnGic2zKbdpNf4/aVyRpV4BYuH0rCXpt5l9PgRIvozFgWXqqYvDukpTWdFJ6TEsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768864353; c=relaxed/simple;
	bh=2yH+9PlEA3wNuVu3XYft/zNSWoMWYCl19ndl8t6Pchc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fp2z0iMA/wd5T18up5JOWphNezrVZwtGbMkiAOg/RQGqqSVevLPhiTECa5dMz7PjIoqk2Z4eqvNOg7Z3HTI3dYCorpfwz265IMU88hIuhyHzHXons3B/oSWlocaLjAZaBfwr8/btjr/jReAdMExbeJxg1DzHz7QgcKnTChPByoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I6ute5Od; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I6ute5Od"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfU7PspJbWv83uWd0Lilda4PXEh9Gmj33s3NK5Fq/sJ7w3grLzfRr4ZSK0E7l0jt+3tzTCQrOAhIl20pIRDrhBv4xHivn8uO09SnmNlbEU83yDML9E+giGPbXGbcKY4Smsxuc/uWo7QLD1/GkPXBeWBIkKqjUngprMdo93fVg22GDDEZgG+TMGqCTBPNldoCb/oEWVNgku7N+8d7evb1bYK8oORkYOpU2/udBOgYTLql88apAkQsv3guLoY3YnYrm4Xta4xCFSfr8/0nn4H/2V6bxWr3/DMxqQpzVHbEiOP3D4Pu9IVkNKKz6+77dd7u0fxPxeX5/L6aOhkmd6XQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiewt5KDQd03EfZt7eVCzVtWfx6E9Z08LVGCqnNEw30=;
 b=cQ3wS1jhMmQV45ubxTlmf45KqM2mjPsXA6KrVgnXM9kZPWyLuX1OvdbmhptlvMyYKv4x/+ebr3vg5d6e3+eutwaiYICBqUu8X/5/a46zJrPfNg476Vh4qmgQ5rfsISVgWTqnFksWvKiJvCt5ukFdqE1tYnrOBuFHgnTYwvh/ajAi5LIaIcutWkgY/nemElTpgSXv+grENd0iEoSA5ojLg7Dl2qtIbn6IjqGMiEHY42uvhKppfAqTuIGcxlmNYTNw/+0gx0MceFRJlVGCsnWbvypDezlYNqCBJPVslrMdX3kmp7F96CDFyzwP8FAWWJ4EquA9zTnxcRNXQ+U2tfi19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiewt5KDQd03EfZt7eVCzVtWfx6E9Z08LVGCqnNEw30=;
 b=I6ute5Od/h3dEo0LZJ1K6RkmrKCF34GeOe2lHCEXYzsnL1jmeFHtzcrVBt3+IxnDAWURLTx+wj54Qf8ICOJW5v4FNdbbyuRiKB7/+V5vpclSQDTAKGBcIeALpjfW2wJJruYTu04jkUyCDZdhNlrs0gm651Hz9LHyW2A63I/Ptf5ddERKxfUt6a80OpKjd2p0exEkWqpB3g0F5Noq41l5UaTsmo+F8ld2i5G2W9qcIT01d6iK6st/xaN/RDIfSLua1r8AdtGp7kUUwm01ahkoPtQV/QRW4TRKNZ+fG4uYsfNd6B6ye3MDxk8tYuvNWLPdpEkI66DJq6VsEw+Ia+v59A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.10; Mon, 19 Jan 2026 23:12:28 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 23:12:28 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next v3 1/3] rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
Date: Mon, 19 Jan 2026 18:12:21 -0500
Message-Id: <20260119231223.989409-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119231223.989409-1-joelagnelf@nvidia.com>
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0026.prod.exchangelabs.com (2603:10b6:208:71::39)
 To DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: bab3be1f-7d5d-4313-b0bc-08de57b036f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GOnZ/prfPdFZ+k03TSHiXdhWO4hX5lKGPpTrpfP47j2Yz6uWwQQjxz0cGQst?=
 =?us-ascii?Q?xNYZxW3ed7Gh0cMHCzgJcD1zahY5FSPf5jIEGvp0sBiSDI6aMEGXuA58F5qj?=
 =?us-ascii?Q?QXmfMJqEfkcYJU+8EQnG2h7GJ1WjPvTofTomuuux36nyUFP4UFI5MxvolG9A?=
 =?us-ascii?Q?kuwprfKG5ExGUV+xBLpOAAJlwpeiStXlHvwc177N8gep8sdSvRbs2/EwX/6+?=
 =?us-ascii?Q?P2NiNBZ6Y5wu3FCgNUKVUPCuM1zo47zhfapcgDchJzXZr092tqOERYyQe56f?=
 =?us-ascii?Q?AipNAyJvu7FAv2HRe6O1/AzoSY+IX8leL/PwU6cU4kB0GqgqTO7nhQfOcwwQ?=
 =?us-ascii?Q?koIwx/YIWTDPU5ffF9Dnaw8metn9+FMI38yNsBq67cJDJ0a1d4hqsTWnJUcI?=
 =?us-ascii?Q?+Xgxv6qcx4DSxJhpdfzx0O9gh3uI8FCTfSHQNypSpqsvbFXUV9EHyyvQfc7K?=
 =?us-ascii?Q?TD9GUK42SfkTlr7mLFBV78qb6JWfDVZ5SScQdP9QBrV5BRN3BIZ1bpd9TIqn?=
 =?us-ascii?Q?g3fldjnUu2aHkWGc7xDithrSCtrKtwBaLsv+BsTDxLmlB6mSCQ2trLIy8IqC?=
 =?us-ascii?Q?QIdu0JGgP0C88j8mUgZxrJh4E08lNPRxFQp6rOr0eSlDYtc1baEd4oVooVVw?=
 =?us-ascii?Q?DqoBTm8kNd3c1t2I8A3e8rmW6DB8TLFBK/O0tnw7OEjqx/VtACuZ8XSLEQfO?=
 =?us-ascii?Q?3lhPyeUfXD+PtiqRWrNXIjJavHfLBSXHFBOYLBdxWkzhahUq3eS2WAuWMO9G?=
 =?us-ascii?Q?kgahGrzwzSCWH6rrAc2mnXrgEvvKQAmoTBI5jK6plPAD8YW/awNEwAR+SNoD?=
 =?us-ascii?Q?szuMiY/BycS7dHSvWMUrrETdcZsDGIvt33oEVc8yrWIPc5fO+tEzm3+qUCXG?=
 =?us-ascii?Q?4cyQHeuJ1WfmS2iLYKWF89p2Du7rOe4OtqmF6Y0Y1et+v3U86O/oF8HVGaMt?=
 =?us-ascii?Q?TC0/doOLZnMVhzBEmXYNcmpUPu9wf39Bjd8p11C2DYfn9SL7Kz9f1kLhI3SA?=
 =?us-ascii?Q?xfdJgPe7rZAxkOihzd/u0sjeQrDh2aAnnMdG37wxHRc7Wga7ojUyl8DH7uOd?=
 =?us-ascii?Q?RMcdvlPPQOIW8Gsxv0rW0uyoaZKdWPilqzzOEAXexroAVS6Uo+EMxqsD9saU?=
 =?us-ascii?Q?bCwJL4S31Ktc8/Y7i4rsNnkTiZEB1iv5rh1o4jK720fYsw1lLBsHX/lh/5xr?=
 =?us-ascii?Q?mKSyB40QM1uIHTFMihCvEs3F/ijAycNM2KlWIm3IYLseh6z/HXYIGhRMOeS+?=
 =?us-ascii?Q?G0Y/7oJlG0gX054oSPhcyQsYvctCt1QkXplcaa8UbPLz9hGpjOw+FRpsTLH9?=
 =?us-ascii?Q?TwgYKG6RRTPIvgt54HUs2arAVlTQuDjz46YmT9eu8QpMnr6baiV4KyT2lbCJ?=
 =?us-ascii?Q?ydTUTayoqN6MuiAGJGVq5VNVfgbBPCaiMSAoAlHTqQWiB3YGsULxSmWtz218?=
 =?us-ascii?Q?BXniNQDI+donU98aphccSaOrcS5oZpUv8/fTw7KGra2p4V4ZdNXyn88kjv5x?=
 =?us-ascii?Q?saxKVz+fKYPFru87R0QcnByykd5omkvGCLq9N3bRZ2xKIu/ag63vdI7dLUsz?=
 =?us-ascii?Q?Uzodw/IdjX6cL5tb2QM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m0LBlUIkjtikDT0hhrqIlRvdkApqkoVOdkzlD1nGFd6r26wYgqEAQw8dUzG4?=
 =?us-ascii?Q?4kcZPaTml/vCoI6Bqa/2fvPeuUXX4yDeiIUgEJ3L2GsWsfKuIpCKkyzyKURT?=
 =?us-ascii?Q?Zqa7Gwy28mTf9ox3nk5cxw90yxHJk+VTl5Apz4qDI4E6D3gW+NST7HZ0bIdh?=
 =?us-ascii?Q?wE9zrwbb5c3Aru7pBxDspetOuaDqWmB6yXTbR8E8V9hSG14HxGLiQ12KkgOk?=
 =?us-ascii?Q?/df++HCVDQ86TDJ/dakYXCUc9YVw4CcAqStr1bNSmuBXWuDRdZafqapxd3WI?=
 =?us-ascii?Q?uX0USc7IHy+sRKOPUEpQW88RHJpyr0620YdtMildQgG4IOsfmYl5aLm4vmye?=
 =?us-ascii?Q?vDkV1B8eT6qpqYYqB/Mtb7L/4DyASlRnnH8IOr6K1CTZJNOIGgZpR3yN/4qx?=
 =?us-ascii?Q?LolH+DbdMeFQYYV8BcN8E8v54yztd58iyxiFcDlNL+5vlv1er7GdAlTuvvbP?=
 =?us-ascii?Q?aQXlVkB+7N2tX+9cw763dLZTK+XM57jeHMcfMKDMSnYwb0fbJZBvJ/kEpVZ4?=
 =?us-ascii?Q?JxYU2GOkkf1GflNGlmoE6zhJ86RaaauPM3psKPYaH9icQ/A+bwpxATIyw6wc?=
 =?us-ascii?Q?4HxM8GiC3EKQVXmpi71vYktk0G0IQzA2KTZ55+MB0Yj4M2ZCt4yLfDCSLKeN?=
 =?us-ascii?Q?B6qIiDAw3PPZlj+jijrEVrO3toRv3aLlEiKpPHxQKh9CQXcZJwh1wj7F+KKr?=
 =?us-ascii?Q?xkIMy/km/0iIXQm3leSVyvEHqEXeILBXmN2sIF6ZQqLH4OgBMSQqJoCTWq3L?=
 =?us-ascii?Q?o+e5MwcuD0TFRvQID3nsBNMIsGsuSuGkSd96WuCv9nbmSnpU9Z/o+Mdal7mo?=
 =?us-ascii?Q?llhHoDwVqZE2yh06J9anJ1cetkodWuFN0gu3EE0xRPrM59/ZDmcRnGyAOtHL?=
 =?us-ascii?Q?+jX26AzAtK33xfKn2I7QB2Dzac+1TVFFXUmU1/ng0fG5RJid8tkZ0QOsFl9M?=
 =?us-ascii?Q?o9iJ6NpcFZIVi67SThu3kLGn3qH/i3m3AS7T9dhuropUESWHylXQsqckXtcO?=
 =?us-ascii?Q?ou4GJfxIfD8pFP+kyiwuRzBEcTYTfM144hDiZZM7aSIV/z1EjBXYxzOUkXCC?=
 =?us-ascii?Q?YxpxP7V8jmi0K62gUjt2bXnThEe6D9pOETbJn8VdrZKVSZ4a3wNMJ9lktJiB?=
 =?us-ascii?Q?dGkwrSo70KEQTir/IhQtElMndy9iEkIKPdvLpsQ+zTrDaLRjDysCt29RKijg?=
 =?us-ascii?Q?Cf5ovEb2FWxHmHbgAOAIcFO8MDNRfAqpqGqLVCbgxHOsh2H3cdzInVOPHJ1v?=
 =?us-ascii?Q?LUm2G1x/dgp2COHzxeBI4HMl1bIEkUabh7dUCM782JU39k5Ug5VJPlUonR8J?=
 =?us-ascii?Q?LSNvul81ThR5H5YWXoJO29C9CIJGg2Xr7Y6CoL34d37Gy8M0AkpY+toBj1D3?=
 =?us-ascii?Q?yIwmwoHJVY63O+6mJ32C632aOqn5CHLbsXffHxLaXGQPk4Dk5Jv0CChp0hYW?=
 =?us-ascii?Q?sJaecDzM9LbMY+qFaaKrVsnBol3q/etts3OYoxjiFZdQjFXeEb9kU7LeiDDd?=
 =?us-ascii?Q?jXj0EXx50enumpQI6jk/UVLxYGb07/Bx5o6/hDEXzXtxXqZwT06jlEY7nKkS?=
 =?us-ascii?Q?hfyiKfjXAEZce0fuZzzuG1Owq+uhrEm31HOhGrZjOWMC+71u36YtWKW1Ivw1?=
 =?us-ascii?Q?3HaPe7eITznWBFeNUsb/m17FJWMEtXAg87I5UhdrgZzQfZHxYEGhBmjz09Sn?=
 =?us-ascii?Q?cswuwu9Jk6cqzXiOJBrkYlZa9Ps0El2k4HWqFa17Qr+5wqd3EMIUur7grpdU?=
 =?us-ascii?Q?LNMLCz2rwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab3be1f-7d5d-4313-b0bc-08de57b036f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 23:12:28.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ariDVXj2zk7bLq8/6WvK/TYCix/rRGWamNaRldoq4sgK3OUYVjL6jcps0VbbYGq5RaYDgmlMz+2jqsfX4xYIeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987

The WakeOvfIsDeferred code path in __call_rcu_nocb_wake() attempts to
wake rcuog when the callback count exceeds qhimark and callbacks aren't
done with their GP (newly queued or awaiting GP). However, a lot of
testing proves this wake is always redundant or useless.

In the flooding case, rcuog is always waiting for a GP to finish. So
waking up the rcuog thread is pointless. The timer wakeup adds overhead,
rcuog simply wakes up and goes back to sleep achieving nothing.

This path also adds a full memory barrier, and additional timer expiry
modifications unnecessarily.

The root cause is that WakeOvfIsDeferred fires when
!rcu_segcblist_ready_cbs() (GP not complete), but waking rcuog cannot
accelerate GP completion.

This commit therefore removes this path.

Tested with rcutorture scenarios: TREE01, TREE05, TREE08 (all NOCB
configurations) - all pass. Also stress tested using a kernel module
that floods call_rcu() to trigger the overload conditions and made the
observations confirming the findings.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      |  2 +-
 kernel/rcu/tree.h      |  3 +--
 kernel/rcu/tree_nocb.h | 49 ++++++++++++++----------------------------
 3 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4..2921ffb19939 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3769,7 +3769,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	}
 	rcu_nocb_unlock(rdp);
 	if (wake_nocb)
-		wake_nocb_gp(rdp, false);
+		wake_nocb_gp(rdp);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2265b9c2906e..7dfc57e9adb1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -301,7 +301,6 @@ struct rcu_data {
 #define RCU_NOCB_WAKE_BYPASS	1
 #define RCU_NOCB_WAKE_LAZY	2
 #define RCU_NOCB_WAKE		3
-#define RCU_NOCB_WAKE_FORCE	4
 
 #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
 					/* For jiffies_till_first_fqs and */
@@ -500,7 +499,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
+static bool wake_nocb_gp(struct rcu_data *rdp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e6cd56603cad..f525e4f7985b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -192,7 +192,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 
 static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 			   struct rcu_data *rdp,
-			   bool force, unsigned long flags)
+			   unsigned long flags)
 	__releases(rdp_gp->nocb_gp_lock)
 {
 	bool needwake = false;
@@ -209,7 +209,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 		timer_delete(&rdp_gp->nocb_timer);
 	}
 
-	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
+	if (READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
 		needwake = true;
 	}
@@ -225,13 +225,13 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 /*
  * Kick the GP kthread for this NOCB group.
  */
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
-	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
+	return __wake_nocb_gp(rdp_gp, rdp, flags);
 }
 
 #ifdef CONFIG_RCU_LAZY
@@ -518,10 +518,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 /*
- * Awaken the no-CBs grace-period kthread if needed, either due to it
- * legitimately being asleep or due to overload conditions.
- *
- * If warranted, also wake up the kthread servicing this CPUs queues.
+ * Awaken the no-CBs grace-period kthread if needed due to it legitimately
+ * being asleep.
  */
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 				 unsigned long flags)
@@ -533,7 +531,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	long lazy_len;
 	long len;
 	struct task_struct *t;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
@@ -549,22 +546,22 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
+		rcu_nocb_unlock(rdp);
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
 		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			rcu_nocb_unlock(rdp);
-			wake_nocb_gp(rdp, false);
+			wake_nocb_gp(rdp);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
 		}
+
+		return;
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
 		/* ... or if many callbacks queued. */
 		rdp->qlen_last_fqs_check = len;
@@ -575,21 +572,10 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		smp_mb(); /* Enqueue before timer_pending(). */
-		if ((rdp->nocb_cb_sleep ||
-		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
-		    !timer_pending(&rdp_gp->nocb_timer)) {
-			rcu_nocb_unlock(rdp);
-			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
-					   TPS("WakeOvfIsDeferred"));
-		} else {
-			rcu_nocb_unlock(rdp);
-			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
-		}
-	} else {
-		rcu_nocb_unlock(rdp);
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
+
+	rcu_nocb_unlock(rdp);
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 }
 
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
@@ -966,7 +952,6 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 					   unsigned long flags)
 	__releases(rdp_gp->nocb_gp_lock)
 {
-	int ndw;
 	int ret;
 
 	if (!rcu_nocb_need_deferred_wakeup(rdp_gp, level)) {
@@ -974,8 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 		return false;
 	}
 
-	ndw = rdp_gp->nocb_defer_wakeup;
-	ret = __wake_nocb_gp(rdp_gp, rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
+	ret = __wake_nocb_gp(rdp_gp, rdp, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 
 	return ret;
@@ -991,7 +975,6 @@ static void do_nocb_deferred_wakeup_timer(struct timer_list *t)
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
 
 	raw_spin_lock_irqsave(&rdp->nocb_gp_lock, flags);
-	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
 	do_nocb_deferred_wakeup_common(rdp, rdp, RCU_NOCB_WAKE_BYPASS, flags);
 }
 
@@ -1272,7 +1255,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		}
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
-		wake_nocb_gp(rdp, false);
+		wake_nocb_gp(rdp);
 		sc->nr_to_scan -= _count;
 		count += _count;
 		if (sc->nr_to_scan <= 0)
@@ -1657,7 +1640,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	return false;
 }
-- 
2.34.1


Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53982BDC3D;
	Tue, 15 Jul 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609753; cv=fail; b=fEkMENeEFriJDTu/+eiBNqoy1DI3kETmssoSNXAmG5xhklLqTeJLt7UZFBVfIHZ8kQ0obyl7fPW56I7yFQae8JU76fqd36qSMP4/y8qnjtAsuHtrwYiougSbZRuSgqo0v8y4UYLi98ZbetderG3FGYVwlaq70rfPCZxGfMUatfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609753; c=relaxed/simple;
	bh=xbrjRO+2o+EmBpiieN3XEPkkux9P9ufD1VSv4HzhqbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aX2+4KPqfY8on5ZKzDorZUJURtTwW1TxkyCGVXFXW1NBrEsM8iXLr90dtChaHGeTD7OTG+6LDGlKgvb7m4QDYalyd1S1Jhi2K5ot3vAUba57pAbB/L8D2XLE1BvofOKEm9vpuFlAESKHBzaWxNVGpURkXbO/f1GUeFsKZPbzvS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F6bxxQwJ; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F6bxxQwJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3dbdfJg5Srj/Nv/cbsmglExIe9mXpstYii1r6+KAICS1mQbxCHwjjuh3gU5mkjRF90W5Fa1BiW3SNyA84qhpNIPPWt3Ep5EiIm1mxMDoFXzWQ0EG5m57KVCg5o5CcG6Lvme+gjVFs4hanrTN4PZHYZML+okiNbf4i9cm7xCC3Kk8M0MhCPamaywJhGPIA7SUMsvm2A4FTzyW2FlLtCXQKS9FshsfJtHR1ou4XoCyWR5hnla32+Ylbo6jrd9opPKV3znXWKinHqhqAdZTKhCC6qG8f6s2z9Vx+V66SIwVl0Vt/+9CXxI3vzZDtAFLdA4HgzFxSULpDCX3Q2RkA+CMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUUjCNOXJjfj3G8F3HFBZAAmw94YCQJlIDPodvrY0yQ=;
 b=qK0pqaaq9g81v5hoQ7qsG8Z7tlazbEzQCRSQk62uu6cH2hI3qWCxctYDg6TEutcx/nVSFMuCzkb+4tfDPYBqLzPOI2tGyWVCAMkw6zTRo6l/2mc0gfLV3AGn7hLw6t8jga8DlRD4/bwIwOi680QdHQ0VdSI0yjlbeAksVnjflyWWdhh2xq1g75o6IoqbQ6xpwUJRHbDEU6PkJ8IQieKbNaXJtqijvT1+OywUyG8fL0JUUR9RZ9ye3tCPCyfrw90GZNOLIuLEXyz+S68Uj8NY3aOuksnYT/2i63EqI7N5xoo5nOiWOqxoE4mmphBSROv6Wrq2ysiiF2lEMwYE3TvV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUUjCNOXJjfj3G8F3HFBZAAmw94YCQJlIDPodvrY0yQ=;
 b=F6bxxQwJ7DDXuvJUhmtWFQ2mkuPHgvJ4tDKTWtNTOcuf8FIQ6MF1Z8+4b1t/0gd+BnB84M1HbuN8mIvZhrcTDuR/YgYKnsKoa5F26abD+ItlYGdGXyQLcuLbdLpcSqG0FDnbMD/ivy1S9gaf+pqEDkzLdtU1d/l1dY85TbOu1xSimJxy8VQ2Yvn3By71jpG3YDAY3tdjglCriZ4SQMOYVjrbA7KI9XeEnDCFhqoaleAEahWI1qD0zQe7cc2oRj2lOTUN7g4GTMaKzbo7gXzchntuDlWKejKAbcWzspbJk5nDJdHA0klE3WAsZh2ByG6gYY9Ldzbx2A2wuvLT95OQag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 20:02:27 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 20:02:27 +0000
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
	Zqiang <qiang.zhang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>
Cc: rcu@vger.kernel.org,
	neeraj.iitr10@gmail.com,
	linux-doc@vger.kernel.org
Subject: [PATCH -next 4/6] rcu: Document separation of rcu_state and rnp's gp_seq
Date: Tue, 15 Jul 2025 16:01:54 -0400
Message-Id: <20250715200156.2852484-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715200156.2852484-1-joelagnelf@nvidia.com>
References: <20250715200156.2852484-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:208:52d::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4cfb05-817d-4e7d-bce4-08ddc3da85c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oRLjiDGTh9Z+b/Rrff8M3Q3QUxks3s3seFWNpLsb/0ffcrnzHwfZR+X7KMXS?=
 =?us-ascii?Q?c/07tDyoE0eawCkM/ijKSk7WFd8qACoyIh/D32uQr4tMpTGxSuUSZ6PgMWT5?=
 =?us-ascii?Q?5aR8/XL/Ls+c4pu1ts/l0LAA3+Mk3R6mPa/N0mI5i+CH5yK1I9AbcpBHMmJH?=
 =?us-ascii?Q?CB6KWQIHaLLUSZn8ns9e/JqXVkIC2fFei1CuwMt1zlziJ/AG7zyfSYcpGLv7?=
 =?us-ascii?Q?SYR/L3WPUeJxvE5wpOjC9evEIp5dad61lM5JHrWMTDV5uxcbEJacCYHCctGL?=
 =?us-ascii?Q?mA1IPT4tMNNCkKC5JF6scx6RLEty6YuqHvbR29ykJ15TYKxRQxFIoeLOkrhG?=
 =?us-ascii?Q?od9RCugEIdh+QUn4uxa0c1cYzb5b7IJqZfL9uSWUino4l5Jz1K+2V++zQ6My?=
 =?us-ascii?Q?w8/uIVPRBtqoditr8+6sn9j5v57J4OcUZ0kMt3QkI1RhOQlXnXh6PESJ5NeY?=
 =?us-ascii?Q?2qGj5x+NA543PtPUQMDiQmjsUky0JJgTBDmrnad5SviYPRHpvBv9EC7TLsPR?=
 =?us-ascii?Q?aOzaKVsZ5FUVIFH4MnoY8hair3SHEF/RxDtCjNhYXH20iXnN64uVPni2CmBW?=
 =?us-ascii?Q?n1Zpx56fYNyKg6Btpbj3Yq0gIkbkoPYdXvMZuddK91XuCp7KCFGvlOyFv3Cp?=
 =?us-ascii?Q?j3HdA94nJ9lwvYRYF0HmWKX7FX/sVzdnbn+D7qVyKmPRzvYZ9YZV058MkSpT?=
 =?us-ascii?Q?flq6/uUf9jtZt90kC53bk7uDkIM4kN/aMyvrHFkegjJrLd7f258aI+34n3mN?=
 =?us-ascii?Q?cACADJqt9/LIkS1mckhlYrOBk/FGJzNr+yBjys9dVo6sR+8cBS9wTPapdApn?=
 =?us-ascii?Q?FSwH2XEX3NrJxzcF94K+Azat3vf7Lr/uThst2h2L2tV+84IC2s8iVIRNfqHr?=
 =?us-ascii?Q?1LHd1zlLbWcc3W30qV8iEAyJ5rz+QnTIcnVRgehMfgWcT5Mgd4fHUquOLdPE?=
 =?us-ascii?Q?eLRDX+xkvxgrt6VLZxSYQ0BdKDXnn1h+dRIgaqUOYhDfqNAYhU1s5XEGpk/J?=
 =?us-ascii?Q?yMFVrLfScn7pIpXl2s1K+w3lHKXnC1IB4DU2OsaEVIYLnOL503fAT5F+ef/3?=
 =?us-ascii?Q?s+IiTclHNEHGWFK/Uy3ci+BNwNpt2G7jxvEMsQCeYPeA6l1U0/NlXlh0OjG+?=
 =?us-ascii?Q?/oApCZbhcPEbf7xlxD7luDEarTyOOAsWvB5XBEFxq+3JZx9NjAdVYrNnmxZr?=
 =?us-ascii?Q?CeAZHfAW4AeYqWP/QEUN4HSgG9NYaFUTW94VS03E9j7EG5frLwEKZGOGsR7I?=
 =?us-ascii?Q?A3HcaxBoh4JGS0wkNT7ZXxI+wHeKd8nrGrDRYDlR+jqrFeKrqhErsR+aNT6G?=
 =?us-ascii?Q?QQ22SREsR3374uQqiHCBReSaAYgVQN2dmPRAv7P9noLhtHxbWrUOXNxYY77e?=
 =?us-ascii?Q?JLruUtF4eevlrLZqj7u5LXN0XiEGWf28QOPkmlgC2FDnYW0gbw+4pocn/7UP?=
 =?us-ascii?Q?cfYXyHktFgNIIrXIZFtYmJuYHQm0PJDnw7D8wBR8ghhW9N9zil8u8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9cSZEhPUDKXa104Vb5dagQJzYnFV0+kUNrrFo/A6QNnoijdqE43jlSe3nVAh?=
 =?us-ascii?Q?bUvMoTzwS9gdMwXOMr+T1iX+wpm/56lpfopSEDGqfwvEx68PLWZS2aZRsWaX?=
 =?us-ascii?Q?K5Ftyh3BMjAWW/YqzLxMi5oZMicN/9Ax+xAtN+8PsLAuil52M19Dl/s6Omu9?=
 =?us-ascii?Q?JZcc5yv3386UUMhZKDi+E0H7yg/318goPWvueCyb6LECNKd5qgqYVu/WvJpu?=
 =?us-ascii?Q?lDFOHt10ocwn2UT3eTMrTYoKIHkMxES6GxzrsQnI9gQDRU3czEj7evRcFMqx?=
 =?us-ascii?Q?DaTXpzOwl2kswMBfijtJHvdYAyzrRd1nIUKSp+e6Pv5KfLteiJq3cRqNGhbw?=
 =?us-ascii?Q?v1pURw6Eb2BeOeh/0WBExMFQXUVLjSX0FmnVyJlAzoI49m0ioFq7DlfJRFpf?=
 =?us-ascii?Q?FCEK+qsaOFVNBf1yclMTf01sDAJTXrh66EzmbUPJExlr0W6j/rPGp9U1f6i1?=
 =?us-ascii?Q?JCLWDX3+o61wV2vcS/M4C3hYEk0Th5rhrP3mBcgVVAtkDUJ+plxr1RwZplz+?=
 =?us-ascii?Q?Ej51SMepaYv4L51efxIG45B3gtWKYEFGNixwYsplnA3gtrC2RO3Bgwi0CdGV?=
 =?us-ascii?Q?Eeigy6G4K+3b3arMxsvxDOcFAMEoCigYhxkHMv1Dhgz59TElKRbmJqmkP/P3?=
 =?us-ascii?Q?Yp72pTxI/t9v/xGBCCwiC3e0WK4HipOYwlyjXqf2f46Y0gINvUGd5olZjOUR?=
 =?us-ascii?Q?VoLyLjYuJLrg46SGOWr8HcmzSUyP+rhA4aI8IgDl98p59KWk5YiTOEXRyCZa?=
 =?us-ascii?Q?wzChIDLwk0tExpGwhuBBIPdv7eXQ988RSnEtrWnwbkLi+XzshVMog52Y+Zyl?=
 =?us-ascii?Q?oEONRuA3/EnZqk/BlpUOIEZf8I/IDvJWWWTfBhlIbzyWAvzLYizwCTHPaczY?=
 =?us-ascii?Q?t2N3Xp+DomfTgxxqWsRXUHEH7ux4WEkxObgiTfhwZjdu9dts3P0fc9nzqR6K?=
 =?us-ascii?Q?ccMZkAx7LE2V3AwSS4/5hyJ3FsYB7YP1DhQgXcDV+knnOfkvuIT+nSPtIPnU?=
 =?us-ascii?Q?pH14W6rMuBxoag47+oDOHH6vPqbh7yGnaSFsnCOzYdn97cJSyilGz0cM9Vox?=
 =?us-ascii?Q?XmdDxZgBSMlhcE/85pD4OMAeVUa+iecSsFMRPUDh5Cmtac5wqwl19Hwv255Y?=
 =?us-ascii?Q?Hp4pN3wGImKKrPe2GuNh13t8gJiEy2ql7le4lmQ6LJhkS50Irw/DOd8F4RUo?=
 =?us-ascii?Q?USol3yKOfKsZvt/3xP917hwdRwAqk5whEp468PI0sgMcnd4K2SY3qNxb8DQ6?=
 =?us-ascii?Q?jPbY4QsMNzTDZ4kvsjOQs0KCPgRnvU3r807bb0yQjZhkqO52DTSzWIDJznd8?=
 =?us-ascii?Q?CvOr8+jmXxS8Iduag1U78uer4xKbxu7IBJZlEvOUz4rgmD7F4gGKn2lvXR1A?=
 =?us-ascii?Q?FNRs12BJH5wcOSlICvE3b175wkg7NA6T6oyo8eTMRRHsHMwMDHYJsZ6sSG84?=
 =?us-ascii?Q?PmSNBaXeGpRksbnsfnTsqJf6ADGZoPRu3Z78Nuh6eE9ejGQZk6Lj0uueSIBx?=
 =?us-ascii?Q?7z9KqhgrKQ4hoWj/LuQ7zBa5QUNSwSipiTG2DJVlTvvZUtyyh3SbRT7gMdEa?=
 =?us-ascii?Q?sif2xr5dBC3PVPO8N24F2w9d4PIa20gDtn2hpg/F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4cfb05-817d-4e7d-bce4-08ddc3da85c6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 20:02:27.2112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsnwEVO03u1GDwYJMI80H3j0N4P1cgsbF4PomjbSFamekWc/U32xCghU1v9TmwTq0V9A508oWieEbyzSyMFx0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

The details of this are subtle and was discussed recently. Add a
quick-quiz about this and refer to it from the code, for more clarity.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../Data-Structures/Data-Structures.rst       | 32 +++++++++++++++++++
 kernel/rcu/tree.c                             |  4 +++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index 04e16775c752..930535f076b4 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -286,6 +286,38 @@ in order to detect the beginnings and ends of grace periods in a
 distributed fashion. The values flow from ``rcu_state`` to ``rcu_node``
 (down the tree from the root to the leaves) to ``rcu_data``.
 
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Given that the root rcu_node structure has a gp_seq field,            |
+| why does RCU maintain a separate gp_seq in the rcu_state structure?   |
+| Why not just use the root rcu_node's gp_seq as the official record    |
+| and update it directly when starting a new grace period?              |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| On single-node RCU trees (where the root node is also a leaf),        |
+| updating the root node's gp_seq immediately would create unnecessary  |
+| lock contention. Here's why:                                          |
+|                                                                       |
+| If we did rcu_seq_start() directly on the root node's gp_seq:         |
+| 1. All CPUs would immediately see their node's gp_seq from their rdp's|
+|    gp_seq, in rcu_pending(). They would all then invoke the RCU-core. |
+| 2. Which calls note_gp_changes() and try to acquire the node lock.    |
+| 3. But rnp->qsmask isn't initialized yet (happens later in            |
+|    rcu_gp_init())                                                     |
+| 4. So each CPU would acquire the lock, find it can't determine if it  |
+|    needs to report quiescent state (no qsmask), update rdp->gp_seq,   |
+|    and release the lock.                                              |
+| 5. Result: Lots of lock acquisitions with no grace period progress    |
+|                                                                       |
+| By having a separate rcu_state.gp_seq, we can increment the official  |
+| grace period counter without immediately affecting what CPUs see in   |
+| their nodes. The hierarchical propagation in rcu_gp_init() then       |
+| updates the root node's gp_seq and qsmask together under the same lock|
+| acquisition, avoiding this useless contention.                        |
++-----------------------------------------------------------------------+
+
 Miscellaneous
 '''''''''''''
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 040e853758df..aa6cbd1501cb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1844,6 +1844,10 @@ static noinline_for_stack bool rcu_gp_init(void)
 	 * use-after-free errors. For a detailed explanation of this race, see
 	 * Documentation/RCU/Design/Requirements/Requirements.rst in the
 	 * "Hotplug CPU" section.
+	 *
+	 * Also note that the root rnp's gp_seq is kept separate from, and lags,
+	 * the rcu_state's gp_seq, for a reason. See the Quick-Quiz on
+	 * Single-node systems for more details (in Data-Structures.rst).
 	 */
 	rcu_seq_start(&rcu_state.gp_seq);
 	/* Ensure that rcu_seq_done_exact() guardband doesn't give false positives. */
-- 
2.34.1


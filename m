Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16E3E450D;
	Thu, 18 Jun 2026 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808683; cv=fail; b=gf7ZOwytnYurY41Axw6EIAw7Y4ANj/OuCbK7ZjQq7ilEW2tXAwdXIEHm8iBUXPiLmXQNkMjKw+u08bA71bquNXFkb8URALMK7m/nOgwwUOvKZ4I3NrhO+nsZbxRpWEjyJyIqs1H5N8R362OB/YYHayuWOwhKBd+HZdsdqUC3RDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808683; c=relaxed/simple;
	bh=5cUsGHCX47yjmjJTgFNT8J8NEigkjsQ6L/A95WK4c+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtmtxRvIvZ666uvrU4OYJGT5xZGudINEWd0rQToQJjKZKUaiBCbuWNMkQVqo6ocKbrROM7MLovG5UHt7zJLrqDDjs0/qL4dAfDpYxM0t32ORGJwK8IwZTmF27ExMBEWAWSoH0YSKW6vlIwtvMOw9MIu1otXea5onWVmmFOT9sZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o//tByY8; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o//tByY8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qo94r2OrAn2E8cdSmq/k6arAESWDmEQCotPu8wNAZYOQS4U965jvhPK1GXzvnUDhspahJlgxpW06v+Ci/AxYrcBCraBxxjZkr0b7Wa+lj6aVHpvtumH0eQuBmLWIecfjI7ZL3f8ZF4ROeLIEUUgGDJe6DhpwQCEEbOBE8f3ZwYoJaXfxt69/khRVjIB44Cvbg+ujyRZYlUjoTQYO3LUkM6LMuUHdtrfxrIq/tmrbph7iD80M612rEb+D0/yMMRbtrAEThxOfGKLLICDOgeavLFSDnPPm+di/kePF30pAPm22+eVn01W2gJeefxDJLw7oSIT+vXlurIqB37OEwvwRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCBFTBQm+wrHDEdstVzAFKfSRfgAapC0qWBeYstsKAE=;
 b=VZjH7rkSQD7PGasB8Dy3Ond792vQgLp8vw9al5j6fgkfdMrNwwoNNGAqTaxS1iJY7ItJTLiemz0IcAGAXOLVzYIkd4W/CWpjRjL3yX74Ruf04gNhBwcE1CQekW9YRqX5DDri8tcSGtvc7dFWIUvErstOybg5heDe8zVzeISkAroXt/wcMqudGKxooP2merH3Lr0KQwbBm/ffwOOzoqyyaDAj6OK3+SWe74DXUuu/cFMCMx4FQQsbDsZ/f6pFpM9Ew9qweqqkRaWxFf+/jsSloNYAW5uFF9rhtcdVhE5ykQd7Td8ptK1g/dTLQGWFFrBYP3G4POwkpUCaXBCPdzhw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCBFTBQm+wrHDEdstVzAFKfSRfgAapC0qWBeYstsKAE=;
 b=o//tByY8wVn+Vljgj5nS/zndUMN53TuZJntbsjxFX2bu/IthoKNnkKwiFsFoJTn+DdAjtWvTQfZICHN9c7ytpw+FuJcQja6FU0e0WOlBroJ8Pxb+5X87ZgzNyhVMpwX9cdMtmMwSQdFx7WyYDFWu8El9BHJkkRynWj3TO5TX9BInAwNW90Z0RrHLNtylVjd1hssPFlVxPP9VPmxtxVCLhcAGZ9/4KMfaPgKbDXgrqrMZKAmZ7npRwGHu+TXPcIzMtYNvZ5DjT6EuQzOSqU6MrnmBJ/L4xqKe7bQl3fcbA6g2Dgb/5wG9QZM6GEqxM7Sh30J7r4cvYvaQ0dJLwQ/zhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:16 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:16 +0000
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
	Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH v3 02/14] rcu: clear defer_qs_pending when notifying GP changes
Date: Thu, 18 Jun 2026 14:50:18 -0400
Message-Id: <20260618185030.376450-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:208:23d::18) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 533435dc-590d-4082-cac9-08decd6a9226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XZnef52IodluzemK0G/378me2PT3nWgeXYezGGh0OaaQR9xIQkY2zPO3jKx6KcmAHOkHHpEWIIf+AX9qwesXDAKVnUo7BzMXgIpEatel+trD5O77Z6UkDGd8d+SBmKkpnVL1w0fdCZXnwk4D6UyW1J7vgnr9VoBYLaiIKTy6/HwYj9zTnlXKOHnbF0Vv8ntUdvRlU3A7H6iYF1sIqYoL7EXPKaNs6BIUlYYgQIhbR5IcQRBTISLowaItRA+cRGCwQlzTJv9xPfVXf/ei7aZNuk5YF0Ttl2JSK3tlzhqC2FXDeuoQ5JOPN/obTLFogqXFa1WYFr1p/GRsGDmgpoRB4E8j1FkU1+sm7PyJbUCTenPjd4VjhF/w+88Msy66gGq6cOcd3tGRMkSFA2a92cBzzsI51oSR5T+IQ7peQylmAET7/y6vHbbEtND8S3k/ellFNOjBMyzfNxtFUvBli8OhxkgSjFwoap4MyLQkOsLtw+SIUjpB884es7aki6TI87qsf0w+JL28JcDHG16VM4jBXDHeIGMT1awyDcrSp7A53zu58ffR3EfklZzN3PO5rTmgJFCBu4lgL6eamiAChtxhpstf12RkNKIYfS4AIe1cCRldoJ8/qYbfmn3H2vMql2LYPDTriEOPzhe+693vP5pFsra34pjEjLM3rQEE24ng+mslJzO8DueLlZE25XNv+3NY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWPHPk/BxULJPM5oHdqver+e0GBlYEZODtFX0wt341f1ERFFfzOZsaNOxs/4?=
 =?us-ascii?Q?WyMYFFmH5Vmbb4dKiSzqSnQFmttuFvT+ENJSZTWKiKTO3c8Gk3n8nZoRaE5e?=
 =?us-ascii?Q?RecfLW2LO/vfvzCuCLmC4C/eaNigCzOPFOkI/6WBQWjprwCKAJU9B7+uLm5Q?=
 =?us-ascii?Q?S+wntgpMPlvgpEeOj/R5MlbEoYT4Fo6gk2/gcRaAD+E6rerviMdu5UZ0n2fF?=
 =?us-ascii?Q?kVyXrQrxOVgC4KknSBfXM9Kka6TC6uFuQgMhaKHb4cN5cgl+bX7yC2C7syHP?=
 =?us-ascii?Q?Ysu2KeE6QLdFRZeNNfo+7zp8dwcxYWnhAmIuJ/JVu77f/ENgkTqZwixXZPoJ?=
 =?us-ascii?Q?ViwHhE6TB91GRMBffLoN2l4y+qm+3wPBdN0rx54Ch1nwK5TnJiWeiYXFW3gA?=
 =?us-ascii?Q?x5sjrokFUS4kkPRJU1eYv7BR8dXrzFOTJsV+GuwjweH1ohlKICrEWRhU8cE8?=
 =?us-ascii?Q?W/+EX2Fv10p5Tnp7PvuTETHZQetdrBUN9sd9jpkgyyiVvho1vJxH4zBVvYxa?=
 =?us-ascii?Q?HPg1u52uHSpcBM71sZc6+11CUcFThTF/v+yxbH5OEs6udU7okRSrvyY3vSfp?=
 =?us-ascii?Q?9RtsRmeFh87gwwaFUc0aeM86+XGcvOi7CK7SVFm/+uFg38UrFPa1ps1MZyjJ?=
 =?us-ascii?Q?OpmZochM7//mflzCsqZAzgJ5cjLhII2A88DOYMh+ydBNpjyhg+RFk93Xnxhz?=
 =?us-ascii?Q?SDXwBNYRZRAPRS3TOwXwR1X0T+r4BJK3yLZmVNWyC254X9C58p1gHd15UoCk?=
 =?us-ascii?Q?iESb3eY5YrXC1WT4fXftVNZZJHBBz8HmP+PXfWulb2QVM5zEXaPF5fc4OEDv?=
 =?us-ascii?Q?tRqyGA6yX8q78cbBGW8hyY5lFTVl0PlywD+cGh5eCVjjJGZQS9MwiyuLysMD?=
 =?us-ascii?Q?Yn7kUL5ej0S4aeC3kBHpslxk+zWRHH+FWV5nWom+KtCCwa2nzSyiX4ZpZ7Aq?=
 =?us-ascii?Q?eFIuTt0kTaTFYUSsKp27A6LHw1jTKZdJh7RXGMfmZ4KYwmoiZ3odhFH7FzrN?=
 =?us-ascii?Q?ZZeqLpwb+E83t0oV/RW3dEqxnMiFjzlqRz+rMQmDsFS5OvjdTp3gJLjg8n4l?=
 =?us-ascii?Q?EJbEi2oiRheinTZarab90X8lm93qU/xyR5b1+ikksKp+umHk/DSRClukFNJo?=
 =?us-ascii?Q?4NzL0zOiGKufOcSxtT1M98MsZqUCpdJO5dygSeppKbComlvuZrZeaKRL43G8?=
 =?us-ascii?Q?X7gg+wL3DBKu9I8M15AhoP8268uWkn/art2UxWxr+fPTIAVTfFY1NTc+Q1/R?=
 =?us-ascii?Q?Psg1e+aBGfmCnUJDeGuIj6TOD+6MoFLztmUvcemBedjrU4Y/IDJFBiNvT39H?=
 =?us-ascii?Q?f6MyCUrC7x9yzcIX5BWjlS+KB3ZiM+2fdsInpkPUNbsk86GKNPXkLFWJT3uT?=
 =?us-ascii?Q?Rb+pZghjwUZ85MiI1u7RFqfZGWD1/F8EUfkWIQH+701AinrTxoPNpnct4ukz?=
 =?us-ascii?Q?MsjLRDcqizN/ZkjSOuuXSgdkH3b5PhzcigQUXmc8mlBcLdlHEUGAGXuIWNTY?=
 =?us-ascii?Q?uWqyGJrm6NSjMLHrj2sAE8qqvdnvvp5IFqim9GciaTF0e8aGP2leROHhLxwa?=
 =?us-ascii?Q?iPRkt2bQSkDcrwhTkpMjewT23EhD5Ye8+0R1dvCu74oSvCSEIi1tIwkjJCnC?=
 =?us-ascii?Q?vrQjxvLyBvTXcdQ00UzZxuNK3esIVtgxGOAgR7ozgf2jlvFTtmGfw/IPVOgL?=
 =?us-ascii?Q?z022qgpMQ0EnUZ1FlmUR2rPF6P0vW2O0tHgMsKVSZB8FMkedhQc3bOwnpfJ1?=
 =?us-ascii?Q?GDZzZVM32A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533435dc-590d-4082-cac9-08decd6a9226
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:13.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpHDNQVe/wZOz+kj7X8SmOmTIKGAtM5uHge8D+vKh50udeuAQE5GHLmQ15wTVZ6MCAk4mNwY9/6KhGaJEcYS4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

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


Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86FC35BDA8;
	Tue, 26 May 2026 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835829; cv=fail; b=Rou8X7yJ0odfbJMDPfLKANr1HGvdpKXPadM7/ae8meIYXEfsu7h1CRLyugCI7e0s1df0Vc2A5rxtFQYXerKXXUh8GvpX4uP5pr1uOWx+5yD0qAK2r4f0y/9sFak5xqBiYbPf3z25QMoAuUdz/RZ0O9dZd/DKpmO2eD2m41c/dDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835829; c=relaxed/simple;
	bh=NhwsSYzpWYvophT09gClNnSlkdKeZI+E5Glb3W4Ipho=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Jwt0KpohvM0lJOt/+8RhqbSHrth0b1aNvgrDvbcftHQJ/y4UDPjfR7eQ4XxSnFCBgCyvwKFUZZg56W6j8EWoTXtSr33QPLtlNOGDwveoSUYLiVPJkqlEV5EAA/zfFBhxQ+AvFpJbZma+DtUiBEuDWcYW8bCISya7E2CQOAwG2xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dz9/bgW/; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dz9/bgW/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpKajmRlqUg0EsqI5aji1iIjH1RbOOYx9ZY65kVkP7ZfFK43wf/obM1RNHxJKKxlchMvFPif06nnAZ4E1MgeRat+Sxq1En6pNVilk0YIlqDfjkg+7FSEtuAE9ZDi0ZmP/NQu7XXUuUoYbeUsQd7j0+ykeE3WLbSYNSj4f986i9+s4/3GXXtU6KwpbO0a929mF8qtzMGQJkpQp1JkTc87mufCZKt6vQgXulN1cdRWPkoduQ1mOQuXa6BqECYIxYQBbz+jvHFkZx7hNoU8bFfUy0YM00JZmpA61oTY546oh9YbhL8TMZ5gZEujxJvg8rKa777Y2Mwh/m351pzKK1Dw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlaJU0O8JSkk5Y1HkVsh6aryH+8Kq+nHX7tXbcaZV0I=;
 b=UBg37hh61gAfXZXp7Q2Dp/ggTFbR8qqMClO3cID3cDRpSLQPmBTAmPUB5UbZlXCKxF9PzKkd7fZA+Q9Oaio2wx5+V53xResbOTbObvA596VeUqHqcUCYX7DODTe5qudcxYulWOFzVac+mbBtol6JWNa9R23AYLlvzYvVr9Ze+obzRD7v6V0Q9QOkrVa0guSXXdqGEW0Md/C3SRrAn/59hIXS5aTESfToNbxC3XTbJ3SuYvekwuFjFd1HrBNVWl9Y57JtBunboVkZM6Se8DnbQgJjfw92UvM1XLQaGz15r4/WZ+aEFlz0G98QSR6DRPmripqpRxUXnK0pGfm3IFIYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlaJU0O8JSkk5Y1HkVsh6aryH+8Kq+nHX7tXbcaZV0I=;
 b=dz9/bgW/GTrsUea86id16ylT6nV1q/z5NkgA016FQnsTIcmwZTooLBHHHdrCKClfI3YgA0qf0AoXUBZY3amxvhuFx11fd9GzTDPclt0XrElexo1SSVyH1n8UQxiyU/wpTtav4I+jv46XyeQCy8nAN15BOSyI+ChtgSACClDyKDdwldOI6tMWKoemuZkVxOYHGKayZJQcS4+Wh20a7k0djZPNJAaL/7ind55WZffV46GzRB12Gm0pdwpy701bbRIj8fFS5Q1d54UQzPC9oAKOpZfhXsZHRKZn+n8UbXIv3eKdPzYF5K+iTfc0uQ3NodRJCeE/47e3j0kpq2/+zgOuXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 22:50:19 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 22:50:18 +0000
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
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v2 0/7] rcu: fix stuck defer_qs_pending state
Date: Tue, 26 May 2026 18:50:07 -0400
Message-Id: <20260526225014.314734-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:36e::12) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a0cbcf-50de-46c7-a7c1-08debb7928fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Y/Dc82jT//5Df/mPj9dmSOFEkLW5jfmxCieI527m7gvZSPxlyRb+C8Vtl1jZm6YaLHJo8ApOa+Bb2LFaNME7B9t4uWgb1oV8xvt3sFXChl4OLm2LirQLCfMx2QfeY78/f1KgP3ysfbTZ0EFI9jJmviIJberrrSoZI3jaSeZKKAwUllH6cY8MVHXwz48/9C2Q+ebj8+Ws2fXY//OQpZbZVPTzY1V5KrEG8z6weZafRAKhX+ql4n6k4yIkGtafwxuqaGitBOP6Oor1sWqmmumL2EH6Xt5geOnlejjA6OCruWLjV52n2Gy47+8eRWXOejCvl0Czj7bVsaMU3/Jp4EH5PKyOO+H0KQSgWgwFjiThJFlqJUKvQE+r434AWVlv053wst8sSfrawbPtDYFztPbXQf2+H/YJ5RRG6yruFTlCsptZM3erj26vbZ2JK01l42imd+Rtsvw+pipEYffSFuVQ2iCcKzFZwRjcZ4zmxepWLE9JFqMH+d5UiaGhO2SqZnmiiGHo8z7ZvBp50k/n9kfT4oj5ADa9pEuH1+kk9os9SbncX0JM/KBISHFodZXXDJt1I5bmU0FS4tXmrUppxPhDbXnqKiI6Hr1Rk3Lz4JdBcGiWdm+Uq0bhxUFZwP7zIEDz48tkgs4mgWSkwyYDl3k4H+Kf2QQnNeYJ6QFKmjg4dCjpPUOStZe7iuPtOxO40gugshy6UamB5ED9VXuga3gpaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MLMbqszo45Wih25TKBRTjcW1v8eCOYYygfi2FWM3127anafb1E/S+DCx4rbS?=
 =?us-ascii?Q?zMbylUYZOmgrPhwODl4kl4mMjOnfIp6t0QVy4X8zQqS41lll0OgxGvDLBWa8?=
 =?us-ascii?Q?Usne1CmKEGjgETrhs3BuYqj3vI2G4i3ddIuNVGJ6qO3CI35jj8CMi+aiM4zT?=
 =?us-ascii?Q?B7ohEHTdLQsc5sBfqo746Kxdq3Y2JDSdqr7Hps7SMw+/htnA+BRlr+FIXK8B?=
 =?us-ascii?Q?pwJ82JrA/jQTDMpZQv2CC+oxMJPemEXJiiA4FlnQNK8iMFDnsfgJeayS3Hfm?=
 =?us-ascii?Q?8BeW2rQL2cwl0IOqXEbUtZof1raacBHWUpkEfCl/5OrgTtut6sXUAXC5zCOi?=
 =?us-ascii?Q?9z+X2DEnbyGeEv2gHqs/hRHtHcWejytDGM9JvaTuZnNOuosXSn5rlXwG8O5e?=
 =?us-ascii?Q?IhodhVM4vaBZIp+tpo8N0iuJVB4mjr2mLfvo3gP8kt9VPTiGo7ClPMDWj6b+?=
 =?us-ascii?Q?l36av5GSbPXyaBxsA1o6OZ7QW+X7ng06+2qwZyhBPg8liP3FUvnAZQtZQakM?=
 =?us-ascii?Q?3Ltd/rkx4mOCIx/dm3sYNrjqQMX/Iu5hUeyYK8rwFZnPxTde2rREZ+aE7jpY?=
 =?us-ascii?Q?y51+7Dx8F3PTLZ8JaWTHVg7zM5Uwl6NoxsazZO1zEoBh/uH5OCBPxYcyz88L?=
 =?us-ascii?Q?2csf+H4s5ykqwc8XlT/OCJ2rxDPTreV9RUOSPLYdqhyygzWPplyMOCKG7qfe?=
 =?us-ascii?Q?xnwlfUcPOcW2GUTwFpjdFm02N2YniUeSB2BvVKDNSdxUa/bD5kEp2vZY5l5P?=
 =?us-ascii?Q?3kAdfemFudv4kX+itb2R2a7niG7usXy/MYiP++VnqRyqgNkYpPdiGQj49rIX?=
 =?us-ascii?Q?iWVoYgHeVBIF1j4l6wSKRyuQab1UGswHgjayHcH42UNrnckOPhb8dJDy0U3F?=
 =?us-ascii?Q?2LAiKL+Y71/5zxc73iyyR0jIDGWESLTOA/CmoLrf9gRtZ9LubdZcPVPvNRek?=
 =?us-ascii?Q?nJ3Zvd/fyHAwPUyWz7XpiSYMG2Qqz1+BBG5dHLoFgo5ZzSGDBTVLIac9i0qr?=
 =?us-ascii?Q?RgsfAHhjhKSQBv8JgAtwj/7E144yoivKwO5MpYmjTE6Nf19GiANNeHKvM20s?=
 =?us-ascii?Q?uaAu/e4SQzUe4fdREmC2w9FNo+2vRl7Qu0H2Mzfb0m6fnfdDAfQ5Wpi32iC8?=
 =?us-ascii?Q?EHmemEKgBy4onEmVBYCj0xZWlUdI1QArUiED4MAEyeP0eeW5XM8arfns2o5x?=
 =?us-ascii?Q?p1lhCMI1pvzI58RZ2aJ2vGoWwMCiWi5K+UzoJ+M0eeWNoBDZilwg5/1N1Xyp?=
 =?us-ascii?Q?1IgSiWsEso8nur1mmw3nHcwIJDvxyxJpc0yV0UGxwcmAHvz1/FDYjfL0k4As?=
 =?us-ascii?Q?XLioE/bkaVp0sNWCvi8y5Ch4t6+R+Sv9ToAPScnULFLw0n5Si8cHtxADEBpx?=
 =?us-ascii?Q?wcMGEoKGSnTGgHaLjgftzvpOllIg1pQRgYTWMLrDQSkQMY2ZAlxX5aszNZ4h?=
 =?us-ascii?Q?oUU2SY6XXJnFz3abpgmhwJs18bELlt8wvEKvJv+MtZ61xgbTpMAYh03HRJOY?=
 =?us-ascii?Q?CGq/gaKdiCp/Rqu0oAaAtBJiTFiAeWf91YodRUE/i0ynYV9JW+yOSNjUFtd8?=
 =?us-ascii?Q?iamj68W22IRaIA7C4x5bK3XFO1033YrUVKvxU/eqNTi8NWaicwNWMXFWZSOF?=
 =?us-ascii?Q?JfTneCGcaHWdzAfjZHDO3Ftyl+SD2otDf3dEcsJNiCaknjrtrPgqtM2BKoTo?=
 =?us-ascii?Q?DYK7ckIsAeNvIiql3GeFiFpRJ0jmpVEajD/9yrXXAJ7JE+9Pnrvfq1l+src6?=
 =?us-ascii?Q?YteE+pVRNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a0cbcf-50de-46c7-a7c1-08debb7928fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:50:18.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5WoRsuOhtYf029bBOUT/XBPN4aROf8xg3Vf3OtjVUf/RikvxYI4gnKjLiCE2KCIlIjVnLvx+GP2Umkwa/aMcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

This series fixes a bug where rdp->defer_qs_pending can remain stuck in
PENDING when a preempted reader's quiescent state is reported up-tree via
a path other than the deferred-QS irq-work handler (FQS scan, hotplug
transition, expedited GP IPI, context switch). Once stuck, the pending
gate in rcu_read_unlock_special() silently suppresses all future arming
attempts on that CPU. The series adds PENDING -> IDLE transitions at the
missing sites.

Also handles the case where the deferred-QS irq-work handler may run
between segments of a compound section (per Paul McKenney's
counter-example).

The softirq deferred-QS arming path is now also handled (patch 6), which
was the remaining gap flagged in v1.

The last patch is a debug-only detector (CONFIG_RCU_GP_CLEANUP_STALE_CHECK,
marked [TEST COMMIT], not for merge) -- applied alone on unmodified
mainline without patches 2-6 it reliably fires a WARN within 5 minutes
under TREE03 rcutorture, confirming the bug exists and the detector
catches it; with the full fix applied, I could not reproduce the issue.

The git tree with all patches can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: rcu-dqs-stuck-v2-20260526)

Change log:

Changes from v1 to v2:
- Dropped RFC tag now that softirq paths have been investigated.
- Added new patch "rcu: set need_resched on softirq deferred-QS arming
  path" to handle the softirq arming case that was deferred in v1.

Link to v1: https://lore.kernel.org/all/20260522142342.1536533-1-joelagnelf@nvidia.com/

Joel Fernandes (7):
  rcu: introduce rcu_defer_qs_clear() helper
  rcu: clear defer_qs_pending when notifying GP changes
  rcu: clear defer_qs_pending in handler for compounded sections
  rcu: drop redundant defer_qs_pending clear in irqrestore handler
  rcu: clear defer_qs_pending at expedited IPI entry
  rcu: set need_resched on softirq deferred-QS arming path
  [TEST COMMIT] rcu: detect stuck defer_qs_pending at GP cleanup

 kernel/rcu/Kconfig.debug | 11 +++++++++
 kernel/rcu/tree.c        | 49 ++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.h        | 13 +++++++++++
 kernel/rcu/tree_exp.h    |  6 +++++
 kernel/rcu/tree_plugin.h | 31 +++++++++++++------------
 5 files changed, 95 insertions(+), 15 deletions(-)


base-commit: 95c7d025cc8c3c6c41206e2a18332eb04878b7ef
-- 
2.34.1


Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416DF2E1728;
	Tue,  8 Jul 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984577; cv=fail; b=N/PNT+PgLUvsuHaR2+earDw4Dcf1lKrat+d0/quiLyDwrj/XxRPj8y6D6w8t5EE7nWXXYQt2g/PkjZGtwsNmacw+D0QNC5SQQzWbA7WqfCsx1+NM/TZ2g+9ct6x++yLbcyTEy8bJv4EcF/rwkR/cspySQMUtq1ULnwz9PCjZWXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984577; c=relaxed/simple;
	bh=h38udbIR9CfLXOmqOQzjzPvQzYvZ/LPT0SvxZu1Xpi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qTusCGDktfy067dX4WwsspM0Ik7USva/SP+Mf5cKMgzFVIpyh3mwC3xsgaX0nmoTHQADvSUG5lMIitY/hOEXIOmQf70B1feCPAEt4sZOJA1zCWL037dVWF/p7o0s2B0UQWkXTFoWp8uNtasd+iTyME/G6OyP+En87fqkSy1vbig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L0qbTslC; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L0qbTslC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1//dQzz4b/J7aVACkSABEn+QGQmYE/eT4mYKYoyUEyA4/5QboXwuYUcPdP4jrEM0yscmFkGgzqBQnvq/xK9po77FwOmtbE0/B+iCZtgVSbdYOhbUuDiIozowdXs2TXhL4BujZAqq0MuWKKVH5rytSb5DlOULtLaVjUUqLzS2qBkzxxvPLTvPbSZVArdu+2R3FOnPSAVDXBCecmBwSe28QyARdkCzmMvdszCBxma53xg9msc87UpI9gOgWIIsd1n2ylmjeRontfdUaBV63SX69oJyrHO4yQsz3LYjzB/8CMCHP0QQzacYSDKeqeqInhKlq2YIHDXEG7RCxNnhyiAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8GpAXgcxkru6LMjglDGk4oVMLMfCUPAak5Bidi1xes=;
 b=u29RV883Bup5mKq96yCxyY5bPW6tP9Zc272M2tJ4pgoUft/gawupd1E27Ye8F8g0oQg5837W4t9tmeGpCaBCxI4YmOjTMzu2zHder8EGCLY172gdqz2CdAR1OlFHvZRyqjo0dU10I/pZAjhnZITKwvWWcZF2tUL4NpiWsP+sHBk5byQErz6de7sCYVXRCYLyzFyGH7qBbRwIYlj1652cOT2oPPr/NCpeNlpXkM6IGYb7pkkktXOvoiDpJaMq+reo3ELC2uP0QpFGNpG+7zgYdoSV0Ii5AoM2MWqukUzDqlXBJs78i+hAuTZZP3wRpC8xvw1xxUqCOUklV2zEzPFI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8GpAXgcxkru6LMjglDGk4oVMLMfCUPAak5Bidi1xes=;
 b=L0qbTslCAHhGBF/jDinJOR3DgASpQO4ukNbcXm1b5QzA44SuPOFa3bx1gm+4sRHrbPenrx3sTJ5iWB+q2EAnxtpjabR5JgLlR8ZgEzlnJ6fR9c9JligMm+pjqajgCFuauNJIh9QP8+A9Z1/5KoodazrBLvVvfLwX5+pUbXSGLoeG76MJGC3VJFIlrqUryKle3Hkpnu4tua3yOjfFEziOWPbL86Umqi4mh7TnMaTUtG2aBJMK57IemkC2+YG2Okvy0hjH7dNC4DmgFSOi+cpBlJb64ogpTCVolV0ixIxDfSjUlTEPyx5kJWbwvvrG8VJikPIZipThmXKHVp41PygzaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:22:52 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 8 Jul 2025
 14:22:51 +0000
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
	linux-doc@vger.kernel.org
Subject: [PATCH -rcu -next 6/7] rcu: Document separation of rcu_state and rnp's gp_seq
Date: Tue,  8 Jul 2025 10:22:23 -0400
Message-Id: <20250708142224.3940851-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708142224.3940851-1-joelagnelf@nvidia.com>
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:208:32d::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fecfdc-3217-46b8-4779-08ddbe2aec3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yLgq70XTgyB8chOebzeJYzD/kE6au9WON4ByRNiYf+uBl9tksja9FWvEbILg?=
 =?us-ascii?Q?VvfF37WcTWDQAanhAiM36Mvxo5KHbbKM/NddtmBUQLtMTCwNbvVaEPve2Yie?=
 =?us-ascii?Q?Bsi+N85FEx6Znjf0aJrP3fKF9zRwF80ngjdpoxdsXNfK10bwLID82BEg2J4E?=
 =?us-ascii?Q?A8A+RmXQe05sO5U2RiX2hn5mS5fklDc/hvnLCoHhI7ychCz5TEwCHa91scmR?=
 =?us-ascii?Q?cbdTDTx8+4GnNFZKWxBot9qHIBN+FOUWyX8t0W00kqJuCdMOXuO5VJVInSBg?=
 =?us-ascii?Q?IyWBkN5HbQc5Qb/8lYp07QL+PF1umI7nEq6eLtz1ntkHvU8rs7Y6aEbpMAGW?=
 =?us-ascii?Q?sriNrPg00Ef6BhU8DhxN2zQS7SnHMlY+f7rUNRc9S56PME5ZVHHqm1nyJYJ2?=
 =?us-ascii?Q?0JLVV6rs+0pJ7tMKvESrPGgNChL5TLvjhe+1/AYCtjSC7sq36f4GUKNoBC+S?=
 =?us-ascii?Q?U765LIbjHERSVZ+nbUOfVOhkFRDsb6c//jmGUjNlLea79DswHM5NAx7eQd5U?=
 =?us-ascii?Q?cRyj02zc6ShSyJLmNZTvPwZwLZUXrMHNfd0C4Dj5Orj56YVZV9aevH4NkJU7?=
 =?us-ascii?Q?CIV6AdLh+WQL/ZtAMTFphD/cf/rusjm6ra4j1u4txIa0EnvHslfhqYvK+wO4?=
 =?us-ascii?Q?3DjEQkkr3b86D21Fcvq2Q7lbaQwzZ4QWsw9N7rnCYt4nG2q0DQmNY2kVUES1?=
 =?us-ascii?Q?TP4PY38/yE8tE9gdvacNHMgRJtIszl3HxFiMsYc5PkBBRNVJmFUG/CvTp1bE?=
 =?us-ascii?Q?MznaJk1UKG162U8vitz6DOZ4sz9wa/i5eg49IRD8YnA7zXFrUj+/p5Ugx9vK?=
 =?us-ascii?Q?SyYWyf5bGQiR159IjukNny1+F1Y2TK3Mxu70bPv4O/jFGbPgL22C/yjvJJrJ?=
 =?us-ascii?Q?8k2UsvZfImA4U6WxP8WJrnERjUdfv2wYF8DBuZkZTqrHUFp4MexVI11SfzYS?=
 =?us-ascii?Q?VwPqhmEP+5fLy3IsxxRnGxor9WcQFwCtrEMmLBzTiy2RHVGDOxpz3XRdtWuF?=
 =?us-ascii?Q?e4XhjVrvBfANh/upAyoQbEn+WPVOHBi1XpzdrjUerfKj63K90iohjv2AJf83?=
 =?us-ascii?Q?ZxXy76YXGErvdMuKs3OGA//xPkUDXxevFOInPHg9vBTX9MBnaSdn/1KdcXBG?=
 =?us-ascii?Q?U7icT+Lh22jeMKpwY8AlbSsE0jZ0qz7Mb6Xcw00BB4NW8dl3inzxvj1MFjp5?=
 =?us-ascii?Q?X64d8RTtZ77Q0xXZL3oj7WI/KO7bgbidA7Sy+Nxdg5oMUJIU+Q4Qjjj++qOI?=
 =?us-ascii?Q?MtmpYr0qInbebVmI0pNb9Mf9mz2iWlOGjmr0Iv9pWRhxD0Zp1E9hVbvdu7h3?=
 =?us-ascii?Q?Ca7i1pw9o1MeSTFIt0lvAmA1hWSEEyRvxSQ5STv56PKvKwwLXubHbFfsEQ9L?=
 =?us-ascii?Q?1iEkcHNpS9iT1tWiQf+EIGd2S5TxZ7Ypgpki3+eA9B2P6wsCCf+MG6fFHxnn?=
 =?us-ascii?Q?2nYN6noc9U0C4B10TiEZD/vXCbSpkZH5SbXY9mq6lVKbDuW1eb9Lcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XyWoic6G/GQmWwXAxW2KSdfoI+Ff80Pj+J6Qu0ZP+IfnN2kmENGvBFClmCYz?=
 =?us-ascii?Q?rnERSqyIPGagxdcCREBdAu19yKu2CL3kpORudWpvtj7a0mqxBWfW7a9bdlYE?=
 =?us-ascii?Q?aDVNoaWhYtMq9AzHZZq2olx0B0OYFeqUo8QMcbpnWeH8zl/oO0/MVLzdJJS6?=
 =?us-ascii?Q?cBS9M4qfwR2Dx2ZC2X280DqUx8uaL4QOKm02cQUK/VqN26xqiZIXQxEuB/Fl?=
 =?us-ascii?Q?a6zY7raKW2wsZCnFca5qR3X4s4sMz55gyUJb27rYwN697mdrZg2G/YgA7STm?=
 =?us-ascii?Q?Q0LN2Qvuv9aTf/f8SbNMq5ZcAad3Em4ub7a11Bwr7oaRnHyQovnHZfDa2EPq?=
 =?us-ascii?Q?MgdNTZQxnWGqL4HtAbiUJTpiEpgICijwqQIn/0/2SmbXbNhGDOHSuLpu6fUx?=
 =?us-ascii?Q?4DtkfRiSseKJBRNomRy1JRgYMn97JcbBvnoEv8M5FrU1AKYP1h8pcRvanOXM?=
 =?us-ascii?Q?BJTXYRo22LV4shxNPUmUhnKwsq1tZFG90X047AROZrXAIAsrGPJeFTbhOzaK?=
 =?us-ascii?Q?/SzblSy6cK1+Lzbd+E8rjBSqeEPWHJ5nSv5eCR5qY7YUzgNmvqJear9FhJaS?=
 =?us-ascii?Q?6SlZzk1/BJ/+gQm8GeyUiKNOR2EIP/hQ63Vruif3J6J7SiSkwMP9qnkIBV6e?=
 =?us-ascii?Q?bTSGhUQdACSlY6L9ZJ0ZYzjg8N3ldD17Wpj4E5MMYbNKdsTxFyaAr+FwFiax?=
 =?us-ascii?Q?zMWZYlMHFVvd4sRXv/pBTEtflM7xSEH4oxDxcGLOaWAnFzE4Ko/Mwa62gFEs?=
 =?us-ascii?Q?HlIDhiakHaXI6KMR5g1S8B67PD5+xcGVgxXH1L6OkZKqNNDwWNxPOJIRP3vs?=
 =?us-ascii?Q?HMPgi5CMB4Q0wTfATexcv2rlQ6mImyunpdvWtoMA5Uvxsxgvbro9H7xCW7Ip?=
 =?us-ascii?Q?Pn09OL2gMvRzFcXTn+zTW/gEhSddeScgHPA18qqQRDmg+5JUpatKyVGwI9Fp?=
 =?us-ascii?Q?HR18m9FdKv29c7S6UYqVR9dFv5wPPkaTLIJtA0LlSQ3yweajZCF0HC9oJ9o7?=
 =?us-ascii?Q?IkFPLgK5a9c+v/vPYwMRSaB6FjT6bYAxRm2FUkPpXiCJB+WY9kkB9io0tbYj?=
 =?us-ascii?Q?DD36hOViwCq96Gg5iMmTRwn8gboeWBPSd5BKaXdL+MlLmn0/CyY1q4HdM11N?=
 =?us-ascii?Q?h2G0eOF4CavUNOjiThU2whzn77OZeequh3s9YjoF4FRjqvSXJvSM7SLp2OKs?=
 =?us-ascii?Q?anokFX0yfWiDxhx5AwwtsB+EMy/BkpdR1SAy8YvQU8KXPbrfstQdzoX3LdxJ?=
 =?us-ascii?Q?NlX2LnlHRUg9xYiFZGm/9Eo34fJ1E7UeosSEtNoThpoWSlqzb5/3vXY3RIxO?=
 =?us-ascii?Q?DDyVNdXo0bLC/MPqIVM1WzizU8Xf+0EabYx23P/olnSeLRe0p4xcEnDW/ODo?=
 =?us-ascii?Q?MVHHwu0D9GxbNsS97iFiZI7HmX2ln4AYHbGeSf5fbw91icvoOEuuNi9IHsAa?=
 =?us-ascii?Q?hwXv4cNrVk37X2ELVBW+mO7Xphtkn+UKgSfmygGon4MxCIQoLPpMFyC5feZG?=
 =?us-ascii?Q?YTzGAhYbBN6KMHaH7dHrgzFGr8SKpnmdx2ahoZ40bsqhJyWDUO6xooHoAmJW?=
 =?us-ascii?Q?bpH1rsJus6puQB9WmtrgAGwD2WcB31fxAGKOqw/R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fecfdc-3217-46b8-4779-08ddbe2aec3e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:22:51.9321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfz71ZiWD3E4tlo8/fb0HunKDbbdxwRxb4yafdKTsPn4C4ZpuIFZLWSowtovHXHeEtq3/8PmH5zAuZx8mo7BoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

The details of this are subtle and was discussed recently. Add a
quick-quiz about this and refer to it from the code, for more clarity.

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
index 32fdb66e9c9f..c31b85e62310 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1842,6 +1842,10 @@ static noinline_for_stack bool rcu_gp_init(void)
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


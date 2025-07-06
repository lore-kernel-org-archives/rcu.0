Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4328725C;
	Sun,  6 Jul 2025 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751822376; cv=fail; b=oRJepIEDiJacONBH3zS7woNJavNb5PmgrKRrR1nt1vbcsH51Vo9LPF3C2UGfhrk8oV8JSPDwszov5G1YrlO2RrBmApLAZZZEI4hyY++449fecXj1CpKepfbhlo9Vl8jntC1kLwbhNAJrR/B4icUVYmC6d85K4RwRI0B4Vnhp4OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751822376; c=relaxed/simple;
	bh=0gtZN4U4XZVw8P4RjQpwSt5aTQuk0yV6qtIXB2VEUZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJB2gIxBIhZGpmkh/ileJQhvNx7sCdRvLnHAoilzLdsreaLRA4gDm+6yXjZbHHAufWJ42pAGg5WRJqeAqwXXnn/61H/Stabs5qWyA27V7Y7gNRnaKx5PWT9GkauEZscP39dUqgBWTJ4tqgshWP1fVSzm74SW/VNjkEreWxgtPxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cWwXNJ7T; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cWwXNJ7T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoJl4Ka21/uYnUF3wkIYQ5MzFP0GtTtyDf6mQ4Aq35q0BGlUOeHGC1nhsFkktClpmEg0aq/wJoh0BKmWAVvSKGEdVBR2PpfGEOdy4pN7dggv6Xywy452fBsrtyyL00Q42Hp1IDNvld6gXXZyYIvOJPVbINuDKL/c9vJfEt2enb3Qudh9Y6ATFRExdHPEfBJ7TMAX2Yc0vOb/ThTfDmODCZoi8pIwBGB+ZeK9DRUzW1IokfaaNZ0QBNbaPPpyKz/BxtpbSw8gdp84Zf4uVZlWDI+zc9Gtv0tDbpGbAhuaNGiLQaXNn/1iZQEuDcrHcxSeG9fFdHyBaq+xKMOdU+rnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC8tcKQYLW7mUr7kNLt5ILd1ziULNb24ubKewtwA+Fg=;
 b=O0IlKvNSE0et7PjZY1OfYaUJCFkUxlaGHCDxpfbYAUsUyamE3nMi9Zkdst9WqgFrNCs8fB7dJoRuu2dmxy2YJbv0cqf30S1k/gzfvK8B2G9oD2d5AVkKVTdu8T91+VjttJkGOMCXZ+vyvq9c+Ou4E7TezpIeraT0RzIGZaVrgZBhD3PPKdzz24b7AHhtFdTg7FA7hOKjtkvIixjfGCP3lY8qOIS9JDsnS2YehPiGY9OAs0OVWRfC7rZooJR2jIyJC/ChE9EmgbsaTCSOD+MpxcH93UlSb/XdLUX+2qJ40Jh+mvf0FrFaSS7Wkw4vb5W4LmjplvoORXE6CDlNX1YJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC8tcKQYLW7mUr7kNLt5ILd1ziULNb24ubKewtwA+Fg=;
 b=cWwXNJ7Ta5p8BJJQFgaQFHOmquINincLnw08aI99LFlzvrwd3mluCWLwGXC2Tx/gX6DzFzGje95VhZjCJrDPpaS8mk0dkd01AYgF+e3V3+gWueGJotJOpXNlaAZGt6bwbWnO2wY9AqoRjI72iU38UQ7nXmA3RnZvZ8ezKaRQ8VIapw8bh4bgdQ/DvacEJlImjIKk6JumIujynxV0/gRzuT4zWVnRHMFR9UoV3ai0bX1/1OhfZi12Yn4W2OJIij1oP6g5hvhFSiEpQadnI+ngc7De0rIV610gPLIB7YJEMYYYpfUKkdMxezfMsOd/6NUNs6FIjzMXbPr0p7i0hPvqOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Sun, 6 Jul
 2025 17:19:32 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sun, 6 Jul 2025
 17:19:32 +0000
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
Subject: [PATCH 2/2] rcu: Document separation of rcu_state and rnp's gp_seq
Date: Sun,  6 Jul 2025 13:19:21 -0400
Message-ID: <20250706171922.235086-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250706171922.235086-1-joelagnelf@nvidia.com>
References: <20250706171922.235086-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0119.namprd02.prod.outlook.com
 (2603:10b6:208:35::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: c394fe41-6138-4053-4aba-08ddbcb145cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jNFYZPncTZgJc5mEid95no2b/TCfsU9leOdOIdgUAQTKf7iimmMEazgrnn4i?=
 =?us-ascii?Q?YGzblcbdxg5lzE4TNPzTsh259Mc0juGsVmt5tj7DD7QOVSfLZToeYact6D3U?=
 =?us-ascii?Q?CeENO0ziYfuAm+k7oPfxnsF5N+2gE+joz0p21g1keNeJlAEj25P0rOc/Dxvt?=
 =?us-ascii?Q?cEKgCMhQ42IiEPrm5orCDG6/l0OejEa+Kf7+NpaLUslY3oqrLswR2TpYvtLw?=
 =?us-ascii?Q?cbYi+DBgbPZOyAyZ9c96nYKeQLrQx2uf6d/Os+h/nX5yfieCLR+I/w+4D2MV?=
 =?us-ascii?Q?q1dkVkgssiuPOoDthNDxvOKTXxflk8EoKRxUXV30MZIAMImS/jGlZ3d67Aj6?=
 =?us-ascii?Q?NVjnFzdffO70xgY5DZm59qi/pXMt+jR8xnyWw8yrmR2afpiw5SeosHX9zjSc?=
 =?us-ascii?Q?eCF+ejzhka0y/vUuuSG5ycEHFAUrJTHwxT5wGo0oKi/F3yhwcHowlPChETeD?=
 =?us-ascii?Q?lprPWKUpjmibq3eDhMqHUlF/8LsVhg7jeV3cXAcIP4ONLYIyc3HOBrlPXr6K?=
 =?us-ascii?Q?1Qt0xXvGL59wvWzBQcyzKQX5Lx9gTlJCJrJakTZ/Q7f/6HRi8I6TzMRuh4NE?=
 =?us-ascii?Q?KxCwc0cN5XKWm+hI/eKoPtFuuQlI6alMD3Ul5E9yTwcRjL2QFLhR9TOOOdhp?=
 =?us-ascii?Q?qahHTJs5eV5mEfTTXJsET6TOMIS4vNuAC3XHFBHL0AU4TBrkCRd61djKqVTm?=
 =?us-ascii?Q?26sm2/bYMMW6/+s6glg4b3AOkUfoBqbWDqSRCb2E87GzzQU7o91MS+u//fYV?=
 =?us-ascii?Q?GJ5A0AvFD6AMga41WFqum1KkzX+V3WToOoCisOFJssFfYVH0IKz2F3EgcPHp?=
 =?us-ascii?Q?11jV1SYaLTs9hrY5MsM4WZ54yVd1bNA8zF13Yq86tQIDyGxPfhMw9uWQJeMI?=
 =?us-ascii?Q?jhQ0gx+ZCrtLfPKNGY9m0Z8Mqm0JnkorKI3VNz0oMI9rEkSqOLYn3s7VZ9E8?=
 =?us-ascii?Q?iKZxy4ptvUc94IeH8ITRKiBsa/7EbXCvSWdzxApahVCq6wakkTyUhTkMnlA4?=
 =?us-ascii?Q?YNIT3nsccR8j770lRwkJToaaM7xYx9UrPkSu8VhMJzdmN/KVOKVEhnzluDb7?=
 =?us-ascii?Q?UH9pXnAZXXLnC/MV8SmRqnX4TVhnA+1R00hSUxa0ezS2dE9p8iBsDSrYTACR?=
 =?us-ascii?Q?7OESYCusucsolSWPCxORfG4xq67me8GLfVAl1hqwIK1GqHGWXLOmJsEnvVZF?=
 =?us-ascii?Q?i0m+OtYH2FAbPLH/k4CZSfE2jmwmv7rSrDF/SUD2XE6CkNnAm7OqWg5508ES?=
 =?us-ascii?Q?DZ9dEPtTJslBdyypwO7UR0JFzbYRJhFKUw3vtW9Ow9PJH/XL/8zh3wwc5Z69?=
 =?us-ascii?Q?SYIguFXUluGsZj2aE1sJJT6AVkfCOV+vousBjdFmHAGyiNzYRUKsPBXFCBuz?=
 =?us-ascii?Q?7q9vNrgvOge3YQOCGgVObgYS/8oMThTqDz/WYqyLpfFBucnueoHxQTM0LJ79?=
 =?us-ascii?Q?5UtCWqxVj1ADwV8DMLzdNrTrelzEHJrbUibq3EN9z50gN6sPO//hBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q1OKN48TbmeKTrp5jo6z9OifNJERcp2Jd4t1G6f3PbiTzE4KTuZTP3f2pne7?=
 =?us-ascii?Q?mIby8pzzuEMvisPsNjUFjzMpSNtkurxwxiC9I+QugXYJj/owtj3GXP1SsKjN?=
 =?us-ascii?Q?sz9iTiF7qF3ibF+bjz8tc8L1Ar5+/62baKNd+mI3aNtAzHCsMDCQEZE9Yvur?=
 =?us-ascii?Q?/qgl1E27FXwK9waM1w+ofUCz60ErCDwYgUuOu3DraKy8lYVz4wFOrDG59WH9?=
 =?us-ascii?Q?dbMEToVK76N8xkesf98maCc8d2FhZ1QDGYPrLEX/NFvW3OL7epM1FiNA+0r/?=
 =?us-ascii?Q?RzPLXNVxGSISpecU8xp9Q6jQIelCSNE9Af52rt4BPV/8SaZUniuZghNIQZMW?=
 =?us-ascii?Q?aI0XqyIc9dRqTy4y8N94YWtuDXK4cCTWJ0xygawTQV02klQoguMyimDOuATD?=
 =?us-ascii?Q?ZkXyAY5fpxFb++rg1EJYLYJ9PIATWZUJEY9X4Ib4WsBm+og86FSfkqtemKRC?=
 =?us-ascii?Q?zMMWgyzw8BUYSjuNE6C5HJmhxtt9wJjyawH4qzDfZL64c9T4TF+lSsY5UCh0?=
 =?us-ascii?Q?qJ4udBAdqS0OBZprjuKJSAVLn0ZWr21OG1GGphWdUNcuVtmPaZ+W+n0/ZzzZ?=
 =?us-ascii?Q?TBbf6rJ27rKqvXN2hQBMScCs2AF+oO3AXK8IiNnaOWp5NTzuFOPXdmhrXF67?=
 =?us-ascii?Q?vEKGmDXpxFLf1prv3rX9G/4zeyZ0tg0VFdubz3QqqE/5NL4H+F2harAK8c10?=
 =?us-ascii?Q?f89thteqBtJOIyGIvzk6ifyZJ2KMIVBWwsyPgRs95WRJcF+q3h18KAeKpm2x?=
 =?us-ascii?Q?Bjtf5OWsAMFLWGwrc/m0t0YSSsaHgbyC9kA/5YgxH8YRzhLoVIsAU7KCsKab?=
 =?us-ascii?Q?BhxewzLrWydG0aRZrOaZ0s5EjiF8o2FMr2yfAp1jVF8YTj2N5x81TTvJwRS9?=
 =?us-ascii?Q?ipa3NH2orR0bnkN7NBl1aL9eiBmTFWmfgX1TFBjK2tk7fDksG7AW4PEqYL2x?=
 =?us-ascii?Q?bbxgkIHwtOR0k6Lm6U3Fsu8QG7jyDD/DyBthbimNWakmq29RMufECqYFRe+p?=
 =?us-ascii?Q?5iqu8z9LfhSQfwcmv2a0tH5suIBnw1T/rxjJylZu36sutlgyv3n6/HvwE+tA?=
 =?us-ascii?Q?9ZvTfEscZ8mhYkTdK/MNzscTSutqbiRGDfNcI9a9EQW8Ppil5V/L6wJc8A6m?=
 =?us-ascii?Q?JlJ1oCqGphUTMYrAF2eqH6VvTTetvRbJ6+jHYFfX4V+2U879HAnqFWVIYe9I?=
 =?us-ascii?Q?kMp+Mc8RHI4o6EBU22dhTnxQfqbYSaapVp6LBx8QmRdMo45jbZM4YIXCbRA0?=
 =?us-ascii?Q?QbnEHZ3ffnMLrQzj3A0QLsaVhS5H+jk3sBu4kCaOJB6AYKbbOB/Gk44fbkG9?=
 =?us-ascii?Q?0/2eaY7YvcXvURLIl61+HzuXYH22WeGuW2l8872x8VZSqc9+UX9dqcuW/PDb?=
 =?us-ascii?Q?K5bYCYAkwlsAZsgpamTxmjOODW+r+qxDdJnKne9+8/SOjsc1W2R0V+Cc/WVm?=
 =?us-ascii?Q?BIfoyT0Gx+gkM9c1JV/qBn70qvC3L/jTUBz+OV26rEN8y2vxahauFXbBsOoW?=
 =?us-ascii?Q?SCghK+KLJEHVz2MtdlBJrsAwax4oOwKk7wUTQ9jKUNLfR2k3Uy2G9ckJapEe?=
 =?us-ascii?Q?9ItzbrlrK4L/C1Z9eqwy3kZvy6f1gMmgOyvSBifn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c394fe41-6138-4053-4aba-08ddbcb145cc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2025 17:19:32.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REdVe4iEvEx7gi0gheh0wD2KqCwnnuS7AAQgYlOjZmQvtbh83opEBhEA0KHBudVNBF5+N8/+MMwWatzSjubUAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251

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
2.43.0


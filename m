Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C753FEF;
	Sun,  4 Jan 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767559018; cv=fail; b=O+O0U+hs375ffUTpmut74LUeuYZHDUL+gKnWMJ6O5x31kt9sROxsa1erNO8obyQqfulKOnMBwhqyrKopqbIZMBzjaWtEuc62vwgdjaEtBU+eqAbBPOt6MIHB5EmgZvSN3VrXU1+fSvjK7Z1QbQxFVANxeshtdxsZHLMXn5dgg30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767559018; c=relaxed/simple;
	bh=CMPdC6ynNMiNRQErlHJ2yZJzLh5+HD90tnYgSnqydkU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mx7QhBDUtNSRg7Q2PrkZCMweKhqVnc05UtGStw4w9+Fcv1O2RPnXC7ttHE4yII04kcan/dSjd+XmQG1QjvFSkiQS8xHLMwGOuaSngqVZx04Ebh2GAtiZJZR2qN0RS6Ayq07ZdhRQpfVw2Il+UPE+ApL4idMF4nIKnt3WUwfJA3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K7ccYVB1; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K7ccYVB1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZtcu4EW4NTKVsQYlljlijsZTq9b2UFq6WMNbWFYYYD2UzZm2iO00lRNokLrRtReASAKYbY8nT2yrlskD2mlOm6G4a5hRR5a8mKtkSIBHSGatljgEMjoZA41B1lOYj6lZ3m4HhacbIyU6QYMb4y/lHB6rMeTaxHxFXSnbCvn4Tu+yAUcRzaKTrKOjki2SyxJ/qBI/YGGQAy47qClYd16uYxWnybumVxZ4Tto4Wy4+Y6287gZShi/3iIrWdn8oDIjy8K+TVJCZvOJ6YRe44Ursotb2HbANHvPUoZoYqcILER+4hl4pQXwsv2exacvFerqw1vP0azShb8rY3yCTevAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcFROl94Mo6HFvz5fg3tIM3hpbQ+daK93kDASbs7MfY=;
 b=LLqbbwGYHoF+ZKSjBXb71O3e6pD7PeHS/YC2QhfzFRdfEC7vHJqzELGIv3JT+3cIVedBs7nlI6P+oeE1D3zUwYVYOd0nvBewCTtyJTredxMUayv9Z/phxmO2vd4xRwxEmFfOoWh2VUFhOpJnYlYbE5+Uq12RvgM4hppaBzxmsTUGJUSk68mCpIismCPwRH5h/AWpuMD4Y/HbvrCt0H+nFAH6Zd4bdcIk1Pw8fssJKQLKP/pnSbTG1lbTIBhCBQQKWv41qw4dxFe+NULhr5G+x+1Zk9bzC4CKWqxhC5zvF8GL/IC2E3TH7035zBf1ERYzHgnU5hK/+O4lkftZEkiXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcFROl94Mo6HFvz5fg3tIM3hpbQ+daK93kDASbs7MfY=;
 b=K7ccYVB1qZUwETKcmgGkK01oio63DfktcRbGijxLg5wplLvkiQJE/AWYcXsG+ME1wAJ/xD2tnKs7zXv3UxUmdwlUh0L/Lj5kmLTPcOQPmZffHnlYVxwNt44QCMeGPE4r0y12ngWk//PkC5S/GJuIV4u8HEnSSQcaPpzoaSD6Ltdk+VrvsVjW+8oQUfrg0hYX2vPbK0itqaPSU5E0IrBpvTzZx9Z7TD3c87wBJkHYBKpLAEzJriUOGKbq3pTqCPy69lMaCJv8QiwALoyeN8Qy34R87R3xP3uOo1bZ6/FotQ+S+jh9BirUqRa11c+A2j81CgHqaglV9lbCiDBCRO+/9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 20:36:47 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 20:36:47 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: rcu@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	linux-kernel@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] rcu: Reset stall detection after ftrace dump
Date: Sun,  4 Jan 2026 15:36:42 -0500
Message-Id: <20260104203642.3171854-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:208:178::39) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a998da6-305e-46c8-35bc-08de4bd0fb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PVnNJN84zlFAkF5GagY+mb/lmrf9xKUsMzYpMpsZwN1v2xsh9XhbZnkfcR+k?=
 =?us-ascii?Q?wfXExjr89spA2zTafKlU9c/uLWRRrhh6BkH20lN0m04UoMS9iaVPXCfLCorN?=
 =?us-ascii?Q?WFAb55N0kEXv3ovmb4p6MEsBsWyRiz0Bmx/exiMLR5IV4USDIYU1H02SlyoO?=
 =?us-ascii?Q?QE8FIXGweOYLGrRRMqygeg03BgYU1Qm+rvmN6/OKNeVFvslQb4AQ8OJrMfUT?=
 =?us-ascii?Q?52SkbAJaA/RF9W6ejkG9ab1rZrO1x4PrU1DQZ9ktT49a9Q/DIQUOeV63rTjG?=
 =?us-ascii?Q?9BbKvCh/kfAZcntqGYRi4NTjfppaWxtGR86mUco+OD/u65WE6enTHGKBg2Kv?=
 =?us-ascii?Q?0sux8NGZ4dQGHID8BYFp1tkWcWxPmQdbgQW5zsix4DcsVnNMl2v385qGhc/T?=
 =?us-ascii?Q?kS1wFlf4eg0R8zGcVlj5WTVn6HRVVlfOi6Z9lG9T0C4OpNpNm9fZtu7RDR+w?=
 =?us-ascii?Q?dzZkgii+YWTkDFRrexrAAJy6D8kMHv1sgKd255pcl7+gkbxGNknk6i7Euwz8?=
 =?us-ascii?Q?4WP+ekpLEiCJPCtrkub5suaJRvznhLwVb6XXLxXXn5mp8MastPFnIely70o1?=
 =?us-ascii?Q?qI52wgEasp+oyNHCgWLOLTQkCL1IyNgzlyVJaWYwGNj1M/sOacAARQx76zE5?=
 =?us-ascii?Q?LXAs2Llrr4jf3f2cnK8yRpoZp9QDwFQThapB5BxQNfgrNEmTNFLoRGi7ecj/?=
 =?us-ascii?Q?xwkEtijbPeWpJOVq2vsfB4baz/O2BP6OmKZ5H4CA7PZ9p2KKaoqEp9TE8xTN?=
 =?us-ascii?Q?jqfYd6JeKNUX5pUbWrfvWuAVbHMYynnBVCyEpDwGcKFIz8/wY5GjP2LMqv/c?=
 =?us-ascii?Q?RKkeZ11DFI4xrwKDQE71Ue+yTnqVHigBB9TtYNDOW1rELphQeLB3IFR4X1qM?=
 =?us-ascii?Q?EFzfpO2veydFjxRGvdR8t3b15vbeK7qYkP5/796v/bYtwZsoEnc3oqi9anSa?=
 =?us-ascii?Q?qHGVz3hq+sZrblFbhpeNLXtgfcNBym5iAo41fEHx8ExnpleOzZ0xqhTGilkL?=
 =?us-ascii?Q?IWUOOZ6MftswmYdLvO6og2EXbhKkl+6zbxjGwAZhby3fRWnt62/6c9UZVV4n?=
 =?us-ascii?Q?vMW7iZ6rgJYHYfY7z/TZLm1BTfbSjYOQl4AqoZMo0d2ErVR8OQqefOmoYXLo?=
 =?us-ascii?Q?nWHNgCsZyI90wmvCTB/tF5qa8srlUPoi4CWYH+LBD9k8Kjn99nRaXoKwsbqa?=
 =?us-ascii?Q?sEw4ZvycnGbNit3ipNqLChrt6wwycHW3dg3DFR9J9SE7Xg8/PmX6umqnnRTz?=
 =?us-ascii?Q?IaE6wJnROV5furaD6TSYEoM21HWmlqAJUz5p9/gQrK+XyvI+bj2s2x54q8qc?=
 =?us-ascii?Q?Gs1frWaRfCqVi8cZd8oDlPacG/DgbQFRdGuJMSAD5SQcWGheTR4r9lqeB1lF?=
 =?us-ascii?Q?gyatDXl7XWd8InhPDtplNBVjetbSHBJDmKoCjr5FHhr4KysCUPo8FuAd3v/u?=
 =?us-ascii?Q?slGQPC55jaRAis5QyL91UVcFcUZpCgIU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u4vjChP/cahnYCdZDoHm/7xifO0rPq+Q4rgQe63ae3/1hbczHDJ8jerylVNR?=
 =?us-ascii?Q?Z3OWD7XCOLX15MNJ+Z2xeLXcpRbbujp1JHErRFs03mBoW7upEKJqhoCb2VRN?=
 =?us-ascii?Q?QeR0ZQEHelgvu70mFplDjULn4d2Dc8zsfJxxRcNDdr6QxQdBIWrpYwo8r+h9?=
 =?us-ascii?Q?isTpinKe0C4ZxOIQpdczPbqpw+MsiKaa3yNvGAmTFtvNvqDXBjs32XGqpRRW?=
 =?us-ascii?Q?TRiSCRrimJ/pqmK6WJC81eJjdaIWVp+FZocyU7G8VoiwR0LW1apDHIs7O2W9?=
 =?us-ascii?Q?K1GnQXYcjqUIc2f0uGlxqXenMPOZJ6dZdxYEs2T3MC3ZEgYFeHpRas/LHwvE?=
 =?us-ascii?Q?hqspSdqiG5Mh7WvE6+3j97aYBVSYZMZLjj62KMEjEsW1niyRbiAMJFfW8NE7?=
 =?us-ascii?Q?/gqccx/nxj+jhHIMHM37l2LI4uqd5UoFweHxe5pmXM1mqkJaWVpBvkIKKvvS?=
 =?us-ascii?Q?1vXJgfYVp6oHhpzRQpwk3vy7lXBBum2AbkJmFi0Z5jG3UC/u+9nwIFVMa6kQ?=
 =?us-ascii?Q?GTicwrl+wGkPUJ8Tr0XJIDKSqgCYI9RDc48adGrs77118tP4vFcKhLIvUXlZ?=
 =?us-ascii?Q?DUF3LVeQEOesJogKseaiPqf7c00fo1Ta54oewZT6n6iu8KqqexNkbnDw8N2D?=
 =?us-ascii?Q?HdTjUTo6ucqklkctsrqy76PrBfK7SCx6rGe6hXdJaL4dWwJ0yV4uak12fHU2?=
 =?us-ascii?Q?XX5xU9ZEhtmUkbV5xG+qIP2VMdeJLTn4coag+HPKI0/1ieixhLP0GnHNgHgL?=
 =?us-ascii?Q?E/LlDSqRUywJTqN/ha4Se9VmdYJxC0vs1G37WWqv8iXo2vwEe/AFXTuogVLL?=
 =?us-ascii?Q?ZG0IHRm2AH9eMMuBrJXU2XgHDbaZ9VURRSjmlNPJnFtQGb5jgn6Mc1X3pRgx?=
 =?us-ascii?Q?BLpXUlPowP9jrCaOhzb984Vgi0s59Cuh0u1PX2EUPs/6FOkniAvGFqkfPker?=
 =?us-ascii?Q?BKlEZNdSuR/qJdyyaV6beb9nyLEU4FFpPexKh8qh50dHUREmwpOBUfnxNWGK?=
 =?us-ascii?Q?E+LXrukTWDnrgEfg5K+dUhyQV9mM8WW0aL0dR39Jefo6FG7N/0gEuFI6kTkn?=
 =?us-ascii?Q?kScBCd2I4S+D7ZB+kqr9oL3vpRtJ57/nJCRmadjx1FInsFmHkq8m03uWwAVr?=
 =?us-ascii?Q?JI1ht6zEkVkzyuk1XIaCqBpnwW9sQx+9VKwET/Simp5YBza8UyhUA79kBLC7?=
 =?us-ascii?Q?KrgUBfmiu8/MGOqLFGjRQXJJoIwz+xORKbTEht7zkP+FTTvkz3AmSy8hpN/r?=
 =?us-ascii?Q?rGvPV+rVN5Uvty1sFTIvJJVMjbgVqiEiWy2RwvCBfA5XJ8BAKXpqM27hdohk?=
 =?us-ascii?Q?zYtxu5rnX4qWLyCzKKWD3rTgZSWvnrwP3KzjLriU8HvvrBV8QHM8Wh6FtJkc?=
 =?us-ascii?Q?h0KweVLaiRzAnURIurm4PJimib4pKURJd2mRU98vCmViafBZb7B6eueXas9S?=
 =?us-ascii?Q?nDzcnxEeyccJUBC9qTeGBr2hj4JmbkBgjuwW6c9K7XbfvmUaCfDXwXArrujF?=
 =?us-ascii?Q?c0muHSbOVSMZ8u0sXlEouF5XpIXht0Cs6o8AvZLv6+2PutciA1y9MvhoCzyF?=
 =?us-ascii?Q?WxLiu6haYeOWWkfZgcj4Jtf4OeutIOUTFE+x5AVkqoCKTK4jhaMFPIiXqVKh?=
 =?us-ascii?Q?3irybwQJoYrqH+CzQs7u2cHr9WYj8nlT6iMf5hQ53aSAdZMKye6J4x4T5jzI?=
 =?us-ascii?Q?0d+KHHBBiSRjW93zPjO/IAJpGBMhObPICBgVzO12UPpfSadjmRfaztrVY5Ov?=
 =?us-ascii?Q?+3gK3tAEBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a998da6-305e-46c8-35bc-08de4bd0fb41
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 20:36:47.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxEl5r3DnTjyafAfQs6XSFecaA+Jw1H1lOSJn2k7AXnhEta9ahoXhG3QM9CZbZytw5sROuXXSoN83YuPRcGTww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839

During some recent expedited RCU testing with rcutorture, I noticed RCU
stalls when using ftrace_dump() to analyze traces. The issue that since
ftrace_dump() can take a long time, any accumulated issue can show up
just after the stall is unsupressed.  Due to this a stall can be
detected and reported.

The problem is something like this:

  1. rcu_ftrace_dump_stall_suppress() sets suppression value.

  2. ftrace_dump() runs for a long time.

  3. rcu_ftrace_dump_stall_unsuppress() clears suppression.

  4. Immediately later, stall is detected.

Fix this by calling rcu_cpu_stall_reset() when clearing suppression.
This resets jiffies_stall to ULONG_MAX, preventing the issue.

Tested with gp_exp=true enabled with rcutorture and ftrace_dump() and no
stall is reported, with only clean traces in the output.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
This is a non-urgent fix and could go in either this or the next merge
window (Boqun's call).

 kernel/rcu/rcu.h        | 5 ++++-
 kernel/rcu/tree_stall.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9cf01832a6c3..87fcf528b9ac 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -288,6 +288,7 @@ extern int rcu_cpu_stall_cputime;
 extern bool rcu_exp_stall_task_details __read_mostly;
 int rcu_jiffies_till_stall_check(void);
 int rcu_exp_jiffies_till_stall_check(void);
+void rcu_cpu_stall_reset(void);
 
 static inline bool rcu_stall_is_suppressed(void)
 {
@@ -302,8 +303,10 @@ do { \
 
 #define rcu_ftrace_dump_stall_unsuppress() \
 do { \
-	if (rcu_cpu_stall_suppress == 3) \
+	if (rcu_cpu_stall_suppress == 3) { \
 		rcu_cpu_stall_suppress = 0; \
+		rcu_cpu_stall_reset(); \
+	} \
 } while (0)
 
 #else /* #endif #ifdef CONFIG_RCU_STALL_COMMON */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..9a036fc27fed 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -192,6 +192,7 @@ void rcu_cpu_stall_reset(void)
 	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 3);
 	WRITE_ONCE(rcu_state.jiffies_stall, ULONG_MAX);
 }
+EXPORT_SYMBOL_GPL(rcu_cpu_stall_reset);
 
 //////////////////////////////////////////////////////////////////////////////
 //
-- 
2.34.1


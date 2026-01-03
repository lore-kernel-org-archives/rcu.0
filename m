Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF1229B36;
	Sat,  3 Jan 2026 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399868; cv=fail; b=QwdcH6v413UcmpRLKTck+MBdlvqIX4+ZowUmjHWcgvBVI7nlADffZudFqvov/VyQ4b649dio1jNH+s6aZHv2Mcm8g7qkk7HiP1nC0GxOyU/ebLmtqS6du0UAmWHFxcf1G6L0kUgU9Rk3sOXLQKDt9UWYtAFZTefb6TMa4MnKp/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399868; c=relaxed/simple;
	bh=auXS3nBE1ms1lXRA/1dM7+gfICzNyXbR7cGGll9tBGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMuiQ47YdxwwkZfHbsKUdtQ5OnNxDKm0ZHOTLvf1nYLpH5gaXMAZj+JEDFWDvTCfi+B67gSgSyj+hFheJRmuIfkcM1BXowlfiCeQcxXyF7ytIKUfr1TlgyVp+yJIIMwkGHwkT7x/Y2Qu/Rs/yL6ljEnKnnxkw8Lu6XxrYZadSFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nqd8yuBE; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nqd8yuBE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGCJkxiLzgtyrfZxVs92I5QZm0dYNb/hQiAMxmEKkf2OEu1/uw4fc2+oTjqdeZe/wstfSqP7n04l22uLkcqvNPpVJQ2csiee2zH7jZeb5rJsQ+M839lOqmJFbn7EpPkHI+jK6WVaVXXRGvNxMB4zedoaZ+X0cApVu0Qiz+kd/o7fm3B4zcrBcC7+8mfrOmIcLh0TLRdB7QjrJ2l1EBkjif36nl2q2V+exN5fXqnsQDQa4QoebmjxJReyZvLL+OjzmIMm4DI1O3nZMd0o4iEBfMoh4/Rdxkp7UVdngfyu4z7zyC/6GEeJRg+OJeKKSIdMn+6kqwlpL7GLp+XZTRQDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLXFvBuacqAvwTlEjmNruDXadCCLcHE8n7LXChvo1zU=;
 b=ruUnbI/u1/UxzeYpUTzWBlspKDX6Deqe/iDAVeY3bmtNsU2XJTufEdrLlS3TLkr87zg81FvCajpMZ9pzepPWCbvSkPxCl4CLcWpPx3BoU/O0hX96NAGPiOvW+7AnGeYsopNXPQMT2KVGiMPXdt5iJWycUIfGtxAMzJ8PLY6pyxU2HBVq92Bt1pJfCBESThShZO958y8qRiXVOBomU9beDX0bCB5qcj+bZyGVHN8324nVwNCLunDFkEtGyCb9RzdrVt6n2j81rYxuCzbhOzWi2x3ztRLf8KuBQfBuxr3Qqj6V7bYICYsCYMPFHPw0kSRMx6UKkrvK6ls7DlFu8XNgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLXFvBuacqAvwTlEjmNruDXadCCLcHE8n7LXChvo1zU=;
 b=Nqd8yuBEFICGe+rg87x6tooxP0wyJYOnn9yv5kurmrSCB26alCGHZnZMpxoiJo+jQWwWkkU1XuiCc4+S7cztpeXE5NJ3e+AosGNQuyeF23TUyxdWyA+eGiEBdzDw721w9B24NuUoqOflUZVwh3gM5oYxpJ852FXkXEjJSP2FX9rR5vUJCBCtj36s6kV96sYkqHLuBFxo1JM9DfkHg3UVrtzwI1M4PprbLi1sJQn8yWd6V8ddUbDwrYErGqZ4m3Xn20O/nS7XQkecOnyHsm6jN3PcICT3hC3mN6dASQn2ON1IOjcCLFQfO02H5zW/gEVwwqI6xMh8OX0ovdNbgsgJ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:24:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:24:18 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Uladzislau Rezki <urezki@gmail.com>,
	joel@joelfernandes.org,
	rcu@vger.kernel.org
Subject: [PATCH RFC 14/14] rcu: Remove checking of per-cpu blocked list against the node list
Date: Fri,  2 Jan 2026 19:23:43 -0500
Message-Id: <20260103002343.6599-15-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:208:52d::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 543ff174-a8c6-48c0-6262-08de4a5e6ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z8xAkYOK77nRaJARbEqbDKH2OehNkM3ZGpQLRaZ/W1HtqnKYP0y9w+NOVmTk?=
 =?us-ascii?Q?IuOBoEY0ruNk2gz6rRHwUvj1tnsslFN4fz8H04YG4VKyhUbG7vrtacc5Qn5p?=
 =?us-ascii?Q?blozonGdfPUaWrKBYVl448d4w4uhnw00Brlyuqmt02uI65iONMCGpo+EL7Xh?=
 =?us-ascii?Q?wT+UllTzF7IyhNmWG/EiBGC3EJqPGPkfgOn0PVjtSnb1lspdBjhnZlD6yHbi?=
 =?us-ascii?Q?wOU61Osz/JFJb6jz+59MBOkdlR+6o3MzhGEkNuvbyNV/VGKqwM1WAZQaoV2q?=
 =?us-ascii?Q?JEl00PIKkzpvwbxTbMJLHji0oFvKNpx3brFxPpLp7tokvzZTbh3tz0OjalYf?=
 =?us-ascii?Q?2RW1Jr4IeJVCjlaOxFD0KyL/9gEnQunMUF4bGwcpA9n2ilKm3SWTDfIjO6RU?=
 =?us-ascii?Q?KgorTt7yjOBcpV34RdwWCRb91ZNs8C4/XCgOFYBsL7YaZvoETUjuduaEeT9Z?=
 =?us-ascii?Q?5khul8iWa1i6JfmrViyIaCqgW7hI1HxV77hOfllnYmkS1UJQ1CTTtSePOhU9?=
 =?us-ascii?Q?ceaPzp9r++++Caf5YzDaCWL4KEouVIjQyvMT13XICKKLzReK6n+NZggm8Jcm?=
 =?us-ascii?Q?jjxknHbtFLEjM/FYEa+YUL8wo35cLF7afbRlC7qhSrntJzDuWrI4G9G87XyN?=
 =?us-ascii?Q?rid241k+paC6nNqwu+ThAFG/RqPCeRCh/6Y+WuVew13mubNzMfDVKkLE+NhO?=
 =?us-ascii?Q?9MS7TCC1jgvLwlr5C8Ej23kPSwxPIRLSg6crmcvGTo7+MqPTB9MMiI0qf5l9?=
 =?us-ascii?Q?jESRCHGVJmp6lrn79EXAHgyPqQSQgQD1e3wdlg5uhjrAD9vRXWIEh6NSRlkU?=
 =?us-ascii?Q?2IHS5byOOXLugy+GI1Kgemni7eIPv+6ZEJjAESDTjM8gb+SPYgswq2YHPJZZ?=
 =?us-ascii?Q?16xEQlB9uSPovPfBCzuJljXKPqGU9gdLyQThJWFeuLS9God7Wi5QD0535jX8?=
 =?us-ascii?Q?smqY55gPVQEBzDSvREDMod4Scwrp4L1BI33H0jPjyNQwcAEA/stcz9Te5iKn?=
 =?us-ascii?Q?HVDVYmbd6ZYfbZVswhiUZRGkTYwy8EFyuK+P/lAzooQPcHHlneEqCtoZnrXf?=
 =?us-ascii?Q?/ac3r0NdFSZKqLfLKvlkT3Kos9xAzd4jc5zUI7/aSV6BfqvErSGzzF9jrZUa?=
 =?us-ascii?Q?sBBhEhazSea2vNdUtkG3nMeKWl8qMfsnjH9dCODzKg0yAE6YdqJjFNZhPAUm?=
 =?us-ascii?Q?K5byCbJMBGf+kFNgLntTHJqlBp0Dif/mmUSO+HiWtRGqzHELfQNVF5EEudew?=
 =?us-ascii?Q?uMW+B2t+n6ZP4zZUgpQbpsCPoQHD9y95g03Gq7THCzU60Yu20YVWDEsBEENe?=
 =?us-ascii?Q?f67QcnfFIxNuFSF+WBmR3HWcOckHOUImbbPzZsnm8Qf0aFncNZz45yI5AElp?=
 =?us-ascii?Q?lvavIZYTYXbcjKZEpJ+ebxb89u7TJlx5MugLV9ojbzL3NaZYCCjQ+qNWuAiZ?=
 =?us-ascii?Q?J0hena3qju0iVUMdIe/HtA+u3bVR/tKn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S81S0XnCpFtq4qJXk2N4mhR2XbYkCsxnVaR41uZNp2IfWNlhdCxHSTnL9A3z?=
 =?us-ascii?Q?8WHSyM9eUa/GrTjhTt6rF3ErYeJxy9i0ZWq/G54qEdwrmrWdZvv64KuRX19A?=
 =?us-ascii?Q?RUO+mXm1d1Ow30IQyfPXVbzjktx7sLSyaOGSWdeSwYAbVJmWml55wzkp2m9N?=
 =?us-ascii?Q?oxpNNdkleT5oPprgtYkuIa8aENHN4xBGOr9dFDYeYTaNJcxoaF8UIau9Xn8x?=
 =?us-ascii?Q?kLAcxFxI31xPbnB68Hj8dnZVeB1lC/mhnu2uat8JDVGZILXqsMzsMmRTJlHn?=
 =?us-ascii?Q?hkJ2g7kFWxbA8SKv4yHZABlQ+AG8hKwb0mFJxaAYoNDi1AMXysBdubddG/uY?=
 =?us-ascii?Q?t2Tj2YdEFfaCx3WrLDz/K2CI4pYo4KAPXxkxNf52Z9VkS/Da0jUpTmerZ4yu?=
 =?us-ascii?Q?MjgmtaXshu2hXqaHbXYu+Nd48i0J9ydS/7ii3vVeAqbpsuylfMu2Na563idc?=
 =?us-ascii?Q?JnTox0RW0dvOPjCdxF6194e3X90kUvaR6ondgh+rKPIkH/VWk6KI4fGbR4J8?=
 =?us-ascii?Q?7nD8JvBMoW9TODTs3DHiQIEHBxyGiO2HUeb8B5026bZxwwGjn9FVbpbeJud+?=
 =?us-ascii?Q?vSrlY9/yPvkw2g6YCx1uhX1URVXiOtgtvQKVuUXxRNiPSR5+Eb/fjkxzdBdI?=
 =?us-ascii?Q?ofxlANRJF157tiXmrBlc0TqFIm2Dv7Sga+TsnyZ/9Rvri+t9gMk5OoMG2M+J?=
 =?us-ascii?Q?Vc6EmYu8X0BpBw+bdF9hBzJM1VVOKhCYmJD1xtn2mInsMthpT0Cj3yHYFs0W?=
 =?us-ascii?Q?Ogbx1+GSS8PCbac5FxkSVXEaRHmqbu6C3LOX2pBcEdMunKwCmy+f0VukKuMe?=
 =?us-ascii?Q?e1qdsXUbKZovXgjIwBrRhVHdPJ2n+U6fPJU1Lq/dlJhpQYxpnlWklFPfI+BF?=
 =?us-ascii?Q?E/zHQO7O+R5TTV1tNEQDyXY7akg8AzlwoBUOVthYKn5sBmx3reenaL7wkafa?=
 =?us-ascii?Q?7QFyua/VYVBhXUZq3jNv+sPi6Ah+FIrae3pbPk6orxm4YPxJ2NJYIOqxUNEx?=
 =?us-ascii?Q?lg8c64XFGb1RjUy1xA3mFpF63j+kX3BvVZFIEoMyTdmb19fw/rMPBi38klId?=
 =?us-ascii?Q?eZunweSLkYx1exO4Q4M+sZff0Ir4cE4mQLu0pxpOgOzIxHlebOp9LjNB0Hoi?=
 =?us-ascii?Q?cE+lF7REgJtT3fUYrpf7GqnNEHl0RN0CU5I5SMqc1NtIEjFNKV4I7sZnQJrT?=
 =?us-ascii?Q?kxas0BPBnhPH9lzfWHkD5JBBQywniZxF0JfElUPXdmPVg6qrUfHsLVacCL+/?=
 =?us-ascii?Q?2vMJmd719gFXmNxWW6C6Xul/dbM1KutIpc3QjmzOCfITE0tw+NxXwiCZGeU4?=
 =?us-ascii?Q?pvJcPO8BsZXOK+eX3mhj78Qib8GJPG7/2RIWM0boXfcXT6ZjAtxp4Y5QvtZB?=
 =?us-ascii?Q?5hK3VSqURMZclERDTKijWoJqJQMK53z9VY1vqXRK/0mexBqBR4C3AKbP5FIh?=
 =?us-ascii?Q?SfCG3E6XEcbBzyLncbHOhkWVvFnRj3FZPVacbMUoK+w5EhABL/KDkXAMwtTy?=
 =?us-ascii?Q?STLMMXRC7HFL5MVSKJAUIREQpMxuRwpaj0HiegIzB7HgPEZwYWBw6YpWWRQf?=
 =?us-ascii?Q?OFtLlO+aQpb7u/7Hkp6umCw9y8bU7ROJVxOy7fWMm8itVm+7RqjlPqtPYwWv?=
 =?us-ascii?Q?kwpzEZtt2OP/5D4c+1nA/XMH/K3H2yQNuidKh5V+aqdHehKVvP6FkGPrgPqu?=
 =?us-ascii?Q?rwiw1LU86wmNfAUWMvu3v13e0degCSN9yKvia/5td54sO85OeK4VTvhIGHMS?=
 =?us-ascii?Q?rzkMhE1jZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543ff174-a8c6-48c0-6262-08de4a5e6ee3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:24:18.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S++CW4ysbRllb9RbKiUZ69a5c8zvpcTr/xC1g6tHx8WyzEbeFuHtd69k0+wpaJM++IKd81GSThfqWm7H4PnpSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

Now that the verification check consistently is verified, remove it. It
is still kept in the patch series for illustration/testing purposes.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 468388970c98..9d9d7c5ff3fc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1900,26 +1900,6 @@ static noinline_for_stack bool rcu_gp_init(void)
 		arch_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_rcu_node(rnp);
 		rcu_promote_blocked_tasks(rnp);
-#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
-		/*
-		 * Verify rdp lists consistent with rnp list. Since the unlock
-		 * path removes from rdp before rnp, we can have tasks that are
-		 * on rnp but not on rdp (in the middle of being removed).
-		 * Therefore rnp_count >= rdp_total is the expected invariant.
-		 */
-		rnp_count = 0;
-		rdp_total = 0;
-		list_for_each_entry(t_verify, &rnp->blkd_tasks, rcu_node_entry)
-			rnp_count++;
-		for (cpu_verify = rnp->grplo; cpu_verify <= rnp->grphi; cpu_verify++) {
-			rdp_cpu = per_cpu_ptr(&rcu_data, cpu_verify);
-			raw_spin_lock(&rdp_cpu->blkd_lock);
-			list_for_each_entry(t_rdp, &rdp_cpu->blkd_list, rcu_rdp_entry)
-				rdp_total++;
-			raw_spin_unlock(&rdp_cpu->blkd_lock);
-		}
-		WARN_ON_ONCE(rnp_count < rdp_total);
-#endif
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
 		    !rnp->wait_blkd_tasks) {
 			/* Nothing to do on this leaf rcu_node structure. */
-- 
2.34.1


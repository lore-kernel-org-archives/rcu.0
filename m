Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78125A320;
	Mon,  7 Jul 2025 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751859145; cv=fail; b=mhSCGmRlYam70p9zMTDTle2BRdsWv0XF3+sP2ufUPKjBkZVpCMapqzCEbtxxmmLdFlzSDi62UC9x61LBlYMhARLsV/r6HQLwdxK443xziKdzpjSFqp7isyQo8x+sZIGsyEvV6W71v5F2xpRUI4++jWP9vs6M13ruTxA64Wzkjho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751859145; c=relaxed/simple;
	bh=wFA+XOHhgtzakfEEKl4JHqEeggj4SHLmk15vczvT8bI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SMfQzqYC6fX99rfT88g+C9kwd7XIUCuhcKvrO+SXHtdvDKqtNt9/tbonGsj99W4+sT+hzmjwVo5VdwIyoW0y6bwsPLrMQ0RRjxoZZR6PcbI4UzdT0wXcCL+Qx/l5GIZc434C48RFrZ4Y1GOuQVhqkmnnhfKZ/weDopuX6g+YD9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tH1g2WQF; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tH1g2WQF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bznK9T0ZytO7qGkMfq3iE9vOdn1Df8D66qRCyGHkWf1tkr4KIrGaq6yJkevv/ek7jL1KW3emRJxRUR3mcDIT0DRsdnkpoMahZ28/4cTjGGgUCWswPVWIsoJ4IR/3IKvOhxFIr2WVbxgjGApboJJgrzNcD9/xzPIfZNvm9u1uFJd+8+lld5hrqrJdh0NUyQg2JdWUBkblRDzsXZiOG/w6l6VJ/ge0HV9OuQNHeSfT1ZrpFbNwW6hl0qpLepNGAGiQlTEwGEuGAYVmfedtvYRG8JjyWpKMlGgCtZDJK8zaEDHrxscjDdkPxEvXV6mzp1hhcekOs2YjPYOWv3b2iTBsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oyg8jT2P/NtwHIzfsrE6WxHXdaD5fpWLttuKG9M2tuQ=;
 b=exAvWNVYQnZTBqrobWsuPJMnsj90xdOnyzzSZbrlWBs9yDVOX0SQzaVtJO594kmNE/wnad0Z4EXI8OYADlRK1AxASmrF/+augA+ZJcZcy+FRt92abJqY9YU3jhNcQzeHI07XhSW9vKSCDgd2cUtWaVRS0xAvRVLmkEhiofhXF4IjtuyR3WD7jvg9aguOJoQ3mUKg6ndrcM8lXOogZ+NlI8SAi+6SZMh3yBUYY6In8OG9CuPUIl5R1lOH1w3GEle/tv+Hk7IkpqaWFeKHjhtpJKDXEbyoT3kZdHUE93ZMsKTIlNu0AvEjq5hV8SDK8/ytartRoGXp/P4rrM6JSHSKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oyg8jT2P/NtwHIzfsrE6WxHXdaD5fpWLttuKG9M2tuQ=;
 b=tH1g2WQFgybWPrpegsuNDEJKjd9kSWiNKyWZpaOYStkHtjCqxKgPsKfqjVkPTahhbyRbfehDIzoE1dCSKUeuUgLyiByUaqfmK/RteMxfVBoL9ZWDAyESi7039BNJf0G7jAPpa7kcebbxlLpYfpI1GcydJAY4Ez87TnUKsHjVN8Yv1CmHPbYea7aD1N1KSWH+08LPM+XIXN9ZdRhFyrtru8VRuUATq9FgBdWW/FwD90g3bofrwlV7fGmZEvSB3D0erwpCKYC4l361wrzyyEUTDbfaxjqDRvgap2FvKUCzNTtD3CRRpTO9VJMCHMRafog/E3WP/C/YEkEQkP2GCrrn0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 7 Jul
 2025 03:32:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 03:32:20 +0000
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
Subject: [PATCH] rcu: Document concurrent quiescent state reporting for offline CPUs
Date: Sun,  6 Jul 2025 23:32:08 -0400
Message-ID: <20250707033208.361677-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DFA.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:d) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: d506775c-fd12-4c68-2030-08ddbd06e155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Txhay95Seqi/uD6kwzd6l4jxSDIie9NwCFX6cY2G4kZnjFA0ZMeaDbCIsIHh?=
 =?us-ascii?Q?GRHWSApDn69EjJ46/txnauvx2bYwDX6jynD9mcT2JxoToraQ7y4KVSZKjNkg?=
 =?us-ascii?Q?Z82M+5laG8zLJF544VkyWx4cU32b92jk9rKl11iCi5tT8uTFG022XNYIjdvd?=
 =?us-ascii?Q?ubKX8vF+RFN4EvTMkMr7fxI0/6V8pUu/Xh8ThGVFKvOjmGE58MyrtorPTHil?=
 =?us-ascii?Q?XvLHiN5xSFiIVkfDpHfBPS+8N1vgXZm8uhDvLCnYMbQH/88GHYmpIIQU1CkI?=
 =?us-ascii?Q?Cf+ebruFp3jB1dlG7STPXuAYUPD7wvEuTi9IzQRJw9igJSORMBYJu9XoGOlh?=
 =?us-ascii?Q?zC3+85FFdOZ52I+ZELf03p75vUyGdqqtoKtCGSWS7OKbZmyH4q2RO28cicO1?=
 =?us-ascii?Q?LSiJNJrZu89lZLvpX6V9+a9IcKg68WfQm8aUeAz1Y97dwumGNi4Pd2Nk8LIl?=
 =?us-ascii?Q?9ezgleZJUvXGrJfXzIFg15EcAw6RAhcFA1yPwOElAMQN6kutTHRc0GymE94s?=
 =?us-ascii?Q?ZJCPSGzS7p7cTO/K1CEluYQz0XbqZyCofPFsudKIcBV4kHrnApB7db4PW555?=
 =?us-ascii?Q?azzTJsJGa0a+uShHTEUDFahpEYNblQJQ1oEBDc9WVmm1xHQBWZGCrK/20yGf?=
 =?us-ascii?Q?hFsq/Z937I6Me4PmalzTXB9rf4bch2oRTBzOHe0w8mkYEj9z7fjOFC+qdID/?=
 =?us-ascii?Q?2H0Mzl7mr2n1DnflbrC96C+/XaecHz5SpLWKp3eW8xnboAs+ULSJ8AUXN2lZ?=
 =?us-ascii?Q?2Ky8j3FTmMkOjOew18t7CptCd0zzcQEDtZTT8DRZYLK6b41sYgVMi0nvmGK2?=
 =?us-ascii?Q?vOdJ2x5Xj3uuka4MHsRjwly/w08q8gi7gWQtU5hl/eYWwhfXF/9Tj607Qeyn?=
 =?us-ascii?Q?3mhs/wMLKVFboZHzfOvrl2AhmXCVrnbfBtqPQSpQddzAnZg9X80jtgK0paoX?=
 =?us-ascii?Q?mXelrcBqTNmKBjFRLW0bAJ+E36BgmMuXdQau30AVVXF7p133HXuNy+RX4kjb?=
 =?us-ascii?Q?3tifridhmJkrSHysLWottTikpr4j5g6U/Q9QPefgmgAAddb/Web2eaLVrJ6+?=
 =?us-ascii?Q?JAi19i7X5SkImJ6sP14UijFVJj00eBloR71q/yLBqOrPtqbv2LKuKY21a5hd?=
 =?us-ascii?Q?toV+IDfmwVTzzk7YqjkrRmODrAjVvebRFVqls/3Gl+o9agN+D2CoHmZ8/0Pz?=
 =?us-ascii?Q?K6uwrF7sF2/4Gj4u66PSdXaJotkMDMN8W2HEmWhal1Z0CPpC1GPNmykC5sWl?=
 =?us-ascii?Q?fpfi4UnC4hBQtHxyI4Ys+nVXEhpVGWi1IiuCq0TonpUt9kXWu5/Dce7hq30N?=
 =?us-ascii?Q?xnOadiusF9Sc5hkGJ01P+GR/QmV9cyprNQw0rzsUlQKibna9lWtTlljyAYVR?=
 =?us-ascii?Q?lD7XZIQoDATU/gDEzLy2aYskRa0hHA8zrOoAR52lKAGiak+VerfHKSzL66pF?=
 =?us-ascii?Q?tDH1cvMEJvccqmmz20X6D5J5w1GvBmw44wl7AjmHvAZU+w4rbBNHLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?srB/8lqPLECCk+lGoWh533EvCAlzcbn5J5Ttce6Ded4E4irZ6R10EoKylg3k?=
 =?us-ascii?Q?jwxRKANDtsfDS3f0rrdO0GoG6i2QDn2XA5246P+vn/bFWFy1IaPWnnyGGEM2?=
 =?us-ascii?Q?/XNl5I6O9Yp4iZC6jR8pbDh6Z//a1Nh+7OJuNn12SZWcS85qQ2IIX5VdMGaK?=
 =?us-ascii?Q?+XsyqRXHh1RrrwAJft9G4Qd5LV37/CPEZEU1ueK3RU7VfsXonKIabc2jIuVA?=
 =?us-ascii?Q?Ul4yhXnA1cqt/BYIFsvcAzSUy1Xq3VIhsysaqd1Dd9yeEMx6FqE3cLbCc2BJ?=
 =?us-ascii?Q?Dei5XG7LxT9dj6DGCuSG8Nnu98b9aJJMpPXtcppwtexKr9fY2ElFepBI+IZU?=
 =?us-ascii?Q?O2wEFftiX5vKS44Ft6RpIr2cnO8VhjN+/GMkTHVM22V1SrhbIzS8qoRxbrqO?=
 =?us-ascii?Q?MDORHvOPEVnTV0oKLgFCnG8Mq7YlgljBQs5RWR+dkxzO8lw02h78NXH3pZX5?=
 =?us-ascii?Q?SXOVRs0n3aCqKNCz8g3+v40dqChxpE0cWVn9GtQW5Sdre/JQk1SpxfOZ2vz6?=
 =?us-ascii?Q?TMrbrL5qhi32AbRRq9gFsuQXplcBAYAW/tJZIfRhPAGEY0Gqhkzytnk8V9GI?=
 =?us-ascii?Q?wfgtSMCScAC6nV6cRSFgcIH4Iy0CdUTSoHzM6JYfiRSRcj6yA5hOaPn8hOfs?=
 =?us-ascii?Q?Z3ERuVJLlyjkBDuLwnk429yKJEgCsrxO09nj1HCbZS5NjRd2GW1k4mpsfv2o?=
 =?us-ascii?Q?9jVEJYe4NExFm0MgXrU2SA8Co974vwOrkEcXXPXCVZiDFNKWH3sCx3rEb2AW?=
 =?us-ascii?Q?n2yNp/YrkjImMJoi4PN57oLM3FJeE4CD8JzILH7Nm3xiunp1hI/GRjkwTcWr?=
 =?us-ascii?Q?uPPVfWn5aYh5iH1rhPcMI0YLwM2Jra8ghB9Nk6Z8Hzfpr7nzn/kHzllXGyJu?=
 =?us-ascii?Q?diX73M4QrHGPQVtKC8FzdPuamIOP7a/8riIWqKSpI70IVrca4wfYsjrzG35j?=
 =?us-ascii?Q?XdjWUDavH6yuV2YWK23wRneNf5xaEkm2Vrp9+evXR5zNzTPAkjuK+lW1AUg+?=
 =?us-ascii?Q?RLcE+TetXS/5C4yKlj3HyrL/m0EV114yBDuHPLCXS/sIm2BIk2xlQ8cJXK/7?=
 =?us-ascii?Q?o9jW/QM5I5gyj+Goa0orvyHTgmPWCHb/1c1s3LfeGns7IYK1kEazwafOJJpU?=
 =?us-ascii?Q?bEdfFTSnOwNzua5+VjBae6nx8r9bQUTa+hF8+1ffFLpTkoSIkFY59MNHJ0fR?=
 =?us-ascii?Q?XPIRUMpBvxCMjzytA25PDNc4k4TAX2/5SZmtIXgXNkz+6PXqbs9rxdU7wRYy?=
 =?us-ascii?Q?VQrYUjr/38qxc/WUHOQCjF9JEDD9fm9XkgHbml7imcYYjYeDqSjoblFSlXQG?=
 =?us-ascii?Q?b9WegJwY4DX+HGTIn4KaMvUBRQmQwlOlsg7A4+8+dIe1OTlSfyQHQUfsddFd?=
 =?us-ascii?Q?lKOjvepto8bEQYgu/wp1a1hmw9+P+S858jJv9tigrawakhuEvkVlKpdY3DlK?=
 =?us-ascii?Q?GQtKsU4U1swUiZRmR4/W4ykY9P0uZmLLOc5+pOPE/tcMes6QCCBg1QJIJ/h4?=
 =?us-ascii?Q?UH3RkyCzLuETszlFsdir79kM2oCn4IWWZ0XLT+aHSMLF3Y/LCjaOcfxjUz1w?=
 =?us-ascii?Q?YsQt2G2WFdTFlpax1yeRomKaMoGdDkiJ4N92G2Xc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d506775c-fd12-4c68-2030-08ddbd06e155
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 03:32:20.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRv0r/lShsDu6z+w9OGKWYYt3lXb09u9OTP8o8HC0FK5t8Vx12yuzSMDwPLXJMclc8+Jc7wxCJVN1WWoPGdSxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747

The synchronization of CPU offlining with GP initialization is confusing
to put it mildly (rightfully so as the issue it deals with is complex).
Recent discussions brought up a question -- what prevents the
rcu_implicit_dyntick_qs() from warning about QS reports for offline
CPUs (missing QS reports for offline CPUs causing indefinite hangs).

QS reporting for now-offline CPUs should only happen from:
- gp_init()
- rcutree_cpu_report_dead()

Add some documentation on this and refer to it from comments in the code
explaining how QS reporting is not missed when these functions are
concurrently running.

I referred heavily to this post [1] about the need for the ofl_lock.
[1] https://lore.kernel.org/all/20180924164443.GF4222@linux.ibm.com/

[ Applied paulmck feedback on moving documentation to Requirements.rst ]

Link: https://lore.kernel.org/all/01b4d228-9416-43f8-a62e-124b92e8741a@paulmck-laptop/
Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../RCU/Design/Requirements/Requirements.rst  | 87 +++++++++++++++++++
 kernel/rcu/tree.c                             | 19 +++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 771a1ce4c84d..841326d9358d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2011,6 +2011,93 @@ after the CPU hotplug scanning.
 By incrementing gp_seq first, CPU1's RCU read-side critical section
 is guaranteed to not be missed by CPU2.
 
+**Concurrent Quiescent State Reporting for Offline CPUs**
+
+RCU must ensure that CPUs going offline report quiescent states to avoid
+blocking grace periods. This requires careful synchronization to handle
+race conditions
+
+**Race condition causing Offline CPU to hang GP**
+
+A race between CPU offlining and new GP initialization (gp_init) may occur
+because `rcu_report_qs_rnp()` in `rcutree_report_cpu_dead()` must temporarily
+release the `rcu_node` lock to wake the RCU grace-period kthread:
+
+.. code-block:: none
+
+   CPU1 (going offline)                 CPU0 (GP kthread)
+   --------------------                 -----------------
+   rcutree_report_cpu_dead()
+     rcu_report_qs_rnp()
+       // Must release rnp->lock to wake GP kthread
+       raw_spin_unlock_irqrestore_rcu_node()
+                                        // Wakes up and starts new GP
+                                        rcu_gp_init()
+                                          // First loop:
+                                          copies qsmaskinitnext->qsmaskinit
+                                          // CPU1 still in qsmaskinitnext!
+                                          
+                                          // Second loop:
+                                          rnp->qsmask = rnp->qsmaskinit
+                                          mask = rnp->qsmask & ~rnp->qsmaskinitnext
+                                          // mask is 0! CPU1 still in both masks
+       // Reacquire lock (but too late)
+     rnp->qsmaskinitnext &= ~mask       // Finally clears bit
+
+Without `ofl_lock`, the new grace period includes the offline CPU and waits
+forever for its quiescent state causing a GP hang.
+
+**A solution with ofl_lock**
+
+The `ofl_lock` (offline lock) prevents `rcu_gp_init()` from running during
+the vulnerable window when `rcu_report_qs_rnp()` has released `rnp->lock`:
+
+.. code-block:: none
+
+   CPU0 (rcu_gp_init)                   CPU1 (rcutree_report_cpu_dead)
+   ------------------                   ------------------------------
+   rcu_for_each_leaf_node(rnp) {
+       arch_spin_lock(&ofl_lock) -----> arch_spin_lock(&ofl_lock) [BLOCKED]
+       
+       // Safe: CPU1 can't interfere
+       rnp->qsmaskinit = rnp->qsmaskinitnext
+       
+       arch_spin_unlock(&ofl_lock) ---> // Now CPU1 can proceed
+   }                                    // But snapshot already taken
+
+**Another race causing GP hangs in rcu_gpu_init(): Reporting QS for Now-offline CPUs**
+
+After the first loop takes an atomic snapshot of online CPUs, as shown above,
+the second loop in `rcu_gp_init()` detects CPUs that went offline between
+releasing `ofl_lock` and acquiring the per-node `rnp->lock`. This detection is
+crucial because:
+
+1. The CPU might have gone offline after the snapshot but before the second loop
+2. The offline CPU cannot report its own QS if it's already dead
+3. Without this detection, the grace period would wait forever for CPUs that
+   are now offline.
+
+The second loop performs this detection safely:
+
+.. code-block:: none
+
+   rcu_for_each_node_breadth_first(rnp) {
+       raw_spin_lock_irqsave_rcu_node(rnp, flags);
+       rnp->qsmask = rnp->qsmaskinit;  // Apply the snapshot
+       
+       // Detect CPUs offline after snapshot
+       mask = rnp->qsmask & ~rnp->qsmaskinitnext;
+       
+       if (mask && rcu_is_leaf_node(rnp))
+           rcu_report_qs_rnp(mask, ...)  // Report QS for offline CPUs
+   }
+
+This approach ensures atomicity: quiescent state reporting for offline CPUs
+happens either in `rcu_gp_init()` (second loop) or in `rcutree_report_cpu_dead()`,
+never both and never neither. The `rnp->lock` held throughout the sequence
+prevents races - `rcutree_report_cpu_dead()` also acquires this lock when
+clearing `qsmaskinitnext`, ensuring mutual exclusion.
+
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c31b85e62310..f669f9b45e80 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1883,6 +1883,10 @@ static noinline_for_stack bool rcu_gp_init(void)
 	/* Exclude CPU hotplug operations. */
 	rcu_for_each_leaf_node(rnp) {
 		local_irq_disable();
+		/*
+		 * Serialize with CPU offline. See Requirements.rst > Hotplug CPU >
+		 * Concurrent Quiescent State Reporting for Offline CPUs.
+		 */
 		arch_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
@@ -1957,7 +1961,12 @@ static noinline_for_stack bool rcu_gp_init(void)
 		trace_rcu_grace_period_init(rcu_state.name, rnp->gp_seq,
 					    rnp->level, rnp->grplo,
 					    rnp->grphi, rnp->qsmask);
-		/* Quiescent states for tasks on any now-offline CPUs. */
+		/*
+		 * Quiescent states for tasks on any now-offline CPUs. Since we
+		 * released the ofl and rnp lock before this loop, CPUs might
+		 * have gone offline and we have to report QS on their behalf.
+		 * See Requirements.rst > Hotplug CPU > Concurrent QS Reporting.
+		 */
 		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
 		rnp->rcu_gp_init_mask = mask;
 		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
@@ -4388,6 +4397,13 @@ void rcutree_report_cpu_dead(void)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
+
+	/*
+	 * Hold the ofl_lock and rnp lock to avoid races between CPU going
+	 * offline and doing a QS report (as below), versus rcu_gp_init().
+	 * See Requirements.rst > Hotplug CPU > Concurrent QS Reporting section
+	 * for more details.
+	 */
 	arch_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
@@ -4398,6 +4414,7 @@ void rcutree_report_cpu_dead(void)
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
+	/* Clear from ->qsmaskinitnext to mark offline. */
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	arch_spin_unlock(&rcu_state.ofl_lock);
-- 
2.43.0


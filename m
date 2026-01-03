Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F541F12F8;
	Sat,  3 Jan 2026 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399851; cv=fail; b=K7mIo9MaGEVWPTbr4kTisGsa89ZPyg22Laz7L1uu/2X1av8j/7Uy2EHeT3TuJKuTNC4GDI5fQ3DMf954tXmBFyPTbAajAQteiQtMxT8NB3E3wQY8sHtPHJ3Dy4wugSLSIGKrNOpMDprmx2xsBdL3cGcF6iZ7xuQLXLsD1ajPo0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399851; c=relaxed/simple;
	bh=XiUGzi8CeJ+7CbRjkqb3vbv0g6LJH1fXTyVWgiZbLyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lq9e6j3MVfQ2V3wc8XRehxcct6uKhHxB9Gdlp1jaE9tw0cyvTgU9RdU1ueF4XfQwHSOFBD2lAHwbeIpoGVaf6/5TRm1J8V/2YwVeieCQdUoOSnf1YmGPsiLHfRzdvfhIYyBC/3l5G9jV8EQQxXq4NBMfjL0pse+0FgnLjZV1edk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R3Z9lTvz; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R3Z9lTvz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mytgmENNDfQaino8bYNEEiqWVogSZFvLWXpvIon1HI6s2oQbM9SgGXT9dK2k+8WHaIrgU3HnFmrmJ6V2EgJryyakLmJ14FAoD1ZUMKDGMzZ8GX7O77nWqO9/EjR4dPWGTdGqqALlunF8LlCoOh67GAf3Iss6xLB/3lOGo8AcRKMnrf4X9q0UDeEdPt4u4805XJp7Z7beflVJYeO5cXUDqUURZlvDiuU4DLfQm03IcAEqAwZTpAE7J1K/qTD+M95o69n0937hVtEjRz8YMy9cxwsrfKAK7wkmuOw78ynzsY+xxre99s8XPrB6HVSD+z8fM/gUP+5vLvBYaq760aIYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED3V/0n1tDKypUfjw0CgWkQqYcApQ0qmipVTYedxtiQ=;
 b=LDSQVxVPPckfbDHS7GivaBOHW4w7y1cWIYVwpPylSe4S/mhTFfRknO//K7Pb+ZAZvrfuDMnKroLqNLIBJ2Cy1Un4HguwyvTSHy+a47cHWjwEixPkOmMaRYMYDGw+OrXk9pNWddOpzNJtrf674oK2aAo0MHqoDMTVa9Tljwq4o5X2fKuOTeRiC9cVuAzZftxXcsA/lDi7Ulo7T1+sxpsHqgWJ1OGZHsUtoUwfQpvV2axFTbU+0ASh34iRrR0g6MgD7cqoHrvsQVqgHjEHHbfUunJeLm8sJHR8B/bb+iEMooVMCjpkXTv1be8OW5lBuRLja+/92KJ7sFfkMyXW5nOozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED3V/0n1tDKypUfjw0CgWkQqYcApQ0qmipVTYedxtiQ=;
 b=R3Z9lTvz0hX1TxrviRev9z3UKrtguZHAp9uSF3l5L4K2vy43qlVtIriQ6dg913vY9fVXD0EDYFKE9IdQo1bG20Af49fFWbubEdidOacHs7kR8mFRkwOrZXt7JVvWxJKLMaOTrgyDEhU23bX4tyqvWceHsHKEe+nRSlS3VSAWi6x0NJxb5tIl6Sbge+MHqn69Rlp5jiAEDOIgqq9/UQKJDNLuoW4pRAUhg0snhOQpU1TETBHXOAagLBCKHxWP0GFqKokS5yJ/KFfINZJqXeOxNmsBYzWwbW7+TUki1hbUo7Vkdf8lnVhI+8XMe9XKL6YkzwEnPHzDR6DEbTAV52tEXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:24:02 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:24:02 +0000
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
Subject: [PATCH RFC 06/14] rcu: Promote per-CPU blocked tasks before checking for blocked readers
Date: Fri,  2 Jan 2026 19:23:35 -0500
Message-Id: <20260103002343.6599-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:208:32e::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: cfed9769-b8ed-49a0-3503-08de4a5e65aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5YP9LNZ+wnd9Z0Egqyoro8BTiuvqSaFIVqvmLcC7yUWccADXomPEMIFEif9/?=
 =?us-ascii?Q?UMf5aptxJV4ct2GWiu6NodeoExkjzQ3rNp1lbsn5mh9OwtvtwTvvGYUJfj9N?=
 =?us-ascii?Q?HV/cGjLAGWQmhnfHX8C/NtUcWg6a9eEBSEVXpSYlb0Tjx6VVtJZKSwSLW6me?=
 =?us-ascii?Q?wpeH9t5MkIMm2gtVmy3nGRYghyraXsecj1lr+6kPLIv+JkDLURDHx5ki/OlC?=
 =?us-ascii?Q?5sz5yuAf3dCLPK3atlB4ds3KqFrwOCaAcDtIJnqA8Yz1z5RdVsqezK/LsEZ1?=
 =?us-ascii?Q?DaUA69IYrEL/ywmNv4Ru0phxax/JmSliZLFwbzpLHSO2Zsj6LdkBV6gwvunZ?=
 =?us-ascii?Q?nMHQjNtCbkcaVkOE5AQQvdBufT56tlHsdnl7Kmfs5R7uWgOK9j1PNpReMN2O?=
 =?us-ascii?Q?GllVNetOc+a5t9Tpt0q+P+RAT4RLfbDEo6aso044SLOI0Wbd5F296vPn04O5?=
 =?us-ascii?Q?b9EKfQ3yXdUkl9PR8kJ9M9PpAKlpr+aOYfWHUGuofFPh3mUFJNc5X5N0a4GR?=
 =?us-ascii?Q?P2srm1+zRyYKxWrfl8uIf/OXk15i8ALrWo3YjviPeN1BaYv8WJs5COtAbKOY?=
 =?us-ascii?Q?7vZ6H4dGWFT5nx0FGsvoDA9e8OadnWeUoC7PLWG0dNJmDtox3POGKn28XIpB?=
 =?us-ascii?Q?4mClsEsMQT5AuAgN/K+i6CsX+2vOccEFsn4Df8B3F+cR6tJVYOD2n/FeCvOR?=
 =?us-ascii?Q?7Ga5/8mPKaOpoW6GUKzt9ai8pCv8rbFuAlTIDdHJPFHHjwEZymH2AxKOIKIj?=
 =?us-ascii?Q?dfieI9Zsz3NAXjOqpxcNLpYKMuElis498BNEtzWQ5z9fjf7uprXOT0Pv3QO2?=
 =?us-ascii?Q?liHhcLnEkb+Bl7WkfNQM0g2l/ExdrR6vjsaTFQukx6p9B3tRmpPYgQk8uJdR?=
 =?us-ascii?Q?26IjKwD1f9Bs8J0hVA7HniICmOLAme1aEDQIhvTU+tukp87ehE5qAoBntMaO?=
 =?us-ascii?Q?9R7nLzNqa7mCbX4XDSElqpnQujnP2NEZm6lOoD9AuEOsOOT20bJAAzNb2FQ6?=
 =?us-ascii?Q?CA62Kw7dWi8cNP36Az3ZH4SX0m4AxBbXPxFYqh3VejDp3Aa817uiFN9YoFDx?=
 =?us-ascii?Q?v5dAAKAFVKzCIV9AM07YtqUstMjsCGgW9ahA8lTt5wvKMpEUR164F6f9G4pO?=
 =?us-ascii?Q?aMrmliXdkoeDpVHM1bbRmS98/jQvjmyH1jWYo3nWoytnPuxpIVhe1SqBum4k?=
 =?us-ascii?Q?O883GaUJJbrO2JK+7byTvHzIcjzKDpNtc+BE4Jgk3KVmjxTD1NZs2JQLe/BX?=
 =?us-ascii?Q?ZkJOe+mzmxlP9GK3GQ4iPi8dbiWO7WBIhRyUFzw+Y/mYRVM/BHJFw+5VgnMP?=
 =?us-ascii?Q?OnUVVIo/EQTCW1EukpRZln7KAZwoSGi/NIoFQIWo4l42OX5zBl0EC1QpJ5XA?=
 =?us-ascii?Q?Ess9HvZTI5qTI9Zb892ADS7jDe7dCX1X9rywT2M26NFCKeSITpGfhMyEzRzN?=
 =?us-ascii?Q?9CvtGXl+XqGBZtGVyD+196Lltba3ibOH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NkivzFhnltLxXHVczAMwwnAhDCWB4sh2A+pn2i76naNq09EXg+XDgMEKXUdl?=
 =?us-ascii?Q?VmhH4fB2I4bDkV63dZBDodkwtfN07+6vm0OUV2OJ6SOZbK/vUt7f3y8ge0NT?=
 =?us-ascii?Q?boWW2qrKzKJMqPhkjUUGX9ex2Sy7/cZgLuAITBZeahbJaZCw7fcR8MPVDaiq?=
 =?us-ascii?Q?k6LrTN7XD59/gO57ayDa8Z/Q8iTCI1Irv4znKN0FN48t0koqvinZIH6P3z5j?=
 =?us-ascii?Q?ZEFLF2AY5wPcJ0HE9fCgcePgdIpU4RcM6BUn16pVZmmajcLwJBZHFqOgnnKc?=
 =?us-ascii?Q?yxc207fstBQ7rR4MFIyp868e5LtFdiwoEKDQLqofzepThpb+oKa1jALXi1pV?=
 =?us-ascii?Q?hAaqvBJUiCdOYaPMEQntaTMojeut8dDGuo1X/MbkSFT51IQWdVws7Xc2JZm5?=
 =?us-ascii?Q?ZOaKyk+INzLG63Fvr7BR9I1kpBbcf/gIg9i5Y4vhCRzF3wvlM1LjkxT5CZx8?=
 =?us-ascii?Q?EWqrVaXGTzpz3Ay03BDVr4Ay8gyCGb8gMJtTiAii/Pj6TpIefPbpeCPlvxQN?=
 =?us-ascii?Q?yD/bTbGr6NF5X7izTPzwABsobuNtx1d6YLr3/EgxuLRJv65z1vXwtvRnPU/Q?=
 =?us-ascii?Q?7LlVtO4MjYoJjciOa+8oT7mzAdxPnhHJGubyKHd0Vs1CHiEZVm0E2LM6fO3n?=
 =?us-ascii?Q?6ggXWA3T9RQeastnQLFI4nNkv/WZofp09zcOBxyA0684icmSQ2KTE3Viro0P?=
 =?us-ascii?Q?18c8/HkUrcBat5wFt5ZtNK4EouB7vCC34xK4b9T2gKycdDdD/X/LLrIxRF98?=
 =?us-ascii?Q?I4U/JZb8YJGcVl1TrY2KNnZiOSzi7AOrGEMK7LYVayz+z4hkIljIg10X0+ma?=
 =?us-ascii?Q?AUCO8woewDCt6Ba9LYSPgbvSbaRTi5BnX6nuaCIsu9uk2EaMoGK9glxT583I?=
 =?us-ascii?Q?N0lKZ5RIn5UL4b4DjV8BY9SsRqymgRKzlmnkS4MSkt29T+ftUHM+GkqkuHse?=
 =?us-ascii?Q?W+jM5zFd4lqsSnkOz/mxlQne2V5N6G5Az6b0UMRPGA1H7KX2Q3eJHKFJzXdX?=
 =?us-ascii?Q?TPz6ByJZZIazYDkbSCNvamw4lgKbV1fntdhWrL739lqfhTxZIwptze5NPS9p?=
 =?us-ascii?Q?1xnHF+lHm+KGDLjFyzFY5qVFgwqrFyyvN22I0m0obnUqWLqxGz2qie40s/d5?=
 =?us-ascii?Q?PRt6UEesUopV+VlvyJcVU6NesUgT30UGByvuxF6ugRkdnHF8fSYlg+eSkN5L?=
 =?us-ascii?Q?w3gjIjo34Ssz05nxJCFvPbuE3Ko5QF3nxRNSvcjuy4xvD64ysnAoZTDx0g9X?=
 =?us-ascii?Q?EIdLAOKb+MwIzfn1J4ICdLRfyVHac9E6WAYZHVIUjsUWT1Zj19pa0B+fShUX?=
 =?us-ascii?Q?2vXfgFCHpuXaawxNQc04OKzzJQsTb/VIXF3jHVeJBAxA8jm2e7qOrF+h36U1?=
 =?us-ascii?Q?Nv5rFvwAhqaEB70pl+3k/i/oHethTAsR45AdVKGLRD+Zb7e0iivkgbPhPBT0?=
 =?us-ascii?Q?2xMjDk09Ygnt3dK0uHa7MHrjaorw07IqsJhMbsx1ZtZjlrL1gdordSZX/Gvu?=
 =?us-ascii?Q?eC2Fesh0TJcbxx19HLdX6kZ1ao6RgGQ5+Nl8lV72GQsdFKBAkDBZUaxJwCuQ?=
 =?us-ascii?Q?7sHVXLRleKlKIszlmBVbPfiUW7jLmBmXOYHR7hVhYztWgRUrwIb4iSjnfOXr?=
 =?us-ascii?Q?gwVm5vvlkD2Hedo4RPzBGoQHU6BpogMPDkrpWVbl9CHPTn9nxtiWevQpNO25?=
 =?us-ascii?Q?XsmRXYBVBeamN9FSKAc5EugiPaAiv+TTFAs53nZ7A0X4curOvyXkdIA0soGX?=
 =?us-ascii?Q?sv5HR/QBew=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfed9769-b8ed-49a0-3503-08de4a5e65aa
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:24:02.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNgx9Htrewp5zXiyMIO0dlePNHF0mSoJlxiVjIA1596Ao1es3i2X1c7e5+5AP+otxlIMk10B88HtMRuB2x+e1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

When CONFIG_RCU_PER_CPU_BLOCKED_LISTS is enabled, tasks that block in
RCU read-side critical sections may be placed on per-CPU lists rather
than directly on the rcu_node's blkd_tasks list.  It is possible that a
task can block just after rcu_gp_init()'s promotion scan completes,
leaving it only on the per-CPU list while a GP is active.

The RCU priority boosting mechanism only looks at rnp->gp_tasks and
rnp->exp_tasks, which point into rnp->blkd_tasks.  Tasks on per-CPU
lists are invisible to the boost kthread and cannot be boosted.

Address this by adding a "promote" parameter to
rcu_preempt_blocked_readers_cgp().  When promote is true and the caller
the function first promotes any tasks from per-CPU blocked lists to the
rcu_node's blkd_tasks list before checking if there are blocked readers.
This ensures that late-arriving tasks are visible for priority boosting
and other operations.

Callers that hold the rnp lock pass promote=true to get an accurate answer
including late arrivals. Lockless callers (GP loop, FQS check) pass
promote=false for an approximate snapshot (TODO: need to check if we can
always just set "promote" to true and remove the parameter).

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c        | 14 +++++++-------
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 34 ++++++++++++++++++++++++++++------
 kernel/rcu/tree_stall.h  |  4 ++--
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5837e9923642..f8f43f94adbb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2034,7 +2034,7 @@ static bool rcu_gp_fqs_check_wake(int *gfp)
 		return true;
 
 	// The current grace period has completed.
-	if (!READ_ONCE(rnp->qsmask) && !rcu_preempt_blocked_readers_cgp(rnp))
+	if (!READ_ONCE(rnp->qsmask) && !rcu_preempt_blocked_readers_cgp(rnp, false))
 		return true;
 
 	return false;
@@ -2125,7 +2125,7 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 		 * the corresponding leaf nodes have passed through their quiescent state.
 		 */
 		if (!READ_ONCE(rnp->qsmask) &&
-		    !rcu_preempt_blocked_readers_cgp(rnp))
+		    !rcu_preempt_blocked_readers_cgp(rnp, false))
 			break;
 		/* If time for quiescent-state forcing, do it. */
 		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
@@ -2207,7 +2207,7 @@ static noinline void rcu_gp_cleanup(void)
 	rcu_seq_end(&new_gp_seq);
 	rcu_for_each_node_breadth_first(rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
-		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
+		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp, true)))
 			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
@@ -2376,13 +2376,13 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 		}
 		WARN_ON_ONCE(oldmask); /* Any child must be all zeroed! */
 		WARN_ON_ONCE(!rcu_is_leaf_node(rnp) &&
-			     rcu_preempt_blocked_readers_cgp(rnp));
+			     rcu_preempt_blocked_readers_cgp(rnp, true));
 		WRITE_ONCE(rnp->qsmask, rnp->qsmask & ~mask);
 		trace_rcu_quiescent_state_report(rcu_state.name, rnp->gp_seq,
 						 mask, rnp->qsmask, rnp->level,
 						 rnp->grplo, rnp->grphi,
 						 !!rnp->gp_tasks);
-		if (rnp->qsmask != 0 || rcu_preempt_blocked_readers_cgp(rnp)) {
+		if (rnp->qsmask != 0 || rcu_preempt_blocked_readers_cgp(rnp, true)) {
 
 			/* Other bits still set at this level, so done. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -2428,7 +2428,7 @@ rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RCU)) ||
-	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)) ||
+	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp, true)) ||
 	    rnp->qsmask != 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;  /* Still need more quiescent states! */
@@ -2763,7 +2763,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rcu_state.cbovldnext |= !!rnp->cbovldmask;
 		if (rnp->qsmask == 0) {
-			if (rcu_preempt_blocked_readers_cgp(rnp)) {
+			if (rcu_preempt_blocked_readers_cgp(rnp, true)) {
 				/*
 				 * No point in scanning bits because they
 				 * are all zero.  But we might need to
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b71c6c1de8d3..25eb9200e6ef 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -486,7 +486,7 @@ static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
 /* Forward declarations for tree_plugin.h */
 static void rcu_bootup_announce(void);
 static void rcu_qs(void);
-static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp);
+static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp, bool promote);
 #ifdef CONFIG_HOTPLUG_CPU
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ad33fdd0efe8..6ed3815bb912 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -383,9 +383,28 @@ EXPORT_SYMBOL_GPL(rcu_note_context_switch);
  * Check for preempted RCU readers blocking the current grace period
  * for the specified rcu_node structure.  If the caller needs a reliable
  * answer, it must hold the rcu_node's ->lock.
+ *
+ * If @promote is true and CONFIG_RCU_PER_CPU_BLOCKED_LISTS is enabled,
+ * this function first promotes any tasks from per-CPU blocked lists to
+ * the rcu_node's blkd_tasks list before checking.  This ensures that
+ * late-arriving tasks (blocked after GP init's promotion scan) are
+ * visible for priority boosting and other operations.  When promoting,
+ * the caller must hold rnp->lock.
  */
-static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
+static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp, bool promote)
 {
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+	if (promote && rcu_is_leaf_node(rnp)) {
+		int cpu;
+		struct rcu_data *rdp;
+
+		raw_lockdep_assert_held_rcu_node(rnp);
+		for (cpu = rnp->grplo; cpu <= rnp->grphi; cpu++) {
+			rdp = per_cpu_ptr(&rcu_data, cpu);
+			rcu_promote_blocked_tasks_rdp(rdp, rnp);
+		}
+	}
+#endif
 	return READ_ONCE(rnp->gp_tasks) != NULL;
 }
 
@@ -570,7 +589,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
 		WARN_ON_ONCE(rnp != t->rcu_blocked_node);
 		WARN_ON_ONCE(!rcu_is_leaf_node(rnp));
-		empty_norm = !rcu_preempt_blocked_readers_cgp(rnp);
+		empty_norm = !rcu_preempt_blocked_readers_cgp(rnp, true);
 		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq &&
 			     (!empty_norm || rnp->qsmask));
 		empty_exp = sync_rcu_exp_done(rnp);
@@ -597,7 +616,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		 * so we must take a snapshot of the expedited state.
 		 */
 		empty_exp_now = sync_rcu_exp_done(rnp);
-		if (!empty_norm && !rcu_preempt_blocked_readers_cgp(rnp)) {
+		if (!empty_norm && !rcu_preempt_blocked_readers_cgp(rnp, true)) {
 			trace_rcu_quiescent_state_report(TPS("preempt_rcu"),
 							 rnp->gp_seq,
 							 0, rnp->qsmask,
@@ -901,7 +920,7 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_check_blocked_tasks() invoked with preemption enabled!!!\n");
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
+	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp, true)))
 		dump_blkd_tasks(rnp, 10);
 	if (rcu_preempt_has_tasks(rnp) &&
 	    (rnp->qsmaskinit || rnp->wait_blkd_tasks)) {
@@ -1127,7 +1146,7 @@ EXPORT_SYMBOL_GPL(rcu_note_context_switch);
  * Because preemptible RCU does not exist, there are never any preempted
  * RCU readers.
  */
-static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
+static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp, bool promote)
 {
 	return 0;
 }
@@ -1221,6 +1240,9 @@ static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp) { }
 
 static void rcu_promote_blocked_tasks(struct rcu_node *rnp) { }
 
+static void rcu_promote_blocked_tasks_rdp(struct rcu_data *rdp,
+					  struct rcu_node *rnp) { }
+
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 /*
@@ -1378,7 +1400,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
 	if (!rnp->boost_kthread_task ||
-	    (!rcu_preempt_blocked_readers_cgp(rnp) && !rnp->exp_tasks)) {
+	    (!rcu_preempt_blocked_readers_cgp(rnp, true) && !rnp->exp_tasks)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..5aa65130ab5c 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -277,7 +277,7 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 	struct task_struct *t;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
+	if (!rcu_preempt_blocked_readers_cgp(rnp, true)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
@@ -331,7 +331,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	struct task_struct *ts[8];
 
 	lockdep_assert_irqs_disabled();
-	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
+	if (!rcu_preempt_blocked_readers_cgp(rnp, true)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return 0;
 	}
-- 
2.34.1


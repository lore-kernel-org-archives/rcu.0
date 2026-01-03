Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009010FD;
	Sat,  3 Jan 2026 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767478291; cv=fail; b=KCsfU2f9NJ4ivcgLaQctdIAbq53vdmIfOOJjkukaD7eYhL0mbx6Tq8uBCjxUz5fvwaHz3GblkjiwzLjAI+dcNfkIXZzEdVhbMMZ/wb8C24eJQwKMxgFsbkIZ+sST9+IMBpFOERdIVkEZqfQDHaFQVuUOM5tvqog05pjAIkkk6Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767478291; c=relaxed/simple;
	bh=JWZrDbHDrvk722QP6mKICUWPMYBAMsRKIo8k5m9se2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lobWU0BpqDzfmBEMCfdBTf/aCRMGsiu4e1dAKP+g75rM7iewlQVxY7n3bnAthIVQCgoQEvIw9rLmT87evINaXD7AMi9kh3aSkYXPZK8tasHyB0a8e6WoiygY60YZ3M+OBCavPFmcEcH3moO+UdFKRLwLA3RZwz1KFUDkecCELyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bImJqEQu; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bImJqEQu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjG3suh2gm8ozs/l1WBD82YniZddZVJXFf5axu2QZMr3XY9MBmjJdqD/eTuJ9r5t9lBZKxPg5wDvjShZhJTzm2mmqJ57VzmsNIVQvhldvTv66LX0AA17mWxu9a5jpSEttR5dEGAgvEO8ofJM4J0ci6OlrdH1GdyXVk6WTR3XdG5sUE3KwH9Z1hB2lziwfLYxHTb3f3/TJ8PbIxVo5UuEYdr33MTwPjhjF5BWvaIrXUKRZMxi4xawnt8bAyN8RjLloL2EMetL38/r5GcspDRIlwxlTTo/TGEpsdUC1tS/IpYYI9kzfQu9RWlSagrszT6CgUR6P/UbiAEeu221TqrgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/Pgfhf1otCvgd2lZVw+w6f1sWbKhJlZEZZvnbrE/QA=;
 b=gzDQ6CvnKliIqwXfiWcO+KFu9w1IhR0dTwWvqLDct8P9B+5btfFebrvredweLsssS2/E1ltnu3Kjbjbd0ERlRWzBQui5ZR1+pnqw9yClQO4B38vzU3dLz5VOpOPPO3PUakJwfmDY+Q/oTYFbrCPkiF2FJRFEzVv+QIv68tWqWvnESw9DA6RQ9CoemPiydBSr+KOkN95hBIo7GHYSTDQMhTCQv9cu/ZQTg02lpTP8lw1+u6uD+XAgWbLeZFRaMFCC0yOVZyCz6PMnlvULoD83Hr6c99Hevz4pZfh+1UJG+u+iGiYQg5xZfuHEiS7JbO6GPCcGMY+lGfpxixOc1Ze0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/Pgfhf1otCvgd2lZVw+w6f1sWbKhJlZEZZvnbrE/QA=;
 b=bImJqEQu+bL1zeW45BO4STiLFfjsj/VKbu07R8TVE3DQGCbJyp7STKVtXV/t8nTLgCu3D1A2AaPWY9ykrW+rqa4jc1zE1Qp+JfZBV2Npoh6Iv5GEVrdLEAF3LM1gR5o+IIYw4/+pw9gK9ZidzujACtnXYSqLWUF6rjD5OlYevxfjzIBmhprcRrkWlhJoDjzC4VYnfpWogP02UEL+IkpX59rQhqDRAaRNFvfQvNnJZPTigKFvM+/EagJv6mMrj3pojaTgCJztmK4PvJbQeGY9xXIl970NvxiMRfK+O6Xz3Qj7EkwuxcGXxPKafiPjO548ptr13F15P5rUDoRSKn+eNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 22:11:27 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 22:11:27 +0000
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
Subject: [PATCH 1/3] rcu/nocb: Extract nocb_defer_wakeup_cancel() helper
Date: Sat,  3 Jan 2026 17:11:15 -0500
Message-Id: <20260103221117.521087-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103221117.521087-1-joelagnelf@nvidia.com>
References: <20260103221117.521087-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0025.namprd22.prod.outlook.com
 (2603:10b6:208:238::30) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: eaad3054-3098-4974-7ccc-08de4b150a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r0UCUJbZj2tL6G4cXSSkLb0OgKSackDhzcZ8LIGyRgKGi3fStE29whPoEX3O?=
 =?us-ascii?Q?mL0Nl57gg3Xt6836lbLiJpIz1eAyXjTi7k637UvFQqRSbn8ODVvt2UBZCSyJ?=
 =?us-ascii?Q?Jl28d4LykG+AQTsDibMiN4al2CllpGIdkeLVZsW2zhJlpYLKfEnrvtLA9d3O?=
 =?us-ascii?Q?9WvpTI0Eu02P0zPRd+z+a4HfIL2BeoEaJ6cLXgjnEM7bEcNHaICU3k87JAkO?=
 =?us-ascii?Q?HW1+9L3ouFGrq2rxzW0aNuACWfye4rUZ96/+Dtx9aCWM7KKlF4bhztNIbrTf?=
 =?us-ascii?Q?ISdLg/eV9Et2Ux8fjm+ERVbw40Qj4mHy8734wnYE9eU9IaC61kBos4+wCuMT?=
 =?us-ascii?Q?qznoA+a4Nnn3ZOQ5ZBVzZmkaji+fntZeETsUcMyRjAWYdLkor0yaafUuAI7E?=
 =?us-ascii?Q?fJDbEA6vlrdh2EraQxhD5ImyrKItVu4S/qH5W4N/psWPTTfz+dIljLiFIfGV?=
 =?us-ascii?Q?UAJL5cTrZLr+tHOAr2UQFIDPOB1G9QdcLX9MAl/7d7OqGF2RM9jBNI9w22x/?=
 =?us-ascii?Q?vAG+oSvaDtJp5HnbUOZ91eA4U9Wibnz0+y5KywALCVsCWsGb1m4vWR0NN7qf?=
 =?us-ascii?Q?vO59nCZoHInhGiXFJFj6kuDePpT8DR1GEt8+AFr5hDaBTYBrEBto3gTHzhDy?=
 =?us-ascii?Q?+XA3HC76FDV/SZrsPuFmQ57TMYeEiP4OOD4FLIwVmyvfKEKaQ4QpExaNcZyD?=
 =?us-ascii?Q?oxwPvPckIMnyFuOelXKnrMTY18drGFNyYZOE2PovCDRGwhiSo5A7UTYgetlq?=
 =?us-ascii?Q?m3+GXl7l5ZrPdlHolwkW7qaVTwyiPCMeAMvxFGV8Kw+V+g1p7rJ5Zbvci9IP?=
 =?us-ascii?Q?4Gs7JADhiDIbR3w8xj6q7CYnU7Bp8Y3B9CaOUfchgojl0fhrTOyDLGSNqFuT?=
 =?us-ascii?Q?0B8yQC2pJwc3ZDuHjkRXNFNpckPNo/pdP4QECCeXyrb2/c8NYYNnIF2kGv2V?=
 =?us-ascii?Q?Um7Ncx6wEl1caGeM11/TE3ChlAuoWoETfuyhxkNm6qYWMk0GsRgRBQOUfUjL?=
 =?us-ascii?Q?cT3VJzupIwPm0jTqvLLKQfzO10y3e9PkDm3oAZxSiLmlb0h20V+nBeqGkXaV?=
 =?us-ascii?Q?JTRpoF80YYt3tjgkrMSLtznuM2LcOJEm3YjB0FzVVAicmc/UIRYQaSXr5sXm?=
 =?us-ascii?Q?MvlshRfutd9IDylbHUaqVe82rJvafGS8yOAwIBL4bx4l/SVy2Nx0CamOVHZ/?=
 =?us-ascii?Q?D4PvZ4wMOWAMkx9jLMX2igA26N5634p8q1ekCXs2f0bvRFlc9cizffNdA2C9?=
 =?us-ascii?Q?bloKG4ZtbQzvazPXi/HR8m/HCTjsKOBMFLKcnHDjgQ4An3iE7cCJ1Uf0D027?=
 =?us-ascii?Q?YOziEqposYp55IzUMiqamS22V48HIioqh5O88Y00+rb9iFdhhE6rII/iYuh8?=
 =?us-ascii?Q?AeLlx3537J4BiFv3lcx0q2b/JxRswJ5VfBPWgiDgIB6jprcKSJ+3UBWPGlyx?=
 =?us-ascii?Q?qhYfD08tfAdwoTVGCTlFTeccfGdc+Tq3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k46sNfYH1yOpxPcdAmxq0TgdWqJgYtCdRQ0JWa40VzV2JkpN3bhNVrXXS1Pe?=
 =?us-ascii?Q?ZOVEOOXykXE7bzXFd4AQMEa/5osiI+9BfEMM3nRn65dLlstD1WoWKRSs37zQ?=
 =?us-ascii?Q?csO5PKxSRaNA+zISr/Bp/NMFar4DTskXa8IJuPiAOWbZfqpFZVEDxe6Wh2rw?=
 =?us-ascii?Q?7LtBn6D/hI5hkCqFPrvr9HTvpmZeuxRJJlLRwXNZmj3YGCAusN3Cb//F6IhE?=
 =?us-ascii?Q?Szo6clOloeaKz6QiAOJm9yu53phhmjdCZzMX68fky+DnKV3jDBzKeOITH7To?=
 =?us-ascii?Q?5xdBau/VVrSYlGg0BRJJhiSCyeoC/fvgnQRPBwheay1ioOgcOS0x7Hc1DIUd?=
 =?us-ascii?Q?RaICwN2RmiwbWOfuphSBVWXa9BxuSCxeH3dgQIIGfJ1zKu8tBBQhPC2hCW7i?=
 =?us-ascii?Q?SslefCnb4+gal2n0WPCPIRzJJYW1fN2z6YJfeZDB7sy3q5utUI3PM+jlGSdy?=
 =?us-ascii?Q?hBHZo4J76CMQPktR0dNT9c4UZDy1luHTjOc81a1+TSJelJDroIhyPd8IuYmD?=
 =?us-ascii?Q?uHa/dne25o1uEOUofmH0/8WHLFUoF82xA2nC+L6XZA1DqflzSWOnGhSlcqwD?=
 =?us-ascii?Q?bFq2R74OCY4rOy6pzWLvot5cVCR8VckgYI/L2a+wLv5P3gWhhQ4CWnRbS1yL?=
 =?us-ascii?Q?Zwg+Eczv/q1e+U6/FIe27e7Ymy1JaN9QmyUmJy9LbARl2G7roTzYD236zCiL?=
 =?us-ascii?Q?x4PGJqgSDMRsQAd7nGxiesLCu3Xd+kfNrHplHs3a8SiF+DSCxGveLtyhx9QR?=
 =?us-ascii?Q?W+XiUIJnOqNRSdr4iJ/ljXmQ7CoagdWBPQtR0Z954jvkKc1Po87vrD6XpP5h?=
 =?us-ascii?Q?BqPkFeScVWANiOBMcpyJ0BSSQVUiyhplsja5B9D6ERdT39Zxw1kLwZelRFWw?=
 =?us-ascii?Q?0v6ZipGlBfRMkeEGTz/x06Zu32bC7av/YG4ZtgxMY9VkilE7TW3/qZ3z3knz?=
 =?us-ascii?Q?dLQlLnaVg6yP+oN/4uEZEIFA+qJMsQfl568gjB/5pVvwpi0AmPCgYz8+EWJQ?=
 =?us-ascii?Q?FsL+Em5Ko4B4C3PtZxdsAJ2FQgi6DQZxf9+PEM2n+dCDci+vdOnyODNz/Gqj?=
 =?us-ascii?Q?h0iOYYguiEMYqEnNuV/L+Bzp+0oG+GmE33bZy0ORFvU+/g585uLt+cNDAXtR?=
 =?us-ascii?Q?eoydMNuZEokFWNgdQ0KusSjx9V48M3D01oCxcR2FcRjd+ia6smy2mlrBYuLJ?=
 =?us-ascii?Q?Jan5Yc2qIY6N/TaBTRL2lhXcxr5fONL+GVF2FeEYfxoy0zc7Mi3Bk12TTPO7?=
 =?us-ascii?Q?N3VkVKQqdPuTIYfLrE0lW1aAdeLpX0QMS7xfIDff9xLfIAXdtK/tlqnk0+u4?=
 =?us-ascii?Q?0+f7Zpu4iILUvxEKlI/qKfa1uXRQdoKup4DePuZ5TcBYWtyVxh9ox/p58gCh?=
 =?us-ascii?Q?vgVpoTITSguIAFQPh479ofmlP7T1qgDfpSy0uHwnXm3QlW7SXANLOBwYBSpN?=
 =?us-ascii?Q?jXBKm86QCNo2PFiYZzieg6Nq9xQcTyf9ajmdhJp9czgow4BPUBURC548GmH5?=
 =?us-ascii?Q?LgFm7TgkKYxSStHx8UwGFug8S4t/J8EnQUQ6xHbTRcNDj2ySWgUzw1+fQ2UV?=
 =?us-ascii?Q?cVhm8hgT0iBcZQTC0i/cpteO55ktVaia3WmJqaSYZPkWGiP/1L6P4wEMKasJ?=
 =?us-ascii?Q?NtwAb0K0APK4zvgSBD6Zho5554MOAuk9WKoutXNSf6g4lswyfkgHkjjGnI/a?=
 =?us-ascii?Q?ZAU+lq+j+bOARsySr4nUw2XQgr2lsnNYX8PHpfJxFppdOPnvuR6I0EPTkuRf?=
 =?us-ascii?Q?oiPBkipr9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaad3054-3098-4974-7ccc-08de4b150a58
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 22:11:27.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+6/7ph0eLpK6qcIoZh3mXwRNhXM4gGLjrR9oI6hqyIZY2y5RHkDLS8OQdkxId2GXXAFi+ju0ofPSWb4XUn5IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242

The pattern of checking nocb_defer_wakeup and deleting the timer is
duplicated in __wake_nocb_gp() and nocb_gp_wait(). Extract this into a
common helper function nocb_defer_wakeup_cancel().

This removes code duplication and makes it easier to maintain.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index d3e6a0e77210..d9687317a2a3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -190,6 +190,15 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
 }
 
+/* Clear any pending deferred wakeup timer (nocb_gp_lock must be held). */
+static void nocb_defer_wakeup_cancel(struct rcu_data *rdp_gp)
+{
+	if (rdp_gp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
+		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
+		timer_delete(&rdp_gp->nocb_timer);
+	}
+}
+
 static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 			   struct rcu_data *rdp,
 			   bool force, unsigned long flags)
@@ -204,10 +213,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 		return false;
 	}
 
-	if (rdp_gp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
-		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-		timer_delete(&rdp_gp->nocb_timer);
-	}
+	nocb_defer_wakeup_cancel(rdp_gp);
 
 	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
@@ -815,10 +821,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		if (rdp_toggling)
 			my_rdp->nocb_toggling_rdp = NULL;
 
-		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
-			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-			timer_delete(&my_rdp->nocb_timer);
-		}
+		nocb_defer_wakeup_cancel(my_rdp);
 		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 	} else {
-- 
2.34.1


Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C52C86D;
	Sat, 27 Dec 2025 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766794376; cv=fail; b=kOkHAlvdm/gRY4LuDWtH6OAXII1dQqqY/sNBA/6t7ZCvtsXg45LmdQZJHrllEFAo4lvOL1jsqWlZcwvRTjiL9xQJsdaFMpxBrBIcwK5G36Y//CMcvoDcOkXi2klrS1ubzwYx0cFbx2uMYNe2GTLa2mggLXr4fS6aNkA0ssmSOGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766794376; c=relaxed/simple;
	bh=zEcThlkR8p6ApY+EKfqs50x04vp+Oas7DdIudWckDzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=izz89h4mTLscW1p0XHGhiDKNN47WO7YdX+WkibC9dLCC6YdIC6uir9vGelqwES3oJNH0Cq4wf5KyOXGHeJZ6IS63tkY/XvSMSGpWGJ4cG0v4CM6XWSPiZLTxT/gpGssVnC6jXIga4V+Y3h/bDOBGaA2yH5s6HHKd+Ldpb2/BBuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KzRb+9f/; arc=fail smtp.client-ip=40.93.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KzRb+9f/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmDxr9zwzv7d3TCUGJDnKUo+WTGiaQ01sd7morjZJC1ECF4qbOZt2WO+TkLBFIq2wTi2lujV6OTdJ4C19laiRigVnJFVDyVe4EyCOVGIrjfVymadHNVFl75HrXQWNsh2OqY1LejEmFpcqgQ82McRGh2IMq4YRerOAy3b9S8dQc+ZrASWM735SOnmMNZGHwcLz+cHBCFdTaJAEHn6bo/HuadIp/jrd4mI9STqlIH+I7Fu49QZxOCnkgD98+e1Y3Nyfz3ZEiU+sImlfvQZz89Er0OEIA/6CiDEt5o66rVwl42rc6VjR+w877z9Xb47W0QkBaOmzscYH0+encfFtA6HAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ivfa0FJ4UVp3jJOWp+jT0uCxt/pxGuCr3M88ZgWRjqU=;
 b=Kp7OfCIDC8fRVfPlRC2XNCif5xySAx48kbTHIC7o11o0Trrek940jnaiFIBJtrpN6+ArvfXqxKWG0JGvVGnLFnRwhgttS7G11lLdRG0pyDwp5916JCeGyNuzjFy9CHFh0/kAag0D2c/lc64Zo4vf/ABIEtPoUMnxhklxXPFZ1YDcA9LExIjQ1ZxpyKFMcthSuGGa/yuezB7a6IgJ2bAS8yCKN0TZl8num2aqW84c8hO8VFlIUfKBUACQfz5LZRHSuxb+7bNbMXlgmA2lw9o2za7VeJ295GXHH4vKzlGnZo5VpgUgnjIy/Wxvxm8ZbZFmZNY3xsaNOPQpmvq+qJpckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ivfa0FJ4UVp3jJOWp+jT0uCxt/pxGuCr3M88ZgWRjqU=;
 b=KzRb+9f/OGotVFjL/VJ+sTbFBcwqfQf5ckmZSKFwL2vkTtAFQGAiVd/h+1i+CTWNB3zYiefNjLgY7LueHLKaXYVQt0XndLvHBAky6uCbMSCzJEEBZRcoGSJENwiuYeRvt4sa4nEO7+inKuLM9r0bGkW+wx7n33LCI+akge9inr+0EBfYBBNCHrCJ1zjMzaka1s/HDh3ixdveRNBRd28W+4FkQYiyLMehCgGD9CTryK02eJ1mx0pJEDm/xRx8ox4LHBVbQ+8PGuwyRQbyRvSKf4ypmMs7R1VjfF/sFc8zvwBQGOBTqmvTkBFc8F1hYbHrsH+mSgJXklCulGlYQtdwoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Sat, 27 Dec
 2025 00:12:51 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.008; Sat, 27 Dec 2025
 00:12:51 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v2 1/3] rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
Date: Fri, 26 Dec 2025 19:12:37 -0500
Message-Id: <20251227001239.405644-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251227001239.405644-1-joelagnelf@nvidia.com>
References: <20251227001239.405644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b4a6df-96de-41ae-4e2f-08de44dcac8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DopYaizp6GFkBtD7b+xIkVHAu40j9+uLEiFZ7uXL3VT2hHEUjw35C8Jy1rd0?=
 =?us-ascii?Q?KsjuzuwmOQlSKOf/R0lMbICXF9Rm7kmHU9dPoXXFQ8M/4ETv34cj+SN33VYy?=
 =?us-ascii?Q?j0dnSsxcbbJrHOop77XHAENYR3s3omKj7wX4fm2sKfZHZKeL8tPJPo8f4fnc?=
 =?us-ascii?Q?7kBAdCuTRsQyHPaNbgjaMMu9nTem8+GlV/uw0vYRd2nV1MqyjJ72UE/x4pf0?=
 =?us-ascii?Q?msJ+pUMz/cIPOjNbI9plJfn4voVyHgykUrNPbGTGTEufM9qZXKBlqGoCzkjt?=
 =?us-ascii?Q?/V58o2wJ/xwCCBJbhuRA7jY13rfZvgKQKkwXKITX/gPDD+zk4KF7tXd9BPqD?=
 =?us-ascii?Q?C6haFUvPRAu7L/CXcf02XFl6Q7WknPv3s7M3G7h9jHWZPCzL7guSuSD/O6Pl?=
 =?us-ascii?Q?c/JBVBws/rkai7QAKyI0MqdRzaGQGceGshosckZInL8wtIR7cfHrXASXW/eB?=
 =?us-ascii?Q?x5i8ElP1VEJ+KzH2d8+MifXH+SkYJyEXDWogd1i+L/dXDnZe4eXu6z4CKaCy?=
 =?us-ascii?Q?9lAUxe7TGjdW5cUqHbHvDl7y4kZRnleHxFdQEc2fRtDP2NglEGalygGUu7Fc?=
 =?us-ascii?Q?XUab0hjMX6sVxhp3c6EPLwLFfu6MJOeTpYTpV8laJuW9Gurwk+Aal292dYxH?=
 =?us-ascii?Q?U3cA4LhwnA6DhWnercleyk4+PPM1PTqax+ccRaHeduWGEvOtAQYlkVsUNWZd?=
 =?us-ascii?Q?fyAG1lcHs+L5miOYhSjkG8tk0VhH8esejaNkCT++bXMt0pHLtRVpErWsTio/?=
 =?us-ascii?Q?bns6OUBDzTC/ydqUlQb0n8+KKeSuOgpvQ/fEmXqbFRUYcG1UPbrbCFIq/z1o?=
 =?us-ascii?Q?VRN1CELdq51+Q1mKvlgLpd17yPjmP+7KV1qGutEvPNYuk7wtlQMPPAlkdVvD?=
 =?us-ascii?Q?YJD0mZbvFeoHmXUNvDYLWVMe4z90BPSvRVqKD4jripuyMgy+qrDMdQZjhjnF?=
 =?us-ascii?Q?TO8usoEpfqBfNWtcF3O+tgfVMv//AxxictcK4gSaHAX4js2W4LLK0LLPrQjk?=
 =?us-ascii?Q?Nv3x9SUeVUcaL3zV/TsfuVAJ9DTW6c/i34t9sDyb5k7PLgmrxZxmuQaZvmCl?=
 =?us-ascii?Q?EjeGlH1OdFzmaK/YPNXWbN5L/c2jPD+WeniHZ/YBXF0UWt7afDbzBS8sTurS?=
 =?us-ascii?Q?9LZYlLvR0ZsoD5f91Tv2IqGwbGAu6xX0ZX59RFEH6p+zTSeACp/JLEiyjH+W?=
 =?us-ascii?Q?XkOxG5eAunUzW6DrViu++7SB0ZdOMRfncnh3POHsb30HoElbj3MFsf7wJsMU?=
 =?us-ascii?Q?UaG92wurlDHB/pEbLd9c5YHHX8wvGsN9zuhxKZlx1Ns3+tMX/P1VV8iz7gvM?=
 =?us-ascii?Q?xTTbGGxtG1dOfQYov0lsaSm+6pfyddv6lxg0D/pjdXA4+kq0/9Cw0Hu0oJ5f?=
 =?us-ascii?Q?p+tSy0MJD9zNKAzy9O7FeAQEOORMEasAtLhMtozzzlbZAfRJA0zI2lWiBpkV?=
 =?us-ascii?Q?oS9aovX5VsBOvLVD4z1bQ2X233kgcR4nevWAxRQA8MGlF8ZAgOsZVOIksnrD?=
 =?us-ascii?Q?Wb6AG9IaWj7R9ks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E1VimyYvEQ5yqRidvko70rEhOuNN/xpzSGTswOhskSD0OhDVQgYh+vjmo/oo?=
 =?us-ascii?Q?5MV8ruuD23U9aI1EDd6ZOiymTzjrrJPCrhVVzOG9CoH3Xo1DlAzJdgHKFiYA?=
 =?us-ascii?Q?uLSoZS3Jj7ZasMjFqPXsY+7E8vpDrlY1j7pVpZQzvAzWnHwyc2wGAnivpE4w?=
 =?us-ascii?Q?Cc2juYvbMOpEvirvE83a44p4fYiQXDH83rCpZ9guTrtdhxNTi++2qBFdSEIX?=
 =?us-ascii?Q?WVLsZwwdAp79NWDHjf+VoFp9yR57Z6zYyPia/Xvzk5+XAuYqoCmwGaK881Tu?=
 =?us-ascii?Q?/NRzxzv8jbflg68yQry1A1+3C9H16MhEcrAK6XPmHh7fvqPW9+YVKLipKP48?=
 =?us-ascii?Q?TtchVqZ4gbJwk8XOWPQ9vRF9jFw7tq2c/WLyDB6urdaSZ2bMbvmxvc1Rvdic?=
 =?us-ascii?Q?84wk9pshkwSr9U/lpk82JA6x61DHxwJNPBE5uCTD6CePzDe16P36sbzeZk5Z?=
 =?us-ascii?Q?hijEEey03zNhmcWqLnaKF1woyzqbMeCX9kxNkP/XTeUSucD0EA6xBIJK+fN/?=
 =?us-ascii?Q?kNjV/07kmA2nGCXiq8dhpby24M23hYjn2hGb0OySGTKkJPH4wIOwmhLhI+Lo?=
 =?us-ascii?Q?ThP5+cvSsIeKR4gABq3+c0pjewVMla8O+VaPMtIa5wHzeCTOyoWeUBvL1Eii?=
 =?us-ascii?Q?zTRH/4rP0g8VLupvnAhi5om2k4/h2KYRs6upRO2svVXqZRMMlXOI9byKoaAy?=
 =?us-ascii?Q?h/71kzNn82owLMlEszLFQIjMcK38prkKCGKHR2Lrxrm79sydcpw5iUb2ppJK?=
 =?us-ascii?Q?6PaHzHB2FD3yU4gomL84jLOn1MsNESkZqd6ShANO6ECiXB51myRMs6et4LW+?=
 =?us-ascii?Q?cWtt2Lt72DRVfjPTi3Jx1gAx5sc/UV3zT25CZHF4V3PWRViKVe/vD4lYqmKE?=
 =?us-ascii?Q?1G8w1d37fcYc/AXVQ2ZisWuFjhbOs4jF12tMRQr3Yvc/VDyyiXHJ1+IKxS+R?=
 =?us-ascii?Q?1UoWetTb1g8w9FoV4kh9DPQPIFxFL+A4KxwNlFax4zJ86yLhBg6Es4B3qHq7?=
 =?us-ascii?Q?0SNetekq3pXW+Kd6mROsYMGXuhwxTugLCHal3yiKLK943BNkCZ2GLrR0+azG?=
 =?us-ascii?Q?0OQlswggRSnDqgGCkFARr14jX4U3MmYYBdnN0Rh2ziC2pu7+botg0M6ky6SF?=
 =?us-ascii?Q?ziCPFjqy4mpvTswUKd6qHA758VUB7yi1txfJLZYp+KsXMNNb+6wIRnGmEzrl?=
 =?us-ascii?Q?2TGJtJefsbpup0yZ8x6pHQDLwSeTpG2m3x7FR1ssDbSaILxI2DPcOrqIjtfz?=
 =?us-ascii?Q?Jon1v6s2ClmERBi0nXt+VB5tm2EH07OfVgrg0W8P1NkhBb9Wvs78vbOFhcrc?=
 =?us-ascii?Q?5T1wcOSazKZA+K7PhWuqiUElXpo81hgs4jMIEaOTXrRrK3COg94qgGAGiUOm?=
 =?us-ascii?Q?wSLwFVtuHr1CmFU6lM+pcitVLK8kkqWyZfuYV4G478qAk+N53kI4EHupVYOf?=
 =?us-ascii?Q?3GFgwFakLjSobUQrfG26SwoETDDI/fSJiYbADcOhK8LwGAaXnyzLD48GQR/y?=
 =?us-ascii?Q?7TUh3TPyL4SPCLm9yZTB8zGQL8hjYzZs+i46Lkl5vXSXYotFDRHcEJ1roVUq?=
 =?us-ascii?Q?TUNcG77Fpu6azDRS/oM1xBsqJcY0RdXuDEZDA8cyctBoxFuyfw1r/1ZZm26Z?=
 =?us-ascii?Q?QWWaE7vJRRSS6XZWh9b9YkVWBVpSoRCQOiO62zvQNTIPc47ZIIazvcAHsKwW?=
 =?us-ascii?Q?ruN2W2VbLv4l3EjBg/C+9IN1E+Vy0sjPO2dJAQ2Efw1rd/H/zEOE+zsXXjoj?=
 =?us-ascii?Q?kCgZsKF7LQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b4a6df-96de-41ae-4e2f-08de44dcac8a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 00:12:51.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/V4xJaa/tXfJSKhP0H1c8FNqt7ijCJVc5T+Cah4u4NbdFyKep3ZAY154PRgZyp9a8RVboVlJ83w+3vPpBqETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

The WakeOvfIsDeferred code path in __call_rcu_nocb_wake() attempts to
wake rcuog when the callback count exceeds qhimark and callbacks aren't
done with their GP (newly queued or awaiting GP). However, a lot of
testing proves this wake is always redundant or useless.

In the flooding case, rcuog is always waiting for a GP to finish. So
waking up the rcuog thread is pointless. The timer wakeup adds overhead,
rcuog simply wakes up and goes back to sleep achieving nothing.

This path also adds a full memory barrier, and additional timer expiry
modifications unnecessarily.

The root cause is that WakeOvfIsDeferred fires when
!rcu_segcblist_ready_cbs() (GP not complete), but waking rcuog cannot
accelerate GP completion.

This commit therefore removes this path.

Tested with rcutorture scenarios: TREE01, TREE05, TREE08 (all NOCB
configurations) - all pass. Also stress tested using a kernel module
that floods call_rcu() to trigger the overload conditions and made the
observations confirming the findings.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h      |  1 -
 kernel/rcu/tree_nocb.h | 35 +++++++++--------------------------
 2 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b8bbe7960cda..83773560332e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -301,7 +301,6 @@ struct rcu_data {
 #define RCU_NOCB_WAKE_BYPASS	1
 #define RCU_NOCB_WAKE_LAZY	2
 #define RCU_NOCB_WAKE		3
-#define RCU_NOCB_WAKE_FORCE	4
 
 #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
 					/* For jiffies_till_first_fqs and */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e6cd56603cad..daff2756cd90 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -518,10 +518,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 /*
- * Awaken the no-CBs grace-period kthread if needed, either due to it
- * legitimately being asleep or due to overload conditions.
- *
- * If warranted, also wake up the kthread servicing this CPUs queues.
+ * Awaken the no-CBs grace-period kthread if needed due to it legitimately
+ * being asleep.
  */
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 				 unsigned long flags)
@@ -533,7 +531,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	long lazy_len;
 	long len;
 	struct task_struct *t;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
@@ -549,22 +546,22 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
+		rcu_nocb_unlock(rdp);
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
 		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
 		}
+
+		return;
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
 		/* ... or if many callbacks queued. */
 		rdp->qlen_last_fqs_check = len;
@@ -575,21 +572,10 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		smp_mb(); /* Enqueue before timer_pending(). */
-		if ((rdp->nocb_cb_sleep ||
-		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
-		    !timer_pending(&rdp_gp->nocb_timer)) {
-			rcu_nocb_unlock(rdp);
-			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
-					   TPS("WakeOvfIsDeferred"));
-		} else {
-			rcu_nocb_unlock(rdp);
-			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
-		}
-	} else {
-		rcu_nocb_unlock(rdp);
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
+
+	rcu_nocb_unlock(rdp);
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 }
 
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
@@ -966,7 +952,6 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 					   unsigned long flags)
 	__releases(rdp_gp->nocb_gp_lock)
 {
-	int ndw;
 	int ret;
 
 	if (!rcu_nocb_need_deferred_wakeup(rdp_gp, level)) {
@@ -974,8 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 		return false;
 	}
 
-	ndw = rdp_gp->nocb_defer_wakeup;
-	ret = __wake_nocb_gp(rdp_gp, rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
+	ret = __wake_nocb_gp(rdp_gp, rdp, false, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 
 	return ret;
@@ -991,7 +975,6 @@ static void do_nocb_deferred_wakeup_timer(struct timer_list *t)
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
 
 	raw_spin_lock_irqsave(&rdp->nocb_gp_lock, flags);
-	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
 	do_nocb_deferred_wakeup_common(rdp, rdp, RCU_NOCB_WAKE_BYPASS, flags);
 }
 
-- 
2.34.1


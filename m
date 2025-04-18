Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD41218AC7;
	Fri, 18 Apr 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992677; cv=fail; b=YoPKr0SeycgHVBMSJUS1ak2+cYkrTRDgdu8MQKhYITQNZuFTgD4LxnZbsw52/Nv2E/ugmaJe2TE8wN2YhzcEZiIo1q2y6ithKAEr8GVCYyO3M1xoz3s7pC84sIXdWns3OlWCbQO34FDdY4Bla8k/yyRcRiJSfNXCj5KXRqVm2b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992677; c=relaxed/simple;
	bh=fhSt13qZNIDURImcWR4YCnIChtWl48dPr2uYbBMnNRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6YAUgzPXSYj+oi7p2eyzjSJEY9/hhNK/tibeD5MR+KnoVFFdPCaUieNFTNLHIoHRl/zH4lluR+qdXLFtv/TdFfO+u0BUq2Th1gWRX5mzv1ulJ/O+91M9n97OUemuw7ulDrtu0zEJAGP29a2n7hwy4cH5XHA059nLbPHryjYuzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f9k8qklK; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9k8qklK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgbN3Z1QxNkVdPeqEoBq7gLoC1Mq7zXAtQLWJGRo3bv1Uc/RZQm5/WMHG+0emeCgqJrnKZflDTe65VpA1OEEdEQusOME3sZ1YGmqNMoeFAp3STi4SBKUY6BpiSWXFJ43VG/0PzsMgMjDZb51CQgiUVGfzRl/PgYOc3SXWhYL89MEgCj2Gf9WDdzbFH/fbdlR4qcMpBEAV1K//LRi2CWSBFq7XwzEwCaYKRotMv5Wh4H7kbLFfwc+6rSA3NePibUhwf28rwcVb/88u6lN58eaD8DOuLEo2u9T610q3q2qyaztN6sfNvNNp/1lQ7+RooXzEp+CeakYbMiW1Lx19KTjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN/bkwuZydj8ywgIa5xbhegSK4kc/+bt2K6Wj118TQA=;
 b=U3kL21kCDwMtTYNDipisGCEoCbgNboGLqURwtr3t81ZWP3CIVF3TZ/sG0yMNphhXRSjw17hfdHFKoyNqCkE+Ej5sHFMTZDk7HXchpXMWmVEhTDgitFDZ1oNRHGhAm2DoKvYZoknLAMGfVNTERdD0Ee43Ki+lsm0vjjdiTIGGy7NF2gSsA+4R9hNepaForM2COyj3862+4AGjXXSY7ZE7mm3+5+0VY+oaLSGaDGbKaPdRHDyzpU5gW2vvlX8KGYg2NcB/4+rsKOD/FU2I+5t7sstkhqbfobB1QSd7ylgkSs3haqQEqjnOGylbe40cPctcOtm4HiZtOKN8T+96xJxGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN/bkwuZydj8ywgIa5xbhegSK4kc/+bt2K6Wj118TQA=;
 b=f9k8qklKhOM0dDkHfLOKYl/jW31GXgKjSsurURJ9jlX07VswTHEcoPfrc2wFbP1YPzs7lfNhuB3lmlS8Wz8t2bCr3le5MsCgic9XJQaDLD07f8YemI59Ur1MdklQ2Vq05CXJtmnA8RLuMrvzA7BnLTbrzJ7eq9eQzHAiuX+UsmvH6jgRjRJQInj3B+eopB8T8f4dtMOuuQ+Wl3SLXDJIaLdTl/Zn9TxlqzJLz9yzcalNTGDJq8vS5vB+CiGQlbgE00MDMNyluDJCafQ7pfCeugx/G51ZC4U+maZvNr4fh7dg17nxTF+S25LCT/gMRLy0YVu6gBafwRvA1qcu0/Czhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:11:09 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:11:09 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 08/12] rcutorture: Complain if an ->up_read() is delayed more than 10 seconds
Date: Fri, 18 Apr 2025 12:09:54 -0400
Message-ID: <20250418161005.2425391-23-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: c89832ba-3e82-420e-0093-08dd7e93a15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOQDB9gj7SKuB65dDKVtQkzYB+GUODRhT028vvzeYQq76Of5/lWarjdiNZko?=
 =?us-ascii?Q?1Z0vhzObwxi4kg0EWKleXZdLTJaFrjGs1GbYgcvGnwb3ZivBNiKFPaMUOiKN?=
 =?us-ascii?Q?bG0Fy5HHN5twUagobg+HC4SLXFuo0qswGprmS85k2MzLKHLoH9DZiGtrb3fk?=
 =?us-ascii?Q?rDUsJbd1TOihRYVsR5Ls46KfxmICD2N+MwwB+2OifMDQTyAxVVPZXKjL+ffg?=
 =?us-ascii?Q?Cvc9CXTmyJL/EksyQt55Vw0r7igE5SeJeAzf0w/oQO/oBMyLGzxuhtCFxH0+?=
 =?us-ascii?Q?M18/6d6Gzz2eDUzle3fIAYTLjjCcV39aBJkqcdhL7IhonOJrzkCCK+4yRpi2?=
 =?us-ascii?Q?98MeqAg9iEBGNsnJxFGWHjckRC+KwclXAMY/HHZGdJugtchJZOQ4CW3T/HXW?=
 =?us-ascii?Q?9P3wu4syqIIqEccZn9VQ0Jlx2TNulXBBGYs+JEHyT9ItXTnBQDiFGqFbX02L?=
 =?us-ascii?Q?I5KYEnIRVdoGu/mPS6RA8DODTCAnXVglrfhWFYX5Wihtxn+mhZhu/MWAjxCQ?=
 =?us-ascii?Q?cej/OcfaLG6BJlSDqNVpnoI98jgDOVtupENxn0Zkk57PLjDPJN5QG/Bhyohi?=
 =?us-ascii?Q?segR2Wr3af7pdSA80feYUtrGh+TUNoAPdhW1zoGEhTGGGfcAWaFFWZEc7oVI?=
 =?us-ascii?Q?oiV9dvLQ0ukauHvowf5vCCcMjNmGnP95baY/pxsHVZ02rCkr/SheKHN7ivl4?=
 =?us-ascii?Q?+ogUskeUYUblSRM5680w7Erp0IAYG9RhuydTKaPMZDhMhluXwhcy2pcUToOp?=
 =?us-ascii?Q?AfLqn0qRp+7fDJCQWAM/YatjrTS/Su9AwHBsl9C/0aJcVOVBWedsqH0u5HY3?=
 =?us-ascii?Q?geTXeWQe57ePbnkkHVcK+mUwyzp5d+UrrVRSwAq25MnCWag4o5KBoTtxrKir?=
 =?us-ascii?Q?aZga4cn0MW8B7bqrNkM8bjeMQLwvkQRlNDyrfuDTuvE2YrSSCn6Y+KluIf/T?=
 =?us-ascii?Q?nQ2OqkNeETBjj5in0DUG9aW6AdVwtCwMr5s7AbcYTSdWmKQneppf7Bnk+qGZ?=
 =?us-ascii?Q?FWY+DnQBIB389Gj32pBIVIVVzh/dyIecPtWYLvlcvjz+LlJxf4evSvCd/oqu?=
 =?us-ascii?Q?G7xNOib3cRjlvrOlJ4tT28z6FWJduGvHfUZZhEOm68bjPfwdHpM2B81Rb6Eu?=
 =?us-ascii?Q?xgbSmg3DuPkiXgT6lO1X/fKDdt89RpJXSpwhIwQnVxdrD8IUV2Lp5GQxAvPe?=
 =?us-ascii?Q?Y83wFsHGXkFo5eXxPecNqvJZi+CALDrI6DvWpGyAVHgPkmEHw2fgO0bFJuJN?=
 =?us-ascii?Q?S3zRGCpu4YCQBm+0uwRV82NnaSlt87H0XK0+PcHsA1srArqUjyRqyg0RRPnj?=
 =?us-ascii?Q?u6JTEj3UCJkKw6xSU0H9pVpJJlXw+ZVSXNsSjGyvFwAQA26T8vuTPlaHN/CY?=
 =?us-ascii?Q?v/gGJaz/l6OuZ/9jzS20q4R+GNcxJM3UDSTUiaS918AcCVYPk+MmZU5MLm2h?=
 =?us-ascii?Q?x1Lnbw7LKuEZHlcX4L0VCdlk+i1joNcWOzJDdMYCKb1MUMXziCluag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k/h5y3dOEMXVG+/8FJidzgxwVkOPGiY4rsBSlJKNFz9AbloLXn7gh2dT1MSW?=
 =?us-ascii?Q?dW/jIjuAA8aEiOZgjHhdLEgpRBD2a/f4p580zaazBQ1rt0wdKMUFBd0jKvnr?=
 =?us-ascii?Q?MgDAaCTI0aRMoWaTnpN2ZgKO7NGZg2QocrO0/g9+hGupbQs0ynPssB2sYpB/?=
 =?us-ascii?Q?nzuxzaX/Sxu5UTjQbtWLn4tXfyHaPJGaPSw2N4lzCvLBw5gTabnjv2XXGwjA?=
 =?us-ascii?Q?CkYnVRKZCGgZrrgdSLkG05P6hU4Ta+uflOhTFXjgVfTpDnl/KZwpxFCW+F+n?=
 =?us-ascii?Q?LT+wrWPSBTfygipNGHzQdca8tP7vCtDML9yg34a/fQq03NXNs91uyvhqV9tb?=
 =?us-ascii?Q?NNz9p96WT+sBRW56WKQfNunGDc4rwNlpO+v6CvNxdw2kMfw5g9Grcs+U2dIC?=
 =?us-ascii?Q?EjV2mQUCN7qTiBuMsVs5hV1W8TqSCd2W6APFs9aoTC91fccZIzuyNEHjWctt?=
 =?us-ascii?Q?Mo1WysE95q19S8gf1wb+SdI0xhwOLTOLA89LQAdb+0n0zK5Ilku2SH/j12z8?=
 =?us-ascii?Q?8zO/ER8WEi0oOrv7H/Fgp4ybkyCJqm0vWuuC79qGtG0F1owxVOS202UI1gvw?=
 =?us-ascii?Q?3GI5cED5LfkrGKiwlAA3xxdeiIXe4FNOxfN6Mue2xsPJP/aKFGGb4jNW/bip?=
 =?us-ascii?Q?SROG5HwFqyp8ExpJmcEjXuh3yAmSyBwyHwBviCZdh+zmy4lhQm7/psq7fvN0?=
 =?us-ascii?Q?Cop9TTTRBOPY4kcSvcqBSeuUALMzfVTdXxDzgATLaJX8e+Yik6ENx+eHmO5E?=
 =?us-ascii?Q?JJ9KZ98LX7pKdqidKreNmsbrbEbt2ux+74XPpIjKlxTl+ZzGxs2W0Ve/mkW5?=
 =?us-ascii?Q?HXKrcrV9I6v6Lh3A+9eQGD1nV9fZS2NxF+boW1MlGHd5fGOtQR5Y3tPfCY+o?=
 =?us-ascii?Q?8T4ZlXMS9L+EezmgbzQq5LwhFMgECgi8fr5Lj2O/gClNx5v5VGWjqQRxdJ8Y?=
 =?us-ascii?Q?eMcn3wzxp75RcH9FXEDScbzdyU4O6lBV0y4+wtIlHm1xYuH/vF/qulRTLlu5?=
 =?us-ascii?Q?auSk3sAPH6e0BQ7kXHK1LVsV47EJ+tlPobFXGP4OdaeHvCOeKA649aAxQFpt?=
 =?us-ascii?Q?N+oHItlPUpJ8YupPfFeJfYk50niApkybg0DWbfOkvgvm0xG0ceYIrEbZFYpR?=
 =?us-ascii?Q?uJQWc4GNhnCbtn4gRcY/BQZVRGHq7C5GaTaxi7MP/LflQ9Tp5ztCfa8yKZEY?=
 =?us-ascii?Q?P78IpccXhS9MGYn23gAX8lS+jAI5vNTqdXcHDP1wyeKwwW7OeZuriN27yz5Y?=
 =?us-ascii?Q?bgh01wXmvQVrUxX7KNMTDowRVEkf/q6gMZBKTAxgomaSJHQOEFvaY2yIPSWB?=
 =?us-ascii?Q?szRHzRhv1z8wQhP0ZA5WcOVK9kTSSebaAj3O/DoxkuYBc9oU2R6ebAV2QcvT?=
 =?us-ascii?Q?YdQOXBoiEAMJPw8SpE0X84elstY+FZRjyXeApcCvE9NdDFzSukW7HRiC3hsx?=
 =?us-ascii?Q?r8QxIMfIMNbTidB8BZ/uPuwL/1IUUDfrKqBzaPqC9DkLqMUnMDbCnehbhKAG?=
 =?us-ascii?Q?w9KKAlMSOevWmY1/EP/dQpdT9njWn83d5cizWjkZlKO0qlDb0RPgUG7MIxZk?=
 =?us-ascii?Q?P59b+Ye0eCsRZbCxKhjNyGLYIzIrjQblLD7I6XzC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89832ba-3e82-420e-0093-08dd7e93a15d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:11:09.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LTJI1xp6XJSB7F86/8AeADyCxDlW35HpsNEo9X3xrMbXiSgd7av9YugHrf6LH5q1SyUPxIja5dK40b0ARG7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

The down/up SRCU reader testing uses an hrtimer handler to exit the SRCU
read-side critical section.  This might be delayed, and if delayed for
too long, it can prevent the rcutorture run from completing.  This commit
therefore complains if the hrtimer handler is delayed for more than
ten seconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ea40f3ad32dc..d2728e95a69b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2438,6 +2438,7 @@ rcu_torture_reader(void *arg)
 struct rcu_torture_one_read_state_updown {
 	struct hrtimer rtorsu_hrt;
 	bool rtorsu_inuse;
+	unsigned long rtorsu_j;
 	struct torture_random_state rtorsu_trs;
 	struct rcu_torture_one_read_state rtorsu_rtors;
 };
@@ -2522,6 +2523,7 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 		schedule_timeout_idle(HZ);
 		return;
 	}
+	rtorsup->rtorsu_j = jiffies;
 	smp_store_release(&rtorsup->rtorsu_inuse, true);
 	t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
 	if (t < 10 * 1000)
@@ -2544,8 +2546,10 @@ rcu_torture_updown(void *arg)
 		for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
 			if (torture_must_stop())
 				break;
-			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
+			if (smp_load_acquire(&rtorsup->rtorsu_inuse)) {
+				WARN_ON_ONCE(time_after(jiffies, rtorsup->rtorsu_j + 10 * HZ));
 				continue;
+			}
 			rcu_torture_updown_one(rtorsup);
 		}
 		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
-- 
2.43.0


Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142E22A4FC;
	Fri, 23 Jan 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181604; cv=fail; b=jCkJUd4oQlS/YkNPIC8bp+Lytp8nXE+1krnAfo4jPRyhGXZGaPH8UtsZ2VIsDJrOr1hxONwUDle0REl4gVZbAxZoWa8/HcsjYD5rh1j3vRSJjsrSX1zR2vFOMxL9AnKX6ZwW84EDXA9dtcE9bqWbWM/hxacwHiHlhkbht34dQAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181604; c=relaxed/simple;
	bh=zaCpDx4G6ulk15+wtV9nAPv/MYOnZd8av08c9mzpJOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mvRJrqyNdNj7h3HxbF7xKCgpjZkXBR2FbYn7j022FVWxvfUenb2j8BiQhkR/8jsZL2jh8VLSK0ALilsGcCyaIP5JgC0grJ8CiGrLk3yuuEYZnmqUgnXbl/lRWEOEvuxjbldUQEVkLYfThObSEUo1yAcqdZQ54OaKMbO9cjYF9MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XYL975/9; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XYL975/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MApo/FQ72jznwCyi/L7S8XrB0sFysCyVwvp9o/LtoGDsQuUZ7jfZW3yZjiMaTzUbQRZuedLlDjhBjHcQSBcty/sfwb3j2WIjywd1zbCshhkf5Hgho7LbWlxeaOXGYKtjYzgGFXN6ftIoG7vt2ZceDnIxQjgY7I4baXiwFFBE8cAoT9sRhHN9J/5JsHvalKpWWe0TgaE8kgVfukSZKTIJApQM+UJuhOZPi1ZTyxmA+TamxozSOkxVyg+jwaAwC8iI5Ki2ntbkySTrpznci/4sQWDmmZLhxOrMFzxXeEpYqCYsOhyld5vGcsR4Viay+Mf3fYBYNCdSLoKivUHazBxRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UxD9amRro51Dr18WHYaMQth3BCK7JdwX8CHXe3kEQo=;
 b=VtM69gwqE2JTWXnTd7js1x4lSG8xySxo31sMAvn5ME8ku85XMv7f6ohV1Yz+fOwLl+QQNxBnq+Jlr+tigQfUpBshQqOpxH3b5+MYhaWkdU/vUoxXJuYQptYcV1nyu1ldH6IMrpCVWdVl42qrz8YFIy3MD7V5xtBRnhc3BBlCQQiHED3a6dfFIz/8RihYCQVHoOAPw9eOwStY3MM7sHewxHxXf/E02UlDhZJ2iSgOsVxjmAWTVDdfGPiu1oR/jOpPaVBx61CqQSJbSZk4DxHOeFvJu9RSfLQ1Rwgy5p/shmNYJf8x4Bw06a2sdLNXCwoGCx13R7HO+lcyVdkGZGhRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UxD9amRro51Dr18WHYaMQth3BCK7JdwX8CHXe3kEQo=;
 b=XYL975/9Mwo9mCKq3HHlyZbTOr4TLqVvlYT164IEjfkN7cuJ3J9dMJ9kTvFfd89LLtfhUv6SwYjj+6zrv6D2/mhkmnokTPk5krG8qLJQtutDd5LBJx+mtr86H0HIPU0hy9yfGOeZsuLBZ7X7FAjK3Qu1jgxvVZxhAZRfP6g4JZyCLvxdhSWI5mGXok/Xy3QKiJ1RXi6QmNsX8UHipcW80+uv8EXGG1gSu93wYhsfC7Kl8ErV1kkSom0Qv1TAttIvgCS2qasjR6B6sCeR7sZ81QoNuxhrXHUtfbxFlG3drGIBM/P8uH+1I+/dDQ2yJMxzvDNoXtd0GnxlC+NMyu5arg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 15:19:50 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 15:19:50 +0000
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
Subject: [PATCH -next v4 1/3] rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
Date: Fri, 23 Jan 2026 10:19:42 -0500
Message-Id: <20260123151944.732328-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123151944.732328-1-joelagnelf@nvidia.com>
References: <20260123151944.732328-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:52c::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2af01f-89bb-4625-994d-08de5a92da16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3RKgQ6mAyX2d8ABnTVvW54K7FYQj3SQboaqrqjs9JvCfsEP2Uvb4JzKZwk0T?=
 =?us-ascii?Q?2YmQldjdgcEf0YnRSADQ2JgGB0LP+sW4T12oVndQaVHoSHoS3zMH+ZQKxHqX?=
 =?us-ascii?Q?RqdBEUI8/qxRt1vDmI2+vaMXMBYwjiRGxpLvB26ZrU+0MrsxWNTtRITvzvOg?=
 =?us-ascii?Q?DZm1ITtz5HjFoHg7FnShOGypKY96sJTApShYlRmvnK2ziT+1yEBBF21swbNh?=
 =?us-ascii?Q?3ZP1pRyVVsS8yIq6jwHs4no7riV3IyDJ6SWVQoBL6BJbaxlqMyIXxAS5hkbZ?=
 =?us-ascii?Q?YjMJiLE549ubpfzo37R8uaW0IQ2j+2xeO7Q7pwriSTtu39rQ/rceLuuVzwdI?=
 =?us-ascii?Q?feHwPimPYu7/6n6aMzO2KAq6olI4NtZBPZojGYfKSc7idphgct6tC6wC91Hw?=
 =?us-ascii?Q?daO2obnY+u3J3tJbtwyCplWG+tMBzJ9HyIm10wiBtvKJoLXYU+u0efw/zqWL?=
 =?us-ascii?Q?uIJJ2++mN95CGkFI4XJBjSfrrcOsj5iTbUwJn4pRpxdWCkdGiUrpbPdK68MJ?=
 =?us-ascii?Q?h+Nc6CNqdpxkNnOAZVuMXsav45rQxjhbSjPYV365coL/HIXCUuuCRI85+Stq?=
 =?us-ascii?Q?rdPwchmeOiZluULwJZ9br/VvjxnOsr/oADjewzLGJOXNwsuTotDPVgMYpm7+?=
 =?us-ascii?Q?q0qiUXsLqesSHAPQOEbKNVkSMq3PUZ2d+ag/H6kF4uS+FHjC9ltl3mRNbMjb?=
 =?us-ascii?Q?Hv9WY9F2vQZIOCHrrdjlpJrKpA0WOZ1+P41Rp8ioARQiZx1AXiRbJ5+u9M+5?=
 =?us-ascii?Q?Y6YboO4mqgnzywUmtzdkkq47/bR/Rl1N8Y9VRMJCwRyuQhJ2fCz4D4S+3H+E?=
 =?us-ascii?Q?44KCDLH3McmSEXXWU2eK9SAoD0PvEzgNQvuUZAuKDfeunWFSN8244f1M3Cg2?=
 =?us-ascii?Q?0qeezaYYi2x2qBcyn5EuBcqdKSoL3RxX5sKTAp4uoNGe3KLNHN7BtnSwQ9t5?=
 =?us-ascii?Q?jZUzmxZGbgjs+Hz+T9IOT3iCY+zS0qdB/chs0EMK46uEnv/357+wm6BKI/Ju?=
 =?us-ascii?Q?/FP32KHwEjbPR7IIj+n6hFLuD4X2RFJ1IZpUzkYDBeaR83XNblLRnJkbOc/K?=
 =?us-ascii?Q?1fYIWH/ckhuYZtS3+9CxIqCD1EaKY0514p5nybKnByJMeaYLJ6fpsO7QgZZE?=
 =?us-ascii?Q?eH5aixEDqZEKqNoVaoUIAMcaluOFSLgE+V/GrAZRLXgGAQMGY/+DYDKoz8o+?=
 =?us-ascii?Q?CwG6fKP5VM7GM4zh1vWaYRHsrmHArFsqMkSuoZmK9kmaBKcS6UsnthtNxgo7?=
 =?us-ascii?Q?fznpyQWT30hPuStRERw3gBZZsrZIZ5k81HUGLhq9q+DAf2MEWHSr5tVL0ZBR?=
 =?us-ascii?Q?2FgTBgoGwfh+Q4Bq8di5LC7QGCPO6kTjIPcLGCRKm6uyVM5kLJ53G/Y+Ptvq?=
 =?us-ascii?Q?/s3ZDR5koeo+BRx/T6Q2+J4aUY/p9p5Suw1uQZrMuqYbzBLYeOK2OzIngloP?=
 =?us-ascii?Q?a7tOQBw4KYoeagiBexCfwqkYhaXJ6N6D8+xGB8Wrad+LBh8vSJRcIX/JK1r9?=
 =?us-ascii?Q?i7+O/eh+ExDIYhWmvsOLD9xC6K+fF3bVNczUbQkfxmOVurF1zDBcqWUTe8D/?=
 =?us-ascii?Q?LW5bMQi/zhM9tpi6COQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a/WYQXVMXBXU/c+xQyxRvEXfcLZZ93sgmK4lkEYbQgG5INQ2QwdrN5eUgqFX?=
 =?us-ascii?Q?wb1gAX6iK7E/iykus0qf9rBgF74sTY1ntBEXg+M+V8QW6il/LzsddirDp+y9?=
 =?us-ascii?Q?2PBjpPfOheTCfdLzGupVcV+VYMNo8IH1wO3uwuzTdgEN8tHsZGaB5bnxMGQR?=
 =?us-ascii?Q?mLmkXLf2/dyNIu2XmrHPy0x14NUgJRs+OMIoGcQp6F6EQo50Hd/nLEz0IdGQ?=
 =?us-ascii?Q?ae2VfcsZrT9Sn5YcHuHThPXNVa9KdN6GerukeM7fPPNbsGQsXZqqo0Lwi4Mg?=
 =?us-ascii?Q?qRMEWboM7PnDU81anTP3HCVJL+uBpWw9c7Tj3Gofs0EF197kJmosYBajAM98?=
 =?us-ascii?Q?ZIe0PvUkICE7w7SA69v8RM/Y+rRv4XEm13RlcXpfdDgVHoZ8Xjwb1uOugc5j?=
 =?us-ascii?Q?TQpWfYKb3yh/RAcD+ytTKv79TfvKSSfl3TDXS9CUYVo+KFz9pW2hfIYPGoV6?=
 =?us-ascii?Q?83DfISuVKs0J/z+BGM4cignQ5+kjCKdLXB5lRsVod26ToIIoKyFAOYNBKzM4?=
 =?us-ascii?Q?2CzobCz2x3qPTOXhqE9E4Fd3NVhg4Jaap17qpoMQAOZXq5grDSqkrKsYiKcu?=
 =?us-ascii?Q?oawkohw9BUhxcJOQrtQBYs4EEyTBnGMXg++AhuHL57CMtoYYEaQc3wSwZdEm?=
 =?us-ascii?Q?0iDmCzb8tEERKL6pbwYnx41U3s2kMA06TB+eVKatH8ve8JPGllWV2sgBKyvg?=
 =?us-ascii?Q?hBIVeqfCojJAOfAeM4KOOCGijS2odxUZCBk2l23GSx5c6Gg5PaDTe1/P58qc?=
 =?us-ascii?Q?WNz5V373/BEu+elj8SO/OWTGHir0jOlv+IxelA/LYSrNY6X5Pd9OXr/Z+0R9?=
 =?us-ascii?Q?Mall0VyKFSkVpRUVEZ19rXGyguNrUst1pzX7osRaxyRQ4rD+c3BwL3tLZkQC?=
 =?us-ascii?Q?5MmXyNITBfHQCiiSdt/ZyJTwKTz9C+IXg3VGfekCA+CMz1vVDDoZYrRpVb1b?=
 =?us-ascii?Q?TNrnT8PayajGPJ7EV3GOp3/ZTzdMTzvBH4IideUjOsCou/SCBhVUZeZhvW/h?=
 =?us-ascii?Q?mSHz0XZp/TUBbCAmwux9FvMhIBfJf45E8DGdYy5FQTQPHxyTS25akHr723zV?=
 =?us-ascii?Q?+K7Adi7VbNHLjCmnXyMPuyfMAfD6ICftN+iuFsRJPX/NHzUeAiRlWb5oZXbc?=
 =?us-ascii?Q?kXUmhqEqLkAgxeSaYwbMzJvcsVZvo6Ge6j2O+Va0imMIcYJiB3fPV6Cc91fy?=
 =?us-ascii?Q?9CbRge3BUXI8sDmhVvgmwrubt7j/2QtvPpVPJ0jOF+lOqx4Cyo5O+Esk4SjJ?=
 =?us-ascii?Q?jukPoJS6F12d6itoNTxpH3yrEeYHW7cHcFNTwga/SYd92QA/nCs8KDS4ysHE?=
 =?us-ascii?Q?e7yYztSJeIKmsyaFiPh8AUg1q7xoEmUXrrfWKOKE0juVpF6sVL7q9MNmEq8h?=
 =?us-ascii?Q?lxnYzehS2hfmrZvgylND1hK3H1A0ImlbWSPzoWFHIWsGFcNOnbJUBtLSb+uA?=
 =?us-ascii?Q?7dJWsalShQrGtOayX0ItZMSpfY+/ks9R3/7AM0kqB5ktFqwMn+TI++yzOxRE?=
 =?us-ascii?Q?zucvHx0XIZsYTxDI4z+TFTJgcoUjOSzUzzqbuoTBlkHPlhOjMoz6Ja/SegdC?=
 =?us-ascii?Q?WwPWk8pyVDEvoHpsSHc2aJrpJPkjyBFbd393JaqDhcguHvg8Z4qzIwLxTaBx?=
 =?us-ascii?Q?qFPmi/rLyq8nKLNSC7SFGKC+42GZL8lZw+hQcfQo8nqYbDxy1Gqy+Yw4p76Y?=
 =?us-ascii?Q?7o1WAwVbTXqs0XnUfOIaQY/XaLYqgE47rNHo6NYoW9In01ZsdRsflsgBX7eN?=
 =?us-ascii?Q?dqITJiqJBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2af01f-89bb-4625-994d-08de5a92da16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:19:50.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhFhsjsmsLg8ghptTsFJ9VeT4zoOd5uot2It22fTnFImW441sOnJoBdId7k0bRiYv2c8yYEqVyciaivi9lrxzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217

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

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      |  2 +-
 kernel/rcu/tree.h      |  3 +--
 kernel/rcu/tree_nocb.h | 49 ++++++++++++++----------------------------
 3 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4..2921ffb19939 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3769,7 +3769,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	}
 	rcu_nocb_unlock(rdp);
 	if (wake_nocb)
-		wake_nocb_gp(rdp, false);
+		wake_nocb_gp(rdp);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2265b9c2906e..7dfc57e9adb1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -301,7 +301,6 @@ struct rcu_data {
 #define RCU_NOCB_WAKE_BYPASS	1
 #define RCU_NOCB_WAKE_LAZY	2
 #define RCU_NOCB_WAKE		3
-#define RCU_NOCB_WAKE_FORCE	4
 
 #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
 					/* For jiffies_till_first_fqs and */
@@ -500,7 +499,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
+static bool wake_nocb_gp(struct rcu_data *rdp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e6cd56603cad..f525e4f7985b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -192,7 +192,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 
 static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 			   struct rcu_data *rdp,
-			   bool force, unsigned long flags)
+			   unsigned long flags)
 	__releases(rdp_gp->nocb_gp_lock)
 {
 	bool needwake = false;
@@ -209,7 +209,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 		timer_delete(&rdp_gp->nocb_timer);
 	}
 
-	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
+	if (READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
 		needwake = true;
 	}
@@ -225,13 +225,13 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 /*
  * Kick the GP kthread for this NOCB group.
  */
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
-	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
+	return __wake_nocb_gp(rdp_gp, rdp, flags);
 }
 
 #ifdef CONFIG_RCU_LAZY
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
-			wake_nocb_gp(rdp, false);
+			wake_nocb_gp(rdp);
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
+	ret = __wake_nocb_gp(rdp_gp, rdp, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 
 	return ret;
@@ -991,7 +975,6 @@ static void do_nocb_deferred_wakeup_timer(struct timer_list *t)
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
 
 	raw_spin_lock_irqsave(&rdp->nocb_gp_lock, flags);
-	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
 	do_nocb_deferred_wakeup_common(rdp, rdp, RCU_NOCB_WAKE_BYPASS, flags);
 }
 
@@ -1272,7 +1255,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		}
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
-		wake_nocb_gp(rdp, false);
+		wake_nocb_gp(rdp);
 		sc->nr_to_scan -= _count;
 		count += _count;
 		if (sc->nr_to_scan <= 0)
@@ -1657,7 +1640,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	return false;
 }
-- 
2.34.1


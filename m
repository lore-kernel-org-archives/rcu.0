Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A23AC0F4;
	Tue, 16 Jun 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648809; cv=fail; b=oCnCAdvo1HVBi7N1arzhgI1kZTnLeNgWiSD4b3Y+MP1jhE2YlXC2WkFE8fdfJyjLxIhPbZv4oZRN1Pcym0aB/7Oja3kD8hNJREs1nrtz2fqYB0bKN4hz+ZeCaqub3pEBAXJS0IV64WiT/SRABFjEwKVaZEAmk2BB0psIFcL3OYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648809; c=relaxed/simple;
	bh=3G23MgUr0ITjJpdC3gwqHgbujwXiWlJ1AjALycwX8AA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bOC1Jwhs60f4dEJLaddmoQuiGOn2HVB0HWyDEBtCAy1AG5uWCsDbSz5UaxcI81iG73l/wioPqTSTsGEreT63UR+koEpasZZ69wFvcCpzZyEXRq7x3gendw9eImyaw7fw5CyB0uNyeGOLcUyJ037mt8A5HHfhSzdWGgx/rxYlxEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSkKxDpG; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSkKxDpG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VG/b+LzLIgUP1zRYtgzqH6lPmvfIIhSLzYPrXbcqIoqbSydNFjkvEe956+30ZDT8Ry7dogMfdtva2ZF9PwzfEMwv8xmT63pHQnbZF2quW0JVt8XuUwGE0avmaxzvcOITY3QbHEtSfzHIgkhRHdu6E4gB+rVuFNyz9DWY/4xNrZvYvnF5NcHnJsDJVNZ/b4LYOZbOQj/odDWLHgnaz9gwZaZwteScRhAccASPTkH+yCyd/wkEhw5vA7WaejBGrJ8//op6K5GcSG7M6Yua1gRrcefZAct7fjoR3uRV04JLGknMYUh8o1QSdVkS2s2lDpW5trksU4c5aDTzVTHxbNjezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2LcGQUyFOiE4grq5fgOCEtiCNZ/4gGKf348JIWKVmQ=;
 b=YCDVlYiaRSwckFblqvZngAzEVXoyNiJuw+kB3xIEXdimSPl73xVLlIKX9xf5MOKl8fPmCebahZnJC15v9xSeMVCTC6RITmq3jXDIpszo7P1nBDVl45krCaiswJtcuoJwWd/OwfJXRBZIctgcmA2NNVKS2ngbUjPpMm/9sW6jUZnxWhnclZcCI/cmLE1kmx+6k+JW52WbEvnJNpUMQsXuupQT3+Eon6DNGxDjAmUIvtwmLPOJM8PzK8JOH50q5j+6bMsNZsPCyDXPVJ8zQJwiJw1KsUuzn8L5/yk6zVX3B5ONxNDbVk7MtDQVGxBGpk7+hXLXbNQ2GwixeMFj6fJv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2LcGQUyFOiE4grq5fgOCEtiCNZ/4gGKf348JIWKVmQ=;
 b=TSkKxDpGstW3bk6D0tLER0ytGxk5/h1BG7Q4b2Lm5/rI2zjy2Yw9UlhFcGMSLxhyL3jld0KGit798pAlhRwTWtMr1RM6KxVOTgBATbUQ6NTnWGtHZSszgFarUpg5bbsKUniws+Xmm3FHEr3mahsq8EBOgCou55AIBn4x5/hU1dRdjkGRh5rNmQUqCqzZDgKdGt4civLZlxG3pNzPzZSlxk3K2S+GlHzoSyvbgTvkcD70Pcxz2vXQqbvUoctPyEEtbP6B0HNTsC044+iLRpUJRBmF8Ot6ltdbMCoUjOXGFbfoj1htD2MzPZPcDxfrgBy4qm3bsb62khSOUDYwA3j4ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 16 Jun
 2026 22:26:32 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 22:26:32 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: [PATCH RFC v1 5/5] rcutorture: give async deboost mechanisms up to 500us before WARN
Date: Tue, 16 Jun 2026 18:26:22 -0400
Message-Id: <20260616222622.2981876-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616222622.2981876-1-joelagnelf@nvidia.com>
References: <20260616222622.2981876-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::32) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef96980-8ddd-4e4c-0a02-08decbf65164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Q1xb43wy3rfbAC0U7bfnTu6m9uZlIt+TFQuW0/EMDzWj9Np9/z1kYW6cbTO0sP0OjNbPcLn9AFx99VvXJRiJs9ujSGrTsyYGHj0S/xrbt8HZz/FLLAf+f9iaMzr10iJefKeMFPfBBxoK5RW2gqLju7ioEQCl7FJX6Fye36YK2HqvWb5krT5nxBDABn1KDVwmcXIg2Rqmt0FS85TfCzqBeq5APjpVDfSwdW0OlTvWVFeX5ww4WCdGe5Mti7Ocj7EyRqg5WV21mRIoDdvteHC8q5XGGNvDUHwVP89NjMkb3j7qYd62QwuroDeJDdCm3DjXTNLVZRJNdbXe/fQa1IzblEKlnWydp0rn7r3Ybo5VlLgR/vcu2Co8IBM9Ato3i+rYiQPOCJz0FraPf3ih5qpZyEC0FceBEWziGqma6zIgtUKBfc7jqMG+2yKbxGG5lGKKRwSjKm0zDbND9utOgAtG3UVUYW0zWBbHjp80rM+OZ27LxjP9Inv6lqt5RXbUcxaF6D1V+nqxWGvf1X1nrxhT7A9e2VuenEtM9zLiPfPQ7GCV2KpjV1XRtUdAEnSit686QPmWdlFEcm8EFsTOyJEADlupQerEpY25giIhKT+dPdM6OoWQd4UnW1fNk/lSApvbmiWHLNRkd18k4VJ0dcHMb3xyHP0EPCoqFsrRZlKzPLVvn5FErp90ATD+u2mMO7l1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yRtD7UtKHcsKSn+XDNUtT/jrskEyRRwHYRS0qGcSny979PF4G6NGuk2EowAj?=
 =?us-ascii?Q?c1uMKNdKVMo/e4wfpv8qBuQ4VMWrCrlxGyftcR55xJIbK+OEqppfIVTxaNtx?=
 =?us-ascii?Q?qhsdLYVXahBH5LfMOZxF1ZEvS4dPUvRl8NeW0hT4VYjrffBE3ROv3QFS5Ik/?=
 =?us-ascii?Q?j9QV8SSGW0q35jltXbimxKgcUjmaI1zZiNEzxaygykgDGZGIEpTrGI3zXoYV?=
 =?us-ascii?Q?V5o3lE54YmJGoQ/jQf3rUlva/PqttsPwgxoCL/tCgpygE42reZ53EMox84Is?=
 =?us-ascii?Q?cUKZfeQ8ECyaH/wy0TB2cJkqEEp7DjUaL/3Zm+dEVsKvMpZN+cDZ5QfSqvGV?=
 =?us-ascii?Q?5huNYRyH+K25fnOezaNa9STSiqq1g3XAmditfTWmVQSQ2QzayFYksYOuijlW?=
 =?us-ascii?Q?ed0Mt6+U3jaUByoVYP7oN84xZT/iD+2xjnbm+ONPzd+sTXlDvfhRabmnLi2K?=
 =?us-ascii?Q?xqMbftMaQxM3E8haJFRRkN63JRgZ78zqHKljI0YvUcBTc7AMLUpg5Bk8ezNY?=
 =?us-ascii?Q?XyGWkpFmR96EBcKW4p4O++FIuwA48J9Ir9eZGg8FYnOUGC41AAEMqZjV2RW0?=
 =?us-ascii?Q?DjIpgutukY9vG+7BoB/W7MeKIM21VgBGoHZ5ujHk5EZ6JNe7gvUjy8DLGVNb?=
 =?us-ascii?Q?MLXWR6nWpMmylKxrYnsPyhob/vvYUN4uABu/+OL3cJvC3xmcpRHCaMYMi/ZK?=
 =?us-ascii?Q?kcWMm3201c+xlDylebqFChfl9EzX6mEBDFSaryxgfZ3/8ZAf22lUvx1/6Kui?=
 =?us-ascii?Q?ZUbN49pigubf8fv7Ol8ARS5E5dxI2uNa6X6JDxb+T9bGtFJYPQeg/G++98aU?=
 =?us-ascii?Q?UjrZFUZsPsCPh3XROFaLee2jPK9Ar0lmfl/MKy8ipcSCQ2cPVHO9fk4MNJU5?=
 =?us-ascii?Q?lYjT6auP3anX3d9mqOLq55j57dw0R/btM/a6OjILmwMZVaPcdr+B7EeLM0Rd?=
 =?us-ascii?Q?PR5I8OLZOodfwnt848udabLuNmFrklW5yAPJAUsedV0vZncBV7a+m5aBRkq0?=
 =?us-ascii?Q?kxXVbtkFYQRz7yffydAFqlNAn1+FZiA63GShRHvOcxjIEPdPnopLfDytKPlO?=
 =?us-ascii?Q?EJp0bVt+dd+wftaAVG4wyTGfOL0phstgcDmmq7fhFpQ8uyVy0k+9kbl11f44?=
 =?us-ascii?Q?tvzVmc4iBzYS256SldtTIUMTXFUkW6KofuB7UnVek1GlPmCiMz+ZPduGT3DJ?=
 =?us-ascii?Q?9+GCHyTAPyf9BXKV8+m9EU3NAZn6zbK7ixUtr1d+iX2V/CYpgp0EtIQaO4b1?=
 =?us-ascii?Q?gSn9B+P2d8iqRHv/S1h5yEiI2wz/o+S+iHEsg3tc4Mgd+4hCRMxHi0qRBWRK?=
 =?us-ascii?Q?cYGRjcm7s8LwIwoO6DNwnceP10G92FFntXRvLsQbVNENjNp+h7+zZXdVHsEN?=
 =?us-ascii?Q?CGm6VLHLtflWrZ2EQh++nPlxinFfwP+mdZzlKX/GodGthKPJoO4pmFSNBfB+?=
 =?us-ascii?Q?Lllhj2nV6B6hKMDBT4aZSUXIjwet0nGnWRgSnGLSIx3eGzMlLEk04WGR/fcF?=
 =?us-ascii?Q?/tPgpn6TjDmDxEG8ymW1fMn6VxZReQQNe3G5OR/NbVM/2+EAaOt2RagXwrCw?=
 =?us-ascii?Q?d2QpaQ7POG27KCMe1Fd6nuX0wpytLdzJyNLX4H5t2Pej+EcwZEun7ms3sRt4?=
 =?us-ascii?Q?LXHl37MJ3Qm0J7qEyfaFbakLGcrrmKW6cbXHl6llyTunmpadwFHGb1YSZGKn?=
 =?us-ascii?Q?OYkEYUpizjs7JWxASL1Oivh5lwJevpJG+Q1Gxak1Pb4yu6XX7KB7xdm+5L6j?=
 =?us-ascii?Q?Z1yXy8VLBQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef96980-8ddd-4e4c-0a02-08decbf65164
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 22:26:32.3965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxs1jlkGyTmqCz09muU/IhSqgmsv94SD2f8dHmWTqVRV3eDCJkLhJy7G44LIcX2k4xkSgItBIenvY76OpvNN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

The Slow-deboost detector in rcu_torture_one_read() checks for a still-
boosted task immediately after the outer rcu_read_unlock() returns.
Sub-microsecond checking is unrealistic for any async deboost mechanism
(irq_work, softirq dispatch).  As, even with a delay in deboosting of
just 50us, the check beats  it.

Therefore, poll the boost state for up to 500us before declaring the
deboost tardy.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e0bea4039c42..12813b5381d6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2601,15 +2601,26 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	// of arch_irq_work_raise()).  On such systems, RCU cannot
 	// guarantee to immediately deboost RCU readers when the outermost
 	// rcu_read_unlock() does not end the full segmented RCU read-side
-	// critical section.
-	if (WARN_ON_ONCE(cur_ops->is_task_rcu_boosted && cur_ops->is_task_rcu_boosted() &&
-			 preempt_count() == 0 && !irqs_disabled() &&
-			 rcu_preempt_depth() == 0) &&
-	    READ_ONCE(firsttime) && xchg(&firsttime, 0)) {
-		nsegs = rtors.rtrsp - rtors.rtseg;
-		nsegs = clamp_val(nsegs, 0, RCUTORTURE_RDR_MAX_SEGS);
-		pr_alert("Slow-deboost rcutorture reader segments:\n");
-		rcu_torture_dump_read_segs(rtors.rtseg, nsegs);
+	// critical section.  Allow up to 500us for an async deboost
+	// mechanism (e.g. irq work, timers etc) to fire before
+	// declaring the deboost tardy.
+	if (cur_ops->is_task_rcu_boosted && cur_ops->is_task_rcu_boosted() &&
+	    preempt_count() == 0 && !irqs_disabled() &&
+	    rcu_preempt_depth() == 0) {
+		int wait_us;
+
+		for (wait_us = 0; wait_us < 500; wait_us += 10) {
+			udelay(10);
+			if (!cur_ops->is_task_rcu_boosted())
+				break;
+		}
+		if (WARN_ON_ONCE(cur_ops->is_task_rcu_boosted()) &&
+		    READ_ONCE(firsttime) && xchg(&firsttime, 0)) {
+			nsegs = rtors.rtrsp - rtors.rtseg;
+			nsegs = clamp_val(nsegs, 0, RCUTORTURE_RDR_MAX_SEGS);
+			pr_alert("Slow-deboost rcutorture reader segments:\n");
+			rcu_torture_dump_read_segs(rtors.rtseg, nsegs);
+		}
 	}
 	return true;
 }
-- 
2.34.1


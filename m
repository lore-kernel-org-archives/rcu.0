Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806267;
	b=Uo+3z7QLWCBeREZla5Ji3vl6uVGan162KjQDvvTsO30zD5JPI9f2ax/taxWjPjjO63BT
	 CUPiDKzdQd7vUT3ipWP7dea+6FgYeSeJ6rHCectbORHzh4hdlq04ElQLzqDjgPsDP+CBJ
	 FXxn3gG4yyqleEg05/U/pTapyZfltIOdLN1vZWXsDIi9wEDHhQPNS6gZms92tIVtVUySJ
	 x+ge5t/0f1602gaNoke727m4LSHtJnS0rQIeoDRTeFEokQXzdG7BipLDAJ6haeHe7K9nR
	 dZEhBIHIFla/KNKG2zFee/jN3Jb0ejD8FweMWqkELo+hV/+bSY03+zCA6Pajx9Z/obA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806267;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JPW24ng8UI3RbdNi64b/B9P9J/O1MRC1nFw7CjGwRx8=;
	b=WI0Eepmk8b2C9FUtux4uC1KbJKlrt/EsmxPxG/hT5+ZHH+nJBHL6p20AbG1nWfEmmsx9
	 5stQBC5B7w62LuWYiCV5jmqlcaZYsPJ/bN39pkitFFnzlg8nXqHENYe7YlV7tnRMbQjLi
	 aMTHGUaGA7HYae8c5BxjPf6rL57lELJFzrZB9wFr5FbdwJFOGigUv307ujfRtqeHHTIC0
	 JgNDAa3wAloJAXBKqBamTlSu/UIHCrreDx8BF1WL0SrHDsw+BVYTqAx4XlM1sakxGRii/
	 89sGPBD39OfT7LIsLUpgtwEr7uTjsTZyXiFVonmdnuHBirIt1L1VVP2IVjEvvoDoXPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nw8hR26c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.9
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB85606A31B;
	Wed,  4 Nov 2026 15:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB85606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nw8hR26c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BINK4+/WVtyEAP16aoNjN9EXB/9kMK1I7MTVLyW+10kH3Gx6l4xWV1wFw/qmoTPP1GA3/IK1JA437yuLVRXMKvZuAlL04bh8g6/92v6tkrjWGCRMOEaLiA0SFww4ZEuR5PCZpVRxObtTYFwiipBt3yJjXzBXyBt3h4HaXqw4yh8HAL8gQWkgMrlOEFuwExwDOOtaymsseNUzm7xLJGwM2nkVBXxy0TDqP8Rf1NgA4k3y56ZQneMWgkou/b6+QBhHZvBdyIoxBkfamkOpHmW6oymxznYgjOBgtKsET+byR6oOMkal5L9mOBsuk4rf+13uriSN4YK5OWlxMwlnilo+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPW24ng8UI3RbdNi64b/B9P9J/O1MRC1nFw7CjGwRx8=;
 b=CKumEtz7DT+2PooJg46wH1Ix3YCQwAU5XEIuyMGNooHAThVeEfEE47OGsqnjaa3IUtBKp1Um/bNFzvLMfnqHsk5rQPgsdErzvitysn4AXsbVR2ufutsQj7j0grHfSj39X+usL8MaP4+j21LsdIyzfTbV7yGP8qtx81WrD1H0Qkk4k/00v26iOVbrvpOlXU9sRvLKxumYZwabusLeq8KVmRqz0cYSjuoA+BWvNJqDmoxR2zcKHM5BDdjQchFx8zFGEIkYeXyyq2qyARfTTZy+LUbzV4k4lca0lhgqSeXFLxkCTUGuQeT6VjF+G/2StVeSidzAa8CR2WtHD9qFPsLK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPW24ng8UI3RbdNi64b/B9P9J/O1MRC1nFw7CjGwRx8=;
 b=nw8hR26cbdd76ZAcZb86TIB1DJoDOvf3gyFKFqjdRkAyM/Nw3ZFCQNNnjHaptE/gpZIR+G5buiG2ugT6vuq0m0tHOoAEAIcLomaME6HQZiRmQS6pAvjAi0lsLck3kbgeMSQxwOhduAHXYybABhls8B384tMa2LjP8EHymFr2Gta8kCbnqz97F+RpBJd+2HxnTRZUbRJ7Iuj/NVE5wzvyMZ7MVrq/L3ghAtVPAwwZXGa+1rVodZRMYieWDU2ni0FmHSGgHqXWH789WCsi+/WsBfSoATBsDMSdYs71PRaZIDGkvH2IIDLW3oZyCdPGm1jOks3a++5VmJd68mouRDqpbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 15:31:01 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:31:01 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org
Subject: [PATCH] rcu-tasks: Track barrier callbacks in debugobjects
Date: Wed,  4 Nov 2026 10:30:45 -0500
Message-ID: <20261104153046.965890-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d09957d-5754-441c-abca-08df3a88a184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|10067099003|18002099003|921020|5023799004|11063799006|261022075727099003|261022105027099003|261026140227099003|261102123227099003|261028144727099003|261026121527099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	BK6+E77Qwvt7KTkRj/gxInx5W4mDTUoFW5Z16VQTgiRX3uuWZhQKM7FSKz8I274UotFsWQLV7/GkVEFd1O25V1vhE+nsdGh7Rc59IT1Y80E/TAm2ziyWZMWM9GB7ZeAC4P/XbNw7qHYvftnbWr3DTbJ0hM5meLEZCKtW07SuqZdBLNV9Tbn+q/D5U3PI7dlwb7Qhgg+oPNVbTW7C4q8ch+Cy5o6jIdfoJZphupqA1XWQBQePQzbrFsNgqjsxgZN7q0FIL3qDWgKf0/1udIwkAQqHTOUsrmHtR/Nm80l/As0DBJy3aueNPkrpKpHtF3n2+CBtPYR5idyKnYhJKujV9xh4uCTGP/r88CAxX+hmbBryA3WUROOA9nlpxOIPY3zeGKNjSklE90FnoO63kIbif/IXy6ojtaO7EEdg3blU0kNomG0/WOphiTjfnPJmq/spLigj2sFMMY61V6SWVEjIeCG5WhYXpj7Mqug4hxKcPxdUkcNjr1yI5JfKVtyU/GQ9Xi4PJwdmn898MOkIlufZIJmBWHjkVTbLbiHt4IaGCRCX5cRhcboiskonBPSLQrWQj13E6+X6TYcGQXG4tvl5+IGiM/49jMzOlajYzwai9Fdwy8OMyvYoQWDr3BowNJDjFSiNkXfE/w8YcpqRn+O+w/JrRvMLHoM7w+Cg57Cjrh2wx94/xskwwP30Z/+93v58Ku0TJbyutDSxK0oOhS3kJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(921020)(5023799004)(11063799006)(261022075727099003)(261022105027099003)(261026140227099003)(261102123227099003)(261028144727099003)(261026121527099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MYIRa6btLmQTfOZnOWIpsrWbyhc25CYGRRfXCJUki571/4xbkPgVv+O1w4os?=
 =?us-ascii?Q?8n2rOK9CQkN3bx6iH2HsuqLW73VTzyARn3CEedWu7+PuDNlxMlf/zsWGaVsv?=
 =?us-ascii?Q?VHJjBXmmLn5/wHUevf+M1JXRmPVYoFDPQ5GUivSqWWKildB16uYtAS3XzIsg?=
 =?us-ascii?Q?uPuDzM+r8h0GYdxhYSI2yXmdBR6kVwKbrf7oPwtdupgHvQGTBeF8UY7wqg44?=
 =?us-ascii?Q?+obaXpOLRZexOMC7EZrkyNoysNpYfv6pHJrluNDWHwPUzsmrAQJufps/WVTg?=
 =?us-ascii?Q?U0In5+aPzqHgTsLeocNl0fVqzdAhOfSA7LTp9pLbQyqhHfq2hY5YZYuwBNjD?=
 =?us-ascii?Q?JwlI81LTgEImLCTxHCxlmnyLsoeDVoiQG6y7RMCnW5LA53bP8tpUAY3qQJTI?=
 =?us-ascii?Q?EiYfqca/NQ5C5HGa06vI6wKcUTuaQkBNQ8/XAAlTStkI9RF2SWUOwvgbZ/5M?=
 =?us-ascii?Q?cVBCTE3/HIrcPvXQtmtexyY8cVxA8Jr4wC5vEyfV8gPr9HcefcAIOvoyqpPC?=
 =?us-ascii?Q?JOldQOK8NoNgnJ6mKU8XcuhStolt9ho22jt0vw0pkAnbA7w2JNa/hgWDlgzS?=
 =?us-ascii?Q?y9Zoy9E5o4BT3/L60y96pw0th5DzlNG0xO6nBSnpAe/p05G4OJ/APScZ/OZL?=
 =?us-ascii?Q?vD5dbVp/HNTxtp6UoSfz71XpjbARZiAHuR8XzcGQ+wbq0MH9oa7nEbp26n7S?=
 =?us-ascii?Q?AEF6du/ThzEcxk4yXKmwFyjUeFgR18OdOtaNRcQMdrEvl3IEzBf9Mvnrrq3Y?=
 =?us-ascii?Q?tudGdRDxIPlrRKT/TkAo139VRc5unmrAJ4eptmZC5iEoNMc6xh84+Cbtk/SJ?=
 =?us-ascii?Q?8sYkzBuBBcEsVqxG7LDlYUZ6AFTay7sJ6VwgUPlfzEKQrGqgZvwamD1h+3PO?=
 =?us-ascii?Q?Rmgn436KdrngNMRjKX7Yw0twbmTMmF8zXbRCd/KZxwuaSsabW9GS9foNHsOh?=
 =?us-ascii?Q?7x301wKm9fKmGnsltW2SwO5Eevi8Y3a7WH2naWNSwvWcwKUugm4yKWukXNC8?=
 =?us-ascii?Q?RzV0LTtZB3Qb4JNNU74575N58vvI31zKWCVkgKBKcaEvL9DDue6BUyerHuSR?=
 =?us-ascii?Q?ES81JvwnJFepNeSp/5Zb+3VKvekDLGZW8nL+yv8YUi23kz90bsL91DSweCem?=
 =?us-ascii?Q?TLyJB9z3ZCTg3PrI4co6PkKu+lUlqQZk33cc1CqImZqFUq/Ts+k22Gex7npS?=
 =?us-ascii?Q?HkBTgm1WDMWsn4BG2Pql60vQ/8UVBLS9sETk3/5/RDEChMhcJ6ZeuB5OTZ49?=
 =?us-ascii?Q?9JipjlsJcpSQbd46PEBg9ebLwLSv5mXKNuVoPx8zR3pEr0hZOTK0BV1GfVLa?=
 =?us-ascii?Q?FrQMV4ifjOEPnfoW48kVTu0srvd3XVKAfLCSVEBo6rWQkkNJ0fmZDdVpkl7X?=
 =?us-ascii?Q?ZltnTzajrDb3TLJ6AD5EAFujhBBJPupKyCDbAqnnm+Y8BNrCdVdrBwLabqOh?=
 =?us-ascii?Q?aj+8Sv2oLScFX+nCd/zOAYE69VUvLeM5//WU07+Hkk54MjutIvHmGEExq/Hn?=
 =?us-ascii?Q?xUPba8WjUh675LqdHrvSgkIEINObpW21RdDSLNu2wweW4aRJXi6wOg3huQTS?=
 =?us-ascii?Q?U0N4pVnDI0d8asabpz2f3ZTStOSWD4NdPyVKCvqA9WKNQ1ljHIsqE1qtIoKh?=
 =?us-ascii?Q?yhtUt200ltC3L8Mv1ZaCTqrO3Wircz4Xjz4QRJrmm4oF7F9SOUfQ+fc99Lx7?=
 =?us-ascii?Q?j84bkqL8OPCc9cnM38YDvli+ycrriC4fpLIUXkLIuJRvp0gGOHF7WzEhlBag?=
 =?us-ascii?Q?wGaZvL3hIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d09957d-5754-441c-abca-08df3a88a184
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:31:01.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvfJnIXvwhseNNqwTRPgQTQDbsnBF6nvav5vp/zz/+kQAZxk85K3E19nqab5wbDZx4DsPHjA8/O4STZYaHLLeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110

rcu_tasks_invoke_cbs() now unqueues each callback from debugobjects.
However, rcu_barrier_tasks_generic() inserts its per-CPU barrier heads
directly with rcu_segcblist_entrain(), bypassing the queue hook in
call_rcu_tasks_generic(). This produces active_state and deactivate
warnings for untracked objects when a barrier callback runs.

Activate each barrier head before entrainment and undo that activation
when there are no callbacks to entrain behind. Successful entrainment
is balanced by the invocation path, as for ordinary callbacks.

The existing n_barrier_cbs=2 torture test reproduces the warnings before
this change and completes without them afterwards.

This fixes patch "rcu-tasks: Detect duplicate callback enqueue".

Cc: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tasks.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5d060a5c4b6..a20db323612b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -470,9 +470,12 @@ static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 			break;
 		rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 		rtpcp->barrier_q_head.func = rcu_barrier_tasks_generic_cb;
+		debug_rcu_head_queue(&rtpcp->barrier_q_head);
 		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		if (rcu_segcblist_entrain(&rtpcp->cblist, &rtpcp->barrier_q_head))
 			atomic_inc(&rtp->barrier_q_count);
+		else
+			debug_rcu_head_unqueue(&rtpcp->barrier_q_head);
 		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	}
 	if (atomic_sub_and_test(2, &rtp->barrier_q_count))
-- 
2.54.0


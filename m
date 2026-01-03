Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221CB1F12F8;
	Sat,  3 Jan 2026 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399838; cv=fail; b=QeH6qJNDQigkniRPTB0do6l2tBIVt9spMKV4dLlw1MDTosHkPLraXi8LLno7cZsOnyOkJnhxgyK70Ln6y2KOu/W7aAu3tGJxQXXKJ8SBCa/iALA6tMWdWGmDNJWTravnZXR7j88XOQqygVUC3GKYoQjof78t0RVgyKxIYFTkC60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399838; c=relaxed/simple;
	bh=ExcAwuJ2csLNXiS13QHqPi/N+MxLxiKs+x9M5EunpfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dt8Teg67CxJymC6oVXy2LcOXsgTOwHfbldrRBJD0q9v1p9lpby7Gnj1BQ7xtehGyvX/bAH+WUgfkSm3IvOLeolzKyiHvNr16fklq9/eihYZsCVrbBDAFBjXt85u/W1RtWJPW/+x0U6bNpktG1Qb92fIaF0kEBqMR42f3wl7xlnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aYOqufjb; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aYOqufjb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ebb5JgUACX4+tXuPtZZtEsZekF3bFSszWtCZAqTesXD12vCQ0hCIw29g8edjcyrauv5NKdgnrCzGbp0/6mblQevahS0E26x/23gPSq602L/V97F0hPaZlXtjDgWFkhkQElaDbHOxrt06LVpsdrQRRCnwVqZzlNncgZUF1WtEqavD55XCKvQkrCLTwn7hnHsaUKssFsBzs9mqmURdvX9jp3+Nnat9tDrs1zu2xesyzhKXKVWAgq0iQDLHv0axXcFoGiKKdLTJ1rA2VBTg3DZGYQyogZd0X1fQjxmGk+o73ZnPnGCBcuIR4ZvU4c/Onjinr/1OwDfZxGAq2gZ8yu7TCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90vscRQZ/II7DHa0WnbCqijbVsbgy9+W9TxBcfWWipc=;
 b=tCd/Z0ykjLHhuXM1qwZJ87uz4Og9vhR3ulzQluqry1OxgOZubpdzmSItc5YUcYkPy4+8+HIIbCumfHwEjUl4d9YIBsWe50UWM/9y6Wt/EkYvauIZcA6nF6rn3fSTqb2/8HIg8oKUGp5tZUQCJx9f2MjanRf1Wq5UKgOUIWd74NbeZCWs3BXhyOx8g3enzNvAFzMFFa9vcDL+ezUDg0tVAcxCz4GmKJ6h5HSmhJEIn7R77vmcwMi45OiDo/wyTAljCeiazeqkEDaTaaAmcugDWtW+bGCSDN+JJx1SVHYfUGnWAtazRvz8s2//QrytYlthBxTdNOxDB6cTn+6Prki8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90vscRQZ/II7DHa0WnbCqijbVsbgy9+W9TxBcfWWipc=;
 b=aYOqufjbcwwWel7RjvArXlTwM7mZwVU7D5l9gM5ypgKdV6dVGp/kxGZ9HahECJr7Ye0p6r+jqeV4j4WlPYzkadYOBSRbysKz9QTRBXoT5mjpo7Vtg/0HQcO23Q2WU+1Nsu0MFOFycJ44xTKChN6Vg6zKBmQ7FGdt4JAIzreshyzIu6eObzg0LL72/ciAcENScDFbaESASUbA9HKs6gp+BFXgPHQrIsy7+gGGLivy0o0H832hPJqzi5Bqd20uvYrQ1uPpziqGL8fOm98wBoWhvZxGoePQpvW0m8Y7Q2jBLjLOUO54r5NFwa74TDNww/X/rmgYfsVIgwowTlDx+5bXyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:23:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:23:52 +0000
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
Subject: [PATCH RFC 01/14] rcu: Add WARN_ON_ONCE for blocked flag invariant in exit_rcu()
Date: Fri,  2 Jan 2026 19:23:30 -0500
Message-Id: <20260103002343.6599-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 2869a382-d6cf-4b0b-eb0f-08de4a5e5fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ElHraaGc1cCgAbcaEuTjkqzghLX/c5Hu0I1EbXNnHNmhy66Ml2bqjiMYhihU?=
 =?us-ascii?Q?2UczMflupsDzcEXvRnIeOOMllFStPizhVKg5BrMlUsmHaOQnc/D1ATIChNBQ?=
 =?us-ascii?Q?8EdxSeyGG3DG0bnd8wSxt8KVp5jYdcjKAKqX2N6m2K0LMWC4+3+AOkdhOsud?=
 =?us-ascii?Q?qgwnBaQFzXLnHNxZYfATPMXqxkcU2muzqMl9ipwIW6B4p/ZYU2bSn+azB4Ru?=
 =?us-ascii?Q?nT1JF8W8IA4D71K6tjihk4z2AIrwwNtgJFRHBQVDvzQcS+vCZsdVUsahCOwN?=
 =?us-ascii?Q?lzCtAI6xWn1dWMxbUIbomjOKai7F+D5c8WkswssgwZmBLTlUb5olKD7jZBhy?=
 =?us-ascii?Q?EL2iH8aj96x2oaByRLuM8hpR0qJDfDnb9Y/YZZoHrgLVyGAwphbOa1VCaH6H?=
 =?us-ascii?Q?P/pi9xTDtz+wdeIb0U5btNnOdUQuoUra/YRjQ9irAFdBY5rkazpFOVlUQy/n?=
 =?us-ascii?Q?h6CShsigJYoPMiEYPVBHnC+/e1tEThFBrJkxNTfZqj4pVW7QXyOJIs4qExe5?=
 =?us-ascii?Q?zbCHTI38Hxyr9I01udyw9bpidDlomDObJvougmYU4cMBtKtTx9Qu51ouA9f2?=
 =?us-ascii?Q?Jjo8J5HM9mdZ8iq3O+vCD0okm6OKGqbrUDZlueXL7UI4MG3biIPM6KFW19Jy?=
 =?us-ascii?Q?urCj8U6aqOuAAolFC1HrAPIh0kLi39EahGFR/oeA4j35aOpcgIZ05lWIWvAJ?=
 =?us-ascii?Q?XAdK2wA9dQ7jD0Z89oSBTFKnxfgvaJMMi9SzHu1PhWvYJTfk0xRrola2Dtax?=
 =?us-ascii?Q?6HTvCWtTmWpNpb1fcBAaP5PAfxjSVWZd4Zc88zLEE14sdX+F0iz5RTsxPe8V?=
 =?us-ascii?Q?riDrsMB0m1/4M+vn6h/8oxoVFmLHUjZep4dGXNl54sGUDpk5RBm0UCVnq+lS?=
 =?us-ascii?Q?NwlN8ybr6U9G+pxFoE3bLeLOuiSefeN+o1zm3lQDuMge7lkl/YSo999OYcun?=
 =?us-ascii?Q?MjBis/n5ac1uRHypOg1FIx4odgZAZPz42g2018RHcHaVj4AJOFK2ma5bZ5Hi?=
 =?us-ascii?Q?zuJpqmic6ptm7BsuCfLWgymM9wtynTtYqaCzU7Vbrr7RspioQk8ahK82MiPO?=
 =?us-ascii?Q?vpScLPgE/fNM0UJXBEbD/wsbZN3N7bH8K8D/RvQbPHGFsPPje06I5TqX/CGX?=
 =?us-ascii?Q?YKHcwqZuyUECiS/TT4hphIBCh4hpHuVK5erzH1rE2qbAvDGWiomBB/gjdYrR?=
 =?us-ascii?Q?AO/mb9dS816Mtf5YQw09YYTiim4/RYGhQJf64GHrFYE27LqDc8IXTeClEKDT?=
 =?us-ascii?Q?AXWIpysi9ajmYKcgxrdoy5F0cNnWcLMhhj7clz6jvvJY/HU3lcypbn1RobHO?=
 =?us-ascii?Q?7+j9mH8FLQPFAQF9CWjSl819stAfBCtrzA0zVcR9E8vEObtt0CMy+GZvOsGn?=
 =?us-ascii?Q?wc81NjA/rYwR/VfqRq5neX07H46cQczlAWIaJNb46sSfeDGRwcGJLz4BOM9E?=
 =?us-ascii?Q?6TFUyXsGQ1WQAXQyIb9+ZYFBuBSoSABH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QsjgvLbl4bLv87AjjKOq8LRAlC2gVgYbk5GU1a+e2iWk44sguIerCF2zzycj?=
 =?us-ascii?Q?pseWfyfo0e6NZGbz+tWcZ4OhbhxlWNgkQoihNlY4cHYtbNfJ1H9D+m03S/wp?=
 =?us-ascii?Q?lTQbwS3IuB8SEI9mdhCc1kQXqL3BueoQT0cCbZMs5upIq3ZenbIs2rXi/qFc?=
 =?us-ascii?Q?tERIlSrPvqY9n3bTFIazWljf7WtKojeT5sk3hJeKcr6eIEOE7htDhuikovm/?=
 =?us-ascii?Q?raK2FJ53umzC3TPRESg1G2jQy/YVwFIWQramCQYCaLBzTfu97POTUH8kL/Z+?=
 =?us-ascii?Q?bvBTl5PUGlhgul3qqe5lLKx1FxPhqZcoAspFldm5Ycmjbe1FLqHULWgYk5n7?=
 =?us-ascii?Q?arwImGiPW6R5LOysLh8/6rlUuPUq5O83YhOulJBVNlPVqC8H0gip5ZVVUgoE?=
 =?us-ascii?Q?WZE3tg12DfAenuj9r8MOAxCzrpZkWH3eQb84tSugWdYdiyR1F8MGIdej/f1O?=
 =?us-ascii?Q?rJ05+IAtaHAPS7qqIEMuJSz+L6Omz6Ps3UgBaBCpceaioZu/ZHAXqGu6yEIa?=
 =?us-ascii?Q?YpIL6ZsA0Te1nrtKkIBBj9oBrjzKemVlnUMYHiT4UlICdr2ko8VdoC2EQCL7?=
 =?us-ascii?Q?9LxKEI4UyDm4Iq2zB6YMWujRld4zOwFm3TPrTHW0apoXRmv9xSqCyan/3e+K?=
 =?us-ascii?Q?6d27y0zTtAhSeKe/myTlPQr7n6uhToqnq4xR00SX0jvjGudM3+c+EULToEsF?=
 =?us-ascii?Q?AVCRBZzaXhXiGTwG/CTI7Bt2d+E8CXGxXbWGUrDDYeaOCR4V555wtz5DlZKv?=
 =?us-ascii?Q?qDm2/iOLJfx9dr48HNbn0d3GTEj8uppxZQRiOpwiyqf1S2bytHsW9MdIulMn?=
 =?us-ascii?Q?xj/0JetIfMuQrvJggPFdcXAU+rpnd299i4keZedHP2+K/dvqmq3cmiT2ECPy?=
 =?us-ascii?Q?xRvGc98o5MzynTsKBJV1NmKTZR5T9qAHBx3sfoSZb+k6rUoPPQP2iBL2RXzg?=
 =?us-ascii?Q?DuS6mFrfVZC2Gv42HUcUcyIesIoY2OMjyN3ANN3qwNCC5A4BFfDeEb2xSWjZ?=
 =?us-ascii?Q?Cpc1DiLtgG5fheK6P8N/SkOLsVombWmO3sb6Ah/nslCD2Z7uaN9b0FmCCWLm?=
 =?us-ascii?Q?rdKIvqkURg0SKgSpHZUWEzuEtHv/PIIN2bgKLuw9AK+MR3wIzXePya37PXOW?=
 =?us-ascii?Q?xdDkOhPz2lL9esqBntd/8fLvHmBvtq2hDAKS9g9VCC8a0600lmQBAYmAjMNr?=
 =?us-ascii?Q?H12QOzw6L/fzBljbGEnt9jm0IiNxZx6SbixqVzhum885Pa9vNnhQdbQAwG5A?=
 =?us-ascii?Q?Rfm6zTNUNDE5C22i7yiaYBIz9NKm3DfD8jA3JWxq3EeKu8gx0SXFzVlhwJhU?=
 =?us-ascii?Q?5G2ejVfuuMl53Mpsck4z+7gnZIgGQTMpMys1Y3Xuk9/xEneoAUJYm2XU+VvP?=
 =?us-ascii?Q?JGKae0EAPGV7SeO/rCkdwgKtp+oji2rLoHLuUr+eLDArP6xhV8vb0qlRatz8?=
 =?us-ascii?Q?13n8Dv62k8hyyCecJ+dqxcC+dGeVvKvndr6fC/qNVGMlztZChvvpZQe6+WXp?=
 =?us-ascii?Q?XAcFLpYT5NZsj4aKBHZoNe9+8hQknr+2HJ+6FROo+aBplXKvBLEPdo7hGatw?=
 =?us-ascii?Q?f7Ow2awXTE29/lwJ85+Cr4OLSNsZo29RaKWRvYqtdqr2h5qaBRde6QGbiKUg?=
 =?us-ascii?Q?acW+nHSR5FWJWXgSUqnplgItsa7eh5BrXYFZjxGn61oTG7oVZI9xQ97Ti1Kp?=
 =?us-ascii?Q?1SVCI24pdHxV7NpYRdaXh677qqUvLK+KRp5j87OM+zAjfDytokW6vlivZ5jj?=
 =?us-ascii?Q?o52vd41NSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2869a382-d6cf-4b0b-eb0f-08de4a5e5fd4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:23:52.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7pgCF5kee7ldy1ptrVtVO0xOe8W12FNwuZMe9KLZgATQQBbiWWHiGmNCh53RDmJQ7rvjG+qmLThL8XoV/5U/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

If a task is on the rcu_node_entry list, its blocked flag should
already be set (it's set before adding to any list in
rcu_note_context_switch()). The current code silently re-sets it,
which could mask bugs.

Add a WARN_ON_ONCE to detect this invariant violation. If this
warning ever fires, it indicates a bug where a task was added to
a blocked list without properly setting the blocked flag first.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dbe2d02be824..73ba5f4a968d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -846,6 +846,7 @@ void exit_rcu(void)
 	if (unlikely(!list_empty(&current->rcu_node_entry))) {
 		rcu_preempt_depth_set(1);
 		barrier();
+		WARN_ON_ONCE(!t->rcu_read_unlock_special.b.blocked);
 		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);
 	} else if (unlikely(rcu_preempt_depth())) {
 		rcu_preempt_depth_set(1);
-- 
2.34.1


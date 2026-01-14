Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB23033D9;
	Wed, 14 Jan 2026 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411944; cv=fail; b=NjbhuCMo+6tML6/xb/ttv0akP7ANwfZNnymalRlRsGUX+1iYEG/5QhVd9rv3AGKcM4B9CMl88RdHrTGjgF1aRqASqwN8FJ+X1mGiOOKzVpdPoO+qvo4Ggnk/Q54vPQw85TsjIadcbNYdyjS96uHxpsYAoBFHdUdrjhDCoXORRqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411944; c=relaxed/simple;
	bh=DGLUk1K1kGWjZzv6UwG6PavgP8d5IcydiLpqh5OPt08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhvMU+tQI/PfsZHL/SdiYtjLYEEN4NCDzkWTR16zEP7PUmpk51kaaw9gcGBD+/6A5AXltTAUXkSTgYWpdfj/6cGJy275uqf4mlikbVVpyHYVqKZ/SwfsZgZrJYmHOKEyhry1GRZu6x1UwooDqYYrXHrGs+2doraLsxYEqvElgp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cRUnzOpB; arc=fail smtp.client-ip=40.93.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cRUnzOpB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/Wl2s/xwAvKs0OIMdKl50PDD6/FRRWPurvQPDcn1XHWc45bJmkhQfI0p3s4K5Run3mLslukv//r3GWlBPzMLLeCbtJCdOClviFyxiVm7gyn16vjLDJve5smvx4b9sA1fl607qrioWzGPfA8jYhOpaSCP4xNArhOccJGMIzU5QLTqt736t6AK7ouOvkhizg6+T7RsJl3Kqn2+S1cqYhD4oqMmWYETQ7O4BietVd6YyQoTsOhNOFsQaMHfJsWzvAQFsxBMplgvCQGa3mrXB8LmCf0JjA359qnKBQAM4pz2oGSZ1GmXyG2HWSB2cm1Kti4JUjtPGdY9aHwvqCkr9U9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXmLa8Hl3JJvCH+eNTaRdbtKcLCy72id3saWckCbhK0=;
 b=sKjdwmxUWy7wAcm5WUQb6NpQSYpCUWgvEBOA0JFemY4Rfx79qfWMQ+D8PFbIY4G9l/Df02Kdvuv17vXNWs+JXceK+efZHmdKU/9WEeFGo2D8t9BzNhIwPBZkOfCOvW6PUjxqc3Q6CR4fos4Ulik3yV95WqiGBtRruXCZd3Dewms/7ZZhKP8a2Vdh2RpmOY/Mzs0/hZRk2dcVdDCOYLxA7rZLtD722Ru6fVUBIaQFnAuUeO4S4c5ShwQ9QafmMXT/TZrC+kvIN/QI16DP4qzjvfvBQQ9FyTG+r65zc/cqhHpk3EZUQ72sGmK2XeGO5dr9kQlu49yLlXVcTWdtAbi7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXmLa8Hl3JJvCH+eNTaRdbtKcLCy72id3saWckCbhK0=;
 b=cRUnzOpB3WLLG4WMqWWjcRrzpOhjaplWyiQWG1miiABZ1gKdUGaquPK7gsTARW7tOxQ0ZGFMn/jegZU5Gju3GXoSd4hNjkt6O3gOGBafpig3ZrxjVV0TdVM/h8Z2h9Gs7qV2Bg/kTE4GVs/qsi97G1wngsv/ED2RsYK9GqtDmkbrh088IFWY8S4+gZDnAnAwtltfLGsZrGchp+1mRhYxJoo88+fFO7O/sesHB2GmYt5R1SoknuUHKkS1ugUEdUQe0ALvrT2VdBmvv84rGIiGsfB2mqr/8wUXbHoVvEN3h8TEHEqEaZqKhvWbS1/Dyk/PG8mNOlx+cqOZbJu4xtqaWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:32:19 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::f071:99a4:121:353a]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::f071:99a4:121:353a%6]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 17:32:19 +0000
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
Subject: [PATCH -next v2 2/4] rcu/nocb: Add warning if no rcuog wake up attempt happened during overload
Date: Wed, 14 Jan 2026 12:31:52 -0500
Message-Id: <20260114173154.1701056-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114173154.1701056-1-joelagnelf@nvidia.com>
References: <20260114173154.1701056-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:208:52d::30) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: c773880b-1c3a-4a5d-4d96-08de5392de6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B9BNbI1esatmm8Hs9zO7FvmzSCypRiumxLBn4MVok5qRxvNufjuOE39SChu5?=
 =?us-ascii?Q?S01UaUudZXEKgPRlloFh8LYM9mQtKZnBXI7kFnnmc/7H2qwyi0YaRg0ifDBj?=
 =?us-ascii?Q?ksoiI5uZyMntmqv7LDx9oNcohiOsfBTtcKmWYBRbUeq+SSV58UrdnU+7RL0u?=
 =?us-ascii?Q?zcX/uOkyawgW4VQusxy+1qfqOH9xRdrHVjlARUiPrcI9wwSI/vDxs/tMMgAe?=
 =?us-ascii?Q?GP37j8PuMldvHhWW/mYyMVT0z6+Srt2edJfgOfqosXx/3gIczedX1EdAGn70?=
 =?us-ascii?Q?tfijXdPOeXwXDDUkpOyXKx/U45pLt2IjrURqKWh4QzDOrOlnaaUX1WFJ9e81?=
 =?us-ascii?Q?N1dcDlG98qRl4YHuAY5svPrwXSA9DMlADbj5ogdQk70BljmQsTCM6HfqHc4O?=
 =?us-ascii?Q?hACJN+AlYPNEw63HiCPQB1dOIKFucpR/KzWEpisFpBEE3jDRVteT37/QdIlG?=
 =?us-ascii?Q?6VzcjSiN1UZruvhdbTCmP37x++cQDojZRckBuuQFEwYSfZwZHPFD+Vs/bFng?=
 =?us-ascii?Q?KXTCEsoqlITK9PXLajmgsZEn/36isucaSynfXxvOu13Mra17M+F2PAfwIDG5?=
 =?us-ascii?Q?Au5UYA7Q4x5M2sj6Ox2GiStC/GaVcTK9NzrgFaNqmtB4fSfXOhHo+TNhdl9Z?=
 =?us-ascii?Q?75Anv4WugU9NXvf7Fd8nvGRT0+Q2lttBnVCdtL2g2Q6kfqxwuZRtv10WfJPj?=
 =?us-ascii?Q?349EfTBS8PhL4WIna4hMmH8T8ltWTVyZMVBvcrxEUdL4UY/KgjZshgV4iL2d?=
 =?us-ascii?Q?oYSw/WUQh/zKukSSot6Cq/HFmQnLkNgCFlYuxeDJ8Km459JA7ANKyFw4iZwn?=
 =?us-ascii?Q?pJoW42htYLA4c/oFYfZsO1UqchI65+UOe7UGZTCKl7Onpg1+FQvDtyPrv0tS?=
 =?us-ascii?Q?oT3qcFRM5Yj5oJDIHvP+k5ORGfAqR9ct2/Ycqnuym8DDD9BYTHG3Fl/dGl3Y?=
 =?us-ascii?Q?RbN809uUMc48dO42gToqm+eRnGmUG0OW+2o0jX+UT9f8J/AnKLhVxg+Fojke?=
 =?us-ascii?Q?bRaViHtMUwIw9IVg/JEfc5h+linO3yGhxbaKk1G8sTqHp3wZqvxdB+u2Zwgq?=
 =?us-ascii?Q?PMGoN1ndDZ5rPERGZR1EgMeoFsunnUM1OsrUJ60EGk0yjHWNR8yeQkNnir8s?=
 =?us-ascii?Q?nLjXfW42HCdna4FunshDrRuRsiVbFtjchWSlcSr/uV5PUzMe6eWHa8dhwipe?=
 =?us-ascii?Q?dW3s2Bq/UXpe/n19EZF26rxmKvoksYYdmDCiMQFOUmJpGlginnDAQmMRVFXb?=
 =?us-ascii?Q?1Gg4EZDkhsEp97x+9jAGn0N/17i3rRv6X4uLGAYih4OcM4lE7+o6BDQDQPru?=
 =?us-ascii?Q?6rju7dqiojrvxX6lBOf9+W+qvEThuQOqsotK0yoNQgzQvjvaTH+BCgbaOWdb?=
 =?us-ascii?Q?7RdKe5avlQfbNOxdFqGH2c4WqQFvvZgVveAmFdZJTT+Er5tmbzlPyRmM/fb+?=
 =?us-ascii?Q?hN9x9eyMdG6T1sQjoZ91w6PC2S0maWbRXVErJCverKEz+sR0a0YxWccgJR9J?=
 =?us-ascii?Q?Ap9LXCJs8w8PoMc/1YqIGMD5DAB/krV8J3+VwdApWIpT9Tps0Sq+8Q8CUfV0?=
 =?us-ascii?Q?I704Co6YCebYDmLAOcU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKsyE5s+xe4ZzbBx87L5naiDiW3KEjvjK8uOxvLharInizPhv7f8iFyMh1Cp?=
 =?us-ascii?Q?DLsoeTDznYGMuZCiJFSF4kEFRSSBMXQeNt37hy6iw7njxQSjw/TM4j8c60px?=
 =?us-ascii?Q?4H7mYFhYnwbhViGv3jgnriNrTTEVbe9EWurafwoaXDRiRBhnYUCOVmQAByxD?=
 =?us-ascii?Q?GXx4DeCLhof2zZd0cekbb68G29GAfOA6+yGLbMzxSWyaexCMLolgKHtMLMNS?=
 =?us-ascii?Q?BA4+t4LiDCvovSb8j4OAPvzVi231ASY5CsH0KpJT8j5N3p4ymgEFyvuBvUed?=
 =?us-ascii?Q?B58qRDf+JAgFt3VHHQJ7hOy+kY4WpYhToX4a6S4ToRTRD0ToQDIPXd7xf04n?=
 =?us-ascii?Q?eoNrwS1xuKHq78G57fPgvsG3jXKYZz2fYB7RXwVYgXr/f5N5f4FqBecR4Wwy?=
 =?us-ascii?Q?DTC62Ga07F1e/k9dBDFqLIqsOVHkxU7nt4rsJSPRbq3Dpa39zO5gi0Ua2zPJ?=
 =?us-ascii?Q?AKb29n5jbWsLSaG/orZCZgKMEAyk7afqXe3hM1XbQEpN/p7KqXzQHrPeCw1t?=
 =?us-ascii?Q?yU85jj02TaSFUrFgWCjpMRLmBjF+psUntdRGsIIOltKnx0bamHilD7A/zXdY?=
 =?us-ascii?Q?hkAWoAeqzP/7guIKWe7SfB6hoi/UtY5oNsADNIjYR2/nKUnr1zxrX3a5L3NU?=
 =?us-ascii?Q?kfbpiDwNsAfMHgnPDMWVGAQkb6/AjSiRYrcfRBOtRDhWVO0EjxRHZPPDOdTw?=
 =?us-ascii?Q?XG2Tgiui7dTzED2WaqIBuxeAb1mMi2DXjf4YW4EPjJp3gH+xrIT+sP3lpOwV?=
 =?us-ascii?Q?DCGUh+IrLKG9x0tF5h4ucHxMDFps/s0dlSFWnNDX/dIYJ0VY8Au3gbnLpUYE?=
 =?us-ascii?Q?3L2b6Q90pvUF7MpwFTzCyExtdsIDisw5uif5XdvepH+F2t/aZHAw0ZySMMYV?=
 =?us-ascii?Q?GwOR39kdTqUQYyHpdsZE6nKK2JvX28uIMumpeGvj21M8BM+pJ78KNfUn7cNH?=
 =?us-ascii?Q?Z6/KPoZ1MvSaJcggDykJ85GqRE6EnD61DX+Yl1rQtf0JZmuNCHafOsx52CtQ?=
 =?us-ascii?Q?HWxzTR80W8Fl8B9sQN6H4TGPlsZK2Uhae0k2T8hEG6koC2ZYRbkH1GR8QNXc?=
 =?us-ascii?Q?BBhz+wudI52RiJ87AGZkY97z9ZXb2+jAtMUzf4+LUj6vmtGik/q9JAhok3Tw?=
 =?us-ascii?Q?y5RJUD+a/+OtzN7oREflfjh44g5r7PrsSPRyu0mYAMii3OLeXOmRmzTui3Fp?=
 =?us-ascii?Q?aPnA5OXRXwBiLd00c9aw4Aw4DCZbJC28HtpiZVsOdz1sOmKzKphoKYHn3W8Y?=
 =?us-ascii?Q?RvJA0FRWVy+wSZmOemURtWerfHMdbrLjsHJCB2r+AVor2EaALHcKtHwcqjwn?=
 =?us-ascii?Q?RoZEs4MnbJMu12girQjRwndI5cqKwEX2wkN5QToGMYaW1TUkL+706A+s7pAH?=
 =?us-ascii?Q?sVpb4XeuT6Yh25vUqnLB1mpbG2Ej5M44ZfjU/g/lFt0HqjDy/45Q5aS/IcTC?=
 =?us-ascii?Q?HRHionAuqlszCbdiPCPCtJeFFojEsxWAIkShjRjWUdUkRahWiSe/b1QiMbOf?=
 =?us-ascii?Q?83nB4jFOhegnbYSsGfM25aSAsFC88ZsKRwakeqXsikkeJFVxGNE851Cil3kv?=
 =?us-ascii?Q?hcyzTL4MG0W3sQmP11nmRXNr8esczPCPrkuven+Y6/9bTQUhuNtsaBu+/ISX?=
 =?us-ascii?Q?yHHA/zcmumvlrBTA9aLtGdcQJb+6KXdazyXtwTbnS/GjTZqsqeP345coF8vn?=
 =?us-ascii?Q?WtxiTZTw9BLtN8jQwXOStxBPbOmNXFm5VTIblv9DXtc5xgnm7ae4Bnosrxr1?=
 =?us-ascii?Q?SyqR1AytYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c773880b-1c3a-4a5d-4d96-08de5392de6a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:32:19.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18057UCWBi7mq6A7P58wvVHmCa9Zw8/Ixt3lUUirkSaP58K0eKc/wbbY/hwwWHvpTyruq3AsSPJNsIQQlat70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

To be sure we have no rcog wake ups that were lost, add a warning
to cover the case where the rdp is overloaded with callbacks but
no wake up was attempted.

[applied Frederic's adjustment to clearing of nocb_gp_handling flag]

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      |  4 ++++
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h | 11 ++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2921ffb19939..958b61be87ea 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3767,6 +3767,10 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
+#ifdef CONFIG_RCU_NOCB_CPU
+	/* wake_nocb implies all CBs queued before were bypass/lazy. */
+	WARN_ON_ONCE(wake_nocb && !rdp->nocb_gp_handling);
+#endif
 	rcu_nocb_unlock(rdp);
 	if (wake_nocb)
 		wake_nocb_gp(rdp);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7dfc57e9adb1..af1d065e3215 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -257,6 +257,7 @@ struct rcu_data {
 	unsigned long nocb_gp_loops;	/* # passes through wait code. */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
+	bool nocb_gp_handling;		/* Is rcuog handling this rdp? */
 	struct task_struct *nocb_cb_kthread;
 	struct list_head nocb_head_rdp; /*
 					 * Head of rcu_data list in wakeup chain,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f525e4f7985b..acca24670a8c 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -546,6 +546,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
+		rdp->nocb_gp_handling = true;
 		rcu_nocb_unlock(rdp);
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
@@ -563,7 +564,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 
 		return;
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
-		/* ... or if many callbacks queued. */
+		/* Callback overload condition. */
+		WARN_ON_ONCE(!rdp->nocb_gp_handling);
 		rdp->qlen_last_fqs_check = len;
 		j = jiffies;
 		if (j != rdp->nocb_gp_adv_time &&
@@ -732,6 +734,12 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			needwait_gp = true;
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("NeedWaitGP"));
+		} else if (!rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
+			/*
+			 * No pending callbacks and no bypass callbacks.
+			 * The rcuog kthread is done handling this rdp.
+			 */
+			rdp->nocb_gp_handling = false;
 		}
 		if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
 			needwake = rdp->nocb_cb_sleep;
@@ -1254,6 +1262,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			continue;
 		}
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
+		rdp->nocb_gp_handling = true;
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp);
 		sc->nr_to_scan -= _count;
-- 
2.34.1


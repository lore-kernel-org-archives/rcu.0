Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6F225396;
	Fri, 18 Apr 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992672; cv=fail; b=fPI1ooxpOOMKmqXonJfca1AtcDEabsUflD5mdmSJD6kCGoN8pHbG9rBgiIo1woUDg95JftWTLPC1o0lD/uxLGoHLHgv+4HM2Cqqz4j2BD/r5ar9K6MUvS1f6d3U+goLIU6JhAkLe891G8rDeUKiRLnTwUD7MdIDf154ma974+kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992672; c=relaxed/simple;
	bh=uZw6vJE3txH426aYUhKnCJE67RQTx9pWxkC4WC2tS5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKTmxnMxFlkiEDbtqZrp5p4SKk8lzPjAZFQQDwPGdp751s88H4Wpm0BzC3RoFgtkR9xJgNrOiQPSZUwnrE6AWz65qR6kT8FD10p5Z2K7VgvxTPD/6QUcy74sncTpbzSlpjJnXVPYqyT5+42J52Ai9WGLwnyjMBB8xDQHaharNl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y8WAX3Dp; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y8WAX3Dp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbPJdIt6rWgeDkNF6Nr3dzxqkExzdPT+Yf3aTRqiKZGz93rw1b/aXOKzH4ROAWnl5hb6y0fjIiw+lZb7HwxXSoDxPcYW4Sf72ZxoQQygoCjXO+ywTNWeP2fkUSt+rqb2i/eEVp5h1UhZ4FDnsmHYgT92poM1SkbyIo9meendnCGqkS+N6R5Vx1C7gJQ3Juvxh3oohWU4OLcRYlIJtxbUqDgniqmHSZrpK+Bws8y0c4QX3Ll1rMqYR6VRAPVOC7wnzBukLpXIRn/0/vT6nxbtecOfe1/HMAsnXE4SKv4T22u1o8epsT8aV+Cb3eh/Axx9VgX6lfK2k117iWjOaZjBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIQqoMc/ZwLJlXJdQd2WCjtQLfJPP1ny8zqRE38qSJw=;
 b=X7AkXh6l2phlz0Zl+/MqLpi45nVvzSwBCjkppPmU9LvJkG+FAsgDOnCD/11oR67KDVC1fmoUH+N6tdDG2pfAFxm7p8fr58NdPTXNxNyY3w+5dRAKUqCFt3dFhRlGD2U+FNvy+6B7RcPGcj/uuKA+8j+DtxVHXDfcyRi3VjwgohRdZMYfjPz1uvIIUqYwgTozTViyfp/0ttzV6Y1oe3O9T6llE2G9g90LIS1CT8+auc2MhMeoX7y1nblEHksH5p2DKUp/V0cvzvl/SoRHWHJkd4xrwHlGT1Crjew33b8WAjasQ2xllZHIRoTebC2AZbImlw7RCaaLmnvpNw6wA+ALQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIQqoMc/ZwLJlXJdQd2WCjtQLfJPP1ny8zqRE38qSJw=;
 b=Y8WAX3Dp71YxVfS0m7v//VnaRpGSdlpQLFcTF4RL0qXYGi69dODJ6Kx5+uKiITVpvZTY7ZDZXfdPElNL123Mgw1gGuBkbK9av0WHRSksJnWprCLxwA/zPqwgjcaNPTaCmOTJntppEH9WEvd1FxZqZsqGBps4OywMyH0R+Gxmu4Cqe62r30BQJ+Yxh2eaE5Y7yCZfheZaVsmYIW3AKXYJZOeT8lJS+CC7bkVnSPpU5WbMHZ4ZNSZXiObaYaj/6lqYYzwHe6SPKdTaSV1uwuF5mRSMXTwhrE2NRvqx9dCvGEdFSY35BgDCMnlHmAIu3NKK8RT6f8rXBOzypkBobOkEmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:11:02 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:11:02 +0000
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
Subject: [PATCH 05/12] rcutorture: Add tests for SRCU up/down reader primitives
Date: Fri, 18 Apr 2025 12:09:51 -0400
Message-ID: <20250418161005.2425391-20-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4616f0-c536-4eb4-65e5-08dd7e939d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LWFedtQUu7g8aHRvrxmwWWisLGNehkxoy6iIURFr6BWt9vOn+atmH2p1Fswr?=
 =?us-ascii?Q?9I4czCqdqH1jfJpKEt0IXoEeLNm+f8MND+ldnk6UJ6Wi23UER7qBD3OLgyCO?=
 =?us-ascii?Q?vPo4ntUl8niSd3WE0mYomA7tWakyH4aTiWmh6oaa5yaiqdeG9lUwXThyvZOi?=
 =?us-ascii?Q?dCUajkNJap7gYa2CKwPTxbJKBFEiT36icowEMdrdEVjjUHfqNM+Ma34XS4no?=
 =?us-ascii?Q?DjXSVBWwHW/ej2vDxApO1goAJd+Zw/qkgcOdephV7+N8Yc+Weny8FYYW3IxC?=
 =?us-ascii?Q?8Wa5apdS8w2Yh49oR39bneeMe2IGlDewyfJ7aTd6vsC3+KuoN9oDHJFdhPD5?=
 =?us-ascii?Q?zWz0Aq47c0G4SW6llTio2Pnx3Lyp7aomu5ZABGRPjDTmC6Xjg0zOtZyQ1F6+?=
 =?us-ascii?Q?Lwmi9mQOQoi2yAoydEAG5cGjcSOfF38MB5stbgX4+6SkB852pq5hOlu4cC/G?=
 =?us-ascii?Q?soMaWnJfZN2vnH2jcIp9/cSCvpAJedC+lVHF7yPtNHWRBeDDTVDjqmk53BKL?=
 =?us-ascii?Q?jm6PejVEmefdSYEM8XUXRv8JE+AJTzh2foWf1+WUc1YDb8CpQsqyEWwPdKL9?=
 =?us-ascii?Q?VbfDOAO4Bi0CVurOx3imacKzbCDzn+BQHhln2OUW864X9fFx0fojn0alK+mA?=
 =?us-ascii?Q?KlyY65g04QPGfxd0glrffh10aYpCiDX6i/pUDWqUGzU7FMWDR24ZT9J7n4Hn?=
 =?us-ascii?Q?93dl/pmrkksZeHzSOEb5mvjlSzDgcrGLvfin90mbD9Rlz6S071ap2JD0NRoh?=
 =?us-ascii?Q?94s8jkTN1dfZBL/5UQR/cDXfMNVvRC2p4wHTKrIOzoaMkpPSugZeusWy6Prm?=
 =?us-ascii?Q?q0xDS+38lus0Viv1Pij6vyM5ZqwXmvczrIItgaZhtF0aB4wARDsfBbGKTKLa?=
 =?us-ascii?Q?ZSdcb/fLQNpvLDJrJszmG1oKhoncM2y2B0PvergSvuyLc3QxAesCXgG81kZF?=
 =?us-ascii?Q?js11y1+A83yNH5wRBZv8Q5fc7dcNGDPBQIQYeTrhc/mmNjFsXw0t5Wsw00su?=
 =?us-ascii?Q?BDBh4SsfuK2/f4yswKSE4Bq2TIgFtjwrEjHTcijwlB9mWBrRjOk2ylR/WXCu?=
 =?us-ascii?Q?RvXA/BjQOLN9Kzgd4sOlgrNJMDwyy95+C0jtctrH0e64vcZSVdoxmeBl9KLc?=
 =?us-ascii?Q?d7UC6YJblTRLt5EixSAGp/AGiZUffo3p9kdT4PS3Gb99ARkJdzhn9QsdirUN?=
 =?us-ascii?Q?7yPWu7vx78Px6R3zO121GoGbZNFvrVlkj67GGDfzndjiH1yKiCk8Bj67fvH9?=
 =?us-ascii?Q?wraILyOHeCumi7xJ0hSTR/luRIizl0XztH0yf8ICjKlKobRYpgBENT8nC37B?=
 =?us-ascii?Q?Q+DNk7SJD6rHvUT2HREvDdseowLWQS0vQRWQZh+Y84RuqltLUbKiiUJ8Es04?=
 =?us-ascii?Q?JgTgUECfoG3iv8o3wpPKALImMqnWQ733CCTEYqgFb87U5BQOfhwGMRxD+RC9?=
 =?us-ascii?Q?zsedeRYan17ziR9lGNalIGhGZhJw4G0SunRANY/9tgs8cKqC95wZ9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0j/QHRLLJlnUDP0te4vJ/dZG9iT76y/KLQaXB6+fnG+Fp6NnOXlqh5Ayjtgc?=
 =?us-ascii?Q?AVVl7vm+Mp7Y1oed/Ymgv1HoUvf6qdscjcEt6evygKg+gkEmWjlwZmHG/rpU?=
 =?us-ascii?Q?eSXT3yFr5ap0AfkRp0tY0r4yF5g3J60FxYlOSSeO5/QoCYg78tVr3ockyFHQ?=
 =?us-ascii?Q?Fy6OR4gjPWJkshXu2UB8ZUEQ2PJvdlNTzjbCwSxZTLHeVzf9g4KJnDjvVnhY?=
 =?us-ascii?Q?lzANR1zqSpJtHpGiAvy5540I0ae3elLpX6qApPKd3Ee7zOADQbFuOUtv5PIa?=
 =?us-ascii?Q?6010gIttvr2+I7/wtgLj+gnQf8LA1TuCTMVHBwp9A7YzsgX+zEAE4TTxCr7H?=
 =?us-ascii?Q?J4YQs7hJxLRaE1LAfogjCAGGvBkh6lklUbBbz+ppHm8wtt+iDhOklUOlwbKc?=
 =?us-ascii?Q?wf8OvkIMy0dRhIhqweEBxbW5tEwL49J9EFxaZfGXAHVz7AJ9oyZMmMQJVFHY?=
 =?us-ascii?Q?GgGjOfAAI3F1YM2kR2RbYYFJmtVc7wj9IPVu5+TnylXkzjouUEi8IBVw0nvZ?=
 =?us-ascii?Q?hAAvuwtS8KZL7yqadS76ivT0BcX6aJoh8A+fkYFNgn75TmmXxwlJeNMcoVNR?=
 =?us-ascii?Q?P77x9E6sVaJj6VqmjAcdQCtOkQhd/aPPwe/ZucioFzTlPUJJGsSFy7ZzJWrD?=
 =?us-ascii?Q?j9P6yB75JgjldPFRZQxv7tUoTcXpaPa2znDr/uftEGG3OG8oEtrCH2li7fLF?=
 =?us-ascii?Q?EeotFwJ57eRU9sa8+aVUoCM9C//z82anfkYr0iLDBXzSrkSQmJgkX4otMarP?=
 =?us-ascii?Q?1eXLgmX65+JiJA6OIZuBc2Auy/tljLkZQhUHa3NvBBktZtQ7IBo/s9MGWJRm?=
 =?us-ascii?Q?wW0uL2fXd0d9gJTHodJPErhjWwemFCn+LikKxapRGX6Cz/30tjNHnwiW7SuP?=
 =?us-ascii?Q?HVsfjXvMdies65wjTPnaoW8Uen4ot02/GP1AqJHNpxqpwvBvqWRRtKy95CMd?=
 =?us-ascii?Q?NMCI35rRUGdT0ldiCzPA2aIdbMhYvkSD0XhMD3wc7PIHtIaQY2b2OybmZfgI?=
 =?us-ascii?Q?lNG4CWvwTq7gg7mb3iVSqfCaCZh88ToGQJcwn3mAJhQhmsK5vWOxz1b/rLg4?=
 =?us-ascii?Q?G1PpPHWCKh/pQyI3WZXUDF6qKhGmXECkJucYqKemGMFG7rqy/aBfoaEsxoAY?=
 =?us-ascii?Q?Vf0JQnt/k5cTg4CNYMSC6SHpEhXV32a26TdcP9WDwd3yk4/X3Y+ZbH2MZktR?=
 =?us-ascii?Q?NKRAUDbB6IcwtZHK28bFiFwctpTvvRSUHQbV+5YOGd+tVlMaPMjKTYwOtQrP?=
 =?us-ascii?Q?apMr8/Hm5R4smugQZ3c8Uc8lux6o9I2ZUxiSXarUV3amANya7AD9bUmWRKbz?=
 =?us-ascii?Q?f/Sj7YzpkI2ItK8FqQ/6PKWU4S5zx1QoLHlzBzOhZxvvJ6Abi/o3wPjwwUly?=
 =?us-ascii?Q?GMv91ijwh/b64MH5X6HfU506ZDvplFC1QVlcknvJJFC+Jn7uOocSkUkAqFkz?=
 =?us-ascii?Q?PxEhgPcwKDpfgatkDV6DoDo6uzTpR9/7bU3+p86SBWbnZuPHQKv3ZXZZjV6G?=
 =?us-ascii?Q?R/0sR19hzSIujlnORouHdg6Sqn22eFz9BXfZDHmz6HxmUwFUqRq0ExQWzt+I?=
 =?us-ascii?Q?gyzVc42c8kMzvL1njwHP2jChlm+BSvVw3QOqLzw7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4616f0-c536-4eb4-65e5-08dd7e939d7e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:11:02.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itBb5zfDPbc1B5FXAhN4+0gSGRJUco762gmAisc6vIP9j0JwZvbpLVHQvLRXvXFrN1ijaHwtpmcrjRilLf8NJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a new rcutorture.n_up_down kernel boot parameter
that specifies the number of outstanding SRCU up/down readers, which
begin in kthread context and end in an hrtimer handler.  There is a new
kthread ("rcu_torture_updown") that scans an per-reader array looking
for elements whose readers have ended.  This kthread sleeps between one
and two milliseconds between consecutive scans.

[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Apply Z qiang feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 227 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 208 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b0e96df63622..e7f0521c56d0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -55,22 +55,24 @@ MODULE_DESCRIPTION("Read-Copy Update module-based torture test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
 
-/* Bits for ->extendables field, extendables param, and related definitions. */
-#define RCUTORTURE_RDR_SHIFT_1	 8	/* Put SRCU index in upper bits. */
-#define RCUTORTURE_RDR_MASK_1	 (0xff << RCUTORTURE_RDR_SHIFT_1)
-#define RCUTORTURE_RDR_SHIFT_2	 16	/* Put SRCU index in upper bits. */
-#define RCUTORTURE_RDR_MASK_2	 (0xff << RCUTORTURE_RDR_SHIFT_2)
-#define RCUTORTURE_RDR_BH	 0x01	/* Extend readers by disabling bh. */
-#define RCUTORTURE_RDR_IRQ	 0x02	/*  ... disabling interrupts. */
-#define RCUTORTURE_RDR_PREEMPT	 0x04	/*  ... disabling preemption. */
-#define RCUTORTURE_RDR_RBH	 0x08	/*  ... rcu_read_lock_bh(). */
-#define RCUTORTURE_RDR_SCHED	 0x10	/*  ... rcu_read_lock_sched(). */
-#define RCUTORTURE_RDR_RCU_1	 0x20	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_RCU_2	 0x40	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_NBITS	 7	/* Number of bits defined above. */
-#define RCUTORTURE_MAX_EXTEND	 \
+// Bits for ->extendables field, extendables param, and related definitions.
+#define RCUTORTURE_RDR_SHIFT_1	8	// Put SRCU index in upper bits.
+#define RCUTORTURE_RDR_MASK_1	(0xff << RCUTORTURE_RDR_SHIFT_1)
+#define RCUTORTURE_RDR_SHIFT_2	16	// Put SRCU index in upper bits.
+#define RCUTORTURE_RDR_MASK_2	(0xff << RCUTORTURE_RDR_SHIFT_2)
+#define RCUTORTURE_RDR_BH	0x01	// Extend readers by disabling bh.
+#define RCUTORTURE_RDR_IRQ	0x02	//  ... disabling interrupts.
+#define RCUTORTURE_RDR_PREEMPT	0x04	//  ... disabling preemption.
+#define RCUTORTURE_RDR_RBH	0x08	//  ... rcu_read_lock_bh().
+#define RCUTORTURE_RDR_SCHED	0x10	//  ... rcu_read_lock_sched().
+#define RCUTORTURE_RDR_RCU_1	0x20	//  ... entering another RCU reader.
+#define RCUTORTURE_RDR_RCU_2	0x40	//  ... entering another RCU reader.
+#define RCUTORTURE_RDR_UPDOWN	0x80	//  ... up-read from task, down-read from timer.
+					//	Note: Manual start, automatic end.
+#define RCUTORTURE_RDR_NBITS	8	// Number of bits defined above.
+#define RCUTORTURE_MAX_EXTEND	\
 	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
-	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
+	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)  // Intentionally omit RCUTORTURE_RDR_UPDOWN.
 #define RCUTORTURE_RDR_ALLBITS	\
 	(RCUTORTURE_MAX_EXTEND | RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2 | \
 	 RCUTORTURE_RDR_MASK_1 | RCUTORTURE_RDR_MASK_2)
@@ -110,6 +112,7 @@ torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
 torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testing");
+torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
 torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
@@ -152,6 +155,7 @@ static int nrealfakewriters;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
+static struct task_struct *updown_task;
 static struct task_struct **nocb_tasks;
 static struct task_struct *stats_task;
 static struct task_struct *fqs_task;
@@ -374,6 +378,8 @@ struct rcu_torture_ops {
 	void (*readunlock)(int idx);
 	int (*readlock_held)(void);   // lockdep.
 	int (*readlock_nesting)(void); // actual nesting, if available, -1 if not.
+	int (*down_read)(void);
+	void (*up_read)(int idx);
 	unsigned long (*get_gp_seq)(void);
 	unsigned long (*gp_diff)(unsigned long new, unsigned long old);
 	void (*deferred_free)(struct rcu_torture *p);
@@ -421,6 +427,7 @@ struct rcu_torture_ops {
 	int no_pi_lock;
 	int debug_objects;
 	int start_poll_irqsoff;
+	int have_up_down;
 	const char *name;
 };
 
@@ -754,6 +761,50 @@ static int torture_srcu_read_lock_held(void)
 	return srcu_read_lock_held(srcu_ctlp);
 }
 
+static bool srcu_torture_have_up_down(void)
+{
+	int rf = reader_flavor;
+
+	if (!rf)
+		rf = SRCU_READ_FLAVOR_NORMAL;
+	return !!(cur_ops->have_up_down & rf);
+}
+
+static int srcu_torture_down_read(void)
+{
+	int idx;
+	struct srcu_ctr __percpu *scp;
+
+	WARN_ON_ONCE(reader_flavor & ~SRCU_READ_FLAVOR_ALL);
+	WARN_ON_ONCE(reader_flavor & (reader_flavor - 1));
+
+	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL)) {
+		idx = srcu_down_read(srcu_ctlp);
+		WARN_ON_ONCE(idx & ~0x1);
+		return idx;
+	}
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
+		scp = srcu_down_read_fast(srcu_ctlp);
+		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
+		WARN_ON_ONCE(idx & ~0x1);
+		return idx << 3;
+	}
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static void srcu_torture_up_read(int idx)
+{
+	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+		srcu_up_read_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
+	else if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) ||
+		 !(reader_flavor & SRCU_READ_FLAVOR_ALL))
+		srcu_up_read(srcu_ctlp, idx & 0x1);
+	else
+		WARN_ON_ONCE(1);
+}
+
 static unsigned long srcu_torture_completed(void)
 {
 	return srcu_batches_completed(srcu_ctlp);
@@ -811,6 +862,8 @@ static struct rcu_torture_ops srcu_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
+	.down_read	= srcu_torture_down_read,
+	.up_read	= srcu_torture_up_read,
 	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
 	.gp_diff	= rcu_seq_diff,
@@ -831,6 +884,8 @@ static struct rcu_torture_ops srcu_ops = {
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.debug_objects	= 1,
+	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
+				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
 	.name		= "srcu"
 };
 
@@ -856,6 +911,8 @@ static struct rcu_torture_ops srcud_ops = {
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
 	.readlock_held	= torture_srcu_read_lock_held,
+	.down_read	= srcu_torture_down_read,
+	.up_read	= srcu_torture_up_read,
 	.get_gp_seq	= srcu_torture_completed,
 	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= srcu_torture_deferred_free,
@@ -875,6 +932,8 @@ static struct rcu_torture_ops srcud_ops = {
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.debug_objects	= 1,
+	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
+				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
 	.name		= "srcud"
 };
 
@@ -1985,7 +2044,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 
 	first = idxold1 == 0;
 	WARN_ON_ONCE(idxold2 < 0);
-	WARN_ON_ONCE(idxold2 & ~RCUTORTURE_RDR_ALLBITS);
+	WARN_ON_ONCE(idxold2 & ~(RCUTORTURE_RDR_ALLBITS | RCUTORTURE_RDR_UPDOWN));
 	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold, insoftirq);
 	rtrsp->rt_readstate = newstate;
 
@@ -2061,6 +2120,11 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 		if (lockit)
 			raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 	}
+	if (statesold & RCUTORTURE_RDR_UPDOWN) {
+		cur_ops->up_read((idxold1 & RCUTORTURE_RDR_MASK_1) >> RCUTORTURE_RDR_SHIFT_1);
+		WARN_ON_ONCE(idxnew1 != -1);
+		idxold1 = 0;
+	}
 
 	/* Delay if neither beginning nor end and there was a change. */
 	if ((statesnew || statesold) && *readstate && newstate)
@@ -2201,7 +2265,8 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
 	rtorsp->started = cur_ops->get_gp_seq();
 	rtorsp->ts = rcu_trace_clock_local();
 	rtorsp->p = rcu_dereference_check(rcu_torture_current,
-				  !cur_ops->readlock_held || cur_ops->readlock_held());
+					  !cur_ops->readlock_held || cur_ops->readlock_held() ||
+					  (rtorsp->readstate & RCUTORTURE_RDR_UPDOWN));
 	if (rtorsp->p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
 		rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
@@ -2370,6 +2435,123 @@ rcu_torture_reader(void *arg)
 	return 0;
 }
 
+struct rcu_torture_one_read_state_updown {
+	struct hrtimer rtorsu_hrt;
+	bool rtorsu_inuse;
+	struct torture_random_state rtorsu_trs;
+	struct rcu_torture_one_read_state rtorsu_rtors;
+};
+
+static struct rcu_torture_one_read_state_updown *updownreaders;
+static DEFINE_TORTURE_RANDOM(rcu_torture_updown_rand);
+static int rcu_torture_updown(void *arg);
+
+static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
+{
+	struct rcu_torture_one_read_state_updown *rtorsup;
+
+	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
+	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+	smp_store_release(&rtorsup->rtorsu_inuse, false);
+	return HRTIMER_NORESTART;
+}
+
+static int rcu_torture_updown_init(void)
+{
+	int i;
+	struct torture_random_state *rand = &rcu_torture_updown_rand;
+	int ret;
+
+	if (n_up_down < 0)
+		return 0;
+	if (!srcu_torture_have_up_down()) {
+		VERBOSE_TOROUT_STRING("rcu_torture_updown_init: Disabling up/down reader tests due to lack of primitives");
+		return 0;
+	}
+	updownreaders = kcalloc(n_up_down, sizeof(*updownreaders), GFP_KERNEL);
+	if (!updownreaders) {
+		VERBOSE_TOROUT_STRING("rcu_torture_updown_init: Out of memory, disabling up/down reader tests");
+		return -ENOMEM;
+	}
+	for (i = 0; i < n_up_down; i++) {
+		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
+		hrtimer_init(&updownreaders[i].rtorsu_hrt, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+		updownreaders[i].rtorsu_hrt.function = rcu_torture_updown_hrt;
+		torture_random_init(&updownreaders[i].rtorsu_trs);
+		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors,
+						&updownreaders[i].rtorsu_trs);
+	}
+	ret = torture_create_kthread(rcu_torture_updown, rand, updown_task);
+	if (ret) {
+		kfree(updownreaders);
+		updownreaders = NULL;
+	}
+	return ret;
+}
+
+static void rcu_torture_updown_cleanup(void)
+{
+	struct rcu_torture_one_read_state_updown *rtorsup;
+
+	for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
+		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
+			continue;
+		if (!hrtimer_cancel(&rtorsup->rtorsu_hrt))
+			WARN_ON_ONCE(rtorsup->rtorsu_inuse);
+
+	}
+	kfree(updownreaders);
+	updownreaders = NULL;
+}
+
+/*
+ * RCU torture up/down reader kthread, starting RCU readers in kthread
+ * context and ending them in hrtimer handlers.  Otherwise similar to
+ * rcu_torture_reader().
+ */
+static int
+rcu_torture_updown(void *arg)
+{
+	int idx;
+	int rawidx;
+	struct rcu_torture_one_read_state_updown *rtorsup;
+	ktime_t t;
+
+	VERBOSE_TOROUT_STRING("rcu_torture_updown task started");
+	do {
+		for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
+			if (torture_must_stop())
+				break;
+			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
+				continue;
+			init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors,
+							&rtorsup->rtorsu_trs);
+			rawidx = cur_ops->down_read();
+			idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
+			rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
+			rtorsup->rtorsu_rtors.rtrsp++;
+			if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors,
+							&rtorsup->rtorsu_trs, -1)) {
+				cur_ops->up_read(rawidx);
+				schedule_timeout_idle(HZ);
+				continue;
+			}
+			smp_store_release(&rtorsup->rtorsu_inuse, true);
+			t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
+			if (t < 10 * 1000)
+				t = 200 * 1000 * 1000;
+			hrtimer_start(&rtorsup->rtorsu_hrt, t,
+				      HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+		}
+		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
+		stutter_wait("rcu_torture_updown");
+	} while (!torture_must_stop());
+	rcu_torture_updown_cleanup();
+	torture_kthread_stopping("rcu_torture_updown");
+	return 0;
+}
+
 /*
  * Randomly Toggle CPUs' callback-offload state.  This uses hrtimers to
  * increase race probabilities and fuzzes the interval between toggling.
@@ -2620,7 +2802,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "reader_flavor=%x "
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d "
-		 "preempt_duration=%d preempt_interval=%d\n",
+		 "preempt_duration=%d preempt_interval=%d n_up_down=%d\n",
 		 torture_type, tag, nrealreaders, nrealfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -2634,7 +2816,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 reader_flavor,
 		 nocbs_nthreads, nocbs_toggle,
 		 test_nmis,
-		 preempt_duration, preempt_interval);
+		 preempt_duration, preempt_interval, n_up_down);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -3686,6 +3868,10 @@ rcu_torture_cleanup(void)
 		nocb_tasks = NULL;
 	}
 
+	if (updown_task) {
+		torture_stop_kthread(rcu_torture_updown, updown_task);
+		updown_task = NULL;
+	}
 	if (reader_tasks) {
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_torture_reader,
@@ -4216,6 +4402,9 @@ rcu_torture_init(void)
 		if (torture_init_error(firsterr))
 			goto unwind;
 	}
+	firsterr = rcu_torture_updown_init();
+	if (torture_init_error(firsterr))
+		goto unwind;
 	nrealnocbers = nocbs_nthreads;
 	if (WARN_ON(nrealnocbers < 0))
 		nrealnocbers = 1;
-- 
2.43.0


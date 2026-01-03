Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646721773F;
	Sat,  3 Jan 2026 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399840; cv=fail; b=EugOdLHeMqsfKZaBld0idfGicAXSi+UwpqoqQcEYgX9/RliPGN0lISoKUz32uWWrJaGqG5ynmxNUf93iIeHbvaMOkWbOUdbaSuYuU850VG/dh3x1ocHFEBuXels5sS86eSJZZkj+nyqu0TJALquKSgam4GBEZEy/QdxKkz3WUTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399840; c=relaxed/simple;
	bh=cTrfbJ0QLAGFF/eW1Xu8zpiZhFNvS/Vv+hgloiQO7B4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IbJ8FSAEKOLPZLUokelHg7n+BBLUtFLdbPPsSNxpRlNhbmYgrLFSJubRzD8LT8cbjALHJrNgUvAXWG9aJ9IJgxmfZ/BISJ3TeFXMT94qyltK0Jh1NLWp5kTwQUiXamoykJ1G6MKmDG6uC6/+5TlNO0M6y9lmwkYBPEw0fC/rrb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VCOSvJ39; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VCOSvJ39"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXft0Zp9Jvjshqfl5TfUS0l5f+OVvpnhTlXWzIclC6xUwV53ZBQ37BI3zCTRxQBZfng/1NPzvs4i+e2zo8VTlxybLQrx1iRGUuhQNwSUE9N8sxvBBBKhPeNFGWDfSfLj0a6sUsgmwXXXdfFkFLI681ZMau+OgQWUpeeAEtPjAVrjlPnYK0KvZagXIUoevwOx5Cb1AdXh+ZRBJydR/L9j2wsOc4Nj4kavXmb1n7q7IQML+/Oc93OLRRJ6Nb7jRN5K+oXKKeZ5e+JOT2zrZekUz1zKtFG/yNuYBqjr+nEBbtSReHrIzKwIQrvZUacW6wIe8ixGj7yNGrVN3rvLgkptFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkwgaKDVo/gi1rc8+Angb8g13zjXdUqYwSl80TJ6JCE=;
 b=gj/y8abRHxrkJU/bwy8T61gxpNX4vBoAOd+lU6GlhDXde7P2n41wGAYhGoW9SvRwkhJghzAhSr0gxye5dp51dGjvoDo36c1G0i4VN14epq2aq9XAASfLsduR+RwFJO0DzKVwp9no6/BdMsUn4JDduhdkRtrBCakeKRc9ONN+CvRRssFwxKX1wkvbnUCooQ9SCp0+MqS/1QVKDrPaCblzCBlq/aMmedn+5a9E8QqheGXZJ4f4tmdgyWUBdK0F3OR/qrIVE0F1uf4PxNnGT+zy+aIEH0v8ulTF9hQ4UdPx1DS+TmfER8dN/lwRw1/aaeXbW+Z2zh4KXLSErx142/ubAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkwgaKDVo/gi1rc8+Angb8g13zjXdUqYwSl80TJ6JCE=;
 b=VCOSvJ39yvyZyfVtErYJirOd3L3spRi17drK0FkRqv+nyzKwk5g1hePQYMV0C6vLDQRrSjn//uET2aJzUfK9TNeALinYMydgVcvNKCbwsCkY3tWdHmyMy+nX+xGWxFiPLs3hlzyaGJZG0OemItoFUJhZwroaxIpnq4c6l47a4ZafzhqNWoRaeBkU8MRsbVWyUmoV1hmPVd8Drwhiwcf4PDqUOKo63Qobo7+ApKs+DQrqc2h42p+fYJCY7J1Es9tsGDDi2Mv4PfJT7nquWk1ShFx5lWtcjQRHIeYEqwbBuXyTLzSQORXSXzBRw9eGPA3VyaPA13YfP4Gc+DMPsS6JlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:23:54 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:23:54 +0000
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
Subject: [PATCH RFC 02/14] rcu: Add per-CPU blocked task lists for PREEMPT_RCU
Date: Fri,  2 Jan 2026 19:23:31 -0500
Message-Id: <20260103002343.6599-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:208:e8::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e23db2c-8ae9-4378-f017-08de4a5e6108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rR0cAu/ooNzA8Kq/NumV8fLxsE+ReHbh1BPcVYh6HAJN+qID4SChuIsL0qWL?=
 =?us-ascii?Q?Hd33c3s2RXazGtYZVA+hU963bYue+kf1tfmYwhIe2ayf2soMQya2oSjovCMJ?=
 =?us-ascii?Q?wQt6Dt70tr6XZ+TrUtnZj30t4J/dkb67HijmfW05DLFnlTyNULu3vx07roi+?=
 =?us-ascii?Q?kyB1lj58a5J5TDanq7gkhiIWB7qac63Xeke0Pq1829zGgP7hSJtTaJbBPt1n?=
 =?us-ascii?Q?u4cbnFImv9J2TtHVcqRsuLkrLKYPQPQmSDkBP3e3Pss9Zz0hW4YmRhYHq6XP?=
 =?us-ascii?Q?XgvRnIIae3/t/SYDTaM+vlgUBgk/JYj3/JwWgWNa8BZjl0rer6akIbnzeaAV?=
 =?us-ascii?Q?tI7rmfQ7meGp/Hq6BwAFIX9SFm5yCO4Gsqj5+87NkYqsl+oLLbU9XLPHVPNV?=
 =?us-ascii?Q?HPRb0XXIiNIeCAUiVsMMzko6SEYawyL1E1opSDyy2ZDdGcENjmzCulX0e+2d?=
 =?us-ascii?Q?RTgL92ow9J+lJSW/VoZYpbiBWbJE5VWZyzyb8kO6W9/Xn+HKh+6DjACY4IEy?=
 =?us-ascii?Q?epGE5bLjEboghqWU+hZeOlMB7OMmS/M/CuiQ//CAYqEBR5sWME3T/rVBUlwM?=
 =?us-ascii?Q?RyZ3+kwyv2zTAF3RbbOJlSxg0d71wV06H/EyCk621kXZndS6KYQlgzGVUcZE?=
 =?us-ascii?Q?6xIFeA55tcb2wnpq5Vil17cC51JcRUvo5wW1BMSXui+y/3eGzkusWXwkZVTt?=
 =?us-ascii?Q?/gHC77xrkrGYKeh8BGJHXG+E9X8bV0KnwMGXMAiKsrB88OBWVMJgIsQkA9Pc?=
 =?us-ascii?Q?SqyAuzJYe0kp9vKH2Enayz9As4zxHHgf85CBxC1MXQkAZHLNyaKR+Ye86laK?=
 =?us-ascii?Q?0fYBY13n4FCsyLdqcqSo/U187v0Q068YC4RQWgEXbBQw4Z7DAKUkBJItC9lB?=
 =?us-ascii?Q?UlRrwK/dx9Fjkl5Vbluhlk7t2QrAtpDaWY7OGgYQKP5Kqf+3fQffzAB5oqwr?=
 =?us-ascii?Q?O1dw0ANiUpK5HHkLVRvhpzdF1m4FgNlFmxU/DwhW9B3oxP+I2ySDQu0IVr1k?=
 =?us-ascii?Q?d6icH9wiGBopfKLM4BC/fC3zfwHDNjXrTti6OsHDg10QoRN5UGh/70ePgs0Q?=
 =?us-ascii?Q?8dKGHrXZ0z2M0OQe3rMvHPGeiTKSYvBSzGhMtQ/5YHoJ3JPiNa/fmJZ7M+1X?=
 =?us-ascii?Q?kyWv6OboSenR04tyX5OvRwTTkmg72XaCNY16yU6AqEGOR54XXS1G6tI2ZoPS?=
 =?us-ascii?Q?9Jn2hjMrggvG3IekjIp2j0mAEkHT46VnbjXC6hF+rpTIXms5ipydH10CFqFt?=
 =?us-ascii?Q?O4ea15IhREfiv+/u7LFgYi8sTVJAknRC1FA/wmwMUaI/Se8vQkXam+OJL3r6?=
 =?us-ascii?Q?4CTL/b3ozTnDcMhKimd08PVdPOcuhyspiB/NKL4i4Jb7gTKj81AtO87FPbLO?=
 =?us-ascii?Q?rA5ZJd6AFKJwHorGdDE/qRJuwO9gBlW2S6mYA/mzfw8qFQDhkUPrUkZRvoAn?=
 =?us-ascii?Q?fpJ+41/jvksIgN549r61D8A1mUbU4YLw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pmkoR9NIFzUskAtB0WQajEGDEBdv4H320a2pXlkww2xXwjaDgrTNtQmEWBpz?=
 =?us-ascii?Q?ISCiro0ZYOpV+ZP6xToJnjcr9/6675DolW7lf4c1cvT/ESe6WgNdH8u6JiLW?=
 =?us-ascii?Q?hY6VtmF7NSGRgeSA7vUFItRzV8IXFPsb0qgMxVBJFTb/uVUdyfau5zg+T2kC?=
 =?us-ascii?Q?FkaZK+aCQ1myAjlVVtaKzXu1hV28SZLZNEVg7lujiEYebU4GnEzapmHnWK89?=
 =?us-ascii?Q?UGt93DhTP1Jm8kzwML9kJau4LB5XZaAF8wlNxCynrvh5Et5wxRbSNnVYqR0E?=
 =?us-ascii?Q?u0/OP/T6jOk38oGi9cO8rFe3blLFJ94YpPxoL8vpqNuI40lEK9oVx35xYmuD?=
 =?us-ascii?Q?YvbCKHjx5KYLf8SMyUQemib1oa3c9latZ2QfKV7tInTjiK3eEG6vtfiXmBei?=
 =?us-ascii?Q?OnLX8SX78+o0curbLB5cJLKQmq235nE2eQTwVbmjdO9TCWqTT2kXOElxzlpC?=
 =?us-ascii?Q?nyWQf7lXKtRln9otRr0cKHbZHQam3Fobb0DjwhMdaJwLKlP3HNHyrdQd7Jl9?=
 =?us-ascii?Q?xr79tUJ8C8+0rFjcxt2HDSRTBWfKr71X50VkkDltifnKauZTcZlSlusrJOXY?=
 =?us-ascii?Q?zdH/p68HXI1VUjotQACjbrLToAjWZZugouwJD8vNoaEC/iW66KccqKbKQbzk?=
 =?us-ascii?Q?VSOuOmOu4J1ozM1aHGWrcw2eU9s/H71jr7J/lKlTbq9lyFiSgTNcjCfrTfcZ?=
 =?us-ascii?Q?Vpsnn82dCQrvwO4qDGyp9SlXaCWZrNSnN8xWJb1EP4LoFqM/gCw1fp0UUoUb?=
 =?us-ascii?Q?WTxZdOP/nJ5jcs09TxENWIz2TuhbHwkIeN/qkyvY5LpsKU4aFr9U+x6TOucK?=
 =?us-ascii?Q?sS7/meahK5oH8pNo4KHqIxhElO5/v0aGYWjHeZOjBfsiGaM9H4jt9Pp9J+EJ?=
 =?us-ascii?Q?fGNZ4bwHDxJKOAHZxjNoO2SNbYCGRLosI+/sr569BObazVTg2/wHPk9DlYYx?=
 =?us-ascii?Q?sCwaxyJqRoMA4SgJq4T1vCVdFjCdevh4G8Nd+7uYdXAjq6cYRAVzzc8docB9?=
 =?us-ascii?Q?evLzdG/Gcf3hoBn8WVACzsTDzvTHK5v6KVp0xEOUcbalIx/+UINP66kba4ZE?=
 =?us-ascii?Q?axcXnDwK2XiXxsI4s3qK7sUefnrJT3D+wc7Hss+ihQAzxraCWVkT1SuOu5sE?=
 =?us-ascii?Q?wwzAg18FLixgZ8+fOBCJXvaE0o5bPdE8CZBE+Xf7loYzEzDWzgvA/sxPGy7Y?=
 =?us-ascii?Q?JrPvDO0h31B/gTBEButG2WWLMfxg1KQ0obD3DzFD7ubDQhbTNRQAd8VrPdvf?=
 =?us-ascii?Q?l2gF5/eRhe9uvzb4b9LCD1WIXYIjYss2iM9qvqFfPyCo5qhpEc/cgh65WzHT?=
 =?us-ascii?Q?hyJoiLmCfu4xTZdh5HBVVTRp9rhgiW5i8EdWMNe7mSzls1/iiWtl6THjQJf+?=
 =?us-ascii?Q?pgd4WCN0EA3mNpXWgTo6Ce3wfy3C6NRO5w5WkpfmiMqOejykw0mQisF1/FG3?=
 =?us-ascii?Q?A16QfXuDrKrf8cM9EMSotGjfuO11uI9Zry7jqWxzzkK3kRbm0xABiydIMIXy?=
 =?us-ascii?Q?UEdqKZyy3/gQyTtoZfZo7mZhd1DikwVk1ETY6c/t/Egs1Ju8HjU1PVDMgmdz?=
 =?us-ascii?Q?IyosGlfmk+/+/HMnNqJydNQMj5XQb25zE+FouxpsQ9jlE1vFlt+iGftQnCv5?=
 =?us-ascii?Q?MJ1+Oa0pPCB3Gp8PAzBZ5MC6AS4rpZdZPTkAM1Oc6saO9gBMHseMsGcaJTjG?=
 =?us-ascii?Q?SyLDVPPv1K8GOUZd9ayu2vkXR6VTBfcW3nhrmer+11frwGRKAlMB7Ch7w+f2?=
 =?us-ascii?Q?vj1lBB/Kmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e23db2c-8ae9-4378-f017-08de4a5e6108
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:23:54.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xrd6d0bSVOfwDPxx9Oqb8vVMwGKguoitfco+fEawo7B+9JeSblKCNJHys132NrZ21NHOqbHXgMP5iG4MR/ipXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

Add per-CPU tracking of tasks blocked in RCU read-side critical
sections. Each rcu_data gets a blkd_list protected by blkd_lock,
mirroring the rcu_node blkd_tasks list at per-CPU granularity.

Tasks are added on preemption and removed on rcu_read_unlock.
A WARN_ON_ONCE in rcu_gp_init verifies list consistency.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/sched.h    |  4 ++++
 kernel/fork.c            |  4 ++++
 kernel/rcu/Kconfig       | 12 ++++++++++++
 kernel/rcu/tree.c        | 32 ++++++++++++++++++++++++++++++++
 kernel/rcu/tree.h        |  6 ++++++
 kernel/rcu/tree_plugin.h | 21 +++++++++++++++++++++
 6 files changed, 79 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d395f2810fac..90ce501a568e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -931,6 +931,10 @@ struct task_struct {
 	union rcu_special		rcu_read_unlock_special;
 	struct list_head		rcu_node_entry;
 	struct rcu_node			*rcu_blocked_node;
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+	struct list_head		rcu_rdp_entry;
+	int				rcu_blocked_cpu;
+#endif
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
 
 #ifdef CONFIG_TASKS_RCU
diff --git a/kernel/fork.c b/kernel/fork.c
index b1f3915d5f8e..7a5ba2d2c1b5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1819,6 +1819,10 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->rcu_read_unlock_special.s = 0;
 	p->rcu_blocked_node = NULL;
 	INIT_LIST_HEAD(&p->rcu_node_entry);
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+	INIT_LIST_HEAD(&p->rcu_rdp_entry);
+	p->rcu_blocked_cpu = -1;
+#endif
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
 #ifdef CONFIG_TASKS_RCU
 	p->rcu_tasks_holdout = false;
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 4d9b21f69eaa..4bb12f1fed09 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -248,6 +248,18 @@ config RCU_EXP_KTHREAD
 
 	  Accept the default if unsure.
 
+config RCU_PER_CPU_BLOCKED_LISTS
+	bool "Use per-CPU blocked task lists in PREEMPT_RCU"
+	depends on PREEMPT_RCU
+	default n
+	help
+	  Enable per-CPU tracking of tasks blocked in RCU read-side
+	  critical sections. This allows to quickly toggle the feature.
+	  Eventually the config will be removed, in favor of always keeping
+	  the optimization enabled.
+
+	  Accept the default if unsure.
+
 config RCU_NOCB_CPU
 	bool "Offload RCU callback processing from boot-selected CPUs"
 	depends on TREE_RCU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4..e2b6a4579086 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1809,6 +1809,14 @@ static noinline_for_stack bool rcu_gp_init(void)
 	struct rcu_node *rnp = rcu_get_root();
 	bool start_new_poll;
 	unsigned long old_gp_seq;
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+	struct task_struct *t_verify;
+	int cpu_verify;
+	int rnp_count;
+	int rdp_total;
+	struct rcu_data *rdp_cpu;
+	struct task_struct *t_rdp;
+#endif
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
@@ -1891,6 +1899,26 @@ static noinline_for_stack bool rcu_gp_init(void)
 		 */
 		arch_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_rcu_node(rnp);
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+		/*
+		 * Verify rdp lists consistent with rnp list. Since the unlock
+		 * path removes from rdp before rnp, we can have tasks that are
+		 * on rnp but not on rdp (in the middle of being removed).
+		 * Therefore rnp_count >= rdp_total is the expected invariant.
+		 */
+		rnp_count = 0;
+		rdp_total = 0;
+		list_for_each_entry(t_verify, &rnp->blkd_tasks, rcu_node_entry)
+			rnp_count++;
+		for (cpu_verify = rnp->grplo; cpu_verify <= rnp->grphi; cpu_verify++) {
+			rdp_cpu = per_cpu_ptr(&rcu_data, cpu_verify);
+			raw_spin_lock(&rdp_cpu->blkd_lock);
+			list_for_each_entry(t_rdp, &rdp_cpu->blkd_list, rcu_rdp_entry)
+				rdp_total++;
+			raw_spin_unlock(&rdp_cpu->blkd_lock);
+		}
+		WARN_ON_ONCE(rnp_count < rdp_total);
+#endif
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
 		    !rnp->wait_blkd_tasks) {
 			/* Nothing to do on this leaf rcu_node structure. */
@@ -4143,6 +4171,10 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->rcu_onl_gp_state = RCU_GP_CLEANED;
 	rdp->last_sched_clock = jiffies;
 	rdp->cpu = cpu;
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+	raw_spin_lock_init(&rdp->blkd_lock);
+	INIT_LIST_HEAD(&rdp->blkd_list);
+#endif
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b8bbe7960cda..13d5649a80fb 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -294,6 +294,12 @@ struct rcu_data {
 
 	long lazy_len;			/* Length of buffered lazy callbacks. */
 	int cpu;
+
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+	/* 8) Per-CPU blocked task tracking. */
+	raw_spinlock_t blkd_lock;	/* Protects blkd_list. */
+	struct list_head blkd_list;	/* Tasks blocked on this CPU. */
+#endif
 };
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 73ba5f4a968d..5d2bde19131a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -338,6 +338,12 @@ void rcu_note_context_switch(bool preempt)
 		raw_spin_lock_rcu_node(rnp);
 		t->rcu_read_unlock_special.b.blocked = true;
 		t->rcu_blocked_node = rnp;
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+		t->rcu_blocked_cpu = rdp->cpu;
+		raw_spin_lock(&rdp->blkd_lock);
+		list_add(&t->rcu_rdp_entry, &rdp->blkd_list);
+		raw_spin_unlock(&rdp->blkd_lock);
+#endif
 
 		/*
 		 * Verify the CPU's sanity, trace the preemption, and
@@ -485,6 +491,10 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	union rcu_special special;
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+	int blocked_cpu;
+	struct rcu_data *blocked_rdp;
+#endif
 
 	rdp = this_cpu_ptr(&rcu_data);
 	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
@@ -530,6 +540,17 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		 * to loop.  Retain a WARN_ON_ONCE() out of sheer paranoia.
 		 */
 		rnp = t->rcu_blocked_node;
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+		/* Remove from per-CPU list if task was added to it. */
+		blocked_cpu = t->rcu_blocked_cpu;
+		if (blocked_cpu != -1) {
+			blocked_rdp = per_cpu_ptr(&rcu_data, blocked_cpu);
+			raw_spin_lock(&blocked_rdp->blkd_lock);
+			list_del_init(&t->rcu_rdp_entry);
+			t->rcu_blocked_cpu = -1;
+			raw_spin_unlock(&blocked_rdp->blkd_lock);
+		}
+#endif
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
 		WARN_ON_ONCE(rnp != t->rcu_blocked_node);
 		WARN_ON_ONCE(!rcu_is_leaf_node(rnp));
-- 
2.34.1


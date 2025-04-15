Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15D14AD0D;
	Tue, 15 Apr 2025 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724198; cv=fail; b=LztC4e8Sh4CGvYGtgsipNWX+AnItvNeXazK0AkJ7k9TJTgqBrGwak0sozjROTTJrJS7vgcEspF/ZLbFIXXj17+QrgXpVgw7dcpqpTNMLh74v+hjDDIV3DvR6u5Zo8+ES7QoNXmMq4eXsCQGtBZHS6gcoYO8EpF/yVXLMwseevrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724198; c=relaxed/simple;
	bh=QPOkbZSaTsv41VHFGW7yDfcZRVp3XP8WZhwS71BU+sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qdt79uj+uj0mZGd8oTiB2Ig4gF4XHc3cLs5xvIduVJ4slaRZNm8U2bpFSXRQrXUxJB03z/1Mpbxez61Ynh46ahgwse9RJB4rML0vw8xAgmySEoBpzbuF/406SNg1BmP2EypGkSbJh9cayX7L2UIQxaZZegZ9frxbIMSI7of6l6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nvp7x/K+; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nvp7x/K+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ/IZ2N019CoRBpMxZRD5iwOmLpHhfwo6X+JNuGRqyxtd9NgbM1LRjxjR9T7QYGAPTGo0iCw7qe2Zh9qrqUdy5mixm2cobShmm8Ww3tR/S8BfR8Z7ws55yeuYN8VBx+kyAd+7dvEHxiLB4llccpuMVhv059A14pzE36qiqIZBygXzAaD9Lo/k1tqRLb1sfuTkLk0T6tKV8foLVdpDrwjoCCRAdibeuODuftqa4+92CI9HmuqjPfssF3pbGuc8ZAuorDpJYNJCV8bO2VvWyhjPEyvC+DLl+4GxTiFf4KYz82aR0BzSDZ3inTJ7+0ijKkiWMlaxD7tBDTG0Z/wTkWpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au/kVA0lTk+kNTsFjV0YJEfx9ZCiFsfubc0HvgdVpSo=;
 b=PvHgePldnyqzcF75o6zVwlBu6VUgzsrteJ72HNRlSO8MwP6vQHVUTwyj5gIz36jaZ9sf2yl0MZbsWqni+VLsO+g3nLgLBaCKLv4gwyFjEGE+htLJ/88+3PoqRdnu3MEzZ5G786ck32cjq2tjHIYTO97l1hQn194n0EMltmqUm9LeVcLsJOqwIElwvBMlEXTk9k3STsCO7eBpcvP5Z8jqaSASHex3yRwHBVk+OzRVPeGnL2Fc5BOMD+UTbhgafAfK2hFKSneNMOXcyOPo8NMI+3obJojalF2jfRgM5uftwCAvXLVoagjZ/JG1qQ5D4ldq9UsGjkp1F9cAkysvFwp0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au/kVA0lTk+kNTsFjV0YJEfx9ZCiFsfubc0HvgdVpSo=;
 b=Nvp7x/K+sxAZ2u7Z4BgzPFnak2aDcD1pdJ4YMibHT+FOirhkUgqHH/1TCHxWLuOAyHgv0Wk1HcPXeK1KvE259rFKo/sO1OsBtL2xlDuG+YjM3is5YXp5v32HkT6YsuyOl73CNXTqhh+DTmRnRt8rRbHrgC/hpOWSskTTlApkIXMGgBb7KYKeUSx5sOCyrQ9dLimiLEkt+l9H4DqwF+Juhrahs/X9BvDjmi55Lha9mn4ZfSzZsKtCccipIXASo5/7C6szWowgkuZEeANu7CpAbiRLUNhX97dbwHqNYw5mnB5Hadv3ow1/qRvwSvYYUE6RqBXWeA5sJUAhrOH96dHMiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 13:36:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 13:36:31 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH v4 1/2] rcutorture: Perform more frequent testing of ->gpwrap
Date: Tue, 15 Apr 2025 09:36:20 -0400
Message-ID: <20250415133622.1563137-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415133622.1563137-1-joelagnelf@nvidia.com>
References: <20250415133622.1563137-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:208:32d::13) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 169d5074-d482-4a16-b0d1-08dd7c22883d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FZ8/40QmH89tkosod5sd/K03oC7sOFU0esclWN7eYDxnXdhIoOedZeRy8eel?=
 =?us-ascii?Q?e3htVmhkCXT7lPek9XCLsuAp6gOeiqxa3SXloBIZRyH5VYzYO2gLQhNcOqzx?=
 =?us-ascii?Q?ZIwZxkZTNIiApa1MfeckbUYaMAzUQhFdU9Hv1NLPrW9jgSL/VNuQPcMxJY81?=
 =?us-ascii?Q?EI6K9cy3NuxK1y2fueuDaC1tHI6Sg+CSDNRTdDRUAXhDklzQhmHUWNxhE44O?=
 =?us-ascii?Q?AokjBEqwWB/qonDppo38IO5WXi7T5UU3E5pVbKluTvvQnVIVrScJqU4MNdSo?=
 =?us-ascii?Q?pIPUczPdqcNCt6VKRGBkORUUaHLeo7u89r+mp2xJJfVu4MjnlYwsr5YHITzB?=
 =?us-ascii?Q?V9Q3qEXmkc8YOb1rqaOg3wEHgMB2Oy4vv+2assyvQQoAUploraJQb1LKnGgu?=
 =?us-ascii?Q?/+nlOWnD24rW2jLCvqTYLjHhM2lbQHWginHWLWvXFTPiYso0D8vsRK93pCpZ?=
 =?us-ascii?Q?ohdXHDPYlDAqONLpknb4BFJX+Y2bskyNHbuWSU4wOH5RlLKa+JeA7+YE7HuB?=
 =?us-ascii?Q?GqbJ5fiqD0clvbxwll30UhEvwjXoRdoHujaIIcjc6rUHgfwVdMn7K//TvMuG?=
 =?us-ascii?Q?EfWMRChdTOcRh6igMtztFOoE207Ou6+KSpSneZtV7+UkZtXsUArQZvuVT/kt?=
 =?us-ascii?Q?zbUj5y3VBBVWJYM7OnsLwUaDWjDw3oCUJ2GkQrobShSQ12nrAZndg90kg2B8?=
 =?us-ascii?Q?mi4Tp+6A7gFdMHuQLT10CQIBCcnREEYeeUX2ZNU4B8zmvqpsIFIe84nIvDId?=
 =?us-ascii?Q?3F3qqKRNaOECgUb0SqXVwM5C2x6WVzXyjL+ipRNpleCkNmZCly6T6QyRR7yW?=
 =?us-ascii?Q?qze4hU0iO/Mq0X5QuI1kKq67w3INr1w/mnSB6hnGdbRu4p4qZ8HcA3/FnqAp?=
 =?us-ascii?Q?ZBiu8IY30wb0ELjNvC5xMQii5u4CWNce8WzunJnjD5Vd6/YhbHizdB9IuMd0?=
 =?us-ascii?Q?lzBtWpJAu4xaCRkaMaMqd217ndQgwlqCnkR7TsAq0h+4xYF4HE6C2I2t5IhC?=
 =?us-ascii?Q?61+qZKHEkwPlSAULoGK/HucJkK2yYlIM7STmR4EemBXiJwWLaCaH9PaeFDKE?=
 =?us-ascii?Q?1oQYAPVMRcci9IpsLUnyGUWLq8ZA/NWOgNGJ3uv4MoC2hfLcwWQBggIRkK2r?=
 =?us-ascii?Q?cf0155kUGbosWi9O0cDqYGGCUk/jFpUleVKipyBPzHGXgz9GfeBfwrOyI2kh?=
 =?us-ascii?Q?J+3GZtd/Iw1YeSBmYcXoqlXv7x3vZc6BfeYMTb95ssI2FhcYDd7dK3FBOT6C?=
 =?us-ascii?Q?vhd8FLE6LqaSpAcUpSfgeuLqWJH8Kv8WddDj5qtbKPuJpuEkJtDhxQdS8ggh?=
 =?us-ascii?Q?HQGQGQF/BdiQxUVLyOia0JeFFmO433tG80qfkY07nq+F/lkw1/tDkRKPGrxT?=
 =?us-ascii?Q?bdybiyvQpAKv+EJYYNJjwp/uQqR8TMT+w1Wjlo3j/PsskkCIjjqfENnI5sUG?=
 =?us-ascii?Q?QNAMNpAYf78NRya3LbV2IttFeD7jHXMVx1u2lJZj8r34FZfkgfpmmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fm1hLsZuStTpRzpg7ogue7dc+j/yIucyDCRTz07x9Af8Cks1WyLMYTuBSDyi?=
 =?us-ascii?Q?4if2aeZ8HGPZKTyzS3FkhmHhyHMjMVEPQGQgW+JDt/8olIOtu3B773uvUB8O?=
 =?us-ascii?Q?tCPLEcR3RVxwxENsePWpCgPi1upiqtSLx+UNlzYrGMUFmiQkWia82UEaIeFn?=
 =?us-ascii?Q?64ZhaSXWvvjjfwlaijAqJip8o4K00NJg0Gbndh2lXmB1IyAcp+C8ooT2E/JH?=
 =?us-ascii?Q?chqTFW2ClGi1XlzqnvPALnby1p1RBwSiYMblzxcA9a/wRTKU8sKMFBD1M2nQ?=
 =?us-ascii?Q?rnkeKjUtNfAPbf8eFUEHcOS6Qo7kfD7xXeKgrZLIIYrLSc+Xks0GULPoKoik?=
 =?us-ascii?Q?nXfz2VIgVldg0WSx069Y4PHbL8h2FIqDK8IVCJc9iHLqZWM9GTyeNKDJjMN4?=
 =?us-ascii?Q?wtlV3/BlrNCOVr80dpotUJgtAbHPdsl6no9vvaSMvBaCtSP30OnjT7JdsBDi?=
 =?us-ascii?Q?BDO6OZ+aoimpdEElbz+IfXmyzVvYMO8Z17bfzjAEBw0kc/sLEgK6qvQ3Wuuk?=
 =?us-ascii?Q?OskGoXlbX4lSGTVgejaJAB1XdXkmPY6Qa6B6bnU6tCPlILIt8fJeHBORN0ih?=
 =?us-ascii?Q?E4HnCt9cqiM+L8ikifN9Br4Q+Kr2V71lUsxTWAzHxKF7fAub1kcCpUnDJmMQ?=
 =?us-ascii?Q?NBrBUEKE7D+47YjgmebghirVehj2+1B/6hhvSiR+ifS/ze1xMI/nIJNksahV?=
 =?us-ascii?Q?kaiaKTI7sBggELwgCWCU8gLbVRt7xPp9ZR2085yqL+T1IIcFx/cXCRlPmGYt?=
 =?us-ascii?Q?KC/uAYLM7ckqmiQWlFDS4/awq1HVGEKLrJiM4LRkoC3EyoB+YipQOYCW+M2K?=
 =?us-ascii?Q?Uyo8pDjgYS7C3jmfqZiwKHLcu8clA3gfTUE2HgQ96boU1SwFf91FpLK/0YWX?=
 =?us-ascii?Q?ibBiIFSY8ciqXQiL8HiE0avyH9688pZww3ahamxOfv6IynpD+Ct1mhPf/DX4?=
 =?us-ascii?Q?9mseNhufHk1NkEv7QNchV7RHM2fY3dwY3YpXH11YUbb907TAZYYnojkWDmcJ?=
 =?us-ascii?Q?Fadsmg028by+JoR7DGDav2Do/iy35F6xI0fxiC77K6z10bj+G2O98h3tRtOd?=
 =?us-ascii?Q?w00do7xa4bbPl1AwVP5h+Mh//VLLZrI1x6Cncb5nThDNV0lS4qZ8I/I4wubV?=
 =?us-ascii?Q?hwbG+QD0g3b41aEP8ebjmaa+EVsXWjnC2Ju0pNnhpml8Rqe7yrl4jPRCK3j6?=
 =?us-ascii?Q?JS0PKYLpiZYr8/geSCXpTbv+5cHzWkEq0XEyH2cvECSRMPTwKFt64Wy2Jzdr?=
 =?us-ascii?Q?MHr67DpvUvol421BKH3kSTZr8w80x63NZ3UFGsRmT+wyE0rCKFEynRVlvOta?=
 =?us-ascii?Q?+MgFLCsZRcdeZAYDZyAVKj36anvh75KoDh2pqSpmMgcloZ7aQn2kKzV3S+Nm?=
 =?us-ascii?Q?0JS/iEZxr1ls9mHkmbOmEw3AqkCEsq6gjzbbAMrD+fRcEDvR9L4WH5K2y8Tp?=
 =?us-ascii?Q?xGBbTdDERKl2L+n86d953vlQ/DgKWmlhGO13N2bBT5oai9sGuy9ixJyFFjM7?=
 =?us-ascii?Q?d2xiBvEgbw8psaR3QQmaUQeSttKRMHTYY7m4m4bMtRwDEwMHBzNcuyUoYTLm?=
 =?us-ascii?Q?Xwdqm6hg5DeHlICXHxYNmsSitcqbXNMVGnBAn4PR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169d5074-d482-4a16-b0d1-08dd7c22883d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 13:36:31.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIYK/KtCZHxa7him4uKdtRWVtAIOu0VzO3TkeK6aoRmHZ7aUadh0pPv1arBMVVFAPf3tdnTL2oltQ+h7CEZsCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868

Currently, the ->gpwrap is not tested (at all per my testing) due to the
requirement of a large delta between a CPU's rdp->gp_seq and its node's
rnp->gpseq.

This results in no testing of ->gpwrap being set. This patch by default
adds 5 minutes of testing with ->gpwrap forced by lowering the delta
between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
configurable, including the active time for the setting and a full
testing cycle.

By default, the first 25 minutes of a test will have the _default_
behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
this is reasonable since we at least add a little bit of testing for
usecases where ->gpwrap is set.

Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcu.h        |  4 +++
 kernel/rcu/rcutorture.c | 67 ++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree.c       | 34 +++++++++++++++++++--
 kernel/rcu/tree.h       |  1 +
 4 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index eed2951a4962..516b26024a37 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c_old,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
+void rcu_set_gpwrap_lag(unsigned long lag);
+int rcu_get_gpwrap_count(int cpu);
 #else
 static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
@@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 	do { } while (0)
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
+static inline void rcu_set_gpwrap_lag(unsigned long lag) { }
+static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
 #endif
 unsigned long long rcutorture_gather_gp_seqs(void);
 void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4fa7772be183..74de92c3a9ab 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -115,6 +115,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, gpwrap_lag_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
+torture_param(int, gpwrap_lag_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
+torture_param(int, gpwrap_lag_gps, 8, "Value to set for set_gpwrap_lag during an active testing period.");
 torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
 torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
@@ -413,6 +416,8 @@ struct rcu_torture_ops {
 	bool (*reader_blocked)(void);
 	unsigned long long (*gather_gp_seqs)(void);
 	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
+	void (*set_gpwrap_lag)(unsigned long lag);
+	int (*get_gpwrap_count)(int cpu);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -619,6 +624,8 @@ static struct rcu_torture_ops rcu_ops = {
 				  : NULL,
 	.gather_gp_seqs		= rcutorture_gather_gp_seqs,
 	.format_gp_seqs		= rcutorture_format_gp_seqs,
+	.set_gpwrap_lag		= rcu_set_gpwrap_lag,
+	.get_gpwrap_count	= rcu_get_gpwrap_count,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -2394,6 +2401,7 @@ rcu_torture_stats_print(void)
 	int i;
 	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+	long n_gpwraps = 0;
 	struct rcu_torture *rtcp;
 	static unsigned long rtcv_snap = ULONG_MAX;
 	static bool splatted;
@@ -2404,6 +2412,7 @@ rcu_torture_stats_print(void)
 			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
 			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
 		}
+		n_gpwraps += cur_ops->get_gpwrap_count(cpu);
 	}
 	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
 		if (pipesummary[i] != 0)
@@ -2435,8 +2444,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
 	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
-	pr_cont("nocb-toggles: %ld:%ld\n",
+	pr_cont("nocb-toggles: %ld:%ld ",
 		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
+	pr_cont("gpwraps: %ld\n", n_gpwraps);
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -3607,6 +3617,54 @@ static int rcu_torture_preempt(void *unused)
 
 static enum cpuhp_state rcutor_hp;
 
+static struct hrtimer gpwrap_lag_timer;
+static bool gpwrap_lag_active;
+
+/* Timer handler for toggling RCU grace-period sequence overflow test lag value */
+static enum hrtimer_restart rcu_gpwrap_lag_timer(struct hrtimer *timer)
+{
+	ktime_t next_delay;
+
+	if (gpwrap_lag_active) {
+		pr_alert("rcu-torture: Disabling ovf lag (value=0)\n");
+		cur_ops->set_gpwrap_lag(0);
+		gpwrap_lag_active = false;
+		next_delay = ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0);
+	} else {
+		pr_alert("rcu-torture: Enabling ovf lag (value=%d)\n", gpwrap_lag_gps);
+		cur_ops->set_gpwrap_lag(gpwrap_lag_gps);
+		gpwrap_lag_active = true;
+		next_delay = ktime_set(gpwrap_lag_active_mins * 60, 0);
+	}
+
+	if (torture_must_stop())
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward_now(timer, next_delay);
+	return HRTIMER_RESTART;
+}
+
+static int rcu_gpwrap_lag_init(void)
+{
+	if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
+		pr_alert("rcu-torture: lag timing parameters must be positive\n");
+		return -EINVAL;
+	}
+
+	hrtimer_setup(&gpwrap_lag_timer, rcu_gpwrap_lag_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	gpwrap_lag_active = false;
+	hrtimer_start(&gpwrap_lag_timer,
+		      ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0), HRTIMER_MODE_REL);
+
+	return 0;
+}
+
+static void rcu_gpwrap_lag_cleanup(void)
+{
+	hrtimer_cancel(&gpwrap_lag_timer);
+	cur_ops->set_gpwrap_lag(0);
+	gpwrap_lag_active = false;
+}
 static void
 rcu_torture_cleanup(void)
 {
@@ -3776,6 +3834,9 @@ rcu_torture_cleanup(void)
 	torture_cleanup_end();
 	if (cur_ops->gp_slow_unregister)
 		cur_ops->gp_slow_unregister(NULL);
+
+	if (cur_ops->set_gpwrap_lag)
+		rcu_gpwrap_lag_cleanup();
 }
 
 static void rcu_torture_leak_cb(struct rcu_head *rhp)
@@ -4275,6 +4336,10 @@ rcu_torture_init(void)
 	torture_init_end();
 	if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
 		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
+
+	if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
+		goto unwind;
+
 	return 0;
 
 unwind:
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 659f83e71048..6ec30d07759d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -80,6 +80,15 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *);
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.gpwrap = true,
 };
+
+int rcu_get_gpwrap_count(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	return READ_ONCE(rdp->gpwrap_count);
+}
+EXPORT_SYMBOL_GPL(rcu_get_gpwrap_count);
+
 static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
 	.gp_state = RCU_GP_IDLE,
@@ -757,6 +766,25 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
 }
 
+/**
+ * rcu_set_gpwrap_lag - Set RCU GP sequence overflow lag value.
+ * @lag_gps: Set overflow lag to this many grace period worth of counters
+ * which is used by rcutorture to quickly force a gpwrap situation.
+ * @lag_gps = 0 means we reset it back to the boot-time value.
+ */
+static unsigned long seq_gpwrap_lag = ULONG_MAX / 4;
+
+void rcu_set_gpwrap_lag(unsigned long lag_gps)
+{
+	unsigned long lag_seq_count;
+
+	lag_seq_count = (lag_gps == 0)
+			? ULONG_MAX / 4
+			: lag_gps << RCU_SEQ_CTR_SHIFT;
+	WRITE_ONCE(seq_gpwrap_lag, lag_seq_count);
+}
+EXPORT_SYMBOL_GPL(rcu_set_gpwrap_lag);
+
 /*
  * When trying to report a quiescent state on behalf of some other CPU,
  * it is our responsibility to check for and handle potential overflow
@@ -767,9 +795,11 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + ULONG_MAX / 4,
-			 rnp->gp_seq))
+	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + seq_gpwrap_lag,
+			 rnp->gp_seq)) {
 		WRITE_ONCE(rdp->gpwrap, true);
+		WRITE_ONCE(rdp->gpwrap_count, READ_ONCE(rdp->gpwrap_count) + 1);
+	}
 	if (ULONG_CMP_LT(rdp->rcu_iw_gp_seq + ULONG_MAX / 4, rnp->gp_seq))
 		rdp->rcu_iw_gp_seq = rnp->gp_seq + ULONG_MAX / 4;
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a9a811d9d7a3..63bea388c243 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -183,6 +183,7 @@ struct rcu_data {
 	bool		core_needs_qs;	/* Core waits for quiescent state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
+	unsigned int	gpwrap_count;	/* Count of GP sequence wrap. */
 	bool		cpu_started;	/* RCU watching this onlining CPU. */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
-- 
2.43.0


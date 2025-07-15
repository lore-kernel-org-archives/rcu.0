Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3529E117;
	Tue, 15 Jul 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609752; cv=fail; b=J/EFbTSEFcCE55ecy3CrqE5BIrXvXX7M7+AuN+01qINdUZ/ec2ZGZyYrzrH5FoKkWunZg895grVCj8Nx2Aigfvp3d+/NH1ccD1eriTBaElEjyWsg8rLAaBKp3Ane2dPQnXOSoeAezB89TGxrpt7YiVNhNwlAQrS7xU+5WakCzOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609752; c=relaxed/simple;
	bh=LvugUNZai7aPSOKZwGDYbgKnyUYOaYeLeLQPLNcfP+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cHCCwyWmAUBfvZwowA0yHydZ3TOzn0ks+WZqdszQjVTdn7/1QbbsncMDxn8zRvbnm77wUg4pbnPzwGY3WOR/lE3g4IyFKZERAI5+sbL1BwLpQuoCc8uIOzVjqBCiAFOJGqubdia0XZMAyi9/pP9ttHu/K939L5ifLb94fTY/jmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LkbEGjBq; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LkbEGjBq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGZF1hmrybkyi9RUf3bH4YaGF7kWLHO+rdv7p+UURqFyCECSGdZnOpDjUDJQuZK19xyASv5VU9Do1Iv0nVJCOyTLzqUQ6D7tfYZ2isiWDzkFdL9mTbctH12RN2Dip6TFv04+LYlhKafH1u8HScg90opUO8OBOhdx6CHqf4Cxy4i/vdpHs+0G8iv9KqF69Ewgm/5BKkh4ztuBv2kL35V0S4rKgzsBfqzIWMSwG/YnAczSUnOOjJyZ9HqL2QSxyse4mNbF0eCAQBE1d/55uN/KpWgqMb9OZjFw7xH6VpEP4+tQbjF42KM6kA3hEMUNMIIhCj7nCjmM7/V/Ip8UT0fHzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fB3nWIfJofqHV0NWEzYd+61pWgh5AxwM7NjD7i1KVY4=;
 b=tTZoQA9IqJPKMA/DHzeImRp1/LCtk428/OvlaKPe9/IM/eyEFMGiJ+wRy/vKje7t37vy5LGi+NxX4vAlXOCFDtnV2nszBcOs/eoBuHdZS/shs1/6IJggPBr+3mTzjaEqlZHX89p2gDqBkrumu1kxU25XSYr5ggfgXxW3oNSvszCnRfq1l/nPMLk0T4wn4Pg/pQAn+ZlZ5Np45QBEy/fqRbQoa6ufFCfx4zliAVgJU7gDLFfvG4/00ja4S6uFEoS1TYkPowS7qMZ21vJPH9hUIOb0aI5c7vl5Y42RHJ1LqWDx6X3xhuUP8uHMk6bigHwEoLDWHnjXZNj1aqxGaSLFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB3nWIfJofqHV0NWEzYd+61pWgh5AxwM7NjD7i1KVY4=;
 b=LkbEGjBqRWgigx0VUb4LADE97dcwwUCoglzIAW5l41FWetYNd433OusCdsYPo0+LSdvj1dnsL12gzAy5IyELGVCRTIxnc0F3VVA5G0imHX4s70lDDtrx2PibKanLRYFiC8vd8GV+Ls2UhqDKJFnvLt41r00S8O4rtnj0mVAuw15+KpFTBDvO0cKnY9ueON5ostCf0W3dF7QeRlMR/r+Lu+CjppIXNaywcLR2q1+KZUfM7y3rnh8Anb0SmMJGHSJrEO8QxTQN0GyOzMLXhCnc2Frf5tXpsE4YLEVRfDiz2UEutRZUF/ndIUtI2lq+EHgA5qTuQFvQxO3jDXkxnL3BvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 20:02:24 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 20:02:24 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>
Cc: rcu@vger.kernel.org,
	neeraj.iitr10@gmail.com,
	linux-doc@vger.kernel.org
Subject: [PATCH -next 3/6] rcu: Document GP init vs hotplug-scan ordering requirements
Date: Tue, 15 Jul 2025 16:01:53 -0400
Message-Id: <20250715200156.2852484-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715200156.2852484-1-joelagnelf@nvidia.com>
References: <20250715200156.2852484-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: d5397963-e9d6-4691-ef3e-08ddc3da8460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UmkaZtoKHXMbbh6GIY4x7AM6qHsxg3sRvsYhqi2JEavqPJIJriBOH3ICH+dy?=
 =?us-ascii?Q?c+KUciLmZoBuiVirafl3nc+4RhTTcvcqwyKrtzr+xI7GcTfO3sa4Z4EhJzEK?=
 =?us-ascii?Q?KZ51KuKv1nw68P7GnpE1TNMnPPteIcc8pb+Umb10GqTU16MgGqbVz3tqEWfx?=
 =?us-ascii?Q?rv0ZswpRXqlPDnjQaLhcsDhkPizJpOSqQVDYihzXmNIUGtm4KaacnW66A7he?=
 =?us-ascii?Q?gqr9DwQWxQUZAohX1UF69wiKPKC7y1LgehOeYgUEVmYIUX/St364l8rJrTA+?=
 =?us-ascii?Q?U7r4Ly3jVzZZUQYXxF8+FA9yUO9V+ODbk6Yt3AOCloVYJQi8M59hROQ2NNCf?=
 =?us-ascii?Q?lAopRrz9spx+mjd+dkpawfX+9jDfTdAgfS70USl5x3D/175ms0j9Fl5iVlmb?=
 =?us-ascii?Q?5wV6XxSXuFMlmg+bTTLoPi2f2KuDAvAqIW22YuEZ960anDalc4hYIZqri2jq?=
 =?us-ascii?Q?ld4Gme8lt1uT0FU/7ON2wujFWNd4dft6eoN4DjoTSNcwYS/M7laLQhp1bV1J?=
 =?us-ascii?Q?TQF/w3fVUQAhBo85cOYP6qurs1/ICjQkbdivYHrAzpn9LrVKj22o3hvytuja?=
 =?us-ascii?Q?yS4DNy9/JBhr4OMd9TqtbBSnV6kZHhOwEy0fkBH/wRgDseV19U7NDRPM/DYY?=
 =?us-ascii?Q?pm2TA5u5+1EFtVAo9WM6GBrdGLV0geQsaQgRkNQbE7pjuJoUAAqgw3MmiCho?=
 =?us-ascii?Q?cWLMkmt+DIKQtZiFQBGMHoDkYiQkoyVwuMbqF9pXV87QEKog48/ppnrqugR5?=
 =?us-ascii?Q?8l34iOGLEol6DbceoHoteNlSPmvcyLeYdu3LgitiVjWujNvcoiVzsMuCGT9b?=
 =?us-ascii?Q?xiwn8SjuuNZ28fMKxutcvF1fLQ9Heyyetn1Kb4Y0BqO4emdTT/hdiB3yaUsO?=
 =?us-ascii?Q?MQ4Anqnx27QRV/ui4mEqIumht18lLqXW1ZAezR8HFm2axGUEE1TZH/5yfrHx?=
 =?us-ascii?Q?21RkbjIjZCYlRwfOjcDqky1PV+6lapWxQi5K8bAfinSEXhXXYq6z//0ekMin?=
 =?us-ascii?Q?naZo8e+esqIlSvjCo4iGWUMXJ372fhHL6u+k48/Em2we0mpwK01YSzB5yikD?=
 =?us-ascii?Q?nAqCr8Bs6H/gGHi+DqegBbuH9nEHX3CZZ9n+g3TccyDmnojIyckV7FW0jpoc?=
 =?us-ascii?Q?WeLyqA+K4JauO745qfuElVGSiuVpAWYTbW0SL6rVs1VhOl/WjK164CL70n/w?=
 =?us-ascii?Q?oF6QLfpVSpPkIwktSTK7otWyUHpDZKiPjqEYKLHyOpM7U/KRZ9y3qUHPJ076?=
 =?us-ascii?Q?1IDTxnWLsKHZag2CvHWqYJZqaRlcXeTnQIpbGRgtkiBAPbtxTa0TJ+pDOoEE?=
 =?us-ascii?Q?yPqIvfakFXqG9XABoukqj8BXf5ArFeMbY9PFJDC3fyBT/cUsQl46lnK4NzPU?=
 =?us-ascii?Q?zlv6nkOWX7m4X3QMDuAJdh1cr67ZZX9tC0nidQ1/peJPiyrbzwThe257h1cK?=
 =?us-ascii?Q?dLktAFVdvm9GXhuX81cT0rd+ofvTrr4gJWSFKykWdEZbry2gxhK5eQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Nn0vUpvbc1X/M7GrmFt/EDvNJn4OelAPP/OC5AWpHTMY+5J3o6Jkb1mZMkz?=
 =?us-ascii?Q?z1lPdjP3vlIaeFqK6vez4hFLSPV7MVEFX+HsLpVLInLXFN+20T9o4roYCv22?=
 =?us-ascii?Q?k/Bb7Uf6xl7/nKyXEbArLDU5kwCKKwcgJwKsFo05GWbwmechE1noQo+yEWE2?=
 =?us-ascii?Q?Rs75nD7WoNhSlQJmkCJ6Puu7MMdUzMoXirLCd+0ITP6nmPuIVaoazSJ56p4p?=
 =?us-ascii?Q?viqikKjmnDfeEsCza97Uk6NoAKJwJYUaqd+JJ5GqFOIdhVUwxH5eQicQMc6r?=
 =?us-ascii?Q?vgVbgf6og4uLnlkDPSsTBFqJMm6Rm7kubqT3trNHoAFK73SLT6YmLd/gigUk?=
 =?us-ascii?Q?ft4VUxpyOwe8NT6eV20cz1Hu3P0bRlM+F344gChZE5l0kA1CayvDfFgTkUUA?=
 =?us-ascii?Q?yOYRRiMZZq/RUjTLYFYQaYJ6TnVECspK/grAOx3Ivs4oDvAf1gcBwiMBToCQ?=
 =?us-ascii?Q?PXa9K3UmD5n0r8oQAf9nk58H1+LcaCv8+4w0wKSsoa6Xl9CQjeQhdsYCp+8s?=
 =?us-ascii?Q?6N4vmzv9yRP2e6tTYjVwFK0MdZpw9RwmIh7SEldqyoFWah4K/Q8y+cw0BWsc?=
 =?us-ascii?Q?Exb0IiQOyHl5ywCE26LSm1pcyU8j5Q08TqY1TDhoEjFdwJ9ThTDTuaVvWBIR?=
 =?us-ascii?Q?fFA7LqJY1jrO3ZNgfSK/3KA71nUVOLBwi9D8boAcMbEzQ4KwFZ/BzYDNMt90?=
 =?us-ascii?Q?w9Gd/sjkk6Q7LszxJd3/xSgEUvfNn/iKY1Lc/vyfViYKGyDnB5ddVMlX37CL?=
 =?us-ascii?Q?61PafVp7ZgBv2leVl5DipPQZ+hWS6eyWVl6Hx/B0Q6B7+ZEf5G9qeNOnoZi3?=
 =?us-ascii?Q?p2vKd4nKAkeTyCAFMsdZHic/S9ot5ZBY/e5ETA5MIQN0smAna4fGw0seVpNq?=
 =?us-ascii?Q?qq0qrQgMAMj+NIgMgCHHcN2YGnoLxHiDcUI24un+BNFwP0pFLEhI/tOGuDbk?=
 =?us-ascii?Q?BcwFRvv0dhYk6QuINTe6VpA+XzhOb0ogTJEEbHUPwl3wNiVPMLkco+4RPEiO?=
 =?us-ascii?Q?m6srK4aWJT618eTnWH82K/IeADQslgQEK+jnTbmHuNSZJVZKsdUXpA8ppfFt?=
 =?us-ascii?Q?GD+qr7FQy8kodPGV3aTp2H0BxRnAiM5Wo5cZQAW2/nD8sCKwJNhMOCComzP/?=
 =?us-ascii?Q?aQuu8Lx81ST4/iz+6M63guWo5reEXqHGISzGkREozzULb0UmeFRrDycsryTj?=
 =?us-ascii?Q?+IjbQ9fpw5vcjB7Lw2R8cGoCOitTdRjGWc5VkMrCxSIxQafwdJC0NTpiu9Yw?=
 =?us-ascii?Q?fmfcXmBzO2OYb9U3I1ksFyJKraExx9HmxlA4YYTHdtCTDe/zkpYaYUNoMDq1?=
 =?us-ascii?Q?LIhF/+IXlP4cRx24OlD1k406GgTfG8vMzvV6XXf6yl953RXia6LcBYaq+lEV?=
 =?us-ascii?Q?MgN0RXu9zmGmtKWn3yy3X+lH3a1iPKj4RmmLNfLu3q46ogISySmZxDuEFuVQ?=
 =?us-ascii?Q?s9nbT3fOX1+U2wd7Bymowi0e3yCEONYYXn2cxKimklo5lv6SYkg+NAWeQeRg?=
 =?us-ascii?Q?0DFtQLbC8CfD9/dOuZZQubVlZmFwECneiOGMVmYXRTGnDsgREE2cTNzgLPzX?=
 =?us-ascii?Q?LRUpgqW1l4kpHAEFuU1XXcxMJmEKeqPcDDYeZgIz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5397963-e9d6-4691-ef3e-08ddc3da8460
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 20:02:24.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/Dl3qLtO0I0q7UFMPf7bPOee75J2TufamLrKOnK6Ne2psWet5VNP/0+GgXtess2YHC5M1c19dhQ80xF1yNspQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171

Add detailed comments explaining the critical ordering constraints
during RCU grace period initialization, based on discussions with
Frederic.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../RCU/Design/Requirements/Requirements.rst  | 41 +++++++++++++++++++
 kernel/rcu/tree.c                             |  8 ++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 6125e7068d2c..771a1ce4c84d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1970,6 +1970,47 @@ corresponding CPU's leaf node lock is held. This avoids race conditions
 between RCU's hotplug notifier hooks, the grace period initialization
 code, and the FQS loop, all of which refer to or modify this bookkeeping.
 
+Note that grace period initialization (rcu_gp_init()) must carefully sequence
+CPU hotplug scanning with grace period state changes. For example, the
+following race could occur in rcu_gp_init() if rcu_seq_start() were to happen
+after the CPU hotplug scanning.
+
+.. code-block:: none
+
+   CPU0 (rcu_gp_init)                   CPU1                          CPU2
+   ---------------------                ----                          ----
+   // Hotplug scan first (WRONG ORDER)
+   rcu_for_each_leaf_node(rnp) {
+       rnp->qsmaskinit = rnp->qsmaskinitnext;
+   }
+                                        rcutree_report_cpu_starting()
+                                            rnp->qsmaskinitnext |= mask;
+                                        rcu_read_lock()
+                                        r0 = *X;
+                                                                      r1 = *X;
+                                                                      X = NULL;
+                                                                      cookie = get_state_synchronize_rcu();
+                                                                      // cookie = 8 (future GP)
+   rcu_seq_start(&rcu_state.gp_seq);
+   // gp_seq = 5
+
+   // CPU1 now invisible to this GP!
+   rcu_for_each_node_breadth_first() {
+       rnp->qsmask = rnp->qsmaskinit;
+       // CPU1 not included!
+   }
+
+   // GP completes without CPU1
+   rcu_seq_end(&rcu_state.gp_seq);
+   // gp_seq = 8
+                                                                      poll_state_synchronize_rcu(cookie);
+                                                                      // Returns true!
+                                                                      kfree(r1);
+                                        r2 = *r0; // USE-AFTER-FREE!
+
+By incrementing gp_seq first, CPU1's RCU read-side critical section
+is guaranteed to not be missed by CPU2.
+
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 08be3df95e68..040e853758df 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1837,6 +1837,14 @@ static noinline_for_stack bool rcu_gp_init(void)
 	start_new_poll = rcu_sr_normal_gp_init();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	old_gp_seq = rcu_state.gp_seq;
+	/*
+	 * Critical ordering: rcu_seq_start() must happen BEFORE the CPU hotplug
+	 * scan below. Otherwise we risk a race where a newly onlining CPU could
+	 * be missed by the current grace period, potentially leading to
+	 * use-after-free errors. For a detailed explanation of this race, see
+	 * Documentation/RCU/Design/Requirements/Requirements.rst in the
+	 * "Hotplug CPU" section.
+	 */
 	rcu_seq_start(&rcu_state.gp_seq);
 	/* Ensure that rcu_seq_done_exact() guardband doesn't give false positives. */
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
-- 
2.34.1


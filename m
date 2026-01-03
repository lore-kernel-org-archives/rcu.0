Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D23225762;
	Sat,  3 Jan 2026 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399866; cv=fail; b=BiFaJOcbYj/Yd4SFgEW4Q6g2/S1zozAnttXuvtqFrorDMBtXeJHtC0fFIQhM+qRJRfqrsSSIz7wlpmi5D2eICb+1BIZdCUH8QQda7HnUBgIIz8IvmR876ai44B5nzUwFMT6XaepX4X+tUGgJ365VL3Tz2OdBUiMWbmZuU6fyeHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399866; c=relaxed/simple;
	bh=cMeTEwMPFmXWhjRtlPV+wwoqz1UHvOSyRC8L7TSBT64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THBmzgNB4wwcM5wo85Y4Epye5gkulTE7WGwIFh9/OIilS1ep3haR+Kj0npUdXmzN1MqAeGemD4McuVPmHGC3kUrarkmJVw3RMHn0fCDIjlxxYr1rH0BUpAxDpk0u7vadlbnrq11KCITas25yFzpHBQH9ekCO9g4nsQTzb96MbrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RNAWJgTj; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RNAWJgTj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjiEApQ66/Qk4EZrqayoOZU0CGtSCzNEUyh6JHABxcbx4+khWvqdwb2aSU47hxsKPSapECeJvv7H7lugqyQ/10LAcosC8onYUFEgdScXeP4T/CghBFQRemuJIgT9nF9nm4LdYVB1G2CnYYzxHJLMnD+JXMBDt7bdzlzTQBK6hf7OV6gY8IwclUh3qh6p0lRgpzDX711ux9fxRy4OYWoYiNFMBGSd9/ksFTOV+o4WEkL+OKziOJEDxxJD3ESZLnEtID6jGIA7PQZwMRGlojrYbKUSmfLsz+65e5dHo4VkuFHV+9eF85aj7uFjgUjDR13cD0iLmo9Xp5W2O+uFNA/+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+mTgRnY5Fxs712rqui9HWx9XxSvsOL/1QRUm7jH9K0=;
 b=Ypfvrda0ak1g8EWCdMTPZaKi8cNZuikuiLaVHA4FGRDTK56Jdd5EJzblfzUIeDwQiRc4kO544KTMh8wc8RZ+hIswyrdd2s+i6gdtROp1YFSeBDKRHNf5IAlJIAdekpcbR27iYyWZzXax6kIbPaw+bqiggJxCrV4kxMbVYa/KZp/Lyu3kOe6PLnJ64BDxqRVHy6tu26ucLlPZhcnU0iOL1cDEd9rY4pj9R/EQCa1l9lio/Hacovxg9BU9fHBTxFBojlHDJUty+D2shiuStSQVCAErgbqNmVNYjbNpjmkWB7+hMp9BM4rF7QpZA6cwC6glbdKLHvlIfSBSXdoSzN3rFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+mTgRnY5Fxs712rqui9HWx9XxSvsOL/1QRUm7jH9K0=;
 b=RNAWJgTjwnCsQPhAqHeMQX6sIIF8zRknA99WaBFoJktaCmCgbAYG7PLWVx5cAIHtCM1cuJYaYQut1Re9UXOEtia4zmT40aZhF07QeceX0YLSzXtpdlrPC6wDvy5G2Cio5Dxc+lmQKxK7cvcNMDcIJdFDCxqpy1m3+arVG3ApTBsMESuGS8+yxRh4RHdnFMH5D0WWie7IgvP74rCLpT5piT/YWGkIsUidxtxg1IeDLDMgq6w5pYhOJhDVjdexFuJYIhtlQ5SRUD/3vbKov+eK0d9ZNFP81pC+yTeV4MjkOJaLzFmJnjsMPgv/GYyiJeSw5gnVNDuT/Tgu8aB6X2mUrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:24:16 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:24:16 +0000
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
Subject: [PATCH RFC 13/14] rcu: Skip rnp addition when no grace period waiting
Date: Fri,  2 Jan 2026 19:23:42 -0500
Message-Id: <20260103002343.6599-14-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:52d::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 186ff6e6-a80e-463e-9409-08de4a5e6dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+ABO329QmvOakNif1vQMg8rgueCA0vmK82ER/Y+AXoLLK5GoHAYXGpAjin4?=
 =?us-ascii?Q?nhDl40fNYREDAVRdZfSkH6dJv6BPPK7yVsHyn2p8y9z8QAdfXKYb5ZRkWTya?=
 =?us-ascii?Q?UoiiDhRW+6hjxvuLOBhc0fNyKHeqvnPusvgQyrCjeuuKowey0+57LzGdB5vL?=
 =?us-ascii?Q?L4kK5ZNdMKMwzi3EBv8aTc4sZ6hnJkSC9AGVxCnQ8J3hQnNOjpVtnJMOd7Rb?=
 =?us-ascii?Q?gzxZnNGiU9TWzGJw0U8AI6prg+J0RTnrkMweOcPoTVK2OBiwxUYqmklV6aWv?=
 =?us-ascii?Q?CnBhMfKYjzLjcW7RPqg5OzDjlZAfu4ZiOzwI1G28/skQJTRAg5Cuc208qw8w?=
 =?us-ascii?Q?huKye4ZjEZt4Dtrmrza5mJePlqapzONjTSdGZi8L0UzWa4WIhFrek5j9J6ne?=
 =?us-ascii?Q?FhfOh5lGEImu50UXGQvnnh5YqVVV7/s24nFvSU0dflrDe3dFkiALV3NZ1Qxq?=
 =?us-ascii?Q?wwcreF2XE7DQjLKkP2+VQobAAa6fDts+xJEpcEGp1rbxwlWmzh3ypVGUIzdY?=
 =?us-ascii?Q?PgrjtQJ2FWlmB9U8drMpHiWgYRYjOQk5z8Eg0lLhLP76iu+9KuJOgTxMpgVd?=
 =?us-ascii?Q?YLAGpPHno+oVkwsTApaDEPAz1Chk2/PBFcISdJpbpLAQCWuXkKkBvm+yMEN+?=
 =?us-ascii?Q?Zp0CjeVj3jghKCAE3gZuqki07r5xGf6SHeK41LQOzDgw9IO+a3n1WVwRu4CZ?=
 =?us-ascii?Q?yPIbtKvOYD3VousuVgL9uzeP5HHiF0AaO+PCuI1uokBHbXLwtPz6EEB5LSDJ?=
 =?us-ascii?Q?K99bl2GeTDJ0PEDCdBcCyzbFR+R7sfW+Yj1hron+0xerlEA1c9jf2N/9XUc9?=
 =?us-ascii?Q?5Ga7j7JpDnCIUGq/9VrOwXZ6i2ulyO8kPkuCTizY5Ul7VrtkxrMkSkzEuOJl?=
 =?us-ascii?Q?SKBYma/sHqWpbNykaRlmB02zmu22X37v5kwCfGqyV8NxrJVQFotdm1hcviUU?=
 =?us-ascii?Q?nNbZrCsHpxmNHUjDJf9Eman6Sz6y658v4Y1cNNAxCHEQ4iXnLQ8+Bgvz5+cV?=
 =?us-ascii?Q?fSlycm8Epq/QyfyEYUB5zQpOtga7WvfOfhUOiw9CXrNVgiQDoc0W01Gwf7NK?=
 =?us-ascii?Q?y2xuQXWRPZQREuH+i8Z2NRYxzrkjMyp0fKoIITRdt9HaHqPXJG2GbXt3kQ3X?=
 =?us-ascii?Q?k3jgUCmDwUt8Nd6yKBEZ5m++SrujcE5N7FORJlGTvkxObn4CK+qHr+yd/Ghr?=
 =?us-ascii?Q?f28RAJ3Iv98iSyYmtni2+a27hUyQyr40RsmDIHOtxCN3roXrsNvTkaVMqDAE?=
 =?us-ascii?Q?ZoZoGnrlna5OfeNapoaK4Q5HOhGkJJ1HU5NCq0bqB0RP+t3IpgoFopGJG/Ly?=
 =?us-ascii?Q?BRhDjoXZG0tkbOm5Y2fjKdLnhJ++HIKgqfxXIJgJNb/v+XbVViNTLFkv8Ixv?=
 =?us-ascii?Q?jUqLe6b3Wf5MkY+omCfXSyV5n0JCM+zW6chNRO3IShj2Rm2cQnx0eck5ylpt?=
 =?us-ascii?Q?pK5sehpc2dzh8QmEoWPEvx/pvT8FPdeO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KfHbU9ERQMJL+lMwAB9fNbQgD91Jq9evI6hehc0U5xD+pr2rtcn1p6AXSa0G?=
 =?us-ascii?Q?3ekVNLPfz+cTVfd/jHKFgBqX4b0AqKCRgg+Gbe6YJ4xWS93//bhJrqkTON35?=
 =?us-ascii?Q?gHCbiy8PZ/KaoUFCuneUfX/s7/r3KTajq+eQ5mC/QVpTWz9UaQy7iI/P8mZw?=
 =?us-ascii?Q?ugUyIQRvaqbOSzNi6qx8WwV2xvvwTYHDKFr6vQXlbxmqFP1t+jvpzZSreblj?=
 =?us-ascii?Q?ZgKF3fvYEDnbS9+LVHDVrfE/EQpEEu6p+eDUvQO91hxwlh7MN1TNajZ06b+m?=
 =?us-ascii?Q?Z7/Wg6WVmxh1WhLxo0yt4BS48ktbDF9/zLEqvp131ROahS/fsH6uxPxA5YHj?=
 =?us-ascii?Q?fjAvaGsgEjIT5UGyKo9r1oX+KAwULs+cxRfWUWEI1esRk30khPy4ES1+vjx/?=
 =?us-ascii?Q?emhzQ7ELuisMSOhM/LiU/Svp3nIkJBzvFFF1/H+MsthWCFZUnxqNcdLTRg87?=
 =?us-ascii?Q?//1f4XrfYWplX670H1l8kL3x3XCBH4idoXMwOernWOkSJcJhbnhjJDguRS0s?=
 =?us-ascii?Q?kAUjiBxFfu90nOXG0BCqUKms5qAA4Sj3ORg8gc3EJSBnPxO4A9WJszjeA6aD?=
 =?us-ascii?Q?xv0dMNp6lZHRDvlooh9jLLJOQDbCmzTIHqqyIxTT2Rzvu0VdwdyuZlvrEdij?=
 =?us-ascii?Q?VHj6XivbuqriWL5HPSwhFR/ftor3Hf1l9ukYPZsKPJ30fqsQdNsKdev8Nq5S?=
 =?us-ascii?Q?fmiVFC3mfSeYDSweoMflR0VjcRckTztAOmufLFgZ5p+0ivIjpKYhu9kHfwmk?=
 =?us-ascii?Q?D36zFkdqZi7UsV4vYvkVQKn9gsDv3YZDyBzcI1gGDmhLFwmeV5tNNre/7qkP?=
 =?us-ascii?Q?OuLEvNVDLD799FkVzv8EVj+QeJ4LVjGSK8cHV4aiCG84Cy4ekuxAuP4QRJgs?=
 =?us-ascii?Q?kRJ3UGOcuoSd2Ui3zbXKclURAx+7yHitLO6gxF/Ls0kKTjtfGX587KTJZ527?=
 =?us-ascii?Q?RC1shzeDkoTBHB63jbNh4EBWhTs5tpASaJr/zll5wR98xS9z+04kU1Kv+oS3?=
 =?us-ascii?Q?iabEXkbaYKrxrc+6MAACbTe/DFV5ObgkSSHVRVMvVSwUfzHvdlEoKdvoFOO6?=
 =?us-ascii?Q?peedKOzUW7SU7fy2mVKBWWDagghdyYMQiyQLjMlEBVxl4sLFt3/EiUMDCf1G?=
 =?us-ascii?Q?/6S9Kzl5SC0VLQRjvklJaAYGP8HiJf+w3HDCRpGdSJoKIxXvyc07+KqAzT02?=
 =?us-ascii?Q?tb0uxaakR+jdoBUPWZ6nzKPw79RErYXugZjtWG5JwketLpx88wVQCw2V0qnS?=
 =?us-ascii?Q?J4yA7wGPBL03CeMQVRsBrAbFLat4BPGBC2SHnkBM1MLBSYXxHHRUY/8zivHt?=
 =?us-ascii?Q?Lnq+meeH6lmDnktP0ETmhlw4uEYpcpUu/omtNXwvCsUmCihtDr70gL65Z92W?=
 =?us-ascii?Q?jhLtmUt70Ar8nQAkNhWa9+DfK49K7vYrFFys8J103JK0lbGs9qQuFsRs4MMj?=
 =?us-ascii?Q?tzffCLXLxZqZlppn1geCxJAFWpNOwTzmJeJ/u+lm/EDwKUPmGx+hIo9cQMhG?=
 =?us-ascii?Q?o6iknXgfsRhvUtoCHxMc3nURFD/s63gD1sqlSTUjv21Q0ufGAWLm2hHh8uC0?=
 =?us-ascii?Q?Cji8nbx3rJtclE0mU1CVyIQ1/gUPtyiV1Qy3wKvfqTrt6NG8NcscMb69HQny?=
 =?us-ascii?Q?dl80AmLjaCG2XyFMmzJEWPUQ1MXPlRqSRFfgQHyI2LJ1jE9f7RFCrO42RBbM?=
 =?us-ascii?Q?c4x933k6uGZiUrtCsqdyX+hSQE2FHUAjC6wFYtdkPRsOmAeBrhl1DtcGhFbR?=
 =?us-ascii?Q?Yojst7RcyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186ff6e6-a80e-463e-9409-08de4a5e6dc1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:24:16.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: It781brFJ7KuDC24nH+1qCGnZ+DQwneO8Mm7JflvuSJn6V+926yq63VHmGgos9jw5TbAssSu1oUo+tw+eSYV4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

This is the key optimization commit that triggers the per-CPU blocked
task list promotion mechanism.

When a GP is waiting, add directly to rnp->blkd_tasks via
rcu_preempt_ctxt_queue(), but NOT to the per-CPU list.

However, when no GP is waiting on this CPU, skip adding to rnp->blkd_tasks
entirely. This completely avoids rnp->lock acquisition in this path
triggering the optimization.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 64 ++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d43dd153c152..a0cd50f1e6c5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -335,37 +335,43 @@ void rcu_note_context_switch(bool preempt)
 
 		/* Possibly blocking in an RCU read-side critical section. */
 		rnp = rdp->mynode;
-		raw_spin_lock_rcu_node(rnp);
 		t->rcu_read_unlock_special.b.blocked = true;
-		t->rcu_blocked_node = rnp;
 #ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
 		/*
-		 * If no GP is waiting on this CPU, add to per-CPU list as well
-		 * so promotion can find it if a GP starts later. If GP waiting,
-		 * skip per-CPU list - task goes only to rnp->blkd_tasks (same
-		 * behavior as before per-CPU lists were added).
+		 * Check if a GP is in progress.
 		 */
 		if (!rcu_gp_in_progress() && !rdp->cpu_no_qs.b.norm && !rdp->cpu_no_qs.b.exp) {
+			/*
+			 * No GP waiting on this CPU. Add to per-CPU list only,
+			 * skipping rnp->lock for better scalability.
+			 */
+			t->rcu_blocked_node = NULL;
 			t->rcu_blocked_cpu = rdp->cpu;
 			raw_spin_lock(&rdp->blkd_lock);
 			list_add(&t->rcu_rdp_entry, &rdp->blkd_list);
 			raw_spin_unlock(&rdp->blkd_lock);
-		}
+			trace_rcu_preempt_task(rcu_state.name, t->pid,
+					       rcu_seq_snap(&rnp->gp_seq));
+		} else
 #endif
+		/* GP waiting (or per-CPU lists disabled) - add to rnp. */
+		{
+			raw_spin_lock_rcu_node(rnp);
+			t->rcu_blocked_node = rnp;
 
-		/*
-		 * Verify the CPU's sanity, trace the preemption, and
-		 * then queue the task as required based on the states
-		 * of any ongoing and expedited grace periods.
-		 */
-		WARN_ON_ONCE(!rcu_rdp_cpu_online(rdp));
-		WARN_ON_ONCE(!list_empty(&t->rcu_node_entry));
-		trace_rcu_preempt_task(rcu_state.name,
-				       t->pid,
-				       (rnp->qsmask & rdp->grpmask)
-				       ? rnp->gp_seq
-				       : rcu_seq_snap(&rnp->gp_seq));
-		rcu_preempt_ctxt_queue(rnp, rdp);
+			/*
+			 * Verify the CPU's sanity, trace the preemption, and
+			 * then queue the task as required based on the states
+			 * of any ongoing and expedited grace periods.
+			 */
+			WARN_ON_ONCE(!rcu_rdp_cpu_online(rdp));
+			WARN_ON_ONCE(!list_empty(&t->rcu_node_entry));
+			trace_rcu_preempt_task(rcu_state.name, t->pid,
+					       (rnp->qsmask & rdp->grpmask)
+					       ? rnp->gp_seq
+					       : rcu_seq_snap(&rnp->gp_seq));
+			rcu_preempt_ctxt_queue(rnp, rdp);
+		}
 	} else {
 		rcu_preempt_deferred_qs(t);
 	}
@@ -568,13 +574,22 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		 */
 		rnp = t->rcu_blocked_node;
 #ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
-		/* Remove from per-CPU list if task was added to it. */
 		blocked_cpu = t->rcu_blocked_cpu;
 		if (blocked_cpu != -1) {
+			/*
+			 * Task is on per-CPU list. Remove it and check if
+			 * it was promoted to rnp->blkd_tasks.
+			 */
 			blocked_rdp = per_cpu_ptr(&rcu_data, blocked_cpu);
 			raw_spin_lock(&blocked_rdp->blkd_lock);
 			list_del_init(&t->rcu_rdp_entry);
 			t->rcu_blocked_cpu = -1;
+
+			/*
+			 * Read rcu_blocked_node while holding blkd_lock to
+			 * serialize with rcu_promote_blocked_tasks().
+			 */
+			rnp = t->rcu_blocked_node;
 			raw_spin_unlock(&blocked_rdp->blkd_lock);
 			/*
 			 * TODO: This should just be "WARN_ON_ONCE(rnp); return;" since after
@@ -584,15 +599,12 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 			 * from the rdp blocked list and early returning.
 			 */
 			if (!rnp) {
-				/*
-				 * Task was only on per-CPU list, not on rnp list.
-				 * This can happen in future when tasks are added
-				 * only to rdp initially and promoted to rnp later.
-				 */
+				/* Not promoted - no GP waiting for this task. */
 				local_irq_restore(flags);
 				return;
 			}
 		}
+		/* else: Task went directly to rnp->blkd_tasks. */
 #endif
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
 		WARN_ON_ONCE(rnp != t->rcu_blocked_node);
-- 
2.34.1


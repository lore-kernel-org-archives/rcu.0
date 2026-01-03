Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134F22256B;
	Sat,  3 Jan 2026 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399857; cv=fail; b=In+oKMaKqSFbWA99rAnIIE+j8N3UStEsDfqmEpxsFVRC8NYny7rmxW8KXWBolZjHbqfuDG8wpxDJ6n9t+IwjI0/lLewf1bzW9zEKDtyPm9RZ0Z6E5pcLau1FV7l+6qrTCqp5r+BAdvW3Lv+vJ039vPPS+v/VmMw+6mTuozQtTwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399857; c=relaxed/simple;
	bh=8Nfx/YgLwz2WOv6Yf5okEol4Ptd6zOufx6U2qYBV/aA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEuPaMjT1WsZShRmPuDin8Vl6A9GvUmem8/bGn5d2a5ksyKCIGp2T8MbYf7zOul7Ea2QFY0d7cX9Jvn5ksumTINuwTVi5ahGGbaK/1Sf6sTV+lFi/SnOK6EnL0WccM/3BQx+Z6+uQetEFREFbi4GCkylk77ul2XvFDi6e89Q3Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YbBJ/rIe; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YbBJ/rIe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oy9HqLPiPsqwmbIInEIilKFc013lAUlyRdbJS8zcQUM+IPBvDqa15Qk+SnYEsJvouZxwCOxdKyxkCyT3iJ9hbCg3QAh+Jt5CFoi5rQkRT9iFe9PCmkKIp9pz0JnL4J+BVuH1XFfVIbx8dhdeHEt46ncHACuLFPFi7II5kC5Atl3jw71tPaV5UHhzsaauUMLpMy0mYnfutMK7S6/oMFbchZ3YO8NjL62iFLehoV2DZYBsi3iY0wg3jN/QIr8BeizxcoVaUQqW8kxsz7gG3Ferv0CFQEFdxqNTJeTM3zgD53Yj6mru4VHIDDElaSlNpCu8rZDTz4IjNZn2tegdeCVDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmCyp1Uwwr9vGbXn0bGkp4zU2iN84nXbhCFMqJBrsjc=;
 b=CJslop7ErWciy1Wm0ZU5JFFBIW8I7Fm9qxfAjohHHZLkfctwkMix+tgmAA2dbw7GxLRtO09KGWaJNsI4ihbVNjydEtgvBysUMX9cpdJtn8AQFpcaLMo5B0x162P3ia0fNqSAeVCN8stQDHEs1U/8cFW4t2pibw7IrG0Br2R3CWXEmy1YW20wN4efVYrhuGaD7hdwPN2fTVg28ne9642rvIxVYuQiUwN81RSp8ngthDtL9s6nE0U+aJnXiZM+hEuhzRX3XC0phjVgzlah5I9x7GRdOhXG4dou0kLoytCNthdEkITQ15zTt1BdFDAgFOZF/TzsyD5n2cLWZYhAHUgthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmCyp1Uwwr9vGbXn0bGkp4zU2iN84nXbhCFMqJBrsjc=;
 b=YbBJ/rIeYQ8ZPFlJ9rek+XQx2ScKVSDhEVqeoa7q/hnm2ccm2wJAl0w+rYFw5H3JnzieBKmMPrepizPXkEDPA6pTjrLztfyvuNapg7INiaKBsPemvsKxJOlOAGaOVdmvB6rtIypl7Vgl8EfEREXdZfE9SYPNDP+XXIMsZj5i8TBQiAqZzsMAFzGSl5nIxcRJSuxD+wx/6mHCxX6yvRtrOON0YuKASgkXtpPucSVo7Fi+WP7TGH280d48RXzcyUdbFdgaKQMbPu4qhpclA65PT95XVbm15bdgvMLDGSLXmiLXaOuizaDlDh4jHA9yoDb4pJl6bCudvg1KFqQxM9JEfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:24:08 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:24:08 +0000
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
Subject: [PATCH RFC 09/14] rcu: Promote blocked tasks before QS report in rcutree_report_cpu_dead()
Date: Fri,  2 Jan 2026 19:23:38 -0500
Message-Id: <20260103002343.6599-10-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: db563b26-70b7-4089-a5c9-08de4a5e6954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cQtAjpfq89fvfFVCqiv11NGIIiC4LxfkirqznZPUP3JFKKl3gNoViRr4sb/c?=
 =?us-ascii?Q?A6UJNMGPXOr+u1LSZ8WgX1JnUQmWU9mKJru6KG49X7X3cVK4XnIxpMhQHNVL?=
 =?us-ascii?Q?eVSsrKYczGdvrMfTfdjg0vFDOO1QO8VKgmlsdkhR3Agb0vwPBCn/2/GhHtIh?=
 =?us-ascii?Q?8oXL3lydp2WbpL44I4Uw9VmjvGPiBgJ02gCgSpaoDT/X4f1cxFZveFF3wTxg?=
 =?us-ascii?Q?WdgdhkCbVKGPtZFKFB/11gOV1zHnf/DGxBq9KPZA7/L6tpmfHJTxoNJtkrhi?=
 =?us-ascii?Q?cGbtDtzkmUQCApnQEEHjuBeKCVPKETWcFe/kORW04csRbVeBi/Wn2dFevM6R?=
 =?us-ascii?Q?GKRzFKVjiSmw5a7YL5AqwMwWLdaGrzzLU8Kf3yb7gsEbvWUMSoir5WC81o9w?=
 =?us-ascii?Q?7RBM7s49WLFWuVPA7a4Xr2u4m0YNUCIMsr+tCvG8W4qRHYAZ6vy8TY2G8zD5?=
 =?us-ascii?Q?/I6ePqwTPzg28tvrJeitVlfs1xkB+XSdpPv9/zFyf3auLGKQMG2vaWE+1r4E?=
 =?us-ascii?Q?Ac5yWd8INFmYhsJR4aS/ThxJ/5mg3srdP1JMWHTc46mUsk4PNVWzJKl7oY42?=
 =?us-ascii?Q?qnByJlzzdC2/J/EBaOGP08uJFFRBZ6Blkbot/onEDSg/WSgvjkzrMOnQuyvm?=
 =?us-ascii?Q?90ZOIOjY6KzKILBapzJafI9PZU0nXbyMNVNV9qIF6UdJx8q8vw/ifc3pLRNS?=
 =?us-ascii?Q?jy0ueU3rWug6vh4v69IJoh63fcf3Km90bvilunftvt6hicKP7ZrlBsos7yG8?=
 =?us-ascii?Q?xYBrfdf9wkGiAbfkwigBeqD5naxhG2e5Qql22e59G1Q+0JeEgGvNjga02vUM?=
 =?us-ascii?Q?lhhkvSS6QjbaeedmDi8xAk7GDPqbFMxt9iez1N7FXEoh/IhzqmmJayvMmoZa?=
 =?us-ascii?Q?YRkE5bi3hLllCsNVuPLkYmTQizzuxO5tgswqiGRBoJ5YnEagK54dLB1MMGF9?=
 =?us-ascii?Q?kAVl8jgbtxMUlhgxkAOiTszhZ87voVdhDSxGqV9SuIGDPCnnaw9oZ5yAkC/n?=
 =?us-ascii?Q?5MTKPOX5UyRXq5GpxAI7QKKJ/I3card/4nBWaWKIw8GOaokd+GspckiYkr0U?=
 =?us-ascii?Q?5osdDbeVQrwH4KAbW7DHaRoYO3jhA7cEr/wUoZjLwk1ZkWypVo2GYI15ZPiE?=
 =?us-ascii?Q?b1nA/Db7oBJbIFwHnDxteKPglQYQrwyddsAQH+uFk3vcFTkTALgzIAaCFSut?=
 =?us-ascii?Q?Lc6AKua7kJL0Fhrm2GKaZKvvIvpTZ6N2bBX7G9c3MijItoJh/BI4MRsJvQ3Q?=
 =?us-ascii?Q?VPNVV9KKQ9EcnhLwkM9v9pjm4A4vRhdNKDysfRYNV1zl6fTdDre4DESK9Yh3?=
 =?us-ascii?Q?SAGj29/mB+pTnNE+I6aufVuzcbTrGjeRcNxYmRrriERiWEvaSAjam8rjkt6G?=
 =?us-ascii?Q?1n0c3t2Bf8AAL1ckf7zbrII0i4ucJ1XjQwNjl06jYzQ3V45Hp0yQOvlw+07J?=
 =?us-ascii?Q?EBy6VNXgfhkdXuTY050srF8oEVnI1WKb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b2Zm9W+ebfPCqVjKyRh3TahDtRXba7v+Vmel3Do/90lhQ1m+MJkBi4aGUa/8?=
 =?us-ascii?Q?6CpTyLNohyjOCMl8hT3osCNbDwcg3CQuMiTGQjgpKXKk0XIVP20wiLu2zgBo?=
 =?us-ascii?Q?hz2+pTvL0qXSJMq/kJ25KrsROibXPaR6KfUQlpYl7HEGXIcceSG45EgYTkGp?=
 =?us-ascii?Q?dxZXi94+mBqF+yasLEaJlJeg6hiufaBSkbmeQETqDpQjkqRwLUjaKNzWR5xC?=
 =?us-ascii?Q?Ot1iK1mWI0ntyL9h7CYAV2IIO3MEyRmfUBQrRZqCLJVx5FNoZZMjf3gNDTpP?=
 =?us-ascii?Q?6W1U7e9cnVvgy/6HpDKE/eCTNHd7JkTxxV3LepGduO8cvDRTUXhLCLTIJ0JB?=
 =?us-ascii?Q?RcrsqcrANprXMLefyPul7FVX7Mv1H5df7ZPrAfpwp9ma2lAkaZVP4aFzCj84?=
 =?us-ascii?Q?D2XsRJDmpLlgYyEu5l5ly5ilXhvGQtKfdChZ/AV9Xdov7N7EwSsfN9oox+cC?=
 =?us-ascii?Q?EeF9aeYzQ1+JiYYOWxBLMYRV10v7f+mMbolfuEWYy7pJ/ywRWPJ67u7gbykw?=
 =?us-ascii?Q?uNYREtRYLg9tp6M5mFQkfsS62sgtOs5oXaEdTbpVghSaTUmw1iqcTaVrjEoZ?=
 =?us-ascii?Q?jw+XjcrE/FyMbnILoOJ9hLbjNEjhyT0JB78WwM3UyhC226xrV4OwTiehG4EA?=
 =?us-ascii?Q?2fy0y9jWiNc6K/BGlcS9shjiPy8WB/Y9OpORCDxWL63pAMsFsa6LrF5sRbPY?=
 =?us-ascii?Q?6dW0nZN6tQKHtaRx585jZazo/Ph8zBT/oW5rSs5UTDYJuoeKhwG4Q6Thb+0k?=
 =?us-ascii?Q?8WHAoIhU/I6sZBtZ2zUPHno10+MVMzGgX3VTIg/zD/IXLNwkDH0P1VOqVSiY?=
 =?us-ascii?Q?svlOUaQw6PHTwaVO5J8+eFc14h3VGx8SfbuUwLcqzs64jHjru7lYWPf66RAe?=
 =?us-ascii?Q?4bQ5DYgteWSZPajFJ+zjrb8OA/o1abVAkigNcfQRQf/l8TUSvxnSfL88+8z2?=
 =?us-ascii?Q?iVNJOP6tk+t8xXL0mjPF7HtJx3f+lB6A8fxnplTCa/pK0NVKlOJ6w2xQxgrw?=
 =?us-ascii?Q?s9kwkBcUYQikBfsIqC+RUqZTXAQYOUdpXqTyGj8cNVzLc+i8D5IzYgNz3Dfp?=
 =?us-ascii?Q?KWbZ04peQrsrmjvS1OUypZcL8A4aoyOYqldTS7SoXUiAaoIqXyykGPZSzCb5?=
 =?us-ascii?Q?tq2RPvEXTJ14KQZ3yWsDSn+R2Le9aqVqUAJtG1woEVtCyfdpQ2kf1DNQChZ8?=
 =?us-ascii?Q?jvafQslMFIqcFdkY6UlCRsmBlfMYEAzR79KzCJjMi7JQszmylPyEJyd92P6Q?=
 =?us-ascii?Q?z0octP3ReCZYUt5d20tzFhBZjEEWbgyG1q5BPzZN9o2yzYIEk4V9hZRiIBe7?=
 =?us-ascii?Q?xIt4mDhT7qfzFmm3DDACw8C2SVv84qXDVasjMf/M4YJw647YhpbL2O+4LscB?=
 =?us-ascii?Q?EpsrZhK/PvWZ7ZkaxXK5wJTfRF9xCSMZ7V7rcV4kVYKQDDLOcDEh+Jsjk7/F?=
 =?us-ascii?Q?idDxfzQu4F3Xc+mKduXMvR78wnfc3wVcQN4SgqGhvGgY2jmxQKbub++O36V1?=
 =?us-ascii?Q?J3cWDFbKRjKp/2lPDMF/tezvP33jypmcxec56a7UAwWXBVKnpMzz/mS0mg3c?=
 =?us-ascii?Q?ko/6YWqbDHJEfir7h28ZORpBSaq7mHEztjjP45eCyJfRbOR8taLrBw4W9x35?=
 =?us-ascii?Q?yrV847CrdvU201RhqMhwgJ+MxCgrRgMxyKN7BNTxq4Wm87etvwWzN4/s4OU9?=
 =?us-ascii?Q?J/4D47kNuyNKgONS73l+kmgCC/XEMqgvoCnto6PmItSwxrPxsH57YZ5Dx0rz?=
 =?us-ascii?Q?q1dQGplnJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db563b26-70b7-4089-a5c9-08de4a5e6954
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:24:08.8345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mT5686qcAYNHoTmF3iJbwoUySgdZxIZJQmchmaYdvaeJ9Hl/8jxgkUHP+ytYO9c6Kn8GaCxYuLy8ZSGIRClLJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

When a CPU dies and reports QS via rcutree_report_cpu_dead(), any tasks
blocked on that CPU's per-CPU blocked list must first be promoted to
the rcu_node's blkd_tasks list.

Without this promotion, blocked tasks on the dying CPU's per-CPU list
won't have gp_tasks point to them, so the GP machinery won't wait for
them. This can cause "Wrong-GP reads" errors where a GP completes while
readers are still in their critical sections.

Therefore, call rcu_promote_blocked_tasks_rdp() before reporting QS.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 19fd13c1e6be..5e73ebb260e3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4460,6 +4460,11 @@ void rcutree_report_cpu_dead(void)
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_ofl_gp_state = READ_ONCE(rcu_state.gp_state);
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
+		/*
+		 * Promote blocked tasks from dying CPU's per-CPU list before
+		 * reporting QS. Otherwise those tasks won't block the GP.
+		 */
+		rcu_promote_blocked_tasks_rdp(rdp, rnp);
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
-- 
2.34.1


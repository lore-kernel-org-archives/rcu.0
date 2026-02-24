Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5F34B68F;
	Tue, 24 Feb 2026 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974294; cv=fail; b=K2Hd56ovFe0qMrB3/POtEBz/ohniKCQIGjY6jJfULltTIHKnjwgS18VzCsEFq1N1uL8NvdcoaLOyuCSGbeeutHrgLuuSt3uTLsoZRxcoWmH+gowfQ/Z5Yq/Wrnny5fxDq42Rduvvyds9hVtCURtsL36hLLZtEeLVZGZj1sE/cbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974294; c=relaxed/simple;
	bh=JDK7MN9RbxWt9cq0BYYLFyE1H18itz9qaVB0mLhX8rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MuynFsVhdPVJiLQc/IjsmV8WJytquyayInc4KmbmAEWm54riY6PCIS6pmDNPCLrSzt3HeNmgJTrntupH9u9KlE6/V3NGQxlvoL4CXOJ17So1QOK7MgtQ8EKItaOZPg48zIi7Jc7NKQP65vq/VONmUWYkeUfzPiqKZllTqvZ8RLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GmUvSc2x; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GmUvSc2x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=civSHIM8Nq0tk7gxTX8LcsdljLfklrybwvoNXSaQWMa+MLTeiJCmISTHQXA5gmzJIvddBjBSl8ZuiS3n67ddBjAjkxagharB5hfcN8r/fulvgSP8Kih8EKPfnHFBtD7vZEwuC44ZOc8SB4SQ+UyPf9Qb1dS3y7TxcfMUotUMJfc3h6SDwNfzn1Z+5Rd0aCl4sZDBe5t7PND4RjsmJzTBfLWBkJeaRrxrWjPVmHxSZYgrMxUd57NBjo2uP5rG1evdNGc8O0hMsgTP1PG9o5os9+uANIBC6lqINbQJzx3CR3GSRQUW927TiJetW8dfNO/oVoVwsrdGA/fRadJUlEnDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hrwcMbBhsXHW3usDc/l+GwTdBgqDyayy3DU58y10TE=;
 b=lOt/08np5MW5JOn82Fw54gEtsI0El3IzGJpdwXKCagMldH0fiPvRmuocb0f3JmqRkv72fZE9coGVYdPldzfSeXriomM2AR0PEZwaoZMZeDSJMYLl7J0RuUT2d/xB1OfhGUxDR4V2wVIGo7EOwZuU0WrouE3Y2D6zavQ+3gVFXPAspkLh0ZeU5J3vKlRsMGAg7gZr3Zd4XDbczyWQRddFVAlPRgVa8BcaIXcuTnhCG8aelVsB60FqiVDonzPGGKF68xlHTE3iZZtdY+xMNVDscsFW0yjatuCBn/Sb666t3W6foaOamnlzV/SiQLLDQPhPC2ZSQp1NG2PtIMajEvuScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hrwcMbBhsXHW3usDc/l+GwTdBgqDyayy3DU58y10TE=;
 b=GmUvSc2xipGqh4perQV23RXN7QLCr5Ho4PSzsM1PtN4OkhqYyVK3VBIZDQUD2QymEnAlBP8nE3m+8IBFilEUzJtd7sdG4aWSioluaZf70jtV8WUGooVh3bv6o2OzE62CKXq3uy71mpFG2t8N0pPi6T+03o7wl2BiYRP5Ot/Xj3yhpoBYHbzZRY3CkfWPjdlWlZ7AtNNd2E2TIm/rx2U303O6H9pLA6IGA3Pjqh1GBG6Be/Tc5odo+6HG458HdxfeAb11cESkP6dZng2AGM/avYrGWPlVa3r9qEzQHcrnTtzYFDfKYBph/9H9Fbt0WcJJ4+zhrSZ6SbzvuQvNO/fYNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.14; Tue, 24 Feb 2026 23:04:49 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 23:04:49 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v1 2/4] rcu/nocb: Extract nocb_bypass_needs_flush() to reduce duplication
Date: Tue, 24 Feb 2026 18:04:33 -0500
Message-Id: <20260224230435.3390963-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224230435.3390963-1-joelagnelf@nvidia.com>
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::38) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: d6764a42-3ceb-4687-a62d-08de73f91c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sw+WkpecXwJaOSomZi25oVDaL2X8qWFkQtLcdOMD9C0kqXF493pUsWekhuwy?=
 =?us-ascii?Q?JbNac+ZyGJ6ezlo3yafIrPO6TngGxlhKYDXT1K3F/eUJ1tIa9j6wvomuFAjY?=
 =?us-ascii?Q?6YGcnKY9yn33mH9VMOEj/T80yjh3LIhpFqVh02V9T0NOYRhpwJm6lCxu91AU?=
 =?us-ascii?Q?ksa47F2DAUEU+4bSjHQpCOwX7l1CV1spIMV17JJu5ChkgkxD9nHhCItYgpgt?=
 =?us-ascii?Q?BT2xyjNbOBxw6FN7rOP2jh2KhfiUzgtx9LMCN4irwZr6EB6Ytaw0EeKEODgj?=
 =?us-ascii?Q?ldLjUB22ba4eJxJcHkfOpvxPxYapDGeGmnZB0+ESJ8UwK38h0i0FTJxdgc44?=
 =?us-ascii?Q?UgHdwUt4dWUgWh44rPyqiHL/EvQ3pMHnpcf2T4blI3LIZDK0PFc3wE5Bh5ev?=
 =?us-ascii?Q?k4eBGfKPDV5ax8VhBD5oIUUm+I5ZVsfZMH58MilbpVz9dfBh09rNQzQaXU0z?=
 =?us-ascii?Q?rVeACYvtAQOnkb/MoUj3S1RPnlqgHp3FdWK71sxICFGLwLH5MH5wQp2+k6vC?=
 =?us-ascii?Q?spVbh71sIkjypGi5+UahOFWjwRVep3Be9OVZr1HL/zPGoxJG/uVcjDTvsP9O?=
 =?us-ascii?Q?KshDa8ZuTKmHSxgxXep8X7liYa+MQ68TNWWN7D/Z6ENVsPH1Fqbxd2eRPI7d?=
 =?us-ascii?Q?LvlrPl7Qu80G7kVblFB/U1H7PqQYHdO7d6vYVcN183vlATaPGdUp47L/Yg8N?=
 =?us-ascii?Q?UNC7HvoBB3TkfctNETr0wesL5XilB6A7yHHYCEx5r5fnQTfCYyWbCG/69RwA?=
 =?us-ascii?Q?12Uv+zxB05Fj6CaK5agKy2RKwQ4QboX+EcB1taD5H074LjkSeQJxYyPTajGb?=
 =?us-ascii?Q?IjH6zvR9MtysJVbXW0WG8dfq3jeFHxHt9l0uQdZqCN/iwzb6HPYQYA19FsxR?=
 =?us-ascii?Q?f7zcXx/GQrF0n9MOUg/jYgw5puC4Xuosy0TXjUf97lM3VOKAuqV/BN1SrM0w?=
 =?us-ascii?Q?D6NDDkYVBURQGfU/6CJDTf2VgNDAXjb65QjCexHazSnuhe4dG9cvehIj40HY?=
 =?us-ascii?Q?m7Y2jWeR6L7eOcnYYXwONu9+Be+1/3tyoZxNVHGfkEpEsf+f6uyjYBcqFU8Y?=
 =?us-ascii?Q?tLceueekyzhBe7DijvU3hr/Zen6Rk0iHTA4un+71V7NqyjhWgqzmx68kFFw0?=
 =?us-ascii?Q?14hXZIe3JpGvsCkkNm4SGiYaR2it0GGzCtrfHBVrpE2ppJpJj+DavUqoHgP1?=
 =?us-ascii?Q?Bg+JkwLVYjDqMdE/mMUQqc74d+oPwmNxt21635O/EVaqjuMnToXFIr3C4mfx?=
 =?us-ascii?Q?ylPNA83E0ExnZKSUJm51JmEZBN1eQbBGKb56n+Jv49xKEcOE7lQb1/rrsNAN?=
 =?us-ascii?Q?AOgX8sKoDfjSL34+EmMALTMCBY9Fikmw90WinpBCYdj3S1Cd7IBwVmk2VwIc?=
 =?us-ascii?Q?o4ALEFpSe7RSuh9BV7mcDKyFJcjPbGsTwgIZ4aaZxoqayedSv8vLCE4fALhS?=
 =?us-ascii?Q?7ESohTPRa96C6BGuScU7bJHv31qYGgBa6iloDLLD/HIwQTmHLa3RtE2rahTA?=
 =?us-ascii?Q?za+zzUyGnWV+75ZvwiQqaUtrXsOdyGWs46ittrGBgicmPhMkLP06GYwHgZq9?=
 =?us-ascii?Q?o7IjwkH+VLKAQy+D90s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eGOxFY4ffJELDRHWBny9J6seSWbV9V+UL6RSyJH9/SgeTSm+e+FNzKSmYcKd?=
 =?us-ascii?Q?5e0kSW/lUx9azBaj2gHPP1cl5Om+pbFAOvyE3SNGWFa09WoE3ZlvGPH4ANYq?=
 =?us-ascii?Q?Becng+8HE3MwkJXUtA9U9OW5VbEXhFYm/sfw5w0FrsnBG5XQxtAKLA4hPCr+?=
 =?us-ascii?Q?vE2yVheIW/vKddGBrKNNcj5KgwVS+FYzL6ysd6oNQIePRcuXJBDB6j8z1Zcs?=
 =?us-ascii?Q?j64IT2aw+ECCTLu3tKkxTKO5k18T+dDMJsP5RTB3V63q9WDLV+bnm9z2GHcS?=
 =?us-ascii?Q?7b79PswtEgsirdiwxBDNBLgn64gxZEe0mQifRkb5OFcv6LFxoZD3PSKaaoI/?=
 =?us-ascii?Q?i76GZvWYgtVsPnnej67FaQeE7E1h5WbZ2Jo36dVPCil3TPwtC9TJf5KXe13O?=
 =?us-ascii?Q?6y/e/8LB81XCLr3SvQzh67+Mc0pwPo0rbsv6405zcSew+4HZSIkhW0ZfGsPB?=
 =?us-ascii?Q?6jCBMh1Y+AzFZjDOBmlvC6XkiL2CYi9TFMrem6ysA1jHkREslDin9j2mnS4o?=
 =?us-ascii?Q?5/CNq8CFT6UOTqA9y+mOx5Ng6zsQvrS6WtxjPRymMmMajEdJWjNKeAKkSrKj?=
 =?us-ascii?Q?Fgp30V0ZZ+PXzp/lOxWCDL7J2N00h/vzoesDXs/bhQncLUh+K9X06C/qWfY0?=
 =?us-ascii?Q?WdD6I3NptB5ItWW1hs3xoSZUjDCo5l+FZylDnS0TE+gyNfZFk1XhjoaeP6uK?=
 =?us-ascii?Q?ugUjCu7JTPbAF6na3d0HDHSLxelwEBWI2CV4Y9uFRP72kUu18OT+nagCek0C?=
 =?us-ascii?Q?VTGu3DLDxlRC6QU4cPsXsU4Qc7u0qZgajRBNFfcOeOxlEzF2+GqoFj1IkgZd?=
 =?us-ascii?Q?EmUiJGakqKz7ZpGUtk182THM2baNt5XpvW6Hf6NQ546l720WM4CIvCHHHVPS?=
 =?us-ascii?Q?zyhutjC9X4rGp58MiG1Cw+DuQ2dqAV89akisD1ULwHHc9SniMdD00Mc7xmob?=
 =?us-ascii?Q?PerqSiT8iJmmkfspR/f7NaJ3afG2R/sl5ENPp7BFWkWrXWYs4ViUZTX6j9nK?=
 =?us-ascii?Q?VewvcrE0gD+xlzpEGwgnnh+GifoOy4Im+ut78w/ZSGIdtuCtuGJ5WkyY4bgp?=
 =?us-ascii?Q?X3lm/I64snNaLwQWiEtYWNYYxXnbTpQWB24Dc+0gGDcgWgXLFUNpECTaQzvP?=
 =?us-ascii?Q?iRfEjLG6uyDqAwcO8zgB46oRCzudV+QtVdru0mlE7+XhxQPDxSFr1/2uPvQx?=
 =?us-ascii?Q?5HyDdUM/E738p18zgjHLMHu+nfNEbUwX1oPCz4vY3B35BJPgRzBBmyo5xZX4?=
 =?us-ascii?Q?s9YUo3MoLHsf5Zpa/eKSsKaZFjn5aq5eM/MFnVvYXRwTpsIcG2o5soG29MNP?=
 =?us-ascii?Q?zMjWLvtAtMR/v9rsatRDsemWTNmdKF2dPdtMfIwBenO1+nhSpKX8ib8YzaYY?=
 =?us-ascii?Q?j4hljE1oDB5xWS2i0s3VP1Mjot6Cu8IxiQnpG4IMTNpPn/bkADU5h/JkfJRE?=
 =?us-ascii?Q?f07dVFGmpK7Rj1v+9W3gd85siyf5P2rBDupBMC0fcv5HKc5+qHgFgyK9ksK2?=
 =?us-ascii?Q?z7KKyNleh7iLX24+iq1Rg7vsgfMbVGaJBOB1EKPA0+Cmu59vZ+w884ewPXjD?=
 =?us-ascii?Q?4to2n0Mhn6tyevMnQ3cjAn+R4ksRbyb/XThchJjCbwTpcTFg68GJlesn2aJ4?=
 =?us-ascii?Q?YgmWNOQ2qo28cNL9WMqNBuYaYd7X2ykzo5IqAUL1BUbRPo/FILW1MkxEy3Vb?=
 =?us-ascii?Q?XhEnMyJ5hbLTUMEIg6Sd8Sh1c9n0cQ8FBYwAi3d5dRSt0pr+lxY1QYgyEx0v?=
 =?us-ascii?Q?SJcrzIKTtA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6764a42-3ceb-4687-a62d-08de73f91c9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 23:04:49.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGnN8DWvKOh9DZY8SVS8Uzzk1dS5tMASkyjXwc+kD3EbFUiMcUX8Vm9ySZVpPX0GtJWHNJ7D4bDL1A9YGTqYtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

The bypass flush decision logic is duplicated in rcu_nocb_try_bypass()
and nocb_gp_wait() with similar conditions.

This commit therefore extracts the functionality into a common helper
function nocb_bypass_needs_flush() improving the code readability.

A flush_faster parameter is added to controlling the flushing thresholds
and timeouts. This design was in the original commit d1b222c6be1f
("rcu/nocb: Add bypass callback queueing") to avoid having the GP
kthread aggressively flush the bypass queue.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 51 ++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 5b041134d6bb..57183b60501b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -378,6 +378,38 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
 }
 
+/*
+ * Determine if the bypass queue needs to be flushed based on time and size.
+ * For lazy-only bypass queues, use the lazy flush timeout; otherwise flush
+ * based on jiffy advancement. The flush_faster controls flush aggressiveness.
+ */
+static bool nocb_bypass_needs_flush(struct rcu_data *rdp, long bypass_ncbs,
+				    long lazy_ncbs, unsigned long j,
+				    bool flush_faster)
+{
+	bool bypass_is_lazy;
+	unsigned long bypass_first;
+	unsigned long flush_timeout;
+	long qhimark_thresh;
+
+	if (!bypass_ncbs)
+		return false;
+
+	qhimark_thresh = flush_faster ? qhimark : 2 * qhimark;
+	if (bypass_ncbs >= qhimark_thresh)
+		return true;
+
+	bypass_first = READ_ONCE(rdp->nocb_bypass_first);
+	bypass_is_lazy = (bypass_ncbs == lazy_ncbs);
+
+	if (bypass_is_lazy)
+		flush_timeout = rcu_get_jiffies_lazy_flush();
+	else
+		flush_timeout = flush_faster ? 0 : 1;
+
+	return time_after(j, bypass_first + flush_timeout);
+}
+
 /*
  * See whether it is appropriate to use the ->nocb_bypass list in order
  * to control contention on ->nocb_lock.  A limited number of direct
@@ -404,7 +436,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	unsigned long cur_gp_seq;
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-	bool bypass_is_lazy = (ncbs == READ_ONCE(rdp->lazy_len));
+	long lazy_len = READ_ONCE(rdp->lazy_len);
+	bool bypass_is_lazy = (ncbs == lazy_len);
 
 	lockdep_assert_irqs_disabled();
 
@@ -456,10 +489,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 
 	// If ->nocb_bypass has been used too long or is too full,
 	// flush ->nocb_bypass to ->cblist.
-	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
-	    (ncbs &&  bypass_is_lazy &&
-	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + rcu_get_jiffies_lazy_flush()))) ||
-	    ncbs >= qhimark) {
+	if (nocb_bypass_needs_flush(rdp, ncbs, lazy_len, j, true)) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 
@@ -673,15 +703,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		lazy_ncbs = READ_ONCE(rdp->lazy_len);
 
-		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + rcu_get_jiffies_lazy_flush()) ||
-		     bypass_ncbs > 2 * qhimark)) {
-			flush_bypass = true;
-		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
-		     bypass_ncbs > 2 * qhimark)) {
-			flush_bypass = true;
-		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
+		flush_bypass = nocb_bypass_needs_flush(rdp, bypass_ncbs, lazy_ncbs, j, false);
+		if (!flush_bypass && !bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue; /* No callbacks here, try next. */
 		}
-- 
2.34.1


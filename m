Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674E521B9E7;
	Fri, 18 Apr 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992653; cv=fail; b=oszXKDtjWqhmKHME8ncl4uTnUTThE7JamGKN5wJRc3itXT43xEoAbU06kUtUuWMnCIql9R/UQyQFjqg4HWSf94BNlBIcB4jVHh6tv98+qEm/ui6IX8gmhhjj9WKrTS54PYMzPH1X9oYEIZOViIrrWao2J6tJeni173u9iP1FMW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992653; c=relaxed/simple;
	bh=u90j+FGtNGwWb7IacbZc3rGAycCswj8Tu1bv0fso5iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vo8TaQt5ssNzN1b3gTH47u8BbqaAjxW1lGyDAJ7q3r59txFEXNdR+WdddHYQkuh7ooTKB0t2QkySxbBMAxHDLFvKpPWA5ERejUz219ZezIna2n3qvwHpCmeJdAcUiwHwbCs9MtiZh2u83SIPrcm+R9F+ueTQlEqi+/5B8kVfTos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d9Az219e; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d9Az219e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiMHd0DrS26Hs+wqoa0ohTOnISW7HcMS8vA6HiJcD41CrVQ9aRd89u7OYVApNgHuYt4aAOMQfvhnDkCVPKae0sssDoHBv+ThnPLozC0qLHQbf3bWyJLli0u8x+4lVqOHb6PAnSt7GFml50MRc8Ob3XGQjLGmCAQc1Llz9+szLj+pPFePOkLPkyhhnOE7SUfYpyPoglKn918baNNdc5TeRDlWaDMHmUH7T8Sxqym6nP7ClaSocuV3oWwd8exdWWYRNyUVvbViOA9W77m/XjK4mCyoAzWe+viogb7iXJ1iWYD1W5RJUr+q27OqPwe83u4b/BJaLxh2iO+FhhWP0LEzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UALDZZtKvaKXe++iy87Qbl/0aWtAFQVSs1gS7ETYVG4=;
 b=ZUFre6OXvO7dyHO+5Ysk3isSrG1jyvXwXoK9j3XEfdlqGiJLOgzRY6O90VcZWDfxDUYjILWA/E5CBwp4bP6zgQAnknya3bZ1SVIjfSTp8hOiUv3rLrQEJw7iP1gMOk0EG4N1yEswrn+X5pzlmLMHUilF6vRGU7jt/m3U7riTW1U8vtppRRhFh83mmj9o5hkLlBI4dPWdwywmV8lD8aQakIIgqaZUP0gepec0hxbMo5S/QvISwg4G7Nl4g5u6G/xDbK7Dj58ibA40Yzo5lPtqx/EIEx+xf68D0iwhFmEa92g37a90elOGSQ6hcxjroRdGk/OIRxYvjSZjSrE0LDodGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UALDZZtKvaKXe++iy87Qbl/0aWtAFQVSs1gS7ETYVG4=;
 b=d9Az219eQhU0J1FaFZy29qZ1FqFQ+6elrtrD3y3L00DGcYErinpyz2MVvb/o9jfXOe4XuoKONsgWHUN5RnxEgZ+yqOJgTFtNR+z0RTKVPMCkvIjmwnaKmZKwtp0yAlti1q1VycSnpN1utuemrYThJvMFKxgq4h1IwIgDBun2J0BngIDf4UkEwOgGzEG1aTaRIuyPX20HyTtx0S038MJYL2FRGlnaXUDpd83bb7QrNaKUIGAokUlIjB/HmNcxI52LiTGl6MosSo73w45SjwauGUuCLWoEer1MsQQxQ1IdH8GRzjchhf9LJOEws1Yrng6Fo73+xiRt6XpcbVtKoE+mtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:10:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:48 +0000
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
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 13/14] rcutorture: Perform more frequent testing of ->gpwrap
Date: Fri, 18 Apr 2025 12:09:45 -0400
Message-ID: <20250418161005.2425391-14-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eca9038-241b-4843-7a76-08dd7e93955d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xKHUkgQamJly8aXasc5Kxw7DdQe44AeETCDhaL6j7DThC5Zr8fiUJ3XKhbkQ?=
 =?us-ascii?Q?5xSlvN2oaMeAgtQ6t2AV6DmHX2dUo0I+GDq6+8gpfIuPQRbAB+bwk1fgCWB5?=
 =?us-ascii?Q?ZDNlJOcf761BdSrtrdL9U3QohkDql34AgBrHjSySRNik7iJfcQi0TsX4bSPw?=
 =?us-ascii?Q?4eQNAENC4lsFsSaNITbHovchXzmDjgOcfBkXb3o3PvCNTz5NuSsmdW6wBbiu?=
 =?us-ascii?Q?MpekhUDSdr1Kt/jHLELPZlRysMeB2R3Up3dLkM1H6GkYXGV0lWK7qqk53sE5?=
 =?us-ascii?Q?A+wQEzm+fv45WwIFLKn69unaKaP/e6Zt/D6f0knlzf2DxAKsLxhAwLrqn84a?=
 =?us-ascii?Q?UXyvP2meNsG9dNHvbF0y6w9cHhPDGDoGWK70KWDV1xiQY6qScdSBP5MYUmMH?=
 =?us-ascii?Q?nYr7M8HBVmFqQ9hgweBTm+trd+sFqR9u73QjB48EzA+cXSzkNQ/eqTLqBHK2?=
 =?us-ascii?Q?D5drdjPOPGlNdj8sm6W21P5Ihv1IJ9j2K5giigHWghdjvslaaLvfB+qVNCto?=
 =?us-ascii?Q?oUv8pIX0SedxVUNnoulKHKxqeWScXZ4eeSRomJiZkOBmHK3/XZAXwMYT8lHo?=
 =?us-ascii?Q?EarfV3hJfnvXmj680QPfuuwQARFoGSmHM2T1HDTEYTeXhH3/rFjOoI7zd4lk?=
 =?us-ascii?Q?W8DUBTNNgVOEyHMURqjWhLsGln0LMYVet6j2XJXgSjU8GV2sZMJFR4AvG63A?=
 =?us-ascii?Q?VnG1kofJh30IpxZ5DZc3RtI6kVJ17WgL0oqaUldudN2+2UugUkPX0xqk0OIx?=
 =?us-ascii?Q?xmZRcHLK5RNC1k1aQG8wGjm/EIQD+4YJyZXZemEji9V7FUYzyNxxfMVslSxP?=
 =?us-ascii?Q?LSrOvzTLH2EjpeGee8jvK02O628miNTTKEeo8+5vFQ0+eDB0AsjChKzN3TCV?=
 =?us-ascii?Q?rqk0vhXRbQ7/BrRa/Yczmimq3JLk0aZXlT1DAk6HM6rkfPpxd6aQ/xdBaoCA?=
 =?us-ascii?Q?jAmTzqiFvnus5enUhdtzqWaqf+kKofdi5mHpD63WfgNAMIN4hF6XqVgZnxJe?=
 =?us-ascii?Q?5MsnrKqLygxAS5Hv6pNGC97wi+X+d3O7oC6trs5sr706B434lX2jm4GwybwD?=
 =?us-ascii?Q?6E+4xSPZRSvMz2g9vGUBywb3kgJVCYmVvfl+0Rw/TwCyKZWv/zejBSxNVijO?=
 =?us-ascii?Q?+c+6GP6F7C78XtXFQdgp+S7AYV7m/v+y9H8z43jDtXrzrBhya9Dzp3/3ekiF?=
 =?us-ascii?Q?J4+seHUA9I5eUjGpYXoPfdE0y4wbwfFErK1Ws+HoBFJK9WZpurGdcdXq3ENM?=
 =?us-ascii?Q?26xVesuUAbfKhOORzWzE+0Pq5kCKxVhFKrePn1TVZ3qpsVkmAsd9g+KRS3AF?=
 =?us-ascii?Q?BSrZmho1im/WuJodTHq/eFF4T+9T12nBGExZJuLZJW5et8ynY678+vBNpK38?=
 =?us-ascii?Q?iKJHVErIP99G0J5llbn7sTFUPMaunC5pXxdAWvm60kgQTz2bExKirfut+JSb?=
 =?us-ascii?Q?ZoIMQOx28wZVUh+oN8zZ0gheLOJxrhNyQitvQSrVopRLgDiTQ29OZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVvjpV4gf+s+6aAnq3Lntkqc13UJR8sg5KUQF6VW8liYxsCk1OTthJqTmlzJ?=
 =?us-ascii?Q?HCe2G0OsoTnUf+qnP/S+lTiCA9W+k8N3KDjWqJ2j/A+Tw4QPRRqTtkAkVam+?=
 =?us-ascii?Q?O15H0XfIx6Rr88/4UK8nhiwXOJqm2Gx9bQodJ1a/+RCxCTriqL+1VO5+xoFj?=
 =?us-ascii?Q?sKmV4TF6mvFygahRj8NLGgqwj+1Va2jD2PJmSP9sNZ/pXLWqzKno3SgI90g2?=
 =?us-ascii?Q?jgw9D1VLfH9uD8xg8m3H0ungT91JPiR2/hOtcEUGtJmdBd4FpC+0KLCVVYp6?=
 =?us-ascii?Q?o3bpgsU6CIcj4x1BdaFs/12bUCIrmYIKCMnyEV8cmMZ5CVF+YOX825LwWwDY?=
 =?us-ascii?Q?0mF2qlh9U97F3SE+BVBXWQ3Q1yj7ZkDXsuoxbTU0oXkQ2/HTh4yAHqjiKiR6?=
 =?us-ascii?Q?QXKG6i7MkPN1Grn1Tk8onS68FtSF5xyGw3qMfiDywl7mS0DkxaHN0FpYSAhb?=
 =?us-ascii?Q?o14v0Mc9radS+cb5cZg9AU5ze95OtrOymTGOoUu2/0DIuMLSXga6Y6nycrWY?=
 =?us-ascii?Q?V/VkuEIZcc7YfIJw/oTVOdYgijEYOxRnKJbkL0Lo9T8Io9p9S5IgxZEthtty?=
 =?us-ascii?Q?Kl82jeG/+xNiYMSUDfWtl0zwVFZBqKMmgLuuyYUuI7Cg+fZkyx6OFnlTONYn?=
 =?us-ascii?Q?CEP06n5jX6EIFRwcrbwt0MycR44nNE8h7jAkHBeTM1YNT98YK9AmtIPQqMJS?=
 =?us-ascii?Q?MjPbpuXvWq4boTSDcyTyhcf7fuYsiLVh/HQdxF8G6QZwqmNsM0vkk9/it5/j?=
 =?us-ascii?Q?LZZwrP+DdFlSuaYNFU1sseoa5IeMe4B5Sbsrl7gBxycXy44XAI539azBKx1+?=
 =?us-ascii?Q?Eiq8HiafdExNrme8dJT6m4W82AlWMjkAUEHVUi4p7SSHtfU+Ke6LWcCVRNIT?=
 =?us-ascii?Q?+QWYX7SVl7l9TxnTSq4zl4uhLPX8MoAYZtHIfVke83/kK4XlX2MoR94+w7ap?=
 =?us-ascii?Q?EGubZP0ejlIVTEAD+FDnRSRS+7nY9VpIFiedQsH/ePFYij2Z1yqjvb0q8Njx?=
 =?us-ascii?Q?S8k02URPIOLqq1RglkGHZTsGrdB/MatrTvEYRHJcQx1Xy9ftulmM6zuSb4xu?=
 =?us-ascii?Q?FUyMeBu1s5zl0wMbzEnZqfH3ooBfi5KzqW8eiDV13qjOeVDEcKlC7LI7y2Zd?=
 =?us-ascii?Q?gr9yh6/2PeTroVVUrFCo+SThbub0EI9OoJC4cA4ypicdpyLmd68QIQ0RlHfT?=
 =?us-ascii?Q?AxWT+hT1uvytZ4fmJagg7ciVb0y4+Niv+tDQBrt0a56zrzLNYnjW3c8cZZNi?=
 =?us-ascii?Q?VOHaCZrgLFbQ4mYT7ZS1VmlNPdkQkp4EricyLMn4phxMwqhykDMR5sz5WZTJ?=
 =?us-ascii?Q?+g9fhFehs1Gedl528+LjQvHH3HeRMNLKz2L1d83/dyMQKKAVX5WI5dG9D4vj?=
 =?us-ascii?Q?7MYbgnNrD5dwVO7snpas0SIGZER4nHbCWsxq8YR87F27/wsUIBg3Jz8gvWJ/?=
 =?us-ascii?Q?KVGZtxU/9qw9QPBJ7ViU7Tq/JdNUjhKclOyKekqWWflcF3QAJHMXZs9Ri4qC?=
 =?us-ascii?Q?r7VcHdYvSL9zMBVFrxRcWCkrDjroGNd/NZDBf4zLY9bTVyHdXhR1nsiOSccV?=
 =?us-ascii?Q?bFy0+gTf96fkDdwar/04CoDfJGdn51EMcYWXlytf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eca9038-241b-4843-7a76-08dd7e93955d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:48.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dj1rk/vfGfwDtwN5EPMvhCocs7iwsiNqSVydoKRQsLTrjNnDkB3XSQ5QyA7auEM0Xleo2oeqsp4Js84KVxu8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

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
 kernel/rcu/rcutorture.c | 68 ++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree.c       | 34 +++++++++++++++++++--
 kernel/rcu/tree.h       |  1 +
 4 files changed, 104 insertions(+), 3 deletions(-)

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
index 402b9979e95a..88d9f5298c3d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -118,6 +118,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, gpwrap_lag_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
+torture_param(int, gpwrap_lag_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
+torture_param(int, gpwrap_lag_gps, 8, "Value to set for set_gpwrap_lag during an active testing period.");
 torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
 torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
@@ -419,6 +422,8 @@ struct rcu_torture_ops {
 	bool (*reader_blocked)(void);
 	unsigned long long (*gather_gp_seqs)(void);
 	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
+	void (*set_gpwrap_lag)(unsigned long lag);
+	int (*get_gpwrap_count)(int cpu);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -626,6 +631,8 @@ static struct rcu_torture_ops rcu_ops = {
 				  : NULL,
 	.gather_gp_seqs		= rcutorture_gather_gp_seqs,
 	.format_gp_seqs		= rcutorture_format_gp_seqs,
+	.set_gpwrap_lag		= rcu_set_gpwrap_lag,
+	.get_gpwrap_count	= rcu_get_gpwrap_count,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -2631,6 +2638,7 @@ rcu_torture_stats_print(void)
 	int i;
 	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+	long n_gpwraps = 0;
 	struct rcu_torture *rtcp;
 	static unsigned long rtcv_snap = ULONG_MAX;
 	static bool splatted;
@@ -2641,6 +2649,8 @@ rcu_torture_stats_print(void)
 			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
 			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
 		}
+		if (cur_ops->get_gpwrap_count)
+			n_gpwraps += cur_ops->get_gpwrap_count(cpu);
 	}
 	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
 		if (pipesummary[i] != 0)
@@ -2672,8 +2682,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
 	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
-	pr_cont("nocb-toggles: %ld:%ld\n",
+	pr_cont("nocb-toggles: %ld:%ld ",
 		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
+	pr_cont("gpwraps: %ld\n", n_gpwraps);
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -3844,6 +3855,54 @@ static int rcu_torture_preempt(void *unused)
 
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
@@ -4017,6 +4076,9 @@ rcu_torture_cleanup(void)
 	torture_cleanup_end();
 	if (cur_ops->gp_slow_unregister)
 		cur_ops->gp_slow_unregister(NULL);
+
+	if (cur_ops->set_gpwrap_lag)
+		rcu_gpwrap_lag_cleanup();
 }
 
 static void rcu_torture_leak_cb(struct rcu_head *rhp)
@@ -4519,6 +4581,10 @@ rcu_torture_init(void)
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


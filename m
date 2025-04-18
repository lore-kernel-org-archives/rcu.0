Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE4219311;
	Fri, 18 Apr 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992640; cv=fail; b=tks0Mt3L7IRYmnqqKA6bvZGVDn7m1UIdojKMUk9kBJ7LhljDUwPUKZI3QEof8Xk0fNfzefkcfd5VYiDoTa4v7amm2Kqf0k1iWh7U+hzwKUYX8kQpfpbCCppT/dQg9vM+sSTAtPxXL3MZV4l0bdLBpZyxHmE3VMEoNpX9TJ3a/Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992640; c=relaxed/simple;
	bh=keh6BvML8HojlxkMI0MXymmJ3ZYlFk6P8eExBENpuEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fp6FlDOLDFIG/Di6tG8vXk4Zna27Bz/vK12hj9YhunXTinC6hLI3LnOcE7NCMW4+Vhwcq1+Key5OLs/rwwrs3ST5ipRmLuGc3mFBpSEauEGCai3Y/DC4IYTHWUsWgTiFje0bjeL/RW9T8Q/a+cvrr1QmydysCFGlLUZaZKVucoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GtgYNoH4; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GtgYNoH4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX8GS9+7uLFyrng2a6z94ybjfyGO/XjniWRRgIEOTJpL8F7kmMS8fqaxrY5oSt//+kYDMehJ3MGNKOj9RvXG9FmWn7/tyHH0D3apOmJiMoTlRjIzuA2dRCGr7IhitC+yWZ68a57Zji2S8QcWvq7n5vMqgpptYENlQfNgAj5zmYbwuMcJr/h1rnn6k5sPUqgVRRAQfmCE1pa0JrM3JE7lzWKCHpKLDWNpssvSLyw9J8TWzNn4HXo7qjPgWeRcOgtePIlS6nFWBDvODBEKWjGa/M/KLASeUK6lTZ7iSkVYYxq8udiHKSGhCNYEX9ncpw9diop75BlzdGXn9YmbshvHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BotCbURfJtn+w7FkKp/46IRYrY4Bm5tWf0k35okr1KM=;
 b=RCFPITLufUr5mn0cwngP3uYZT96VwZk9ImHUumQw7FlHq6QlbhHxShZQ/z9lLx6/P+bsIj2SP1ZZvghcOGZALdtP5KOBHWJINxCRKV7aNdmF+P2P8YagBEjcLE+4YYOz+DIWXemA33/XDyvlgbK2RYPW6s2CDCG29XDFG8efnQUGAI1oE1TCnb63TMLGy/0Ce9eV+LOv/3nFkg84HggUGNGja46RQyDSuXOG17iiYYPjZ4Twuxw4AQD2PV4mfnU/zxCQdh7bwFtLtafEoY/ztooC6DETryaciDrOj8+CbSxEPi7bMUwtbWMe3diAoOcvGTraCPo32HmJZqcjadWKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BotCbURfJtn+w7FkKp/46IRYrY4Bm5tWf0k35okr1KM=;
 b=GtgYNoH4VzfOMJdaZNL14M1k1CA7UQLLECqtzKaScW+4tnKDP3ZRqFmfcKAccGN97zJ3taT+XkqpmO/5dEV4WKLcLAycg4O9YdSjxIqZsfr2hbHiZ+K1uqfe7XNuC7UcVs6ATJTp/pn77bFkw9ZBYiKtFDhpP0/eAmp58o9AmAMOZMlZN0sXLAqvYltAAZyxBAxLAS3TV8GIbo/PNr51fR3PMBKxe3IP5D+t3twSk1HhJ0SErB6tcguM2Qj47ZdOyzcPdYYD0+QvDR8unoe3B+KEIyvuvBh6gOuYmJVkBPjtmA6VNkIwzdO/pFlEuOabdq0RrNgMG0Hw8qfXX8kdpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Fri, 18 Apr
 2025 16:10:34 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:34 +0000
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
Subject: [PATCH 07/14] rcutorture: Comment invocations of tick_dep_set_task()
Date: Fri, 18 Apr 2025 12:09:39 -0400
Message-ID: <20250418161005.2425391-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d789ec3-f464-4b48-6d63-08dd7e938cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?19Xm5DmbVpSjSgXeWGdykMfUpgcoDw0ci4nWsyRx7v9rTUOSo9FcaL0fttkj?=
 =?us-ascii?Q?xHFbSt34jTHDsJkztjW3k1jaP1UW9bnY0xZnvjTdC/GsPTIkJJ1bSJmDcjiD?=
 =?us-ascii?Q?D7D8P6xHz7Ule8eqoY5ZjwaFdViJx4sEnBBJcuB8+dkp76ULhEdxItiCpE/3?=
 =?us-ascii?Q?abldO41Jfo1YdC7ZHuO0819VK35Kilv7aFB+llSorXvFJHETpAWWWTZJK35L?=
 =?us-ascii?Q?0rBjzCh9szSC1FkqcX4Icv2VbiZANWZvRMOvkNazgac8u0nF9IVMks2Qg75p?=
 =?us-ascii?Q?ZtrGnzssYa07WTdhJagmsqsFPHIXmntBUMzsszWCMjKlqjgGWmbxofNeEysV?=
 =?us-ascii?Q?/02aaMWJimL9Ca0kTJOtb87sBYDW0JYWfPw8NFm8UM0sY9JCz2s65nQukVvJ?=
 =?us-ascii?Q?hT+gRMPO2kTneRap+tUewO2KHe++OGHYbv/6QTfwMOt6qrABp7FPM2gwe7Iw?=
 =?us-ascii?Q?dUH5Twk4SAXYRUkRsgj0YoeEYJxL2o5WxVI0hr/evQj5hM1adUb0j3eJIvGX?=
 =?us-ascii?Q?s+mQ142xkDv1oPWDq++geeIM3QAdVNYgNsjCVlpYmFF49fCzLCe2mHaxFaHX?=
 =?us-ascii?Q?2/KjEDATOOh4SC1KjLOxKO3v3dIxzXAWyuJS0/KEsmq0GCrkMCy70ktHO1u8?=
 =?us-ascii?Q?N3q0ITb9g0P2LhOLV7rbDNxfVYGUWCSFHNZSXW4rSZOewWdBwpxJ/k2t9dWg?=
 =?us-ascii?Q?NLnSu5z0OrqSXPNbnsRB9X5yoNnnRsmLapgJNysMDDu4bV2PAPd9jEEFt2f+?=
 =?us-ascii?Q?9hZANkWm4jSwDdAw72pmKKmVWQizdkjELpMqaRAJuzc5w45vK7zdMSdfvpOl?=
 =?us-ascii?Q?2zzR94b7dKm/KVLGUq877wrDQzh7yEMVG4Oz3rp/Jt0G9dHpzFAdaMTB1d5N?=
 =?us-ascii?Q?bDjyoU+0dwFSBZ/UL35D4C2knTsfnDBLX1kmMwBrpi0nRdmzQLDS5Nue7GxQ?=
 =?us-ascii?Q?YAE4WdSVOPHp/orqLoFnJ4oNrHNemEjXQ6mVbmGN99drH1wPZJogwqevi0PK?=
 =?us-ascii?Q?lSKWJWymgpoc5B6pQImphf8ycGP/EeuE45te/gx2AJ/u2KqFH677tc2yWclz?=
 =?us-ascii?Q?E86VnJw6vCH1/a9ludIFj4//NhgITlzhAy5JGaKDr+leXZCwU+SK5uT0D1kV?=
 =?us-ascii?Q?T+oJDd7lA8hUQYC2fslBCdtGUtZ7080s6tkNiXM1lAzQhDH7wildGvjaZDDK?=
 =?us-ascii?Q?dFqB3rWf+0qf4RGpen9S6OLGJtTPO/CXOhAqvmkQ+TUxW4/B5yD7m+llkKFX?=
 =?us-ascii?Q?1qZp75AO6S6oIUWrxdOZYtMCTrHPhDGYm+m6tkmZ/Cwyv+77N309F4dH8lBe?=
 =?us-ascii?Q?SpQKFACnW9p6UnxRdbkQfhKP+aQDQODSWgyDPkmeTPWXtkEtT8nH/lT/WgQi?=
 =?us-ascii?Q?h+gb5uMe4lVXHTDn2ubW+HUmzjbCR+O4niljoeTv1/nR77aOfwhnPX94pAtI?=
 =?us-ascii?Q?yZBsNSBClClQQrQ6z2/DJ4UEh8diHPOU1cR+drKp9557Aow0D6z3qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JcH9XrlkTGN2YpwO8YY4qqGHLD9yZvBzIgohAHSie/dqFXDWYL7Bs5oeGbOy?=
 =?us-ascii?Q?1B6zVWJAC+RXAa43gRnRLfjWYYZL94S9FfUIGFNR3LsRJ0VYBi1oUsCz9iIP?=
 =?us-ascii?Q?x/nV783lNWjgF10ZFOIeqMVb7rhion1oersM8JLU5lFxIAnG9IoCLDsv2JhL?=
 =?us-ascii?Q?q0LQ5bawqeObuaoC07hImcvwCG9Ge1RErWQfzTtHrTWON2fxr/3+l1AD0fCY?=
 =?us-ascii?Q?OMY3FQ7lVoexyYtyEdKCUqR8VKNAd6iynOETurkCoFxdziSpakrOce8ewOEI?=
 =?us-ascii?Q?i9y8gieBm1oJfGdff0dhTOLwASoRnzqdLyz8eZlb3W4fgWZk4HrKIXq+8W8r?=
 =?us-ascii?Q?ZVSW/odB2UM7DCr8mY0+pzmLe+1jqO863D55w0emJBGstGnF4Coc6bC73uoI?=
 =?us-ascii?Q?lsLmPDjv1H/ar3o6c1p6fJlRlufSVJkG06zs207O/ksfPRE+zXjFcnCHXJ59?=
 =?us-ascii?Q?qG3Thfi8LAPF1kmeZjcCfZAT50ge47kgu3DrhVPgdHUPQQdV0GFYoqWuNqsJ?=
 =?us-ascii?Q?R1jj0zj1Tw3v+aZrr0m0R8PyYRPZVwUOlek3oOSw24i48ntabZKNp+nk5qC7?=
 =?us-ascii?Q?yd86S065RvStYV9+n/46+BtdT8lXWlHk5FmQFFD6q5aggLzHWyVXIhkNDGJe?=
 =?us-ascii?Q?4tI9O5VCEeAiCTY/tkARlnkN2qWlTh1MwsotKMoTYBf5G4OhZFWf/oNp7n0E?=
 =?us-ascii?Q?cgDMHiABbH5iDt5ymI9YqUPPneAK0TcjOm7tHWHix7KbqP0f/j89nP/WPCtE?=
 =?us-ascii?Q?e9ugdeYzyoJFv9vzfO6DH7e3Xsxj7w8rTqY4satOVa43DL19mSNH1ZETKCim?=
 =?us-ascii?Q?aSGx4SnlwHu1xKkQ56I18fBZ3r7a/cgdDBaaRDxYzI+dVqaVO/WC1UTolYGa?=
 =?us-ascii?Q?Qip6/hCh8ODji5BpTJeOq107HUD2SOEmQ3yXB+Nj200U5FVx1a6+1yt0Zyp5?=
 =?us-ascii?Q?HAkFpPL4nRD/Gp40d5wfCmyYMgydz4vm0xFt1rvB0KIV4In2oFxhkwsxoOIq?=
 =?us-ascii?Q?Z8s69UWpEv0xkgv/KDmHMRVhQV6KiKTGDR6vzik+wmw2XYlVhWjOmWJI7L3O?=
 =?us-ascii?Q?/9CNKVZQCoRPxT05cYqxJfxOgNdpY/JgvbE8Z858GeKniUqRw6mIuxGVNkJV?=
 =?us-ascii?Q?z+LWDn9u8zUJwGk4lkw7tLcgv+LPkG1ys1QMmjZeWnMzegHsJJ9zAmsaTZY4?=
 =?us-ascii?Q?Xi7bVLoIRtXM4NqTOw/pAKjwliqHrMrXHS0KR8sda2Ix5y12YifbNOup4dgY?=
 =?us-ascii?Q?QJ2MFBD6wJeVoEWPBjFbi6iKSacJFEz237kN7mSOwKc+3p4J2S5IcqdfnDNw?=
 =?us-ascii?Q?D0aSfYVJdpyF1PDklbq3Fvz7aeAw6E3kj+1TbvuLaDaPLBD99idgZ87FSKb1?=
 =?us-ascii?Q?27EdRxQkHLEXzbdU2fAb+KSKikRWACZ12V5M8tmIuO64UaPxrZcC7OCK1Gb5?=
 =?us-ascii?Q?PnsI6nxUZLjd5lnmnksLegSyQyK0tpcIJ3chSOYVmuMw3P30TN/rJKpzs+DO?=
 =?us-ascii?Q?FQvvGOuVLJo4qTjTj0GV6G7hza+ii3YppyAplcFtJYevWTCII80lvyt4GfcF?=
 =?us-ascii?Q?vQVs5mwarEtPwPhByUiDXVtaaNc3NeIQ/O4L2AEA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d789ec3-f464-4b48-6d63-08dd7e938cf4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:34.7947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nbLDjYBEZG/5olhaWjEOt22mFV5FXv/BCZV36J49n9x2Ao9f5zuR1OdeGPOvnb5pum/ot+PD10e39CqGd/3Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_torture_reader() and rcu_torture_fwd_prog_cr() functions
run CPU-bound for extended periods of time (tens or even
hundreds of milliseconds), so they invoke tick_dep_set_task() and
tick_dep_clear_task() to ensure that the scheduling-clock tick helps
move grace periods forward.

So why doesn't rcu_torture_fwd_prog_nr() also invoke tick_dep_set_task()
and tick_dep_clear_task()?  Because the point of this function is to test
RCU's ability to (eventually) force grace periods forward even when the
tick has been disabled during long CPU-bound kernel execution.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index daa55ff05570..25010666576b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2410,7 +2410,7 @@ rcu_torture_reader(void *arg)
 	set_user_nice(current, MAX_NICE);
 	if (irqreader && cur_ops->irq_capable)
 		timer_setup_on_stack(&t, rcu_torture_timer, 0);
-	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
+	tick_dep_set_task(current, TICK_DEP_BIT_RCU);  // CPU bound, so need tick.
 	do {
 		if (irqreader && cur_ops->irq_capable) {
 			if (!timer_pending(&t))
@@ -3258,7 +3258,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
 	rfp->rcu_launder_gp_seq_start = gps;
-	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
+	tick_dep_set_task(current, TICK_DEP_BIT_RCU);  // CPU bound, so need tick.
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433119;
	b=iRv2BxRYGc0tsE5e0BWdHxvenIrYAQrQHQ8kQbuU/8yX6hc3cfyAbnEfwo/i3nl6iyMq
	 bZ5kb/4/8QXRuOwiduWRp+H8gg2uvcjOfkwboEJ3NxKqtm2TEc9EO0o283O4983FE/qwa
	 lPbOKKGkpUqYXytPqBOqrHZuXXf16j24Pb/twDvtrWGu2B7zd1lQsrJmgijBpDcBcRvRJ
	 rS36A0HlH8tVHw/JXoJqWQFOJYyiTmXA1vthw7YhazvWKA2PBijrDH+9K5IEB3h9Zyfl3
	 uYg6XYZicj2mXUFRcGN0xg031n4NB3BID45TOdcTJcWOu8+40/bFsMmINXjzP4vp/Vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433119;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ysA4b8x63jaLjRueqPmmcO8y779HYWalzB+L7R5PuqY=;
	b=aSGh/o8rU2v2mHnpIQVK6SF/WHmeOZRxHux/jYI9rI13q2+eFkMHwmPbgO1dvipm3EgY
	 x0wrY9rmlwJQttdydqW74F+/VLqj/8oJiqbuL71Ye2f5skca1oLMDhMl1OgSgO0bJSXxC
	 ZUIB2yZIZyxDrnA78WVayBwpCiL7CyR1CslEXtQMhIJBBV/D+OfDQqWkfxz/xTIkMbPTu
	 6ThspEbsfBMoE+EbkxIVFlMT5pdH5Qa19o3lpei/V5fGbfrmu2a0hpp+hRouwCJvXsn5+
	 Dgxnk/178mjWQOjHXMjAjuNvM6XqmS+T6zE66aF5KrkX9lXvSEOBavPhFe+IBa70Xdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bjm1Hht+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.39
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E3606A339;
	Wed, 11 Nov 2026 21:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB5E3606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bjm1Hht+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA1k5Ka+/E0b8z5HAvfUio46BUdZCs6bPh/Zpy+5gijC2tKGMYUcg8VTTBhkcpZFrL/XIrFvcoBXc6uPiWzBEexYrDCbYW+UolyVfB1mStff7JipnrcWuheXv+oRz7JHdHVABNYu/wBh2OH55IPi3j7OljDNmKJPfXl2QQtp1kUAVF2DsS/M+8raeD0QdhbjC/QiVplBj3DuCj2uTMg8UT5BD5Wmp27eWQxC8957+/FW7s5IDoHtEhoMMMNncTdMGJd/LonzNTbqD3vVtnsWkGDb8mz+w/MYCNQc04lOOQokljUBZifhuVP1qdR64wHJ10+PuYiS5VW2sDCpGspSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysA4b8x63jaLjRueqPmmcO8y779HYWalzB+L7R5PuqY=;
 b=uthO8UtCzUbsaMS1UGTilRTpbpJXDzqhUxsg4aixFGETT+RXR36Dmp9Lp99D+hUusYfWGxTeWdU9CnQv4jz5AapZF6E1m1CKMaVGOC/luWYPiuwQRD99htw3cXy2kzZgy9ZClto0dYgak7cSl9wQmf/AN+VmU3u86w14Y3E9NzCV7RO9zvt+GNneiHbEKWg+lzlkR36g95KDtRMADofZC630Fit/ONEXIpWQa6IDpnzqUJaUtMOtdZduL1dpH1UAXkiXtI4dzV/yfwtdAxX6V6TTbM8v4LIa82fYq1NG0xwF3qNLxp6VsqJUSlBUMJWKnrcruENriiUj0WEoPjSg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysA4b8x63jaLjRueqPmmcO8y779HYWalzB+L7R5PuqY=;
 b=Bjm1Hht+eokEmULBw2IMDSK901CB7kUe30Y43AIynTLnoKDrA0fMrUIViy9NmB2wfvhlXS1dwhCT9xMX+o21pzyABpLy+P589+/5e55MpEbBbSW2mVWleh35zVD/VAJfrIMyClk9Jba5uHdbzZUzQpGaKcgbKqKoisA0v9CvmynoxUZmRe95Q2VgHHFM4DaS0PmiVjZKyVCr9WmvO4P+kZjVub77qYvehGCjaDRctxD6ZohSLpD2CGT/9Oy5BIvWDy9+YWty+X1inBSsc+Puo0KhExer8fm+a5P/Lu9VXoiSgV1CYw+/BKdPK6NrcvphA3xwEE4BF4IK3wgGZUA4Wg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 21:38:33 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 21:38:32 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 1/7] rcutorture: Rewrite RCU priority-boost test around a CPU-hungry reader
Date: Wed, 11 Nov 2026 16:38:19 -0500
Message-ID: <20261111213826.2035045-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111213826.2035045-1-joelagnelf@nvidia.com>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:208:2be::14) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 501d0a9c-5cc1-4843-f06a-08df403c2255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|261102123227099003|261021135927099003|261028144727099003|11063799006|261021121427099003|261022105027099003|261026140227099003|261009223027099003|56012099006|261021123027099003|261026121527099003|261022075727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	BO4XfizC7EY+lLHNRpSYj1OAYBzIZXEiuhJrksZUf3edrHuD1I3ACbNuGp7yEElUgJutxE1nQSGcmd7e4M0GiA05jOQy4Dujy3H5Z4g2d1LOUs2mcSg+ULgnDhb8ru8OwjyAomlKu0vYOkOGejR/hXfEIIpTHd3sti1kd4fxIJzqL1ttQgOsSA1hZhXrVQmbCp17BLDMgly8E92u0+NJOK7k7w0NTU2P594FP0XgxdDseYc2yfThIk2yfxDC4kFDHb6nlJEFI1oLrrxyCkTaEszVkt4Hfk8t2fKW9mDExQnxD8QPQ/KAieIoEePgxl7ibzvS+tIfyu66C3igwC/4fxqvuTGqZlDU+sJ6Gu6vMBUabFDc5yl1wbPaNaD3keKxTyozb4ZNJ5NF8YJUEXWfIviRe0qUUfQKYZddCz71sb8UnLiyCz9T0A4H/lYanKgXCO8shCVJFXvJn9m5rFVVH/ONeEmSev+G3zo0pmvYR/N6uE7Ta2CiBnH5wW3cV+YeCkZqyybNu6GLEHe5yefa2crtYu9hSSlFregRqVHdFczMHhMXsIrUU4k4+pgFezD9P1nHNyP5mP03FzAotzcCUPT7zW8c3UZ5XPas0kC79F5mQkyFMa0jgFX2ZTvVZ6dVm8KeY5ZFcHapIk6Xi94EKmLxUnCAUsUkFxE9us0z2ok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(261102123227099003)(261021135927099003)(261028144727099003)(11063799006)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(56012099006)(261021123027099003)(261026121527099003)(261022075727099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qrSXQooVFd5vmFK7Osn6AH3H6WEG/LxjrBQq4BNODbxRn866U5wGmMdSEQBu?=
 =?us-ascii?Q?4+08gTToORwwFaqk6uj1UkPyyJet3pt70Sz9Qg6DwL5MHekuY70NifzF4qzx?=
 =?us-ascii?Q?0fBplRX5cgSh8S8CG8IQvP0s9zeld+c9CBswIEhATeo0/+2jW9LrhlCVjxhQ?=
 =?us-ascii?Q?a8AlBuAZo74T0ytxXjC4J1UWnbM1DGqaFdcf8gX25Vt4OWJWqsl50dqlDIlH?=
 =?us-ascii?Q?qShE+h0bPr/pGz4ShkhTCi6tKKyAl/C7Aa5arauEOoXvV6nKehjIuW1LR6Wb?=
 =?us-ascii?Q?lkOUaD+aRaCGbN3TK2nLjYMVNCK3PbhWxdqX+19V57Z8SYeQhnUko42U0BIP?=
 =?us-ascii?Q?9zAfT1Jds6RqPUbtf4ZNChQuwc++AJPJ5CEtu/coOshiGovifPdTgy/14lED?=
 =?us-ascii?Q?EmxTKdJGQX5+1d+YT6nSoAnHHROLTpqVXx45njBFWdyJ80cw7v5k31iM2J/M?=
 =?us-ascii?Q?W7hkfaNjUGzw2ROwVLO6Bq1rO9ZWkDzE6IDWVYWeptKsmRmxu/OlDbuUHMym?=
 =?us-ascii?Q?UChUUxakQ9MLhjR251GNpVdhd1Hdf29YmzvbaRRi2+tew1HLsICpfR9R39ww?=
 =?us-ascii?Q?fAxJA+nz0mGoTCeZ/efM0xtggRHGl0xK+9FRveKKaUJDwT2ixmMpEay86FOR?=
 =?us-ascii?Q?utzsqOcJr7nPrn0T/bmBd3wfzM2kl9sZqePj9kGIm91uNwXroW2rjluUwrbs?=
 =?us-ascii?Q?pceTrFfslaU0nDguo6YPWhnyDpGOPiXFF5YTK4uS8wG1tUQrro/tnCEY2mb1?=
 =?us-ascii?Q?543PjDSCUeCMq5CXbfbNCbxEFe2FwEsHOLHt0JSjIpwxsCM3brOOpQWKKS6y?=
 =?us-ascii?Q?EFY2TKCvFeNsJJ7xtadcyB3W5RU75NCyryn2GC5ZHFzCyipFpxe1yNkvlSwF?=
 =?us-ascii?Q?1KAB0+Y1ffUnZ/7PD3lGXFVjRFjz/YYO8M39NlTVF2ZoCYgSydv6OwE9Xk3R?=
 =?us-ascii?Q?0DG71VnBlDCHQA4J7wqUGP5ORa3Ideuu057Swd70/HZ/qTD1I7FN+mH7hrom?=
 =?us-ascii?Q?0c36edG38A+CG6faAaQG9pexfLKRICznw8Gizr5q3VQHwffuB48UFEXz+mXf?=
 =?us-ascii?Q?I7fCDkMKIWxkzH1TsVGeCX7FQZMvVRKQyV0N1EjUnP9Eis9vP6E3mWaYOL1n?=
 =?us-ascii?Q?p7rfvWdMJBnZZzjgaxfHBwAqxJ4Rv2NvYEJ7erSmbKXZ4jP82mkV2Qo0IoQJ?=
 =?us-ascii?Q?2x/TRoB6+clAKhtMEkSYNMrVVWVe6XTQAc2mAbj07NZk0am/wW/K0axA/sTI?=
 =?us-ascii?Q?r7g+VuqwBuH77xuafm8Qd1p8yREbfLlXaX9kXbqWaYvlz3gRCDwwlcjLYeOR?=
 =?us-ascii?Q?jcTVwCXlk9CRFJFhuuSCDRcAHYANOidRbUyRRUGAdwJwEvrJPQVp7+iI/Gks?=
 =?us-ascii?Q?a5QLOfHiMTKQKlkZf5cWqPyZz8ShgSsM+FOTIXJqz33/88ax+M07bIMR8z/Y?=
 =?us-ascii?Q?a+lhTC+mXlIXqQ/XgqnCe+wsNMgDQnMJIsewSQXJ2SS4FH3WrUhcNphqf6CG?=
 =?us-ascii?Q?MY+S2GuDM5rQYXxTgs8w66CZU5VYOtsBA+4hGeiE6zEAjCgg2w5MOG4gT25X?=
 =?us-ascii?Q?QQGn+iKMW4PCZNR7yKupkxw9TjWL6noSpaUrkuaC2smtQUmzWgLB6GWEFIxN?=
 =?us-ascii?Q?Lf5a0Ihw0Zlcm2kjZ7lV6N6rOQZWBuPnn1vZiSQ0FziKjO+f+3SNKdCSTAIK?=
 =?us-ascii?Q?twVp/heK17oSNTJl8pVPya9KaPYfBIeH+7HGpgeDsEbiTBgW1jDDFsJ6RR2R?=
 =?us-ascii?Q?atBNsO1bLA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501d0a9c-5cc1-4843-f06a-08df403c2255
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 21:38:32.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRcijrI1CeuxWizzz1be9dl07Vo6Uk7o7NJVqUFjwyEuxFKULam3Mt0tqXGCLDN9ded7KKeze+ofNlrj9Sitqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

The old boost test relies on RT throttling being disabled and on grace
periods taking too long, which is fragile.  Instead, each interval one
CPU runs a normal-priority reader that spins inside an RCU read-side
critical section until it has consumed test_boost_reader_ms of CPU time
(measured via sum_exec_runtime, so time spent preempted does not count),
while a SCHED_FIFO hog on the same CPU tries to starve it.  With RT
throttling enabled, an unboosted reader gets only about 5% of the CPU,
far less than it needs within test_boost_duration.  If the reader
finishes, boosting worked, otherwise it failed.

Only one CPU is tested per interval because RCU boosts the readers of an
rcu_node one at a time, so a second slow reader sharing the rcu_node
would wait for the first one's whole CPU burn and falsely fail.

The reader publishes completion before leaving its critical section.
Otherwise the deboost on rcu_read_unlock() lets the hog preempt the
reader before it can set its flag, which falsely fails the test.

Testing methodology:

The test must pass when boosting works and fail when it does not, so
both directions were exercised.  All runs used kvm.sh with
--duration 10 --bootargs "rcutorture.test_boost=2" (which also forces
the test on in scenarios whose .boot file disables it).

Success testing: with the series applied and no other changes, run
TREE01 TREE02 TREE03 TREE08 TREE09 BUSTED-BOOST for 10 minutes each.
Every scenario ended "SUCCESS" with rtbf (boost failures) of 0 in 59 to
83 boost intervals.  (BUSTED-BOOST can no longer fail by construction
because CONFIG_RCU_BOOST is now enabled automatically for preemptible
RCU.)

Failure testing: break boosting on purpose by making the early-return
check in rcu_initiate_boost() (kernel/rcu/tree_plugin.h) always true:

	-	if (!rnp->boost_kthread_task ||
	+	if (1 || !rnp->boost_kthread_task ||

then run TREE03 and TREE02 for 10 minutes each.  Both ended "FAILURE",
with 58 of 72 (TREE03) and 62 of 72 (TREE02) intervals reporting:

	rcu_torture_boost boosting failed
	Boost inversion: reader got only 203 of 2000 ms CPU in 4003 jiffies

The 203 ms is the CPU time that RT throttling leaves a SCHED_NORMAL task
over test_boost_duration, confirming that the reader finishes only when
boosted.  The remaining intervals were discarded because of hotplug or
stutter.  Setting CONFIG_RCU_BOOST_DELAY=3000 also produces failures,
roughly half of the intervals.

Pitfall found while testing: a first version set the reader's finished
flag after rcu_read_unlock(), which failed about half of the intervals
in TREE01 (readers on CPUs brought online by its nr_cpus=17 hotplug)
even with boosting working, hence the ordering above.

test_boost_reader_ms should be well below test_boost_duration minus
RCU_BOOST_DELAY and slack: a boosted reader needs about
RCU_BOOST_DELAY + test_boost_reader_ms / 0.95 to finish.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 180 +++++++++++++++++++++++-----------------
 1 file changed, 106 insertions(+), 74 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 924705b7759d..2152906a807e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -149,6 +149,7 @@ torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
 torture_param(int, test_boost_duration, 4, "Duration of each boost test, seconds.");
 torture_param(int, test_boost_holdoff, 0, "Holdoff time from rcutorture start, seconds.");
 torture_param(int, test_boost_interval, 7, "Interval between boost tests, seconds.");
+torture_param(int, test_boost_reader_ms, 2000, "Boost-test reader CPU time, ms.");
 torture_param(int, test_nmis, 0, "End-test NMI tests, 0 to disable.");
 torture_param(bool, test_no_idle_hz, true, "Test support for tickless idle CPUs");
 torture_param(int, test_srcu_lockdep, 0, "Test specified SRCU deadlock scenario.");
@@ -333,6 +334,7 @@ static bool shutdown_time_arrived(void)
 }
 
 static unsigned long boost_starttime;	/* jiffies of next boost test start. */
+static unsigned long boost_claimed;	/* ->boost_starttime of claimed test. */
 static DEFINE_MUTEX(boost_mutex);	/* protect setting boost_starttime */
 					/*  and boost task create/destroy. */
 static atomic_t barrier_cbs_count;	/* Barrier callbacks registered. */
@@ -1334,10 +1336,17 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 }
 
 /*
- * RCU torture priority-boost testing.  Runs one real-time thread per
- * CPU for moderate bursts, repeatedly starting grace periods and waiting
- * for them to complete.  If a given grace period takes too long, we assume
- * that priority inversion has occurred.
+ * RCU torture priority-boost testing.  Each test interval, one CPU
+ * runs a normal-priority reader that spins inside an RCU read-side
+ * critical section until it has consumed test_boost_reader_ms of CPU
+ * time, while a SCHED_FIFO hog on the same CPU tries to starve it.  RT
+ * throttling is left enabled, so an unboosted reader gets only a few
+ * percent of the CPU, far too little to finish within test_boost_duration.
+ * If the reader finishes anyway, boosting lifted it above the hog.
+ *
+ * Only one CPU is tested per interval because RCU boosts the readers
+ * of a given rcu_node one at a time, so a second slow reader sharing the
+ * rcu_node would wait for the first one's whole CPU burn.
  */
 
 static int old_rt_runtime = -1;
@@ -1366,61 +1375,111 @@ static void rcu_torture_enable_rt_throttle(void)
 	old_rt_runtime = -1;
 }
 
-static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *start)
+struct rcu_torture_boost_reader {
+	struct completion done;
+	bool in_cs;	// Reader is inside its RCU read-side critical section.
+	bool finished;	// Reader consumed all of its CPU time.
+	bool abort;	// Hog asks the reader to give up.
+	u64 ran_ns;	// CPU time consumed so far.
+};
+
+// Reader CPU time so far, retrying to avoid torn 64-bit loads on 32-bit.
+static u64 rcu_torture_boost_runtime(void)
+{
+	u64 a, b;
+
+	do {
+		a = READ_ONCE(current->se.sum_exec_runtime);
+		b = READ_ONCE(current->se.sum_exec_runtime);
+	} while (a != b);
+	return a;
+}
+
+static int rcu_torture_boost_reader(void *arg)
+{
+	struct rcu_torture_boost_reader *br = arg;
+	u64 goal = (u64)test_boost_reader_ms * NSEC_PER_MSEC;
+	u64 ran;
+	u64 start;
+	int idx;
+
+	idx = cur_ops->readlock();
+	start = rcu_torture_boost_runtime();
+	WRITE_ONCE(br->in_cs, true);
+	do {
+		cpu_relax();
+		ran = rcu_torture_boost_runtime() - start;
+		WRITE_ONCE(br->ran_ns, ran);
+	} while (ran < goal && !READ_ONCE(br->abort) && !torture_must_stop());
+	// Publish before unlocking: deboosting lets the hog preempt us at once.
+	WRITE_ONCE(br->finished, ran >= goal);
+	cur_ops->readunlock(idx);
+	kthread_complete_and_exit(&br->done, 0);
+}
+
+// Run one boost test on this CPU.
+static void rcu_torture_boost_once(void)
 {
-	int cpu;
 	static int dbg_done;
-	unsigned long end = jiffies;
-	bool gp_done;
-	unsigned long j;
-	static unsigned long last_persist;
-	unsigned long lp;
-	unsigned long mininterval = test_boost_duration * HZ - HZ / 2;
+	struct rcu_torture_boost_reader br = { };
+	unsigned long endtime;
+	unsigned long gp_state = 0;
+	unsigned long start;
+	struct task_struct *t;
+	bool stuttered = false;
 
-	if (end - *start > mininterval) {
-		// Recheck after checking time to avoid false positives.
-		smp_mb(); // Time check before grace-period check.
-		if (cur_ops->poll_gp_state(gp_state))
-			return false; // passed, though perhaps just barely
-		if (cur_ops->check_boost_failed && !cur_ops->check_boost_failed(gp_state, &cpu)) {
-			// At most one persisted message per boost test.
-			j = jiffies;
-			lp = READ_ONCE(last_persist);
-			if (time_after(j, lp + mininterval) &&
-			    cmpxchg(&last_persist, lp, j) == lp) {
-				if (cpu < 0)
-					pr_info("Boost inversion persisted: QS from all CPUs\n");
-				else
-					pr_info("Boost inversion persisted: No QS from CPU %d\n", cpu);
-			}
-			return false; // passed on a technicality
+	init_completion(&br.done);
+	t = kthread_create(rcu_torture_boost_reader, &br, "rcu_torture_boost_rdr");
+	if (IS_ERR(t)) {
+		n_rcu_torture_boost_ktrerror++;
+		return;
+	}
+	kthread_bind(t, raw_smp_processor_id());
+	wake_up_process(t);
+
+	// Wait for the reader to enter its critical section, then start
+	// a grace period that it will block.
+	start = jiffies;
+	while (!READ_ONCE(br.in_cs) && !torture_must_stop() &&
+	       time_before(jiffies, start + HZ))
+		schedule_timeout_uninterruptible(1);
+	if (!READ_ONCE(br.in_cs))
+		goto out;
+	gp_state = cur_ops->start_gp_poll();
+
+	// Hog the CPU until the reader finishes or the interval ends.
+	start = jiffies;
+	endtime = start + test_boost_duration * HZ;
+	while (!READ_ONCE(br.finished) && time_before(jiffies, endtime) &&
+	       !torture_must_stop()) {
+		if (stutter_wait("rcu_torture_boost")) {
+			sched_set_fifo_low(current);
+			stuttered = true;
+			break;
 		}
+		cpu_relax();
+	}
+
+	smp_mb(); // Time check before reader check.
+	if (!READ_ONCE(br.finished) && !stuttered && !torture_must_stop()) {
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
 		n_rcu_torture_boost_failure++;
+		pr_info("Boost inversion: reader got only %llu of %d ms CPU in %lu jiffies, GP %s.\n",
+			READ_ONCE(br.ran_ns) / NSEC_PER_MSEC, test_boost_reader_ms, jiffies - start,
+			cur_ops->poll_gp_state(gp_state) ? "ended" : "still pending");
 		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg) {
 			pr_info("Boost inversion thread ->rt_priority %u gp_state %lu jiffies %lu\n",
-				current->rt_priority, gp_state, end - *start);
+				current->rt_priority, gp_state, jiffies - start);
 			cur_ops->gp_kthread_dbg();
-			// Recheck after print to flag grace period ending during splat.
-			gp_done = cur_ops->poll_gp_state(gp_state);
-			pr_info("Boost inversion: GP %lu %s.\n", gp_state,
-				gp_done ? "ended already" : "still pending");
-
 		}
-
-		return true; // failed
-	} else if (cur_ops->check_boost_failed && !cur_ops->check_boost_failed(gp_state, NULL)) {
-		*start = jiffies;
 	}
-
-	return false; // passed
+out:
+	WRITE_ONCE(br.abort, true);
+	wait_for_completion(&br.done);
 }
 
 static int rcu_torture_boost(void *arg)
 {
-	unsigned long endtime;
-	unsigned long gp_state;
-	unsigned long gp_state_time;
 	unsigned long oldstarttime;
 	unsigned long booststarttime = get_torture_init_jiffies() + test_boost_holdoff * HZ;
 
@@ -1441,9 +1500,6 @@ static int rcu_torture_boost(void *arg)
 
 	/* Each pass through the following loop does one boost-test cycle. */
 	do {
-		bool failed = false; // Test failed already in this test interval
-		bool gp_initiated = false;
-
 		if (kthread_should_stop())
 			goto checkwait;
 
@@ -1457,33 +1513,9 @@ static int rcu_torture_boost(void *arg)
 				goto checkwait;
 		}
 
-		// Do one boost-test interval.
-		endtime = oldstarttime + test_boost_duration * HZ;
-		while (time_before(jiffies, endtime)) {
-			// Has current GP gone too long?
-			if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
-				failed = rcu_torture_boost_failed(gp_state, &gp_state_time);
-			// If we don't have a grace period in flight, start one.
-			if (!gp_initiated || cur_ops->poll_gp_state(gp_state)) {
-				gp_state = cur_ops->start_gp_poll();
-				gp_initiated = true;
-				gp_state_time = jiffies;
-			}
-			if (stutter_wait("rcu_torture_boost")) {
-				sched_set_fifo_low(current);
-				// If the grace period already ended,
-				// we don't know when that happened, so
-				// start over.
-				if (cur_ops->poll_gp_state(gp_state))
-					gp_initiated = false;
-			}
-			if (torture_must_stop())
-				goto checkwait;
-		}
-
-		// In case the grace period extended beyond the end of the loop.
-		if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
-			rcu_torture_boost_failed(gp_state, &gp_state_time);
+		// Do one boost-test interval, if no other CPU claimed it.
+		if (xchg(&boost_claimed, oldstarttime) != oldstarttime)
+			rcu_torture_boost_once();
 
 		/*
 		 * Set the start time of the next test interval.
-- 
2.54.0


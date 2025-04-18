Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCDD225415;
	Fri, 18 Apr 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992675; cv=fail; b=JJRbowDUgT999BP35QZJaUyCEer1DtHCcHFYtI842MEaEZAtvU/tSezdD/r63S1tRHWJoIWWVWHaS20ev8wxuovr1cYHwMQSevTcwRGOkmbhWpFOBGNsu8MIpHeOIBK2zgIT1tBpIsLw7hSgnDpOjaLPqUXPCI+ZOSRCWpB1OWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992675; c=relaxed/simple;
	bh=IN1ZQG4QVBu4mmS9yqPZCfUFrZf8GOg7XYHSG+b883k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WszLs4XKYAd55fFnFOmibDmcGshVGqbkf6EYIo+K0B03XRQ2M8GKPQVRNifU+ZXdNe6X7NrCjOp9Pt4QyFp+b8jePmhPpChR0q68lgW2NF8MHtj8pPR7PDPXTvxd2u3lSNLLEsY3zn49F39O/J8rFRLCCjbaHQSC/jyBR+tUPvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uQUeJ6pA; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uQUeJ6pA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/BtHOxA+VQrr3IoCJjD+fBq5uwJfZ8PHGInc1xc2nAskk8l/u3CdRTZenCRAZUhHHu/Eh0SS35pc1gQK59lnyc8Sut7RIHtvQw+7x//0KQ5HOmV9Ybz6xz9YsEOpbHiHJFvQ+Nme3wY62TvzIZTqJT8IofXe8PSNF3ZejjQuEkBrSyEy7cnVDblanq+LYx4FjHiBvmnMvzuVOVUDKK8UVgfGcJyQeErTFsJCmelIj5cMGsL34YZv8qFKY6KKVzseANYaurG09cb2FUOSSTwjYjzwBcwGZn1Hnw6N4bg25hhKRRd9HBg9m38QMWIlYrfgS76s70OF80Cn2Ll6zigZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTNQg5JsGys++ns2mGdmrcyIsr3Ti0kFeYpbkqUk4QY=;
 b=lQ9eNubOBgM/BEUoT7w5OpZTEWSMpUriN949NkAf7dPMh8f9IMdsgLV0lYSPLEXj8MqfzS2oaQeuWVvTnRGmPptvOy4WU5jto0+QUI9VAjqFiQEDVcayUqxVKpn9QeZQR7sF4sq4oYQEXWfSbBZozyBe0AUISiC+uius+WWvnHoak1E3MmOH117Xo8R+XarXdxqtNhgU7htUoJq8460c+CbIwPyLEEZuy/rKQkGJruJGVQmOAC416JtlMhWEV1ir/hTvYDclOijFZFMQd2Ts0k1FLE0p9DOIyAv5ka54qgt0Ry303PqHoU/JDvz5gqbYEWI2ryMoGfMhHSXSk+3Rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTNQg5JsGys++ns2mGdmrcyIsr3Ti0kFeYpbkqUk4QY=;
 b=uQUeJ6pAxqapLBsinrFG3ioBZVI91Hsh5FZhovxI0JciaA9lumA3ifMZDNV9fldSLbrMs6dUk9wbw0UWg5bAF/VtycQOt6KwXhqPR91lj4Ti5Y6ZUx3FV2MnPcSEEBuoIeF16fEGntB7k4Qz9AabMgcGwmnw6QyR8tBxUhQbWv7+/UQLQWNrJ8BZzneKdXtvG0Yc9jxXtg6niX8K3mJMIQhskGl92npb5LAgqcyy40t1eN6K5ZXu/3IsSZAGaTVQ5/UBxflCglOkfZ2fa4XjgsDNYj/EKsuzI/+lWHtYuhJGwvHzAuG27H/MBZvutktGybunrcT4dFw9ZPycjVRj+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:11:07 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:11:07 +0000
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
Subject: [PATCH 07/12] rcutorture: Comment invocations of tick_dep_set_task()
Date: Fri, 18 Apr 2025 12:09:53 -0400
Message-ID: <20250418161005.2425391-22-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 144a4281-1653-498c-ae7a-08dd7e93a025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yISaxc/E4rIeBKK9M4r+beopNzDQ96sppt9ZhkvXueoTLwRUyQF+vsdlK0v0?=
 =?us-ascii?Q?wN3Rt3n2u0btx+KVqifWOK3EJVO0BYg1WhgFHEhD40MRwKNc6yXNkmWFl3Ik?=
 =?us-ascii?Q?gtu7H9ExI45yHOm6/X1YR5DkmUKYVqtDg43PuDadFXf4/BSh20+Fv/gcaXeF?=
 =?us-ascii?Q?CIGuWIu65H3HyMF2DOHx3ml8akY83MoiT4v16Zv4A0yydIS8dD+3rv+ZRBPo?=
 =?us-ascii?Q?pEWNswHZgkg757oafvGrUHJlOQpaKBptKbEyJFO6JeXmJAOaFZTpdU4gmtBc?=
 =?us-ascii?Q?/8m4cTJKXMGu8uSx7I+wPSuqJj1OLlnnWCNcPYvUOdm534Jd78KRie3pork6?=
 =?us-ascii?Q?cIZr4uYa+wcjc4NG2Ir6OIIUXSQlzdxW3VuqIqZrb0o/7T9j47B+ahzlJWGx?=
 =?us-ascii?Q?lazNQ7RtqoSpRVM3T8s6CAUWm2YR2RcZlG0Y7cbs8Xji+qzsP2e2gjvLcb00?=
 =?us-ascii?Q?3HoPploEJOuZozsZllrVgmF6JJ80WEDX2U9tMcWHC4t44rtkD6wVR06zxpBQ?=
 =?us-ascii?Q?F7jMIK4iH56184lRbZrxzmBsKS4isuiXy+LRGoDzbzZzzi1TIot5wmbVVoiC?=
 =?us-ascii?Q?Y/L28yAVurn3krK/aOsDX5IOGpl8jmCvCvIfyTPtFTUgUt2fKEt6/IFMXg0U?=
 =?us-ascii?Q?rYFtyNV9F2kjTVN2R10UTqsCfoPWUlY601BQ3EstJx+3WizqOmNprlKnLg0S?=
 =?us-ascii?Q?3g4YkfwP/C9WlNmIKuGuJuxDIlCo4PEcW0A5baAHePnvwONXt/Gh7gdyEhKa?=
 =?us-ascii?Q?zsUJtVvxq1sAhqQqtxWKFxCYeMinlhnknMbN3KjP9Xyl6yLR5+vDtEeCyXpA?=
 =?us-ascii?Q?6ZSbsv6L1pSPgDaYOZV0Esb9XCO8GDA2j+5qX7Sy9zWtzpcHMdEAhQfAU4vN?=
 =?us-ascii?Q?xFvrcrWqSkX8npdLqF4MpBszM37r2INCPPYeweQYvbm/XPRIBSc9OD9b0kxa?=
 =?us-ascii?Q?j6EjOrppDGGalRM457ydjXNNHsCNiWkUe/MuBSojvOFZ+SyLG8eK8atXQZx6?=
 =?us-ascii?Q?m/0Jc41dhEOXr5vvYGzixipHCCPOlgTotxyyh4WAIsX78Wc+NELvZRYtbMtM?=
 =?us-ascii?Q?wIndpZKjBa9xq6/KoXmOk8sWOnpp4Gf7lwLf7dQYrfZmeQZOphdpzAZnkOk2?=
 =?us-ascii?Q?M16EVzHbR64OrXsO2+KP+LkOJQfGkTOEsFBa28Lj/RjwgmKmdcm25o9oRbTs?=
 =?us-ascii?Q?v7xxLusZPXUArZT+8bqftFu33CK2NA9OgvY0yDj/STnqtEsVfp64EkzCF8QD?=
 =?us-ascii?Q?AEBGGE1h/MaZDCIw63FOYfIiPTrqQyiS/oeIApE9WILyB5i/tlNc6RjkZuJu?=
 =?us-ascii?Q?flOxCMM8KvMD5vjjxDY38mqSb9SbLFYksEy6Z19YA+cxS6bgH1UBPxqW2TnO?=
 =?us-ascii?Q?48Ja8xXDQMFA8uWdlXzmyjgaUtkJV+0T2b9beFW9lrn+57vf4s6JlC9Rm0AS?=
 =?us-ascii?Q?E3hbPY9185aV6vYuRgA77y+U6GFFNECwOa0Ec9XgRUTNtFrbrL7OxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+sq8mHDAD0GnY0mpGLjD9IWZiGb2kuwxrJQogjvN1RNhswtU4WlbTESf616c?=
 =?us-ascii?Q?JEw+IakUEoGYEaQTYlUQBqCyVkUKnXqAvIzjUxR/USaRfqLrR8YieuZlFzbA?=
 =?us-ascii?Q?eWdqkLhj2cPHsL7BjgGw8GFrU17iRqdTMKyqXbY/2xTj/r7opR+7JaKxsJss?=
 =?us-ascii?Q?SIwAyGC++mvnBjXgvFT/DqsqGnibP8ucmMC+brO+4lXORUUHrKaPv3S4Sx+f?=
 =?us-ascii?Q?xY3Z47/KFfsKdc9n+BuDo3Iy8PiOVJQjWmd+JvyaUJ/cd0Ozr56u8TQPaLfL?=
 =?us-ascii?Q?jviqh0qwJqP17PLzjcqObScUIR6Y1+BYc6QsNTUCcjAWpNTuPbgiFISdpPUk?=
 =?us-ascii?Q?0JTGciajSLI1PHaAjaf4FjGZe+0PD2eig7CYMTpFdCzUOicixJpkzVWWGr2d?=
 =?us-ascii?Q?K7++y4dC3VioyBxu/CyIswdfwR14gure/dvAZsEt8xb3/pN4NA2KoDZSKKnu?=
 =?us-ascii?Q?E2NvxSxzbAVSDfpeWXmqmJJ1NeemHKFPJbVxoI653+XydjPKWm8wRPDmOuW9?=
 =?us-ascii?Q?lNg4uRDcqtJ95dIOS4Ue2k6JfX5VErQJKVowEv2nz18kwdH3yHJXtB+o981Z?=
 =?us-ascii?Q?Lx8LKF7NZjeqLGrFt+wDVrgyVpxCOWoZGvFdKqFvSTIV2r2kALX5Sna0KqJw?=
 =?us-ascii?Q?njCI9WMMTCEk7T0mBcI6dMMEbss2ODbNMTPmBXcNCzE9UVqSlGEzM6szBDL/?=
 =?us-ascii?Q?t8pfn4EH6NGFqh9n0RlNTVsq9KbioK1OwOpOkCHJbqMS+UDTQeiB9LF0lg/P?=
 =?us-ascii?Q?/Rrn9YKcXPPS/VVZCNk7LTptqdi5Ad9hdX4QhThpzkJ8CWV1o6/l7QoZeeH5?=
 =?us-ascii?Q?Z8l4pY649UuP3qo1XkFPSIFzrByALUwgk4JVfrKvD1tIbWfupQVKSKnOcbJy?=
 =?us-ascii?Q?ZUs0nElCmhen7LG8tUvLEYTfQCSIajYawXfBr/H5+iNShAL3TuGbSIRGEigj?=
 =?us-ascii?Q?pq5bss4LzlrWxnyGeHXbmeOnpm4owfxkeSxEIT3ddpckJ7iRwICE7LcbfjZW?=
 =?us-ascii?Q?KaHgl8bI+TBO98IMU/KXDd+1iodk/8Kc4YcCuFRc5FnsyQEAZqzhHaK6Mlh6?=
 =?us-ascii?Q?G2AiHowiRphrh8hRs9Qo1BVNpEuzTwaTsglNKNJAibW6SqvSMKozrrJLLF16?=
 =?us-ascii?Q?kjE7cX5XBWXoJ116o8I65BsUCuRSe2Layw3XVyi9m4pgsJWnj2WiBhr/qchs?=
 =?us-ascii?Q?bXzWgEslue78NDMcO8+NIN4R0/XL32tRuNaNfjawjWmZF4+5qjkNqH+C4PLX?=
 =?us-ascii?Q?Zgn5rzZ3f+Yda1F3awDRmj4x0jCZS0SR6hrF38vcLiPXJ0xtFKNSr4XgIG8g?=
 =?us-ascii?Q?WORV/jWuSuehWEU/mX1NxbLDh77SArrdenjewaGIRyT4HcmG1DoRN8ay+UDg?=
 =?us-ascii?Q?ikwMe9eBs8vvjlvW6Y5ZTQSo0xODPIT6kTllwi5nvT/riWyxpbBI0AIW5f1I?=
 =?us-ascii?Q?fjSyYVDRlbCks2YqUvzw427NVWY9VSfMvMg9QTr+mIPXcU07SfIuGsGQIWty?=
 =?us-ascii?Q?HqdbBVF007potn6RRApQDCryngYtUvc98X27KpQ8z4QCoszE2So+AzDrwaZ5?=
 =?us-ascii?Q?PmS/98hJVWwubeYp1kPxY9luwiVvQ//kPrUVAT6/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144a4281-1653-498c-ae7a-08dd7e93a025
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:11:06.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvDZSPeHP01gZTHKMhHVwiFC0kRJ5pgYFJ0lrLsE3ciJHKY6T5eVnwZ/9oFzwQUj+/R+z9DDZowcVR0b7LDc/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

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
index 7eccc74e60a7..ea40f3ad32dc 100644
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
@@ -3260,7 +3260,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
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


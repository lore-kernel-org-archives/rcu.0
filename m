Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794505955;
	b=IGR7hxLwr4dgh2RP1HYMGCLSUx86ee+jd+9BwUWlIz537wgt2B+TN9AoQ0KfjDKvE/Cm
	 XwGoc164LSokK83e26TzW69ufz3qNDhPHDms8OLe+q1JLQWdU1CLhElCouaNMf6RJ6g8+
	 S/GuzwovxdgCfuT3C0bN5eAfUuA6jVm+ekbvl39+HzsKnnPYbUw2RhwL9BCYx6s/UCRp8
	 PMXHjzK3UGMDHYJXOmt0KRJ8Dm2KWAczeVMtACtIkKbej8+1ARe4WUHVzWJ8tgmixnLr7
	 7O6Q3liqjrnw1vxAQ2PwiSTVTwr8JYpLGi2w+zMcT4w0Ssz5BSOLCw32kMUuuYenOWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505955;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tL74Vsf2oZZ1Y7xWB+Ik6hgcaFq5tz8fBLDuSTQyVT8=;
	b=H1BU6TL2RtHoYNi0xioGgEZ4OczBcILry8rxuqXJsuU6ztpi/tdLeZouOb18eK44eorj
	 TiMzfQvb/QRH6JRifIAsXdBD+OgkvNxli45nX/om4hSEqn8uF6FOzLSUORfgWzvU1aPKH
	 cF0IA4MSNwjK5zv1y7NkNF4NP9aJWvR+MGmA2MbxIWyqEx1KvUmbaa2rVR3Ix5H1elKpP
	 DEIrQJuJ2I75/3rcyBHIevWpr8oOcHjDrZCm7wJRcGY/Hxr74KooBbas0LpfCkZJoR3eC
	 KpGFGq3XRaffrEJkpgpR9P1rrlqKUoZWkXY26B2PxKczTpYKmISTAf8JgW+rSFzvTKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ryj073Y1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.15
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB4D606A31C;
	Thu, 12 Nov 2026 17:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB4D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ryj073Y1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ6Q3pIlEg66es+yojQGxQRoY5wNycVb0o6y3f/2+TFST5Ije2QP2Ct+ftZE9Bd00OtbEvHmga0o2JkV4VZD4EKpYbTvIX+CC5U4Ku4dCdID1J87JMT7oSSUe8HgJoT97iLQVJpyJWQhdQ1Jz+10Pn0yDixRPTjHmjlAUQfg+FHuBfQI3VvDApiY7n150VZvfff2L3WZM96CDWiT+OdK7xSc6Smle4kO6ScrBMN0LlWAsPNyd3WvWah2YwaolJN0tyv1ZGZya9/rR+CHhpmkaXluSMo18awICwi3q9KfSivIBJMPbBHVoGpqie0AjvhL68attB664ayB6QIxJvGmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL74Vsf2oZZ1Y7xWB+Ik6hgcaFq5tz8fBLDuSTQyVT8=;
 b=tII7KuW0kaWxBkbQM40oLlXss7mPt1sUDmV/MRzY7fMvAGah5JZbjy0L3p4k5/MtQ8r4stZwRBzhm1Wfa4nazIYrzqCCzCmLKKYDFMKGcLAsnGqxZBLLK0cZfRbwsKUhqXBqKdq2jsmitVOmz5Y+hdemovfqaT+Gljj3+OiXIzLVizhbzx7DaCE0h2VrJRuCq9FB2D27sJwlBekVJ7lW1MAEMRcK2OIJ1gM9v9MPE8upPSLp6WsYUMj15gSvn0EwHEqjC0bMfR0EK5tCSvGVxBYF7Rv0gnK37x3N1V6BBgWTOksz6T342kqYbXHpbJ9a5YblBMUo0ckk0ZdDXaSGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL74Vsf2oZZ1Y7xWB+Ik6hgcaFq5tz8fBLDuSTQyVT8=;
 b=Ryj073Y1s13qW9HYqi2o8qOwn6u0npZ5w5A2HeseKwzzf870krVrmN/dxqCZF14lP3Jg7EWBR8nDnMM2ap3YfiYaP6MLnEF1s71BXTru7HSm6ZdOtJqcZEJCy+c02K3C58AAFIGPuB5jz+82LWGXV5LCw9sVnUSJ5CP/WCmso5HOUZrbq6YsEgdMepxNwKqTxDFV3pBsn8qIRN1ZNrde9yu9NDdwZPzUADM5Y22iz4ZK7qApCNIiPAB8cMbiVtYx6WuKma+aLSPNat9AYjkZQjABCmrHWgjQpqpqP+V5hjutcT5u7kZpuqFaL63Xb/qaXOvMDM0P/Tr+jPAA5wUs8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 17:52:30 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 17:52:30 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH] torture: Forgive SMT-control failures in CPU-hotplug testing
Date: Thu, 12 Nov 2026 12:52:20 -0500
Message-ID: <20261112175220.767903-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:408:143::6) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 68679a83-5f69-42e6-2ab3-08df40e5b905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|18002099003|261009223027099003|3023799007|921020|11063799006|56012099006|10067099003|261102123227099003|261102130727099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	lvK3JEcpfnp1Tvlon3FX/Sxq3+oM+GyYvv86JrQmNSqOFB9MCA0rjODRQ8Qia0hrV5F9U5W8n1nYWXlwf2aE99+ub7kV87JUHeTIo6eCM2kvun3UVTpqt9CV3PZ/e8OY7wcE5iBWCfYNBVDUhIOdXohhCvVHeNJukqr25pNwbphOyOwao9PBmVXhL281EN0UnzIqBgOC/xnIxxmLdHdSl+cGsS+rL8OPEP7idc9BMV94NCNVkDGpXWioQo3EGvL+mzb6lOoU5sl+364frtawzSOcV8jCF/P75zfdpWgZozvqeTqOby0ULLnWpMnsLdAdJ8A11OHh5UZoLpJKzmxXds3sBQk9XLiw2NZBQPLfXFsKztpk4We47/HDNFB90bvEZKRn2ysT8nlLCtArxRCWS/0SAC5dB1ZsQ+4wj0G82RzNAx+SDc6Eo+NvhQzzkCufDKPmr5n9281/XeE5yG5blH0VjGurCEi86oQn8ZxKaca/8jbAAVv1twDOy6KEN4oB+BSlmK71+g9gAL/2zH+L5IqkIHV/iB7N5f2t9XiWUXXmK8jP2z930xyGy0C/+QIJ8g7buMX+T9iJuEMBAb1ndSM6x0QOV9r2drjYZ7n0uDC0cbqOhMi6vDcBHgVJck3G6BIMQHaDrpiUFqyAHZLumHbe0U48tkI5DbrgKK5vbmypPBVDA5+2BgaAsUXjl8le33dEXU8SzEV/CskEznO07Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(18002099003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xgk5v0WDeVcQS6uKmhFyD+ptGLsZv/QEnp0zoPAP2zsc/e6RnqOLP+lCTTbt?=
 =?us-ascii?Q?YRjYmFR3tmK5LR4VKbji3v45g7VdtP69PJ1oQU80UAnOoYXZO7D9YWD6Ufp7?=
 =?us-ascii?Q?6vGZUihP2VhiGg/wd//7TcOXIWUrhDJKqwNrCJrcwsnVN/wuvhCee70oSmYh?=
 =?us-ascii?Q?IKVSEHVK8vdXgUbE0ybGAONX8pNgkVyyNVZM0m9YTTjf5sYB7D+4Oig8gJFH?=
 =?us-ascii?Q?RywHdU27SvyTJMNyrFMh6/k+pvscbs9at3BegCj1N2pYEYABrkdoSQWbnZQl?=
 =?us-ascii?Q?yXL162tuZBcDS1PHr1jt46dDycSNucGdwsdvW4CqqXnsGXdbiBYCMPu2pSTr?=
 =?us-ascii?Q?SE6K3+p5JCOJZT6cQT+GHT8RFNce9acNs+v+T5tsiLjvX1Kr9F2bFu9ixQCD?=
 =?us-ascii?Q?u5f9sTqfRQFS4c7TZE6qBpdI348YnEaznJALpKAfeN1bBkWCHNA9jan/PDWh?=
 =?us-ascii?Q?mZIRlEIWn2u1NAK0EMFVf29toDEVZkUP8zwfuhWMhQ9glTNjsgzqrkGbLkHi?=
 =?us-ascii?Q?xza6mIoGyJPt8p1Tt2kJGyPkJRHXiMW80pyiktbpoRNJHPRH9yluHBuHOiwK?=
 =?us-ascii?Q?uPDQ3krOjzkH36y5UmnKqp3pJlEIJnCgdiid3jNwK4E/c6cioxaNKhOtkIVU?=
 =?us-ascii?Q?TAs/VicnLeUzxg6UghsAz9NmyK12VhKH+GZilTwfgbO36VQq4zzGxsTzmf3w?=
 =?us-ascii?Q?YgaXaBTYlloFCtj1x0WlGSvPOuqOk6OgYXfKl3uHGuEpR4PdNca5eUNv805j?=
 =?us-ascii?Q?N/wPc8bRyex1PGDX7IahPznl9dkzmLPuJm57Mvh8Ha5kpg8pou/M8cgfKkkK?=
 =?us-ascii?Q?DJWz+PBts7+jGNlnGiHevX6LAnJ78WeF7XC927HZyF0FqcfyHzrgV1SCwcwO?=
 =?us-ascii?Q?TKWsY1g0/wNgEpGUT8RSiFGEL4UmgNAUXyucZng98N1h8VRGkpvSo+A/Lq7x?=
 =?us-ascii?Q?akiRY7I3loIzYtwTJ1B3gLHDbeCS0BhaPjQ4YlNShmIMiWjlgxyH/YvsaHAt?=
 =?us-ascii?Q?dWRBDnoPV8iYiP5Z72MaY7fQcVehRUpsmZElLcEXwVPNyGu9Cl2cr16zYN3v?=
 =?us-ascii?Q?2n9D0rkd8Kbv2Yf+J334npE2IqKBO5ECVm6LPr5l6cOc+40/Fx0SRe/6giva?=
 =?us-ascii?Q?BBHLtI1bLFYozYxmad6GX01sqDIZevXqUsT7pOcrX5AMHjf9PoKFdpJl2SsJ?=
 =?us-ascii?Q?q4R1jaqsVQyEe4xOkwd6y97BwukVL5XU8adlo+E+GLySK5tkJJwkoMJJe7Aj?=
 =?us-ascii?Q?XdpLyGn8rYueZaosqqau72Ld2C4oCf0acQsIV2Vfq4yIUfYEQSr7xt/wPgj+?=
 =?us-ascii?Q?aei87t4j9N51ZMrOijrqXbYPV0MieVckYQlbuhs7hDXomNsnc7DJeRV/SQlB?=
 =?us-ascii?Q?NapgVbN41ToyTe4FEazWL2zXm39MsP0A67QG2eF6LGme39oB4+y6EOicL9l/?=
 =?us-ascii?Q?w4JHBLBtKPBuuwH1Tob7V+4ZkwA8cdXXeiYL4tL5OvLXUN2Q6QwFvnHY6jvW?=
 =?us-ascii?Q?SlvvRM5AEptgoFVJlL5D/RyJwiiXiozmXqgoJt1XG+4h+IJXof8RFoL9BBK+?=
 =?us-ascii?Q?H1QkaGlcIw67Aha9GehKB7gJtkZOFV9uN0++dExPbhV6nnEWR3m1ShRNqRfY?=
 =?us-ascii?Q?skIN/pD7mDQE73ZyzjD7CsFfwg0a+dm9aG4gMq16T1PRHFzUFlq3dAW8BNhP?=
 =?us-ascii?Q?ArXdESLJ8ySS0atgQnvYzKYV4SuJaKVR+5TdF6ODv+0EYrwB6tPJKsSdMcQu?=
 =?us-ascii?Q?ALFqYSnuPw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68679a83-5f69-42e6-2ab3-08df40e5b905
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:52:30.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KazxScXai6Febq4J67cah4D8Aga+9qRl27a+DkTfv9q2gXxownQs/465sbig15PquPvZewlE3sxrli7m1mHtHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049

The onoff task ends rcutorture with "End of test: RCU_HOTPLUG" if any
CPU-hotplug attempt fails, other than -EBUSY during boot.  Toggling
/sys/devices/system/cpu/smt/control while onoff runs causes two failures
that are not the test's fault.  cpu_up() returns -EPERM for an SMT thread
that SMT control keeps offline, and device_online() and device_offline()
return 1 when the toggle already did the operation.

Repro: in a 16-vCPU guest (8 cores, 2 threads), run
"modprobe rcutorture onoff_interval=1 gp_exp=0" while looping
"echo off/on > smt/control" for 120 seconds.  This ended in RCU_HOTPLUG,
with no reader errors.  With this change it ends in SUCCESS.

Forgive these like boot-time -EBUSY, by not counting the attempt.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/torture.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 8c4e6b2fe8ba..b860c99e9ca7 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -194,6 +194,24 @@ int torture_num_online_cpus(void)
 }
 EXPORT_SYMBOL_GPL(torture_num_online_cpus);
 
+/*
+ * If the CPU-hotplug failure is not the torture test's fault, return a
+ * string saying why it is forgiven.  Otherwise, return NULL.
+ */
+static const char *torture_onoff_forgive(int ret)
+{
+	// PCI probe frequently disables hotplug during boot.
+	if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY)
+		return " (-EBUSY forgiven during boot)";
+	// Hotplug is forbidden, for example by SMT control.
+	if (ret == -EPERM)
+		return " (-EPERM forgiven, hotplug forbidden)";
+	// Something else, such as SMT control, already did the operation.
+	if (ret == 1)
+		return " (already in requested state, forgiven)";
+	return NULL;
+}
+
 /*
  * Attempt to take a CPU offline.  Return false if the CPU is already
  * offline or if it is not subject to CPU-hotplug operations.  The
@@ -204,7 +222,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 {
 	unsigned long delta;
 	int ret;
-	char *s;
+	const char *s;
 	unsigned long starttime;
 
 	if (!cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
@@ -220,12 +238,11 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 	(*n_offl_attempts)++;
 	ret = remove_cpu(cpu);
 	if (ret) {
-		s = "";
-		if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY) {
-			// PCI probe frequently disables hotplug during boot.
+		s = torture_onoff_forgive(ret);
+		if (s)
 			(*n_offl_attempts)--;
-			s = " (-EBUSY forgiven during boot)";
-		}
+		else
+			s = "";
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
 				 "torture_onoff task: offline %d failed%s: errno %d\n",
@@ -266,7 +283,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 {
 	unsigned long delta;
 	int ret;
-	char *s;
+	const char *s;
 	unsigned long starttime;
 
 	if (cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
@@ -280,12 +297,11 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 	(*n_onl_attempts)++;
 	ret = add_cpu(cpu);
 	if (ret) {
-		s = "";
-		if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY) {
-			// PCI probe frequently disables hotplug during boot.
+		s = torture_onoff_forgive(ret);
+		if (s)
 			(*n_onl_attempts)--;
-			s = " (-EBUSY forgiven during boot)";
-		}
+		else
+			s = "";
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
 				 "torture_onoff task: online %d failed%s: errno %d\n",
-- 
2.54.0


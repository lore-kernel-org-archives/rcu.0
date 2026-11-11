Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433116;
	b=UHlrRrOWz5GjaTK7mPvpAIkc86xjir4dh3nMFESmjYXSsydePlA1R53EGNg0LLKSjxe7
	 d41qBxJeEcoeQ2RvwruO/gBV6Fto8jMJUbA/PShxH2co9AhL4r4QMNkpkaEs2uMCYzmBz
	 o97fcLazqnNXLVZlURCwDOK/CMU6Cg8xPti+Bd7u3/Y5UZmDgyOcYAEH8ShhZLq9KCJq6
	 coGIvTX7Lkfv+bYbAhb/Yyu8YEhQwcesKhfAXUSw2QoICJb2fq8FqlhupR1GqrYONQ8hd
	 9SwnN5ADvAG45YPyvm7mWaP2hsWL+WHybnNKEz3YZD3SymhhLrRXr+6L7H0YD45ZApA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433116;
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
	bh=GNoiHUuefLnkOvbXxe/MuJNO36lFGgjAPq0UCW4zDbM=;
	b=3vmzW+wF2aQbLjkIZGGirVbUkgD6RbENfYpaSv08sUBXj8viZERJ6K8Q6UAxgjiyNLid
	 I7VUgDl0X8S8ndW/9evKPi5fSfXFFithG74pqlncDj6XfMAolQRW48g7krEJnTVNtypbS
	 ZpeP38vRN+ddvAlNLvo4N76n0isnmcJOWu2ID7DVykVAvXGLnx0YCRHf+x6djeHo4a6fR
	 VEHwBVhdcI6FNH99sN1w0IzqwwWkdJblv5Qz7dAQisdW5G6NS53eVD7Vzl473qJ2kjVkZ
	 3mTk+LIc6WUHRdwgzbf/mEjAZM3nbPDuhjX8xb2FAwoHSKoDWzHjSDQuBqoQqRs0gUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DA+AWE+L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.1
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF61606A31C;
	Wed, 11 Nov 2026 21:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF61606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DA+AWE+L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQcDkAEqQwAiWlakDAFLk0fxplcCrIUIN3rT5j8O3QQI+puZb4g4sK9/8MmuiSAEFiV1P4H/GIfo1K2AQAskaHWJ9Uvr3HNRvRMJFpIGqdgbVva8DBSXRkomEc4FjowjQQMqiAc9MeCBnpbutjhzS3wBk3KX9Lg9ZxGcet/LHSm0rhdj5HMAUqtno55hdFFCY462TkWKjbR9ilDr6zh3EOdEI3oNRZ+za45fc0fdfAQrg1PTBEAuNTgmgTh8LhUS7iKuziYSFt/aAEfvGZQKzncJKi3yUQLK0cHONVkg7gyaOt1qBoHRXDhcdWxbql1KVgzmOixKv8QTivGfZKyQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNoiHUuefLnkOvbXxe/MuJNO36lFGgjAPq0UCW4zDbM=;
 b=ONpEl3bxobpfM6KdT+tX/OJVfArUHDvdws7iuC8bWnsFr06S/MrzIJL16/vgfytZ4UZ+Lluf6E43qQrcN9Fn0S7kEP2+KUnH1iS4HBqY4DwJ5HyXQWWwpw9eC0iUAP9GZQJNy82KZVLpthuQ00E+RAOHXtj0KbyuXbqEhs5X6fj8B4NfummyPBoNHzRmh+kP45OpXG7DgaIHoEZlmtEcst8V+2Ch6OGSw5aMjOsOFhwxMuX4Mp0iWETbld1N4b8gcPd6cudc4Ymyxe9d/kozrVp6DiF1a/yHuspgL1LWkmepM3seSVLTfC6wSGB4uiK3LDmLngpL8fkKv0zF2BZIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNoiHUuefLnkOvbXxe/MuJNO36lFGgjAPq0UCW4zDbM=;
 b=DA+AWE+LS2hd7jyeX0JB4jOMFsWrlSEOdKgdKkDSUwmqKLyj7AB1nxsN8uXyGoXaoR4pqrO59aIczXXcWO1c/4xt7bMLK7LP20R0mk0ng7uDgR3dhWzJRChADHIy3SvdQHufFxB8+YZ1f/5bs5tCuAL1AfBfQD7vS6ynEn48ejtZxlxbo4CgiEHMs1upl74pRVTX8+xuuEf6QmCY8dFoXNy5b3KtL6TKaDatohrVULg7rSDRJicrarLXWWKwYrup+xau0t+QHtL8nhXl6JemkRIfc7edlNnSVLweWNwchj0yjedbodH5QWmzx+7v7abc9jtzz8b0Y7vcES7bwUC8IQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 21:38:31 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 21:38:30 +0000
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
Subject: [PATCH RFC 0/7] rcutorture: Rewrite RCU priority-boost test around a CPU-hungry reader
Date: Wed, 11 Nov 2026 16:38:18 -0500
Message-ID: <20261111213826.2035045-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::29) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efd2363-028a-47e9-4380-08df403c20e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|261026140227099003|261022105027099003|10067099003|11063799006|261021123027099003|261022075727099003|56012099006|261026121527099003|261009223027099003|261021121427099003|261028144727099003|261102123227099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	igUt86cG0MvQ3uO7aQmI0fEUHJHvjgIbOO2U7xe5n19pbWHQ89orHko14NSefSyeMdzWsoNSP4S+Qy3rBSDcMkKKPvOwhV/4BKSR2qzIpKiX7Kh1rQ0loSy2DyAOk6o5twGo+e1ULcMVpO9GIJKdcKyQLkHjVkEK/xMZkDbmywLuuvUb3AYpMpCV5x6XdvbaIV/cwGgKhBnagx2tQ7vEHJSuqfUCqqxMrz1A0Pui2DWfPkyALVvqsADmMUNZMLZFi5CjBfE0f39RwVb9vSvt3QmjbJdt3sCyQtnCtbnJ6J+5cvEqe+PKfrPPCi+JTYX/0k9bmWA5OJDkv+9+eAKWIa3VQNcIXu74JNTaXU0/AwZ0ntj3H/gHkrbwMJ0wFB0hlt0bKSnvxNCqT1FxKibOKMx8N3DSDnh09O0bcqzK8dlaQkIJOhsvCkX+VDp/vcPSOK5KqwMXJ0CD4S4pJCqpA86DpLa3GoJfjslQWVOjELt38XUkziB/jVUoT8Jc8Fq8OP3MtwjMvoZzAaZPpLC2XSQj8uBojC5oB4Sm7OjT5Wo0owekgib6kKMi2w7ayiT5RN1jBuJ0BMqsEm1Ao+cVsf9NYdE2HfIx79+qVV4JkLnvfnU1xyBK3HSbi5hli0Emso5F96d07O9tCN1SlWV7+o/yT2NOqXGmPlPSc5eAcEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261026140227099003)(261022105027099003)(10067099003)(11063799006)(261021123027099003)(261022075727099003)(56012099006)(261026121527099003)(261009223027099003)(261021121427099003)(261028144727099003)(261102123227099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQboaStw2mhWLqETNKTbKIfzayA1ZtO9Fe5dFjOdJEyQAzSPMpvX1+6o2/hc?=
 =?us-ascii?Q?CwTAi/utHbEcfk0sl33ZIV5Fe0qEFI3upiIvT7YeK2AXaGB0dLCSs9WbGYWF?=
 =?us-ascii?Q?DhLBJB/UiUP96fqSOeegB3FLDmQjIvgPEp2DYyim0s4lTmtlWIV8levf3AN0?=
 =?us-ascii?Q?zfDN8FwOpHpHGvOU/OgcyGojNmqLCir01H5AUdiMnFOEoi4zDilgSZUD0EcG?=
 =?us-ascii?Q?3jzEyWfHWLbD8dQivmDKJ+DIasU2AjofMZwQUkluCa+QiJ06Flx8nHMpxQMZ?=
 =?us-ascii?Q?DWHHgpr6S6ZhChwBkKwHNXhWBzxAEgJ+YVOf4f6sykdMuCQnCBusTTHdQ2H0?=
 =?us-ascii?Q?cOnzzHQsWVgpnabaFm1rbIio68PYtYweBumStGVF0g63Hx+20XC1dkNHYF1Y?=
 =?us-ascii?Q?BsHx0p9frkRMMtPpFAGEL5r0ecONcIgmuCd7tzB9mPqmMkYcVjrvNQ+pFIKr?=
 =?us-ascii?Q?C4ihpcbAlbM3AN8EZkQUcE3OuPf2QNmIzLvDOOsm6S4RwyLOfUdMdmU3ICoH?=
 =?us-ascii?Q?RwRqwV3Boa57DXobfssV3P9wJFBCq7gUnpeRN1xDHZMeW60GAmoPsq6lOqUc?=
 =?us-ascii?Q?HCc+/jypKGiDn5gnR3e82eO/ZXKdoH8zQaT8FpA5T179hhN36sgcd8uuZjKl?=
 =?us-ascii?Q?v6xkyWB2VN4+eG5+YvAKbVCQJBUKcK2MBZo8VWEwAabu+HhCIpjxbfb7FZSB?=
 =?us-ascii?Q?TRxj3HdJZ2QDovJvUesMHBYaE3ZxNGODfy57y13NKl7lrdXaudJka77ca6uu?=
 =?us-ascii?Q?WVOOl2ByuqdpfsJxnYok25JgwFY0uzynY2Hgkf3jIw0iaYcnBSSCAwDbw98T?=
 =?us-ascii?Q?pnTf4+EZlFIJxIBoHy9UYwKqjNoVQ5+xMtatltSu3ga3xBssXsk8kKJ2BFdl?=
 =?us-ascii?Q?jLUHgWA/3MjsAVl4MeUdIIJ5TprdeBwtQV5tw9wyTixoQqXIfaVnFYYEc/JJ?=
 =?us-ascii?Q?I8dT1mo+qlc28sE4iTWCG3BlZiPJCTunC/ZLYuze6X21a5LxPK/BS6hAJWE+?=
 =?us-ascii?Q?zThwciMybG7AXYcG3NVxPwQzF0rEUsepfl72MQOxUtR7TDl3Mb4DiJOHugqD?=
 =?us-ascii?Q?SxIjqKI5uv8vAk2yiNrdVVnGstcfkV8q1GIuBfRN0i7dCM0Zs2N8EJGxoTlR?=
 =?us-ascii?Q?biKXPwRCwLPPIChNOg9HALkgce6wNsSWf7ae0UGj9bcneAFWw+bdL0LOR6OR?=
 =?us-ascii?Q?rx1frFaPqWjWAj82S42MNaBrrLYJuP+L65G0ywR8eE6bHuhMkA9+vnNtIf4G?=
 =?us-ascii?Q?W7M+bG/nlfG7+yP3XlHW2mJ4pmYxxRDHX9r9dKxKNJy+CglCOOs8RECA5440?=
 =?us-ascii?Q?snNDpnHn4YYXmUfKdZPqq0s1rwlFSeDpbqZFW6TaXUAQf8KMdpQQYa2ezsDe?=
 =?us-ascii?Q?lfwpoSI8Rw6Tw7cCvHw+y7qQU/fb85N/69VeSuSGHCBKQy0icWyDItcckQku?=
 =?us-ascii?Q?eZOtRnC25T1ggDZFBhfznYpBo+RBndA+SAb/hDkF0myhaMPuWT8LY739e48P?=
 =?us-ascii?Q?jeSwYZMQzDXsS/Ifq4e+XxStqwSGVH5gpZUgjNyJGKRKa3OF5J4MONX/WNtm?=
 =?us-ascii?Q?rUzqv4/fa4hNiw8eXGbEnyLKJTlSAWHkrtN5VcKhQVo09ZOqJSd3QjI6xnam?=
 =?us-ascii?Q?TBkzaRAeGRfIBLU2iIDhpPx9VYx1NrHC/TznIfsQV0P8C5ACYfbWn2wzkX9U?=
 =?us-ascii?Q?SEktEHvjkL0bwLQKYLLuIWuFjIUv4Y1/Lay3UKlziQCj4fndHooqTX8K3Es3?=
 =?us-ascii?Q?6jTFOYSEuQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efd2363-028a-47e9-4380-08df403c20e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 21:38:30.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFSEnWayw7OmOQuMVAMm64aqMqtPNGuw/OfqPxoH7B11mv3dgXoiG51hibHlHoxOPUaxb680ZOShIV3arD58eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405

Hi,

This RFC rewrites rcutorture's RCU priority-boost test so that it no longer
depends on disabling RT throttling and no longer infers boost failure from a
grace period merely taking too long, which is fragile.

The idea: make the to-be-boosted reader need a *lot* of CPU time, more than
throttling could ever give it within the test window.  Each test interval,
one CPU runs a SCHED_NORMAL reader that sits in an RCU read-side critical
section and spins until it has consumed test_boost_reader_ms of CPU time
(default 2000 ms), measured with the task's sum_exec_runtime so time spent
preempted does not count.  A SCHED_FIFO hog on the same CPU tries to starve
it, and a grace period is started so the reader blocks it.  An unboosted
reader only gets what the throttling leaves it, about 5% of the CPU
(~200 ms over the 4 s test_boost_duration), so it cannot finish.  If it does
finish in time, boosting worked.  If not, it is counted as a boost failure.

Related work: Sebastian's recent series on the DL fair_server taking over RT
throttling [1], with its RFC [2], also touches rcutorture's handling of RT
throttling. This patch should simplify or make those patches unnecessary.

Testing, all with kvm.sh on an x86 host, --duration 10 and
--bootargs "rcutorture.test_boost=2" (which forces the test on in scenarios
whose .boot file disables it), 10 minutes per scenario:

  Scenario      Result    Boost failures / intervals
  TREE01        SUCCESS   0 / 70
  TREE02        SUCCESS   0 / 73
  TREE03        SUCCESS   0 / 71
  TREE08        SUCCESS   0 / 74
  TREE09        SUCCESS   0 / 59
  BUSTED-BOOST  FAILURE   82 / 84   (expected, boosting disabled)

BUSTED-BOOST boots with rcutree.boost_disable=1 (patches 5-7), so its failures
show that the test catches broken boosting.  Each failure reports e.g. "Boost
inversion: reader got only 203 of 2000 ms CPU in 4003 jiffies", the CPU time
throttling leaves an unboosted task.

The series applies on top of the rcu/next tree.

[1] https://lore.kernel.org/all/20261110-sched_dl-v2-0-cc9399f7aeb1@linutronix.de/
[2] https://lore.kernel.org/all/20261023161348.t3lpPLQZ@linutronix.de/

Joel Fernandes (7):
  rcutorture: Rewrite RCU priority-boost test around a CPU-hungry reader
  rcutorture: Stop disabling RT throttling for boost testing
  rcutorture: Remove unused check_boost_failed hook
  doc: Document rcutorture.test_boost_reader_ms
  rcu: Add rcutree.boost_disable to disable priority boosting at runtime
  doc: Document rcutree.boost_disable
  rcutorture: Make BUSTED-BOOST disable RCU priority boosting

 .../admin-guide/kernel-parameters.txt         |  14 ++
 kernel/rcu/rcutorture.c                       | 192 +++++++++---------
 kernel/rcu/tree_plugin.h                      |   5 +-
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot  |   1 +
 4 files changed, 116 insertions(+), 96 deletions(-)


base-commit: 44646ae309330530a23e1e4c44fd47d274cfd0ea
-- 
2.54.0


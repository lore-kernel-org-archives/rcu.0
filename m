Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433123;
	b=gHh170y2sgZgXHrpwRgaUH/BkJFhuWMYMU3flccL00h5xmhst8RO8Q63qohnD4URt882
	 Eb0OHcoG5epVB41M+DKgQbY0wg9nLu3O47d43kN7NvJhkrcqWFvLHzikEodDDZpj6wkS+
	 noQCEjsUbz9/lo9/mpnx7jvAk7/9A+0HqAKwEWFY14RU12TG+YJfrV8CGlzzFFXFKLZFH
	 90K9frsY8ZXx1AuroQ2u8U71O/sQRLHOZhyZoyY1OPzccvly26OZ3Cg3/zUJC1nDHZc+J
	 3Eui529YX37MtDTppBRappoG2Fx/bMX40sT1XbUlfGAaYBg0MJ6cAQKDJiypaC95AAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433123;
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
	bh=mcCOi51e4UqC+GpLRKbsh2QAtwM4muVWWO3fHTKlV4o=;
	b=rYvtEjpQdwNEOoxi7mrjgycutVC7NiSTUdfkBBGfIV3xEFGBNlMmUhDhS49jaRNhQ7rh
	 Maxjr8Rpk1wd0M1a9lZftu+M9MMePi2dsy5xLu52wCoazTqcMbqIwRKKrdJR1SQteBp6v
	 1OBW2kyZqrIvNHtB6n8vz4VJkJSXom17i4fOAtBuGBQsAPyc98kjsR8nwKUUVCg5VMiF7
	 RQ99+ZnN9qoZA4kYIXPccjPRxEBNMvJ1opYzpeW7R5CsIrTVemBJZYG0KIqFhu6rcZDQD
	 10B+v86lz9tQfyTROYQNV0vHQ1RlPneisTv41Z9Ap+sYq92VX9669Ryybous9/tcBnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fWOjn466;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.71
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B95606A31C;
	Wed, 11 Nov 2026 21:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4B95606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fWOjn466
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/nQlt3UaOjAeBRXNsJGqd9wNgnu/E3hpvk3ISWsnK0U9vk3Lj7VrESsDBUi9U5uOiPNqRj0Mt78T5KzUYt/tLQEcOOpFsPFdljGICpEQs9BRQsa22U++YsTsnhMLTkpmJJ1X/ZXyOXNnl6V5SAkrPpJAmgdvbnrkfLrsA4UByttWiOR69hbKRIgpvgSFmyjO3gOgESP0u+ENYbaqHdqOKfwzs0M6BIT1DYiCPFmitKbqB6cxMVGQzSF08eV24ryDWUAYXQCgzJ5kgljxsOT4aECS/2Blnbfzpc5btQ0N4HUWKrkj27G8VDQs5T1JWXoZFVEXxHpM6SklDPzlHoBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcCOi51e4UqC+GpLRKbsh2QAtwM4muVWWO3fHTKlV4o=;
 b=V3uLtaILCcfO5NPT0EQtE3bYWxEdWVCqAVs/maMennyN7hGS4TA61tqW6aqN4J+jq6MvoeBg/Xsyv/mAnbCtnDjRHWC9KnctV1k49+8Ag45kY3ifPcBjNCC1NxkfZYaujirX6FDXh4Q8HwPrfDcI1gY0ob6RODhOe2Szlh/JS0on+FJYNFPxJ2csM/5PYdz5aXIYcqqjV8nz8iqOZr24/o7+t1a9Z9R6DiT+uKDrJUtJwqIVK55p/wEdbroAw3E9rLT4u5vIfUSGd2QxCPTgP6j923mK5NeS7irL/NtIpYtEEK/v3NzYOyxo2k/r+ya4LbW9rLRwfl8T+L0RQDf91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcCOi51e4UqC+GpLRKbsh2QAtwM4muVWWO3fHTKlV4o=;
 b=fWOjn466eToliSCXQbBeXbRwb5bGRmBCnk2EncDqRqNQ4YLav5SnAimO3UHEITOXB69DSWmXZFVMvKom4O5bmiMO0eej1YZoLs4si9VcvfFRW+0/YdcHmU/hvF2Tdkn29tVx/5CV8fRiotbbkQFgqpFCdc5jpcMRZ5vZJoKLOUpk82CHNeeA7J8XpKmGkIVz3H16DHPew0l3AQyg2FmjpSRMZ4vqYhA9MNR1k1ym4xng47Khvxfqz/V3DnZ9svBUkDsCphTbPOAR3jdFutZBRsP+yvdnVZZzDLhCf1qQ9iIegrejIvntiROQf1MWgjOdn34JinZ+FssM1lrWlwWDcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 21:38:38 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 21:38:37 +0000
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
Subject: [PATCH RFC 3/7] rcutorture: Remove unused check_boost_failed hook
Date: Wed, 11 Nov 2026 16:38:21 -0500
Message-ID: <20261111213826.2035045-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111213826.2035045-1-joelagnelf@nvidia.com>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:208:32d::30) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: e49c6c18-1f21-43b1-a885-08df403c2544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|261022075727099003|261026140227099003|261028144727099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZpjBxnQtwMWN6XK9pgyMQIQtYR/vu1GFdJHBWTzGp9Nysmd578nP2F3d0X+Kj5c+ZomWDdl5YwlCsEL/BRdHZprOTYilbm1sQQDLukOvP6ZCUbxx/rTnxIF05D8S9VNehws1gVwxD+O9hv512TnYoKPYy3ASfKaY+DRxBevYgYnOWaujzAnCijvRTKuhM/3voZ6d8kNYxnc1cEXWxN5Nahz3ab6ISVf228K8QaO5KxPTSaU+yefUPlUJLZBSloHVY9Yo5QreL2kH6/FWDopFFToCny24qbu0xzM/yfrlI5/friXuMsU8uUhIa080Wj2Fx60TBlxJ6SpOuGmYadP4IeglRIwet74CCB0payGRd9qFqKqmuAIjmmUy0J1kiggb8A63ooR8ArLZWSPKbX0nfdGPS7OXDIHvT0pKYb/v5j89lvqMYzxi61JMJNvSanOy8KcIi0JdxEr1mVjFp3Fq9YLLBTdEFAg6owyLOEC9XaphmlnL1vIiagEmpf5dezwK6Yr3NCZSGse3uQmoomrXGqtfBvCWgd7x7qJA+fr/SQPiDvmxTF/sCeKqMzqxImGbfuuqsVdPfKxjtJIehASOAzpblGgNTL7rhwHR9yYTaU7BVmJivH47a84XOauKMkj83rjYe9hX7uRRRW3HYIj5kFxgV5BA4OONyM+6+hOMFug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(261022075727099003)(261026140227099003)(261028144727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wLd3K5h5EMBSKz/40qxdvQKZCjetzqejTXnYUfLKJgkr374wBEtggpARrq+8?=
 =?us-ascii?Q?uSv4SfHu+f0DH356YeQqjHc2WupeAwQivynJXrG/a1pYJfSQO5fGE+cXqrol?=
 =?us-ascii?Q?C3GybC4FBFcQ2UV3ohOTcAxx6QAvguc6LvbG7ac4a1R9MYMmAmCSFVJWLRHG?=
 =?us-ascii?Q?Gr4a1QvgvwvXgz6qmxKnk196AUVjigK8mxUUhZ1aeGQXrAsCnzYqkhA6/9tY?=
 =?us-ascii?Q?J6AnOVzTkH5UJJiZrEct5y9wxzKl+ojTNBDKACK19ALJC5T1bbU/sAcc02sP?=
 =?us-ascii?Q?xdjSrWZKu337ZuZzSROmtfxhYXph+DAczNjfP7Zz2L7ZBD3v8MAKxP6d2jje?=
 =?us-ascii?Q?fSBdkCZkTqMbLbAy2ER8ViAenlqma/qz9/y48fYOD6rRf8XOMk6yp0CyRzP4?=
 =?us-ascii?Q?ukBRKw9LfgWbvXQaOZRRCV3MUGVFY/d+wWNxrNrmukYVmwYx6BaHbxWVV431?=
 =?us-ascii?Q?/mn7gALRnn6t4fv1jwhcbXWdnTJmAe2t4PsxkeXPuERQV58iMIU+2N3KBQxO?=
 =?us-ascii?Q?BFApP/xsQzLys8tWNNpR+6V5FcamsVmWqx7U4bRYbG6fXaCjvYIDtS1PEjVt?=
 =?us-ascii?Q?s7KlVY3v11G12Y/p7pZ8InFQA25ekFwY15wq0430flqjvh6yDfyCyUlLB2i5?=
 =?us-ascii?Q?cQnM17jv2orRNbAij6+vp5rOv85kTzXVceQdI2POAhXPChKwJUtrbeBp1icC?=
 =?us-ascii?Q?5YXgmBmek18QfKtfVg49Xs135FdN338wLGZOxX57/x2cgGTlNzHLzHsrpLa6?=
 =?us-ascii?Q?Z19TEy6GYa75qJJgzK3G4vrdtZ1eZwhnstQt7WqicUHGJAG8Hnohx76hJ16E?=
 =?us-ascii?Q?Z/mZm2fBO+ppUZTLApX10RoKxvQ8gGwupLEWCvYD58uyW4AsnQcYYB2nizZ4?=
 =?us-ascii?Q?xZkfyUNBGB10BdevaKNYVQnw8TE03C7+TYRuLrwV4ZZCeDjKmBhY309iUPHj?=
 =?us-ascii?Q?wlqMhx1+fU0pjWJcIYC0/nZmxBuAgDcVJS1EwMAxOJXSlQC4qWH8084zyXIS?=
 =?us-ascii?Q?cM2nvmjstpQsUBV/Bnbnz1LT8ohungw5GmaL7pyY+g/FHkiYAu0SmmLNAHpc?=
 =?us-ascii?Q?+A9g+W4/1D4mUyVOPkPcOJsmsBcWeoqoaDX2aQcO2bs2Hqch5XU/qi6WpLKq?=
 =?us-ascii?Q?0E8pmkq8m9hPms/N4/BydC01uNuTyFLWHSVB2doo1iyRSjct4GjbwHwXCTPH?=
 =?us-ascii?Q?Dmoist5N+wgOocLSVMLrW3rU8qjEVfpMYCl3dQjW8kT2RRMBQ6xZzat1//gX?=
 =?us-ascii?Q?vn/mUtn9yph5+kBYNCpzKZMhC+5MMElfxTBsr4k2PPwW49UbaiaWMQlsL1or?=
 =?us-ascii?Q?iTbsDe08g8sj8mjjuv8GcdkBq24MZRdZa+dVp3vkHk0ITGI80jhVe21VFXA4?=
 =?us-ascii?Q?HubRP8Q9r/tAa0Iwf8JGe6V4FVxrRqLixCAksZyfv0cnbz4jLpOiECWnMgOq?=
 =?us-ascii?Q?VM6PXQjb7svcZ3Dp0JZr7VcuON06p0cB0nMTK4VuXOKs7ld9xeIcWf+EIXyn?=
 =?us-ascii?Q?Yv2QW/pvPh/JPQLbpW+w01uELC+Gviuc3rJur0ks4k4Q0WseuYW2DunGT7ry?=
 =?us-ascii?Q?diwmx+dHmrf/h+zO0JPc3SuLA2choAqz7+WHpUyXcQaRd1fQNfv+zsy2Pgp2?=
 =?us-ascii?Q?f2yfYN66p3lZz31GB/XsYYteZhfEEPe0/qG7pjiy9D4AqE3sFWZmG48Ne+Vo?=
 =?us-ascii?Q?QT8ly5sNwxmtqXFLJDzEjn322038I6ZiFmwbc354fNjzAyrzWlqq8UA/Pdtj?=
 =?us-ascii?Q?Z5pmeYZ5qw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49c6c18-1f21-43b1-a885-08df403c2544
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 21:38:37.9172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HY65ZrzKLhMXsgQwhSCWj+4M4s/Y1CLyWY7MqVzxLc54ZemIW157vHlAxToaX7tkYw8VNIvzt1PpTjIh+HJuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854

Nothing in rcutorture calls ->check_boost_failed() now that boost
failure is decided by whether the reader finished, so drop the hook
from struct rcu_torture_ops and its initializer.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ad980e9257dd..b13b25b686f7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -43,6 +43,7 @@
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/sysctl.h>
 #include <linux/oom.h>
 #include <linux/tick.h>
 #include <linux/rcupdate_trace.h>
@@ -425,7 +426,6 @@ struct rcu_torture_ops {
 	void (*fqs)(void);
 	void (*stats)(void);
 	void (*gp_kthread_dbg)(void);
-	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
 	int (*stall_dur)(void);
 	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
 	void (*gp_slow_register)(atomic_t *rgssp);
@@ -637,7 +637,6 @@ static struct rcu_torture_ops rcu_ops = {
 	.cb_barrier		= rcu_barrier,
 	.fqs			= rcu_force_quiescent_state,
 	.gp_kthread_dbg		= show_rcu_gp_kthreads,
-	.check_boost_failed	= rcu_check_boost_fail,
 	.stall_dur		= rcu_jiffies_till_stall_check,
 	.get_gp_data		= rcutorture_get_gp_data,
 	.gp_slow_register	= rcu_gp_slow_register,
-- 
2.54.0


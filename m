Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6B186E58;
	Tue, 23 Dec 2025 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461631; cv=fail; b=hIYGAKKihkZrTzGOfGp9lmCyTeeW7F/ki9pL9bh+LLAVAHBWbM5RyGBo8gGQtmCqgfVYbzmAHDLsIfo8J0PWnF9nN0nTWwXAndny/rTQdE6Q5ewKxhhbLXam6VK7W7sPuiVPPMMpTkwW6zrs5BGzU/MbH7x+giHzc3HRmjEa2MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461631; c=relaxed/simple;
	bh=tTgs9UQQrhiQaXGkeCcWoosOhMVzq7Txw/mCChs/BJk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CiCKwOL5RxnNyjbpmYNDhE7Z9paLz1/JpGviXDKB8FAtG46vExdknc7o22ocUp+stO2vvFGiCmqNC0EaEhXAAxrr2byX1NPcxfoz6kdZ6MF0kG5i+7MXRuLcWExvKcAnnHWpUo4/hK5bMKsVSoCi6RjD/1XZ7Vjkho3J/ssWExg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QiEGGCcx; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QiEGGCcx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbziAC4aQy3KNIkF4PLBm0/4k8QMLJdGh8Df80irOZ3H7Fj5/TqUwL2kNMxU3ABFgxAvZut7vtIMH7EZFgy7LznBXynP11wwyVnLFmJ8kFIk2JFV1DYtvFibQNKVi7bbjAEdB3HV2xvnoMHOA6AKMytH+ifHsGtywzwz0ENRE2IlIBnq9G9sdav9fzIcssf/4bW4sOVqgOqXekiT5MjVZvr5kH4cMKg81dXJksR6k0HBurBYv3abVwTbvCxzMmoQnBUYq+SPzCpeILSED4j+U0w2Vr6ElNIhz+KnFOCAwbR8zEUUbbObxLVqNQzZyZF9O5iBnyKXOszKLnhfH/SGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvZxeAfwaumEYrElHPj9MIInSq9W8mnybPr9glXNNwA=;
 b=b2bcQMSEPOQjs+sg9+pt1tJwp9QBZKQDZ4JfaFy2F78JOjlxdAHfmK34VkvJg37gLkk1h/9ig4IX+yhWd1QUHWj93ivGLHQsRNAkiwnKVb2RFCL93As8pfazemHIQ4dWd+PyVFT95BXww1uC0FKaDVcTHQSD38Ah+8Zip9sv1kR9EyeRrjIyEAxLPSB2LALv0fAqxMNPjIpVYPcSeW92GOF6tO0kt+dkxZGYs9fgxFrOz5daAUB31CuGtrksknrf52bM6bG9KKtmu/lATAUGC9JBYJB0GHmB4d/aOBjrsVvoo8fKBzqV1NkvbkOzAzMczs5oEZ8RFgIqidLkTitH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvZxeAfwaumEYrElHPj9MIInSq9W8mnybPr9glXNNwA=;
 b=QiEGGCcxqzwOj8YlhmVabIriEVkkvYr1mi5wWe1w1cgmTAGscdIKbplrbFdI1++hDpPaA2PpcVgYUH5sxveH8ru8dn8KJFnF3cNMzVVoW3idURGu/AfS2oMe1DliV6U595HXf3lBoABzEQq02RixzYLV/6OUR+NTVHX302r5/haJ5A82fbaCjXV4IUzaP8ufQ+DvJnBW237gpGY6M5Hsqza2IhpyGwZgDJEOgemsrxxJWFvP48SAewOcjiaTaorLDCzEU4jvcYsSd2YULSQe1Wm0vl555lw859d9DDz78St7Re1urRHuNpCyuLUxqndxoqW0CZccy2WjdUlUTdyBaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BN7PPFABD533732.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 03:47:07 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 03:47:07 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH v2] rcu: Reduce synchronize_rcu() latency by reporting GP kthread's CPU QS early
Date: Mon, 22 Dec 2025 22:46:29 -0500
Message-Id: <20251223034630.1092719-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:208:32f::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BN7PPFABD533732:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd3ddaa-82dc-4f00-b25e-08de41d5f18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cpzV4r5QBqwHtN3auHUN+RiqV5mYBiOavTvVCHNmCsy1MJWhzs2TR3g5Z0G+?=
 =?us-ascii?Q?Y1Dmyb9CB6dszSwY37R80EsvUqOV5aIJ8kRdXOG8OfqlupLAqHFWHgndrGu3?=
 =?us-ascii?Q?LkGgVxJkcO4pBJ5ShAzIcCBi+c+5zrk6+G9/f6ISDZsAN1tHv7qx/EtaXETs?=
 =?us-ascii?Q?OMwRKx0CN1Bl4nKtyonbOP3ktCr7YaIfo2+o/soVBgnJ+6Uzo/P20mFxHz4X?=
 =?us-ascii?Q?MyhO63BD9hI4zekX89tx3CaCldo9UXKHW2ArREsg81Dh0AE7qtKGUxSDyoC9?=
 =?us-ascii?Q?05DG5FB8h2MmrDLF/mEe3CZsZiijNrVCT+S0Is2j+bwzYTA06osa/XNgxWj9?=
 =?us-ascii?Q?lSxK6TrXxAjTqA6hsmBQlnskKTo3U2Xh6+faQDPQtpgWMW6WqR/gMaDDnNRi?=
 =?us-ascii?Q?CdglC0C3heFcEVDc31i65+JsVcEFlT64QiJRFBzxM2iA98dAjkfDxHf0U5Q+?=
 =?us-ascii?Q?M3zG9tYDxMuWneVOxqNpVivJc8GDgvUA0XEhsFqV/gIGpqCoC9nItvGBGkGg?=
 =?us-ascii?Q?bjzg4UY23pYmdNKB/YcW/Ms+nW1XYxRTlWRPlzKt4ZPKlrUGgwOiMQYGdj++?=
 =?us-ascii?Q?9yF1RmW46FdMT4x9D6D9/uZtDy8yXW0amCTVQ3AdU/yM4EG/A+Xm2BGfeHzv?=
 =?us-ascii?Q?dQLaALodm7PORQpIdCoRJUfF0sl35ghwyQ9CNYOb1mbi6+N6NLhF2OwqAxco?=
 =?us-ascii?Q?UAy4OreaKdceZ/g/zsUmVlRYt4ngSoVdoD3lSmVrzKh5MMSF3QEo4oTTrJgv?=
 =?us-ascii?Q?7SeiwS+N1Gw3PfJ+kde6bUI/putLSewsKdGbWzsN4WbtIoU/daW9Dj8Q8vXo?=
 =?us-ascii?Q?vMs7G20vfVNReAquhHpg/C9u4mPsOTHNnlAGLExngZ+D6hxShBl/nrVPcOfb?=
 =?us-ascii?Q?4PVB7KJw2qKyN5L6qLr7ecSot75TiH6jAbaFqNsdmAcNA/TW1btXqBh4tZEJ?=
 =?us-ascii?Q?3NTeH6Ckrli+T/J/dlQ6fGtip73z3GHeiy54AM93tWy9cnp1rEjbewFjm8NJ?=
 =?us-ascii?Q?OcdDj7U/TT6s4npt6EaO31V9MyDd8iveG8BD4Cm19QE6FAQ7Pg/mRY9yHX7R?=
 =?us-ascii?Q?gwJTskp0+zvckjYyN1acN+2RIoGgKYzmi+hZO4xHMESG1JyOOJeU1akxz4gA?=
 =?us-ascii?Q?jKCkeHLBgY+uPSTB6j6Ms+U20VF/KMD7MZuFA8ZsCrr25pak170j5IO+i5KM?=
 =?us-ascii?Q?4cWGacDgHKa4XWwtQ7mx5km0MTKlslPHmS/mpdjNCbvaVT9CBQ6xTxuH+KEm?=
 =?us-ascii?Q?dzFUMvoFhw8xfmqXqO6kmQehdwLeqKkfmpscU0fb4T3w/skMRKdWQFpaRfTj?=
 =?us-ascii?Q?Gd1/paWYwLY1brk1g6hzloeRn5vywqWyDmUh0T8igtNL4Ddgy1wka7n5H+X2?=
 =?us-ascii?Q?qnebZ1L5k5xe001IP8aCthg8nTUCfBC5T8oikYh+zlI8FXf6vgRJbUtFhhBB?=
 =?us-ascii?Q?pU9PpiquL4lYcD8YpU8SSKs2IHhwyRdwKdToZCJLDjfjjPGFnKd+uz+iTcBA?=
 =?us-ascii?Q?xg0ycXxaun9+kFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nfaUkbPOwsQYOaY4oNeFeXOvVIx/go5R0fu9AxdQ75cF2jvCPnk+bvGBRYnN?=
 =?us-ascii?Q?BnQUOBBc/c3zLLEPkuzuEihhdVlUHGq48lZ/FDYAh9jqK/YP8Q3AL1KUJLou?=
 =?us-ascii?Q?Aa1AwEu3PW/2sQdwvO1SakXEQ/W+meZWlbXo96V1ktOK6V8Q6LM8xzvdfPwq?=
 =?us-ascii?Q?Yor1+pWLWhBQ7oOudSXovgWPSYk+YlTwe5eXWMm18V91ljrQYhj/jA7UPyzQ?=
 =?us-ascii?Q?Hy0Lk/l3N8xmD4REBOOq8uF2B/EnvSQfQzbRKoE1KqenQcVHtXbd87iYVQyZ?=
 =?us-ascii?Q?R8nHgl9mNJdhAWtjIhoVrHjJuZWtGz2sfSxqFjJ4Ub7M/LTZFebd2WKqk0wu?=
 =?us-ascii?Q?3qMaAYzZnUsZbm9TDU+ZR9krEzSHhEaIg0RW2Pph0guYmUxTejZuy07OG9jf?=
 =?us-ascii?Q?DrI72CalhsCI/XrSHP+64sbimKd2+XJrlSPsD3AeMM3vHhSj/7epiqIr10yw?=
 =?us-ascii?Q?iYWCjHNoCAmVsSFxjge1DPnZO69TfoAozOR9DeSYh32Psy/Iwj1yZRUvo1kY?=
 =?us-ascii?Q?Lg0mansB2BJvGXFGysiQi4WpnXd+q3U4NK163eaj8CbHPnujZcltRAKj/AvD?=
 =?us-ascii?Q?Gvw8ehsnsRtX5NhIVPSw+44UddpYnVs9FgEsqBWhEO3tHxoWxMV9QZFLtfYU?=
 =?us-ascii?Q?INuiH2zsDeheFtfofacFym9DTvGyTLPzdUVJikQvZEKs5eHnpyYQP4OX6PsH?=
 =?us-ascii?Q?2D63082TMttO3oM8jsZIRojbQQb/8SEXP0oq4oR9GncqFWHszsM2Tjf+z3h3?=
 =?us-ascii?Q?YGBZ0zLTmZgr6+VdAAjgTrxF/Eo/6GGqPAbqGCrudRxR8UqrGzjObuNEDeal?=
 =?us-ascii?Q?aBAqdyqgsZ9e3FAANbKPn3e0qlOOQTut2ppvsrEnUHlfLTNsDzrJ+KXDWogL?=
 =?us-ascii?Q?YRJooSFKJpLhz+PBzW14YDpFItxGO7EnrY8+KrX3hu3PWf8du9/yLCKg7rM+?=
 =?us-ascii?Q?S+mP9YMVMpOrQ7aACCRfNX4mmLKAr+TMieuETbvCpuy4Q+FBQ84DvZMfTa9+?=
 =?us-ascii?Q?+wCM/YTxquEsck9M9GkuFDIwN5qgMAb0u2F6P4dEk8OsYFb/VZYHkz7XjmMr?=
 =?us-ascii?Q?t3V0hBvVd8Mw57ojeo2H3jLkK2ikCxDbYHXO4TGBMRFJtejvxc7+W33C9MZC?=
 =?us-ascii?Q?r+qaR1ghd7vaoHY85Y1DaIJv4B1/DmRtUxANinO2dmdcnKEeLehYD8Y5Xd42?=
 =?us-ascii?Q?WK5YH1ivZTfdlCLPDQWkH+GqUwODVbZx1C0sQcB0XQMbBqYxn4KAnHvpMdMK?=
 =?us-ascii?Q?D7GTIOYh/qHgzE7mt5FLSdkIXuwRdfv5KyB20AN7MLyMb5mQm6uVG+hoMiHq?=
 =?us-ascii?Q?b1d1+eIoFhZZZuxg+Ke4V9dyqA5wgYLHMdZpoS8Lvp6pjWYmDjK2fXPK3Ocy?=
 =?us-ascii?Q?taCMOd70XLTvP2lalrKYPUjLSpcfDQ8/7IksC0y5yXH5PTjrn3e62fGg7J4x?=
 =?us-ascii?Q?aKBHmY1Oej32nPYeAh+jompDC/QjFChf9YCCukNXKK4B7SvZ/exCuBJ/62fw?=
 =?us-ascii?Q?uMgGVSGkiNYnExB2pZomuNvqsPt44L0x6WAmY9nNvC+BCts7MRrb9r5BJBHg?=
 =?us-ascii?Q?gdYChQBT9sA0Tkem5z/j5mLJ+rDFtcmOwNEt+2VXYDUezv90kKvMwQ5YlH14?=
 =?us-ascii?Q?tAhWD9R/TZA1GOdG+NVBBNB+07onGNYh4wwdbj80PmsnOsVl2aRMb2UTuyJv?=
 =?us-ascii?Q?hit4hvWVtFDUf70QglyucUxDKqVHzTXTx+z12lVay2OTs52tLNSrjfkd3BtN?=
 =?us-ascii?Q?IUPRex+6DA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd3ddaa-82dc-4f00-b25e-08de41d5f18d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 03:47:07.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BlHaWk77qlH1i8bdXP9lc5GUXjVjkMJypT+M0rXu00jppk2dv/u6+kQ354N7FZ2WH/LwAugw5j4MdO5oUnv8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732

The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
State) design where the first FQS saves dyntick-idle snapshots and
the second FQS compares them. This results in long and unnecessary latency
for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
1000HZ) whenever one FQS wait sufficed.

Some investigations showed that the GP kthread's CPU is the holdout CPU
a lot of times after the first FQS as - it cannot be detected as "idle"
because it's actively running the FQS scan in the GP kthread.

Therefore, at the end of rcu_gp_init(), immediately report a quiescent
state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
GP kthread cannot be in an RCU read-side critical section while running
GP initialization, so this is safe and results in significant latency
improvements.

I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
showing significant latency improvements (default settings for fqs jiffies):

Baseline (without fix):
| Run | Mean      | Min      | Max       |
|-----|-----------|----------|-----------|
| 1   | 10.088 ms | 9.989 ms | 18.848 ms |
| 2   | 10.064 ms | 9.982 ms | 16.470 ms |
| 3   | 10.051 ms | 9.988 ms | 15.113 ms |
| 4   | 10.125 ms | 9.929 ms | 22.411 ms |
| 5   |  8.695 ms | 5.996 ms | 15.471 ms |
| 6   | 10.157 ms | 9.977 ms | 25.723 ms |
| 7   | 10.102 ms | 9.990 ms | 20.224 ms |
| 8   |  8.050 ms | 5.985 ms | 10.007 ms |
| 9   | 10.059 ms | 9.978 ms | 15.934 ms |
| 10  | 10.077 ms | 9.984 ms | 17.703 ms |

With fix:
| Run | Mean     | Min      | Max       |
|-----|----------|----------|-----------|
| 1   | 6.027 ms | 5.915 ms |  8.589 ms |
| 2   | 6.032 ms | 5.984 ms |  9.241 ms |
| 3   | 6.010 ms | 5.986 ms |  7.004 ms |
| 4   | 6.076 ms | 5.993 ms | 10.001 ms |
| 5   | 6.084 ms | 5.893 ms | 10.250 ms |
| 6   | 6.034 ms | 5.908 ms |  9.456 ms |
| 7   | 6.051 ms | 5.993 ms | 10.000 ms |
| 8   | 6.057 ms | 5.941 ms | 10.001 ms |
| 9   | 6.016 ms | 5.927 ms |  7.540 ms |
| 10  | 6.036 ms | 5.993 ms |  9.579 ms |

Summary:
- Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
- Max latency:  25.72 ms -> 10.25 ms (60% improvement)

Tested rcutorture TREE and SRCU configurations.

[apply paulmck feedack on moving logic to rcu_gp_init()]

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8293bae1dec1..0c7710caf041 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -160,6 +160,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
+static void rcu_report_qs_rdp(struct rcu_data *rdp);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
@@ -1983,6 +1984,17 @@ static noinline_for_stack bool rcu_gp_init(void)
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
 
+	/*
+	 * Immediately report QS for the GP kthread's CPU. The GP kthread
+	 * cannot be in an RCU read-side critical section while running
+	 * the FQS scan. This eliminates the need for a second FQS wait
+	 * when all CPUs are idle.
+	 */
+	preempt_disable();
+	rcu_qs();
+	rcu_report_qs_rdp(this_cpu_ptr(&rcu_data));
+	preempt_enable();
+
 	return true;
 }
 
-- 
2.34.1


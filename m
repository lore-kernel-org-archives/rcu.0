Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433125;
	b=4cOl4sEuwLS8nS4ihz20o++5e7Ybic9gVFeONE2wYEKQwhNQFqY7CcRsNx8rLLpfrUzS
	 s610Kx0NakF7OGk6YditQHRSQShywmjpGJleeoewY7OIb/OYD7sDTznnQJlV+2DArAqdF
	 A0gL3CiW8xZSXXdGzcymbwPeaVp8/KbyKuU78Kr+6k6f++HRSs2qhsXFgJYt6urzqSgcY
	 ObfVwQHdaCNqjdkfk4QUKI9TqHPSXD4uQMW52RVPCcPmakXNFNc0CElNYWfZwGxK0vC6p
	 uL8jb5/y4R7XU6eg1+zUHZvu/tAcYtXHVlbtgzY9uVQBCSbLqH5IXstxLX9F1trS4Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433125;
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
	bh=84cuI3AqDuHCsJEbTGTDs6Mw0lwA2Wvv24zLUdWz5S0=;
	b=Eecc/EBSGs10J5Y1dKNNYgNcPzuLFD4UkZQdELY15CBlrwQoRmxncsXvjq+ovcIjyrMc
	 Flp/pINjpZpjNHqeabmDlHFjE4lJKWfso0pa/NJ7CLJ0BFc6rb/WGJu76QOpojcB0STmR
	 k0tKtIFhyAfTYAA7OXebvgzC6zWZX/47szdPmiNi5IhoZPZmPEcDN5nyc6yWgMj/U2T0/
	 F1fIDfTYvz5P6jfDllWCtxzj0SM0nfXRkwDG750rZDfHwftCu8yZYrumSeAoCL9pc/e6n
	 ujn8+aqO6V+b76G6bMVrDwu6R/zzltFAOhyvEBZAe3aHXrYRleztErhszMoG3WNVa4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=szjdnBSw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.2
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01226606A8A8;
	Wed, 11 Nov 2026 21:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01226606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=szjdnBSw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adBwVy9qIPxvbPqGK0B6xS9nAX3wgxVlQDru6dq86aZcWhlobC5/xeBWhReoFaDQXRqLcgzlbPII+OEzDo9Pox3wv2AMuwwqr9zBJYE5OUJ5HB7zCp8aU21I7wL78Kw3oqZ5RBwzjn6YcpZJclSNaplbm3Wj8XZa4nasL/pNSSI7bSQXrIl9qFTigWpVLU6XT1yODy+HFDpdZfMtBvkSbeh0RuLqPKWlZs6o16Vhl5Y9VPRPKSOKyWls2paGz2b+tXo6/v14draiHnpArRon6B/l3GyjnXRHXElYqzVpZCRXGEHzKOerEuYVKdihV4IpEXBOuUM5B2MzJiwh0LGoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84cuI3AqDuHCsJEbTGTDs6Mw0lwA2Wvv24zLUdWz5S0=;
 b=FIhw81qeUFu9sDQ0G4p6Fo1M49+ELALdkqY+r6xdCs2GKiV4OnfRB9dXKOGyMmH6s+eGnnoB1cceTNOy59yzCmJuQOpe0IcIPCoOaIMQWneG0VHIXiWZYjA/v8AFTd1IXwVa6qXXOGlv+bftuFf7QKFXEEPbP9orYODrq+Omn3S0C3OHSQVf4x97XNjiS8nDnS5hz0JdjhWUjw31/rHHSB4Kir2Soz48M4hdXlTIFKApxK6n3Uad6Pga9up/5EFHrX2X/cWOi4Se9xbAHE6O5NBK6rtLrJcZR2smZE1WWyW1GwkWFek0EGZiVHNnTB+u+R10n2yyr6qzj+nv8inNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84cuI3AqDuHCsJEbTGTDs6Mw0lwA2Wvv24zLUdWz5S0=;
 b=szjdnBSw/9Dhiha90UtmN1K9VfKCdvJnUcfTKD74Bt0npUTmnYT8ma6Kf/WsqKlO9Ox1UpzZJsb5/aunCa76vMrjkv0rY3D3LHDluvvR7xPWMAe5pfUJFhcErGUz2pw3acVR/daBMrs8+0y95b7rUlqSCO0qEIUueV20oa01PFHYeG/FMgZrstYU1sGWdJMWlCqvI5vw33Qzx7i65XZwftrdX/mNK4/HaEsTEhPfrPIqPVZHW8o3kTBBwKv3V7zZOOXpMLnICo/MetKIA+FAPmRli/mk+0k8Sbs3WB3/7zwSWPtFaloDC35tUmGZ678rD9QjMgIUrcjSVPppc8Eing==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by CH3PR12MB463434.namprd12.prod.outlook.com (2603:10b6:610:39f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 21:38:40 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 21:38:40 +0000
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
Subject: [PATCH RFC 4/7] doc: Document rcutorture.test_boost_reader_ms
Date: Wed, 11 Nov 2026 16:38:22 -0500
Message-ID: <20261111213826.2035045-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111213826.2035045-1-joelagnelf@nvidia.com>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:208:2be::12) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|CH3PR12MB463434:EE_
X-MS-Office365-Filtering-Correlation-Id: 15eac35f-4539-45f1-ed40-08df403c26bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|261009223027099003|3023799007|261022075727099003|261021121427099003|261102123227099003|261026121527099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UMfUMl8ZFzuaUEAaTTmFMMFcwZCaN0djyfp6o7BeizrYJhO69Ydb752JAKmBmKKHwI74rd6LYtSLl21zA7D8AskJPpqz/FF9V054MoCS3vTcwaHn0K+JirIKl9obGyA9+cLKheZmdKAhbyoJrlgrJCuzr02qu+KnmLHV3hlWbrRHXYaTPq7NQD4042RvRndYQuW+gP9cmx0JeccwmJO0jFZw/DbOgzPrKeO3QTNmVjbjuKtrKUmqVxpzBZcIL7T28J0PioSgwsVzl9SKTCSjhoEbsMQER0AYTdr2JN0A113lYYBPaZCFNCqD6UMgN5KwRkr9925bCp/m6RBR9H5stHkcy6NUP0M0cUOAOgWkZi1B8vZXkaLWKvq3dWAIRhvwPcHCVVpeQ7i9hYZ8DAzyMIjjm8uK+i6GlI6nWc9x0RyEHiHPmRk5GSJS/oeSRHrWklx3Zk7qRmMxvWEWjAIutMl/yeO5Mz3iEOSjd5o8+HiCCGUzmv36Em0wMjTtRb42NOFtOKdsv8i6M1rCCBKKCb78Vnh0PSW6TuPjKFC3upTsr9/qwlkhlKDD6Z1Q+qVTl9kxRxMMX03Uilwn9UfkER7fvuHQUErJk+Vh7HRr5IQYjN5IUqAau2YKY7CKpcIQc5V1kpg91rWJg70L6+iOE1IV2gXmZRkxo7oSxFkHX2w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(261009223027099003)(3023799007)(261022075727099003)(261021121427099003)(261102123227099003)(261026121527099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dg2XBVUrsvN0EdiIQGnauuLgW6Oy4r1gBiHMROnYWZbZ1xmM1g7kVYKVpuBo?=
 =?us-ascii?Q?cUTbCShjgR0nPYFJblcy0vL1ln13e3dnuHhViIfzdEsoar5u0AQTo6nAthoH?=
 =?us-ascii?Q?7fq3kqBFy+E2zGANdAY1jfJq/kIPyPpZC1Rufh9eCsCE4+d2e7mZPCSbnpD4?=
 =?us-ascii?Q?7jLaE+pd+wVSKyvTxYqOpV9FDDkukHpmyrjQdzM8NZ0LJWJPxuHGxnY5r3nn?=
 =?us-ascii?Q?ryocPYdy7rrEtHHe4CPduqBo/JWQz+uThXb9+sf2CVb3nKg9fJq2RdvEiOvL?=
 =?us-ascii?Q?hmibheow6qtKY5onTdh8ephr0oRCNrw71Dm6L+NKWMnUA2FQO9ZOByj1MeO8?=
 =?us-ascii?Q?Fiv6Pk5CNrFysQas9aol2coLVaUapvAEfHfr6ssEwheGnL8/6RYbVY9ZiP9o?=
 =?us-ascii?Q?W01i7Ppty/fwic0G0Qk5yKCIo+NvjB91VDcNfiOQ35dzLqEJ1h8KOdQZ5xds?=
 =?us-ascii?Q?PqSmrFGQPDyPi+DO9bNTrjM5GA1TIv0BboG5n9euNjwK71oi1ncyeVCHA05z?=
 =?us-ascii?Q?9JwxRnN5+FG1QZpNPuIw+RfU2lOonUkt/FRx5ToyhPndEKw0nx7Mc1p5gPHI?=
 =?us-ascii?Q?t4D/OGrA0PaPpl9hdA6IBaQBt0TjVsIrUQwXvZSUrmswfQUxXvLYDx4s8geN?=
 =?us-ascii?Q?4TvRjnFoYWNB1yhKS8LMhIsGPZdaNmzSngLQMKbMtNJf1VQHXAsRZ/irsoGc?=
 =?us-ascii?Q?5HNlVGd/fkaby4jqWJCA9RbhwOUqE4+ZiQ1yn+Z9J+rtLRXvV3VoJTHhvU6s?=
 =?us-ascii?Q?rfOtjMU+kdd6ZReTyEc38eQ6fFLiX5ylM4MdB0Akd+SgQWfW/8Gb3GxMlZ1G?=
 =?us-ascii?Q?FXetdF3w235nUSEdomdafum1ECjqfZltPB3Twxw3LtJ70tbjv8Ex7Mj1FC5X?=
 =?us-ascii?Q?SEXhUnozhiGcfQx22hKT+hupY7MniVqR3mvSFfIHC1M34S0mq8BP4xzqbDUJ?=
 =?us-ascii?Q?DG/a3/aXU4ZX0ptKsakRJRjLd5+35NxV+9d826XECz0Ig09PWmi1jBmuZNcQ?=
 =?us-ascii?Q?V6iNzrCcFwbHHM5TOAqb0RC7NBBJHP73NaBxGlWMXLvCZ3clkdQgkMWmeBQY?=
 =?us-ascii?Q?/pk5KHgP10CF0+bb5iw4Po2OLDL7VHLKdB29OS9++OoU9vSlTTv2xjc0PoyA?=
 =?us-ascii?Q?UAcvVhmpu0TxI0m/UR9JD6P7aeQZSGBwZ0Kd2ApOQLTooR9N1Oh2/Co0clUg?=
 =?us-ascii?Q?1mxxU+sQkUkC/QApArcxD5vi+jKEgyyHZvJlD3pppeKpzx6aYpumkYtBN6d/?=
 =?us-ascii?Q?Qpph4iRcylNugMZCPMDvhpiMzgtmkM+YJHvINjovDnYbMpg0JZMkb1jYznwu?=
 =?us-ascii?Q?UWonOUp2oUGXb2bcAi9oHlDNUB9ysHjCqL43FWzHHM7gJzOZb/WeEhfqabN3?=
 =?us-ascii?Q?yaPefYvXT/VTUPHTBhuTVsWxPJtzJC94tBayMrJH6HV3DdZwKyGkttC+w97V?=
 =?us-ascii?Q?vtjt1Y9z3rnD2vIzTBrCaJQiUIkI6tQV5pRA6TcM/qkAs60ivKXO3vKUeCu2?=
 =?us-ascii?Q?byMWUdtkHXM8QbMN1TcXnjsZswR2Vg/hSN0jQyHNvq9yiqGBo6H7j20SOdED?=
 =?us-ascii?Q?ECFn7hLwNAMvIbijvTRWwVlK5ZpERQD1OJ5pH1l8TTZczUxktP3m5RAkKfTX?=
 =?us-ascii?Q?xFDmpLT7pXzBxR1wt6lBgROF/25PjUY4+53tn20AiVnCasMUAUI0Ard5oR1U?=
 =?us-ascii?Q?242IY2ZXZP2+JHuHtKvbX+fbWiTELmFIWQ4EtZbvUudKtsGexesapjD5x1xl?=
 =?us-ascii?Q?AySHRHnZ0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15eac35f-4539-45f1-ed40-08df403c26bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 21:38:40.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEWP57/LLy5wbw0xKOOcCymQuxas2XBCkTTe0greTFQMNfg6mX+LA4Irj2fdVky0H4n6kvlOk8BRn2ACL9y7YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB463434

Add the new priority-boost reader CPU-time parameter to
kernel-parameters.txt.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 176648941aec..ac97cbd98b46 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6283,6 +6283,13 @@ Kernel parameters
 	rcutorture.test_boost_interval= [KNL]
 			Interval (s) between each boost test.
 
+	rcutorture.test_boost_reader_ms= [KNL]
+			CPU time (ms) that each boost-test reader must
+			consume within the test_boost_duration interval.
+			The reader runs in an RCU read-side critical section
+			while a real-time CPU hog tries to starve it, so it
+			can finish in time only if it is priority boosted.
+
 	rcutorture.test_no_idle_hz= [KNL]
 			Test RCU's dyntick-idle handling.  See also the
 			rcutorture.shuffle_interval parameter.
-- 
2.54.0


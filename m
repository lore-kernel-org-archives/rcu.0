Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC039151B;
	Tue, 17 Mar 2026 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782605; cv=fail; b=aMg0E01/MNcxLFhcPM9X3BLk8l5YP7gU4XosutHSDT/DZ91MNx1oWfBLFWaswJkOkCS4TZCiyp1ITQqrsKsbrcfD/u5ou1q/M2R5HGlvYySPBOUwgDlMs99o1EqIwb8lnSlx/c7X5HnN2LChiFJO53ztzwDHQa/KbCxUDl4idtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782605; c=relaxed/simple;
	bh=cbCmcNBr0tAIl1GNRsKq67MCQO5Q0F+0aadGH2Qk5YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uewAbTXkWZ0/hrnS7OYEoeEDCijDKrwqXs043apaEMqaZNSOlay/ra3HEiU4UENhKwKnWQtc2uGj7T5EPHqn5YbiUea9BbXdyAgaIvQ/rqbO4hQFdOkEfg39waGEC/eXk6o8Wlu/Caui0HprT0hMUEI3IOS80+bFt9qC3HQ29UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EsG74DwK; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EsG74DwK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN2absC5WBYuB0L+NCGox6OPAf+mKbC7BWVOdp0G1wJTTpnEvBnUTHEK7uYzdWkvc5oxOrkYxkx1Sy/jfbyyBJo+mPk5jqAxqOrfrHQRhI7AndMqtDpjB695e9PU3r74tDKlgCWIb28PxPMEYLK8wz8uSXRD7HV/HdeF/5nqEXukuZYE4QeoHmMyio47HcREJCK0pGgUArtKHavRqyZ0vd4E+eQsRRlv5yPca9IkZjNCEMkkcBtm3wjmdnbEtymup811+X18n0c9ndGfxm62bID70LYEl4jyEulhAiXuCMB/xuclASaiLgZh8eAgQTFMgJef2mr1m04jqoosa9N0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxeaa4zv3lSdkGAVpwWBo7503TM6Q5dsu56qXgMxb0M=;
 b=Dgbp49M3KOeCry1GX8OqNZCnD5gWd8q297CM6Q9COLGMLH8+LQne5hcF77bOaFO4w6aOz27nSXtXVyijbwxd57oK6lskoRvFsDb4LjfZSkUqd9dLxp4C6tOhmNUUCOxFpWWLBJFLpfOLckN+BvBY06/xJ5e1wVMsEVgxLUi1lMU6j6aV4wEBu4DafuFwfpKx1yn70QLdwWvCmzRYYPdlCIMlsSsbGFX33ZRFaw4ybVQj5rG6SZjQqB9AvuyxsCJVzyOavO6cu2zOqeffJkyTMsbP7jBI8lPdW9+AQAGC7gR2tZ5Acm50wXMcSR8yG6QhJKsK885zX35btQ/q8PWTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxeaa4zv3lSdkGAVpwWBo7503TM6Q5dsu56qXgMxb0M=;
 b=EsG74DwKCaRYKVCd7279tLp8hKmXyltus8xM8TU+a/y0Ok10JMVZiRg8/nq0FQoNNfhNICy3MjCml4TbDHDYRyj3kHfgrlBKEbfo0fiA+hsDi0kXwtfGlnDUT+HSixrYtT/ZTwLfDs+gtGlJW7yRpzNRA3MPow5Ocp1vvET58Y/axbhjxYqSgHb4rblTo8QXcIqrwIQtHaiUgwntj9+Fh36UQQHhjcYvldr/1XsAGGW9OdTdlLkR9lhX9Oqrh7pddL6mee5eBi3Hv5UZD68B/C3OsSDZ2hU0bv0pQWVdkDt7O9Xljv2rnN14VF9K3WMC/PoLIrPwXYpkkAKcT7wbmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:13 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:13 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH -next v1 11/16] rcutorture: Add NOCB01 config for RCU_LAZY torture testing
Date: Tue, 17 Mar 2026 17:22:12 -0400
Message-Id: <20260317212217.1527644-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:930:14::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bdb188-ff84-4fcd-5786-08de846b6576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ISGloqtCI83dZ+jzafxYCef2dTTsIMatv5qh4w4WpLF2NNRIWKGkfB1m9qSrUwgapKsOkTQw0OPrP0w+Km300irD2lNIgW3SJv3WDBqgIdPu24SvHppRQHMLr6W3B9/aJ2dLKo1KnUbAEaHUhk6YKpes7prKpqTQFu7sSUTEpYyOrql9ET5edZqVvCvxJ5EofKJe+UHrTWbJ9iMhMQv50a8GYh+pN0B59AJ476cX6CBZl8tM4age1aAPR3UMhyAFvGMsRlH57rD1GNdYP9+xEd9bIOfcaRklpj8vL0OgUPfS925OErquWKBPpa7zgFGw506JrkGSB9poQR/qYjqEqrNBdRz+AnOHZyRnYs2h4raXF9W1UTZZfc+xikWqrF4VWB0BbIJnTpvMwRCAswSonXeqvgnTHJ/wVaNhbBnIz5twX0cxhqYSjjO53cqQGKXwOssixsu/6CRby3WsjgAnG8Yc8S7ZEuwxuCWo5B7goOKspJVZNbltyeyltzJ0R3GVSfPxLezGuPsEYcXNmMUwTZHcTE3YrKlk41kWEaEa12XVaUbtOiDXmvCYrPkC5iL32F2xcf2BLukNG7jWz9S0w4Q/wsL8U/hEpvZOLt/g1vF+EYOTZ7HdzmJuBxw7aJs44UGpSryOixHHugtxuDReLXCiQw4qhLcMfqn/B0le/lf8EuCL/ygArzazYa2vUpzoCyReb2rsKp3atcFQD2tIJzGqJ6FzWyyPRLKBQw43fIM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R/STG7ko+LNaE4OpJCmQWcG60QFoH1OJUqfvhLRwDWNMloK7o9HrSNBfg9xx?=
 =?us-ascii?Q?palND4T9FcJ3t+LpUbWbkfdQ54jMbZrYo6Yui6coqNe5/jrZoHKyxYlfUBMa?=
 =?us-ascii?Q?zllxQNUuKJm1gOynQrXMO9AM+JXSLSKKAck/N7VLXaw0eITr4rneDkg9Xiom?=
 =?us-ascii?Q?KllZ9FgnLBFCzKhoBd9D5peu1Y++dChh37oqZWnO5ae3y5kk9XtmVTh2pR7K?=
 =?us-ascii?Q?SXF64TIc6bOKQTRaP/tZEkdndmtCyhQciz9qTyAbnQ4CHfNNpTuqcnhumX5A?=
 =?us-ascii?Q?fwvdxMtWMEnByTD4ZCcTQ0a+pVgX/EVHpxxRcNc5NcmHwatkGG6X/RYUvYfS?=
 =?us-ascii?Q?IadoiF7qfPcIBBrCovOIagfqpzJTGmrEV1rp8YIbVKZgm3C7J5mKo3jfCNE8?=
 =?us-ascii?Q?g0BTgjNPkK+bVI28yclmhCKkD+mkrshM+EjSyVbAyZE7CARC66a1ioym83b6?=
 =?us-ascii?Q?EeeGmUmLjqPBTkn9itHb2MEABbTyZKpIzEgB+GbIRXyclRczKCHK06zs+n23?=
 =?us-ascii?Q?MXPXrs6mAR4bL+un81Gv3mdmXr0bdPahazN6jUJIw3nHl6RtNyaYf/zLbMhU?=
 =?us-ascii?Q?+Hw6OaxOTXTsnimTcyCidMj6KU/ifOiW2bw90mcnKiz0DOCbCGohNq4gzj2k?=
 =?us-ascii?Q?BhDjyyErmLW5H8B84Z1V+mfCxqLiNziq78vmKwEWgpLtxMxE3gSB16jESQkS?=
 =?us-ascii?Q?JQpuzOiNGe9sADWggv+L7fWMDWwIgekldyH5D8e7mzCYYq29GbCqc7hiNoW0?=
 =?us-ascii?Q?YXMiPAJ0Jqz6Om1whYM3uFE/zc5dkUw4SaHI4a/RFlKxngz7+vmEXB0oDRk/?=
 =?us-ascii?Q?qCIaVc02ma19GJDu5lk2G9sYUbBwH+W8Gv08Rd1BIFwNcVHFZKGMhFE2TECv?=
 =?us-ascii?Q?7Im1vhSpKO7XpsO7WAbcKJh35nd3gjkTLbzKlL6loijBBap/6kUHKK6Ja5rf?=
 =?us-ascii?Q?roIkhE1kp3mNH19f42P96mmp7z8ANbTZs/YHANRrf4QYKXTNAP8tyJsd1k1b?=
 =?us-ascii?Q?d7s+faRHI5fRBYDdRFRDzXyc4MbvA6/w3ZiG9jjuW0QDjLM8vkXqCPm3rfKY?=
 =?us-ascii?Q?VQUs9Ep+u9mIcOi5w1zjZy5b3v00PDEcfX1ShVHrdpBfZzEbWG+IvIkqSxNg?=
 =?us-ascii?Q?+M4CW20pJPbizuoBpUECEsMUTUGvXkQYaVlIKRZBUa3L/A39LKVfFDhYm/14?=
 =?us-ascii?Q?t+0mJl/3XbZIpy+9VgOb8xQyrKwEBAWSDj0I82tkDiiX93Lm5ls7w4WFSpNK?=
 =?us-ascii?Q?ynccCAYsgrkM+L40SImikrdBnfnkQUZ4PiiNKckuWPhYP1VQPAWYZJNBqriN?=
 =?us-ascii?Q?V31iK4R11Mp6s3qSYtOJhtD+EcP28CUOoYRaBKGKgXbBc6bSexvadMJECNrp?=
 =?us-ascii?Q?dsapKkud2dNwAOY9v+qLVMSV1Mx2inXqZmSuAEnP7D9KEnMVl3UEu6pTpuLJ?=
 =?us-ascii?Q?F8zjRCwk7Z8Y42YkKQLJWOrOYIzuvPm/aO0iYVRuO3u6eCpDVFlnDXdNF7Wj?=
 =?us-ascii?Q?40e0FWtFWrPaqTjs/JhDVUoup2aJp6q6g+xMCAmpRUrTC6JBRfHnAa28RMYj?=
 =?us-ascii?Q?bfc3sYdpZQ1jGj0g8KIMtJ4GpB+d+9M07FWseq+vh95bTUUt9ORO6v01SAsF?=
 =?us-ascii?Q?ln2zwDq/Y90xvJ364/HNqrPLKtN8y9/0417JAwnJLuTfWphGBEsBLIg2x9Yc?=
 =?us-ascii?Q?2Yt6jtEiVQvdYdBFYWVXIxIMQFGMU50E3uHkVEvfK3wp1iuX16LOGsTyRJnn?=
 =?us-ascii?Q?WZnmP4rqXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bdb188-ff84-4fcd-5786-08de846b6576
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:13.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qslgkkh+dmOrEzxsxuKzX86rZklpf5TleXYgyE/UFZFwWfgLKea1ujRham+gMzWX3J1UiOHCj8Yc9LK+n7rJSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

Add new rcutorture config NOCB01 that enables CONFIG_RCU_LAZY combined
with CONFIG_RCU_NOCB_CPU to exercise the lazy callback code paths in
the NOCB implementation.

This config exercises lazy callback paths not covered by other configs,
including lazy-only wake and lazy defer logic.

This config is not added to CFLIST to avoid increasing the default
test duration; it can be run explicitly when lazy callback testing
is needed.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../selftests/rcutorture/configs/rcu/NOCB01   | 21 +++++++++++++++++++
 .../rcutorture/configs/rcu/NOCB01.boot        |  2 ++
 2 files changed, 23 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01 b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01
new file mode 100644
index 000000000000..bbe6d28210ab
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01
@@ -0,0 +1,21 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=8
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_TRACE=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_RCU_FANOUT=3
+CONFIG_RCU_FANOUT_LEAF=2
+CONFIG_RCU_NOCB_CPU=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_EQS_DEBUG=y
+CONFIG_RCU_LAZY=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
new file mode 100644
index 000000000000..5130bc84c435
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
@@ -0,0 +1,2 @@
+rcupdate.rcu_self_test=1
+rcu_nocbs=all
-- 
2.34.1


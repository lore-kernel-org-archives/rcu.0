Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3A3563D2;
	Tue, 24 Feb 2026 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974308; cv=fail; b=BlD5pycnckyBLyMIlqO9mnkmf0ONMY/q5aT52oP2eopMbPG2gz775YPcOx+nS1f6F71npOf/jRZ4hVqUK06QORZH2CR30tOhxCUWj5I1uktQAMSq8/HFZmE7G/jelRbXUyzf43ZAqGSMa3TRRIgtby81k3IZ6+Mrce7G0mWscME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974308; c=relaxed/simple;
	bh=9qARNRh/Cw7pubVzJETs8rvvGjkJluiCCvCitrmwNV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZoobiTFVaVhoeO32QKfT8/cxp0ku63QGFyW5njJvAEKyamFZ/N0hG8vCAYAoPRzBV8cL/z3p+nfYzld/6KF8OypW+9S/6YscGc1BZmT1B5zhFbp37z7PlUjx+FIdagW8y3w92FboK+y14T0DYS3h3qbhQA298N0iTIAHCY2lujo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aNT1/hP2; arc=fail smtp.client-ip=40.107.209.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aNT1/hP2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liz8+F0TRZYs4UpRlPdqzt/9ZclITNn6zVuLc0cSn1IBx3e1TZZIhbf+h9rTIiKFSDrkRqh2t3LltjsVptG9JrXUWlxuTUvJ6rhWHESPXM02dQM0yEcrlT42H8KJpoQEAyGZ9qBmjTIdmm8C6/aD+28/MaYzZ5SZ87weOebPiwtJaFSAaxN008/uZ5ZE40Xe/3RsgeAJ3lMApA3tlTWzPswDmFlC4zQ8Jbvk/sU0F+73nMtCcxOPpZaqBTFvlTDUKTDApmFB7nnjULi4jBEGFQzTcqCXqhhEiivKeNRLSU1wiYliMaUI/dhO3sTCc6S8D8A8ZgEcQd9vaUWxoIp+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrMGOZLaLJHOiI6ndcVwB4lA/b8LH4YXsVMPZCWlzbE=;
 b=OD4tBDNtpL0bC0RXZ0vnUpQY3gKxqCyqVgLYQLU/KOl7Xec8t2DaEE2EnWj5F0u9/6dH979LVUSN0i3XDfD1IhRF4RkzRu2RtjnkvtALZIcye/RaqAKzJ8RXYoYVc/KssBdBA+7ytEq/SsirUDyNDCYuIZSC+D95NMnzCPWJZgzisG6gYqPf1TBVSivhQDDIHwWiUpmOb2Rg+tFIqWuRXIDq2ug5gMaIZFPH7cxmZxGFdurHoNne2NIt1VELikRjVS+VFa1RO7qVju2rRJIITqvLAtlVg2QRmxenp7A/ZL4DuD71y+R+aYO0xL2h8eueWNcUqw6KLA0go1gJ8hKJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrMGOZLaLJHOiI6ndcVwB4lA/b8LH4YXsVMPZCWlzbE=;
 b=aNT1/hP2cpNy8LpiuIkQq0kKQgZEpUjMStuNZY3I+BPLScKPebkT9HDM4yF4753vF2rozJI1qbP416D/6MfKVT/2PtMBVVQkMKL/L4mWvXMsp4823BLBx2kRLD8mu77Y3mcViZ03PRHXH9iB3VHM7wWV42tJeXALgEJLHovIu5sydBRLwnkIAfp/AIgP4tw+iWtfRpgowXmh3kngUbfHM8EXNBwOXtxneofJ2yaxJLf6KWaoIzaDEmlslWqJdMz7qTkVtP4HEzQwHZTeOgRSFQGuX77jIUAec48XcNRDTPOay+lgKzYpEsz96FXYx1/uvCGZUZvSg3mPyVtGdXfGAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.14; Tue, 24 Feb 2026 23:04:52 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 23:04:52 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v1 4/4] rcutorture: Add NOCB02 config for nocb poll mode testing
Date: Tue, 24 Feb 2026 18:04:35 -0500
Message-Id: <20260224230435.3390963-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224230435.3390963-1-joelagnelf@nvidia.com>
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0020.namprd15.prod.outlook.com
 (2603:10b6:207:17::33) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: f4aa6008-6ae9-4097-ad8c-08de73f91e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9TJNbek9MsVFOKgKVo3wITCtUaNYKIh5M9U7kOT45gDZ8IxYKzxf1U/eBZ5m?=
 =?us-ascii?Q?/xtrFu1C2FdlYGp92PMWNqVNcTzy1C6J6ihxGvIDkXt4GQwXNZ9zv/A166TZ?=
 =?us-ascii?Q?KUC/Fwr0aJ9OjvRHjQyhD4+Cs8/7BkuOfQTngUuRcvn/4prpEkHszaXg3mlg?=
 =?us-ascii?Q?1vB3Dy49lvQvuK5sDichsj+KS9Z0Jjfjse6vSiqYu/nhcDjq5Dw9Th79mRQV?=
 =?us-ascii?Q?OsabJopntG2FB/qBX4Kcu6MYthAVWOjXTxTg8OaN+crpIuZRBKGsz1aUY7Ok?=
 =?us-ascii?Q?61VxYo8cwLH3chsq46lKDJN8iNpR/e+YWICB3m2YTD/KY+l/yNjLh6CJQW0r?=
 =?us-ascii?Q?Uo+S10Rc6qEQy8cGiSGKnHHaDoINI9h16632VQAAK/tKXcWfX0dG04KTzo71?=
 =?us-ascii?Q?NHaZ8p9IqEHp6tnMBVUE73cT8TprlcTqRGKS8Ce0wh9HSwvtjeb7iypIfnEu?=
 =?us-ascii?Q?0jyCpFEWSP2ZD51Je9Ue0nGz05pB7uJOiZXtqHVveslwcvqS9Uw8rmMq2zkY?=
 =?us-ascii?Q?CtGFrRFIcBCNs6J333k2W0Whxbivd4XkJD4NenvRGsAUjzSlJk+Fop2hIK1z?=
 =?us-ascii?Q?FZxAzrJtSuVivrN0Mm2M/Gnmb1Q1hGZfFDqE7CqxyOJ4y0WzH5SX6+W3efaz?=
 =?us-ascii?Q?iMHJ4Y1nkoaNi8MkyXTPgwO74G6YGhQFdZlPkLOfdKAdKEQxWudU7LZcZs/7?=
 =?us-ascii?Q?WGDpIV69V4Cz4ghWICw4XACWv0T78zpXEFiDHrEbpZy2ZLi26sH8+H2SRJf4?=
 =?us-ascii?Q?jO/rOEcUQibEQpy31/qcpKlwrRyOLdQzxPO89lJvgIf38q71K3mJOblgIK4x?=
 =?us-ascii?Q?2kpBHYOsRa2afRNUAi49N5z4XZFLGrutogqIhH/zcjGTSgif+jhCUgrFpzLC?=
 =?us-ascii?Q?oHDJixnW36BFR1rcUUhgVPVccu5Nohn1/pC6OW4a28ppC6Dw2FqzDfKIRIFz?=
 =?us-ascii?Q?bkOgIHJulXN1vJjsHPOOHEL+lE0SRXG8s1FW5KAwymVSxgw46qM0AZKUoDaG?=
 =?us-ascii?Q?Cu7FcVlamQEMEPY8x5E4MSS1Yf0l88SJmpVEldb6Y57Qc6PQWJxZaKceCBdY?=
 =?us-ascii?Q?y527aGqwVZlHYGDYoxhhFdfzzsPSYWrU3JACGjGTtbw7A7dhDy+N7HJs2Lf6?=
 =?us-ascii?Q?RYEGrnhMSnDjKAXXNZn/kGXrXPuuOLNcSInL8Mp+mFk5TPizbn6rtdWWKVVj?=
 =?us-ascii?Q?h4XeHDdkfk20w03TSdxVC2mWWAaKe4JKarz47jcD6ZujhDEon1dQAz5z8LuG?=
 =?us-ascii?Q?0KFah+/dTvJOEFNQ7LQ59H4csl2aGPCn8dCUYBjwuIV9DDEbWovYEPQ8OR/A?=
 =?us-ascii?Q?UIPkh0u1MDUIF3KbWEgcDZeIbM9jaRsbrF3HnqXRmPlfFLs31rrxknJVvHDS?=
 =?us-ascii?Q?T2o++D4Q/CgE4pQxMXMXAohWymbo8ndvUHCbcyydgOZmAjVdolUmRLma5uHa?=
 =?us-ascii?Q?XTwFL3jCHEkWz/L650wK2cjqKUk4ePi9XeFPiTb/QNGavgtMVjZREiMcdJSJ?=
 =?us-ascii?Q?p82UXY4SablzaK82SWu582oVyXErH/ZkVuq+4bUKbX7WGbGY1N17Y3TNa7N3?=
 =?us-ascii?Q?NAu4j8KLOuDfjMFnUJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHDh3EdJTO/sJt6skIIuOH/dQQqUMLZtxBpHb0eHiJOlPQWQhncf9Io8QtCG?=
 =?us-ascii?Q?XnVa4OTP4j+89LVQVwQO2dHf20kLrYYpSilVopaZDzfJmUB0kuMspCMDEcT0?=
 =?us-ascii?Q?Kd2cj3Wv6M9joc/Uin1bLneZNCNQB+ISOPdiGUSIvWMghj68rbx7WI85a293?=
 =?us-ascii?Q?kWHd5K3SzeKXdY2MvdGFLhbLjUeYCGsAbdyDRunCkKEMCFeRXGrCq05pRqKJ?=
 =?us-ascii?Q?k4jo6ypem03RJ+PRJo/BVFYwirv/+vYodqQFRpR7pW+Kd2amsOgSwFMOYqcV?=
 =?us-ascii?Q?0h21Hiid93ZaSxMn9r9DTXwSE+o1lPQwS+Xg40bNhNV7HChIIWQpDONPPNw4?=
 =?us-ascii?Q?KUjfz26cckStGeW4dAT3Is1J1k2BxxVU/sBIHESK6wgYaMncPrp07z+N2cZo?=
 =?us-ascii?Q?p59L9sg7mlY46Lly/rcvNNCzyV3NFy9sf1bWdb7EmEtihPHLgqJdf3CoLJY7?=
 =?us-ascii?Q?Zm+EhAxF3S4pzYbulMD3xbBbT/wu2OxCPVD9wTZTdfZJElMdmI9maH2q2a8x?=
 =?us-ascii?Q?j9NsAg0Om7bPXGuEfrXyX7CedrgIZXyK/kwycb17Vvc33qBygCfdxBuaUBDI?=
 =?us-ascii?Q?gLdzZwmozndOMUYtQ/bTxM9Obj1vBPKNLWuJwd1nidINHq8y/tnMEMMYTk+s?=
 =?us-ascii?Q?oynHTPAPH2FJZJR1JsTNd+HY7BB9IzJJup1iq+47UaNybZD0eZIs3nbMr5mI?=
 =?us-ascii?Q?DY7AzYTSJsDL1zo6Ti20GoyPqrzzV4d3Fl1mDVlBEib+Ku7yGkIBXjbw2I0X?=
 =?us-ascii?Q?oRj90550+LNWsPwDrQVxiRG2hiF/w5lVfBr7HdqxHjvRJcezVP6Ej93qEQPO?=
 =?us-ascii?Q?0+ahIvjK8KyCFJXFFxQlD+9RmkvnbrGZpQ4HMdrrRMyen7W9gvjxgyeSUmUO?=
 =?us-ascii?Q?6GF+aKfQVOacoBSZEjgo9pcPoHOj/UP9Nx0yXiVcMprcA4dJL9R2hJIQltMz?=
 =?us-ascii?Q?5DvxGjZuR8jhSNZaFk3J06ws3L6YlTNk/xabRt5MBPn47gSm3jotTHCuE+H7?=
 =?us-ascii?Q?Iyve6YxCuMCi0F2Z7wp4uLisyIdLIY3g2RPDU3bl+UN4g9BazV3lA5qXqYBk?=
 =?us-ascii?Q?ki7zjSb3YRclseuwKE8ZDfiZtaW/ezrlxOge3NlIGMmKb2KIZqH8zUxaLAUT?=
 =?us-ascii?Q?rRcBCHUa4Mcmmou3stpfJXMbLG+Kzvtmd3GRwRN0nT3M+fsgfGjV1ZR2ICQ2?=
 =?us-ascii?Q?fOzzXejsjnQbMdQC8pXn/mQzNAYlgSkhmZ4ZqpS7mIwiX8XzKJFXUMKNbCqb?=
 =?us-ascii?Q?uP/TVTbhx94XO5gQyd5NYq6mctyii5nt7REcKa+oR/nEkr5C/LSIchClMbs0?=
 =?us-ascii?Q?15tqK6Pbk9sbTUzflUKjoNBu4Ve/r+VHq2o8RxKPxwEaKV4uFT4kdVxR3rPi?=
 =?us-ascii?Q?AfzIQtm91kyuYlkLV9Gy91vllXkAuAdKO5umaPNFnOIaC9f3YAQ3/V6dZp/o?=
 =?us-ascii?Q?Ep832io/YZc1TCxCh2PabzsOmeLcHL3Z+OVReEM9XleBfrHpbzpr05+rJcxZ?=
 =?us-ascii?Q?/fQgCY9lbjeQZ//Tf9zAbxipfcdoSeg6VH6Mk+nLi5YMaTzoa8IH3tnIRYQw?=
 =?us-ascii?Q?FKytwy88sO5MZo5EAzMTZZ3duv6MtJIcBIJoERI3AMpkxHwb/Mr6tAnmw1Q0?=
 =?us-ascii?Q?1b92Q4G/aErA1ZMRc7Z6r53bztXT6jKG34RN8yV7kG7AMfIUvKa6Ke3pJqQa?=
 =?us-ascii?Q?aQCRWm8TI5rqQv0S+U5C5IdAVee5VBMF+17HO+i/gJV41Y0f2+f4Ypr0tv7M?=
 =?us-ascii?Q?/EEFNHZstg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4aa6008-6ae9-4097-ad8c-08de73f91e5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 23:04:52.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdmtpp0MloiqLEfg6RbDyVzlTKJ5SabFn16vrOPvaLWg6c7M+t5J+Hdfqh4RelOSSG4lwDmZN0JRNlZk7LOHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

Add new rcutorture config NOCB02 that enables rcu_nocb_poll boot
parameter combined with CONFIG_RCU_NOCB_CPU to exercise the polling
mode code paths in the NOCB implementation.

This config exercises poll-mode paths not covered by other configs,
where callback invocation uses active polling instead of kthread
wakeups.

This config is not added to CFLIST to avoid increasing the default
test duration; it can be run explicitly when poll-mode testing
is needed.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../selftests/rcutorture/configs/rcu/NOCB02   | 20 +++++++++++++++++++
 .../rcutorture/configs/rcu/NOCB02.boot        |  3 +++
 2 files changed, 23 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02 b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
new file mode 100644
index 000000000000..4c2b8cd6d8fd
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
@@ -0,0 +1,20 @@
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
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
new file mode 100644
index 000000000000..c212ae299b0b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
@@ -0,0 +1,3 @@
+rcupdate.rcu_self_test=1
+rcu_nocbs=all
+rcu_nocb_poll
-- 
2.34.1


Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129A17993;
	Sat, 27 Dec 2025 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766794374; cv=fail; b=KBWP7RbjH15YTC2JweAISYrMnkCJMLWfwLw6nEv9SkhAKVDxhUHaFwW74I8qSj142cc+9kFaYr7kNu8cNVVlUCUdsOx7EF0cClm+8ZKYcF9BvYvKkl4g/kRbF92HMuEKkE550oRI6oOlx4pANQY8takfacJfhlcUNtfIv4vVeO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766794374; c=relaxed/simple;
	bh=1YTk1BXSU+S39Dk4vNPSd2M0Sm7fKxE5DFaP6JWKYR8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qWTYqU8igI2wuLLEB1ylxkUzd0SUIMfvuEAXnR0szfF8NljfjOpWlk+/9c9bnNSZX1CagJSiroYoYY/Y7fMKn9pObsZamBZrfGws2g1MBYLENM6vyEs0QLbSSWwtV5Dm4h4qByy9+fu6tAzV2nJFeWq7PU3H8tZx87pDyYszu8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MdmA5LB5; arc=fail smtp.client-ip=40.93.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MdmA5LB5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcyGxGESHx3ZGzTPs/AukF4sLEXcXyNyG1qOwlMxR9YQ9/sqDLbSreI1bmPJrFew3o7+vrREZoRVPhC3HK36PI3MlR9R6NgPShkN0T1dgcyAwTtCgyWd90nJnkV2uuaOQaoXrhDmo41QD+eGwYs5Pre59sbYyvnu3gP8rWHAliMh9dLKThewGvsajGGx/fIfH7SbvLVdHZ7nu/Y/Qe2ni7ZhTdyc4UbGvszzSyetdx9F75NQHJJ3btnknzisKm173WiZfe9Xtua/42lNBit4hTSX1U+5wMgPQagYvKajH8/pJjLszOrpJ4b1h41DPjVPwmPwygMbQBZ6CmRuUCnU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vx3nu83cv16+BA7MynW3yyvoVmu+5yyWmLJNSu81IwU=;
 b=raj93Ei527tsN6dBzvhBBJxXPBqnPYBX+j3Bzt/dazQ/wTWj/lqeCg2AYEExBAtTd2KswgM/xMYwqYS+JwOBSrWAcInOyHayRRPwNYIhvzKv0oVB/q/bsUTqleL5/TGGAPcnWl6rf1cOw9WFi1y5PcovMzcG4BT9a2+9P/qLUZTehaXnkGx7n8D/14fharJ+zkJMcl36yFMGca5yc/0VR2YKiK67CbhbLl/ee4UTWEN0ZvDWpt0YNgRpZqVZr6cPCyBDU6pOU2vxN1MJLgVhg1HJf58vqLVhogf6k//18RwhCL4gYZhEMsrL6Spb+I/cj+1nleYzv/SHTh6oGKZrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx3nu83cv16+BA7MynW3yyvoVmu+5yyWmLJNSu81IwU=;
 b=MdmA5LB5QlgEJEAhVtnIeBSQgHAQGkxhB9ZeFt4C4fe8tNxPqQOm7J4YFFhIelF3fR9rh/usykk5J+GRtr7azyJnyUp8FQX+rJvs+n4rY7lICggCqJyP1iQYxkGVZcDwrbn8HNiQGv/akPrzX1Q++ShCtY1u6RULdVBfpHcTidgtTpUTg+IfsIqpz6wyDG0iP1735YpBcIP0ZknDise0LdVmA/GaG65oh4jr/dhfb4mgbicpnYXSefwhOSCKbxHviz2ApBrvXiM08JjpiiMI9qB2LMgAbhukriCFo9ru1Ooi3xo7rik9Y0nTE0+WuD3qhUgLqvtekmm77GQROFxegQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Sat, 27 Dec
 2025 00:12:50 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.008; Sat, 27 Dec 2025
 00:12:49 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v2 0/3] rcu/nocb: Few NOCB cleanup patches
Date: Fri, 26 Dec 2025 19:12:36 -0500
Message-Id: <20251227001239.405644-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0103.namprd02.prod.outlook.com
 (2603:10b6:208:51::44) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6c7da0-6b6e-4e7d-9a00-08de44dcabae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vGdgvxCMs5XEUZNMkpkcwO/D9z/01iZIoodwgn9ovatqF9GUGNnKWrmf9GG/?=
 =?us-ascii?Q?IMvXmR6uoSYaRHyDGam9Mx9/NyRTTM3W5f3uCf9Vgy5+fBoIUHi8/L0RNkVe?=
 =?us-ascii?Q?s9DxKH5MWHSaGJYP5wJm9VLgTscuadlTnuhZKT8OmzRVqIaLbj/kY+vCMhXU?=
 =?us-ascii?Q?Ee/s90MxWM6RdZkT973KvmZUefttzxAXFlA//DiUixNnZWULWikdTebMKUaU?=
 =?us-ascii?Q?rWHzjq66//hxDNkKkAqVEyOf+M7Q+sEJoJvaNsCjVLBH+MR4Ir+gxa5VVL1x?=
 =?us-ascii?Q?CTyHViOM6uFRgcyrrt1SIqoP3QlwUXJTtxflwLAfjo+0XLTNPSRmgwMrMnO+?=
 =?us-ascii?Q?T9xtjKG8oyVoLM2QCojrCiUAZna9UCoFHvT1L+JWl1avz5udEWId91S85O9G?=
 =?us-ascii?Q?fkB0UzIBZYoldHKw9wHzdrXDNm22q/qcCp93EHh9+onVWD1hREuSjk51pyI0?=
 =?us-ascii?Q?ecExNDMvfHASEC2KyuhkOS71Os5UtXBl8sWwl3cxdrIoURqsIMGrgkCVrCGg?=
 =?us-ascii?Q?H2LPt9M2aVg0kaZ0CufJfIUdTh2WMhcLHYwlSHLAQI1RaW2483blyRH3DZ1l?=
 =?us-ascii?Q?Ef8dJRebGkZZM8oyxwgzEMjZTAAnRLmmVfhy6DZM/3FOH8peHQc/1hLvNMje?=
 =?us-ascii?Q?7EMywAPVxYPrCKxDVGhFPPxE2S0tLVgp0vj/mUZUHPifxEp51OShSzJOVDdm?=
 =?us-ascii?Q?PJQog49f/6SARJcig7M4C1DyFXLwAlCs3g0XR0YHmLLO6v1UZRH3y/j+9h43?=
 =?us-ascii?Q?yUR6hsr6ZAmKdH+ttAbU/8QgodAsIG4nqaeKTiTlZIjre9/MEp3Llg8cfKWE?=
 =?us-ascii?Q?hjhmBNncR0/GZ1mraZZvTSHVPeodZy4TS9uXdpivCoEzSd966tgcxg2MjuZs?=
 =?us-ascii?Q?1ZDynHs4av8gPf6GKE0mKqjJl8Fznenr15/n5fB2PdYZgQ3TMVKyriqSNO9k?=
 =?us-ascii?Q?CfUzljQBJXmrtEu3CAU1s8fwMAC2nPxduSZJZj77Z9XmPEtUfX/vQWTBz1JW?=
 =?us-ascii?Q?Vp73KKQieKec3aNfN3sbQKW3EJmaou8+iH9x+D2UIEmPA1nDFhcSWJl9E945?=
 =?us-ascii?Q?SqzQGrlACjUrgBvku82swQT5tFKit5RMhV4jabSrbwhusC/y0lTrm/rckkqm?=
 =?us-ascii?Q?JNeQNTZFHSFiYvdUn4mzEceZ4Lgui1Moy3jxQSj+kt5V1npQoEQxYHU0Xn/7?=
 =?us-ascii?Q?U9eGA6X+XFh6jRag5TkiIQWIzPrPTFJy6ykdzaTJXa1gFRTn6FDneAQjlPMn?=
 =?us-ascii?Q?0F4jbQv736xvLfkXEBZGDCVPH4UFYppehmf6YIgIVR5bhBriXNAjXBU6blcl?=
 =?us-ascii?Q?I/L29NmUkxQR7YneGs/3+8PrIAEZIjJYegsss6C7MPdfyeEjJ5AGYlxLFyaO?=
 =?us-ascii?Q?nF52wbWgH4CHo8NuEf3vZGU7kTuxyYnCQ5fxsThJ83iq9rzvjrhiO23gvZfC?=
 =?us-ascii?Q?+IFi75hZ8sHFsEq4HNEGwsZEbMw3Zu41D2h97V8hg9gRUB/eGUDDFUZqLD54?=
 =?us-ascii?Q?kUWxX7EVonAcQkJHCQlp0q+EKlGZK9+RazeH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BF2CxZchKfpzil3Nl/+MxaPauYKVDXwQ+t4DTcdHZcjHNuwtgJwyqFodEf5b?=
 =?us-ascii?Q?gxDQ9DlAYYqPjNf9DWlAmwL5vN+d7Fvw+FI0fEv209Zk/6Yp1wTKF7KmiX4k?=
 =?us-ascii?Q?yYr8hmPcwzmvZ2Ez57HnHnJRJxPgVjdWtD0Rb9wBcxL5ayeuiFTsOcEzWiP5?=
 =?us-ascii?Q?ZL2Xo3M1MmuTjGml9atNNR9OBT6tt1O0p91NI4p7Y+rpF5AvcVsi6c54Ha0V?=
 =?us-ascii?Q?X52lmrA8UMSUckh7bFVulWAQ5Y5j5TclVWvrhsc97xwHgpcXeyQyZV6tw7fN?=
 =?us-ascii?Q?AKf1GvwKwSJPfI5nbwgtgmCn4CVmczsUyoKARohl9IEMhpzfIU9ejIv5AcJu?=
 =?us-ascii?Q?qb7tBCYYT2hs3y5F7P4EKVcbimb7R3yugOSD6KUhwPU/SBpRcW6QRd2i4x54?=
 =?us-ascii?Q?tcMHEYyKKyAIkZj82yxkNSc36n+rIT9TKhxigJb20dFfc1TXahHoBe5gAReR?=
 =?us-ascii?Q?0sIB3hr+SjWCOmSxmsZ8FVGSsR8qWQnCQQ3bU9sVke3hyhRmUhEzchbdOpPG?=
 =?us-ascii?Q?GaeoRt8R34Ijcpptp100Qk66+A2reNvRBGOdX0AwftqefiB9ufbqN2ztqB6M?=
 =?us-ascii?Q?vrRmPcg5pPMAAgbz+qS9dUaNoq50zYWT+FllJfmct/o1titNi7COWG52Nmt2?=
 =?us-ascii?Q?0tb6xEBdNzS3cXo3zcL2zIwSvg1YkMK5O2D/ybVs8nJaksqWaaV4MAex4LpO?=
 =?us-ascii?Q?xeS62vIT96a8TgdpZK8cZ535OGPbDfzhtZuPtns4MB8UoA3FgMVbUGuekrGO?=
 =?us-ascii?Q?Np6hVzaaQbe+BzWTXTwBDW4E5MXimUnehyYMaSNhf4Ivnnw2m04doJs3r6R4?=
 =?us-ascii?Q?PouP2cJZQ8YfMzf9lSKxuYu5PJYiVy8zkGaRAaQeNHjMZnpeDf03TzV8mZ0w?=
 =?us-ascii?Q?5eTpaQMpdVUP18qhrsbDqttLLXSBWMcEo42ufzDBAtI84YOvwy29L4aJNk6y?=
 =?us-ascii?Q?3m/R0YAXlRFv8E6cKelRSm3at/Ub7+OgnW+KparjIGdhzk/iIsyvKPpDNdZM?=
 =?us-ascii?Q?mI2oS53e3FY4O94MiWqgWAJ7iGYvvuqDRQ0WmN8gX2rLbCQi0d8GkS9OiJ5L?=
 =?us-ascii?Q?gjfTcbSfkOEXpBZHIpwkso/wntJqzVitlLWj2+ZWnGfPnMknPIPAgcmTRo61?=
 =?us-ascii?Q?G1pO7Ic+VcKMfPDvbAMpwbBk4CE9gZ7yaLV22P8lZnsQAYVX1fjmi2yoHzcf?=
 =?us-ascii?Q?kWY3csbmvoSPiCv5rUCMiIWTgM3t5QJjHpqV+zOrXdkZsJZgiCBqeWI1rTMo?=
 =?us-ascii?Q?CE3ebsx3YQRE+9AQ29w9TlX2qjXLeiPswSIPDeg8zpMhu01kQjIf9IA2ZSqt?=
 =?us-ascii?Q?1u/mKeh1Sng1TghjrcVpCP/sTYmZxvjIlL2WUfC0G5FxBPw7HruK/THNgYYo?=
 =?us-ascii?Q?N+ds9TUzKRKf9EdULe/LU9O6nNT7WHW5YlAIVoT5bKjDFQpFyeLU3NYTwulk?=
 =?us-ascii?Q?mbsa30Cmm9EyfU1ZoJ6FGFS+7wz9Xeuy3eNQ6Gq3ggdq0RWKmPEqV5dG0qC2?=
 =?us-ascii?Q?I6q5awArl+vh6//OUt6aXcB7uRiOdYmAKv9Q7DPC+pvsRfjXvNM7CZcm3HLa?=
 =?us-ascii?Q?JKMQ3JzK3NRpxK5+woBVzqksHWCsVz0N5JUL4hgtz/vZ19V3vhc4isJ4gIpQ?=
 =?us-ascii?Q?JI41ZIALZzwC03aqOEKM+w1TQpNmlv+BID3Uznj3JkkvqVPdPcvMxrrzpQyy?=
 =?us-ascii?Q?OoEN4KsNaypbYRN82sSSo6H29q2Mfr/1iAMJdoDVY6pdasXeA5+PPhnd0vPq?=
 =?us-ascii?Q?L17oJOvX8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6c7da0-6b6e-4e7d-9a00-08de44dcabae
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 00:12:49.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw7oSUTAghJJ/627b0DbAeTggBAsPfmdE1ZX8sWOIIUj8YuEyadL0+TLov+rZlSimXML+Tss2XkaW0UZJvM/cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

This series removes an unnecessary wake path (WakeOvfIsDeferred) from
the NOCB code and adds debugging warnings to detect any potential lost
wakeups.

The WakeOvfIsDeferred code path in __call_rcu_nocb_wake() attempts to
wake rcuog when the callback count exceeds qhimark and callbacks aren't
done with their GP. However, testing proves this wake is always
redundant or useless - in the flooding case, rcuog is always waiting
for a GP to finish, so waking it up is pointless.

All NOCB rcutorture scenarios pass (TREE01, TREE05, TREE08).

Changes since v1:
- Split into separate patches as suggested by Frederic
- Removed the pairing smp_mb__after_spin_lock() in
  do_nocb_deferred_wakeup_timer() as noted by Frederic.

Link to v1 (RFC):
https://lore.kernel.org/all/20251225074451.2405584-1-joelagnelf@nvidia.com/

Joel Fernandes (3):
  rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
  rcu/nocb: Add warning if no rcuog wake up attempt happened during
    overload
  rcu/nocb: Add warning to detect if overload advancement is ever useful

 kernel/rcu/tree.c      |  2 ++
 kernel/rcu/tree.h      |  2 +-
 kernel/rcu/tree_nocb.h | 53 +++++++++++++++++++++---------------------
 3 files changed, 29 insertions(+), 28 deletions(-)

--
2.34.1

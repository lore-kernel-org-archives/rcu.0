Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996421D3D6;
	Fri, 18 Apr 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992971; cv=fail; b=ltRn9y7KsUIMYxBZRb/p4tv26P0Vb3FiwRC0vYdzB3QF/t/X9g1WMIC9oYl/bIVOaiCzGFZ/K77vFdHZlVQ6VDew6bJiBM3bShplhsFaMlB7azAQkBcA+0bVr4ym5r3wruicbEZLvWb+sppRLv+JZ0E0s2brtrdtzzQhkgcQMH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992971; c=relaxed/simple;
	bh=HSX9LDgyHGraA41a24c2ASLhimsjzF3fVe0DB3SE7NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fx6BbqA/I/JvhB5a63jDGVto4WLxG6v0ynmKZXNpMOToopn6q6eArzVE2e3L/0C0Khqfz+5BTBSmbCxwXgePmRSqNvWN9iYP0ljtYmFstAFC/52SyL7kwPu0exAvwmkynXxqHRAJP4vYyRquVszmUd4KdDQ5o5Y8XvB6d6IDU8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dyw0EjMg; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dyw0EjMg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox8DLrNE2dEAmOIrdgkY/GJHmp9Y4pRZrZTTFVbDwYYOSOBUPJTwJ3mqr0B+eQ/ZQyCrP7rOmDop3DvR77+/aX52IH7mp1vNQrOLcibbwRa7HkGf4yl/olqcP430XykFHjaJu1EL1HBCaQuDzYPsLfum8PkAfsSEqYpBKBqtFu+bQOxm7bjJQwN7ai4r1yy2qo6/KU4pi6la+AopeX/jzbv/i/lZdiErHoWdLRRXF7oQBtBQ/fq1rgHo5V7tWZ8ag7phGX5Td1/E3Fr73BT2HNiG7NFKkvtZ8CSg331TQzEkxtMDVf977weyhua/YldtL+4F6vjAnXm3hygHPTabTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nvl7CrjHMOCk+8WguhJUJV8GNQyqk/gFZVKFlQ7cQD0=;
 b=yYs6Rly5UEens7k8vbad4sHcrQ+a20Y1d8cfR06xX6kkgo1oLDFCkT6KBKPkPxK0dMyUCwFv4RRbq3veIZUq1Axz75KXd3UROaaTfRrSK1XMTrIP5kuA4Rtuvaj7onPuSXBUhvqh8lLzdr97k/+FbC/AEBMNVJYnVNEDe4b5tT/twyPUeJqHbMeY9I2Jmdxnj1hbg3LHZk85/EIMhYvgebQvF5dT6K2utSuESPjwFqcrfKs8GDWg9VwVqbjYOJG4VBbXceNcsp7+C+UN63CKf4nVsUPwtAY691/yeU5elE4MA6iftVVCr2HIYOZwByOpCRJmKRdMAofGximtTuddoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nvl7CrjHMOCk+8WguhJUJV8GNQyqk/gFZVKFlQ7cQD0=;
 b=dyw0EjMgHUivD0T/AvWrxkVtGwElrBabIpeor1iZlMrCeU92Q1fQtbuiyvkxTA8JxSaVLHyhUl1baoMVuzL9CLmyFYbHO+Edp5Wi4+/V1nKhc5LqbNXvn/ti0VkAp5gKZUosO2Iwpm3WLv2iujxf4M2x4Ep1RZjTX9+ZaRT8tP0QZGLM17dgo8x9hQnP9Kt3FtoUT1p2oYsttPMZtUV6JuH86gbKJIB1vqpfdkPnJ46QIUKDs5CJWET7GGasTYFbI839YKn5jPuSYcEJD6Yck23//nSdi7/r1MnT8IWd91lowNzo2C/vPaB931/3bNhibZou1H5T3SVkJp5anRJ5+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Fri, 18 Apr
 2025 16:16:01 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:16:01 +0000
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
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 5/7] Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"
Date: Fri, 18 Apr 2025 12:15:38 -0400
Message-ID: <20250418161542.2429420-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161542.2429420-1-joelagnelf@nvidia.com>
References: <20250418161542.2429420-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:408:4c::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: b5708783-a93a-42fe-0e36-08dd7e944f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TytYuqHjvlsuwdj2QGZ0sXJHgujGPCXBK/iUVdi+ccUsiJqtosHBJoKjd7fa?=
 =?us-ascii?Q?kPxUtrmBjG/ZDCu3Bu+rWbrS1wLmo8gimua48CbadshkG9IiVcAAIlw0XCuq?=
 =?us-ascii?Q?6rPUr6SD25SDm2erwD8C81kFPT4eiy10P0gPL/meOIxbpqeEgytnqs7XEAUc?=
 =?us-ascii?Q?E3uzTGZMAk35t2WWOEmETqMwUU2d8ZnMOiRWzlJVceNX142IBaCbhagnaDq5?=
 =?us-ascii?Q?6mSjX/gUj4TDHhNc4sta8kgbWYNtfTW23bgLPdw2GfTzDqMyodMkRt64UOHN?=
 =?us-ascii?Q?urKFOzRcraKC2i7eHSqTIlp4n6ZCPGEn7hMrR984Z9V6tj5oornIpw2Tuh0g?=
 =?us-ascii?Q?POssLbMdiJaD+RIvHR/O6q73aW1HDk9F2i5JdAIfFfaTbe4dzv85JPXNy5j/?=
 =?us-ascii?Q?yAA7ZW64UhvxgArbXdo5UNHHII1APMMd9/wSKmryR6SE101p9DEXgh89mkL3?=
 =?us-ascii?Q?MWJt6rQfenPTN+vTyXqcHYiQnc/mY2GjoFNvzPVVYGtP0bx+ny185/424XA+?=
 =?us-ascii?Q?4sFV0ZfoaWOH5WroVDLCTaYwfJux0ycNlkoLIPPeGLqBcBNcqMrFNBOl36EF?=
 =?us-ascii?Q?8rtHqCN0zx749oK+89lXxeRY6dKK901CUFtgMgO9MNe+vucRfJf2Gn/g+M6g?=
 =?us-ascii?Q?ZqJ8oiTYmqVhmXVuo8mc3+D3joeB6MdQW81UgpBRsRCd79qtwLeyg9sfD8F5?=
 =?us-ascii?Q?lspzuTsqVOYOIHBO3lVLkbkbvKSWxAhno1l2tO/ikIT4TFufrjCHt1MuvPVs?=
 =?us-ascii?Q?ENipEsv0TCh3P+E9oIj69PKSHj9HZ8InEnysPWOaHTQZRFMiJr6VWlgf0NWx?=
 =?us-ascii?Q?lyz6aAHcQTdJisbGARnF9cminars8TMjNjoAfULlP/c2iea5eAo00FPqlzn9?=
 =?us-ascii?Q?gxOLhqthQjwL9mXPZUP9rQZMKU54ke1s3tU3isN4uhYqYJS7qexcY2Jv7S1K?=
 =?us-ascii?Q?5smuUb/Jn74YTBXPVDpRS8kDOGnedMGpOTHphaARfzu9QWxwzdYOpDetUzC8?=
 =?us-ascii?Q?Ph3yA0v4TlTq7YJdIcZljxd/NyQl46GllOOpX5eu7d1u7/RocZfUklZPTzFX?=
 =?us-ascii?Q?pGNgQw91U9+sXV6NLhY9w0IIuMKqhIZbSBKZENtQB7wHzZuPGJqKt5oeLWKq?=
 =?us-ascii?Q?8Ax76iPVu8CscFqTQ5HsyDaIgGpwX5yHmjeLJ5TP24dJKSinZnjIrPK9kh1i?=
 =?us-ascii?Q?cCj1IReVQr3YTAw1fWMEBB72gl7L7CC0HDMrZWXJ25fARYrVamgWIktXkZeE?=
 =?us-ascii?Q?WawGH/Fi5LWn284PEwbapagG0Y+yG0rLsZagmsENGduVbhbQVwZINOYurgaL?=
 =?us-ascii?Q?3pwEYH6T3f+q/bdn10x/HNgLnaA50aAdIXm+CpDJWux8PYw8FbaIKkxlURmb?=
 =?us-ascii?Q?VLLGhXp40eAScKKU01KNAx16HXNYKWRAMBMxXOyGMg/3m5iHAAz0DuEXEFEF?=
 =?us-ascii?Q?GOO7LNYTEa6rHJB/oeaXF27JwTt3P/nUcWNWszp+ptCeK/oG9s3z9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZV/Qkvr2Kse4aO111Mpih6WOy53k3w1Hg7WkzhN7to/FBNbMnO77CpVLRTG?=
 =?us-ascii?Q?NL7ORSH2hA+uW88V73+HvbZ0HxJQ62aTfJBS8VYJMymu1n9naDlWIDBtkdu8?=
 =?us-ascii?Q?jiTQEvg3vuVeJS6ftpvzrzwAwIobHQfGQH0b54VboOtEM+serHLjdJ2xGA91?=
 =?us-ascii?Q?Wkrgjezrb9zcmt/LuoA4LBRta+3GUDLR+S6okiqZovnE84FMHGQoEu+lhVfc?=
 =?us-ascii?Q?gVca1yYiwA7FNDi5P3z/iNCzPKkkpYRpquKV0ysH4FLgN16ulQEfPIAXGnn4?=
 =?us-ascii?Q?5IKhlOX4MtIk8RHNdVrqpUFSmt1v5VUY21zXAEybiGwvIP9Otwd4io48MahK?=
 =?us-ascii?Q?FE2NvzqBviLo8sNDjAZPCRCFxO/wMaEoVygTxWsXDzHw5D2XDQcDwEis+PEL?=
 =?us-ascii?Q?TPQY3yS002YwwYYt8EucUld6KKl1Nw8Nskj/YPr+Y0RqTff3FNCH8jUDtM52?=
 =?us-ascii?Q?I+rW6G8kETlznqM6pIV/Zbsz0KKP1rs8xld7VqCVgbikVuJolB9hcb2j4993?=
 =?us-ascii?Q?M1EtrjkvIIhvpjLkMOGkNFKOFNfavtt7JY7yrZOZXfTUmixxVG8NiOfP+X5h?=
 =?us-ascii?Q?xLlDAVjtKUmbMKry4Zv2Whj9SdHlraBsZIqPVnQye9urJyKcOp3ypIM/MZgq?=
 =?us-ascii?Q?o0Ce/tpf6Rw6Sf8lZMRWyI6GOQfdC/W4+Wh9aQk5VsuIoLOBndewDvKQYfVz?=
 =?us-ascii?Q?mjAGsj/w18pJH0uD9VZJ1XdLdMCQBwpQ7/Ul31iiT7rCtJOoFwmBQlO40JZu?=
 =?us-ascii?Q?vLQNrtdHtA6oHiImNVRms7p+BvTLjoSoxCwuD5ertXxM+WJW2vJChCPwixae?=
 =?us-ascii?Q?8X/XP9kqEduwGQYEdnVCa9pkIf95PT7WnndRVLXTMDYfUl8MQQ12kJTPcKv+?=
 =?us-ascii?Q?jnsr5TEfHEgtVy2GTTDD5+ABXSuJOqzuUDrTocj7zS+9qjB/Qin2I5QKrdvL?=
 =?us-ascii?Q?k27hybqOgS8leW9Ij/JtOgGqiDjfJjVvdosFoKVUf2UE+11ZrTV06xZ4OaTC?=
 =?us-ascii?Q?v4BwZZB9hNh/Y9wNUNr1JJVCRp3+zpJFRRJZ20aqocTyRaTuA/usSaafjpvS?=
 =?us-ascii?Q?49gq4xx+csYIgl5psTaLVLi4qHiIKtJxe1rf/r/s8bn9mU33mXTe/mMPZ3Qp?=
 =?us-ascii?Q?v11/aF1jTs/iXrwJ69ZQDLgv1pZTPqiOpZKm/aFMheTcnA4S5a18TIsf7QCm?=
 =?us-ascii?Q?q7RsHMR/cyv2nM5qN3n6GxxDGk5m5gqbszMFSxsqBI7GNrSRE3u0K5k/D6/M?=
 =?us-ascii?Q?RJsyLHx2fKH/J1Y5m8L7lCNu15hCTDClrUVxL8kCWomrquvpdyw4Qz6SNL8k?=
 =?us-ascii?Q?19nhUmumlGx+8MhS1q1riJ9RRhtUBJsJ/yUKFZpRz9KddeCeEemiMEsf5ZeB?=
 =?us-ascii?Q?Jo2/HaVxi9SZA4BIBzxhrG3vE8Rju09rJ1v6P174ewfEDGXHoT2Etdk0y1Gp?=
 =?us-ascii?Q?FQCYUVqodokjPAFUXtqIZWxE9mWAc4HA007mtzR5eHwKsSMB4b7Zhx1ZOz38?=
 =?us-ascii?Q?txrR/boxdTmEaKT7wU1i4F3pSrNrMd35UtD/7uqZTX5zDti8TqLn9AX1okhU?=
 =?us-ascii?Q?yWH/lyrWiM6rMSkEBkA9VEMUu4HVKBBLMAmermsJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5708783-a93a-42fe-0e36-08dd7e944f65
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:16:01.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tddAYnT39yld21qeV1N0UlwKBkTfKJvvkp++NrGvig4HFbWG8mM/VHDEFaf9mHIZfD80CD3RpDoXlTl7I/nUqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

From: Frederic Weisbecker <frederic@kernel.org>

This reverts commit f7345ccc62a4b880cf76458db5f320725f28e400.

swake_up_one_online() has been removed because hrtimers can now assign
a proper online target to hrtimers queued from offline CPUs. Therefore
remove the related hackery.

Link: https://lore.kernel.org/all/20241231170712.149394-4-frederic@kernel.org/
Reviewed-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 109bc2df1d9a..1596812f7f12 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -554,19 +554,13 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
-		} else if (!irqs_disabled_flags(flags) && cpu_online(rdp->cpu)) {
+		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			/*
-			 * Don't do the wake-up upfront on fragile paths.
-			 * Also offline CPUs can't call swake_up_one_online() from
-			 * (soft-)IRQs. Rely on the final deferred wake-up from
-			 * rcutree_report_cpu_dead()
-			 */
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
-- 
2.43.0


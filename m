Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44802C0F69;
	Fri, 26 Jun 2026 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434615; cv=fail; b=Fi1Ji0dWxjyjZa5Z+nQf1syiJ+Q+6JsF/UHmhG2rCfW7YYGNSWvAwxHhDEqsXAuL4vTTK9H7WgXErvP6xqgT18OWRazw/jSpuEZITSjJRWfKd7kflJ5iavzKoIv1gA2uDiWRa45sGYWPgEvYRRJIsMN+2lWvDUuH7bZOoHMSk6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434615; c=relaxed/simple;
	bh=/KxusEMELPWEErOsQwqZP3FD3waNIs8ZvCJeiPY6ztE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AfXKaZEX+nRN2ivn2JQ4o0y+NjRT/SbR8lY28uDrbhh6Z/tuC9NqCh/f5i+81Nsmvz9t0pHD+mfUFbZO7Ldomd4v+FDWoPAEcoHGktR0N+5qJkGidpSB5qPgEOaM/mBWYO9g78b8SMivGrRawWZnDJlFo2T5fgu+IK5laSUcw9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMPd33ct; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMPd33ct"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ct2ip+sdylwTWIzdtm00qB4fs1GFCP6J+zkPLlZW8LozQ4JZi9mI8+0oNLGcO1yocSFDqT0dmU5jIF+CjqmO4tqsbjUB5LqaJ7NotLYMbxvrsN3kOzjJ+larv4RoowGiZ7XxAkyhkpvggtwQSUBIZcO0hYbLfaRbvcERP7K+kUaNwrth/yKABdfZ3z06LCha5yotdv62KNZJyF4/qeDQAzHS331nUnsw5X+fPiWl2HmPrJx65AVa02FBqckLKZvCO36GT9ZROy7pphIR7rquxwKDRkR91BlxMS9b8xkAh1agEytnvablGCd1AxF3QxHX9YUroVLmwKDN2lQPjfw4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D1U6u7NjIsVcHTs+EMne3J/37kUVd3oSROddZsxRnc=;
 b=WQzCsieI8RI10IDkpANEX8YQbSdvxSObBVXu3YWBLyl8HARhQYHKY7Aatx1sI0SIYwoSK3+lKSqDmDugeiKaXGqf9ZRs9tbuybm0J5E3a/ZcE6Oy1Tx5fwXUQejk5CWQO4f0aWDvHZR9Z5LA4csjlxUj+rxSXRqll7L7KVZFR1njS8ZFc6Xfn/JNgFC6uZ+jtucRt5z8FpbaTNnfDw8KpK2uZhPRj0Jd/GFU6aITHw8YY4wdM0NAWjXSm19aBL/g5aiC1qKcvLsMv25lioMYeOIyihxt7g7L494ynd7frGDp4mt4y7Y3tWvYCwDTMWGied/wlo+KCE0SxXDMPjr3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D1U6u7NjIsVcHTs+EMne3J/37kUVd3oSROddZsxRnc=;
 b=RMPd33ctqRCf5m4+ktoP8Kik22fC6CgAvLrFlTCME1UvhTMb+PFaZeqsgxTJsSgzFPdWzPCjhnIot5kMgiNVMfouZUk+q4QfvKTOQ+d9/bdjknjBkwzzrSVhsfmkKvc8OqVWBJcSQYdQfStilsTaKhuPdGYeT4bqXQGF6+pWPpu8yZr66ISUPiTOETgwXWTKDUKepbPaAJ+iHGaGnaL7GikD57iEMrkJswoOyoG2+yhqwfL+KrNCvEcyRLc+FcMZnn+Pu0yx+7JoO0FVYyXW8cYBRKOwYk0IEq5n/4Fny2WoDMjzR3hwbBqlSFdtWVi69xVP1I4ids0BmH0p0SYpfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Fri, 26 Jun 2026 00:43:11 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 00:43:08 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v4 2/8] rcu: clear defer_qs_pending when notifying GP changes
Date: Thu, 25 Jun 2026 20:42:55 -0400
Message-Id: <20260626004301.1632168-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626004301.1632168-1-joelagnelf@nvidia.com>
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::31) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b79920b-4b91-46d5-38f4-08ded31be4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4OCgLn7krZcd2GHCkHgPQvJF5QBuu0LrDA05OHgovze2gal8StzYP0ja/a3s3Bguvcv7tvZpt9ITyEPESDhbJ9e7iG/Sh1jys35cIwad9ZdkvAfZbQ2Q++PTwc1q1onfRoR1M3MXSkAL7HIa2l/L9XLuqyqJ268vep1Yh76ex8mRjmdXtVuNl5V4O1woqgcgIpmKx8lene5GTD/enT8bZHxbhHfgTcrs8Xdxytt1ToFZbnuBAZS2fFx+J4BJPLTTOZFJIYl3jsRkfO1awYMwQbx7LZlPo52823T4ePqZinnWQ8h8BunJdoJ523WjFZUad2nzDoQGWt0o6p5uk8295fEoRNv/p/OE3kEBMn5Qtedtxm5QCSSiGKX7TMloxvSP1iGI0y0PAQdGlDxSS2hvaKCRMNeeYhJjy4xstheWkoQ4LJSheY3TT75btdUHNH6uPGvaKWENALtkyzLir1/wMz85FbFN2UhbjP6QRDkW5ozw59LPM5D9nXO8TQgRNtF1zm+tlBhJwjujLajgr4qNkN/UGn0m+bj2YB0T0WScDTxRWgGaVcnnFgYdXWLpCcj9r3jJDWnCbJJTg9Fy2kHN7HQpTS2nCIBDPqCQXtAn+TjB4Vo1qBKt/y3UQdJaTtSakEkAjVF74JQDlhUl+to7CN08rt42LCkB3lUozQc20lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dftwf+ARGWR820+FPBxW4PJ6ty647b7M1ofEbechV/tI3uyMMGjKeYbs7/Ng?=
 =?us-ascii?Q?TUpfWrGAl/qUay5PbPKrdtEx1djP+UjEMQl7V+yucq3HqfSvin9ELlwbPevn?=
 =?us-ascii?Q?TcGp54u6mau+Aak0J5/tXP0Ayuy7qC+gzKqDe4ULSN2wQBbkPPGQbGbSMarc?=
 =?us-ascii?Q?c+n9lMs+qoyiff5vkZUJCYEi7rdXgZpf0GN8hVO8P8SIWR242QJt2QMJw0kM?=
 =?us-ascii?Q?of7EI2ZLrwOuFGnSmzteXzrKMVSqkiJAqFGO888YAALuHxDwO7yOvi45qBt8?=
 =?us-ascii?Q?/G6rO0CPeMYJBUdDnABc9xxMC+Fuy1q2+eH38vXgOr4Chgc/GNIe7YGwR9bJ?=
 =?us-ascii?Q?E6dDLyFlWdB9+hOmKyi2CPLa2FA+Sw61gpDQfxvKx7M9lvizxF7mR6/wZpFq?=
 =?us-ascii?Q?Ku4HA7XO10UTW9+hXcXteRYyBH2Cb6z/wKHtsOoq+RPf43AYDyujRUor7luF?=
 =?us-ascii?Q?OPLm/77Qa2SQqe8ZAbJ6sWPIHTLih2/UwP2rF62YLFjCxzy/oHfbKXEEoFhq?=
 =?us-ascii?Q?WI6k1I3EJEmXotUoyfXEm1r5lLZS8OV5/UsCxRu/+VsCRxZCKmA12OQeK865?=
 =?us-ascii?Q?D4Dhz7s9SmDfRfVFh5KLsdBw3GhhwhSgPldlckvXyLwxhZhrKGQd2vQ4e43I?=
 =?us-ascii?Q?RQXuN5ssB6gi9jG66w2/RCmCN/hlWzRKzWlkeCxtja2rQ+aYeyywGeBaxlPR?=
 =?us-ascii?Q?9B1pqOk8hVbGd8EBEM8nykkpJ3xHOoy3okvHUcZ0kl8F8Tzf4o5+DiGp4b3d?=
 =?us-ascii?Q?Tf6bW+VOWNB8L/uxGeJUo59DwOZtU0YjLvcmI9U5I+zEWsiDnRBB+uSa3cCD?=
 =?us-ascii?Q?fAvJmFAmZ05+JbydYBD9a/8Ad3c9Cle9fG/5eR18swqnUTKQp5FvIgcW5WW0?=
 =?us-ascii?Q?PZaefw/inndRGVV7eYhbX4tE5r3DbabXDWCH8bE3pK/e2NcPzJ22098VfDYd?=
 =?us-ascii?Q?nYwYgvUr4gA5DZIvKQIvarFjXr7Wm/VjVNcu4wKtXSnPW7ZzkaRyORZ+P8tG?=
 =?us-ascii?Q?8oKWOWFhDBsJAGokDUtdizQBaUIrg1/ViUUEECupHbABwdTJKeHSCyRiiKpC?=
 =?us-ascii?Q?485csUgnkQiIYuATBNovQREvAFAUyNl5cQz6wiRwfMobKPfXf6OcKNF4qbSp?=
 =?us-ascii?Q?xGPw2hT8T6BqvABKqoUDE/mRGu9ip1SI6o5DdOW8f68sFhdOkMFuc8JSHRmF?=
 =?us-ascii?Q?KvGSBCul4SCtM5HDFdgmzpMi8K9T2q55ZBIFGLG7ikHOX3RhTsC4OIDx3T4D?=
 =?us-ascii?Q?enKv/T5mykhCvA7BjmBE9JNnLnrnK9bWoyy7a9q5/WGbuCD/PBNh/eHq75df?=
 =?us-ascii?Q?B1bQqwkL3e0PvV3oIo0N03H7CbvQ3GxXn9faC/+js2MBHTuaHAnJsaMkMXFi?=
 =?us-ascii?Q?pxxfTw2z0wQUlPSE7lYNhT3VfEGChMHdJA0qgQFUw/jvWWKYBIjxczPYylY9?=
 =?us-ascii?Q?S0JFszSOXa5qzvyTZc3HQtQUN2qPC6QLZ4z3cpLe2EZqTytglTlbNmC0DGq2?=
 =?us-ascii?Q?ElSUkXpuk16k9K0XhedvuHtilVdwoKr6/aUCZuhqSJx7q5y3GD6q9xKd18mR?=
 =?us-ascii?Q?IXfVJnUmOsFYCpcqN4UVxNj1/l5ZS0vJ9bxilXAuJGZqj/8teTyoLScKt+WQ?=
 =?us-ascii?Q?YuJIAIeXDCH4gBc2zvo+I44OV8pQenKxf9Ri5AdLaxfWW0lV3ZhmxEuJA+3H?=
 =?us-ascii?Q?1FtcmklL3mNQBnF7XyZNzHHAmottZ0afWIZOMPKsvUZ6prP+22FeoL06dB8z?=
 =?us-ascii?Q?wxAsb6RlcQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b79920b-4b91-46d5-38f4-08ded31be4a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 00:43:08.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiiPz8u3NG0AS6/3dDGwSNwNOpuaUoOtgBdc/HPoGqiGJeChjeRjhBJd4eTLYODmG/MFU/SqP7wuMrgmXH/E1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

Prior to this commit, defer_qs_pending was an unbalanced flag:
rcu_read_unlock_special() set it to PENDING whenever a deferred-QS
mechanism was scheduled, but the clear paths did not cover every
up-tree quiescent-state reporting site. In those cases the flag stays
PENDING after the QS is reported, and rcu_read_unlock_special()'s
pending-gate then silently rejects all future arming attempts.

A test patch confirms TREE03 can have get into the problematic stuck
state very quickly (< 5 minutes).

Clear the flag in __note_gp_changes(), right after the nothing-to-do
early return.  This is the natural per-CPU "GP transitioned, sync local
state" hook, called from the GP-kthread's rcu_gp_init()/rcu_gp_cleanup()
paths, and other GP advancement paths.

For dynticks-idle CPUs, they do not call __note_gp_changes(), but they
also do not arm new PENDING work (no readers running), and on wake-up,
note_gp_changes() is called before any new reader runs.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e86a8c0d7b4c..c4352d0c3876 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1281,6 +1281,8 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (rdp->gp_seq == rnp->gp_seq)
 		return false; /* Nothing to do. */
 
+	rcu_defer_qs_clear(rdp);
+
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
 	    unlikely(rdp->gpwrap)) {
-- 
2.34.1


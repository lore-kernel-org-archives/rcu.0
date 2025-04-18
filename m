Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5222257B;
	Fri, 18 Apr 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993260; cv=fail; b=ZCimN6eT6SnlaRgguBBJghSaaNxcjQNsw1TIu8i+MDpDGPdtPDnedsfSwRik+W8OVe5/Y7OTXI8Qm+DXJ6XTbSrHT4WHsWVGDHem1lkeFXdE/gj1hpQIOsr6aOZ8+XuGpz8TlgIwrIpUSNjDVjgnY3JrDYfQ44/s7qPsL70gif4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993260; c=relaxed/simple;
	bh=RQKUPUQcwDm4EGQ/QtUESlr9/0zsNp9hGnst96D4b94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tLEKsfv3I5PYu/i7Vbo0waJG1aCHBH4zkKmz7cqt1j7GLGjXI/O9HStlFBzCTKkRtCa9mHGKL/hvgBSspp9bKbYwRZ+dE77N0n5uBJBHQULZ31a0uOTomXeGlqdidGirmTagmhiy+nGLonmzBUZ9WyXeaN7TYES8Bi6zUinCiow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OVcRbqOY; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OVcRbqOY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YW9OzAPWWZ1aQU2ZtCF6WL9FherBD50bFpgFQNNc1OlIJZw1A/LO1NdUvAw7q2ZlfJkGvtoAhOLHQ/r7cXXgzgtFW0ofEaYsZqcDlUeD7KgLqUhJgQdtaNMws9c5LUWqerlvzuCYgM0q02XQLjmIPWE0h3uSa6cm9RnuhXI2CxmHnLMKjalmD9oi+ESsCclLAwvMtn5jNpLDrvsjcrxE1K+AET0r5hFgi2jCr5SCFeiKb2kMG1C1K44W5tJPaTZ4e3EcD3bNR7XBKiSitucLYJvVFJNDQsUpcRskCGkXHzCUdFywj3LLZWNi/GVe4oC3E6N3SKG5U4e/av/5kfoqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEgHhgyC5sJGqOplCWQAccBopd1m9KgkxQQ8aSAkW6c=;
 b=NN8UN5OCXa+RSKombFbSIhw1vCQfoIT+pgLmeGtsakjTG8reGid64Wwr+HXftx+mNHsgW5cmeokw+uEHpnvdNZG6NdxJsIbkdmsRTI/PM/DangagZEsAsLJ3G0lMqDOSn+XGHknJh+bmUbg00kor0dxhelnHCw++JdaNMqpL8nIF/5A2YEYnjW2XPZh+uyNXwT5ENi/ol2KiC4BsaBqPwLZGozuQ8IWg/qFeoX0SAUw/OEg4egFRrLK0PBhyHnvqe/S5/1LDh2//oH4isi0NqNk2GfC1xg+3g9VA1OYp33urfzGP6LIooWpdMO4iyQa9RB5OGJZv+Fm2GTErOpSYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEgHhgyC5sJGqOplCWQAccBopd1m9KgkxQQ8aSAkW6c=;
 b=OVcRbqOYnXK6fmOAYtQ8ko8TFSpz/2nUYQJwC7vT9t0CE2uX83/pD7C81hGiiMeW79yFcm4n+0gYnIfVOB+9n3T+BOX7+WPAugVYkEsRsFcPlMTHXBiv9vrf8QleAP6JUIGOUhC0g3TMOT6y+ANeii/RJK3IBUKGmVq5gUmCogcVDoB6zKKi8xtDW3z+KwgCcgbjsUK3k6nPnfsKx/1874qTfm6eqiEZt0PEROcjJC8IpguvLPuKe+6z6xzj9T2Gy10a8q+0wfM4uO9YBjV3MFNKgGbjJCyvYYwsAJ3JgruOvz5iO8XPKTdkQZ+KzGmY5ie6Ava6yYQ8Bvkl7UEsdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 18 Apr
 2025 16:20:55 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:20:55 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 4/4] srcu: Use rcu_seq_done_exact() for polling API
Date: Fri, 18 Apr 2025 12:20:40 -0400
Message-ID: <20250418162041.2436282-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418162041.2436282-1-joelagnelf@nvidia.com>
References: <20250418162041.2436282-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0359.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::34) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6ddd3c-b5c1-4fe9-1d4f-08dd7e94ff14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4NZjqGTzrl6T8qJRSv+g59yMdR6NxjCO1b6H3mfNl9UCGMJFLOszlNb04ofR?=
 =?us-ascii?Q?7FNhOdrDJCu2O2awtnytC5+GqTcCTgbocq8tHOXXXGQa5Daa2ZYtlLw8NRo+?=
 =?us-ascii?Q?wP4LmGztFElBeqjrMteUqTpNGGW6kPACRGpKpwMSnw6WKTYBNhly4oP4hPSA?=
 =?us-ascii?Q?ey1VyRfqBOVhrJWFK7HSJOZ335EyuoY951KAG64L54OvhLSAy632MwdEskIo?=
 =?us-ascii?Q?wsWJdCvphb6Sb9XtNK3YpH5CgEiJZEG81O/c5b+c7+hOWS0wZYUUQcsf4pxi?=
 =?us-ascii?Q?5nJHjY9Wn03w4Jv3xI4vY7TcNuELDdBfubdZXrsjJ6A6BtkVdGmax1RvRHqH?=
 =?us-ascii?Q?F1k/hLqTVjEfnT/03258gU9AKm854aTnYzw7HP7QplVSJB8+5e3UoyWlyJDM?=
 =?us-ascii?Q?WuEbwhk5sM3RvkfpGss3KhGx36k6K2IWH7SivN0u95ilfFqg9NifLTOtejsP?=
 =?us-ascii?Q?xun7IzF0DqY0MCAz+mMvAfCiQPS2gsmS5aacRagAZ1J1vH4h2hxVAIbqE4zF?=
 =?us-ascii?Q?rjidiS+w4CAe4rgDRhLBX5u4JEMgmuxkgporRDZtZI8fR4YkJ5tmjftSPTzZ?=
 =?us-ascii?Q?u6bIJln0Mdh0eQKMR3Q5fsFRc2DF0mauKTAhJm5bMeRqqvkQkAwYPE60FMu3?=
 =?us-ascii?Q?KPJZ/B37iy942Ti7ehpnjVz+KxnPQxEELAAoiqs9BsQ1vvPjaq0lUtSQxYyX?=
 =?us-ascii?Q?M/50X39NPcEeEf4DVTxK0t/TdTBY76JQNMc9dsyWZ4NvOp+MrowmqbFjuCW+?=
 =?us-ascii?Q?0/ChJnDybXibnPDHXXJVTEJpY5AgmRcW1r58coyCvAkQvOd9ZZV0S4v0xz82?=
 =?us-ascii?Q?MuZmFeMsRj/VexF9IbzY0WFoV7KWIektErOy3A5dG7IJfofZ1nVxVYpEHA/v?=
 =?us-ascii?Q?OV3J4jYwV5ABLMEdB7tvx+Eiq/XFAf7vibYs5THmgI7w4axWmWqs+ijJFp/m?=
 =?us-ascii?Q?XL6nB+y8O1PHntPuVBSheIUzZRiR4Z6Fb57O1k1IfOcq7LL9hWbf1saRfMk2?=
 =?us-ascii?Q?SP8ScBPg8UEeS2h+HHbrDdaUnGXWz06kGa3ivFMUcqZxE/5EhXs83ly+OwYX?=
 =?us-ascii?Q?xUvQXwnAtIm8uSBwnZC2OmWkY7BEpN0lyAu0qgSHn4kHMP1SQuy8TOWlogKn?=
 =?us-ascii?Q?HUBQ9WPi9A7thSHGISzgMCWxzJGCPcJWRZhHWvyOWmrQcFRhAwMqsdDPiPPM?=
 =?us-ascii?Q?0tnUMAkzkRA1R7WhUkJs83Wii27S1dqD/6dJlxTituBUgnNAd5tJJfDS+cfH?=
 =?us-ascii?Q?WGq1VXhqODN71qQs+cUZKCIzB3UNYdf5EwTPgxkgEc44eSwCixa6Nx/Fng16?=
 =?us-ascii?Q?09l67RGrh+ZJOWRS53l+t2f9tprx4Z9eCkrJjClZmkKuMSoDWMmkn82xWAh2?=
 =?us-ascii?Q?ehmREvPLgA8ZE79DmOChIGMILnaRZ7h9YepZnbdl+8LVqq6/GvOj5zagpRrM?=
 =?us-ascii?Q?5JVsmi3lv5s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJSiCdUHfwuPgoeWRspdDbFj+oHBfDnAQAPSIT87g1Jx793cS879jnsN71Tt?=
 =?us-ascii?Q?5sUDSQJoTe1P8VRUNppl0HAseNgXm7wKbzU95gcpvircneg7yCF0mUoSkm7O?=
 =?us-ascii?Q?lDryFk5cMi0IqNLulWrNST7wLEJ5ecwI9sc/aTF2IkS8XA2tiMSNx4GPe2WR?=
 =?us-ascii?Q?mrxgO+NSKax5u30JJ/DhpYtOtKpYMT8D6+LZKR2pWTOis/Ddh8MMt1le183S?=
 =?us-ascii?Q?rOJFjis6bPTeSyVq6WW+h0qOQmp39lhH350N6DPN0j4o55f5gytceONeTJCl?=
 =?us-ascii?Q?MqZQN09IB1+aIJ6Wihm5NC/nUKB9xK4nQLmzOQU7ZReLHDyjftxXBfWVWjo0?=
 =?us-ascii?Q?rsEuXbqrYIBVe+fs7aS8KD9+pzDBGVw617T+yWRMIzA4K5Wlq6RqJLTbtpbt?=
 =?us-ascii?Q?l+8vlqwzvNSHwK/BP45T/vv0ohytyYlxZBsvTyWXactAEWdxUoMz8h1ZoJIn?=
 =?us-ascii?Q?pSzAjyaMc6wMNbRdVK/9CM3QqI86PdL2lwmgwV/Cknoop3iqOIl/nhlK7Zbl?=
 =?us-ascii?Q?HQHxgUxCwuXW7A8ekuMrPfEhGoTYE1Z9hFV7g6AUjc/iXRWZHkQj/pG5YViq?=
 =?us-ascii?Q?f2MlQpeNp02ZKofAw8U2LAT7bAOIS+obQEodOQAvJpbTk56QvwpwV01nlCXz?=
 =?us-ascii?Q?/UKk9zELNkmKyr9n+rHrU33VRF57cCkiw01jAyyT0QmQkKPBEYhN1AR5pYz2?=
 =?us-ascii?Q?b/Qneacr5hhntA88BMi//QN3pcWQtRlMZ4IE2TrUsFLMtTXsYSW9BUrziEQ2?=
 =?us-ascii?Q?BvYc7OIYHN9YoLapZudoZq6Og5fVSGb54h3zhbYFJban9zuxotuiMLkeuutG?=
 =?us-ascii?Q?TdRDvNiyoHDdCI99qt1fGk2WFfmWPYVDFv+6u+5nMmvI/FVBj7q8NEPYg7/x?=
 =?us-ascii?Q?bC2SCyUfz+dY0/pgBxUrHtfwrp/VJEWkA0YfUHssJeCPuLJUZaqCwJlfqHnf?=
 =?us-ascii?Q?DNUNFm8Z1II+NPTdHUrBmWT1vYoyFku7XpK/MN7Hx7kOkzBSm0t6QDriybjx?=
 =?us-ascii?Q?2lwZ2GyHmn3w7JPdl6OKcd0kxwjKYjyb7w96Emin830BimeViCmnqYitma8K?=
 =?us-ascii?Q?Y5ytgD5wqWbAhfYM6LPBnGreh2jDAvb/e102soACZifzj+jnD67zjY55Qgpa?=
 =?us-ascii?Q?gMcaP+FbvxkEs4dJRQdwzJCeYHNH7MOswW4NXSdv9E7ZZJhlCQS52HU8J84V?=
 =?us-ascii?Q?qA7XKU65dPNzQhsfTV66UaZwocz2bAzuvAw2UfvuZqpG+4dSBSYUv1s8two4?=
 =?us-ascii?Q?7tL7LAtxD0BB6qEChvBKoSB+7JbG5/pT8eyZYAwasWM4j4aquqbusSn77zxE?=
 =?us-ascii?Q?9iWXoKjBVLUpWpi60Yr8SaJYn1m+XUOu3zVVYpogroPzpA4Q4xcERh1MIIA4?=
 =?us-ascii?Q?zFvAb0z9FP5b+q1hMPju0aNsAXVFW2aVopnIHY0UYBEe4matLL64oUEwaL/7?=
 =?us-ascii?Q?l1KXTG5mXPyID/zObQMmiXqJxMhD/JtHGrMMjpmCSXri4yo2ZdEGEhFJbtCV?=
 =?us-ascii?Q?HxC2VWHWzP+zAgym0pL8RzhI62w9USzrDKQl1eq4mWDJ2ynTyzr9zLWyaJU0?=
 =?us-ascii?Q?8ncaOA2e2NwDRmq4/RdXc4VnxKAg+sJtqyQVAnum?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6ddd3c-b5c1-4fe9-1d4f-08dd7e94ff14
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:20:55.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMBNL2jVRpjUv4U6vUws4KqABN9EgnjhMqWX58XiU6q/M8Vesdoeo9y6rV/84RFnojgU78dLQkcnqLJyqyL0CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289

poll_state_synchronize_srcu() uses rcu_seq_done() unlike
poll_state_synchronize_rcu() which uses rcu_seq_done_exact().

The  rcu_seq_done_exact() makes more sense for polling API, as with
this API, there is a higher chance that there is a significant delay
between the get_state..() and poll_state..() calls since a cookie
can be stored and reused at a later time. During such a delay, if
the gp_seq counter progresses more than ULONG_MAX/2 distance, then
poll_state..() may return false for a long time unwantedly.

Fix by using the more accurate rcu_seq_done_exact() API which is
exactly what straight RCU's polling does.

It may make sense, as future work, to add debug code here as well, where
we compare a physical timestamp between get_state..() and poll_state()
calls and yell if significant time has past but the grace period has
still not progressed.

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9a59b071501b..48047260697e 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1589,7 +1589,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 {
 	if (cookie != SRCU_GET_STATE_COMPLETED &&
-	    !rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, cookie))
+	    !rcu_seq_done_exact(&ssp->srcu_sup->srcu_gp_seq, cookie))
 		return false;
 	// Ensure that the end of the SRCU grace period happens before
 	// any subsequent code that the caller might execute.
-- 
2.43.0


Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013057.outbound.protection.outlook.com [40.107.44.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117E3376AE;
	Thu, 21 Aug 2025 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783702; cv=fail; b=pLsy6NLsqbb6qCREghnG8dsWTipZUne5/NmbuyEdfhj8SGLWEeeToApQxrZUX3ZrnAHccPCaxRBsJa+1Xyxds5rnWF70ui14TwjF6Xbw06eVpWpDsI5iLRcT0y8W1gEcPDTdQhB3tShGyaWdZU+Y+PccpGy77UrrRgaIUeelw9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783702; c=relaxed/simple;
	bh=mS1m5uivoI4tD40RLXOMRVpYOZXeBtlLedazA6lA3WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dds7TJhJ/G5LgfgRU3c7thFHeWvKFgQQFjmHZMhdG0LXwWBmSyLXlBi2XmHBJtLBCxMlv9qjnkU/CQ5NiIEf9VhHBQQznX98ZLSE5PofN/o0/edNPz1xk5KR4HKlt7vy1feI6eD513lHi9lnKdcuNoinQHneMAZdRvohp1DlhMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GRZc4T4n; arc=fail smtp.client-ip=40.107.44.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GRZc4T4n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kni8ZOK+qWFo/4rVZ3hpYmH7m22iDCuSjyMv9pOvv0BHWrz6In8wp0TuZ+VVJv3iDgri6p0wpJvCOkVHn4ym5WmdAJaOuJkSikQIWZutQVHlGrNMpgsYe86NVfkjscZUfsaPsfX3GHM7YNFapxJ/wcGkvin87Jg6RYsyUIknzeOFacvXa8JPR760RHHa4+lPCzehx++UFRftsQlDyqpv1pszUvoxFjgAKcf8KHJ8p1NpWn26rJG8pNSYA8jmu/LgW3tEaTudpqfXI79cO1j2vOuvXZzDda6uNEJoyFWc9KMNNzj4fEhJaNxsXgeLHqQhsLxQo07jJ7UKIJVjm3fhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrUp3JrPF1PaIAJ0ECly5MjFT9ddJRGFqcLv77Q2Ums=;
 b=jZ3EJMSB3eff8CfY+c2qD8t9CXugxAs7LYLnhZlva+czGnZCaNhVVruGQvk41GY4x3lCWQNrblpwv1c1RCJ/XkP5Fmv6mZ+EGt9Ztq7E0C9uvIm4M6DoKerXTqvY9dMM+5oXGIktHHrcPfkPD7+82drGG/4k6AYFm6fh6LmLyui2EfYHd+Xjr2rRge4/UyD4UWHspU48io/EmvvpkEU3bUog6zxCBdq/Ee0gLU86yYOXI+fN/KR5XUT/8PT8K41uDNTQ1+puLqXFEpDQWI5gK6OhpQ0keR/QO/soMJ9FFu3Burs6uKRu7uNNzM62osEJ3mbio7BQCaBSFF3KtUhoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrUp3JrPF1PaIAJ0ECly5MjFT9ddJRGFqcLv77Q2Ums=;
 b=GRZc4T4nlEXO4Bx5A1aFkAuTkvYFwL1Lb4J/8aFGGs9PU2MSnDS3xO1XbZzP9crMaAxFEDHfNR9vfiv1H6QZJIB/1agMkIRqGFeadpvPADus627Te6e4M+MHuuo4w1UNjkKLudY35OXv0sL0k1fxMY2dseuzlNjsrs3PBTBameKznRozjNVxwGPo5t397flFix3L8LspRrj95GftnHyHWCYHD2dX7EwmIYFOT16dIlCGjEpg/UvTiFKYGoxJ06HlAkst11MjPhOodTs16IwpRQ6xi+kXpLo/Gxru7P6FEMheLTVZQmv8b+2oGfjg7zuW1xDY5fJ7QFHhKv7YBHb7Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6215.apcprd06.prod.outlook.com (2603:1096:400:33d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 13:41:38 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 13:41:36 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	linux-kernel@vger.kernel.org (open list:TORTURE-TEST MODULES),
	rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 1/2] rcutorture: Use kcalloc() instead of kzalloc()
Date: Thu, 21 Aug 2025 21:41:16 +0800
Message-Id: <20250821134117.6347-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821134117.6347-1-rongqianfeng@vivo.com>
References: <20250821134117.6347-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f267b76-51a3-4388-1003-08dde0b872d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fY8umZVauqgD+sA0w/AXUJoJSXI+94v0c8yTN6ClZpTiTNVhHCtDqGdvK1qu?=
 =?us-ascii?Q?N4FrPCL8OjUqI+qVb4lC7kc0Mf+fEKYhPMNNcWiDBz0sIWHNG5H00h8jyAwX?=
 =?us-ascii?Q?EQIaPU3LckzWB89GXgwQf5IuTNHKEvuUgmJSI8TTMnPtn6ZN3UzxOAGs4jbo?=
 =?us-ascii?Q?jDPL1OfbyU1tii7TomCLjG2Ih5f/Arnv29ul+ErWJ4XRwNEp7rzv3fFlQUY8?=
 =?us-ascii?Q?2qcj90JWRJL4JYCCmcC1lYuplEhrFS0czoBxRgy8GhtYlnJNR3iJ7JVEybeA?=
 =?us-ascii?Q?r9VxTziCEexKydY0beRuOeLZCeA23VYITFlqFXFyUuZe9s91tHx9RGI6d6T+?=
 =?us-ascii?Q?bl6/QqLk4bNGgQ6TNeBsw7QNaKWxoJU2R8t05e2KDfPAGtAe60n8Y2YGSb22?=
 =?us-ascii?Q?7zH4TYNxXnQTd67rzSg6+L3t7sKJ5ATDqDyPnxUOm6QkK/Nh54tBiWpIdD27?=
 =?us-ascii?Q?JU/33H4YzVjAk0jurw1fwyx09iImO46nFwA1uEYiBUKCyXfvKSTtztTBvqng?=
 =?us-ascii?Q?VERgmxi5xO321NCurm+hlHENeFgp7S4OAA1+3dtx1N1l1PsFeUNPLsquwH5u?=
 =?us-ascii?Q?TueFzm8qfIfCMHViMX9WjJf167QmgFuP24mA0bwZMB6RoLFoHE63eRcym022?=
 =?us-ascii?Q?Kv5NgZrMOYKSFWD9sifiQTspGBcqeNqhlq4rpB81DM0QRWWh54SQN5mz0RFp?=
 =?us-ascii?Q?a031kQIkz6TDA9SmbyNV20hf8vVMkM9RfdiqgnvqqPcrje9TMXPqOzay8ZSO?=
 =?us-ascii?Q?AwaRXaWKNiu8dF1Bx0EJdNneFZq9NAyeu/Z8g0K2HFnaux6HKCKlqy6h6FxV?=
 =?us-ascii?Q?YoL9rkLe5iFvgEhNX7AflA1l1A4bDa9ReZjjHJrYHUJj7GCbhF33TkdXjs2C?=
 =?us-ascii?Q?A6Omo3g+2ylssaHyrtlIInFbgszdH+JY2eHEXM4AdQnBTwwAXAt5OaFo49q1?=
 =?us-ascii?Q?oxXJfemt6ui3+NeAznZLunn2+jzS3yU3zLzbjOul+JeHXaRm9Me4jekSwK/T?=
 =?us-ascii?Q?biu9WCFbdGoaDJCOG0E8nR8BXtiSUpY+hv1zerYix6Ug9AEUlg1G+EbMfeJo?=
 =?us-ascii?Q?wT/TVgD/bC5uOfTgm9Y5Nz/NtMzMDmbD2w/+tTSj8Al0bwbhDrn4GU1Hw3Lu?=
 =?us-ascii?Q?Fowjl0sN601ljQO4XHucjOQYugWVTj1d/MKVyP7EHBNRYIpc53KNAMDQhxbl?=
 =?us-ascii?Q?hIaT0srluRXMtSr1Kla5nGNJz8X6Zpo7xRttkWIeN5DUzXBjrP1+kAaKpRBb?=
 =?us-ascii?Q?K55SVSdBILio/032xdbsE9vziYyOkSVrxim9fal2JvRSbEr0gZq8tG38hxGJ?=
 =?us-ascii?Q?+17o+v6Tj1XTbgzJBWDEGBHRccD9xq0btEt9Is/GrtrWq5S1F1aex6KP4rCx?=
 =?us-ascii?Q?GPvPGSHiJHq84C1bDY8PXDFIAunnuEjwIpV/hC9xdjkMaBbx3ONL51Q5kWIb?=
 =?us-ascii?Q?hkMIJQSaM5uYD5HR4bOmJalzwiaaSMMJElnT3EyYrD92LcSIYlOPJI3V4Erp?=
 =?us-ascii?Q?95dRtKygEFmDSog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U03rizvFF5cuk1qLZp0zHbm0UAbeLo0RjT9GQ8L/l7vTnUX/G0ntkgofMQZA?=
 =?us-ascii?Q?cReRoN559pMGXfF44t3As+aZzJU2p+cKnCOstqSXB27xg3ibVEzjHjd2fQQq?=
 =?us-ascii?Q?oOu61iGg4QlZynxDOx9iCdC9hRYzF/pBfpDRP2ZZ2tpfXBzp26T/g3hW+kQT?=
 =?us-ascii?Q?9j6++1Wrs25qGljweX8xgghKE/rkWZ5xYHYidTAolkDpg+UQnQ21Fq++keDL?=
 =?us-ascii?Q?O6uiasPNu+wOTI298lD/ZO2A5hYojqvaj5Jn5eRoj02qps3ENhDuimcfvOI3?=
 =?us-ascii?Q?bPR8b7VoUPWtBM6p5FsmtbzXdc9UYgyAZUlC41sbDwytS4clxCH7OXADbM+L?=
 =?us-ascii?Q?eMj0HQ0mFjwAy56gbqPs7Itc+RBIAjoboAoEfeBeTtZ+tCss81opOfGVQrcP?=
 =?us-ascii?Q?qaeA4jZuZ64PW5t3mCS3T+dgrAFwmdpffM9MgvZKwwWWXzEoUd+KGmdOU1lm?=
 =?us-ascii?Q?AMiGM2m5KXRz6vpNvwz6fwSZROUwGKWz8pBKEJfKzm5mRhC8WGTg8B/J6RKl?=
 =?us-ascii?Q?UodtG794lU+3c8akpDEtSYdtmyU2FTHH5ZxbVbLICkNm50DJbEa4Fi1JfmXX?=
 =?us-ascii?Q?OdsC8pV8nEbBt4UF2w7EGVPafhwe3mJJ3HZp2764eMUIrIVb1P7ile/lMA3i?=
 =?us-ascii?Q?JLvdNwOjPvrOHd98Qp9zicJlzGcDSgTUBOGV6e8yRu8v5N7+NBBfoMfbJhYi?=
 =?us-ascii?Q?MZN6C8dSKy0B9sfNORZ9TgunnA2U/T4XlHOIRAIEFYLobRVBGxUuGxePcmUf?=
 =?us-ascii?Q?8psa29FKEVVc/0o8vdzhtcEh3tWk5HrRiLMAEE+/VBQQ8ZO7mB3CsQAxRca4?=
 =?us-ascii?Q?bsdjPMRFKVx0l5zecPtNP5PG+ccM4fuJ49xzJ3CQr4fi364LpYA3EO7ee8ki?=
 =?us-ascii?Q?KwJV/J1bHpSLE1+ZtSx/A4SNF0DbkTqiFGpVjRZJaC1scQ6NzLy3qdXg/0fy?=
 =?us-ascii?Q?mdn4e70Hr5PQAmFHIaLD5gOFDkRJugvG+hOCj1aFiqO5wlXGOQBuhkUmLZWU?=
 =?us-ascii?Q?JX7rVePNTaPb74vG6rN7s0iZqBns3FvzftqmEsdZMmyHTxYU2Xe3xgsQGo3n?=
 =?us-ascii?Q?xQnKCZQz+ifnO5TwXBO0cduBU8RoT/lUNSpZDInN+fZT4ioub1qP5tPLTRsr?=
 =?us-ascii?Q?yP2Koqfyd6+oB9X5DxBU7i1jTkDYHUbJ7IhwZkERHYSXtBjYVvHJzxob1I1+?=
 =?us-ascii?Q?tlku64xBqVINnvMN5hPv6Skoo4GrW6r8oRC8OmOmdsOSra+bqa15eOl1v7YA?=
 =?us-ascii?Q?UD9tRFN26FENGnTNGfoUpyi5sfnJQrno7vXkz3nFU92tc+dHEqfkjMxfrp2y?=
 =?us-ascii?Q?2c0AceQYo0Dokd/cEO1vVCjCuIytDYiACXTiTaeiMpNKRVp3X6BbG2HlvEVk?=
 =?us-ascii?Q?hPIAT0gb2Bd7AvNBDnH9dq/SGQ7HXp4dtwzSIIho6PVuKhus9w20s3j8T41f?=
 =?us-ascii?Q?EH3VjV8SUXD79EGgCj9ZHwBlcgM2eGWP3LGQGqYVtXKbQwhTnKsaqFuG+8qp?=
 =?us-ascii?Q?mnzBD1sUMdVRrHeadWK/aJ4NfdcplD5aQyrGQ56r73UCQZsu0U8F/+3/Dezs?=
 =?us-ascii?Q?Hu1E62QnlYZAUn7fxtzl9HJiVE3uV3PgWJqcm03J?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f267b76-51a3-4388-1003-08dde0b872d4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:41:36.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCPUWR8RpBV3yH+E3iUZkRao4r5m75sbKdEhTBDxWsbZGC8WjGYA1P2o8enxe730bHR8cdPddr5LPEsHLenZRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6215

Use kcalloc() in rcu_torture_writer() to gain built-in overflow protection,
making memory allocation safer when calculating allocation size compared to
explicit multiplication.

Change sizeof(ulo[0]) and sizeof(rgo[0]) to sizeof(*ulo) and sizeof(*rgo),
as this is more consistent with coding conventions.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7a893d51d02b..60cac761efc9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1571,12 +1571,12 @@ rcu_torture_writer(void *arg)
 		return 0;
 	}
 	if (cur_ops->poll_active > 0) {
-		ulo = kzalloc(cur_ops->poll_active * sizeof(ulo[0]), GFP_KERNEL);
+		ulo = kcalloc(cur_ops->poll_active, sizeof(*ulo), GFP_KERNEL);
 		if (!WARN_ON(!ulo))
 			ulo_size = cur_ops->poll_active;
 	}
 	if (cur_ops->poll_active_full > 0) {
-		rgo = kzalloc(cur_ops->poll_active_full * sizeof(rgo[0]), GFP_KERNEL);
+		rgo = kcalloc(cur_ops->poll_active_full, sizeof(*rgo), GFP_KERNEL);
 		if (!WARN_ON(!rgo))
 			rgo_size = cur_ops->poll_active_full;
 	}
-- 
2.34.1


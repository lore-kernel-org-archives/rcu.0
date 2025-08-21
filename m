Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013057.outbound.protection.outlook.com [40.107.44.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46473376BB;
	Thu, 21 Aug 2025 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783704; cv=fail; b=AMGiVNTJVV4Bs6VChC1uHyE3GJw4mymfzZGKbPbuMjgv6wc+a/gxQBQhO0/M15+nKNkVzty5wRkt6Xhuy80s9R5OgATFfn8Efmw0qs+IWBpfIF+djAXrTFChh+0cbd7vOoPPcwVYQ/nQlQ7Krywaxkxn4Ir1OAnRK0rv8BPaxXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783704; c=relaxed/simple;
	bh=9+Ym2MgmqoMIC+MjY8EoUzgvJ4sgYMohfL6IJEaJxZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oWDuL59BLZJ4oihDeNoyIjbtkvl6GV0TZBizUMXAbka74i0zlb9+DH6O5HgZ1pVZr2L7E3v1Y8ehEOnXE44WZMpByw72WGF93cF8oEJGq2Pey/uZimvmh34l8ldOAxMvuSGAHvRf+JxIC+7RRM26QKFVEYsMTtdFjeUgwfbWrYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dvqrnUBo; arc=fail smtp.client-ip=40.107.44.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dvqrnUBo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ct+n11QThQjE0A+Q6X4zbna65o9uEBep6aXcmgVYzeKEFrg2YP6U+hwknszjtYsXL/FKTBhpbmxD3z7c+QlmqhtpfFJMw9VHrpHf7nt+OA28qvQbK5AtQGt9HCaucVubVDAXdt6E3CyxXLKzeDaWUlYhL1EAxYt3JbfkJMc49B1vK/DUSGpMwmUj3qk3/gts+uTrRCrowe0cAnSH1GRjwOUqHtPlpzazmh+LfrxNeS3ORcYXv9q/BhD2WbbGJONNI/6Wsv2qN9+qaobBBagZAWaK9nNknyK2IS4L0eWLfBX9pXoPbs+Mt5+oMep+ge+Tb21SKgFaOVmi87iAKxQvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boF4xt4TAk4PeYj28tHz9T3pExqliIiACzlUxuLO22k=;
 b=B9VZvPS2cUGmZSZfgnTPLjkuKdhraLPzd9FaHtZeaC722q6p48MzzFYyosLYjlU3zoZS4tA1YMoTykwgALZeD7w1rJ1qfZsR+2Cpjmxlsd/m4PcSVO8bi4Fq82jMlATWWyHFOB4NkgsUyHmYVMGB9OprLOlB/6b57KZK2cnPSC7cTOCYgp+n4Srd7ObZNowtzHzk1UE7FoB2ChN2HwYA1di9NnsDPWin8nn5oPJbsaX8KtV9ji15nu9B7u59QBpVFKPk4l48WnrmUbUKMMcO3LiP5Brct0PJNqR1Eeopr+HnON0F1ZDmI08UwId/pAiCHpQyL+Cty3kWpO2ysIvQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boF4xt4TAk4PeYj28tHz9T3pExqliIiACzlUxuLO22k=;
 b=dvqrnUBooQb/bPVUpcECZ1VyzJUEkG/o1DCmvf17HxtNyKkBcRKskjDL7lwmIv9BjDE3NXHp0dGvw3tJz5Vf9DF9CN1wX5zW/Xg5bDHn1aQ/JRGyNg8CFYSFkdpFJywiYe2QXEXRjfyO74I3qVqB70JzRkigAPKID/MAfFi/wCnBIX5/x+3LNGb2+X5nP4g7wuWNCUE0qstuNhrXJcGfC/p9LJs9x71+XP7FfvFvGLjr6UF8Z/Z8ch8nlbxWMF5NkcuA6iSxkZaNH1GOHc3WfUvny1QLXFpzKLkse9HD/TR1Ppe9Y1GVhnuHt0JpAr0QmFWi22BAQPenMWnFYj5QfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6215.apcprd06.prod.outlook.com (2603:1096:400:33d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 13:41:40 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 13:41:40 +0000
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
Subject: [PATCH 2/2] refscale: Use kcalloc() instead of kzalloc()
Date: Thu, 21 Aug 2025 21:41:17 +0800
Message-Id: <20250821134117.6347-3-rongqianfeng@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7df98ef3-a18e-484a-374e-08dde0b87538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BkoA3uqLH9TbHhw0vFHxXqNRHwBfVuUJjU91S+jctI0z4+3m40re2F+4Pavr?=
 =?us-ascii?Q?W9sbcnlVi48LsKyFjmaKKVbn/ESWj4z6RE5FEbEtJSqJO1Nfb0y5f7wVoQc+?=
 =?us-ascii?Q?WTbMYSyPV81O182bFi2TdlmX+rDGJrFAYw89fosnH6OfVzIW/6A8dgmHtncz?=
 =?us-ascii?Q?ISZqRZZjE4KQt9HF83Vc0oM5YUwhoAoz/UDqW+m19IIVUgzrndX6EPwaRmku?=
 =?us-ascii?Q?n0bbgipy+9SbyzzjX1UzHv8I056WfG1tnpTuIbHtvWgyAI1fKe2jLM6YXMlR?=
 =?us-ascii?Q?cwNSopGxszNA9WhpDFQanqcZg293BMd0LFjDh5I808DGRNSRzMjGFAlY6Yc/?=
 =?us-ascii?Q?TCw6QgyIEi2IPvBKvgHklvxrjr1iEOOzXaLUBQy1CF6OYvSfxmArOBNcg54V?=
 =?us-ascii?Q?MlLkHWxSiTtN9Ghtn0zsrlUhekfeO7Rgtry7cLbsUff7kV5VrTRBtIolqc1Z?=
 =?us-ascii?Q?jpz5pbhKEj73MVWjvaXBbliZfaMYik393OhwMR0/ffC8q/Y10PUSDO3r02Ic?=
 =?us-ascii?Q?nU6LIxwEz3h6B8YSzYK16IWpBhI2GL1BHi+hLdsNJ8Ag39vDCOZctwxsCI8a?=
 =?us-ascii?Q?rclC5UlGDLqvLa+Yar4COK/VoFNsx3DyJ+5dYJKnDNlZVGG3Sf32iyFYZjEu?=
 =?us-ascii?Q?/1yPJpnXO6hX4WEtsWUGrMhuCmO3yF/CPAtMpGUSOVKrw4SasK+QcS1cY98s?=
 =?us-ascii?Q?G11pDkABwES/AEVknVsSd/n0Sn1Y5So37fSLX0R9vNeXx2yapce2iF7PIpyu?=
 =?us-ascii?Q?WZhgrClag3in/4kleprlRQXJrP2FAYonpWdmyo0LNZTbnocxaIaFs0neNiqH?=
 =?us-ascii?Q?D3NKu+30CXZLVBTMnSAC9DeW6ISIXHFWYubm+AXrqFkp4rJ2ZmroZuWVThIo?=
 =?us-ascii?Q?qRIv+ity9r6OHst0VGteh3u06FdJo13HAABIgJct3935F0IETIB+fs4EqiD1?=
 =?us-ascii?Q?yVKSKITWy9zipVltIOi5WR72FukRjTVmpB/cGiRZ9FOf54Dr8jPJd4hClgqE?=
 =?us-ascii?Q?7doIjm1TMZNbtACxzDVBuAFngFV+iSEJIPUjhqanF2KIpX9CFB70yKzAhZnG?=
 =?us-ascii?Q?bHqGEJzwtKdMvYtIg8k7fqfO0vX/pDw8o2PWdO5jkL00GldSejuaEbrFkWrj?=
 =?us-ascii?Q?FRvYWpUFdFk46b5WI1JZ0UAxCjk0NhHkHQczXGJKJGRf6bBADpEc/aEBDLov?=
 =?us-ascii?Q?klZjm/5iApBvd81zOfPzOGBJ6pYF1CYRMUGzf5YMrZnQGFlLkaPFOKpVS4kE?=
 =?us-ascii?Q?RRuNVWolx6R9ADF2gOXto9jXElnSbUKigsndx2rnI9YSife0nlK+01WTV9TP?=
 =?us-ascii?Q?KdCO/Evp/HKRzfrBTuOPKqTxWuhx7/X6aCNUgiBvBtECwqEcl04EEGoXP27I?=
 =?us-ascii?Q?txA/XdHxnDQfiOvlpmNGyATI/5pijk3s05xwN5QL3BqjXs7VVpzHVSZRE/kA?=
 =?us-ascii?Q?Ni0sk6V83zADlnVrNs09EvifMm898x1BUIgMpvncQW21BBtun+K02eGXJF8p?=
 =?us-ascii?Q?E5NYyiCFjtXp9Ro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eVivhCDP7lDwNneoCT70Uy/jbLMq3ig/LXH5MyHiMAxMFUwOZiGmIlMECML0?=
 =?us-ascii?Q?jABe7OdXTWiZyf/B4TqTOguPnVg5FBaCnnSqyg7BhS2PjBQgswqlSCxenFAz?=
 =?us-ascii?Q?wvwfHksQZK1ELAeS3sCddore6Se54qftiNbFIgR0/yXVm/dzH+y99z94b510?=
 =?us-ascii?Q?iLuF/n0b8QEwA3PbI0UrOwDwA7vECzoVpfxk6RK+EYd/TuYo70CDmNPMia0Y?=
 =?us-ascii?Q?IvzlzzWX8adh0d6ZwEVZe6fqVL9NF0rZCX+ba7Zb+v9bKGzGwp9JPkfEI9ZA?=
 =?us-ascii?Q?tHt6tgVwNTiAsgSJPTvbL1Z15+m5euihH8FtjsikQtq97FwLTkRBgE25qcVb?=
 =?us-ascii?Q?wLtsdeVOjpuvIND4yLn/9JVMNV5pqVqjFH7kw7z8bkg18VLlI40FNMPuRaEw?=
 =?us-ascii?Q?6uSh5EL6qaRDL55NbD40pD5FYy4o3kBYC3hfi1OImrJbzux+4d7flNMzQYuy?=
 =?us-ascii?Q?1fNNQ61/6R5rhlAN+dswSoZoLX/Nl4XEmLh0j6d8B+I3c4zf3+WBgz6ZDJDR?=
 =?us-ascii?Q?yDyg+cIWvv2LZsR/d2XKqvpBMhIw9udOnJuC1IOH4YbYXuqOiFy8bzknWgZS?=
 =?us-ascii?Q?uGkV2hTsj4EUM6VG4fEy5qH4qiyLQWS3Go5GoB+ISLzLomNvQSUvanP6UwAg?=
 =?us-ascii?Q?se0JpgNVInW03lQ0EtPQe+UtioQEXwb3rfgd7I2LlKeMalimsrM5F2EjHlgN?=
 =?us-ascii?Q?qXXBOay210p63ExdSvKsac/fXzVR2xmm+0JHL3PM6JC5EgPXw4pgC4kLqVS6?=
 =?us-ascii?Q?rHDi8ciFkpb971RsezWQjLrj6bMcXbJ8YZ9/MayKp2ruMFccvPw3hI4PUrFO?=
 =?us-ascii?Q?DKwQLq+Lgf93GYcteIywumZhs2GPqth+ob09l4vJIMCz4g7vOlUgSgQ3RW6u?=
 =?us-ascii?Q?ZFxZxhoh0Ts/ZK7xkhXxeg9Q1ftlrY3QTy7CejPwgvV5IIiy5h4+RSUwnqHf?=
 =?us-ascii?Q?Vu3bpXFVN18dxzvQ2abLvnLMjahQxo8gg/rZ/x5CIOtzkszfdHJ58O0K/92z?=
 =?us-ascii?Q?i1M1o6ZkEgQe07wZPoKA13xDTPKJTkr/+XPiPnMZjpTM1Bw+8gNJolSO7wF2?=
 =?us-ascii?Q?G0/dbsskXtOECrWn/BB3mxc0aFXV0i35QzRCZqbdTrEyN0nukAEn08DjIABT?=
 =?us-ascii?Q?pAZByiNY+9DZhyfMhsfvnboDfWcEID+KSo0Q/xie+f6gLzdZJ5aUpeMEyqH6?=
 =?us-ascii?Q?0k9/BXNGUkTUuXwNzHHBCJtqvCEod6pvfIidspA123H4NY1r4wjuIadltRyn?=
 =?us-ascii?Q?hBZBFGHLOrN0NL88e8k5kTqVT1mKfQtCbsK0ROb3nnQ9N4sdakqTwj10ZXrn?=
 =?us-ascii?Q?He5ln/7bL9gCu39yM98/N4sLn5xJc45iQh6PHHD2MUhNv2oU2vzo94CuYBAt?=
 =?us-ascii?Q?rgWLklm2kEV2mkPvzoM+APnCTeURtRuoUnSRp5dWxj10SpTcbARGUM/46WR1?=
 =?us-ascii?Q?f9Ly8vFGTNmqnTqn7JqbgyMe4OOpXfviEOBKtfWR9CYzjxIftONBqN48+7/u?=
 =?us-ascii?Q?c+ervzm1OESKarmBrIQektDNPYCxCbyidhTfVV3Z0wVXNCSRgHS0pqpF1QXS?=
 =?us-ascii?Q?2w0GRSfRJXcr4mLH8moOXOxRmo5xVOy6s8jNF1UB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df98ef3-a18e-484a-374e-08dde0b87538
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:41:40.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCBnNuOt+ZQS/FUCoxVuWAyfp61Lz9PnLCBsQajNMnAvYoQrTkg8y663Pgj2nHDy6/qF3k3jUhw7XXXGWkyUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6215

Use kcalloc() in main_func() to gain built-in overflow protection, making
memory allocation safer when calculating allocation size compared to
explicit multiplication.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index df646e0694a8..5840fac06feb 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1021,7 +1021,7 @@ static int main_func(void *arg)
 	set_user_nice(current, MAX_NICE);
 
 	VERBOSE_SCALEOUT("main_func task started");
-	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
+	result_avg = kcalloc(nruns, sizeof(*result_avg), GFP_KERNEL);
 	buf = kzalloc(800 + 64, GFP_KERNEL);
 	if (!result_avg || !buf) {
 		SCALEOUT_ERRSTRING("out of memory");
-- 
2.34.1


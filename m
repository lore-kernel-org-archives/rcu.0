Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794182583;
	b=q6QzjB3Ur77C45RPiIdCuK1t/dI0TIDwl5/1tUSOXbgsONLm+iy7N/4RX+vQuk0i06I5
	 XJJLDZDJi3dxA3WsQ8LITvVvHcAt+jkk5UdUAcnH6SakQNc/YlUQoOxfsqvAxnoxvWM38
	 9evcQCIVP1BISu1mFkSijgk94nLNFGOs/Q2f/mH1gQXy6kYf9QdYLZaM7KrSlLAt1xRTl
	 SFW69wvyrA15Ea9wN23VYg1DFsseDYr9PWlQMSaBk9lNddB70opnoGkeAZYBKGiFxyZSI
	 +65HqknocAezNhMWODdgb6UTpchCZr0aENOtimjDpVzr+llXMqG7m0D8tAmsD74GTcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182583;
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
	bh=sgvdES7KjAUyGgCO5Yj962Lizyr8jjN6GChq/uBlLio=;
	b=xIdobX8WCCMpbEcQW7WrskHRyxEasGWGMGAT7ZuA6UByKX8Aozl/aMUpfDSAwOCJf5LI
	 d7DL67KAULGMSrpRly12N4shhvsNOw7TWNVkdYU/61jhbyxGNsV4z56UJOScRrNKd2PT0
	 6AnQ8882pRidYEc5HGsJw2yiIv37sxFNzxSWN7rML43SlCZFMt3N8Nqkjqvt5S/47b+pP
	 8Nfqa/nFeSTZDiBY0UU9v3BuR9hn1Mm3dSC2DjZiHBxZ+sW9XMetlmsnapVjO8ILYWzHO
	 eWUQxYesgaHc9qygPM3T0RGdAiD/0Uxr/S3DDaPxLhJveQpF/gj1aTJUxszQW+q4z9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P3IRIcwi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.47
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC7606D813;
	Mon,  9 Nov 2026 00:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1DC7606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P3IRIcwi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFctdnGQlSJkCPAl67ITmGfIWD4fTVqqKyH7DnLY7+xRFILO86Eoh8wsPx3Q8SvWV5WGljYjqqKNOP1bSO6FHyUABYiKnVHlYe/jGmDlLxG6m+wW10AbzKhDD5+3WPaNrzt/8LYbA2qhqNmUticnHU1+INXi4PhaWCFkHzWnQ3mrCYFZQECt382GpVHofoHzCNLZIapNA5+Ce/T/JE08/uUcLF6ib0RghyMq5w+qZzTygwzHkdT90ISwY1r04NVgv0ek2wgvphhY4BFr3imAZrnInBmbCgpuaB4hEgQ5HvBHNzbO6lp20w3UHdMM9KO/bY/j/6RND0/+QAIcpEOkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgvdES7KjAUyGgCO5Yj962Lizyr8jjN6GChq/uBlLio=;
 b=GfoE1RANDE/fZ78gLtleE2u4poIOheULp7mSec2USe8/UPBrDZ33ng+dGlf2asS8oXXnljBAPNDcvMp70h/N1Oo4w7owQJGKHhRl1cWokAc+WzZc922LAfmEBOpCoSL0Jm4tFlcqtfidc569VyyTAN/VO973rlrYGlpJZX2q0rT9afczwCrm1m5f/KtOU1VmCRPOxTJSBj3oVy9ORAUcs+BphtGkzFZXbHywaspgB3JUdaagHP4xCMRHYaKSvWtowbo4BWIFr/CbkvEQIdGimQqTGQmDXQ+BvdCijXOT8GtTYgBpSEKA3wlibBK72IXbuX544BiJXsedgtgBT/Tyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgvdES7KjAUyGgCO5Yj962Lizyr8jjN6GChq/uBlLio=;
 b=P3IRIcwiqYxTF7nK11GqHurPGhYw9I+ZBsLXi/Ci5CZ//9ui6zqxRTTfMBr6krXU8y5wj8r+YJgiJHdozoU+PTfBv3/AZdJz9LOh08uzX9cD3cmyc/+AgfRkVuS7Lura7VYojyeQXLUMwF8dNSgGVI25AYHab7mjyJ0d+nsbZdqFBDYW6Oc1PxVhOkAtVIhcTbmcmWzUjIIw+r9L905mEXiPwwPHALWeovGzt3Aoso1GbsAHKrIcqOx5/9ayDBuTH1FI+MOj/AhuU5nM1G5Oo6+bk2S9cMmQgeTe5/3ogKhAASpZVSlS+82PgkD9rGSjpZfbb1miOjnv/1DZANE18w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 00:02:59 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 00:02:58 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH v2 5/5] MAINTAINERS: Add scftorture to TORTURE-TEST MODULES
Date: Sun,  8 Nov 2026 19:02:41 -0500
Message-ID: <20261109000243.3936824-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109000243.3936824-1-joelagnelf@nvidia.com>
References: <20261109000243.3936824-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 775c1688-6456-49e2-aea2-08df3df4d06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|10067099003|921020|56012099006|11063799006|261028144727099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	75jveHvEVbgcnDcbEfT48JdeH9sFsxrp/6cH3I9rKgoFio+v10FuchdpaoCMCZUl/XNuo334hwo2ZHVgkv8h04WitzOjhdwI6dkdJiSETUGRVjh2Q/bcLQNRE5mOzu7w0KvahRbQuEsOXQxzoufeKuR08MJvwxrWNDvtJce2AmAqA0vq71KbuwZ1kokNqt1jYwYzD+Ix6eEQHfrUhmCrgWlgFQdYazNd9Jvjtxav4RR73ydCNx8L0Sf7BKzsnPFIsd0EiWSkYlf8XVfve9sLAwxmTuC9pzUuRXg6lmAmUJjzGKkgHw6yVzPjwDf2vUcQQ5KPrhYQvfvLE0MtgdAPUH49qvhr4/hITEQyK9ePWilxxUJf2nq3ak9CasEdx0/FxGugVAg7y75LnvjLE4oYRbz5CjDloALw9cggmag9o8tRYPMORalV/9Jp/tb6pFei6MP0KGYJiIQs35hn6Wc2DYrUrautx7Xu9S5X2wTXKV+TbYIsCiHSIRBPCO69VWdQNfdrDHS9EkvlFb+TuL12pIzUDg1OOzF9CpOnJYgy7o/Vm/lUayDIEsdRlOdl4VqzuDUPbtS/X9UzFg/YpJgskS38MrZ8A9IHLj9mqWHfWYDd9u22ilATRIcjzZsi2SIC9wuU+HT/u8iEhY2GFyUQpcJPfW389W4AnuaNlN0Peb13Bk9xDKGwTxHeS/FfV+49OuasBztaaFagoC1KVoyq6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(921020)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3jTsPbh8WLsW4pXIQosRUpUXm+iw9ZyW9X1SA1lJbFo4G1quZhL0oGAShNvP?=
 =?us-ascii?Q?jacs7EpzRoi4UTSqOUAztd1Mwlfkn2H6sgT5i8cEAzu+Zvam0u9IjK4RDiuN?=
 =?us-ascii?Q?lHDCQ3gaKe872v3JQV0u4cs/QjWzIzPPykwRWqqcUygzsQT2/DRDQLx7NtD3?=
 =?us-ascii?Q?XT1scrwrQj0RG9Kaze+JYA2ZtmGs2QUUXluUVVssboq2IMPEKxWE4tSK0Lb0?=
 =?us-ascii?Q?d/B69+PvTe6RcNRqMel4S6RMAhELSfA0lbnOTo/UhERigcrFdMjTgRtKE2yB?=
 =?us-ascii?Q?Sv2Sm/TDX269jwDz35TmiSlhln7WnAlN8NlQgIKZq5jqpcJ2wOc/fhNFbMhs?=
 =?us-ascii?Q?zvki+o41neSnpfjlV6NhLiwCKW+0OM++S/vqELWTFDKtYzolIGYhKtLIuVVv?=
 =?us-ascii?Q?AwgAnFI7q5kkB5+4pHPVJRzS2v2fUrJlXg02oi1l7YuVQTZ1wDgR8HuiTVQ6?=
 =?us-ascii?Q?8eo1GtmLHe9FdEDjRLyrboGrE8YDoLyAXCbhLwCfrS/Y1OeTEo0dOLqtRCMi?=
 =?us-ascii?Q?QdmHaPtFc2iLZpLRX3+IcubfirQy2M+1SVzbQoLbnSl/XEeanORIx6NAVpb0?=
 =?us-ascii?Q?OSaDAcbvjCxIhhUL6YVxZ9RGJkL/s002/cpJKqPrxu3E3z+nGM7k6hT8dJXX?=
 =?us-ascii?Q?HIyCZ6YxpneGIXt1k6eiMbETYHNszyaNmu83qMssorxqxL+Rv95Y/YhJj5SE?=
 =?us-ascii?Q?xC8WkFG+sL+K8u0vdizUR/4qLFOMxlKKkS5Pvxzoh600VQrh3zHHf+EKUHO0?=
 =?us-ascii?Q?uNqUankIa+/CBCD/aKl92PjVwDLUBnsIc1DtpVKqcF/iK6Pp94ka4RTdzHYU?=
 =?us-ascii?Q?xI6klNpV6WAGQOIBBlnHnbBfLXqVRLoNVfWsH99T47li9MCb7EQgi6tkCRMq?=
 =?us-ascii?Q?V+Xt12irlkKlYBh2YY4MzxeHyqUXVOLjkBo0dpcX7UBsRluRNn+DAfDvSb56?=
 =?us-ascii?Q?ZwthinNU7bsl9J/RahbaPmdWsgcOQr4q4gzTEfP/gvZsiO4eSmaM3zNXhrsN?=
 =?us-ascii?Q?O0BxEeCjCYEH5s+DKg1x+dsxfj8nuGk7V8dJoEo8qtE7QjWwWHWG/OZNissJ?=
 =?us-ascii?Q?FC0Kg8ArAcGbudhr5w5kKIq0YQNyxwoJW2q/AF7VIwwHpS9p6yKHh0nmLLDQ?=
 =?us-ascii?Q?gjPPcAY9BJt5AmRqL3N0stiGNHP/8YWJzmJt5fbt4wj8NRTjZ/gz5/VKckXt?=
 =?us-ascii?Q?71Vz81o/7AV3PmU067RLrYGX4MUssBIgllQ3z64gEbdACT5xqlAHeLyIeMeN?=
 =?us-ascii?Q?QtSZYgJDLGC1E78ok1Kc4afvGlejHkHnzLrMFb4mjOeZcWp3Bg7FHScAOiyM?=
 =?us-ascii?Q?dn2xdVuZ2uEUpNQVxMgeelZZnGbBUR4OesimfvooC9CmmUbO4kJcp91OdmEI?=
 =?us-ascii?Q?ZpI7fI95+H3H7om/+qksxQlA9oRflyfpVs+TCL5l+l+Va6ihcNrYOnmklufG?=
 =?us-ascii?Q?gZXkcOv/yo5rHGgkill6VNNSu2H3FG+aq7DpYiUbfCljAdHK6/5zyWVTYqpF?=
 =?us-ascii?Q?p1xvqSTS7lXh6K8YvHsFV1HEulc+pGh12BRFrTJodSvOYrO9jLIOQvrkSLxq?=
 =?us-ascii?Q?aFEFwavmVcHmrwDuFv5FHHB8izOehHiv19kMo2ptDQNpTe7Qra6D8wcD0Pzt?=
 =?us-ascii?Q?IOILbZu8Bf7l9XSNISL/G8MQK0Oj+Ny/cn3r6/JfCXzh5IvhPMIotDglb/h7?=
 =?us-ascii?Q?vZeNWbq/LWX0oZ64IUPuTIP8hfU96vh2G33hBxZkorPwwnH+iVrHBg2wFa+U?=
 =?us-ascii?Q?Bf/QeTf+jQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775c1688-6456-49e2-aea2-08df3df4d06c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 00:02:58.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHIjvWI9DPH6qKjtQzBaRkTb/0p3zycT3olkUDOH5s/ypf0TogjvBN0qADjERiQR3rj7BWtmowpyeeRDoqfMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

kernel/scftorture.c has no MAINTAINERS entry, so get_maintainer.pl
reports only the linux-kernel list for it. It is one of the torture-test
modules alongside rcutorture, locktorture and refscale, so list it in
the TORTURE-TEST MODULES entry.

While add it, add me as M: to torture modules as well as I have
contributed patches/fixes to it over the years and use it for RCU.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..5c068224048a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28282,6 +28282,7 @@ TORTURE-TEST MODULES
 M:	Davidlohr Bueso <dave@stgolabs.net>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
+M:	Joel Fernandes <joelagnelf@nvidia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
@@ -28290,6 +28291,7 @@ F:	kernel/locking/locktorture.c
 F:	kernel/rcu/rcuscale.c
 F:	kernel/rcu/rcutorture.c
 F:	kernel/rcu/refscale.c
+F:	kernel/scftorture.c
 F:	kernel/torture.c
 
 TOSHIBA ACPI EXTRAS DRIVER
-- 
2.54.0


Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC421B9E7;
	Fri, 18 Apr 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992646; cv=fail; b=oEIBeKRdegWmK4AXtdB4ilLB7W/DduYQvanN3Bgg8lSmelKsbHWBn72nI9xZHdKcDdxHZDB7uEzkEK2K/eL36KBcESYMz82khKqcVDN9axSaSl2/Vv5f1R6El/wpsljkdoB77lJC/PSPf8Dlcv+qll6Xw0G5dHSMr3uSx/pe2RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992646; c=relaxed/simple;
	bh=YbzgWQa8DJgxnstre58HNHG10aky9zqPYsGegNA131c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yp0DvhtXSVif4M3caB1MfaSl/6k2YMgSogKBnH+GvA8ZqzmG5lkARm6Mx2hYGm26DlJrfTkn6k3TQNqPnl5PNyUCFO61qKrBNvXYFi13I36TfKVWjmG+k/2nwxzU+N6/RssSNjiuM7/v+Myig4ty2p3egLxtUzxBqWyD3ivVXyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DhKwe2NH; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DhKwe2NH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfW96/zcBvoDbQcgwchs6Hl7EYgJVD+szFYrxXAWPA2rYdok9dbI/3m1IqchWPSkmxq2m2V1eLiSakdKv8fiWKJv38nVX4JnOvh4u1BkoSn2rsuxurbODhrJrjUKCU6rs/RaJszLuWzwJ2pm9m9OVdPYHRZT0Odn4RNRA9m4G0CqhtZujrPoQpkqUeH9+qNqw2xcGhPl9YZht4l1SQZDVx5tdYONRKwQ/u2JCMrtaj5QJCvMb4ry5ABFcpcPgc4W9bHKFIftC5L1kiqb1g5Ej+IZHybDhUlZButxCLOi0n3i5T+LTL9OzSs34psAv66KQhh09CifKIycqELeCeSSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWJGymz0yaaMHI2aGDCN3iFJ4nkjw8XJixH9rp+3G2A=;
 b=ZARRa5pZNmuEq3pkb5buee/sBz4hhVwnLbZ9qSTUfPmWnh6vjHUrP9BOqDXbkjvkKavzd3gdN7ZIkZBaRQErai+CSj2qkDrY5EiS1HEZhBf3U+db8c8Ks0NJr5qc1CN4CKcDieBTgSYP0DGwxYJXYTcxf+b3Yn0RDmD9Frff7vxkNS7XRpbmRGfM/1KgYmUU1lhJZWUz2GnLk8Ag3jZr2v6nCTf5dSVmEL3m8A8Bw2FoIYsgxMq7Gpteo+dg2ii0kaBu/pXHyEG5PMjC93TJV1Ga/Cvo+mmzjkSuxDM1lRfbOC0/fzVB8OIxIDe5BcmY/zzEgtV7vb5iMaTkh3Tc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWJGymz0yaaMHI2aGDCN3iFJ4nkjw8XJixH9rp+3G2A=;
 b=DhKwe2NHYyj8YQx9BQZVKLPPJb2sdMdQgEiM//IOUtVenwF9klaYdQiLtQXcxm6GZW0Ngxx1dCaYZnHZiL8DKQlpQQFRoT6QNUoxqAbRLBkhUFFdb//9EcW+qV3c4jpVvct+qGxbtfT4Ntv/2AA/PLVx6ZqGygMY8V4v4w0S2BCQsy7Ljp0IO/ZnnyfP4mRuoxe7Z2xPSoAquUwy7IdS6gkafmGrb13/bpkL39gPIWBeDLJQzZx4gtSOerORSZmUacu3OqKsfnydkuFJyk3mA31hjHqby4OyuCX/A7VW9KoNh1vDQVEVICEW7TVPLkHpECEg2B2wvl3W59xD1pbUfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:10:41 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:41 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: rcu@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 10/14] checkpatch: Deprecate srcu_read_lock_lite() and srcu_read_unlock_lite()
Date: Fri, 18 Apr 2025 12:09:42 -0400
Message-ID: <20250418161005.2425391-11-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 539eb4df-4f5c-46a3-7a7f-08dd7e939132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jSLGlgfqNm5Tss9bYLQzTSyBw84NlUd5hzIK053uzCZn6hYefvhI9TzqsdGw?=
 =?us-ascii?Q?XqeTfuBcMiktPYA9B9zooLpHhPLSY5qX2MjSjnEJdbwQxQGqnqxBbRdNkNJc?=
 =?us-ascii?Q?PgicQ3L5ENTys55U4fGvYkKj1+IyPIPzhfxhXLWI7Y+n9moiqvWZnpMefarr?=
 =?us-ascii?Q?druqj0QYFbwYUbg07YzUVZCjWkkKeBtoUPVW7/acgNggJa8u4AOe80CcSOEW?=
 =?us-ascii?Q?bxsuqikle+dWmEJNKnSViGmKeJFlNYvtltg1XpUQArfBL7t3oVS2u/iombsE?=
 =?us-ascii?Q?+VlNI6teoem8WE8+SnVL3yc4yVkXNSJ9xQB/Z3tN0F8D2ACfQPjlLVpTC/NA?=
 =?us-ascii?Q?i8wolwDNEnyaDqUEbdAxMYOSYTMzD2p/cXi+OHD7th/0hRPcuCL9/Fk2W04W?=
 =?us-ascii?Q?hqUn2hR9bklG/RyiHF0xJQHwjoSZmRnmmIL9Jur9Hj7s0dN0/23bPbOBoj+O?=
 =?us-ascii?Q?nUBhbl5JcCSrUvFfENm2XAobvrowGGutg3p0XlBn3vBA4y9GS7jKvxI6x/cH?=
 =?us-ascii?Q?cZrMFYyvSJWsuz/nhvd4z/71elRITAFVCmx1bsdKo9LS44TGfZxAg+vphqpw?=
 =?us-ascii?Q?FcmcfIFViM2ZxvhryiXOSrUhG48lsRNMknNlM9BIhg90yEWEIx5Qy4/4mVG9?=
 =?us-ascii?Q?9tZO2nYYrsFmrClJK6WzjnrHmVdZc1EFVeEAnXQfrIh7n6gE1ub7p1bcCgmU?=
 =?us-ascii?Q?w4wOWOpiW66ti6nYCWSPCG78F49xe5RVh61MBCWZGsQV9ii1ez6MG1+3DX5K?=
 =?us-ascii?Q?Qhw2mPb7qGZVJYTA4HhNFGAQ4OpYUvDjWNNS2YCktSfOgCIguO03ODrMeLfZ?=
 =?us-ascii?Q?aIQ+R6F1BMDG1UTBr5k4GC7EFnFn5cwW2wE1+F3qZDbqSD5Vfxk1DvdF3r1Q?=
 =?us-ascii?Q?PhIvDlW4o8A8u7jWYgL7Bh3CGR6aloQUtTXKjWd492oYL0DcaF3AvoCqOpVx?=
 =?us-ascii?Q?P1spVOsPYxHP8Qq6gk76ERP4/eVYum3baso+ipny6eCi8b3E4xGn5CIz2Grc?=
 =?us-ascii?Q?+YBVhd2yBbIGUqPXVG/at+qJhqJ4adke+txICrUwFhOLOqsc2cv5IF+VFsr+?=
 =?us-ascii?Q?cGCtWyiPSa+0WYcpkt4tQZGlcXCmKvq5pRpDM6i4LF6fYncoXWNcvZ2IYMEg?=
 =?us-ascii?Q?pC4Vlk9Lb/W3fgoLIwXXxAt+W2pFH3Q4/w65VlF1moAdMfDbCKkwsvaiIvDh?=
 =?us-ascii?Q?65q4RZKIKdsI1AyuyFbavLT9YlZ0cyoB4jJyT65Ad5GS4MIwEJu/c9pVdk04?=
 =?us-ascii?Q?YOV/2+LJW5d5Dh1Tg464cO7NvFVAHa0bjtwKfRQPvxDhf58G8S1QxThEMzHM?=
 =?us-ascii?Q?gY1+gu2FC3VwoQa2ldWwf0zyyQEq69dm+nnBITTfFSSHsglBWgBMeLSyPr9h?=
 =?us-ascii?Q?QDvhNIo5S2UxwgaIy7SFtwWRQ2FKmThffuL9CX8GnSOgsiBiYebSKNGKBLW7?=
 =?us-ascii?Q?pue+ECtA2mA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AuFohWpHEWwNc2BL2f07BN6tck1i+SD9U7DBvdeMw7ZmekPjUqrpv5FN9Jxk?=
 =?us-ascii?Q?iV6pGkRiwdGcrImGeLgomjMmH8MCZOW+x8OJPfObnMyiG/Osl4M5TibKPNmr?=
 =?us-ascii?Q?CGiRYGEVDlb7qcFHPr0iOO6BYbF4XAyozfKQKOTLTHB0NmKYmr/zdp/n0TQi?=
 =?us-ascii?Q?1amOQLT05wsd5EeW54mAMqyAWgHn1jG8+bqXxgs/f/xHXZHac3L451ihqcca?=
 =?us-ascii?Q?xJiivIe48k/CT5LPXRMLUQ2sLm9op3ejHY+q0ZPG8+wrlvnSSiWtLYsPJJRZ?=
 =?us-ascii?Q?nRV+HeEhfBPakwOVhzB3TLv1KylX/PZPfwhwj4wGDs4y0tHo6uLmokkiJ8F6?=
 =?us-ascii?Q?sla4aDlGN/0dfvmw/A34Cgu6H8Mt/bCtv/jkuVsnBhdtybQcd9PwkHBIVTGW?=
 =?us-ascii?Q?4jkgmbSwHbs1oDImg1FfBsYHBK5iAJDXGFh6blvoFRD9fnvd4G/v9k9PO8BF?=
 =?us-ascii?Q?3QX0KnW3LjybBYKiAYCp4wQUOonbrFbwEma1Ud7RmCKQKnWHFa90Mm179QWm?=
 =?us-ascii?Q?w1aJykfxrfcaWJRo4qQ3y8fCtI//RCjWdcjhUPvjCwugeK9UHBFkEpfA6/XK?=
 =?us-ascii?Q?kZ776cXM/qec46fyNHfPPF07LOJE00Tm+zOQkgNd7EI1cyGLNNn7cR9ChhM2?=
 =?us-ascii?Q?cRZvvtb9pWKYhDV3SWI+0OchaUFoyKhCFSlYV/stmiQH+9NHDxS/KrsjAc5U?=
 =?us-ascii?Q?szTQ5ZXmr/yAuqS7JhTlndQPxkKSdRxFYY/dbjgXw3d6PRMUPpsG10Pl1Hn+?=
 =?us-ascii?Q?a6sljpBTtF82Y8nb78gwi3HWsmGSAR21MGoYA+TDwLiqGBCwdkqL2o2aga20?=
 =?us-ascii?Q?5/Vs8EOg1OsJRG/OgRiTL1hqLNFUNJYGxV2m+Rx4XPWyvppRguK8txyVxR50?=
 =?us-ascii?Q?idZUZB6N02WlRvLZntYSNd2L9yGB+5El65pQsXRCxu8P4zhADoCeXoClRrJn?=
 =?us-ascii?Q?DKW45l3lpuH2XqlGZRZP/aPp/LiakDr1F9VEYs7MxrRu4ebdRywn1Q6liqhl?=
 =?us-ascii?Q?AOq5iLEV/8vDsmaECHhirGDJyz+x26tsId4YzgMXu8go4d1yJ9AGN/AOGlAO?=
 =?us-ascii?Q?lvMf6jEdVI0FRppkaZbAfCbBmFitIIgC5KNyJ2Xsb5CMS0PsXCgPddborAd2?=
 =?us-ascii?Q?Jk7+yoPin0wXcgRhwMz2ue6KvmUyRU0T/KY3V36SICDK6tlSAvCAvb6qryY9?=
 =?us-ascii?Q?vitOfAnLasHYOtihFgKbzz3h3akfqHF2Xp7XxE2lk0aBb/DshusTLKkvVKuO?=
 =?us-ascii?Q?HrS+z+F9QBdcX90DYKVQnRri5dtA2wqWCbJIA4PUJeV4wSs+wt1o9U99VbSH?=
 =?us-ascii?Q?kLbcvwof0thmJXaBgYyM7WeRjBzpl4UCvTL9b0lpJCZwuPwYViOqr+20FWD2?=
 =?us-ascii?Q?Ojf0d8737wKuLN/n1hxfJ7JGNq4JqWRaGnyH9k82oaXalzG0YfmlUpwSkKtD?=
 =?us-ascii?Q?x4DCuLI6/aOOzOPgI4HhCay59tZoF33dGPXNITiUIME4w8mX4EVYgGgihbsd?=
 =?us-ascii?Q?mE2f0y6hIO1/PnzYz/ERxPFTfmHtX2RhH8iwshT5T5EzZtFYliu49jlj+9tZ?=
 =?us-ascii?Q?llZeq/x0R/NsrDWjMvQRhO4XAPQUWV66GJAWqAQx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539eb4df-4f5c-46a3-7a7f-08dd7e939132
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:41.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImK3vvSGa29o3Lt20lnVWn7rULULthQlT5d5N/tKfhhpCCweTvl9LjBjpp3Oc28t28coMLmWBrPjiLem1CKd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

Uses of srcu_read_lock_lite() and srcu_read_unlock_lite() are better
served by the new srcu_read_lock_fast() and srcu_read_unlock_fast() APIs.
As in srcu_read_lock_lite() and srcu_read_unlock_lite() would never have
happened had I thought a bit harder a few months ago.  Therefore, mark
them deprecated.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d22bf863eec..b3b1939ccd19 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -839,6 +839,8 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
+	"srcu_read_lock_lite"			=> "srcu_read_lock_fast",
+	"srcu_read_unlock_lite"			=> "srcu_read_unlock_fast",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.43.0


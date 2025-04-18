Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B489227BAA;
	Fri, 18 Apr 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992680; cv=fail; b=OX1+VBGGcSLmhAkLZM1NSiFdma3EOjXrqIRcvqefaklRot36vdeZy7bcoWPXPgyYWJFhGCwZPYtkf2NGQ2HT8GSgQ3+AWaakrkjGY3LVqlZMXCK35YENGsiS9YcHfu4S7WYLZBtQQcwW6t/jsdTBgNIk6fnuYNzmiJapY9feq8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992680; c=relaxed/simple;
	bh=NUJfl0C2Vw1lRbQsuu6y17r1zhbBqgGAGBuN+hBqALk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+RPj+DLEVR1M+r1oJTHrKG1ASwbJvVqIjOOg9h7JBYf7lR8z7hAuyCMLEq0mLKnAt9fOoWcBUvePH/VCUYG0lYOs8WB+9a/8AdwvwDHRB4iAndmPtTtTVDu0PUoVq4PeoOIe17yDo1B7Ggm5E6/QOzdXBWLT1A6Gpt5ksWORn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nnd/Rfqk; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nnd/Rfqk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEF9zhwSSpnaSeRMGilLYANveovQ3IeurVCoyCenfDDOQpu3IKRYBCB/1C8kkPtPleC3RuyfkYTRzWee93invLAPSZcAdPFet3PlRKyxOl2etAslqS6UQtHrPX+JSP6NF2UPW+SUTYYmKyf4pXxr3ptJcToppsH330MxYmuQzSrJqXiRcMGasGy6TT5t+C/l+SGeNMLDaiXdh/ypzEyxVv/a4x7g6Ob+zT9tsDFxp6JMLosMbWRl8bTEmx75YIY2HZ5SsOGmqV//wfHquVdDQfzxILvW57+DIVzeStVLknnASuoC0eqF1Heb1GeFgYd4NcbRniD3Z0K8HbCsaoxADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxLn4KEhhe14dWHCZJB7khU+tm6O4yn4QoBaG8VryhY=;
 b=uiZ+wX55ljzV24zfD2zBZYTaATdI5CYPTRdTAh3TwEpNgtYmoF79dlJZiM7JTRJE+GpT4zcz4WFkSJiC9wUbkOacJoRXGBKaPeE1KNYnXY/YadIJAZOsnJXy0pkRi4eB54xs54YEF8h1aIZxV3xSGVGF6PDvl8BzIdA0olDAp+emsEtK8EWBVEVv0ju+iAz0pCQPqe7PzuIXP4nSDnV8dxYvdEGbAQ7642zkD/ASyKZ1MZH6BXPExsurywKpHo2rLwMmyyr5K5x6yWOMgmX7kmwDUbCTzvRNSWKhg4g3eRvnFGp7+rP0uInpvymv6XowBQmMAutA982K/z6oTaLwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxLn4KEhhe14dWHCZJB7khU+tm6O4yn4QoBaG8VryhY=;
 b=Nnd/Rfqknm5GPso9ideHlx4RdCcJbrg+XyQwF+KpTY5flPBH/JQQBGaktlvVRHSd57PJZoebxGklPmOA7NGPw1Ld3sYbvb4cdhtZI6lahk0VcoBf4n51JbbYKLY7mDuNPCKedQy/d+UjeDNDVteAZ60U3Dwn6zsuMe0+di8zh/USbk91kuBwWw03gi8eqssUo0EwXXJTfNRYmXrdGzPYYLVeiPtvTKu9Z02KF9pP1+Vi5kOfSTeNBM8I3030Na2Wrp9BBfjx/PI15ndb2BKyj4pRPgs66ZdMH9SU0jc6DQ20Vsa6U/rYe9AD5l8IpmSdUB2CsmI/O8GDUY5KVwjydQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:11:13 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:11:13 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: rcu@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 10/12] checkpatch: Deprecate srcu_read_lock_lite() and srcu_read_unlock_lite()
Date: Fri, 18 Apr 2025 12:09:56 -0400
Message-ID: <20250418161005.2425391-25-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR15CA0049.namprd15.prod.outlook.com
 (2603:10b6:408:80::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9ffafa-8755-4ec4-36be-08dd7e93a429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mnsFPuItDGw3fQX5eYfKLlut9sO/1/d7UNgKvrLVU2Ynm7Ub5ietCsjXMQPa?=
 =?us-ascii?Q?21K7vyealhAxmoHh5hI6fnST3nmkea+ph6VKj4DBWRKO6CwBgx8vOP7S8IkY?=
 =?us-ascii?Q?bQuQMJwKqkKxzDPI1kTQLcRWOg+caFm5vtJ4d0QGVgNYQgY7GieyGCn8Ud1x?=
 =?us-ascii?Q?NYmWK1/qGSaNNZHrs98AaMVkfBAV9XKxtgYyxtVQ0noHINPHm3wDp8yvHXV1?=
 =?us-ascii?Q?cwjmU2UTAcvLsACPQKm0idh04EdPlyjHeaEzYTxpY503lelZpqPMWxlopppm?=
 =?us-ascii?Q?CkQCluG4Kmrn6gMO+k8h0OAyoLzVDZKCJE17eZ8Uedjz28oFUh3i8N5XcTtv?=
 =?us-ascii?Q?JsfKUkrGWDGgJyWdzbNjwL8x+sVk96mGYHD/i2k9ARgTDAQmfmR6pS23R7P0?=
 =?us-ascii?Q?BYmwfIs3dSY5CAJAjU0t/tvyj+7ZRf6wU44nEjmchRk8/2qDd9GLi6O2paIo?=
 =?us-ascii?Q?cRlzGHjkl06s/QOIMivJcF6Y3+MJ9y2xJTdePYu3wyXjNs2ZO5nUL/ZlvSQ1?=
 =?us-ascii?Q?oT0AOmIg6101oxN9zg/O7YX7ACtD7TRk+ksjQEaXnQCuAutT0bf1TOCmGQLO?=
 =?us-ascii?Q?JaCqu65KuZiF9tSHlrHQ1O91W5J2/blySej2X+7ttRI7CCnrYnxPfiHYvj91?=
 =?us-ascii?Q?ewRHRlgbe8jydNi/rLutsXe2HszRK1ywe7zqtdaBdUTrgwLqP4XoJlaeL9Bd?=
 =?us-ascii?Q?5fPefBC1Y838IJ2i//Zm6ZtmJIsDI1Bp9sONxabOutF/FKIINnGuj/rHiO4f?=
 =?us-ascii?Q?5PJgCBYr8Emk8fG6WtEEdVIJG1qPNmi+K5BMqcb/sSADHmb7P3lSrDAu88LZ?=
 =?us-ascii?Q?NIqe7oDTPHc6dAYR0rLikpU1rfeZYtpgPnzryYY53L5C3AT4DErcCdUxC1fP?=
 =?us-ascii?Q?bQB89APSLG+Rjl0xnsLiJPkTqrUIHhcEW6b67GDLocE82CwuzFvTzipAVluJ?=
 =?us-ascii?Q?xzpbRT1b2ivyhgNgNSZmNSyBLno09K0g7nCbf9UAsm/578fCBb7tqmOOZ9Vc?=
 =?us-ascii?Q?QrDUFaLzQBawpJ1uNethgihlXBw5Px6ieXfDjhxPGGmlqlGl12wH9uJh0TRB?=
 =?us-ascii?Q?7Kq7/Qh6Epn8DiTQ80b4s7xCLtHEr7riiYq3yhGgzDQX/kYa6p7949kPbVNP?=
 =?us-ascii?Q?qWAkY3fV1XZr5pOXFlxJLNffol+kmFep+kJehZeI/TLlc4rik0pDIcAXAARe?=
 =?us-ascii?Q?ihMdR5mDVOW+ExDwbv4GTY39qVJxe7ArQJnT4DTx5oWL8fw/rB/SmKgeb1mL?=
 =?us-ascii?Q?jo1cmAn9rgiIlz+4SbMrcb78diYsf+3q0JQ4Px10kM3eylQKt4lR93R6D8r+?=
 =?us-ascii?Q?+kTPZiU9LnHx8r+zvTPVWDJJ4KeJDn62pg0z4ROG8+/IVl2cXYtb4AKX6zlq?=
 =?us-ascii?Q?S5Fcrf+ufk1Lg5IrhyWK2aimQKueqs0coFIdpbMA7x+NBYECW+xT6ASOx85v?=
 =?us-ascii?Q?zeBP7lb86nM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0FtUtkdvER0l0co5fWJbGWR9G4Yv9sVHoCcz/XqGu6ffniPoiRd7PvJlOEk2?=
 =?us-ascii?Q?yoCazx070zmVI9yBzPejao6vVCuvAJleX9efjipxfWuOFEMfgQU+dwhUiqa+?=
 =?us-ascii?Q?dXP8WwLZu6q6EUIp6NgPaVMQOZ/2cx3zLw3tT/X63An5bMHqmayk732poU/N?=
 =?us-ascii?Q?/qBRacpQVyJ7AURpY4tDKyDf8tPlup7ifyEPOUAQ+g9WxeuwqCBgJSSO0nhy?=
 =?us-ascii?Q?koi7QANAg+X2CyUesAICbD1RaACEWgzvsgHiaIUE1JHd9xNGZiM1dzh47X5o?=
 =?us-ascii?Q?jJwc51H8sfU2zNEPtb+X8QtU7WAv856z7Wuztxtjor12Gor7xSI/UqIy5D9f?=
 =?us-ascii?Q?JNDV8oGlw5jda4kjGmKi8UwEEmfGZt/EP3OfyxxODqkBEKbt82lIf48wDQBe?=
 =?us-ascii?Q?z/wLns5VBTxqByoMOkOdVx5vOGui4ljmssEgs3eei2UCGCI5KyhgFaYuok3a?=
 =?us-ascii?Q?r1Vga/5u8mUdnbO1TfqgBiK7nuBSp3JXpqB/ATD7eb+AB0TTSsZsXkikbNk8?=
 =?us-ascii?Q?oUJQ/pYeAEqGm/+KXsrrzxWg8SUG8qvXLjUValFCZkzZKu+LCbEVGBIbGTsT?=
 =?us-ascii?Q?OrdTOgQpKYThqYHykRS9BY/Y9jRONoyeBL9wpZXbyjG6GNdzg9sEL3MzMpKM?=
 =?us-ascii?Q?ZF+sdC3B81zKnjDi0OVuY6bxqSNHpy7932NJdgznvNbTXBASpwWcS3akvu08?=
 =?us-ascii?Q?kj8GQyq9dqCSr1Bkt9yfv+O0jTW0oPVMKDENOc47ZiYdb/xVWDjfusviODYF?=
 =?us-ascii?Q?mMwTlwUpgnL/5C7l0VkFaPiShntU22OZoujseavRSsXZPd7/zQ+BOMHmCR14?=
 =?us-ascii?Q?X1ZduTI09wJ4AOL9CL7ZnR+RL7sHsU0b/zwSQt9502+ET1IZRZ+3m6zkMU0V?=
 =?us-ascii?Q?3hA/Y0gREeLk26+H+KqgsUwNbXNkU8kpZ0i0vVNSORmBrS9yoW/y+vxy6iOy?=
 =?us-ascii?Q?0xje4yrzxBNHR+jGDdqWNytKe/Mxo16JAm7l+U8A+0GqD2sDs0HlblScGsN0?=
 =?us-ascii?Q?eTN4bVpB7gxoMVjfVmGIIw7gtbk/aZFJEbkLnhM/WgG543NlE584bQt76rnP?=
 =?us-ascii?Q?PITaaoTm7OnkJd93jPYs8RjFIV/iMGtae5PzGCaB8roj7MzxO1QM+foqK8QV?=
 =?us-ascii?Q?hm4bkOZhiNgGl2L06USztsahbeze9daUIf9FjzdK9754GU5I1tvY91ssZbpK?=
 =?us-ascii?Q?Z4Jqb0+P9QuEfokU5NPgI9Ym3qBIorSQTx1yzz3fMr4SDCnIb7F/K/HOLaK+?=
 =?us-ascii?Q?XqBCLICT6n1Hw15AxdCJYz2PBmyf/y3x3vCBD4h6o1uuEEz9/SUgEauo6ybz?=
 =?us-ascii?Q?C2CAs6r0J4bt9irS4ber9Mt8rZkgnT54tk2YHMF8C9PcsnsOh2IRs8DdTUFb?=
 =?us-ascii?Q?2vgoOpYz5uH4u+IoEsVB/aO7tpsXGp1pLOXsNsB4VouRuo4Kb2Pmdyj9GWyC?=
 =?us-ascii?Q?qBZIu27/aQNmstIbLBzaFF3GYT5vClvGLByQIlGj+L152t29Jej8KlMV53XL?=
 =?us-ascii?Q?W9URAaMneR25PlTDp3JyVYlZFhAsmDG1CnKM1K7RaJVdMVa7BOhnkw3Jgy5+?=
 =?us-ascii?Q?UCMBScPX8C5HAqazOcfUxx6KVjaQoudVJDXyZDf5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9ffafa-8755-4ec4-36be-08dd7e93a429
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:11:13.6824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZntP0Dvyad/LNcWNsC1Xnu6aRQ0ybh4veio95WiSKYi1BE8zMCCLrytP6/BMZmWsuh1OdOi4SrNcdftuwsClA==
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
index 7b28ad331742..de8ed5efc5b1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -838,6 +838,8 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
+	"srcu_read_lock_lite"			=> "srcu_read_lock_fast",
+	"srcu_read_unlock_lite"			=> "srcu_read_unlock_fast",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.43.0


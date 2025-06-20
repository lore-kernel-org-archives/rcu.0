Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5182253EB;
	Fri, 20 Jun 2025 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449163; cv=fail; b=Pw4ifTYhlH+2XFspXLHZ/UnWM3llQ9yukOy9u0gTRnqBoSF3dmIw/X9wAxke8ovU21I5WMd8Q/yzrvMxKXrVIgzA3nAES+RiapqNdQIbfF4g4jHD4XrhgdivUl2kHXclwzGEK9OZNwtIDGdFpy0OWSQi6YZY0XfWDVJYlGV04ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449163; c=relaxed/simple;
	bh=+Ha2WMOKihoD9d721f7Buq00n5KRXri359xxq3KdQ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eVwiG/aQ/8iaLWDmswr7myV9Lrp7YaxAAvpBHQq3LgGRMuHpnQUbm3NvPXnR967OK5KFDWd67PMdYv2/1D6IHf7Da2r2Mv6YjphRr8n8bWW1ORPL0thWW/L/sxu4lpkGORS9c4cq4D+g4VsY88kXFC7TARHqK/H+OAWC8NmYyLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UaFBl1HC; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UaFBl1HC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqXazBcERSMGw7vht1cpBC58Odc8TE7nQdjKsFfqCoikYyM6x4v/RqfDNW94cfor++mkWe2Rz2lnBTHhg50uR4booxLQMpSA6SOerZS3dDnbj4Xtt6budJ4i0bHKiiZO6lGYf1FrnwbkssdUkklyTEtwVdWiNyLv48jf4x96LYMq8AFWpKlNRhgmHZ8DDfyHW+7KQMMXjWbkvtWy+jg4PrVMLjPXphonEAS3/MPgwuWlUPAXrcEH88DeaVwBwC+b0wSoO/C7qvRiBMsef0XEDHz0znH3PJHJT5TwS9FnWZKOeP6Y9ZS6LmFHS4Pha1X16rxeRcxZcHmHyi7V2sIQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85Q4r8eXs7B9OL01EaEeRwnW5Yq7I5pVzzB9k0+/GGU=;
 b=lFDV5D3oWgz31ptOCfBbb2BuYImjSZNwwnUYN9U+Ra3ZTPg8loPxHPp5d0+9ACC4CkgLRMcnpsE6XvNvfRbsG+deTfSYzTLrlIevQRqfoYJkBblx/hrcsM0UAkEmZ5MsP48e11nttnlZdrK32AFyvLUoxxxpytvWUhDGE/gOSlR2nOPpSs58cO5Rx04hp0ZtkAY9Cvug0QO65dJdlsOrMyPKFbPz6oN0W8GxfTHF7PrV+boWi06yvPkghtjvTDx4RtYTcf0XFqWWwmOESAIO1SCRPpe/hbi+ztlB8ST0jIaIKd0yr7C/LfoSMXrEEi9E+BPDvG/7GJc3UK/D+3mYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85Q4r8eXs7B9OL01EaEeRwnW5Yq7I5pVzzB9k0+/GGU=;
 b=UaFBl1HCip1j/q7gqYK6rYs7Vdzij3zvaRLSBJXbXimX8vej0QYCNS7W38bZO4YuZlDbfZEGrIH6mgbDW89QtQwnnHD9rMuQ2FnQI6sLojmEtLpAeUSQCxa3Dy8P8EtVkExBKvkqSHYBKiAJBjLBItp7uU/V5IAzUf9+gNadiTbGj5RAbZoDdKWFJOiwFvptlSoUQKXX/8w9MfKE9oNc8Maz5KeocS59n56YAdXLvYa5RkWSxgOgraM0jbp67+RegaW8Jj2iSTIqPFnTur0AcwtDwnWqf7Osga/MVYabdTCoLtzeY0m5Q8E1awR0XfOxZ5c0O32vn6Faq4Avzmc64A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 20 Jun
 2025 19:52:36 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 19:52:36 +0000
Date: Fri, 20 Jun 2025 15:52:34 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, qiang.zhang1211@gmail.com
Subject: [GIT PULL] RCU fixes for v6.16 -rc3
Message-ID: <20250620195234.GA3336282@joelnvbox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27)
 To SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e6585c-7715-48a7-9875-08ddb034012c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HS2EHTUMZvxl9pTqAFmZRvR/Xh02UGAwiPTPHQiC/fR81V1SaQiwg6N4OvxP?=
 =?us-ascii?Q?oUm4fRd4r1czqpBkTSX5SiXf4VVKbosRYjDxZP3n/KZsgOH/Apq42Tr3IMZR?=
 =?us-ascii?Q?4Zhos3Yqlmx1s8d+0SzPgybtpC6oRYHmzXCW1WdFxWr2LFpaqhiN2AQBYIqx?=
 =?us-ascii?Q?p3IqIkwIk9RPr8HHKueW2uYLup8bwkShvol4lvRHBQ2KzIUVx6kGPw3SCk25?=
 =?us-ascii?Q?mWiG9nNdP0K3tVPGhkgVKYLv3yjLk1hYNe0++cqkoBr7WB3taPGYLvj7fy3t?=
 =?us-ascii?Q?fU3RoMsPiufBDAsNm1i4xK0lH15REd6Df4L0DA5/ih+vHejESz0rZytGi3FD?=
 =?us-ascii?Q?9BNlMnXv40GlxgFSoFxzpnnUo1x87arwIRQjQyO+nOI+G2U4/xNrkZp/6LTa?=
 =?us-ascii?Q?efFbNM0e7iWlufPfc51petywYu0ScLC9HlP7DPKJN+jl0A7nqDUmWLOS60ll?=
 =?us-ascii?Q?5wfmfOe+EvnpkiYtrObMifU/MLU2zNa/pVSu/1fbNJgFLV5eC4565BHDpDPW?=
 =?us-ascii?Q?cplR28MVPYxk3eVDPcmZWsFCTy0/X8pEor7iz8/1Fg8FUG2OqnA1SaYcLPU1?=
 =?us-ascii?Q?A/1YdlObZ1WFP1jh6UedTOgQalKwc9gWSooFZsG6ElC0+ZZiPToJslp7FKGv?=
 =?us-ascii?Q?3TwWmG5KdbWK2urO9IPQs9u/W5ZbKa1QsGOdP9/ySMD822Yi9P7JFjO91Ixh?=
 =?us-ascii?Q?CCCxZx4t6atf4tCdh37ylAY8to5LiRPHUmCVfoGq8lMgX7alqfOW6ytRZsop?=
 =?us-ascii?Q?ndhV1KPp+zI23py79B497tsyZ8I9Ro9U++/7YuLDaadGFWJ8QfirAumj/2zF?=
 =?us-ascii?Q?RdwwPB3FBrkNORKpUZc52l1+IQc3jiao0lpgIeTzFdTcy9gQx8nSy6ZYbLqY?=
 =?us-ascii?Q?RIfi4WPuqTNVrHGxk0RPgV/xoKhBhgt+ATOhUSSdF/V/6mJxD8oFqdeOBfsH?=
 =?us-ascii?Q?gXjWVA3ids8j50eKho7SsT5Ur6M4NSbEyByoiuOjRgp6xMfPadscCnD0g37Y?=
 =?us-ascii?Q?LMdtOyLZLw04lAIbnPi0wVIH33Bnf/4XU/n/R0swbLAYM+tp0Fsu5FRA0sPI?=
 =?us-ascii?Q?PGGBvwdwP593JUBkuIaqlAA7HyEySucKZXOqrIShjtVHvNLAhNcKNubh7J+v?=
 =?us-ascii?Q?kSpICCcoYOowF0tLq+jKKXE/Hne7zLaqtwY6WU5lAngOGL3Vu9WMF+E+hllH?=
 =?us-ascii?Q?Zgms2JWH1WzBOp56dl1Qlbk7Zui/sSN72VoBHaT58110Lk+RjalfEzOUn5Rd?=
 =?us-ascii?Q?B/EhUa+3fQq2L5zmMGnT9Gltu3pvmjDvntue069m06HiQfLb8+W0hvqC5aws?=
 =?us-ascii?Q?hlwEm4ws5NLcR9F6JKmRoMQoliAV+mEwUyXfNnCY7GKC9iFOE/Lcq/ccJTL2?=
 =?us-ascii?Q?JBUbOFOiyaARn0Bl+GGUNz0CPBV7cLflYNXIewAK7kxMdmx2969eCThAWgJp?=
 =?us-ascii?Q?0GOWb8v4cCc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9K/bxwlH2gwMKcoqpXJLBs/rpePLn1mK/WCh2ee0YJZ1ViVWoG7ymQTfc3hK?=
 =?us-ascii?Q?vLSiy4sQM/ZJqMR58jBQFP/E7eal0qDt/CenyFxVbkDrUbCtrT4ffbddKdy6?=
 =?us-ascii?Q?e0FUadn6csvnqOqFA754cEthV+F5AQWXGVAml1exOw6FMy9GQueIkKpKu008?=
 =?us-ascii?Q?BUOQxniUhg+33ElU61SMHbPRhcud8NnRXXayj407m1xFwm0q/Ys5Vs0fcxs8?=
 =?us-ascii?Q?WrrDd7wUFgJkbsdpGR7gwUXWYsr02RM1hBXvKvhtJJSVPG9AEBs2ITHHCUTx?=
 =?us-ascii?Q?iUXxTRZjQJWAdBFpDiyfpxGQffxM2Z8jjsZGCFICNOXYSl+jCAzxajv3rsXg?=
 =?us-ascii?Q?d5mJTYa2TqX/hSnQ4QnYU9cfPsIREUVPKPhVpP/6PpBEzAKU5lOc7gcQv1w6?=
 =?us-ascii?Q?sIIciR+RvzWb2SYhZ4mvYQTmlw5Urp8fjnT/GficK2I5R4Cub/bN2dCSwgp3?=
 =?us-ascii?Q?6q5r5+HML94PCJKUgDguFYE81w7Vfnph1iWRyoRoLFJvOSFMg4Q9f/rhXzTP?=
 =?us-ascii?Q?4/uMN5Z3xNIl+srZgLwvtS90i3MglB+nNIaz9LmQErCo3iHFjm59PLQpgHC4?=
 =?us-ascii?Q?+jTDmQbKEi6CHQHGQ8Sill48DWTBLAbpkMpTrkknAgdVLhDtBp82/USehNlM?=
 =?us-ascii?Q?tQqMFiywmv9SmH3UbdKklLDMjIwNhCMxnGL6W4F4dOc38Pxi07bXA2EgMMcC?=
 =?us-ascii?Q?CtktnNBxiqIrXF0ioniylgyCJx7P5RShnuPWTxxP+YbYervoivgxCpeiCRJx?=
 =?us-ascii?Q?RE6sDjfN8NHErsbjB2npKS7SoBPkQnVOHOGBBfvkRDfA/WdpGbYaZiAj2/ta?=
 =?us-ascii?Q?CGcZLWJqzX02ITDkxmuAwVig0rMVaVhlut/VRD2Hcpnct522gzD4Pc7AMcvl?=
 =?us-ascii?Q?sseJYqoBA16Rorjc8IgGA9kf5WSvDyQpOoRB/hY6HMIWya1K3ZmS7GRjSRAv?=
 =?us-ascii?Q?1yxrabAfrSRNJT1V2Y5LnkkOHuLPCOwa/J0QaWMG2aZB8DtB70ll2psmW72H?=
 =?us-ascii?Q?d9nTrYSBwu4Oft0q9ZlN277x49mL/ftgxLn1REgLIahmTLsAFRE09r9aFvvK?=
 =?us-ascii?Q?mZG6mUL6GkAM4SgEVDiCAoVaGOES3HO/0rV3coRNwVWEQWeWGbcfFlaoqcQp?=
 =?us-ascii?Q?RZhbNyWZAyTac0DG64ENcplW9xjq0+TP8796B1A9DTkzgdwsadnASpDH1nsw?=
 =?us-ascii?Q?IhEqIe+wSWY1Tm2o/N33/LMjch0AafjZsyt/MP98kAUfGNglAuDRgC4FpPVs?=
 =?us-ascii?Q?WHZ7CBnQM8I47R9JrZf7hokj2Uo5xe5VECSOvTDIEnqP/+/ngvn/Mc/NORrq?=
 =?us-ascii?Q?NhYBGv1RPms2BlkGMg/RZRrT7F48JeaH29D++ubiBMlEzUv/lZ9DK6Sl0SoE?=
 =?us-ascii?Q?0zqpwy3m4yGfJCmE5BXx0X2EAKcRSYmgpB5L/11Z74b1CbIsZpL8eDnASmY5?=
 =?us-ascii?Q?kocPhlnUM8gLW0hiRjBb4LbfyhBytbVnJGWpmopHntxA4jfqcAmlIW2Nh88L?=
 =?us-ascii?Q?g7CLzPy3KcyiEOEhm7eS39qUhGSkM32GPIEmB6Cl3ThSf1DMGPVYmF5ZY5zC?=
 =?us-ascii?Q?/sY5aOV/cOZV6sxVuX0Etov2M2YvWZ5XU+ssKEm6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e6585c-7715-48a7-9875-08ddb034012c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 19:52:36.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPihsoEjogchJrSAk8d0sTenOXsrDgH6EpXEfi9THhf4JoUxy2xGDEAynyIp48aHZI3u5q+qjJ5U3hIBaZ0O7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544

Hi Linus,

The following changes since commit 11313e2f78128c948e9b4eb58b3dacfc30964700:

  Merge tag 'gpio-fixes-for-v6.16-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux (2025-06-20 10:07:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu/fixes-for-6.16-rc3

for you to fetch changes up to 33b6a1f155d627f5bd80c7485c598ce45428f74f:

  rcu: Return early if callback is not specified (2025-06-20 15:31:48 -0400)

----------------------------------------------------------------
We recently got a report of a crash [1] with misuse of call_rcu().
Instead of crashing the kernel, a warning and graceful return is better.
[1] https://lore.kernel.org/all/aEnVuzK7VhGSizWj@pc636/

Uladzislau Rezki (Sony) (1):
      rcu: Return early if callback is not specified

 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

----------------------------------------------------------------
Uladzislau Rezki (Sony) (1):
      rcu: Return early if callback is not specified

 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

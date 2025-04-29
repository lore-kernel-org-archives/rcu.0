Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE1274FFC;
	Tue, 29 Apr 2025 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912208; cv=fail; b=RU5Gz6zZvhaJlYnoVh3WnxrjjNsutJRJn6ncQ+Xl49uSTiAWUWzBCArQEyjymdmhBdQY5j4BMbotDfMfAIMcRzhxtSyt34JCF5q8r90SJ+yHF7qMkQF8RytOuwhsY8e4xPprmWvBd/5amsqry5re5yw55wuy0CV9qPBAlFMQFj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912208; c=relaxed/simple;
	bh=3yIJMmbcZuEvO4geygWBLB4YQAnmNuAXQZU2DJJuwtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hQsX6RCZ2vy08WOnAzfyFEDcdiwzHmpWt+A1FZ3V+QuGFeeDPQJGYDZpSI+nSPFdgcKkqzXvwp+/ytunDZDDtFC22RErFjGX3gg8+2x7eP8duXDw+maB21QfiO+n6s1PzTjqryzXlcwxs+aIPLPDBkM0RwSuy2cpjns21NC1Cwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UsYINyWO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Px2DIcJV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UsYINyWO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Px2DIcJV"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T5agYF010509;
	Tue, 29 Apr 2025 07:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7PZ3rkgPg5YfRlA/3W
	oYVRPPvOljpa/erUsMpYWpylM=; b=UsYINyWOmFR0MIUKsEsl0ixwheiDWIiQcF
	p2dHGoiYufr3clv/JAaH+W/z43NA5zp9ESFoTQT4bptFq+pew9Cgy8M18uSlXZcd
	a5CrEC/xIV3E4HPyIZf7c+NFVS3Xq+w3l4kp/aho9rgm3ema3rjIYCJjxdV48XKI
	0aZQCCY1V6kpDqkjfRep+3GaQwKUi7ziJD5pt46w2pbXou1ks2BBXZ9BIw6RiJ3l
	3yQ+lQ4dXO+O6ehy0lGOvpJs77njtNzHayVcgMqdsBjjy0qxhplsnDjufKeDCak+
	P0I6kiQoWgU17CG98oljOq97+rXbjXVKXzeIwFEZYarGkllR5JdA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46aqkw08sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 07:36:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53T6ofWx001354;
	Tue, 29 Apr 2025 07:36:24 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx9fbgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 07:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjOUd7Krx6y0vw/mY9Sup5rS24gVeHPTVlgVmsxFG60F3dEca6PetwrFP02goFadQNf1a36yd1ppLD1rPsNlxD6rPVRJ25C1sa8QezmMUlE2Jqcs62QZRi+enGx7n0gX/jk/vx+Mp3SQtbNjzTBGAIvRCVDewsPPCHkqkuEwncWYFMEVKsakHAlB1zd+KdC2uhffzTBp7BR6IaOcL0IjGMdeB49m/Ah3kDh803hIhaBo+RbzGJwlS9EULniEqxq76BSaGHW1CIyo0taYydXcPoUlGEoLJKKq+yNF/jTsvMNOilWF8UeAG8aTFBEJ06SRY+bTwbjFb51sFIam+22LvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PZ3rkgPg5YfRlA/3WoYVRPPvOljpa/erUsMpYWpylM=;
 b=OHuKDadN8xGu9pZE+qxJvTwyRlKoTVvLwzE+VMZUcdoVkofmGX9Q73xw3QJ1+SUjH3dUS6lr9aIpyzUVzdxefYPt0fKKy+YZZkpSp11+7I7qrdxQQkjqB7c6ourXLSxzlZ29PTOlLw8ssvMf1STHKkh1BMxuTej50yKY3GQ7khutlxpIiwDmpd/aRxwy8a8Fejw4UYdcYWqWR/YdMZ434MFtWSMI/PKj2p2tiImxgrd9bYiIjsVPeokyJNEkx8Kr53KUmJJYWMBeJBFsLHCALmALdNxUR8RwjMzxoFj/kt9C5Zp9J6NEOBF9a6EprXlOhONz6y1CjSzGMBkMUwOaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PZ3rkgPg5YfRlA/3WoYVRPPvOljpa/erUsMpYWpylM=;
 b=Px2DIcJVSkJ5asoGanvXdcUhPOOXGBkkSgWI0l5UOLQ32jl4jLCTO8PZ0fe5mcDoh4KJrkRVhkXITOiVfNDcBW3E897PBVZer5TtRyWv8u/ld2vqj8laQX4MZm9eGkF5hb5gMh0i9RUgJm2UQ2BG/SWs6I+9DfEDCojVLoqedRg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH8PR10MB6670.namprd10.prod.outlook.com (2603:10b6:510:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 07:36:21 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 07:36:21 +0000
Date: Tue, 29 Apr 2025 16:36:14 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v4 2/9] slab: add sheaf support for batching kfree_rcu()
 operations
Message-ID: <aBCBblup5P1F8SPE@harry>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-2-8a636982b4a4@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-slub-percpu-caches-v4-2-8a636982b4a4@suse.cz>
X-ClientProxiedBy: SEWP216CA0024.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH8PR10MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 97103b38-c498-48e9-fa28-08dd86f08956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y1kQQRwnhf5LjcGqTytsAT30YAYGuJlezp2QzXtB6GuE/7enwA4km/4MhUbZ?=
 =?us-ascii?Q?/KvH7w5JZhq8aX2SHsB10xAbkI8UtWXD1NsQIjuQOtWHRwe1DsujAUwF5ilD?=
 =?us-ascii?Q?rI59T0j4ZclbzarmyDAQon/83POgGX+ilYMvuH3WHIoJU4CEnnzgovx3gQb7?=
 =?us-ascii?Q?D/36pBT637UoEz1Y3Xz14COW7vFJbVU01bbEs2IPb/QN8iWUfWAqgkY2lMj1?=
 =?us-ascii?Q?suLzDPIf52Hz3cbBZvXeKPvEyKTNiaDfrWd1GtgpwCZOaGMCWgOEhH4RKyhx?=
 =?us-ascii?Q?toZ7MX/j5z18H/DoFR24F+2YVpxc3B6kkoqvJARqy+d65+Z4Ik8qORLlmT94?=
 =?us-ascii?Q?oT49EHVQeK0z7dMi4PeJtYYFdt0gC+IuV7X7a4obngoO32eEGfCPM7Q2/dM3?=
 =?us-ascii?Q?t20z1ybR6Fi3FPbsM2nqKOCGxNeHK/VkZsAqtQGYnkI8UUYyYB0SiRYUjJ6l?=
 =?us-ascii?Q?O7JPK7vYc9uzxfPocUnTzjDy2ZAJ81bflWNlORu/rG9AIgkUkilZEg804XAd?=
 =?us-ascii?Q?X9epish1HeQMpC/tjOMcI3SaxBY/5DsT9qdkJcbQjJ8MkQ9thUFQ1aGBWdQ9?=
 =?us-ascii?Q?Qkhay/NRAvVB5FykzAFebtoDgrAku95idogISxwCGYwYKxOzESaR+ywiG+8+?=
 =?us-ascii?Q?3P0ath5uCQLkw0PnwFDnjGKrpmxr8j7xErEakr6dpoGLjhoMjGFjxF1xDVW1?=
 =?us-ascii?Q?28yC+9Fzz2OZaZQwdnB/qCviAeaLvvjegkUCpK2KA/ND4lvWJMiw8SDq9mNx?=
 =?us-ascii?Q?RiPzBZH/ePlSFxQr2Is43SwpOWDayPXMzxJNCWUg8tEOA+wukkxtIEc6okuo?=
 =?us-ascii?Q?x4MSSrNI/osfhLgLuFGm79iOERNV4807I1fWiW8UH5No3J5UtRKoTMRLc0R7?=
 =?us-ascii?Q?sXaamr/KwWD8pn4gIPuE2pklxm9vpSWlpeV+HGlgvzLidgb8unAxcb2LtCey?=
 =?us-ascii?Q?C5YK2Urs+oQGNVeuxEWQHPUxYDlE8/AyrN6U008ZguQ1/qZ7a0SNnHr95FWu?=
 =?us-ascii?Q?aIKORSs12IsnoVLlzjiwehFxtrh+fWWy3CbcVrQUyJ2DGsAzqgE0qSeEKVuk?=
 =?us-ascii?Q?6e18onU291klDnFjFNwjXhCTgj0hDoe79zscFrEqa7yFpXittmO6ZmTlxZ88?=
 =?us-ascii?Q?OWB5bYLq6Z+EHUfwtaU0IZoTAzVJh0rNCUemOk9TaaLszXiRlbFUwgQCCp1z?=
 =?us-ascii?Q?ayC1F2JI+GUYFuOmNEgnIeV65ZaGZ8NZGWtsLAGeBNy581evW9UDcDth3rk2?=
 =?us-ascii?Q?D21VP+K4aRMnJ+k6jO4+pZkqxLFCf1upTVvXcAa8K+LzCSqq6MTEKyz74PXh?=
 =?us-ascii?Q?HqtyuprK0U0BtIfA0s4oxfRIULjc21XqYMRDzVzvsY9raCUtl6ngvtjuvZ7Y?=
 =?us-ascii?Q?42bTtuNCz0pSd6MV8HV3NUD3q7h/qBE9j2DkrLxgnS+whfBNcbcOPHSKZ6zk?=
 =?us-ascii?Q?x2aW/1wLoVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iZY7tn50COT2azZ1nBbD4G+A5rZUs5pSPsx81y9LT0TNLYlVyzfVg/qPOgOT?=
 =?us-ascii?Q?ico/l/yJXEbxb6yI+5AwZVYBIqyDX92BB6X6InnPNSDO6NHpGQNMAA0tt4gc?=
 =?us-ascii?Q?ASno+nhT12rnIjUu4ErxYX/Dr83Lc5fB6UC6cboYNu5c5jhtlDTv9pUY+a4H?=
 =?us-ascii?Q?/tU8TaVNWAmPcB8p5XX62kUEjoZh9St74yTQvkBUzduBsnOgNnGa8i+LJIoM?=
 =?us-ascii?Q?KdH3fU69slK3iF1yt/VWyvw7KLleQNUrbhKcC5fEULi46JyTF38QhH5LQgdJ?=
 =?us-ascii?Q?bEbuLZYSdaQACIZWdkRZ+GN7U/Qgiofp4h8OTxpVnZsr5mMQ+NndctMA79i3?=
 =?us-ascii?Q?AJIn/sOL3vtPHr/gjd2w20VR8axAs0UWhYMapF9tKyDmY52qp1iGu18kx1r/?=
 =?us-ascii?Q?JCDqO/W7GmN8ydqZMESV1WaxGRl+qbUBjM97CZhso7Chq8ze6VnOQA4wbsyc?=
 =?us-ascii?Q?TU9YFX/2+zMLnPTm4KLUomKi9s0YPox8LyvCt71jHZQdtobYxiqPQqEahkZk?=
 =?us-ascii?Q?084o5YJF1w4Dj4PRzLCdrg7reJLl+zT95hG3dm/WlqJ7wD0wAbP2A14jtxK6?=
 =?us-ascii?Q?8hBmqJLf6UdpLLe7iQFIk3+cBuH6u+3CqLReB8nZnDKt4iFCh+0T2MlpVNaC?=
 =?us-ascii?Q?sQBqLDZMCZsPE+kbRJ9o74ogu+zhzJ6nVxBeoxlkQV0wZB1vQ3tXRODdZylX?=
 =?us-ascii?Q?oK4GjaNqIA5hoMce2RNNrf2gMeaubz6UWfn4STk84UgTFnrzE/1PvU2nIQti?=
 =?us-ascii?Q?foU9o9P8wjocZNG43EK5hIiGz+ZSviJMiRUTLIXwpO+e2EhX7Wc1vO8/77yX?=
 =?us-ascii?Q?/K9W1RNh1Tw5IZd4VNvbVAmwY2W0G8TimR9ng4S6Uop13w7Wu8qT2jwh6Qxe?=
 =?us-ascii?Q?ZMNwmfNys62g9AuRu1z+bEkYhXKf89GnSyMFEqwmdkJzmk1X42D1almprNN0?=
 =?us-ascii?Q?Hcn7MCbohazMELlLSJt1Pgz6yO6tymBMD24vlB+GLEpVoWr4n/Pb5/UWbn9c?=
 =?us-ascii?Q?MZlWdq3P5BmIj5teQKJKnT+0pYmFCIn49Y5Xl8JgHt6+9oLtII1tXZqkEWZy?=
 =?us-ascii?Q?vUYhz1RRcgLj4/tszqHov8Z/XbGHgscOW7TWgSUjWOBV9yk5D/KPnQo2JFfJ?=
 =?us-ascii?Q?lp+CUxkEwD9+k6U0lkjO1Ets0v+zdECFkLMZGfX9NJ4WDEesoHWPqiU0b6qS?=
 =?us-ascii?Q?1rew1imMMTVW9HQ7HVrfEP8ogGjZoPr77mFDTuwbNFwrU69jdewy9LfEmMIu?=
 =?us-ascii?Q?ndO4cYJL+PpO5B0Xso2se+os2Rd2p5xdK2fMm9OTUyUCHi4Kyj+tXIQPKXnU?=
 =?us-ascii?Q?XtwiF0F4CdHimlcJAE4kr2uI7d8Cr9TKdDb6K8ilvSi9r4TFneKKkPp5WZau?=
 =?us-ascii?Q?2i1PPkb78oQy4dCZptxGsfFSTW/V9Dtluzk9TW4rsrna+p+7OiKOMJo2uH0m?=
 =?us-ascii?Q?nxINeG3nI6KLillTBjrchi7cm1Ky/n4MmDy9VowkDMs3VLm04LmmfVhn+oet?=
 =?us-ascii?Q?sNurWESKFzbCerAjfGdaRsk+uTkB8zOpMH6zXITVLalS2aSz90IcDyAzzIAb?=
 =?us-ascii?Q?Mm3TSWt9E40CVRsNSSfG4+oXsViGIHIT+Ejd25Zv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UHScnfg20Pt+GyCMbUguGA9HciCEJsviXP8/8zQ6+kL/BnRFbu58G80Cmo9MFUPv5nw8utTqrhwypfC9Mrwf+3TqW6fl5Ls2NupcUF0bvpWDGgHqcql0YnmcAdegHYB/TClCeYahKsOgiASluJIpo/spfDVaKsSFKSymcbIf8FjYn+2ZKjhau4Wt5AT6s9DB/3UfHebjW8C7e0uwao+btgtmjw2ezHPneoo+8HUXr1TQz8qRPyC8FxGYNDUVNTaJMlIeJz/M5cGoY4T9RmbLx1yf6PT7Puj1h5+Ic+rTlbRIbKLHfKmtKiQWJiFBjSP9FHbIOmfEuRs/yuxKiRIyba0JlOTBPP4I9OqvDjtYYlMnGp+cdTJDTds9sFPX3SHv8YggstcNwaC20JvIbCtsEO6xZQATRX2ZnRbTHKaDsV9+w9dYOQMQyzyV6dp3BzzC0GrJZqj6M/+HpRdsQTCCMxxwDxwyDuYQOtvgwuBdyJZjjjSmN6og3FmtSiBaWUmlUYmXkdjiRfcq+6I2eX7qtRFMmuiFTuT7oShUwcsTskyPtlVGXHwiNAdtSCHhnqSy1ZIeTjrAVaXLlIdC++R9cpDdSGZ/Vbs1sWxSeflGlXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97103b38-c498-48e9-fa28-08dd86f08956
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 07:36:21.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amgv9zu6++3VqeEEKY5yGlqZcKjsZDWCwkiK+JixBXtv8k2+Z9L2bj97CcBPrpCCoKB9qw+HRmXzvsa3iNysJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504290056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA1NiBTYWx0ZWRfX5fnPD/83i6B8 p6GmGGqoWkuw+3ji3o1E7/zZIvuYpEFirT2+p8ynV//gunidgNNXj6MBqLTdYFaSWGkFm8iw5d3 3WjotRTUZaKykKKO3Gs6YZ5DV+jS9meKNCg0juduhSOuGDIpyXOGHYVPS8kmTn6M2fc5wa9bnWg
 e/vXcj6j25Z2r3zTFOcvOWn2wzuOgS63ThlEPo7Etn2SiVHQnEsS5l2NysDr8ZVuk9M+ysdyvrV OZzwLgljF7pRV4m4QwM5oq8lTg/8FtzlFAjQPB2oRwx3ODP5NJx/2B1DTyHYNSOpL35NZHNTwWk 6N723PYJY+QD2gs54V3GCjrvht+pW18D9kttfypQXx3i+pK6M6RYCCesmDm6vkIPRmlXJoYRYrj tbl8glL9
X-Authority-Analysis: v=2.4 cv=Za0dNtVA c=1 sm=1 tr=0 ts=68108179 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=mYjyeNvi2m_gXkDS6jsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13129
X-Proofpoint-ORIG-GUID: p9iR_2F15AeTOvGsQDNNe8-cYewS5uc8
X-Proofpoint-GUID: p9iR_2F15AeTOvGsQDNNe8-cYewS5uc8

On Fri, Apr 25, 2025 at 10:27:22AM +0200, Vlastimil Babka wrote:
> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> addition to main and spare sheaves.
> 
> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> the sheaf is detached and submitted to call_rcu() with a handler that
> will try to put it in the barn, or flush to slab pages using bulk free,
> when the barn is full. Then a new empty sheaf must be obtained to put
> more objects there.
> 
> It's possible that no free sheaves are available to use for a new
> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> kfree_rcu() implementation.
> 
> Expected advantages:
> - batching the kfree_rcu() operations, that could eventually replace the
>   existing batching
> - sheaves can be reused for allocations via barn instead of being
>   flushed to slabs, which is more efficient
>   - this includes cases where only some cpus are allowed to process rcu
>     callbacks (Android)
> 
> Possible disadvantage:
> - objects might be waiting for more than their grace period (it is
>   determined by the last object freed into the sheaf), increasing memory
>   usage - but the existing batching does that too.
> 
> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> implementation favors smaller memory footprint over performance.
> 
> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
> count how many kfree_rcu() used the rcu_free sheaf successfully and how
> many had to fall back to the existing implementation.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

with a few nits:

>  mm/slab.h        |   3 +
>  mm/slab_common.c |  24 ++++++++
>  mm/slub.c        | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 208 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 1980330c2fcb4a4613a7e4f7efc78b349993fd89..ddf1e4bcba734dccbf67e83bdbab3ca7272f540e 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -459,6 +459,9 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
>  }
>  
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);

> +/* Legal flag mask for kmem_cache_create(), for various configurations */

nit: I think now this line should be removed?

>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
>  			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4f295bdd2d42355af6311a799955301005f8a532..6c3b90f03cb79b57f426824450f576a977d85c53 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> diff --git a/mm/slub.c b/mm/slub.c
> index ae3e80ad9926ca15601eef2f2aa016ca059498f8..6f31a27b5d47fa6621fa8af6d6842564077d4b60 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5304,6 +5340,140 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
>  	return true;
>  }
>  
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> +{
> +	struct slub_percpu_sheaves *pcs;
> +	struct slab_sheaf *rcu_sheaf;
> +
> +	if (!local_trylock(&s->cpu_sheaves->lock))
> +		goto fail;
> +
> +	pcs = this_cpu_ptr(s->cpu_sheaves);
> +
> +	if (unlikely(!pcs->rcu_free)) {
> +
> +		struct slab_sheaf *empty;

nit: should we grab the spare sheaf here if it's empty?

> +
> +		empty = barn_get_empty_sheaf(pcs->barn);
> +
> +		if (empty) {
> +			pcs->rcu_free = empty;
> +			goto do_free;
> +		}
> +
> +		local_unlock(&s->cpu_sheaves->lock);
> +
> +		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
> +
> +		if (!empty)
> +			goto fail;
> +
>  /*
>   * Bulk free objects to the percpu sheaves.
>   * Unlike free_to_pcs() this includes the calls to all necessary hooks

-- 
Cheers,
Harry / Hyeonggon

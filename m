Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEDC21D3C2;
	Mon, 24 Feb 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386483; cv=fail; b=RnGBHfmR6m1mrmZ5k/6rnzY4kAbp3OOlAIUrFLcw0hR2ie1LyjkcgThwOmO4DREDM1yERqtexl+yg2SRH9IQVRmOi2NFSMiOf/yI+ZbOltnV8G1xi6YDIf/23S5zYNV36cO2y4PAg6H3bMjA9IR+16kgHr/YWorsLuEE3Ssox2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386483; c=relaxed/simple;
	bh=2RQQIdnSvxiqAva74Ww4HrbUKweRKB86woVYUZEyicQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eutxiJemkG7ChVwtTlxyG5O5leeebu3foO89AQnKRez7iatYnowXEd2gGB2lG/ZR/3FZ8Yd34n3AbW1YEkl8BQPGMq4gebobI1432Knfik/ml8U9dF51HDJh0AcSpG1j3NRBs8oQNwD33nSXZPuyc6SBavtLbO+It3AdOLBj+Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AOFLhD80; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y5dFhMYC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AOFLhD80";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y5dFhMYC"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O7fPDB026985;
	Mon, 24 Feb 2025 08:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OkIv85mA61If/mHtoi
	lrSz8fH60L/GdpByl78Z4GeaQ=; b=AOFLhD80rwJGKSgDfZ21IrtRfnlbNxa4Jq
	c6JLCUCMNBhuW5fxlm5RHDAAtNTeXoXMa9VacsxtKMH+yPO8yza0amqPFwDKKRjM
	uCMI6RuJ1BAkdPBZlaezZ+groQG3uWaDzPH3wvn+84MeZJMQgfVYS2v+/85jxZvD
	G0OzqYKVZOh2GQppoiTfkCzJnZNYaQLYiGFQxpv/jkTT1kNZawN9YtZxgECPwOGE
	tEi2vZdFZsg02fXTZx+Ojh92cJC0rfFpcIuJ0mme0U7AsUcCZ6jHNIW5IFWyPWD1
	2vEMVHUF8rqzUhOgmQrbVuznuqVJXm020yC8la/RHiThfe9gLTtA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5602331-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 08:41:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51O7eHe1010209;
	Mon, 24 Feb 2025 08:41:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y517468k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 08:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bO3RLRdibpvBEIeyo1gyE1UwtoiiiZ0AeQg/SxtHTne9Vk32rirh25dhTr15umogD+Pl62T7bOgAIyeJVvyjuNo67EC8IleNn0KgSKPbcjaAyptcRgaO+VtVApQyBhPIHsxzeCA8Q38oZlTgwTRJ7gpu7jf32m5LxAVn7VuXdn092xNeoj1/h/nP9/6iq+BI95EU0zVE4fhStvP6dTHFmV0aR0AQwRN+Bb8/LpMU9MnTC0lQkKt+Dd2MsDDnqrcQ/6gwT3BX8QNRog1bEFpGd6IDIIymEA94pqSEoZEzHIJ1M+s/gZx3dCkaXMkPAeTtfxgZ/1WNxT5BZuLa7sExYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkIv85mA61If/mHtoilrSz8fH60L/GdpByl78Z4GeaQ=;
 b=OsY3QEDAZtKzXlXVGujulBL188s8ur1Y53fn2JL09SeUOXBnCoafoZmrPnybLXDurAIUcMlMdu6D3tldvAmiz8k2a6ul1chgM8Ix8yoDIWx+Wx+teeK99Ifwjyr86eOMJ6+LE6nrsngtNo9HPvNsw/XC0zlIDlTjGKq9jrdOk3XwV+OkMyDefpkXHFWTHHR7nor+xcye1rj+rLZiZRMeYrzq3ra4oq9nNACix/EJaADJ7QPJObNk1Nn2jF1H6W1DBeyoY/JFN9o6Iv7MR78hlWusPScceUu+GwLaYcSbGTjUtE2nlhgwD0y4M1TWV1zr8tjpV10cJklCKebBWYC+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkIv85mA61If/mHtoilrSz8fH60L/GdpByl78Z4GeaQ=;
 b=y5dFhMYCMvphWCHmwK0qO3EPTFoe2/uQzqav0DX76lJoKtFPuNGq6H0Zg8c4RRF83oeQJJVt6ZWgSeLQCGl2UmA/I47WtHwV9MYqAZuG+SuViAudxEAzFTLfzoi0Icvzng5mjLVk5fh9vG38tCgzZF10q5Ob1a+PuD6qy8IqtRE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6441.namprd10.prod.outlook.com (2603:10b6:930:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 08:41:00 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 08:41:00 +0000
Date: Mon, 24 Feb 2025 17:40:52 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 02/10] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <Z7wwlLQFBDlcmsDT@harry>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-2-88592ee0966a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-slub-percpu-caches-v2-2-88592ee0966a@suse.cz>
X-ClientProxiedBy: SL2P216CA0099.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 127f966e-5ff5-44fb-2fa8-08dd54aef6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Qnxp/cTFE4uEHLXTUYmAmM3ID2HZ7JWivcPV0+NYKkGDaPtaJV2Fb0QiiWz?=
 =?us-ascii?Q?gjrMUZdYMUPBOI36etYKkLgFJaUX0/Y42Was6D7p/ebfdkFUPnvQwH89PabV?=
 =?us-ascii?Q?8J3JrNivCO09AWh2QONdLeUTC+MmncKdfFOl89xlEEKpQopM6ona+GZJRCIl?=
 =?us-ascii?Q?WVYON28y0tyGt9l4o9M7lHNlYk2iIZqSbWjRnsgNRAQzd8pyw3P+WDtnCRps?=
 =?us-ascii?Q?scei8UT2MgmXlOZaKROdZqNjFzI08CxgNmU66CQmX/hmY4n9muwUGkpbnm12?=
 =?us-ascii?Q?5CfuuR47DDHMdHL8QSfw7pU3G+M00+GAUYhHGFNgTkhvrHdjxmlu6/WSxJTu?=
 =?us-ascii?Q?mSHFIOOVVFzV9ElVRsVUigFZPNVpmkwxnJzdMnNAm5U+7k7/OYoqGIwE4595?=
 =?us-ascii?Q?Im9dKrmL9lg+itwfZiKOacJhbrfsuRUHUq6LDvgDXS10oLwi2azoF55GAiCk?=
 =?us-ascii?Q?TmQB2wGWVEjyUX05BoYzJbx+ICkoLzX4qLA+e2/DqFHKiiUnw9kD/NvH0HGr?=
 =?us-ascii?Q?mypPD19hCMrIQXrF/5M+wzsgF/OmL+A/l4s/oBDMxp76ZGN6gI9URR/DHyjP?=
 =?us-ascii?Q?LXOB16/98KMdTJ/Ee5F3+1jRD3gCGFFIOHQqbL9JuVmqJI5DJxN1c+fHbw/q?=
 =?us-ascii?Q?gWF9+WrzkVJTlj54kxWwe49b9Se5Ak/UanOm4ue+Yd4clpeSgxoB0DHbSC/p?=
 =?us-ascii?Q?gJvIrCjYj9mxnlSc5grMDgzj9A2uGNANynr4XlFOd7ZB1wmG2y2jsS1d6TDv?=
 =?us-ascii?Q?Va/xK1bXW59hXaLOiFhxACdSXeWNQFITD3reH4YfGhjeVsO2ZE6VZhnczWYu?=
 =?us-ascii?Q?Fv7JGRb4NKJqb8eXFm3gTsG59jCk+CkjrmTKz2dkuF2BcpeCsx3xXF6S8qJL?=
 =?us-ascii?Q?BK0yFMJQewMEvf5hALIBXPFryA9BoVMi2eTMy9adUSiYl1btU4qEnVxE3fah?=
 =?us-ascii?Q?CC7X87H6yB1NqhZynqf161DJocM2lue59YEQZgvqYSIqxajmGCCWWRwmRrmY?=
 =?us-ascii?Q?P7kd65j9DLJ+hFXSUz2vuT9ZdllopJ6BRIup8U4vTeuiCqqIjdqcP7t+LEK1?=
 =?us-ascii?Q?d6fSZTbLYGVoxpaDxR4bdEwrBJKwrQGl7RJxvyB28w05HgT/28pstoppubg5?=
 =?us-ascii?Q?KrzT7Bq1qIv+K95KyAH8LQ7hE2sjPHw5MxH6N8jO/Uv7dY7iG0YV6W1gwkNU?=
 =?us-ascii?Q?rPNCx2aUdaJt7HM6mhqXEDNn16wCwwpypeM0SBhzCBadu+UMyktIwXuJHS5y?=
 =?us-ascii?Q?aJ+Ldf63IocR8Bnh0fh3OaXbr/UvrOln4HeoE7l0FHQjh41NCJ23UNkCAT8D?=
 =?us-ascii?Q?LscFbWEzF3zGx8H6vW3F5E1OkOK0WVldbRy+8gV0ZdYorxRaS6mssBKAT2Ww?=
 =?us-ascii?Q?KsiI3CBOm3wQuzKJuFu0bFbk4I0A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8xbtr2SwXcZAH9Ir2JPZkQhVd9hOrsHhH1yvmdJAnPHUGQhWdKXtWtAjh9Gz?=
 =?us-ascii?Q?CS/Uq7Ssv4vOd/IUuUv+0SECylbRYvUpVo+PnWcrtzuxyOIeBN5tBP78uGrt?=
 =?us-ascii?Q?bQjOHCkm+ev9yAe0TMzuF54nOnVWLGkmV6ku6wlHXQqZ8qH2S02sc4FciNuB?=
 =?us-ascii?Q?g50N3VFKxb1DjozJ78uBse1ltQkz0lxN3OcPQWPJeQWswbXJ6VEg6XAP6Qm4?=
 =?us-ascii?Q?FB5/tpWOPplN6jN5jOnkz2isW5SHQidTsRVAfakqbqkHZKFeKr1JYih9mHhi?=
 =?us-ascii?Q?6xEi0l0TOhU6IoY4PqtGTU8k8qAQVxzT24koWjIfooC2FbvaMqULwdW6eyKL?=
 =?us-ascii?Q?It5D4SNRxA9Q0DPPlDtz0wl2RPraHK1soINDzMRVQfYpWLRny+Ogn9OW1wGA?=
 =?us-ascii?Q?gbUG+5iqDE/oU43XutK4ejUhaEpNlBI93eXH4s5JJs5LaQ4APSE1ZDnoFRD5?=
 =?us-ascii?Q?1G4p0p6HUzt6DwYxtB7P/U0qFYh1QJy1/FJ13r2HTpRDHTXY1HSxaaLhzK1p?=
 =?us-ascii?Q?FQ1ynpLfZXUNNNkwO8j4IYLK5gXPiHsGJWkoxLARNMbPjEH+Oioda4TmB/Fb?=
 =?us-ascii?Q?nRB1bYl4uMZ7xlAs1+OOTKWjU53d0uTjq6cWKuwsN3shou5OuDSv1prgeNrR?=
 =?us-ascii?Q?LUMJVstAUD+d/u+wL3Tkozyd7qK7gKv8eAJ93cY0Q4M70sb+ikjJfja8nkcm?=
 =?us-ascii?Q?bjsrMpcCeghHcyF5rQzsaOBTizAmsmovm25FqbQvFg+xCAQA4SpiE66SQNQ2?=
 =?us-ascii?Q?NXdc/LhiVF0EHa51zMiZxT3C/0QJX+nxZzt80XAfrwU0a3QPdH/KWMbmx7DA?=
 =?us-ascii?Q?CHPNlhg7MdLEDb1M1AGZ610Gz4vv2jpVX4VwOyVWnukc5zRbo0gSldrl0Pwr?=
 =?us-ascii?Q?GwyomrFAWgYyoSN9R2qFMkwE18E84Owl4X8EOuon4q9CszsIPKZC5rAk7ou+?=
 =?us-ascii?Q?0C351/POj75amVOAIo7juehIziJzYVbC3xGBE3/jM6kVBMFCCGKP5BQvvt/4?=
 =?us-ascii?Q?vMZgpDt1la3Oh87CuyOolvdGlAv5eLLyEBCPj6x9Walpg49sHoJYLdL1Etg/?=
 =?us-ascii?Q?Am80G9F0T+5cAN0xLg4OJ2pkXSJ06tI/5tsadI5YXgTHq1cXZr4KOPTB5wAh?=
 =?us-ascii?Q?Cx+OticgtZDaY0GaWclc07U+E9Dg1hDBqlMMwSP8UPo4HDgSOOIaZEHAvaIN?=
 =?us-ascii?Q?SD6D20BhX1H8l+CfGu9HzaMnZ7nLxTSgw2zMiTs3pHpnhpMCpZRuKGubp5yO?=
 =?us-ascii?Q?jlo68rBdRKaM9TlvcEj6YsXGb+1zPHctSSehpbMeIFVkJs/Tgt+WeAMCI2Dt?=
 =?us-ascii?Q?zUsSSMBtuSHEjzdYiHGPVkKM3iCww+lI7GlEE5HVEdvRaqACZSiVjIcVzNKb?=
 =?us-ascii?Q?r79FxWrDm459UvcQzMmk4IT8hj7HRrprflGX13Q9r5Y1PxPoglunACrMszDg?=
 =?us-ascii?Q?SPQOsXiQipO4Jm/0D8fX6qxNPleIRFctUmp2KIdhPY0ofUIPh68N4pk36l95?=
 =?us-ascii?Q?fOr1FSuGktMSOlOpG4I5gJUCp6j8CdAeICXPxWoE31/NGzlQ2//1y8BU9DlH?=
 =?us-ascii?Q?CX6Dt32Li8s2dlJyuSsSlU1xT/mK1gxA1MqyR3O5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JUU/Vo+TeqF1uWC6sG7DZ6pWo35ohHj+TUIVfonLuLpNa38HHKu8rGxJApMMO4HLi6JBjDnl41HUntTQ3ovlsO2hBOUbH240xbbryeGu1TCD6gNPZulXZR9iyC3WJrjo0p9pjJC6SjyAd3UxjMO6RBw9NcDr9BcqpdmGtXk2gimuFSn0mSQ4BNWRNLaRueb//5W0aMwjNdp/SzuCcnLYl7VFfw6yKILSQAgIp0bhMl0VHFazf2+vBHUUQZw/s2krsqJLXGfOTctrbZ7txQJ0CMLLQUb/fVEebCPkMVHJvqvfTn02uBRKSJcmzzM+DxwHc+QP+a/CcLEe0B1JLJY/Ngw/zNP96FrLyXDUnTTuZXCJYTuqncPPwpwkl2JXu0F9qJ6WToA4FMD355S6mVdKg6+6/emwuJ5x72U8foTmPiEkLdzYPBwXOgN2oWvXA1yyX1Q7Yb6UcavaQZCCtVIReRSfuOizUvkgtpzRMYnoOtjLSZfMH+z3lfgg4b9gUJSOpzbiN2IYRX+8OqWoD0qaDttfaFanzsH4szsyFfucNA8glgLJMjQ3wxNgIz4FKmq+ZNWAd8jrC9nyE0L6u4LCJnUnNC2VjmG0B5+rhXZeW+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127f966e-5ff5-44fb-2fa8-08dd54aef6b9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 08:40:59.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaS80Zzt4aCLSytKQ9xqFDtXYWMVp/Jba0Rnm6KhTqv0v37AnNz9RvSJQHZyBYRSzdMOMWy/mK3UjFmocQzE8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240062
X-Proofpoint-GUID: IhkFQaFB0tvD3B6FcdCqeyghrQZrQ9f1
X-Proofpoint-ORIG-GUID: IhkFQaFB0tvD3B6FcdCqeyghrQZrQ9f1

On Fri, Feb 14, 2025 at 05:27:38PM +0100, Vlastimil Babka wrote:
> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> addition to main and spare sheaves.
> 
> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> the sheaf is detached and submitted to call_rcu() with a handler that
> will try to put in in the barn, or flush to slab pages using bulk free,
> when the barn is full. Then a new empty sheaf must be obtained to put
> more objects there.
> 
> It's possible that no free sheaves are available to use for a new
> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> kfree_rcu() machinery.
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
>   usage - but the existing batching does that too?
> 
> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> implementation favors smaller memory footprint over performance.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h        |   2 +
>  mm/slab_common.c |  21 ++++++++
>  mm/slub.c        | 151 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 170 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 8daaec53b6ecfc44171191d421adb12e5cba2c58..94e9959e1aefa350d3d74e3f5309fde7a5cf2ec8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -459,6 +459,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
>  }
>  
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> +
>  /* Legal flag mask for kmem_cache_create(), for various configurations */
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ceeefb287899a82f30ad79b403556001c1860311..c6853450ed74160cfcb497c09f92c1f9f7b12629 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1613,6 +1613,24 @@ static void kfree_rcu_work(struct work_struct *work)
>  		kvfree_rcu_list(head);
>  }
>  
> +static bool kfree_rcu_sheaf(void *obj)
> +{
> +	struct kmem_cache *s;
> +	struct folio *folio;
> +	struct slab *slab;
> +
> +	folio = virt_to_folio(obj);
> +	if (unlikely(!folio_test_slab(folio)))
> +		return false;

Does virt_to_folio() work for vmalloc addresses?
Probably it should check is_vmalloc_addr() first?

Otherwise look good to me.

> +
> +	slab = folio_slab(folio);
> +	s = slab->slab_cache;
> +	if (s->cpu_sheaves)
> +		return __kfree_rcu_sheaf(s, obj);
> +
> +	return false;
> +}
> +
>  static bool
>  need_offload_krc(struct kfree_rcu_cpu *krcp)
>  {
> @@ -1957,6 +1975,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	if (!head)
>  		might_sleep();
>  
> +	if (kfree_rcu_sheaf(ptr))
> +		return;
> +
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(ptr)) {
>  		// Probable double kfree_rcu(), just leak.

-- 
Cheers,
Harry

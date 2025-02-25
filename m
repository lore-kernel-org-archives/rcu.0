Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B783927701;
	Tue, 25 Feb 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470494; cv=fail; b=Pj8P3iC6yKne3ajch/OOMNMwVC2Vpc9AKI46PpDeSEPo2Y3HaL7p8GXjwk9jZsn4F0Ps27dFbJxRqNHO9pI5yEGzN16BD1yogQ0NtC0ZwYnuijkkqXC0Q/LQSfvLEEc9q4W/w9r2vy16NCiEEBA+43GsQE+wGTP/Ha1OX5Htrs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470494; c=relaxed/simple;
	bh=DD3AjaTCUFTaccVDlilOIWCH0a8M69AtI+wXSwGs0zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mnIajhpES4tSxqVlnNa8C4pKHkQc6lVU3KvvVLVlcNt0xo0ReanA5ek3LCo8ywJj65ai3Kv/1rkpxj9ea4G1EJu5rqsbyZqK7hbRMVN15BfFdNb+O6zPWqG/ZXnBHufuGo9HMdqhcz8NYyi1MnthcmZK7XXk0empUEs7ZqebQzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MvZnXbpH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g4o/Aczu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MvZnXbpH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g4o/Aczu"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BkPi011148;
	Tue, 25 Feb 2025 08:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9fGu/ivjfcFP9Ezgex
	dI5QNoQ2iNm3pMWvKHU6M2a2A=; b=MvZnXbpHaGGd8zDs9BFYKxIZH51LcQvuAW
	+HXyBtfak892CT/f7+xBBXZPgNJgh0jAhsXuBvaicrjAdWtv6In78f8V8rS55Z3q
	kvnjuy+i9e3ceR0MMyZWvnj/wm3RTKnIl/1HX6x1nmGD7VqPGVieeM36l2lpDC5t
	2Eh+6JqGFi6U2n9AMpAd9/lI2hWpfNEIBMdltL9v9ep860aslURDFWaaLMez0Pn8
	6Xo30vUI2SVBPSOejJWNj368Jna8KLckCDL75YOVQIIkE4p7+Gfbw5x38VlSpYGs
	iALD8qi5BZvofhDDsbDyc+peyUZNdxx1SgiqugFC0b+FkQXisgkQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gamf0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 08:01:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P60RRT025484;
	Tue, 25 Feb 2025 08:01:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51fbgr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 08:01:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlJbk21UGeZFyEu7LqdKgaWOleksKYZg/FNvbxCUhcD9BkIAssgpXf129A5aPaVULW8tUYT44MfV7KpYA+CtOf3mqWCP2SwAIeIN9JtIOEgG6U6eXAoC6zZmQo2/NBCaoE2GLZCbAmoVyaj3GwBD+WGDIlDH6t0cUTcehumfZtB1XiBLDcaPzvwJSmn8f2L61zsB/X2SaW4Aye+ZDD3p4izsNsd88Yv7N+LZ2WW8iJVdwd651psWSxm0NE9gVRxFBs8nXSgZLKB7TbLmQccp9TndUxkuSa9pU/jUdOvA1p6+T2m8iVfLnV/gj2TNBke9s4ovfYcf+516vmrYCb55qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fGu/ivjfcFP9EzgexdI5QNoQ2iNm3pMWvKHU6M2a2A=;
 b=J7HT+bjLinGxkmgjxICHAlSfb+F7XRNYu2ManBNhP6ryDUdhxZ/HCyrL5MtQkWN1Qcl1uqsunCa95RrpeKs5cAZmKpDOOJTBwd4CkEPQ9YFLa5zWcI93mYOGIvcMjcjqOdsmRsCrdv5u+3MBja9kmN3vJnN5sKQtxu7aRQfQZcd0fZMqCiYnYKyzq5gb2uoFbDHFKmBZVHVCe6lV74dFaViSnI8+Bhr1JXqUOJ52wWjgdG2EUSHhekSQofi7Fd5Rq97uFQSp75v84dRJVVgROHCBDDvKCxMM6fKC5tPcFq79ATAG4uyGNprqSRGlgvTamYXx91bW3/OXjnkkXMVALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fGu/ivjfcFP9EzgexdI5QNoQ2iNm3pMWvKHU6M2a2A=;
 b=g4o/AczuwA0JYV4NH1SIlKZocJXxEr86h87dkqmnSka/d8gg9MqTc6fB4KL0/xthu/Jc4deE2n9tAXiuBCUFUNUbd4jH6OB5CvzT/7JYIC6hinWxvMLBafQ7B55ktn0N5EggjpPsdtIg8Qzgstqp0ATuzhkeNYCDpv2cAzhzU8Y=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB7181.namprd10.prod.outlook.com (2603:10b6:208:400::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 08:01:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 08:01:08 +0000
Date: Tue, 25 Feb 2025 17:00:56 +0900
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
Subject: Re: [PATCH RFC v2 06/10] slab: sheaf prefilling for guaranteed
 allocations
Message-ID: <Z714uDm4VcusQ7-Z@harry>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-6-88592ee0966a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-slub-percpu-caches-v2-6-88592ee0966a@suse.cz>
X-ClientProxiedBy: SL2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d41fca6-0eb4-4933-13f2-08dd55728fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CXILjiCx/W+LyNIKERwf2qzWw8PeWdIhPLkaLuuwDC6FI/zvABoyJa+GYYFb?=
 =?us-ascii?Q?fWMEU7yNSqr2RbusD7USPBxlHLPGmPhn+uMIpc1Jys/WU56UELBYcmCEmDhj?=
 =?us-ascii?Q?MUIAPUfrid7nezaH/lBhXoMlC/FDw0lgYmEIITu4CO+LvzWzU+LRK8btsxeW?=
 =?us-ascii?Q?bi68UzjBkhSBJwmPSaZ+jPnWmNFT81oziUWOa2dT9lbtOKoBPfP3B5HKX8UB?=
 =?us-ascii?Q?zIbf5sUVQY2/oAIpgq1a1sntSj74MYxGtqAm012Ffpdi+QSZFPX/B7oYm1jl?=
 =?us-ascii?Q?t8rgntXfAeLqzeHhYOXBy3axR31OoVnOE7VyP5mcbu1Vf/cfem+k4fADG6XW?=
 =?us-ascii?Q?OQM7zIWZdv7KyQ8t1c1YdVlsNJvWrX22UeH8DmqkBUew/J09I/odJqRlomjB?=
 =?us-ascii?Q?nQmxiHH9Zj4JOmVe6tNqrMbnQkImoK2EoSAEOoBNFPaY8nxo0L7hRS5NTBL6?=
 =?us-ascii?Q?x0lIqNuVDWAufsZ72XzoO97Pzqtkpc0ZQfteudmJ7jnwsXjvtY0jYrYWdzZv?=
 =?us-ascii?Q?ocWEObriCL/LynGBfnMt+zJxEROsnXVM+je6Hb0++bzQQBH8FE7V4OQtp2El?=
 =?us-ascii?Q?K52eFsUb6SXHEY+eyhOKnRA7eB4aa71WHZWaRvoQYKJ4Oj/FADiYx5HV0sZf?=
 =?us-ascii?Q?3dxEZZOFUT/NJRcFNCK/r7SOExXkj3mv12qwP+ZSZWJd2Puw+dkVyWVeEDbM?=
 =?us-ascii?Q?QPG4HUmzlLAIGaENmESJ7jly0g5Kvku+G44PR5s3XQc9HCIN+c/3lmfLEUF5?=
 =?us-ascii?Q?gJ+sGNqtpo0L6r9sPDWfypb0TMfDYv3sNjJfwlDQQH9wquoYULlHfpzjqdHN?=
 =?us-ascii?Q?C9VzRtEJlq8ZO/ufWs8C8EMqO8fj4HH2/2QvR3ktvxZKyDQ5zbONNIY9cyvh?=
 =?us-ascii?Q?gONgLXDCgf0H66v0ikWoD6ALM7AQm+S46fzjdQvesMmMS7tBiLoIkknQVPt3?=
 =?us-ascii?Q?cwukt3PIjhgo9kSYiK8OmvQ0rVqIaUWCHDt9y2eL1apGRXlXk02eQAAh1Juv?=
 =?us-ascii?Q?3kFygvR1YVAagWMgJJMDOwOCiGsYLtH2Cwlv/Pd7kvVMhcuMm2Pv4sZkkptQ?=
 =?us-ascii?Q?2FIIj2E+fr11pXQoktRvNYzN2Iw/p1K5wFO9FszHw9YGrdX0akkvGiw5JjZP?=
 =?us-ascii?Q?XXbamXdQ4up/67xuczBOUfbo245wpj5+GkFsXC1RyZtvWj3nGKOiW6Ft+dHn?=
 =?us-ascii?Q?QE3M+haacV7oZwBxeuBoRaBRwg1cdp8uVn/oAL4YseSDfPLpBuXe1KRo2PQa?=
 =?us-ascii?Q?J4BJ++oHCYIDxn4l8KFx12DsSDhwJ65EUOp75s4hBUZSBrR6giV5G2Foy6Sc?=
 =?us-ascii?Q?75Cu7ZWJzj2+qGKWZDjGNc1LPHhYpfzXslZ2Zq6pgmUY3VAZYs+HtbiHOiXB?=
 =?us-ascii?Q?pbSgBPIfHKBKAujrKoqZcGvmwQrh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D3Y0XmNZSHSKDIT+mzbkEkCcDI5QZN3NRsVEMYSn4oLJm8PZI1VHkbAsfPYS?=
 =?us-ascii?Q?HOm+baRq0Gck9i1LVhdi9+3d8PLqXlEDBAL4pF3CcJVdErsIURdP8zpYqruO?=
 =?us-ascii?Q?0asyRQXn1ySvyltK2gmGcgPr0aGWkB5uaxz8Tu5XWx2Sc+8xcE5mqEVHo0wz?=
 =?us-ascii?Q?uMwK9wUOuCCSLu7/m9G4h9bhVK9d+opln72fp3Oj8pEnMh/DzHa2SVZBam9H?=
 =?us-ascii?Q?BNLDcGn8/dgeZ0oBdpjaI848DoTMoVTWVPNG+0UzEkKKECKBqjOPExVOwKag?=
 =?us-ascii?Q?ZpA3lsuMJhrTBIBqF07NJ+hskATdjvPBU9Bi1pxkMxtw6y8QtE33lef38A2q?=
 =?us-ascii?Q?ZWAl7dZJS9dVMrUPE9wv42XnJ1BeL7D/xXKRG7+9Erkn24m62/Nfx3zC55an?=
 =?us-ascii?Q?qpN4mhUL+xZV4LrTSPo27AM27IrEX18zT/25onl5xeX8bgKLdq6JC0/qX3Y8?=
 =?us-ascii?Q?D0UwovpPLtngE6DkYORAI74JV4OTQl0QccyF8SMRH23ox4M7oy+aVzgDjNf1?=
 =?us-ascii?Q?ewWsjJjDMG8eAHGRSrM7fPHsQa9773jPVPVKVIPnS5tiSWActO3xY0p82XqP?=
 =?us-ascii?Q?y8tCzfg3j3nkPeydwnghnFToQQ74uc229Xfkiw8GFHoeVPfVMQ4USnzDv9of?=
 =?us-ascii?Q?vSQlFMGZ5k/aheBulhwny/xdFHJX3E8/Y+FlVVrVs1rMQUDcwrevnz8F+4N2?=
 =?us-ascii?Q?46Wqm6ogSnQBrukIK3g0ZO6e1EbHDfNNxlOVWsBvnU5kY/68OSiS8vH4Vb5s?=
 =?us-ascii?Q?KeBo7uX+58uBWQP76PCiWyHSboI+UXU4bi6i9uqiywkCIQogKKCpctrAhs3e?=
 =?us-ascii?Q?WvErNmO4iCtCu3YAlXA4eE2vzn03GH9Xjj4+RKKoWL3jq4oWtkuQpbX7QgK2?=
 =?us-ascii?Q?TjPouH2/2zJuIsHQvXTVKnGZqNT1v+69VqYDt52TUln2up85E05EoR4qPWjZ?=
 =?us-ascii?Q?dYDP7gli/Ft5fpVoZ5+ovtnCMy+yaARTD7TeK8a96u8C2A35829vkCDQUgx4?=
 =?us-ascii?Q?441eh2siou40n4FKfz7Nu3orD/vRP76Jj5lfYyh9zN+MBGM1otR1FXvRS86s?=
 =?us-ascii?Q?PZGJNUfgYyOtkxeTsWk/xt+0XvRdYunrgCLl722YLnEsZeXjTZPbfYefs4WL?=
 =?us-ascii?Q?uiaOFdaWTVPZxdKYU2NiAeYqMnBKEiFfEw6r78luRBFH5dddqYADv6cPA6WE?=
 =?us-ascii?Q?wS9/sAZZuv6K9U0p19izzaLNRBwBQr4/zgD/jct0jeS7rEodQue8oqWCVXzV?=
 =?us-ascii?Q?JkpVwbb7H9aQ3iMwm13Omjl4dgJlhVES0kACvMNXRfXKQ265ffYrVNtjrUFG?=
 =?us-ascii?Q?iSvW3jbFyGk9Luabjg0XOVM4SRZumUAcQXzxYoo0ViE7CanObYA6iYQ3s8Cs?=
 =?us-ascii?Q?b5y1CvC2SmId1spjlQ9Dz2ROS5+9ZSKgA14TyongtBx5mhE7HJ5AuqXjJy0o?=
 =?us-ascii?Q?bDRQ5eakksHI+FkU2HJHRx+IeXXhaLP3qcV00lQZHcUDqKXhvDRejYCPJE5C?=
 =?us-ascii?Q?jCIJ4jRogBgsBbUHRE61nYQO7eAg5dgmGay1Z3/vrtzZ5bd0EvQ5jQysv34b?=
 =?us-ascii?Q?vCyNUvCulIC3o7Bz8tJBaxtVkF7t9F1z+v6R3Ijt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gg3T4AvRV9aBXWy1/IivbNko2mpv+QtD90vddj9IGP1Mb1VXwed9MtUEbRBWWocKs8rWgULSfO+R7jG9wpQmUiJpuadObBqEkIP8+H/Ai8hSPNLwRKAjLpi2d9OcFquGXytgmC5I/ogfPi9oqwqRPvQOWkqm+6/Q47/DdcI+283j3NJlX1MJHMZ8noAvIc7xSqcumufgujAyRFHiJ+paH0qEJtq1/oqZIH02S2CFG+1nqTk/H5RTQAj8nvQkBWunUAqEwQhHSkyu0DK/7t+4GnHY7IRDHgQSiCMoCO2bA/NXKXm7VVz2ZVCbK2mpZ7tC6fga3LcBP7o+K2KYao5zUTMvjhEctKnyXwvwOHLyX3BeXr4kWTUO+sxDvHCaTHS+krXljEhdlOtVACnOqypxe5NFNA3k6iyl8W9W6DTSO7CpYeZUPaRApIt+oi01fnEoqxWRliSPRZ+ndu4B8/TEFvzsyUvZUGSMqbkSHX3SU6WAv2U3Ee8r+U0qJkL6P4HVFEJkHNxSNUrkyKyUBtQQ0EFl3A6YH/Qo+dKqwxrl1KAbezAo6WfMN0RuvCW/q3cJ/UudX8Y6NTSXZQHJ4gfpOgS6FAqoDtSPz0LJowit6f0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d41fca6-0eb4-4933-13f2-08dd55728fd2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:01:08.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGSvST+avAsMTeOhlFw3FrBRn9cJJwgOyH56orVBLsNLDoJsmR1/J4FHUclNeMzc6tKhKPInKddur0hNS63NDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250053
X-Proofpoint-ORIG-GUID: w59I9pQMKj_FA2jrmkrKD5H29IDO3jIN
X-Proofpoint-GUID: w59I9pQMKj_FA2jrmkrKD5H29IDO3jIN

On Fri, Feb 14, 2025 at 05:27:42PM +0100, Vlastimil Babka wrote:
> Add functions for efficient guaranteed allocations e.g. in a critical
> section that cannot sleep, when the exact number of allocations is not
> known beforehand, but an upper limit can be calculated.
> 
> kmem_cache_prefill_sheaf() returns a sheaf containing at least given
> number of objects.
> 
> kmem_cache_alloc_from_sheaf() will allocate an object from the sheaf
> and is guaranteed not to fail until depleted.
> 
> kmem_cache_return_sheaf() is for giving the sheaf back to the slab
> allocator after the critical section. This will also attempt to refill
> it to cache's sheaf capacity for better efficiency of sheaves handling,
> but it's not stricly necessary to succeed.
> 
> kmem_cache_refill_sheaf() can be used to refill a previously obtained
> sheaf to requested size. If the current size is sufficient, it does
> nothing. If the requested size exceeds cache's sheaf_capacity and the
> sheaf's current capacity, the sheaf will be replaced with a new one,
> hence the indirect pointer parameter.
> 
> kmem_cache_sheaf_size() can be used to query the current size.
> 
> The implementation supports requesting sizes that exceed cache's
> sheaf_capacity, but it is not efficient - such sheaves are allocated
> fresh in kmem_cache_prefill_sheaf() and flushed and freed immediately by
> kmem_cache_return_sheaf(). kmem_cache_refill_sheaf() might be expecially
> ineffective when replacing a sheaf with a new one of a larger capacity.
> It is therefore better to size cache's sheaf_capacity accordingly.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h |  16 ++++
>  mm/slub.c            | 227 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 243 insertions(+)

[... snip ... ]

> @@ -4831,6 +4857,207 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int nod
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
>  
> +
> +/*
> + * returns a sheaf that has least the requested size
> + * when prefilling is needed, do so with given gfp flags
> + *
> + * return NULL if sheaf allocation or prefilling failed
> + */
> +struct slab_sheaf *
> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
> +{
> +	struct slub_percpu_sheaves *pcs;
> +	struct slab_sheaf *sheaf = NULL;
> +
> +	if (unlikely(size > s->sheaf_capacity)) {
> +		sheaf = kzalloc(struct_size(sheaf, objects, size), gfp);
> +		if (!sheaf)
> +			return NULL;
> +
> +		sheaf->cache = s;
> +		sheaf->capacity = size;
> +
> +		if (!__kmem_cache_alloc_bulk(s, gfp, size,
> +					     &sheaf->objects[0])) {
> +			kfree(sheaf);
> +			return NULL;
> +		}
> +
> +		sheaf->size = size;
> +
> +		return sheaf;
> +	}
> +
> +	localtry_lock(&s->cpu_sheaves->lock);
> +	pcs = this_cpu_ptr(s->cpu_sheaves);
> +
> +	if (pcs->spare) {
> +		sheaf = pcs->spare;
> +		pcs->spare = NULL;
> +	}
> +
> +	if (!sheaf)
> +		sheaf = barn_get_full_or_empty_sheaf(pcs->barn);

Can this be outside localtry lock?

> +
> +	localtry_unlock(&s->cpu_sheaves->lock);
> +
> +	if (!sheaf) {
> +		sheaf = alloc_empty_sheaf(s, gfp);
> +	}
> +
> +	if (sheaf && sheaf->size < size) {
> +		if (refill_sheaf(s, sheaf, gfp)) {
> +			sheaf_flush(s, sheaf);
> +			free_empty_sheaf(s, sheaf);
> +			sheaf = NULL;
> +		}
> +	}
> +
> +	if (sheaf)
> +		sheaf->capacity = s->sheaf_capacity;
> +
> +	return sheaf;
> +}
> +
> +/*
> + * Use this to return a sheaf obtained by kmem_cache_prefill_sheaf()
> + * It tries to refill the sheaf back to the cache's sheaf_capacity
> + * to avoid handling partially full sheaves.
> + *
> + * If the refill fails because gfp is e.g. GFP_NOWAIT, the sheaf is
> + * instead dissolved
> + */
> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> +			     struct slab_sheaf *sheaf)
> +{
> +	struct slub_percpu_sheaves *pcs;
> +	bool refill = false;
> +	struct node_barn *barn;
> +
> +	if (unlikely(sheaf->capacity != s->sheaf_capacity)) {
> +		sheaf_flush(s, sheaf);
> +		kfree(sheaf);
> +		return;
> +	}
> +
> +	localtry_lock(&s->cpu_sheaves->lock);
> +	pcs = this_cpu_ptr(s->cpu_sheaves);
> +
> +	if (!pcs->spare) {
> +		pcs->spare = sheaf;
> +		sheaf = NULL;
> +	} else if (pcs->barn->nr_full >= MAX_FULL_SHEAVES) {

Did you mean (pcs->barn->nr_full < MAX_FULL_SHEAVES)?

Otherwise looks good to me.

-- 
Cheers,
Harry

> +		/* racy check */
> +		barn = pcs->barn;
> +		refill = true;
> +	}
> +
> +	localtry_unlock(&s->cpu_sheaves->lock);
> +
> +	if (!sheaf)
> +		return;
> +
> +	/*
> +	 * if the barn is full of full sheaves or we fail to refill the sheaf,
> +	 * simply flush and free it
> +	 */
> +	if (!refill || refill_sheaf(s, sheaf, gfp)) {
> +		sheaf_flush(s, sheaf);
> +		free_empty_sheaf(s, sheaf);
> +		return;
> +	}
> +
> +	/* we racily determined the sheaf would fit, so now force it */
> +	barn_put_full_sheaf(barn, sheaf, true);
> +}

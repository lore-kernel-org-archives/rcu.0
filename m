Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2428C5DA;
	Wed,  4 Jun 2025 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028857; cv=fail; b=Twb6iffFF/A7gmMEUauodFO3+DUnx8KE7AuRHXLvoLTy5wKDxz7h43SXWe7Gq68woAbt8AVPo8pCbU68iLal+aLmuY/xF9kBeBlNx7m2QayqewP2RfmwgF+Mbcn2HaT6PjO92pSWkPCZjrK/PpcythlFzfTarusOZSzV+3vyu5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028857; c=relaxed/simple;
	bh=wQyGRi5EML+hHHVs3RJktaYdHc/+yY5hgyMktT8i/os=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ETUxoPrfTBhO6074+weSEj7eU7nOcTT3NANkGzcpH5aFj9LVoPAbLWgbEAnhK5j6gziqVCt5BkScFrLL9n5aP1AQzadDkjP/MmbsPPDUXbpO5QeeomYFQrWsk4eTENTJzrCMKdIT5vMH3f0RahuNwxf+DzjGinH1lANttidZyvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DDZR/hns; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DDZR/hns"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3YOH+QGgjm4iOHPe160IS9YCJdgMlQJJnT86qybJsilLv0J+de83Tchq6x1lqwAVvrWf9wxt2Ry5GVOQl6qynG6y2iLd/huN0krYQE1HcMSc1dHAtXPyAMGAon5jWqvKUaq2kw9LNJGJl+406kj0f0a0bkUPC8rWTTWb3XHuODi9Wd5lne0ImmzG1McWBJ8mFeBLhqV9IoKZrt1wLf+UXnE8g4povinZJ5ESAcEiYd717jflqYBm27E+aGqM5IszSUP31ElHW7K1UqeQYzDWCwEn+S8mKjLYBFyasAkrXNyKPtOMnRDOglVrK9ACkEIBRpiFXfC193RwRu20nphLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcvVEluBvEqjJvKyHF5zA9oei/5KD7pzc60tat2l3wc=;
 b=q9ZKvI9keisHcKJnoBYa/SC+7NF8zRZcQHFjd2ENkVdvFlzDJ6B/0j0rDPseOCTsvc7ahA2VdUCzxBLgRhorSk4lju17g+nJh3Jgr5TkqeSpzjDlccs0ytBraqoLWN+QQKREn9yWIEz7Yy2SwcZGLqsl8VMf7SYbV++6REpzWQ7bUSLbtvGpDOr0HrMQeemRE5x0HDeIkmP1bXIF4VbjOEh/uy9ZTIgatBrmkd7zfy+rV3frBEg7d/C1gh0geCgEfmIiyUYIw9563Yj86G1nSGlAuV0bHBSH3XBDsTN0YRoEFBeADvj0yp+TAKjbkV35/I+E0LDeSmJ9myg5VhFxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcvVEluBvEqjJvKyHF5zA9oei/5KD7pzc60tat2l3wc=;
 b=DDZR/hnsTcRoV8dJd0U72lqjMmXEdJ+M9/vb5dtHjIRTNua2xc9NINqMBWClJXIcLasUoD/9E/cD5TYa0ORYW4TK9aRIrHBFZboUSTuTe+dO6mDmiRqMYsAA8/wRXg4vcsvqnXMfR8PCS05AGNmEPfUzrvZQqyw/AlqzEG00T9BEIvy8HaNRdCyeRxyMPJ16ox2ELefhAAWW2X9WQuDMBVm9WUW8CUVQIIz5KHHa9/HV0Q+k7glYiABxCG+iVttxAKjGQMhklxwemDRMDlD3lMrcJ3yEuQeCECEM9KwcIVVpWKzzTPeH9nfBJphLaEarIZm1YeZBTnKfuk2KPJxoUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 09:20:51 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 09:20:51 +0000
Message-ID: <df05edcc-083a-49ae-981b-66c87668f3bd@nvidia.com>
Date: Wed, 4 Jun 2025 05:20:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
To: Qi Xi <xiqi2@huawei.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 neeraj.upadhyay@kernel.org, urezki@gmail.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Wangshaobo (bobo)"
 <bobo.shaobowang@huawei.com>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <20250604013526.GA1192922@joelnvbox>
 <0f322c7b-d8b7-ff0a-5c98-26230a9fbad0@huawei.com>
 <64dfcaad-091c-4319-882b-d94515365758@huawei.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <64dfcaad-091c-4319-882b-d94515365758@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:208:23c::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de54e21-5af7-4b22-b46e-08dda3491953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c294WlNmL24rRWtOaXozNjVob2l1d0kzTjlYeGFTQUROa2dUK0U3Vy91RjJW?=
 =?utf-8?B?ZmJMR3dMclVmSWhGUmJEYkRzeFVKYnRLNnBwaUVqMHBkeDdrU3JhcjA1TTNJ?=
 =?utf-8?B?MmZ2VUVrY3p0V21Icktldi9UYm9EelJ3a3dZbEt4SW9namU5V0Z1ZmZlSFVH?=
 =?utf-8?B?WW81Mk5zYjg4UjFVQ3lCYTF4SFlFTkoxbWRkQmZFTjVHc1U0bXRwSWh6aThQ?=
 =?utf-8?B?THJZSU1rOXJCUVZnbDUvNy90TjJDb0hBbVVJSUcyWE5XdEFKUVdrajZWMEx1?=
 =?utf-8?B?eWpHbnRicVh0dlhFbDlRamJwZStLbFRnWGVIMDRSUDZVdXhOOWFsMm5aa0h0?=
 =?utf-8?B?clVLN1NOL0xheUtvK2NCWGlzUXNKSTk2Qzdqc01KOXdUdmcvUE5lTTFaSVA1?=
 =?utf-8?B?TThmTno2VmEzMjNZWjJKL1RsRnBYTXkrUm5ZQ2ZmUC9namVvR2o0TFQ0WHM1?=
 =?utf-8?B?T0JQTEtaR01ScmE3MkI4VzhQN1Q0dVlDWklwVWpBdzdYNUNmY1orWGRYMVRo?=
 =?utf-8?B?M1ptVExZOWkzMlZHanUySTltMEx4YzFaeHRVbEl2ZERPaTRYblVhRENHRVYz?=
 =?utf-8?B?ODhzeDhsK05keDMrajFtUk5mSi9WNU40WkV0Z2Zxd0IzNUZaRkJRTmJVc001?=
 =?utf-8?B?UStRVnlmcjI3Z21mK2FtekpoaUl6WmFMWVJTcStmZ001SkxlK1NTZnptYklQ?=
 =?utf-8?B?NCtUL0s4RFNiS1IxbW5WNWlkQWRaZ1ZwL0RIT1UrSjFxR2E0cHlVbEZFKzZZ?=
 =?utf-8?B?Ulo4YTRuZWMrM3J6WXlCOFZKU3JHVU1vSXczMkZNaTNuOVRaaXQ1YXhCeG1O?=
 =?utf-8?B?amFNcVBHVlpvWEdaUGFLYTA0S2pHQkJZV2Q4dW5VV0ZVNXNscWs3YVppQklG?=
 =?utf-8?B?eXdIS2lrYXd4a0p3RTRGaFVWSkFMeDZxbDhxSDY3RTE0bkFWc3o2WEduQkRj?=
 =?utf-8?B?Uit0cXI2eDY0NEF5VWFFZ1BEQjJpSDA0aVpCSzk3U3k4azg1NGtvQWExNU03?=
 =?utf-8?B?TFZlNnhEblFyVmxoUGhQcHRVU0NMdXpVSGtvUUZXaDROYXhnRXdNZ2tIQkJi?=
 =?utf-8?B?MDRVNC9wMUlIQjlFWTNQWHZOQmJpRDBnTk9rMnNFQ29GZmk3aStTU2FUUEpV?=
 =?utf-8?B?cW1NZHdycThkeGtvczB1YzlZdG1SNk1iMEZvRlVwTHFIamdEMnJvZTdxaUF6?=
 =?utf-8?B?N2hFbkppUldzNzZseEtodDQ4SnhxdDNpMGZ4TldQSS9kKzR6S0VMVFdreXhy?=
 =?utf-8?B?OG96YUdKSUdZTjAwZWlqdjhidnpWaFo2WjFydHNtd0hLQVNQOEMwT0ljbWly?=
 =?utf-8?B?WXBrblRaZUl1azdNRXltUHJjWHQ4WmFGaWZiTXFlNkYwRm13aDJvQ3MxU0NM?=
 =?utf-8?B?TnlnRTlxdW9FWXhzemczWktHbStVZVJhNm9GSWVyVmE0WWZ1NEIwY3M1Z0lh?=
 =?utf-8?B?alVIK0tvYjRUQkJUS21TK3VQdGlEZWNJd1M5NXlRYU9ySi9ScnpVaEZiMW5N?=
 =?utf-8?B?SGNPS0VBbmJ0enY5SUI1ODlhV3RLYlVoOXlrclV3RUVyc0ZTSFJFenBjLzRT?=
 =?utf-8?B?Ym1BQUdIc2k3aWV6bDFkcENoOWJHc083ZllNdXpBb1NwOGhjTmpmdktqR1Bn?=
 =?utf-8?B?Y1dJaDN0dWhHR1BlUzZaL25kZ2xDMUxOZ0tHRWc1T3pqWFBHVWNsVXErcHlX?=
 =?utf-8?B?U3N4dkQ3OXh3UmNPNk9oMHFKU2ZWSWJaYlpvbWFycDFOaVV5MzV2ZVh6cnNs?=
 =?utf-8?B?Q3VNWUpOQXNaWnFCSlB2azJaTFZzck4wMUx4Q3c3MjBlMnFkYjRYQWwrVFcw?=
 =?utf-8?B?RWZIS1hwY2pUMDFOQmVsM3FKY0FtYlFmdGxOK0lWUko2d09MWm85ZDQ2K1dt?=
 =?utf-8?B?ekVydTlFejNMQnF2L210a0lyQmd5QzM1R0VGTDB6MUFWS2Ivb1d3czF1bVpV?=
 =?utf-8?Q?hKUWEC0YuS4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGlWWjdFOFFLakZmbU1ndzZsbHpybW9Ud2IyeFVLVjc1eTdwRWN0ajJIY0tt?=
 =?utf-8?B?NHZlWkduQTJ1ZjBYeU4rQXBITTArblMzWlAzMlB4QW42dS9IYVZpWGY0cU84?=
 =?utf-8?B?UUNBM1NsMzNEVmUycUZiaGxxeUgwNGtONlc1blI5alBTbzU0UndDVyt0RTRN?=
 =?utf-8?B?b2ZBem1FcEYyQklRb2NMOTZQY2RxR3lJZ01xR2xrTGNTUE9VSlpTSnRZWnBX?=
 =?utf-8?B?WDdFVHhCa1FSYmp1Y2xrcTF4SC9ObnRhNzUreHA2VnhhNkpvZ3RUM21CNnJJ?=
 =?utf-8?B?ajJZeTJabGtRVUdwRjJ5MG1pZUQweHQ0bXBjRGdhVzlIMjlhdzRwNHpQUjQx?=
 =?utf-8?B?b3FYSDBGcTVrMXE4YWdMMVNMamJ0M3VnbklZUGJWZDVUS1hzalVwZ3ZLRElY?=
 =?utf-8?B?MVc2MUhiOG1RUVdMaWZlYzY0aTgvaUxqM3hzKzhhZk95U3FQZnJ3dHorMnE3?=
 =?utf-8?B?OVo5MDlrTUNJaTY0bWtzU1RzOUF2WHJ1Qy9HVTRwRS90SmJoNHphYW1IQjRK?=
 =?utf-8?B?Nm1ySGxleUxuc1dURFlPanBVL2dGQ2RvOHdSNmlXa3pLbGNnMVFOY01mZ1dv?=
 =?utf-8?B?UHQxOTB3empmZVBPU1VXNGY2YTZNZHQzeFNqRlJuczl2ZU4zYW5yYklSS0ZP?=
 =?utf-8?B?TVFTU2ZTYStaeno1MlBGenVaYnl4dTVYZ09zcXlzYlZFeDRrVDJId3ZEbllv?=
 =?utf-8?B?eFlxRVVOd29iT2lvVnhxTk5DUzRUY3FuOXhwbnFpK2plM1UrdTdORkJMT0Jj?=
 =?utf-8?B?YVlnR1B0cWVuWXZyOEc5eDArVnBJaCtLQm5hUVhQVUlSc0tKbngvSDRETWVY?=
 =?utf-8?B?Wjd2YnFmZnNKVEJOQ0Rkc01BRXpSRWlZd05YQjBOU0FOL2dkc1FCV0ZyTlNK?=
 =?utf-8?B?c1BtL3E1a2dnbVdZRm9LajZDNGNKTndMODg5cVFSdzhrVkRyZ1poeVlXaldK?=
 =?utf-8?B?aW5XQ2p3d1BZbHd6Z1JGOC9yNmdxNUljTGN5RVJielRRUFlJQVdsT1FaUDJj?=
 =?utf-8?B?WEVpdDZXc0gxdHJHWStLNHNiVFVWcGlIY1hmbVZSVmltUEIwanBaaUlINU9u?=
 =?utf-8?B?TFMxTGtTNkNyS2lBb0RFc2dmVVF6aUw1cTRJTk0veU5SWGZ6cXdnMDMvR1Vq?=
 =?utf-8?B?Sll4U1J3UWoydGRLT0R2ODRZMVVneUNSckM5U29zSmxwM0Z6RXIzZmEzb0Fq?=
 =?utf-8?B?K2dyaUtsL0p5NU5EcVBGdzlHbEs2VnBKYVJkdlYzQ2hiYlFXUXBuYUlDWUVw?=
 =?utf-8?B?Nm5hUWEvVjZjTlBJTE9ZS0I3d1o2NWpSa0pMd3F3czhaOFlCOENia0tXSEo3?=
 =?utf-8?B?cTdQTTgxZndLRW5MQ1NRc3dXcjlUd0JZV2NvWElycldSb3Z6OE9NM2lwY3NW?=
 =?utf-8?B?VzJld1hQNUV0bFQzT01NYmNLbXBMdi9WWkg0NHdwY1NNd1Z5TzNZTS9KTlIz?=
 =?utf-8?B?a2VVMUh4VXNIaitPaEtHTWltNmRpeUZ4TkxnV3VMRFk4RXBCNVp1djhOaDV2?=
 =?utf-8?B?ZE5rdmwxQ24wZzVyNjRRSmhJU1RXMVNLaXBKbW9YL09QNHhqMlRSNlNXTWJK?=
 =?utf-8?B?RERkNjNSbXc1YndGMkcxUktiMk5sSzluOTZWQUp3d0w0K20ySnFrdTZHakkv?=
 =?utf-8?B?d1BuckJnakd2cHV4cWFXaXJuQlJBTmdwdzVwVzI2MU5QYU5XVGVQUzJ0MUx2?=
 =?utf-8?B?MzE4eEJzeGxmY0xBYUpSS0pqRFlsLzZ2NTA0emcxTXgrNmJDT05vMzNSWmpw?=
 =?utf-8?B?Mlp2aVlKLzVheUFnV0Q1MUxqR3kzcTRSdGhrU2ZabDhxYVlrMGtlRkw4eGM4?=
 =?utf-8?B?dEIxUDBEbnp0LzhrcmVIYUVTWXZDanJjTWRwQ2gvVVVVV0pHM3BORFNQNHRQ?=
 =?utf-8?B?Q3VkUHlqQmdQbVhmdU1UNnp1OGthd2N2dVc3VjRtZWNxeGNXQW1HRXpLRWQ1?=
 =?utf-8?B?cWFKMkNUcmlSeU40T0crUElyVTl0b1Zpa0NMaHlqQ0Y2VDM3WDRoQ1hkZ1Ri?=
 =?utf-8?B?ekRVZm13QVNrOEQ5UUNweU5RZ0t4RmdRRkgwdDRzN2t5VUY5THlIdk1ReUZH?=
 =?utf-8?B?cXNnOEhVR2E4UDV3L1RkSVlQaDJtZzI3RVlsZEZuek0zeFFJRnI4UDEvS0hp?=
 =?utf-8?Q?DACvT+/6YR6qRnrNpuTnxhjpe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de54e21-5af7-4b22-b46e-08dda3491953
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:20:51.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/v6z9MvPGo1raNAaV+lMH/Lqv8+VHu3f4NG7LJEYmKnZduHC88yCNAdH2k0WEOwAFwf42YHMAy8wvbjIf+uJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

On 6/3/2025 11:37 PM, Qi Xi wrote:
> Hi Joel,
> 
> The patch works as expected. Previously, the issue triggered a soft lockup
> within ~10 minutes, but after applying the fix, the system ran stably for 30+
> minutes without any issues.

Great to hear! Thanks for testing. I/we will roll this into a proper patch and
will provide it once have something ready.

 - Joel


> 
> Thanks,
> Qi
> 
> On 2025/6/4 11:25, Xiongfeng Wang wrote:
>> On 2025/6/4 9:35, Joel Fernandes wrote:
>>> On Tue, Jun 03, 2025 at 03:22:42PM -0400, Joel Fernandes wrote:
>>>> On 6/3/2025 3:03 PM, Joel Fernandes wrote:
>>>>> On 6/3/2025 2:59 PM, Joel Fernandes wrote:
>>>>>> On Fri, May 30, 2025 at 09:55:45AM +0800, Xiongfeng Wang wrote:
>>>>>>> Hi Joel,
>>>>>>>
>>>>>>> On 2025/5/29 0:30, Joel Fernandes wrote:
>>>>>>>> On Wed, May 21, 2025 at 5:43 AM Xiongfeng Wang
>>>>>>>> <wangxiongfeng2@huawei.com> wrote:
>>>>>>>>> Hi RCU experts,
>>>>>>>>>
>>>>>>>>> When I ran syskaller in Linux 6.6 with CONFIG_PREEMPT_RCU enabled, I got
>>>>>>>>> the following soft lockup. The Calltrace is too long. I put it in the end.
>>>>>>>>> The issue can also be reproduced in the latest kernel.
>>>>>>>>>
>>>>>>>>> The issue is as follows. CPU3 is waiting for a spin_lock, which is got by CPU1.
>>>>>>>>> But CPU1 stuck in the following dead loop.
>>>>>>>>>
>>>>>>>>> irq_exit()
>>>>>>>>>   __irq_exit_rcu()
>>>>>>>>>     /* in_hardirq() returns false after this */
>>>>>>>>>     preempt_count_sub(HARDIRQ_OFFSET)
>>>>>>>>>     tick_irq_exit()
>>>>>>>>>       tick_nohz_irq_exit()
>>>>>>>>>             tick_nohz_stop_sched_tick()
>>>>>>>>>               trace_tick_stop()  /* a bpf prog is hooked on this trace point */
>>>>>>>>>                    __bpf_trace_tick_stop()
>>>>>>>>>                       bpf_trace_run2()
>>>>>>>>>                             rcu_read_unlock_special()
>>>>>>>>>                               /* will send a IPI to itself */
>>>>>>>>>                               irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>>>>>>>>
>>>>>>>>> /* after interrupt is enabled again, the irq_work is called */
>>>>>>>>> asm_sysvec_irq_work()
>>>>>>>>>   sysvec_irq_work()
>>>>>>>>> irq_exit() /* after handled the irq_work, we again enter into irq_exit() */
>>>>>>>>>   __irq_exit_rcu()
>>>>>>>>>     ...skip...
>>>>>>>>>            /* we queue a irq_work again, and enter a dead loop */
>>>>>>>>>            irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>> The following is a candidate fix (among other fixes being
>>> considered/discussed). The change is to check if context tracking thinks
>>> we're in IRQ and if so, avoid the irq_work. IMO, this should be rare enough
>>> that it shouldn't be an issue and it is dangerous to self-IPI consistently
>>> while we're exiting an IRQ anyway.
>>>
>>> Thoughts? Xiongfeng, do you want to try it?
>> Thanks a lot for the fast response. My colleague is testing the modification.
>>  She will feedback the result.
>>
>> Thanks,
>> Xiongfeng
>>
>>> Btw, I could easily reproduce it as a boot hang by doing:
>>>
>>> --- a/kernel/softirq.c
>>> +++ b/kernel/softirq.c
>>> @@ -638,6 +638,10 @@ void irq_enter(void)
>>>  
>>>  static inline void tick_irq_exit(void)
>>>  {
>>> +	rcu_read_lock();
>>> +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
>>> +	rcu_read_unlock();
>>> +
>>>  #ifdef CONFIG_NO_HZ_COMMON
>>>  	int cpu = smp_processor_id();
>>>  
>>> ---8<-----------------------
>>>
>>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>> Subject: [PATCH] Do not schedule irq_work when IRQ is exiting
>>>
>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>> ---
>>>  include/linux/context_tracking_irq.h |  2 ++
>>>  kernel/context_tracking.c            | 12 ++++++++++++
>>>  kernel/rcu/tree_plugin.h             |  3 ++-
>>>  3 files changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
>>> index 197916ee91a4..35a5ad971514 100644
>>> --- a/include/linux/context_tracking_irq.h
>>> +++ b/include/linux/context_tracking_irq.h
>>> @@ -9,6 +9,7 @@ void ct_irq_enter_irqson(void);
>>>  void ct_irq_exit_irqson(void);
>>>  void ct_nmi_enter(void);
>>>  void ct_nmi_exit(void);
>>> +bool ct_in_irq(void);
>>>  #else
>>>  static __always_inline void ct_irq_enter(void) { }
>>>  static __always_inline void ct_irq_exit(void) { }
>>> @@ -16,6 +17,7 @@ static inline void ct_irq_enter_irqson(void) { }
>>>  static inline void ct_irq_exit_irqson(void) { }
>>>  static __always_inline void ct_nmi_enter(void) { }
>>>  static __always_inline void ct_nmi_exit(void) { }
>>> +static inline bool ct_in_irq(void) { return false; }
>>>  #endif
>>>  
>>>  #endif
>>> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
>>> index fb5be6e9b423..8e8055cf04af 100644
>>> --- a/kernel/context_tracking.c
>>> +++ b/kernel/context_tracking.c
>>> @@ -392,6 +392,18 @@ noinstr void ct_irq_exit(void)
>>>  	ct_nmi_exit();
>>>  }
>>>  
>>> +/**
>>> + * ct_in_irq - check if CPU is currently in a tracked IRQ context.
>>> + *
>>> + * Returns true if ct_irq_enter() has been called and ct_irq_exit()
>>> + * has not yet been called. This indicates the CPU is currently
>>> + * processing an interrupt.
>>> + */
>>> +bool ct_in_irq(void)
>>> +{
>>> +	return ct_nmi_nesting() != 0;
>>> +}
>>> +
>>>  /*
>>>   * Wrapper for ct_irq_enter() where interrupts are enabled.
>>>   *
>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>> index 3c0bbbbb686f..a3eebd4c841e 100644
>>> --- a/kernel/rcu/tree_plugin.h
>>> +++ b/kernel/rcu/tree_plugin.h
>>> @@ -673,7 +673,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
>>>  			set_tsk_need_resched(current);
>>>  			set_preempt_need_resched();
>>>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
>>> -			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
>>> +			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu) &&
>>> +			    !ct_in_irq()) {
>>>  				// Get scheduler to re-evaluate and call hooks.
>>>  				// If !IRQ_WORK, FQS scan will eventually IPI.
>>>  				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
>>>


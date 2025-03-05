Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856E2E3362;
	Wed,  5 Mar 2025 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188294; cv=fail; b=UwVIzNMM1P6qYHryXAv6N/59cvCHom65E8hSQU9DX2TRUCU5nsUojM5CZdtBzdIJinJcWKgfjb0X4rlHVnGup5ltukHB16rH1/oYinHGWySSMu53YOfuY6lppCfSHQBeRskN4+ZmzfPmcMvYSg2VHUa5WoZsvdf6dTQ985AM3eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188294; c=relaxed/simple;
	bh=EnQUTixPSazXBYQ3rPD4g0fJ5ej3zQf3xpyxuk9tczw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WJvwqIWq7uyGrNBfqioM5VuH1RmxkchpHyYnU+SguPLa+XmkAI39F2d8WYIxhHGJI0HvZ5o1t8mE4938pq6lRACOBmE5CHxfcAVwCKkVZ8dFtNOoFzLHZKhnFZw41AqonkMeoEoKHrBpKEnIj1mmod8MHDCgwYgfgmKV37ElOm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uRXMeg7B; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uRXMeg7B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRADsj+cYddLm0CSjoB5DRzloYtdnhNSgfT5559Y5/KSRTGmWOl32nOq/j7WP5Kam/h72x/awIL54Q3OPYLYlpFdTwdsLYjawybuwGVvH989Xxatj+5t7BlCvsKqFtUORXDAubwYfVjKv9iUT7A8ne9IBcpFa61qTbFwYbC1ezSqAa2V9oFOCdRsJ3359qWqEiRC03F50utWwnAcCDnR3TjG351d+iF4b+YgtJydMUn/riDIkC7XhiZb+YlqvseY7urcZnfVH5VKN3+nKeSmry616k+2Qej7A0xzlSHI/WY1vXKvK+a7VupHJ4OTRrEMvZsJl3sFIeQyd95DlZ2niQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18hVKb9ABcAmvp1LHyWb2p+wYEUOrgCFCnxBA+Oe9fk=;
 b=rruPdLBNhcAOZn7MokEUaYoJIv2Ewmag4Hocb6UexzKj/ZVaz+FcWPSpHI7NDW17UT38RCt//rNZoUJKPcZi9w2xX7a0VgLW3Bbz64XUZNBlPoGKQgme5FpGbkXlRcYZIr0hilFurImU0VgIUZqJlb5SMNktdXTA5O6rkgvkeMSCePhZV+AmmbqcQnenvfxg+Mg7ncY5kKnrSpIXato9mHJn4wMDq6UQMNh0io97vC+PSJjLBI6gMZPKK2JV9hdH/0qabW74DSbFU9y5DM7e7SfkIsn3xLWyh/466z5fQBSfpM2syC4irxRTbpWjtsm2IVMsGAVEhbwTnDREohNEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18hVKb9ABcAmvp1LHyWb2p+wYEUOrgCFCnxBA+Oe9fk=;
 b=uRXMeg7B6e4y753OJz55l6krWFIVwNEIFJDGIz2MZ0X7g58YYYx3Um1Ay7rRMR2U8Q+joPAfvefweJ8+gJhRH1rYS9RC236YK/Aljy9meeQcMjHD1v613JGPrpm2Qus9TJG4pRPG/cspU2A6sZYNFtjjyXHHQSL8p+cRSb4qXoKQWB8awOUHeragrwsasF/ckiUy3zhpGcacJePW8C6LPt6/h1nK/1JI8hSVXzBpxUZNG8QlxgQgbFWGir8WBDH5xAexjFQVXBnAic+PWY97SlUlzXiR7iSDVoK7izczCkLrS+i6g0eICllMQR7Logf1rFF3/E6Lt5zvO87GrXGXzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 15:24:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 15:24:49 +0000
Message-ID: <7081437b-63d4-45a9-8645-8c3445703ead@nvidia.com>
Date: Wed, 5 Mar 2025 10:24:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Cheung Wall <zzqq0103.hey@gmail.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox> <Z8ZyMaUhXMIxX7WE@tardis>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z8ZyMaUhXMIxX7WE@tardis>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:208:32f::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: a03ebf15-672d-4d06-391b-08dd5bf9de1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG0wMmZ1aE5qS3MrSW9yMnBvcDNLY0F3REEwaWNLOGVoakxhVEdIVXZJRGlt?=
 =?utf-8?B?dEg5U1g5dE8wMmhpNlQ5bEdsa1djYkRDN2hWR2JvamprUXVzY1dVVHVJeHkx?=
 =?utf-8?B?WkJMODU4UVE2NXNMcEU4SkVDcVFId25NUnR3WXZJdnFJcThXbDFPeXF0aFF2?=
 =?utf-8?B?RENlNzVzcCtpWnNoVUpiZTAzZnNBT1JDRm1KbDdqRXdTQmpRTUZLcFYrMDhi?=
 =?utf-8?B?L1hEUjdFTzVvNGF0d2dTZDNVb1RnWGp1ZlhUemNrM0dVdWV6RkMrWVE2WGxL?=
 =?utf-8?B?cEkyQVU2OVFsbmJvQi9nY2VWdlY0TzFua0lNb0NvRHhERTFoamFqWnZqTS9r?=
 =?utf-8?B?U2daNEdPbzhScEVjMXVFKzNRa0htcmxiQ1pwSllVV3RjNkFMdVQrQ3lUTDdV?=
 =?utf-8?B?QXFDd1lyLzVIT2JpUG1wU2hPSlR0VmJPa1l6MTFDak1XSmJaeVdJMlB2Qk5O?=
 =?utf-8?B?c2JyN2Z3cHk0U1FselFPdmxBczNMRE9PQ2ZuMWFHWm9aYnp5TWFqTTFMQ0Ru?=
 =?utf-8?B?aHZHUnZQMnRwMStPejZTaklyd2VjRFR0YXhQNi90aVlBdFpxQWoycmVuMnpy?=
 =?utf-8?B?L1psY0tWeWU0dVpOYXVReEVqSUNqZ0hVYUZTVFpYS3hzOThocGQwRzhuUG9m?=
 =?utf-8?B?KzRXSU5LR0VmZTh0SThyejc3M0NHZ3JCbFBsRkZrK2dKcGFoTVBjYVpEbE1j?=
 =?utf-8?B?SmprckNsRmYwVm9XVm1jc1U5ZHhzWXBmUTJRRmdoc2Yzd3F3NnN3TGpQeExE?=
 =?utf-8?B?bkdXSW1aSGtJUjNpdDR0ZWlNNXpyd1VFL0w1OS8vblJzdG9IYUpKeklqS05P?=
 =?utf-8?B?ZXR5WHBTTEllbWhLU3JTazdwaDFYckthL1dpWnBhb1F4MlBZRGlVYWUxcGFa?=
 =?utf-8?B?eS8yYlVPTWFJcGx3WFM5YmdyN0xiQm1oT0RtU05aVzBlY3ZxanBheVFHU0VY?=
 =?utf-8?B?K2Vwbk1hVlJJYzgzOFIzdElyZjdrbHpndVIvWWFqaktxbDlPQnVldHpTL3VF?=
 =?utf-8?B?SFMraXU2M3NIOStxWnRITkF3VWFBcWhZaTFiQ3M5eWdKc2FoTjNXd29GYVJB?=
 =?utf-8?B?WFY2ZjlxbVBScU5BRzN6ZU5ZeE94OUxzbi9TelFpZXE5MWRDK2tETkJoaXZW?=
 =?utf-8?B?bzgrejh0bE1vWVZDL3dyUFZSZkgrRG56NGwvVGNiSCt6ZUJVelkvOUl2YUIx?=
 =?utf-8?B?OVhhY0IrRjRrTnd1TVJXVnJtYXl3VTlCa2dWcWZDWHUxajdPNldWNVdrUnh4?=
 =?utf-8?B?M3c2Z0FOcDlrbFhLRzd3QW96dzdFczZnZ3piVUdwaFlPV2FQcjN1M2dacnJu?=
 =?utf-8?B?dE50NFJnemZNYXFncWp0eDc5V0dEUW1YOHhiTHdKSnVhdXNIdlRGWmd3R1Bs?=
 =?utf-8?B?S0lMSElNa1U2eFE1SHhyZFBUdGdBYkNhaHNqMXJsUmtaR01tUEpkRkJYM1JT?=
 =?utf-8?B?eVZLWHZUT3BIZ3dKUUpHOG50WVlGSllMMGJMQUlWY2Vwb3F3bnUzc1oreDFL?=
 =?utf-8?B?OERob0FBN0IrSW81THJUTVIyYUw4UWs1V3h6N0hhT3hwVGJEa0ZpTGJjWjZl?=
 =?utf-8?B?TnB1bTFzRy9UZTkwdXQ0eCtqWHNJSU9TUUpWcVBBSXVQMHJGd0g0SGlyN0o1?=
 =?utf-8?B?eDYrTDIvWUVkV2RoendNTkNwQUR5b1BDTjhLbjNmM2hURkNmZlEzOWxCQ1NL?=
 =?utf-8?B?VWx0Yk5lMzZRaXFrcFVoQStwVE5KSGQyR2gvUVFobGJsNVlzSVh4MTRJMlB3?=
 =?utf-8?B?V3FzQnpHS0RDNU1YaFlyNUZ5RmZmWm1jKzlFTFBIQTRPOFVnbTYzamZPME9T?=
 =?utf-8?B?V2FyK3ZFdExqM20rUFp4TnZZWWg1dUVrMjRCWDE1Q2oxODlKcm10eFF3bnJJ?=
 =?utf-8?Q?0w+GYzwNAEKAY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3dYL04zUGpwQm5MVjNqcmY0TlBNdmF3MmVTLzdtNmo2ZDZxdFpJZGl1MEN4?=
 =?utf-8?B?WlppSDByTlVNUjBuMEVtYVBDMWNJMyt2TFliV2RtTkY5aUpoVHR4bFZ3cm8r?=
 =?utf-8?B?cW13dXRxak9oNVZjZzh3V3R2NjVlUEtaSE40MVNMT29RYWhOWG9EaGtTVGVX?=
 =?utf-8?B?WWlIQ2pLdFFMTUhNbzYrSXI0RTNkWmt6clVaajVacGswK1MvOWduc0VKYjBT?=
 =?utf-8?B?M2ZVbUR0WXpIT211ZDlER3B2RDBlMzN6akltZXlYclNyd2J2OVBrU2pHMnNU?=
 =?utf-8?B?NmNScG5ZVWRzaitmWnhPWW41MlI5ODIxOFZuemMxUkFBMnczemJqWDNlSkh5?=
 =?utf-8?B?UDR3NXYyU1Q4TmNobjRJWWt3OFhySkNjVkFxVVp6NkNPYXhIbm9jek13UGFV?=
 =?utf-8?B?M0hob1hFUHNTc0RWUWRneHhjYlAxRXVaWHFIT1RQUDBOQ0NrYUJsMHdJb20z?=
 =?utf-8?B?VStPTTM3cWZ4NG1pYVRralR2RTlnZGxLV3gzMS8rcEtNSG1yVVBFTXUwV2Vw?=
 =?utf-8?B?bGlOMVgwSHdrL0ZzS2NTZUh4NW1MVTZmTU1Eb3dMSW9IamNYWFBldTd0MnNj?=
 =?utf-8?B?UHhhSDhpLzNuS05LZlpTd1VlUnJvSno0S1dvdkRneWw1ZkFxKzlXWEVTN2Vh?=
 =?utf-8?B?ampNU1BlY0oxaVRHOTR5TGp4T1JWek5aNWVpditaRFlUckZVenhscFoyN0FI?=
 =?utf-8?B?UlFNRzYyeThOUHFCMitkR2VZUlliN1ZvTTI3VHBQeGl6L1lrVHV4UmRId09u?=
 =?utf-8?B?Ny8xUHQzS3A2UUlna0I3M3JNcGpVVFNtWno5SnV2WXZBdnJMU2Z0VDk1TWk5?=
 =?utf-8?B?U29WZ2c2eVZjOGhEanRyZ2VFR0ZTekcwdnhyV1JieUF5ZWMwQTNnOEhuSi9i?=
 =?utf-8?B?NkpIR3I4MXRGeGovWmJQS2NDU2N0RS9IRmJhemVWUFE0SE9maEZNMmJjU0lY?=
 =?utf-8?B?RlI2M1d5NkRRbXB6ZDNIbnlwM09uUFNjL1diclE4UlIvMW1QTXhTdDdhdHFr?=
 =?utf-8?B?bm9BWS8vR1hyd0pRMU5VRE5IYndyZlhCQndYVzB3OFpJN1MwNjNrKzUzNG1L?=
 =?utf-8?B?WjRUWDMyTEloc3BJbFlQU204dENmQ0JzL3ZiTWd0ZTMvWWtRUllrTVJQbmxF?=
 =?utf-8?B?WUI2TCtpZWkzQjBqWGFYaENCRDBtU09wdFBCVnowNkFmVXE0NHY0NThTVVBQ?=
 =?utf-8?B?OTcvTk1NRTlYQzF0UGd1U1phZnhrQkh3YzhEajBlUlA1RkIzMzhqT21KWUpT?=
 =?utf-8?B?VW9DVVoyUUppNzNIcU5UZ3dRM1ZHQnJJblZPTDhkU0NZdVhxaTFFQUVIaTdI?=
 =?utf-8?B?RFdWNFk5SlJRaHdXMmVTSXlISnhLV2l1dU84TE9wbnNLWnp5MU1RUm5YUmJB?=
 =?utf-8?B?QVRnZm5JVjBkQkpOWUhVZGJnTHFIa20rUlcyU2dCNGJsUGl2bzlROGErbHA4?=
 =?utf-8?B?VTkvOFlQcENieGNzTWtuZEVDbmdtR2FMbE1NSjdXbDJBc1dqYXVqMmxneUNI?=
 =?utf-8?B?anBpMVpHL0JvNy8yQVJhUjl5Ti8vTlVHQ1hZcHUzaHlxcGhMRHpIREMwTFZo?=
 =?utf-8?B?NlhTWmFOaXVHNy9LTStOa1g0dExRbU5LNGZRcnBoYW5KWkRmdG5lREdPUEVj?=
 =?utf-8?B?RjloWmNGSS9VbmppQnVWZEVrMjdTTXRubHNNM0JvZnh0TGNOaTZKb1EwTGd3?=
 =?utf-8?B?bkFlMU1XbWRDLzNLMHZmVmpJMDJubXZFejBXUVFjcWQzeEdXNnB4KzA2dSsx?=
 =?utf-8?B?UmNxVGpQWlFaWjdtZGZrbm5NdGVjb1hxY28zUENHajdwdlExWFJsK0h2Vm8v?=
 =?utf-8?B?MlV2ZzhqZzNLVGl2SzNRWll3QlhFOUdMeC9LR01QVXZVV0tqQUJKYjMrVkxR?=
 =?utf-8?B?Qm5aM3dOQkhFeWtrcU5weTZIcHQ5akdRVEtjY2pwcDJPaHhwRUVLSEg0OEtR?=
 =?utf-8?B?M2RzMmxacXQ3OFA3UFNlOHBuN0dQcis5empPN0dqdEpydmNwbUkyTkpDVU90?=
 =?utf-8?B?YmVWVEZvV3g0aWFhemo4MGhqb3RnaU9GaWk2REFlWXdkaW5jbkFVRFVubVlZ?=
 =?utf-8?B?L3lhdXVhZlhzSGljSExMaDVZWHNMbll5Q2VqMHJoY2tjTCtwMEltVU5UQ3gw?=
 =?utf-8?Q?22D2v9cprgdnK6f51KzdmOoiO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03ebf15-672d-4d06-391b-08dd5bf9de1a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:24:48.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRRAnIEdsAi/gocFdRYUVTdIKAQelpugBkBj7odjygqqGIk3NoydL7l/XR6BocEyExXJbqxXA5iWrWXrbQr+uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758



On 3/3/2025 10:23 PM, Boqun Feng wrote:
> On Sun, Mar 02, 2025 at 07:15:07PM -0500, Joel Fernandes wrote:
>> On Fri, Feb 28, 2025 at 05:08:49PM -0800, Paul E. McKenney wrote:
>>> On Fri, Feb 28, 2025 at 11:59:55AM -0800, Paul E. McKenney wrote:
>>>> On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
>>>>> Hello, Paul!
>>>>>
>>>>>>>>>>
>>>>>>>>>> Except that I got this from overnight testing of rcu/dev on the shared
>>>>>>>>>> RCU tree:
>>>>>>>>>>
>>>>>>>>>> WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
>>>>>>>>>>
>>>>>>>>>> I see this only on TREE05.  Which should not be too surprising, given
>>>>>>>>>> that this is the scenario that tests it.  It happened within five minutes
>>>>>>>>>> on all 14 of the TREE05 runs.
>>>>>>>>>>
>>>>>>>>> Hm.. This is not fun. I tested this on my system and i did not manage to
>>>>>>>>> trigger this whereas you do. Something is wrong.
>>>>>>>>
>>>>>>>> If you have a debug patch, I would be happy to give it a go.
>>>>>>>>
>>>>>>> I can trigger it. But.
>>>>>>>
>>>>>>> Some background. I tested those patches during many hours on the stable
>>>>>>> kernel which is 6.13. On that kernel i was not able to trigger it. Running
>>>>>>> the rcutorture on the our shared "dev" tree, which i did now, triggers this
>>>>>>> right away.
>>>>>>
>>>>>> Bisection?  (Hey, you knew that was coming!)
>>>>>>
>>>>> Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start detection
>>>>>
>>>>> After revert in the dev, rcutorture passes TREE05, 16 instances.
>>>>
>>>> Huh.  We sure don't get to revert that one...
>>>>
>>>> Do we have a problem with the ordering in rcu_gp_init() between the calls
>>>> to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For example,
>>>> do we need to capture the relevant portion of the list before the call
>>>> to rcu_seq_start(), and do the grace-period-start work afterwards?
>>>
>>> I tried moving the call to rcu_sr_normal_gp_init() before the call to
>>> rcu_seq_start() and got no failures in a one-hour run of 200*TREE05.
>>> Which does not necessarily mean that this is the correct fix, but I
>>> figured that it might at least provide food for thought.
>>>
>>>                                           Thanx, Paul
>>>
>>> ------------------------------------------------------------------------
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 48384fa2eaeb8..d3efeff7740e7 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1819,10 +1819,10 @@ static noinline_for_stack bool rcu_gp_init(void)
>>>  
>>>        /* Advance to a new grace period and initialize state. */
>>>        record_gp_stall_check_time();
>>> +      start_new_poll = rcu_sr_normal_gp_init();
>>>        /* Record GP times before starting GP, hence rcu_seq_start(). */
>>>        rcu_seq_start(&rcu_state.gp_seq);
>>>        ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
>>> -      start_new_poll = rcu_sr_normal_gp_init();
>>>        trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
>>
>> Oh... so the bug is this? Good catch...
>>
>>
>> CPU 0                                           CPU 1
>>
>>                                                 rcu_gp_init()
>>                                                       rcu_seq_start(rcu_state.gp_seq)
>> sychronize_rcu_normal()
>>       rs.head.func
>>       	= (void *) get_state_synchronize_rcu();
>>                    // save rcu_state.gp_seq
>>       rcu_sr_normal_add_req() ->
>>             llist_add(rcu_state.srs_next)
>>       (void) start_poll_synchronize_rcu();
>>
>>
> 
> This means synchronize_rcu_normal() got the new state of gp_seq, but
> its wait request was inserted before the new wait_head, therefore..
> 
>>                                                       sr_normal_gp_init()
>>                                                             llist_add(wait_head, &rcu_state.srs_next);
>> 							    // pick up the
>> 							    // injected WH
>>                                                             rcu_state.srs_wait_tail = wait_head;
>>
>>                                                 rcu_gp_cleanup()
>>                                                       rcu_seq_end(&rcu_state.gp_seq);
>>                                                       sr_normal_complete()
> 
> at rcu_gp_cleanup() time, rcu_sr_normal_complete() complete the
> corresponding wait request, however, the sychronize_rcu_normal()
> observed the new gp_seq, its poll state will expect the next gp, hence
> the WARN_ONCE().
> 
> Yes, I believe this is the scenario for the bug.
> 
>>                                                             WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
>>                                                             !poll_state_synchronize_rcu(oldstate),
>>
>> Where as reordering sr_normal_gp_init() prevents this:
>>
>>                                                 rcu_gp_init()
>>
>>                                                       sr_normal_gp_init()
>> 							    // WH has not
>> 							    // been injected
>> 							    // so nothing to
>> 							    // wait on
>>
> 
> I don't quite get the comment above, the fix I believe is that wait_head
> was inserted with a llist_add() which is a fully ordered cmpxchg(), so
> we have:
> 
> 							  llist_add(wait_head, ..)
> 							  // ^ provding the ordering againt
> 							  // the seq change below
> 
> , which means if...
> 
>>                                                       rcu_seq_start(rcu_state.gp_seq)
>> sychronize_rcu_normal()
>>       rs.head.func
>>       	= (void *) get_state_synchronize_rcu();
>>                    // save rcu_state.gp_seq
> 
> ... the synchronize_rcu_normal() observes the new gp_seq, then...
> 
>>       rcu_sr_normal_add_req() ->
>>             llist_add(rcu_state.srs_next)
> 
> ... when its corresponding wait request gets queued, the above wait_head
> must be already in the llist...

Correct exactly!

> 
>>       (void) start_poll_synchronize_rcu();
>>
>>                                                 rcu_gp_cleanup()
>>                                                       rcu_seq_end(&rcu_state.gp_seq);
> 
> ... hence, as the comment below said, won't do anything.
> 
>>                                                       // sr_normal_complete()
>> 						      // wont do anything so
>> 						      // no warning
>>
>> Did I get that right?
>>
> 
> Other than I'm unable to follow what do you mean "WH has not been
> injected, so nothing to wait on", maybe because I am missing some
> terminology from you ;-) I think it's a good analysis, thank you!

Sorry I should have clarified, you are right the wait_head is inserted (via
sr_normal_gp_init() -> llist_add(wait_head, &rcu_state.srs_next)) always;  but
since per the fix it is done BEFORE the rcu_seq_start(), it means that:

IF synchronize_rcu_normal() saved the gp_seq via (which is required condition
for the WARN)

    rs.head.func
      	= (void *) get_state_synchronize_rcu();
                   // save rcu_state.gp_seq

then, that also means that this path.. :
sychronize_rcu_normal() ->
      rcu_sr_normal_add_req() ->
            llist_add(rcu_state.srs_next)

.. will NOT be picked up (have its request serviced) by the end of the current
grace period, because rcu_sr_normal_add_req() happened AFTER sr_normal_gp_init()
due to the reordering in the fix.

Thus making the bug impossible.

Does that make sense or did I miss something?

>> I think this is a real bug AFAICS, hoping all the memory barriers are in
>> place to make sure the code reordering also correctly orders the accesses.
>> I'll double check that.
>>
>> I also feel its 'theoretical', because as long as rcu_gp_init() and
>> rcu_gp_cleanup() are properly ordered WRT pre-existing readers, then
>> synchronize_rcu_normal() still waits for pre-existing readers even though its
>> a bit confused about the value of the cookies.
>>
>> For the fix,
>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>
>> (If possible, include a Link: to my (this) post so that the sequence of
>> events is further clarified.)
>>
> 
> Will add the tag (with the email you really want ;-)) and a link to this
> email to the patch. Thanks!
Awesome, thanks!

 - Joel


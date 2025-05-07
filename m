Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED808215197;
	Wed,  7 May 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633998; cv=fail; b=lCWFH+FgoXm3cXJDf7gWUBJebFDtIdtFlSqQahXrDL3RwpLvSep0r1rm76l1hCdhYB8zi2HgEg//kAsb5nr6YKR0+BwroPcpKs4rNJ+XcXgmRwF+73Zor0+JCAideDkh5FnhR84h4IQl7/OXOTMWxuC5304D18qHkfXY0iBOlxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633998; c=relaxed/simple;
	bh=mhSNgbhfCuC8rtoxwsaS41JuR4vfvRIEi7/xaRjQLYY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MXjmkQq613ElpgbUfwL66fSGqg/sKfrQ/pFIH0jdQO3r9OUzV6T0etrFhR9BwNNY4MLI8jaMCTrvr+W9a6/WvAMH9OMVsTI7ajCX1Sub2/A3hnClUxmmD9gzQ4yNtKXUEFllsWmxD0TKldG7AawbbSlJIPsE8jHyEJq5buorzqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CXw9Jgzn; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CXw9Jgzn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDldEj01741a8bCNSSSnlhgVmJ1uxmsymgflNfVdiwpoAP1J7/VdX+2ZfIvOM2bLzIQzHLmv0BWtIFtB9YrubbAGhexhEJEvoFJaxVbGO4nsaU/k7JMVBvaAftfklqCbWTPHGVOYCPXZ8MWs+jMbfodzvvZAMYzU1uUz60bYgiU5lvkqFtJRqSlHRtqbydr3WS9Y0xZOVe0KbAYBbLZj6KgDlxkLDnQULWLNq5hd23/HFlwxSCCQ8hqmAQUa9p7X9UySgZMms9zjrMeanWQsXBs+Tu0lTdXjoWMFZXX5EpvaA6XF6TK+DgJfxlMjgUl2F4/sqZ+14mSlwfwAJY8bxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VdbdnmhuogrNDFUv5o3+fq8uh2TnFVXrI+6jfKizlQ=;
 b=SGhi/wUVmD1ao4GnATdIBZQDaNm4m/Xc2X1TBitQ0nou+gZq4saHbNoATPFHd7A7A8gui8NwQq2vNKeGp5l8+h2bB8Ye0TnFFaywiQ2LzvctWnAv+aVij2C6W9cae7UAWsecKTYh226Vv0v7uFrHsUB2m/KMpqaOi5YaDZREk9bJdh2hfl6+U5/H8OgB4OZDiyICXUQGnZQ02z0s/FYOwl+MzPPCqqOAMnnW/ItgDLN4DW095rwxP9/IpW3QI4gpHuxK5YTdrwEyc9zLvYdARu0ZG/4tGLUHXei2Hoyc9cMskwy8kuNGXShVwKoYs0oHiQ6OsHWd3JKnDB5vSPURxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VdbdnmhuogrNDFUv5o3+fq8uh2TnFVXrI+6jfKizlQ=;
 b=CXw9JgznsdXvyAF8HVjoJKbQjf84QV5t741VoRK7HO8KrVfU+KWw+FcjVAcAvKKWZcBTrfyk5uBgiIgVLyEHp12Mo31ZtK5jw151hEz9BR0QRJKOfbe/mqwb3DbCzzvZq2zXtn//1a1nsgmuxWhI/JXrRdz9Z3m7VE7R3Yy2tSnMy2shk/pg3ZHOFOmdjAjvW5lOI1S0GxqMRoMstzw6jsUOFbBbjfsd4ZoRZVAvdA1mM2etrPMvXFpD5B8ieszTyQV8xY1y8kyxSW3sZVevoa3Xs1FeghiEW7MLatuBs6gB1BCnALMFnaNcakYF9BaeUtmZYWMZvH/5Ljuc9U0WuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 16:06:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.021; Wed, 7 May 2025
 16:06:31 +0000
Message-ID: <b242ab38-c488-450c-9735-11e1b666106c@nvidia.com>
Date: Wed, 7 May 2025 12:06:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu/nocb: Add Safe checks for access offloaded rdp
To: Zqiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 urezki@gmail.com, boqun.feng@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-2-qiang.zhang1211@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250507112605.20910-2-qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:408:143::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: bc405d4a-6ae7-4e56-ace4-08dd8d8121d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDlkZWtoSXVYSWNqVE13LzN5Tm00Q1ErUXpMWmZ3L3p1bWsxZ0JrZlkzMGpI?=
 =?utf-8?B?dDVLOGtqOUVSZjI3RjZWNVZxd2xDaTNwbkpQYVBLOFlpVWJNMHVxTGw5N0dX?=
 =?utf-8?B?Zk1LeUQ5THBFVCsvdXA0QmVWcFh2TTN5RW14b1F1bTRXZVhSRENJUkRmcXpu?=
 =?utf-8?B?ay9jWnFnTWdESENaKy92Y0RXeVhiMU93RlRxWnVSSlhtTDZORWVENkJDNUh3?=
 =?utf-8?B?UDM1S044L2lVQnhXUVM3eXcydlFycDFZVlNyQU5VNXdybThlL3YzeGhxbEp0?=
 =?utf-8?B?aUEvejVYOGlEdTVCYktCa2ovcnRHUVhkQUN1VDkrZXJnZ3Z3OGh2OGRkd1Qy?=
 =?utf-8?B?MDN4YkdZMjBwZDk2a05BdHgxMlJTdWZQVFhEQ05HWVk5eERuL09PVGFsMVJ5?=
 =?utf-8?B?WkFWNHl0ZHpnRm54Y2ZhUUd0Y1dtRm5LeE0veExpM0tvOUs5WEdEMFJxN2pr?=
 =?utf-8?B?MVRqUmozNncyNS9QOWYxTmw1SEZ5Q0tITktxZkFoTlhPaWdUZ3VGTE1FME1z?=
 =?utf-8?B?SEhTUWNzVGM2NlpjWEFXQkI0QkVtblZCKzlRM1EzMDAwandINE1NK1lBYW9M?=
 =?utf-8?B?K0tTTTRLS1h1RTcyWTJrYnRxR2xWZGxZaUxMenlQOHZZOGV4bkR2WVJZdU00?=
 =?utf-8?B?QnI3V2xEanZlWUYvQStMVmZSQ01pRkJxL3BxdXBTSFlQNG1IdWp1cENrV2la?=
 =?utf-8?B?RXlkSUNRZnJzam0yWlhPUU81dkdKOW1yKy9EdVVWQnorZU1kWFlaQldzQVBM?=
 =?utf-8?B?RXhIWXd4MU1DUHl5ZzY5WlRhdHp2NFJ4UzRVSnNzVzRHclJLNGFDNFQwWTcy?=
 =?utf-8?B?MFhGT2daVVJhMk9acVRzNmlUQ3dBTE9ONldXY3NQZ2NXNFIrYzM3ZnNVaEsv?=
 =?utf-8?B?cW1na1g2bHJiRVdjdWhxTmloZ2I2d28vT0tEZUNJeGh6R3d4M3A4U3l3T1Fj?=
 =?utf-8?B?ZFN6TUxJNnVzbk04YVVLMmgyQUYzV0xiSndjL0xNSU5jLytHR0JMOGdOZW5l?=
 =?utf-8?B?ZWpGTG41dWhUanZEdFM1bmRnU1c0Z0wzQnlKL0FaSWZ4Z0IyM2JRTlJoYnNE?=
 =?utf-8?B?ZU1yYXZrOVBibStaNzd3NWpoSzZkUVZNWkZYT1h6MXBVemJvcEZoV2RZb2RW?=
 =?utf-8?B?aG41ZlIzcWE1ZW1aM2lreUxxekhISy8xVXdwS3B3OFVDSlgzT1RvVy9oamRz?=
 =?utf-8?B?MTlKek1aa2FYWlprb05FUHFURHlWLzJNTnhyeFVlTlhXZTJPYmxpQkJ3VEQ2?=
 =?utf-8?B?a2IwVW9nMUFSQ0wzR09iN3Z1d2g4cEpRYzk2QjJGcW9KZnA4VkF4Vjc2Ymt5?=
 =?utf-8?B?UDRBRFB4VVlyY3l6NFFCRHM1dXB0dEZxa25tTmp6aVBTRXlJM1ZhZHZOckU4?=
 =?utf-8?B?UTZaU0JxUndQNFBxUlU4WExkVEF6NjFZSWtGWlp5OVZVaFpNT1BqMUsyTmho?=
 =?utf-8?B?WExGSEdSVit5MDQwckY2cWdhQ2poT3lNSG9FYjRWSkIzWnpRaXhyKzRUcUUv?=
 =?utf-8?B?K3ZQc3FBbE5wUE5BTWdIeUFMMzhnS042WlZjcDdRdkwzdDVoWWJRQU1zMERS?=
 =?utf-8?B?KzJQN0hKRkVVTGZJeGNlamNIUWExOUtPT0NuaHNPcGFRUTVSWHUzaU0yVTJm?=
 =?utf-8?B?RFpES3FhMGMrQ2Q0RnQ0N1lSUnZuclhWK0NPZ0Z0bEtQUmRIaCtJYURFRnlk?=
 =?utf-8?B?MU4rK0pPeHFDTThNYjh0YUVrT3hDM1VNWjl4cCtJajAvYk02cG5kOERJTFp5?=
 =?utf-8?B?eGxFZExiblcwam5obnd1VGk2czlaOGRxOWY3S1BPSGprVlpSVzNYTHVMS1Fp?=
 =?utf-8?B?MXpIT21uTzBXZlYzaHhxSlRmejJ0TDZWc29Wd0xJaGxoUFZ5S09zRjdYRko3?=
 =?utf-8?B?R1ZmNng0a1czRUdpWkhUdHI3R091Y2VydUJ2anJ2Q2hoNVZZYzYxRVZsWmlT?=
 =?utf-8?Q?GgZckiKdGrg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlptZEJ3RFVTMzkrNW95RGF2b1VTK2tVdHQ0T3BVQS80SFhtSTdGZmQ0RGRV?=
 =?utf-8?B?SUZtQ0w3eVJvakRWQjBMQUNETGY0WUtmTnNGTzJMUEcrcDdyT0w1UXNPYWEv?=
 =?utf-8?B?dWRXVGgyZDROcXU4OXFKY0FONUJTNWdoTndJQWgxdUZUVy90dmszRDhoUmdH?=
 =?utf-8?B?NEJJbVpwM2grSGFudEhKUWtzQzZkb3RvNFJocjBXdW1vMGI1N0xqMlQvVzBL?=
 =?utf-8?B?cXc4L2dXVFlvc2wyU0tnbWFxaFVxUms3a1N4WjFEZlZleXA4MHBqQUdJZXp3?=
 =?utf-8?B?Mit6NjEvWVdmeDlXeVdRcWRNSXdRbUdYbEFWSDVsQk84bk5HNmJabjR0VWh2?=
 =?utf-8?B?UVBnTGZvc1dHTUdFRDVaQXFIQm80cjh5Y2NldGV5Um1FaU9POW1MeW5rY0V5?=
 =?utf-8?B?K2RJQkUyN3VBR0FoNWpNeUp6RWZtSm1RUjIrUTRZRzVDamQxMCtGZ0dnaW5x?=
 =?utf-8?B?eTdlanhaQ2VEYXlibEM2VWdPajRRc0tPT1hrVEJOS1drNkdQTWtjVXZEVkNs?=
 =?utf-8?B?TDArNG1xTDV6WEN5REZnRHFUc3BiSVdtRTdXenFiUE9aWDNJMk5ZVlRGRjE2?=
 =?utf-8?B?TXFRSkZsOTUxbkJ3TlJXK1grUXJSOU13WlZIV1R3dHFmRWRVaVNuY2s4QWJa?=
 =?utf-8?B?N1RrYUJrOSs1OEpEcUZXMVBHTG9zNlpjZEQ3alBUNEMvTExTMk1OWWh5Tldk?=
 =?utf-8?B?b1RtNEx4TldIWkxsOGduNHJxU0tuQnJBNWtXdmIxajFWZW9oRVVLR05rclFo?=
 =?utf-8?B?K1BROGZtQkw0azAvVFhSK1QvVTFKRVlCM1BmS3g0cjU5NnlnL0UrNFJsb3ZY?=
 =?utf-8?B?MHNWWnJ4TXpvbW1OVzY1SkRzVkt0TU80TXRzZ0YxZkNHOVJ2d0RsSGkwR2Nh?=
 =?utf-8?B?Q2JkY0ZMN1RIdWFZRzJUZlpIM3EvaE94dE5xNm92a3g3VkdJWWVRMWQ5Z1V4?=
 =?utf-8?B?M0xGODNQbitMRkZmUG5iNzljVHdZTEpMRWhaRWRZZU1QdEc4OS9CeGtyRVJQ?=
 =?utf-8?B?cjZEL29PZDR4Qm9RSWk1WXhINkpIeGE5M2NyYm14L0lERFRWdUQ3NWZJaFVh?=
 =?utf-8?B?LzJJdGZNdEQ0R2hVNUgzQkpUYVhBNTM0S1RnYVpSTUNvUFgxb1o1c2pTc1pG?=
 =?utf-8?B?QmFFMFJPSFdrMFRsSHE0d0lVSjByVzZmTncvenZJRW9iRkZxN0xIbmtxeWxl?=
 =?utf-8?B?UElWSFh3RVV1OGdvVkFwVGxSdWYyM00xVkhaU1Q4cEZ1Z0pqeHQxbVdFVkNR?=
 =?utf-8?B?Z1l3bXAxc2hFc2dzU3VwREVUOCtJRWlFVWhuOURVWWVjWVk2UzBGYkU4NHFT?=
 =?utf-8?B?WFRHL2lnZ0ViTVVnaWlWRHJzdHdteEVWVGFDcVhFUlRNVVk3ajV6WmZjWENj?=
 =?utf-8?B?a1hPcnRKQlJxREFpdEpZdlcraVlvZEtjZTh1eVBYb2szSVArRk1TNW1yOG9n?=
 =?utf-8?B?T3FrQk82ZEp3Nk00VFNPMER2aGtMTlZZR1VURGpjYzcrQWtKODdnM3A4MWF3?=
 =?utf-8?B?QU5TWXBVVkRVdzE4M0xtVkpwKzhma3FSY0JlcFpUZmVtaWlqakg2MWhvaUZO?=
 =?utf-8?B?VjFROVQ5aWxlRGNtaFk0VHc3VVlnUldLb0VFN3ZnMHh1RXRnZ3d3Y2xScGZh?=
 =?utf-8?B?WUJYTkJaL3FBUVFjSCtyM1QwWk1hZjBiRTAzTWx0NFA5VUR6akRKNHlLRWRm?=
 =?utf-8?B?Vi9jVHc1b3B2MDNkdDk0MjZwWFFXYkRjRkt5TFBFYVZPOUwyajFUY0ZXWWhY?=
 =?utf-8?B?ak9WaGFxNlNWRHFiZDdVQk9RZzIzV240SGxsVWNWU2VUbzlFenR3S2FzS1JK?=
 =?utf-8?B?d0N1RklmbUZZdFNLUTBFQ21sV1FZWUhtOThLcTNIMnN2d2h0K0xiZlljcHFi?=
 =?utf-8?B?T0k0cFBNNkpTMGNXaGxBK1VaY2U3cjhzRGZralFJbXBXTURjbjdkaXVZR3RQ?=
 =?utf-8?B?RE96Z0tDbEgxYmh1TFVITG4yY3JlTEVqZ0FxVU9LOW4rQWVhOGMybVU0MVRW?=
 =?utf-8?B?UUNhbGRFaWFxYXVXb05zOFZrMkF3ZGVGbENEc1FmZ1JQRzRpN3ZYc3NKZkg2?=
 =?utf-8?B?YkFlbitHZmpPb094bThRYTlxaG9qV25VeDlMcHY5TTQzUG5BVm5DcVBoMytu?=
 =?utf-8?Q?SI5mGOxNjf8m97fexMA93SHYr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc405d4a-6ae7-4e56-ace4-08dd8d8121d0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 16:06:31.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFYLWU5m2LDq2o6SOfjyLycPURxODRRanmzKfkUJ83QzJ47Dlx/jkrU/Wqv3j3DT/eZm1C5PKd11ZuvPNaItgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678



On 5/7/2025 7:26 AM, Zqiang wrote:
> For built with CONFIG_PROVE_RCU=y and CONFIG_PREEMPT_RT=y kernels,
> Disable BH does not change the SOFTIRQ corresponding bits in
> preempt_count(), but change current->softirq_disable_cnt, this
> resulted in the following splat:
> 
> WARNING: suspicious RCU usage
> kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
> stack backtrace:
> CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
> Call Trace:
> [    0.407907]  <TASK>
> [    0.407910]  dump_stack_lvl+0xbb/0xd0
> [    0.407917]  dump_stack+0x14/0x20
> [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
> [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
> [    0.407939]  rcu_core+0x471/0x900
> [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
> [    0.407954]  rcu_cpu_kthread+0x25f/0x870
> [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
> [    0.407966]  smpboot_thread_fn+0x34c/0xa50
> [    0.407970]  ? trace_preempt_on+0x54/0x120
> [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [    0.407982]  kthread+0x40e/0x840
> [    0.407990]  ? __pfx_kthread+0x10/0x10
> [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
> [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
> [    0.408000]  ? __pfx_kthread+0x10/0x10
> [    0.408006]  ? __pfx_kthread+0x10/0x10
> [    0.408011]  ret_from_fork+0x40/0x70
> [    0.408013]  ? __pfx_kthread+0x10/0x10
> [    0.408018]  ret_from_fork_asm+0x1a/0x30
> [    0.408042]  </TASK>
> 
> Currently, triggering an rdp offloaded state change need the
> corresponding rdp's CPU goes offline, and at this time the rcuc
> kthreads has already in parking state. this means the corresponding
> rcuc kthreads can safely read offloaded state of rdp while it's
> corresponding cpu is online.
> 
> This commit therefore add softirq_count() check for
> Preempt-RT kernels.
> 
> Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 003e549f6514..a91b2322a0cd 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -29,7 +29,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>  		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
>  		  lockdep_is_held(&rdp->nocb_lock) ||
>  		  lockdep_is_held(&rcu_state.nocb_mutex) ||
> -		  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
> +		  ((!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) || softirq_count()) &&
>  		   rdp == this_cpu_ptr(&rcu_data)) ||
This looks good to me. Frederic told me he'll further review and give final
green signal. Then I'll pull this particular one.

One thing I was wondering -- it would be really nice if preemptible() itself
checked for softirq_count() by default. Or adding something like a
really_preemptible() which checks for both CONFIG_PREEMPT_COUNT and
softirq_count() along with preemptible().  I feel like this always comes back to
bite us in different ways, and not knowing atomicity complicates various code paths.

Maybe a summer holidays project? ;)

 - Joel


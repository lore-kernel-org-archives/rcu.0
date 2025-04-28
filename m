Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12082AD04;
	Mon, 28 Apr 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851613; cv=fail; b=sMs0BCV/pY+RQLAxCm/vBI2tODgsIgs4OLgGoZpYnk1iNU0bFQOYtduuzH6OdpANjMkJ5KsRuNUiJbwWhvY1+vQSwdsH24r6xRexfNZwl+aRJBLBky5GxkcCxCHx71yMJ7U8hxSccOcSXH03RkpATYluUesXXX3ns2jnWMEPZjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851613; c=relaxed/simple;
	bh=/pyih8nmUdFQxGFHjdOVk+shNu1JsIeTfwMqWFJtOfk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hGTnrWQJXsfYVRac/Ps0baWhm1GoxuI5EsS8ypUUqZIA0tKt5sDbQ2jrb/km/sediT8os7u2HImlkwfzumGB4dPLMxNBZaRa7Dn3pMyCtfqh/EdpoB5khFcOd+BeY1A5/szvbf7qPrsbn0LSOrdFz+72liYMBoAQ0cq3EXngOtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M5Way3gt; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M5Way3gt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5+i+vEHccXvSHTx6fXGo/OVmZFAd9EQuR16n99pQIvc29Yt4m7h8ipfEOhRDrH+TdT4qp6gfrtGQEiYEANP9lA1UYL8g5XV0F+PZmGQK8sa3JiWwx0aedjPR9H1V/oLfND0l1WekTUzCr66gFYGyCQDOxHP3jo6SOpZZq5Hva98HwdSr4+nyGp9W2S6YcpguOn6GMtNYpJcUQaDVypx38wvFV2Mo/n0EAMTSz4WANj2GtwcGGaucRsPljbRhNnvDTZ5Emz3XId8+areiaEyFRgW+RTz6c8Wd3iu64ed2+Owi1yREkZZLaNuF2J62iWWFh94mh1MogC5A9PcYScSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwriJOgxBqD2UGvr6oUEceeJ+AZYSaJL8mkcm66dCbY=;
 b=yVF5F32Butxt+mn+cCTGGUocy/MoJ6YYS+DH8oyBxj/AdME3jK9JBfntfHXqvkYSu/DDeariOC8wCegvmwAyaOfyCaNto+yM9s0Cf69nN3Yl4+APvOjbmGbJDrm/4J863ijoecdAsucd3nuM1FV6cQ57N/I0mYi+WOvCKpUlv5jMmc8iScPMMFOvo5eqTVU8D2pVrB3vww6YXpOVmlJpGyUb7qWoNaQ58EuyIygLdsPhKK3SM57YdTJhgxpfWWusJbDBEtOXtvDHwx5rPRfP9v0LN71aW0F/8IfEyp7hXzDmcFEt2R25zyGKkK3DfZOhsGnmBp14+ApKhTy3YCNhEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwriJOgxBqD2UGvr6oUEceeJ+AZYSaJL8mkcm66dCbY=;
 b=M5Way3gtV4SDya6hWbm895VDlSyqufarMX6z41ufUArznOcuz5zgh7j0H9dzvLMPH+V391FKgOD9tlcJyXvPg0SyAnDb9mHOXeSugeCcj/+GqMxCkDLePtRidn3TrJUEHPQZa71TGUQpqc6n8TbjTP/duNBeWdolBLs2BrMD/bO/+aba4KGiFFDpMEzPguJpippyQd1XpYZn1sKb+VzlYdtC+dSa70zJBVDAPJXFboyXJYIpVLuPWFCQUmy5iJs10aPZnSPyENKrZsp3rQwVCXCKG1f82IE68SM4rx1vP2qwNsyiLKkxdc6ORDmaViv2WfYECOEGJ2KMbtVnbnjiIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 14:46:45 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 14:46:45 +0000
Message-ID: <b1d6d155-de0a-4715-9de6-45d3d9e5c9a6@nvidia.com>
Date: Mon, 28 Apr 2025 10:46:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu/nocb: Add Safe checks for access offloaded rdp
To: Z qiang <qiang.zhang1211@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250428095403.22889-1-qiang.zhang1211@gmail.com>
 <aA9U9QvB2t2MLuU2@pavilion.home>
 <CALm+0cW2tXM-HvzoMsNBk4DNyZ-LuUkGj5M4wVLJixSvUDP+Dw@mail.gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <CALm+0cW2tXM-HvzoMsNBk4DNyZ-LuUkGj5M4wVLJixSvUDP+Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:335::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: de18fdb5-3d3b-43b9-1dfe-08dd86637f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjkrM0hCdTZack9pVHVBQ1pMT1ZpbG5VUTlDaE1Ib1NlR3Q2bGdtbStjUVFo?=
 =?utf-8?B?MEsxVUF2d3BPOW1LSkl1SmU0NjdqWEV2WkR0UnFUMjNiS1hZTTNIMWZLaHAv?=
 =?utf-8?B?UU0yN09weW9FdHJLQ3lzdE4zM1lUK1ZWNUpzWEdsNWtxY09acEg3MFBNbzVJ?=
 =?utf-8?B?TkNXaVVaSDV6NjM1WlFsUUs1MkF6RE4rN1hmOW1BVHV0RzBWNVRxL052ZXBS?=
 =?utf-8?B?djVLd0xQRWpzVU5PM1BWdCt5c0lMNVhnNEFJT1dtdFZoa2FVZVpyamRaUXhu?=
 =?utf-8?B?MFgyQktnT005UUxtZDJTNFJ1MTF3dFp2RWZycllheEltaFZXTFBQM0h0RTFM?=
 =?utf-8?B?YVNKQTlZdHZhUlZ6UUw0bnBxYkFyTWJQWjAyN2lpb3RNd2VWM0N6engzMjN4?=
 =?utf-8?B?bVA4MUhFTVpwV1VrVm55VU9IT3VBQllHZUI5ZHJaOGt5dDJZbUMzOW13TFZp?=
 =?utf-8?B?eC9GbjdlUGVsV3paYUM0aG5sRjIrdTZPQVFHbmZncStZaWJJR2pxQ05pL09P?=
 =?utf-8?B?QWNaMDI5Sm9EcVZFUmVEb0x6VXcyZDN5ZmUrYzFIZzFnZWxhbGEzN0laNWJO?=
 =?utf-8?B?UmdvMG14Zmg2NUw3dW1CNUxWU2svT3p2S0kvbHBSelFOMkRkU1h0UXhmdFM4?=
 =?utf-8?B?cGwvdTAvaEl4OTBwM0JqNFVDM2xqRnBaL2JsNXVqNVIzOUl2ZjMrU3kxelJE?=
 =?utf-8?B?KzJWL0J3ZXZDdXFkcHgrVElMa3BhWXZ2SDk1aGhobGFPRUgzWGtjMTQrRHVN?=
 =?utf-8?B?OWRMNXQzUmgvcUQ5R2hFRFlBUFU0ZVg0Q25hVE44dWhnVTVaNUpsYW5jQjVH?=
 =?utf-8?B?VjFLSXErOVhwKzI0dVFJU0IzRTBXZ0pRL3dIVlI0S3VrNHJtRTNhK3NQdjYw?=
 =?utf-8?B?RmE5NW0vTFp3NnFjY1ZZNGNiaXlvMW9TaWU5ZHU4enltTUpoZEU1OC96WWp2?=
 =?utf-8?B?WXJ1bGZ2cjRTUkw3bHNLOTlzRHdFMVE3MVAxZDJKeTBBRlhMM3hQMWVHYnRl?=
 =?utf-8?B?Wm9tblYvMzh2eldzNng5VTUwcWZWb20ybEYwdGtoUVo0M3RXVEJvSDlQazVh?=
 =?utf-8?B?S0hXQ24xdmFUZmtXbWFTNVhxUWdzMHM3U3d4NjdoS2hIelE0UDJIMTh5Qmo5?=
 =?utf-8?B?cnQzVlJpTVJwLzU5bDVhRDVVRnhUY0l4VUFKcXBTcE1UMGUxZDdUNi93cFl0?=
 =?utf-8?B?RDVpL3RaT1YxTzN1QlB3RmZUOEMxeG9QTlAyUm8rejZqSFczMFJyeVFpTkZ5?=
 =?utf-8?B?TmxudllKM29vNzdmdW50WVRoVnBXaVFGQ3VFSnVZWmhyQ1BjMWt5eE9RanVs?=
 =?utf-8?B?SXpnRHdFQVU4Z1A2SlhwS0lYaFdNNDUyZEdIYmxyU2FHc3NISUZvSkgzVDZV?=
 =?utf-8?B?S0VCcTN3Vk9GdURnMWFJSnBEQkFOenR5N1JFMU5jdkF1cHA2M0xzTE1WNFA4?=
 =?utf-8?B?N0VZczJzZlQwd2JMTjUzR2d2RDNyTEVQQkV3OTIwb05xSUhCOE8zZEl1N1hX?=
 =?utf-8?B?OE4rUHM4Q0ttcHBGejV6ZDhqVFhIUzJNcDh3V1RyVUhsT2F6YjRWbldDTTJV?=
 =?utf-8?B?RnA5QU1lTElTaVI1OVBJQ0l6eWR6OEtWUTlPcTNUVDhlUHJGb1BOVFNYZUhN?=
 =?utf-8?B?WnRuQ0crTG1wZ2g0VmhmQ3o5S21HOFZYT1F4cGNYZEh2MEpPdE1NMkRGQVpy?=
 =?utf-8?B?TjZndW4zQlErdTZQalE5L1NJOWgxTnZZVHZKUGNyRlZrZnoySlI4TExqRmpl?=
 =?utf-8?B?Rm4zSUlIOXk1bTdaZExic0x3STdtN1FSV3NzRGRUODh5NC9JQ2EvT2dJSlA4?=
 =?utf-8?B?U3BXaFFGSHRwRGRmYmpDM1NxTzdlYlYraWtHUmNmOE5OckVuaVZ4N2J0MlBW?=
 =?utf-8?B?UjRxS1FzWExPR0dOWUlyN0ZVeXBseE55ZDBkRWMwbTc2NzdERU5BSDB2OUFx?=
 =?utf-8?Q?f18LigXhtF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVIyektUZ3Z4QUJIZHJzR3lGc0JZMHpNS1gydFJBTUY3VDR2K3dacGljVGE0?=
 =?utf-8?B?dFdmVWFJbTNXQ3c4NC90NFlNazllb3VlWHJmdlQrU1EyQ0JsQVBxQWRlY25s?=
 =?utf-8?B?ZzlqRGxQWm84OHV4TnBDcW5kVTFOOEZqQmxFVEpFTHM3cGlxWDF6MlNieW8w?=
 =?utf-8?B?cm1PY29WUHJ0dGNDYlhiQmpSZWc3dFlFRG94T0hzYU4xcXJEYjhUSnYvYndj?=
 =?utf-8?B?TDFaNnZoZCt5ajdzbk5UekR6dWlhZFJQVElJUDVwZmJSbW02OFdEQnY4MjNO?=
 =?utf-8?B?MTZ1SWM3Yi90TW1xZWM1dzJBd3BEb2lJRDI0bitWM1ZvYXpBWHdDSmVGdzdo?=
 =?utf-8?B?czNWTndSZDNTaFI3eUd1Vk1Yb01jeGxaQ1FvMlM5d013NUNlV2d0bG8zUGhO?=
 =?utf-8?B?ZmRQdW1SbnhnUC9FYVRFTjZ3eE1aSGR0TW5zeEwwNUVtWnRuRWduZ2EyV0Ey?=
 =?utf-8?B?SXpFd0h1OE9ZMXQwZFlSclhMUkgyWE0zeEQ3Ylk4clE4WjlzeVdFWmg3M3Za?=
 =?utf-8?B?b1AxeWRjU3gvMWpjRFRKSDMzR3RoQmlJRnZCQVdpWE9UVTgrOXV4bjdLM1Bs?=
 =?utf-8?B?cVI1QUQ0Vy9EcVpQcFBwQ0REVmRiVkZrVjNNZFU2NXZ2bUZqc05oUENTbnYy?=
 =?utf-8?B?aFVYRXhzM2dGSzBoVFVGcFhwZDNKUkR2TVl1a1BjblI3NFg1OE44RFFZdWFL?=
 =?utf-8?B?VXRkdUEwM1lwMVNBSnJ2QXYwRWFPaUE2VzJIemZCMExISW1rWkUyVk9VV0Na?=
 =?utf-8?B?RWxMeS9kNzJPOTU4TG56SWI3LzdLcllabGl5WVh3cURFZnlVcnVJUmljM3l4?=
 =?utf-8?B?aXJxdTZwS0xBTGRhT3lpSDMzN2x1dEdxOGJmaUZZMVBLay8xd3hqOWpLZEVl?=
 =?utf-8?B?Y1IwemlBVGhNSm44Y0tSOHRoVGlqeVBmQU9xYmNpbUNoZkxtWXcrUHVKWFg1?=
 =?utf-8?B?RUVDaXk2RVhYakVydkZnLzNWQTFacHZMZmc0czBkTEpJaVUwckE2bDlMci9o?=
 =?utf-8?B?bHZiUHFuMEwxMXRJWHEweEhMbFB6dFd6MG16K0xqUGVDQ09NZms1MUpkdy8v?=
 =?utf-8?B?THE4dURzQkZsSms3czZqREZwNVR6K3AwU1owelQ1aWxWWnRhTnNTSXZINGQ0?=
 =?utf-8?B?VTNqazYyMExGbG9wZXFQQUx2N1pCTTgvMFdaNW1SNGVzNEdFa2dhWW51cWFl?=
 =?utf-8?B?bkwwbDN3bHVITTlmTGZKellzeUZGVjhZMmNMUmwxUnVpdHdYekhtVUQ4Zkhj?=
 =?utf-8?B?RFFXR1lqUG4xdkp5anpoQTNqcGlKdmdYTjFUUysyZjhCNmlmUEFKOHNJdDdq?=
 =?utf-8?B?N1p6VzRUUlU2UEhuaExRMnhXM0hjZGR2c0lCYUY1RHZyMURSR3dXdW5qdkhT?=
 =?utf-8?B?eTlnOFhIdURJYW1aWFFpVG9WSWF4WUNETDRDUGJScERWVEVUbFRkT0hINU1s?=
 =?utf-8?B?cExNYm1EaWpYSjJQK1E0UXc2dmJLaGp2MzUyMUpMYVJLNDBXVy9jYzl4aFBh?=
 =?utf-8?B?dDB5cmNUUVhodVdVZkc2bjRrUjRONDA1cDhxUWNzak1aWXNJVmhpc3J4UzVw?=
 =?utf-8?B?ekxRUUczUlg4S3licTFJYVF6cTAzZUpJQXFrV3RTdkQrQTRNYTN0UTUrM0JI?=
 =?utf-8?B?VFY1RXgwL0NCQllqaDhrZFovclBiMkk5ZkVhNy9UVjBFRVNBL0pLTll5Z1Fa?=
 =?utf-8?B?YW9mM3l0TExYTzJRd3cyQk5rS2FaL3JvQXBrWG92TmduRGQveTFzakNNYlpX?=
 =?utf-8?B?cFlNZFIvMEJLNmlDc1ZlelZXb1B2dkpLWEp3MEVBZmloanRSc3dyeHd6ZWhn?=
 =?utf-8?B?akYxLzFZejI4S0JGZUFZa2ZSbERFRVdnNjg2RnovUDE4bEQrTGNkZDFod3RC?=
 =?utf-8?B?Qm5kdG1XRkZ5MGhOaXl3R3llUGozeTVib21GVFF6N3g2MGxoVWM4SklJYUZL?=
 =?utf-8?B?azFCWGtWajlTQVV1M0xxa2Zhbi9LblVVNThmM3JoQ3Qxc05veEVrTGp4TFRH?=
 =?utf-8?B?bUJMUnNWSDJ6SVVoZmRBYkJSZlFMNStXckdYaEtUTUlKRTl6NEp0YSsveVRC?=
 =?utf-8?B?TGxJZGhDUTFycnNiTVltKzlWREFLcS9OUU1NaU44V2V6cXFjd2dMdWFBSjNJ?=
 =?utf-8?Q?Epq3tlo6b5mSAQ4WzXTGEEvEQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de18fdb5-3d3b-43b9-1dfe-08dd86637f1e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:46:45.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yP+tdhnqn+3N4N2kGZghhipv7CkcxZxHSPFlZ6sXGM4fuM0l6WE1dGg6OAmBTCgf7OsB1rVEzXXH3IAlKcvwwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213



On 4/28/2025 6:59 AM, Z qiang wrote:
>>
>> Le Mon, Apr 28, 2025 at 05:54:03PM +0800, Zqiang a écrit :
>>> For Preempt-RT kernel, when enable CONFIG_PROVE_RCU Kconfig,
>>> disable local bh in rcuc kthreads will not affect preempt_count(),
>>> this resulted in the following splat:
>>>
>>> WARNING: suspicious RCU usage
>>> kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
>>> stack backtrace:
>>> CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
>>> Call Trace:
>>> [    0.407907]  <TASK>
>>> [    0.407910]  dump_stack_lvl+0xbb/0xd0
>>> [    0.407917]  dump_stack+0x14/0x20
>>> [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
>>> [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
>>> [    0.407939]  rcu_core+0x471/0x900
>>> [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
>>> [    0.407954]  rcu_cpu_kthread+0x25f/0x870
>>> [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
>>> [    0.407966]  smpboot_thread_fn+0x34c/0xa50
>>> [    0.407970]  ? trace_preempt_on+0x54/0x120
>>> [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
>>> [    0.407982]  kthread+0x40e/0x840
>>> [    0.407990]  ? __pfx_kthread+0x10/0x10
>>> [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
>>> [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
>>> [    0.408000]  ? __pfx_kthread+0x10/0x10
>>> [    0.408006]  ? __pfx_kthread+0x10/0x10
>>> [    0.408011]  ret_from_fork+0x40/0x70
>>> [    0.408013]  ? __pfx_kthread+0x10/0x10
>>> [    0.408018]  ret_from_fork_asm+0x1a/0x30
>>> [    0.408042]  </TASK>
>>>
>>> Currently, triggering an rdp offloaded state change need the
>>> corresponding rdp's CPU goes offline, and at this time the rcuc
>>> kthreads has already in parking state. this means the corresponding
>>> rcuc kthreads can safely read offloaded state of rdp while it's
>>> corresponding cpu is online.
>>>
>>> This commit therefore add rdp->rcu_cpu_kthread_task check for
>>> Preempt-RT kernels.
>>>
>>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>>> ---
>>>  kernel/rcu/tree_plugin.h | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>> index 003e549f6514..fe728eded36e 100644
>>> --- a/kernel/rcu/tree_plugin.h
>>> +++ b/kernel/rcu/tree_plugin.h
>>> @@ -31,7 +31,9 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>>>                 lockdep_is_held(&rcu_state.nocb_mutex) ||
>>>                 (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
>>>                  rdp == this_cpu_ptr(&rcu_data)) ||
>>> -               rcu_current_is_nocb_kthread(rdp)),
>>> +               rcu_current_is_nocb_kthread(rdp) ||
>>> +               (IS_ENABLED(CONFIG_PREEMPT_RT) &&
>>> +                current == rdp->rcu_cpu_kthread_task)),
>>
>> Isn't it safe also on !CONFIG_PREEMPT_RT ?
> 
> For !CONFIG_PREEMPT_RT and  in rcuc kthreads, it's also safe,
> but the following check will passed :
> 
> (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
>           rdp == this_cpu_ptr(&rcu_data))

I think the fact that it already passes for !PREEMPT_RT does not matter, because
it simplifies the code so drop the PREEMPT_RT check?

Or will softirq_count() not work? It appears to have special casing for
PREEMPT_RT's local_bh_disable():

(   ( !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) || softirq_count() )
   && rdp == this_cpu_ptr(&rcu_data))  )

thanks,

- Joel






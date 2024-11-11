Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815E14600D;
	Mon, 11 Nov 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318894; cv=fail; b=D1Gsp801rDZrkIPCQXTPPCEbqlMZfCT6pBgzqzc6e4/Jg7EnYU/J0iF22ChV8ZbyxgR15sURlTV+ENe69Vz+6jf8IA4MvNaUMGCvBMFfNxxBH6lQ1+UTBfRbJQPd4sa6+BMziwvesQDriRqs5amgU3Y/igFw+dVh1jvBFQD2HJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318894; c=relaxed/simple;
	bh=rFI6XihFKZ9/No5BwI5BIlDORJBwiBsBfUsirR2Ak+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOShjB6loja5RrbW5Au7QOAXjGxHCFoxQs+MzjU6iv+pE5GqOcIzkgCNt7MioTFl/vaRKHcoa9a2XII/PeEon2W69nawxsOdLTHpeNV8HBD+HsBm4BZhXxd6KJd9JpSlHJ77gW/X+DtL4BrIZjTINj2pG75Kn1sgzqJFcR+BJLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KrVp8VK2; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KrVp8VK2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwXk73fzF3TujwcR++Ca4ZNP5bcxctPh+CYXdgpiV0ksxlZo99D8dhc1ouYOU7PEjrU1JVizppFUNew/BygHJm/AS76Km/FqvYNbBdPGsJ9hj0epj46eHWQKDTFKD2bTDZGBfF00EKrC2ioYmTwqR6h+/w8aCkReaQaEZRA1e8pyFo1ebcFUCWs0yrrjewrjj7+/tGDoJFnxDlLV3a9KAk8O0Gb1Naff5/9QcQirSkm919X4wNrBSzqdmYLWplL6JLV7VZAy5i4/mrJrMo+6Kpnj5OUgsKQo5JSpnD3MfkCQ9OLXJBdcD7Vkn2o1bjYrymsBq4wip6i2qubjXXMapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAM4zD/RUACNngYHZJQYC6LDohi6OaAckcsliJtXbzE=;
 b=XKgLwsoj3YemnP/5bM2ODBAag/+rQiz0nDAPAROubNy+Rz1r14YmBZ5byECe+sNqc38/vU6JkHIfmYsiJDu3pYEDTLaWccfJ2c7MMhgdUD82x3oaEDPoeQ9vmCeI8wqM4hdQZMNKB0QqO6PV1r6jHTibH1gaw+tfbkM/TofjSKibSKp57cxpD+ibpbz5L9Z9AT5vQ3l5zkcU1JbvrOOPLuRxRFhLaMkG/Zp3sRyeTyF1SHUBM06kavVxkb6v49TI+xUcGTeGTJqxf3cSItFJujR0b7ZEOrxsF9PAW0TirR3KOPCDnfyidXmLbCIxdRwRALNu5vxIQP8PslHYa71Vtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAM4zD/RUACNngYHZJQYC6LDohi6OaAckcsliJtXbzE=;
 b=KrVp8VK2y9N//1+sZuaoPbFqWyF012YtcmAME2xn76/xpKwWNQPXqenf0q+/LmYIa9GY31AwPSYbN6ZKNZMAidY2vllSysNlqqiK9FlDwW1Gf1nlS9X+bXDw3uLuWX7j4NUxwV8jSiwXahOh4mAUI02LPQHlZwoyNb3SE1ZGcA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 09:54:50 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.019; Mon, 11 Nov 2024
 09:54:50 +0000
Message-ID: <f4c8fcaf-185c-47f8-b926-5bc2429103a4@amd.com>
Date: Mon, 11 Nov 2024 15:24:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] rcuscale: Do a proper cleanup if kfree_scale_init()
 fails
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20241106160223.42119-1-frederic@kernel.org>
 <20241106160223.42119-6-frederic@kernel.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241106160223.42119-6-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0080.apcprd02.prod.outlook.com
 (2603:1096:4:90::20) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: c98e2ae6-0aec-4f73-cf5c-08dd0236e1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjBRY1hkc3hYRFJkaVJuam1PYjBvYkhhYVpXTWlsdjlhbFh3ajdZYTYvL3Jj?=
 =?utf-8?B?Z1dycWFWdXJnSUxJQ2U4QUFnK21TMy9XQm1icWJ3T1MwMnBIT3F0QWg3UzdZ?=
 =?utf-8?B?ZjBXems3MVc1SEg1VWZLZldvWXA0MGtIV2Nsb0xWZjZSNjBONXhzUFFhSm5L?=
 =?utf-8?B?OXBEcDNDSTJ1MnVkYjV3bWlSd1JFQ3AwZE5rUUFxYkI2U3VjNFlPY2IwZHg2?=
 =?utf-8?B?Q0w5VitlZWF6UFRpTUFUSzFmV21zT2FPTDlocFJiSElhd0VNcmV2VXNyeThk?=
 =?utf-8?B?VEFEK3VYNGZHekdkeGxCTDVjUzN4UHpDSzZzcVBsTXFxTjREV3ZEb2QvR2hy?=
 =?utf-8?B?VUIwczZNTkloWUlKUlBuV3RyY0IwVUdkZW9wNnFvZVFDYmltb1pJdmgySThY?=
 =?utf-8?B?NElsdG1hNVlrUlhBVlR1MDRnTzdwWENFQ1VRQ0JaNi9RQ2xmNWpybFluMTFO?=
 =?utf-8?B?L3hMcEhZUTZtZGRsdFpJTE85dGwxVThHVzAvenRkQkQxU2JwRnpEME5mNXlF?=
 =?utf-8?B?cVJ4NVJGb1YvWDYzSjhoRlk5akg4bkoxZEhSUkFLU2QvbjBMd0R4RFVqdWxK?=
 =?utf-8?B?YkI2emRkNXdCcW1JUDR4cEpDYWpzL3grVWhBaWNMWkttaEN4WVlwalJ3d2to?=
 =?utf-8?B?NFBSQy9qNjhjeW4zZktWNlNHcE14YVNiZE1oZG9GU1JGSWhwSnZ6NlJSRWZn?=
 =?utf-8?B?MDhqQ1l1aUc5NmtzOGdJWUxEUmVuWCtmUkJyQkFMdDZYdHhzamdJU3Qybm9E?=
 =?utf-8?B?NWsyeGZTTENqL3AzWm1jd1Z1clhpMFR0UW4xb2FtdVNDdUhjM1JBNDMzVHpI?=
 =?utf-8?B?Q1lWWHJGQlVHM1ZBaFlIUndwU0pMS3pVMW9Zemx3ZFd6dndLbitoOHJCM0Qw?=
 =?utf-8?B?ajJES1BFRERtOVhPSDY1MmpPTXY0ZUN1SzRCOW05WlRGd1JBRWZLODV6cUhB?=
 =?utf-8?B?bkNyNkdqTTFOazM2UEMyUmYxVE8xT2Vlck5PR0Z3YXNqdHhvS1BqMjU5US9q?=
 =?utf-8?B?dnNEUS9SdFJNK0ZmdENmaGxJVVNmUXM1bmNJZUFsUlZQanlFWk1hSjBwMnA2?=
 =?utf-8?B?azVzVmF4Qy82cStLSjVhdU5ib0FDRFJMMGw5emdVQm9YcDZESU9zWVprS0tJ?=
 =?utf-8?B?LzVxV3I5SEl2YW0wRHE1MTA0ZnBZemUrakF4T3UzTjF3bHNMSmJoZlJQUTd5?=
 =?utf-8?B?d3pHRmFxbmpqanJDSkRDeVdvK3lSRDJuREJBL1dTaVQzcG8wMm43MHg3NERZ?=
 =?utf-8?B?cEQySFh3ZWJhTkFMRlpnNzR0aWhtZTUrVkEvNUJyeHlkeWZzMDVQdi9rc21v?=
 =?utf-8?B?RlhDTzQ0T3ZITTdVMDhPNTlIVTZBZXhZRnd0MnAyTWNpUVZIQVRxVU4zREtt?=
 =?utf-8?B?cWp5S1ZGTlplSmlGUnBwRGJ6cHZOam9QdEpUYjdLRkxiaTVGeVlDRlR6ejN2?=
 =?utf-8?B?RUFyaXozakRya1NMUXFmMFdYZWtwTDBGTUpDczJMOVgra0hibGFEMjRsa0sx?=
 =?utf-8?B?d2JycGh3VFB2bXJFZnVKeDB5L2hnTjEwZmVlazJ6SFFGbVZFQ1RjK1p6eGRl?=
 =?utf-8?B?d0l4NDNmMHVDSWFreE96dXExL3FyWjFreFMwZDVDbUtHeWxhbkgwTlBUOU9j?=
 =?utf-8?B?ZzRMdXROWlB3Z0JMWTBGWGtzWkZHZk1DaE84S1FEbVBwT3ROYXNIbmdLWnhG?=
 =?utf-8?B?d0dMMVFWWFNRYWYrclVBT2dXZUdVellUelZwcEt4TzR6NURTUWJLSmhjUW5v?=
 =?utf-8?Q?j0Ce0U+Lq5gUHISNw1Jw646R5PRwskaCAdvle2K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUhxMmx4UkVGNm5JOWFudmJQSEFmNHM4WnpwdUEwdXcrN3V0SXFnaERBNzVT?=
 =?utf-8?B?a0pnV1hXOEdzZFNQcnlqRngrcXNmVjNQNVNsemh5a3E3S2Y3NDJDZmwxblFj?=
 =?utf-8?B?QTR4OUlFaEl0UDkxRkhuRWIrZmpLcDlhRWpLWTNocWROQVJ4RlR1TFFrUHkr?=
 =?utf-8?B?cUhoV1duUGl6WFM2Z2t6UldBSEF4QnQ0YjdsdUJDTDc3Q1pXUWllMVEzd29B?=
 =?utf-8?B?dDMxWkxiZkxra2JmOHZRWUtva21HTWFhZmJNZkNBc2JFUkIxQ0cyanBCd09l?=
 =?utf-8?B?YUo0T0YrL2JKTk1rSEhIR0NyN0V3NUVYWmVqZENScHp1VWd3UjQzWE5xZ3Bq?=
 =?utf-8?B?WDAyWmNVUmtRQ21ZNXBheEtXVTZVUmZEUHcyM2RtRkZYYzBqVEViWGpGd29j?=
 =?utf-8?B?bFhWVzZLK0RVY0hPMWtCNkZLVkV1WUxDQnBnWlJ6aEg0bzhINGlBa3RtbitO?=
 =?utf-8?B?ZjMxbTBpTlhQWG8zWVVhTjJjUG9ZWkg3c25TYWYzNktSUDU5NElLMlZHU0Rp?=
 =?utf-8?B?QXJQL2I3NUh2Z0N4c1ErVGpleVQraVhQSVRmTkd0UXFKb05kRk9VM0JQSklY?=
 =?utf-8?B?YVZUcXdiZHF4Q0YxeHVZUjRnTThLWm44VnE5NEhWNHFFWEd0L05iSzZaOWcw?=
 =?utf-8?B?QVA2NnlxdVFyMXJIbkY5U1E5NDJxTHVndFBaelZBNXcySXpsWWNEc2k4Yjhh?=
 =?utf-8?B?SlFORVF2bFlwSUFqZHNWVVA4QlBuSWtSVHJmM0hyaGhaM0hmd1lnbWpTUnJJ?=
 =?utf-8?B?VDdKNzdQMHJQSW1ndzVsTms0eHl1UFdHcGRpdVdneXZwaE5lYVBRMWJhdGRE?=
 =?utf-8?B?WVdPLzkxVHFIbW82cWMzRENrUFJvMEhqY21TMFV4MXJaUUJhSEZvTEhHeFVZ?=
 =?utf-8?B?Vnd6c0FTUXJHY1R1dmRWdUVJVHlUZFhyZGI5Rkt4TFpSb2dMWG41NDFpTElY?=
 =?utf-8?B?cXRBZjUwRmhCeXVUZXFOM1RYWS9VR2FMdzB1YjUxZ2xHOUZVYlFSbTR4cnRy?=
 =?utf-8?B?NTJ4WGl0VllPOWE5UnhkTFZ2SnFkZEliRTQzV3c4cmpyM1I1WmJjdHo3c3gv?=
 =?utf-8?B?WktMTkp5eUlBUENhUnByU1NLRWpoQ2VhQnpPQUNvcWcrR09iVlhkVEpqLzdS?=
 =?utf-8?B?dmphemljTnBRZ1psNGNVRHk1MlZlS2NOeURDaytxVDJVUlRuaXpVY0c5alRX?=
 =?utf-8?B?OVR2bkU0SzVUNktUOFUvSjN1UVB3aGptbXBJRkgrVlZSamxjdVFIMndhTm9i?=
 =?utf-8?B?dVdDZ2wyaE5Xa3hjRVp1YjN5RGV0cExDZHFyR0s5bmd6TnFaMnQyUWRnMXBC?=
 =?utf-8?B?UThrcVZwc0JtUmt5R0JsYVFwd1puQlJsMmhrVHdRT2JheEtKeGh2SWwySXlR?=
 =?utf-8?B?R3dueGFmVlQ1SmUvNkJER1FkL2VwUENOVkxqSCs0Z2RjTnlSOXhLYTYvcFYx?=
 =?utf-8?B?elR0cFgydk9peXpxOEV1M2dCMys4MU1LZWdkdEh2cE1DU2dtbnVjSXMxaHZ3?=
 =?utf-8?B?RzBNZ1FaM0REcklLd2RNTEZaNFpOZ0dSeUFXV0ZJZENKK0h4T05lbTRGMExC?=
 =?utf-8?B?MWF2WW43TXlsZmQ3TzF5eHN5SG5jL0U0TmlNZkhBSDdpajlJb3J3bllQUVh4?=
 =?utf-8?B?QTBIZ25iTGxJaHVGNCtUMVhQZ0U3WjNacXJTaE1NV3hna2xTV0swaXVna2Fj?=
 =?utf-8?B?RDl4YjVCS1Z0KzhNWW44ZUNPYlp0Ykw1VlNJeHUxK25UazlLS2JFOURlU3Nl?=
 =?utf-8?B?Mm12Y202OXZBTFNsVzdha0YyeldwRGdLalA2d2p4MGs4SXI3cFVFbGw5WkNN?=
 =?utf-8?B?ZUExRzJxSkI2U3g4V29vQW1qZ1hJanF5YWRHZjBKbStxam1lN1llckNoSDh3?=
 =?utf-8?B?eDJQdEtVRmJXUzBobUxZVXp0MnNyYW16cG94WGQrZjY4azdYUUw5amlRSTY0?=
 =?utf-8?B?dEhSdkxvUmVKcTlaT3RkcmFFdFVQT0N1WWl1VHc2NUlOTWZkTW90dzQ2TjJS?=
 =?utf-8?B?NjhXdWt2N1cxZzdnUTJpQUdyTEtad3VHTXVwUWRhcmlSRkR0UEM3Vjh4S2xN?=
 =?utf-8?B?N0dCSEZSUmpGZzVyN0M1YUFaSFV3WFRUWjUwblVWdW8ySURUT3NDekVOZlhO?=
 =?utf-8?Q?HamkT/zUWWFi1DU2PlNAFl2wM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98e2ae6-0aec-4f73-cf5c-08dd0236e1eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 09:54:50.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGzRrj51OYKF/tnyzQxEAaGLHQhbn74OKKBGpDoi0TxmS2Wy9Rrcl5Dcv1BVV4Eh2/BZV3BCZhnj2jg+SUyd+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710


> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 6d37596deb1f..de7d511e6be4 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -890,13 +890,13 @@ kfree_scale_init(void)
>  		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
>  			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
>  			WARN_ON_ONCE(1);
> -			return -1;
> +			goto unwind;

Do we need to set firsterr = -1 here before "goto unwind"? Otherwise, 0
is returned from kfree_scale_init().

>  		}
>  
>  		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
>  			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
>  			WARN_ON_ONCE(1);
> -			return -1;
> +			goto unwind;

Ditto


- Neeraj

>  		}
>  	}
>  


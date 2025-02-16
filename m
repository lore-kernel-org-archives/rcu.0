Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735678F35
	for <rcu@vger.kernel.org>; Sun, 16 Feb 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739708638; cv=fail; b=Ray1Pp3/oOML7kNEtVNxaXC47+lbAHWBQ+IXyjIXYsf3+T1lJLHSkHnkcTmDAvslqAlXCiph4n23r50U17uoAScLPc5A00spVPPAeSKsjA+KqfZCUlERUpv5uzGOYbhOQVQbgZicqUs/bKhsKTDBqWlKFsgI+uGMDWtO1w/USwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739708638; c=relaxed/simple;
	bh=odYxCbvnEx3rJf9Wt3yIoqxbxa6LedFgs5zJj9uFVYQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n+MfJHDLrxcZ0QpFgKWsIwN53Piot5kQ6wUyKi+DmpiRpIvDTBc7pTMMDu/X5LDETGNAf87XJNhJefp9tFYENAezn2xF2pPTmloZGd3FH75b43qGVIELr4xRb92tHpI7W9HD4NH1cfpoxhAVtvuQR4+KAcXmfTvIRvXZxA1I4QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A7u+lcHL; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A7u+lcHL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfIk1JMmmLO+tPocShvTnMm2g/0uoF5dUg+AG3z1KgQpoXEv29/o5Z0IZgK4Xl2IQexJVyTYlVH2rOwZPECTMpugyG2+w6T0G8rpYik5wQgwbG2x/rit1MM3GrSoIQo3OwMtXVzwjat0ZPH/zj+a95xtIA8WJGh6c48W2YZPpsAhVah+4+jdZs/Re/EW0c+7IUC2R3oWgXSOtmC+iNpTDQ6OIOjKFpfJvrohUVZFEPVY8oOfEiK5gZhKNfpHE/70b4v2aORJLZftCXOkHJF0e+iR9M/vmTituSAKyJz/uwHeBi4TGe6yCWfYaWnkshbobyr5NucQfJFi1Z56RxP44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BYdnR2it8meukWaRgS7AywJqq+ohlIODOqShsRfLXY=;
 b=o8jkICJmAfKmP/wsXBjESs4HOZNZ52WzKSpYL48g9zc7ByXZQED9YDx2c3HDoFdo/9eOu/UPBo8nlYxiWBIwz+1DG2gjWkZXA1dhWak0Cg3PAOMachUQRX5Zv3kYNb3ygAwkYK2laNlO6wZGokR1qPFb4VJ9zQOcjCI6M1kdpPFct9jtRD/cUxtzKcwIpszc4L1bpSARnVF20zprXzKH3D4ZXr1PH3PHMlEkLPpkl9WsIsXE/yo30G+7JEn/6jX73Q4aVBzztgPtRYrAa7D67v8h1IQzj1IJum2VGyjCI59Rxz2CeXGXECSBvr1sH9Hc/bEaiFTIcHXhwcOu6WZc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BYdnR2it8meukWaRgS7AywJqq+ohlIODOqShsRfLXY=;
 b=A7u+lcHLk/Vm7PfoKI19HaLfWxkk9ko9NYIA0l9BjyRugwNyz+R7zcrJJG7HSMzeZ85Ne7m8YjmhZ4CByZ95UFevx8JMWfwg2n266YhG3hEAQgCXDEFasP/q5Ra63AIsD5mZzb031Qo1gN0WQGvPjr5JaEFGoAxu5sscVYsQGV8gSo+vvCL8ay/WLEdg0MSnIUpuz189e2kxNf4ZOiE5RJqij7yQKKefUTFauO62mtjIgsmMqfVXLJuYfmtdFW+PKlJn9w7LTiz0t1dN3lcm4guxAlXxKPOgZuylKzxXUjI/Bwpkn0UGol3zhhyf1WDTkK+cP7GgKOvNANWHbPJvmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Sun, 16 Feb
 2025 12:23:52 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Sun, 16 Feb 2025
 12:23:50 +0000
Message-ID: <03416b20-789a-464e-8c2a-f9a96eec4b68@nvidia.com>
Date: Sun, 16 Feb 2025 07:23:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: The rdp->gpwrap behavior
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
References: <20250213183033.GA2635051@joelnvbox>
 <b04b997e-fee6-4c5f-a0f9-12e671d27f8c@paulmck-laptop>
 <009ef653-f41e-4101-886e-d9a4ce4d6e32@nvidia.com>
 <d1ebe3a6-42d9-489e-8df2-9dc8c2635a61@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <d1ebe3a6-42d9-489e-8df2-9dc8c2635a61@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0060.namprd16.prod.outlook.com
 (2603:10b6:208:234::29) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 65094568-de2b-4376-7742-08dd4e84c502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1g3ZGo0RzZMellzd0Q2TzBDVVVWdjQrQ0ZCZ0pzaHFaSitxamNrNG9PTW9y?=
 =?utf-8?B?b2hEWFRNUjh1S0lsUFducG9uSlhabWlob3J3WTVqb1E5bW91SmVDRWlHTUxr?=
 =?utf-8?B?WkFyMzB1RTgvVTdETVFTRkE1aGpBUFRLSE9pQlBZVzNDUkJ4UGltc3ZEQ0oz?=
 =?utf-8?B?eloxUUR3S3ZyZDI2SWhoV2tBRkRVdXliRFJNd3JsVDE3dVJhM0p6aTZ4MnJ2?=
 =?utf-8?B?QzZZU2FZOWJYTk1MTU4rT0gvaGNWTHVkVmNOSVl0clM2Zi9jUU5LcGhHNCts?=
 =?utf-8?B?Y2Y4ZjR6UUszVGFablVhRmpmYW5zdVVVZzZOaU5JNldZZWNiZ0xDYmYzemlR?=
 =?utf-8?B?QzZWTm9vWkVzdWZvTU5qVVJmeWp0dXZhUmR3ZUprQzRpTTFpTlNMY1pMZVEy?=
 =?utf-8?B?Q0lwZ2JTYyt0dEQwaGpkMTM5QVpKT1pIcmU4NDAxUnRtYkRJTzdQSXp4MnZM?=
 =?utf-8?B?SE9KbVRoajNKOEZUVTRWUnVUNzNhRTQydGc3ZkwxZ25kcGpxb0o0MHV5ZTNK?=
 =?utf-8?B?MHo4MzRxLzgzMVBaWlpSU0p3UE9SMTkzeWNpbldDYWc4VHI2SUxtaGNFeHNM?=
 =?utf-8?B?bVVPaFpBN2NiZ1VyME1aeVZZdDgrRWJPMVFUOWNoNjlQVnhuWDVSK1hRZzhV?=
 =?utf-8?B?eTBvcWZ0d0Y1L0dmSDVKcnY5LzdTQ1pzSFl6RldiaTFoUDUyQnRpRGFCS2tE?=
 =?utf-8?B?VXVuQTJQWmd2MDJSTm5DVUwxeEJtUFhyelJsVm5MVVJXNWlGVTN2MXdtNk93?=
 =?utf-8?B?RTFpVlZXSzdINHBRbnFZS0x1ZGdIQUJ3NUpMSlB4c2p1aWVZQ3VNMzRvN2d1?=
 =?utf-8?B?cEs5Vng4THZVSnFQRDQ5Y2dtdW53S2IwMVZ6SzB0c2lZTFJzbGFGUFVHV1Ny?=
 =?utf-8?B?RDNjbFI2cEVZUGVrY2lueElOZlNTYU9YSDUwd04rSHE2dnNHMHdpcTBLRE15?=
 =?utf-8?B?VEd3YW9keEZOYjhSY3FVK3YzYk03V0wxZ3VMN2JIK0pMSHd0S1UzNjVGemQ3?=
 =?utf-8?B?MGkvSHdDT0V3VExEOVVqbTdLZ2F1UlJveVFaT2FlV3JCN3hNTFhrYkNkRTB5?=
 =?utf-8?B?alA3VUxvWEUwbWpwYUc2ZDVkL0lUL3NHWlJmZCtZNnZvZ0tGSDRHWDBUMUVu?=
 =?utf-8?B?ZW1YNlAyb0Y0N3MxcFZndkx4MDZPZjJvQWlXNUREcUVidHV4T08xVGQ3Qnh1?=
 =?utf-8?B?Qk1nNEE0MllNb2t6V3UrN2g5bGdRNG4vWlNXYmRuT2M5blRpYk9rRjg2azgx?=
 =?utf-8?B?S21EUWN3RGc1aTNpMEJTcTJ3Y2hQc2tFNno1KzlubWt3RGJsUmtMbERTOFMv?=
 =?utf-8?B?Vy9HWktSb2Nicmw2cFlkSU9aMEpFYkhWMHVwWkVReUI4Rmd3QWdxT01PYjh6?=
 =?utf-8?B?b1VvbEtVUExFSmdsSUR5QW9Xc2ZFTm1oeDkvS1ZUdmRlS3J6Lzhza0o3cWRP?=
 =?utf-8?B?ZW9aWGdXVDFYZGV0Q0k1R0pRMGVBdVJPSnV5eExlWUJ2UCt5a1QvR1BZanA0?=
 =?utf-8?B?SEsxdGlhZWJrTDdEOHdzd2J3b2Q5aHc2Vmx6Q0tHbncvQTd1QWdXblVTNzRO?=
 =?utf-8?B?S0JjNHdyRC84cCttczIwMHFwWTJKaGlGSmhrcGxVSUwxQXJ4dE1QQ3J2OU1S?=
 =?utf-8?B?ZU02Z1YxYTdVRkQ0YTdvamt1UVllVkdaa1NTc3ZlVGpsa1NERjk2VHNkOVNZ?=
 =?utf-8?B?SWJQR0p5THZaT0diS1lQQ05hWmtTUi9tRGUwZE0xODJva2RBbUZVc292QVk1?=
 =?utf-8?B?bkRJYXdxSXpPRStVdFpEdVZDRW1NYmZqUlphbDJiZDc2NTl1b3AraXpJSWQv?=
 =?utf-8?B?VjQ0ZjI4b3VLL2orQmlleitrTDZQSkVzdEVTQVY1cldPUk5TTzQvM3YrV2VD?=
 =?utf-8?Q?JeNYs0b7XkEzV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q29yYVgxQURVYVN0c3pFZU9KYlVYK1VhZjBSbDlUYTFmOEhDRk9BdG5MNUNL?=
 =?utf-8?B?Zjd6RDhqb0pKMXNsNy9Iang1WFpCaXF2OWxENFFwc2taeDZtd0JacWxNMWpQ?=
 =?utf-8?B?U21zY2RDNkcwL05BditSR0tHYTJtajdKRHg2cHhvalBWL2ZVeUNjYmhIeDds?=
 =?utf-8?B?eGpRdWJzZ2N4NlkwNGZjQnpFVzFhNEpvWW9WN2FoUDVWNFJjRFArY1RpZ0ky?=
 =?utf-8?B?ZVNqMnpBMHoxRGJxbWhDMVJZSUxFZ0FEcWlPbUU3WDgrK2k3K21pa20zdi9D?=
 =?utf-8?B?MDVCTHZMbXg5YWFIVHMyTmg5WW5rZnVwdHA5b1NpYzM3U0ZINGVGWXBaMERs?=
 =?utf-8?B?VFZYM2VpRjBmYVhUa0V1UmRnK3B2a0RhUmtqdFd4M1dKZ2VPVDdlbWtrQ01C?=
 =?utf-8?B?MDVuMFRqbTRFbHMrZFhLR0VCeUVPSUs4Y1phemVwbmMyc0dkWXhFRzZLR2ZB?=
 =?utf-8?B?a0NIMjh4TDR3MWxoV290T0FqSEVQcUY3MklONnlzRWpWMmhpcytVMzc3bkp2?=
 =?utf-8?B?TEpUYkdaNVRYZjN6WmNQUGJpQnRLYndoQThMbzZjNmJaQzJTWG56b2dCL1kv?=
 =?utf-8?B?MGZJNW9LK09yOHhlY3NYdm52eUxuSXNkVDU5UUpPOHVyM3BnMDhVTW9RcTd0?=
 =?utf-8?B?RE9rOEZkOTlWbnBaSmliQ2h1YTRSclZTRlpXcEZvZGVjQmZ4K2NQNStWdDF3?=
 =?utf-8?B?b2MvL3ZYTklUTEdCVUYraUVJNGNNbmpvM1ljQjE2RUp3SDFUcU1nSGVCVFUz?=
 =?utf-8?B?MnhmNlZhcElTWU9pMjYrbGN3OFYxMkJqWUswNG5CMnVpc3ZySXY0T1dNK0dR?=
 =?utf-8?B?NWRUYmJsSUZTWmV1d2Q3eERnVUd0V3g2aXJUTm9KMXhGRXdYQmN2b1hMRlI1?=
 =?utf-8?B?eVlTSHhyV2RQZ2l6V0wrOURDNFRJbUc2V0FDc0RnSXk4TjZRUWNUZXozdm56?=
 =?utf-8?B?ZVNBN3dHYzMxWXJUdmsyYVFCeFF6ekRaQ3J0cmlEdnQvQnZRQnJOVFA0U285?=
 =?utf-8?B?eUR4U1RLcjBqUXpMaXN1SmlUK1IvZlpSR2FaYkhWaHkycW82Nk5Bb0FkcCtV?=
 =?utf-8?B?RmI5ejFHUnFLQThkejZzVXd4dXI5TThEd0JFSDBOeEpHQlIwRlFUV09WcmZF?=
 =?utf-8?B?WFc0ODlmSGtwaVQ4VEtmUVpkSjBidG9TcVlSWjJtaTI3R1dReWhXdUkyZ1Ev?=
 =?utf-8?B?V3g2ZmsyVE1sTkVJRldRMkxZNk5scHlqakpYTUZzSFJXZU5JSjZLdWkwRCtz?=
 =?utf-8?B?Y1JSWDJYRk5PbncxZkVmaVZTdUxLNG42blZUUUNlNkYxcE12Y2RuemxQQ1VM?=
 =?utf-8?B?VXljWHdzYXBDa0VXdVVoak8xbGhPVzZvTngyajBQV0hiZ2NXNWFCZks2UVor?=
 =?utf-8?B?aDZyWjhZeU9iYXQ0QVB6Q0F6bmlQbi9OZy95azhOYVpTdUYrb0w2Um93aDJL?=
 =?utf-8?B?SDBDQW9HenhIWXJTbTBEc0RJVmJnRE9EQUhabWN6Q0xjWUpRM2FxY0xDWHlu?=
 =?utf-8?B?T2cyeVpXV0JYQXk5b1FzblRKK0htQkc0aExFclpERTloUVRjWXNJSDA4OVpO?=
 =?utf-8?B?aGRzNkV0dTU4UUJBY2R5RHVkLzY5c2tQRjc1NlVRcDdaQ25ZVTY4c3pGb3A0?=
 =?utf-8?B?Y2NGZ21KYmhqRzRWemVGSDc3QytEVlRhd0pBWVQvcjRvSEZWQWtyditEQzFR?=
 =?utf-8?B?K2x4U2ZGeGtqUzJ2c2RHenVkZE9TaU14bm5MaWxPekRVWXNWOGpCZ0NpSk1x?=
 =?utf-8?B?anFhdCtoRm9JeHB3MWFnMFF6SXdsb0MyK2pONXI3ZEhtdVVVb2JYeVFNaEtp?=
 =?utf-8?B?VXVWclc4SnJSRTZJWDI1T3p6NGE3dGRUTDk1bkxueUU2VDhXRE42SFF1MGVn?=
 =?utf-8?B?U0I0U29Oc2FtQjVuSnRoRXlNZ2gyRXhZSGtxL1R2RkZEWm5ockNGQjI4cFIw?=
 =?utf-8?B?MVloU1E5eFhHdlUyUU1QLzBpcWZFM2Zqc21FWndKTlFaVDl6L01YVWhsSzJv?=
 =?utf-8?B?VlFkbDR1VnJFUGtycmVzOUtLWmZqK0dnUkpRdkFZZ00xOUtoSEFFNVRKVlVL?=
 =?utf-8?B?eTlacFBycWdMUzZKOUZ5eXlkeCtRaysrUHA5UzN5SWdGT3Zma3N4a0NrZnlk?=
 =?utf-8?Q?jh4fairhezKbtI1oOF7tRXJD4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65094568-de2b-4376-7742-08dd4e84c502
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 12:23:50.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWSBgPoyBiKemco5GWYp4KNZYE/2X9hOVURkPsfcklHZ9bz9qfyFclO3cDaVlHm2yYwBgsU8yKbyOGFTftD+Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015



On 2/15/2025 5:28 AM, Paul E. McKenney wrote:
> On Fri, Feb 14, 2025 at 01:03:40PM -0500, Joel Fernandes wrote:
>>>> Following up about our gpwrap discussions, I did some tracing of rdp->gpwrap
>>>> with just boot testing.
>>>>
>>>> I actually never see it set because rdp->gp_seq and rnp->gp_seq are usually
>>>> very close.
>>>>
>>>> Example trace:
>>>>
>>>> # rnp->gp_seq starts with -1200 on boot and then right around the wrap:
>>>>
>>>> 178.096329: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap before: 0
>>>> 178.096330: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap after: 0
>>>> 178.100327: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap before: 0
>>>> 178.100328: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap after: 0
>>>>
>>>> The wrap "before" and "after" are the value of gpwrap before and after
>>>> calling rcu_gpnum_ovf().
>>>>
>>>> Closer look at the _ovf() shows it should be only set if rdp->gp_seq and
>>>> rnp->gp_seq are quite a distance apart (say if the CPU was idle for too long
>>>> and many GPs have passed. This can happen both with/without wrap. So imminent
>>>> wrapping seems not necessary for ->gpwrap to be even set AFAICS.
>>>>
>>>> I think the problem is ULONG_CMP_LT is not really "<" so even after wrap, it
>>>> can false. i.e if rdp->gpseq + ULONG/4 wraps, it could still return false.
>>>
>>> Exactly, and all of that is in fact the intended behavior.
>>
>> Ah I think I get it now, so the wrap isn't really about the counter wrapping
>> causing an issue, but about the design of the ULONG_CMP APIs which are designed
>> for comparisons that wrap around. Due to this design, there is a side effect
>> that the numbers being compared have to be at a distance that is less than half
>> the number wheel. Otherwise the comparisons of numbers yields incorrect results.
>> Is that accurate to say?  IOW, ->gpwrap == true means, don't compare the numbers
>> anymore till we sort these huge deltas out.
> 
> But "incorrect" is such a harsh and judgmental word.  ;-)
> 
> Somewhat more seriously, ULONG_CMP_{GE,LT}() are defined to return the
> sign (or its complement) of differences between a pair of 32-bit or 64-bit
> numbers, as sizeof(unsigned long) dictates.  This is, mathematically,
> how you do signed differences.  The result coming out negative isn't
> incorrect, but instead the expected result given the numbers in question.
> 
> Current RCU use cases might interpret a negative result as "no one did
> it for us yet", as in rcu_barrier(), "this CPU has not completed the
> current grace period", as in __note_gp_changes(), and so on.
> 
> Now, these can get a false-positive/-negative result.  In the case of
> rcu_barrier(), we get a needless rcu_barrier() computation.  In the case
> of __note_gp_changes(), the false negative is OK, but a false positive
> from wrapping all the way around, could be fatal for a CPU that was idle
> for a long time (hence ->gpwrap).  And so on.

Understood and agreed! I guess what I was getting at was that ->gpwrap can be
true and false-negatives start getting reported well before a full wrap /
false-positive situation arises, I believe. And a false-negative may not be
desirable in all scenarios. In my other patch, I posted a scenario where I was
concerned about missed wakeups on a false-negative situation.

In srcutree.c
		swait_event_interruptible_exclusive(
			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq) & 0x1],
			rcu_seq_done(&rnp->gp_seq, wait_gp_seq) ||
			!READ_ONCE(my_rdp->nocb_gp_sleep));

But I shamelessly admit I don't understand this code well enough to say if this
is an issue :/.

I agree depending on usecase, false-negative is a non-issue. But I am not sure
if false-negatives in all usecases is non-fatal.

> 
>>>> >From a testing POV, the example shows it is not set even when around when a
>>>> wrap actually happened.  So may be, we are not testing gpwrap much, or at
>>>> all, with rcutorture?
>>>
>>> True enough, and that would be well worth fixing.
>>>
>>> One simple (and maybe too simple) fix is to add a Kconfig option to
>>> kernel/rcu/Kconfig.debug that makes rcu_gpnum_ovf() use something like
>>> (32 << RCU_SEQ_CTR_SHIFT).  This, or some similar value, should cause
>>> rcutorture's stuttering and/or shuffling to trigger setting of ->gpwrap
>>> within a few minutes.

Since minutes was too long for me :-D, I am trying just a count of 4, and I do
see 15 total wraps in just 2 minutes, on 36 CPU system.

I am trying this same patch now for 10 minute run on all scenarios:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/next&id=984c47eeb7728829901b33462baae2771af80ea0
Will try longer runs after.

Are you interested in an rcutorture patch where we force this? Would this be a
default setting where we always run it, or do we want to set it only under
torture command line options? Do we default to say a high value like 32, but
still provide an option to lower it to say 4, like I am doing?

>>>
>>> And I would not be surprised if doing this located bugs.
>>
>> Ok cool! So I will work on this next then. I am curious to see how often it
>> triggers both with/without such a change.
> 
> If you can make it trigger without this change, you are far more patient
> than I am.  ;-)
> 
>>>> But before that, I am feeling it is not behaving correctly. I'd expect it to
>>>> be set even if rnp and rdp values are close but we are actually about to
>>>> wrap.  So most likely I am missing something.
>>>
>>> If I understand correctly, you would like ->gpwrap to be set
>>> unconditionally at various points in the cycle, for example, at zero,
>>> ULONG_MAX/4, ULONG_MAX/2, and 3*ULONG_MAX/4.  But this could easily
>>> have the effect of discarding each CPU's quiescent states that showed
>>> up before the first call to rcu_watching_snap_recheck(), even if that
>>> CPU was active.  Our users might not consider this to be a friendly act.

Got it, thanks.

>>
>> Got it.
>>
>>> In contrast, the current setup only discards quiescent states for CPUs
>>> that just came back from idle prior to call to rcu_watching_snap_save().
>>
>> Do you mean the check of ->gpwrap in rcu_report_qs_rdp() which returns early?
> 
> Well, it also resets the CPU to collect quiescent states for the current
> grace period, but yes, it does return early.

Got it, makes sense!

thanks,

 - Joel


Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646C28003B
	for <rcu@vger.kernel.org>; Tue,  6 May 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540609; cv=fail; b=FwuNlaiMYoEpIuciSbQygP37+bm8f0dZxHdKj/phHs3Lzu2Y8ACLpj39GPuteniXIu6yOQIqqz9GmuB8CneXx2CWG4qt4cu85wp1gD3MHq4nlO6Ci1npjbPixm52p8sX0eG9v4ez76+q6gMSLmVsrbAglzXqSpHRqe3oRxI2EyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540609; c=relaxed/simple;
	bh=YZ62pj/fumvCWlI4GFViUSfQnSPYU1avfdmo5giTYlE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BVJL+QYJOjHpTQHOr+LSY7Kb4HJXVZt62Msj0l+5ssknQ/2L7Zsv/kzkg01yU5gFbFCwW80M6SFqLkUGOBx7+2jGUT5JIJKeXsdDfGpzgf/O87DWL+q1VAopRy4m/v7aOrAxBbudMbFI8UHr+fNNthfdYxMuKXhTtc8Rv8ekV2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iUi4U6lB; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iUi4U6lB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yyeq1xbwVmMpucK9GTeH4h9MMW1UwabebDaiJU+YzsmX4F0hS6on2f6xdAGp4L4iptIDLvDn+0tb9bcWcOdrJaN/ye2Iich6pvgRRaZJoABqYi713oOL/5kjcoN7Ask3lLKKq365wqTyG/Hza1+q8fcKigg/DxIRQ4F2FHRCMetMsdDYK6sFj8DY5QVDgUwQSaX9b3/jgwoB1Mh0QYaocp5K9rPd9EBKMS3FOg56IR/toAnA5FqI2Ge54PfeVwFFKiYmzvukUxhU6aYZXSb61UE0v3jBRzM3QNRnJRy+KHNddumrzwAmz60S2yhwrEUJg8ecxQuVmCkiyLYccVy8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PT20X1Y5P+sEr2M74pg5BysE853jLSBHIiJggU7ypo4=;
 b=ZFPERJlHCMM3yFrldXxbmXLf6Ct3eHzz4EosqMPhPg2WaEdFldVWfpd6L2uTY/0LcZuEgUqvpOkac3Tw/XUVWiO/l7tDQIWUvjAGrLhUEV7yiVYrZCQFYuHI5E5ptk3QGXzxT7mgJYbkvGtB4Jz5Z2YTi+n84/4+nM3LxPlhZRne2dLy3ioRprSMESbEB2OrZQxVeSz0vwBsRgIEVpXA04anGfNLICapld1RDrIbEvIHPUBR3G918J7F68P8x42D5/umgnmDAWwgmwEujXfV4U+iil7uBkiz9oE5KYrkd1SubBala4zh0Kj9Hu8dDdMHan33BIQPZJ1ZWiBRloQWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT20X1Y5P+sEr2M74pg5BysE853jLSBHIiJggU7ypo4=;
 b=iUi4U6lBRn1GSV+13TE6nrCLI2FNzo5AiKCPJ0XCWyysBbcMGGSz02P2MgTr2eb41H394C/UXEmzr2YN5Me9LUJxIU2mGuMTfjJTdYae9z85dBwUJu8jqBlCQORmkCIMM0wSo0dkp/f+y/rnZe0LRKNUYXUWbn6vxfAcpj79/S+F9Y2GNb3tWz0WwFDp9jnjRtzPNEAxCaECUAco/hJjDJ0E7ODEHvq54PKo3nt1UF2ZINBg53sHqvHA0biD4qViLykwdusVbTxsbqcdff/7lrwGQSn3qy/IfKgmZQKFdVmtBaCnccn/gtHoOVNiVu5uK0EhG3qSinR4pK29DY6tig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 14:09:57 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.021; Tue, 6 May 2025
 14:09:57 +0000
Message-ID: <ecb7a3d7-9ddb-49b2-8072-97b933e3e181@nvidia.com>
Date: Tue, 6 May 2025 10:09:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] RCU CPU stall warnings on TREE01 on arm64
To: paulmck@kernel.org, rcu@vger.kernel.org
References: <0250d0c7-381d-46df-bddb-729130559ba1@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <0250d0c7-381d-46df-bddb-729130559ba1@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22)
 To SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: c22615ae-2d18-46e9-a234-08dd8ca7ae2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akdZV1lvb3hJNG5YenRTMWJGNUI2ckhWdlcwZC9rTjE1a0w0WXRwV1prMG92?=
 =?utf-8?B?VEZ5ZklLUU1rMGZXY2JENVh0dlFZM3ZJejh1UlJWdGJCT0MydmRXMFJaR0hn?=
 =?utf-8?B?OHJQWXorZkJkNXNMV2E5YjZmK1EzMjZMMVZLazQ2RFQ5MW82YWwxNlNtSnEx?=
 =?utf-8?B?d0R1NTRaSktOT08xMldjN25Ya21iSk1MVjI4RlJMaE8rcENiaC8rT3R0ZGFX?=
 =?utf-8?B?dzBKdFVFdzFNMm02dEErMVJGWjd4L1dGYldSYWg5ZWhja2NTZ0sxYnZ3SGdB?=
 =?utf-8?B?VXQyb2VwaVFBejB0R2pmNGZ3RUVpWUNYWVNzMjRNMEdvOWxhelM4V0FKMHVr?=
 =?utf-8?B?ZjBCSktKTmVXMk1WK3AwVTZ2eUltN29PdHNybGc2NjlWZWxTcDkwOCt0RTBz?=
 =?utf-8?B?aDlLRUxBWVVGK3ZESDVHUitDd3JwL1dPaUlIQ1VralR3T1BaaUNubXFtUGVu?=
 =?utf-8?B?d2tPeXNCdWZkL0FWcnZtdG9nRTRTU3NWL0xpQ1lsclBVNndGVmtqTGljaXJW?=
 =?utf-8?B?dmxyUmVSWmF3OUZsK2RhcGx2YXgvMTNEWjBKYlRVMkxIT05wblFjUUU4WEJx?=
 =?utf-8?B?aHpiUzVsNW9OeE03SXRuUGx3Z0kvMk8raHZpS0VXaXFGa1l3UEtzc3d3NVlF?=
 =?utf-8?B?WTdQT3Z6YXUxTUNsWlR3Ty9MZks1ZUM1Z2RJcHE2RGJ4eGs0ZTlMWEh0ZFVT?=
 =?utf-8?B?TnBXZi9nOXh5cFFuU3NvUjVyYTh0bG9IMTB0RVRncTJ4RzFkNGdEbkpYV1Bx?=
 =?utf-8?B?UmlGdGRxYlEzY2FjT3RQQ2VoRmd6aW13eE9IQXl6TG1iYTRTeWQvWUkwSFBy?=
 =?utf-8?B?ZCtIeHRkSDlia1l5YzBsazc1aFBlZjNmb2pNemh2VmIzZVlIakJyeU1Vbk1U?=
 =?utf-8?B?SEw5b1ByZlM2czFQSnFZMllMQnlVNFU5OXQrZXpldWptN2lxdTBHSHJ5aTFk?=
 =?utf-8?B?SUU0M3VaK21oOFRyTklkNFF4S0FCZktsemkzeDRUa21GYURzbEQ0a3QydXBv?=
 =?utf-8?B?WnZPRDJUYm1YS045YzMrMGE3TWNRdFZpVEJiQ01qdFl4R29HSmtPYkVHSEZi?=
 =?utf-8?B?SCthaFpSQUtKSTJ5UFlSL1lnTzU5eGdMUXRXNmJETCtwVDlhcTdVeHBML3li?=
 =?utf-8?B?K2c2UWVLOGdKZFhiMlBkdGpNTDM1Vy9ZdlpLN0kzbUIwWHhRZXAwY0tBTTdQ?=
 =?utf-8?B?clU1UHp6cURnWXc4TmFSeFUvdGJxTXV5UTRqcFpoTThQcXNtdXdZTm5HTlVZ?=
 =?utf-8?B?TUdVTlRIZE56WVZLOHMvTFAwT1FFRU5iWS9PQUlwUnVQTUhjaVN2Yk1IbWZj?=
 =?utf-8?B?R0FSMm5YVElxb2hWcVFhTkVvVTIzL1prMjBlWlZXL2RoaExqNlY1OTJtOGNa?=
 =?utf-8?B?QVZHUUswMEpKMXRYOTFvM1pwYlZzaVVhR2RldjN2ZVhCazNCN3ZJUG4rVFUw?=
 =?utf-8?B?OHF1WVNEdjVVZEdpc2lvY0pZeEdyRlk2di9CLzA3YVpKQlZQMDJzcTgrOWpT?=
 =?utf-8?B?Z1BCZVZJSGp2THBXUHEwNHBzY3VicVAxS2xvS1ZRLy9DRDU1MXBoQkZLVWIz?=
 =?utf-8?B?cHRObG1jYVU4aVFoQXBQaWxBbTl6VWRvdW5LcUR3bkdUSUUwMkNtaGhZM284?=
 =?utf-8?B?aGVIQ1NMOHNjOGM3QzVqV2xrOFhnR0REK3ZxSVJHNVRvSWU1OERKKzRWUW50?=
 =?utf-8?B?SXlOQWpiWFN3WEpFQ2VBUnZjdTY4cFo3Wkk2ZkIvUFVQWXdBV1NaU2lPd05Y?=
 =?utf-8?B?ZnQrbkh6ZVhydU8wV0xDOFVhUWJiTWNMM2pMQlhGR1liQStGVnVnWHVKbTJw?=
 =?utf-8?B?UHRadXl5b1dWTXdGRXdqaFFZaWU3QzRRSi9wUFp2L0V0eXBhdHFWWFBybFhL?=
 =?utf-8?B?SWh1SjA5bnJMQkpZc2dPbzNqc3ZTS2tjc3dFVkJ2L0VwdzErK3dobmRmSFBp?=
 =?utf-8?Q?N7JeqtwNyNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlppVURIai9XMzlGWTlNdnpsV2NWdmNWQ0pyV3pnLzZqQTNrMmJEQ25ROE9q?=
 =?utf-8?B?VHdjSjgrNytHNUxSZkdpWDFaaVdoNjNISlBHZXgyNmFYRk8yYkhFeVV6YlVl?=
 =?utf-8?B?azdpVmxVTnY5OXhlRmpRWDVGRXdILytQOFRsVXVEb0NxeGZPUjJSSnhjQzZ6?=
 =?utf-8?B?YVk2bHZvTjBOa0JnaG5DZWNEUHRuOVdIbTY4Qm5OWkZoSUhRS25zcXBOMzR0?=
 =?utf-8?B?NWdEY2IvWkZoUDQwUWdmTit3YzVQOVB1WHo4cExhdkUwZ3ZTeE9lNDZaK05X?=
 =?utf-8?B?MlBqK1hReHlEZ0JuNktUT0FhTkJRQkFOeDQ0Sk80bEFXZm5HL2JNazVFMzd5?=
 =?utf-8?B?SHJqQ0ZGYWM4dHhvNmx3ZTZMYTU3WXhSWFVJVEZhRm5KaTFWMEM5eDVyTjhx?=
 =?utf-8?B?cy9ON09HdXV4MVRyYTl4TERXUllaTkowWTQwU2dPcmJBaXpvRmt0YStOS0JD?=
 =?utf-8?B?Um1IZkViNnR5OEtvdklwQTNUSnVZZjYvclBKYzZWd1FiRjRNV3VBZXhwUG5F?=
 =?utf-8?B?Rm42ZWtCdC85UVJwcmNqN1BodUM4dnNzYUxrZEFkTHVodDE4N0Vseit4N01H?=
 =?utf-8?B?S3dESFl6aGpqUzZ2Uk4reUdQa3JXanNPZ2d3TEthK3RWMTVUdENuV1g0N1Rr?=
 =?utf-8?B?ZjNIUU9vM3pHdnc4MXZzTkM5aDRaOFJ5cFUvcElEYlY5YkpBYVNIWGZETGpy?=
 =?utf-8?B?SDloaGh2c084R2c5OTkzeFNITlZCeldabTVFSm1YVDFEQ3IxVThkYnB1Z3Z2?=
 =?utf-8?B?Z0dsQU1MRzFJWG5lVFpFa1hKUlZnbGtXK1VsMUszV0pPVW43c1BBdnFHQkFa?=
 =?utf-8?B?Y09UZ3hYMVgzbXI0UlVmSU4xNFNsS3JHNG9jaVNvQU5YUGxoVjZIa3ZXc0FS?=
 =?utf-8?B?aWhGY3V3Sk9CdjFCV2dqSWsvbGRneEVXZWhHTWs0RkdBZjhmQW5vbDA5MkxY?=
 =?utf-8?B?WnhkZDhJaGt3bExlZFR0MUhGemdrVmJCOHI1ZmtlMTFhMUFrRWVOeHZldXFj?=
 =?utf-8?B?NEhPR2YxTXE1UnFpajd0UHE4ZWxzZG1HVEd5SXZJb1ZuekhoWk5LeG0zbjlw?=
 =?utf-8?B?dklhUjBDN05wMW5NTlRpd0tJTjFrWVhnZ2wzYkFLYURJdlp5eVdhSEdDWlI1?=
 =?utf-8?B?WHlwaitLek9yOEtFaWpzRjdUWG03N1VJYkJQMmJmTGpXamRtSjNOU3E1dExl?=
 =?utf-8?B?Sy85YnFTQmhUSGNUUHFNS1IwTlVoZEdRZXpYb1MzNS9QSEx0YUVlN2V0c291?=
 =?utf-8?B?YTE0YUR5L3hjRU5GODNrS3UrNWNaVGs0VkpxUlFwR3ZseWpIZzVZNU5wNVd5?=
 =?utf-8?B?K2h1T3FiRE1pb0ZLZlZMMCtmSEtyMFlSNkNsRFBRQmVTRHpqOGdFbnFBMUZ6?=
 =?utf-8?B?bWp6ZDV3TTUzZ09icE5lcnZaNDVTd21NaFNJeVlCSlJmb1FvVXhvaWcwREpv?=
 =?utf-8?B?ZmFGRnd1SHR3NUVJYWFMYVN5dWxYd2s3SmQ0cHRvTlRHTUxoN3RWN29Vb2FR?=
 =?utf-8?B?U2pUcUFHT0xIOE9EODk3VUlwTUEvVGV2L3NhNlpzd2R0OGRGR29PRW1uMCtJ?=
 =?utf-8?B?OWpPTVVoRGlUYVdxd0xtTFlKNmkvRVFiOW4yY0NXYVU4TW5JVzg5aW42TDAv?=
 =?utf-8?B?YlFYT1A0UHVZOVhFZHdZVC9TdTFsSlI0a2pLTE0xaDRZQUdJMGxHSC9lUXl5?=
 =?utf-8?B?dEI2ZlhueWRsUU5uclNrcFNML2lneGZxOEVTQUN6M1FhYkZJL01TYUJBblIv?=
 =?utf-8?B?Y1ZyVjVRcE5DSytaSTJKSHRsU3J2dTBBZHZ6V09ySGlWMVhlVkNoUmJubVI2?=
 =?utf-8?B?SUNURklWRHFnenZ3VjRmczY1S29LMGo4Sk50U1VOMmFEOU1sdTJUYThIaEg5?=
 =?utf-8?B?N3JHRGx4MEh3SmUwZ0QyazlEM2NOMHVBbFVsOGV1RjhrNks4eFFkb3o5MUFY?=
 =?utf-8?B?OXJFay8zVE1Cek5PUkR5VDZMMkx3Nm80T0RleUdCbWd2QjFkcVBlV2xDSCty?=
 =?utf-8?B?Zit5ZHl0dmR0aFR0RVloeWtNY0syTXVsT3NVc3Z3QjhSajIxdW11R2ZHM0k1?=
 =?utf-8?B?UlBJazBjekk4SEptWFlOQmZFZ2NkeTJlRWM2TklFZTZVL3hpVUdxbVRpZEw4?=
 =?utf-8?B?d2NweFpHdlR6L3pFN1p5SkdEbmVBQjYzSWZUT3BlTkRQRGxBdDdjVm1NNjM1?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22615ae-2d18-46e9-a234-08dd8ca7ae2b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:09:57.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUtRN8qrutzP585rMK6In0LCzl1YRH6hHlerYePptN+G52Cczh1dgRLOh2iTnKYQPRUM0b2JQn1eUrVIl0cX1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915



On 5/5/2025 3:03 PM, Paul E. McKenney wrote:
> Hello!
> 
> Following up on off-list discussions and requests for more information.
> 
> These reproduce reasonably easily, and here is an example:
> 
> ------------------------------------------------------------------------
> [  426.022056] rcu: NOCB: Cannot CB-offload online CPU 25
> [  460.867350] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  460.867980] rcu:     0-...!: (1 GPs behind) idle=8fe4/1/0x4000000000000000 softirq=2124/2125 fqs=0
> [  460.868726] rcu:     1-...!: (1 GPs behind) idle=e0ac/1/0x4000000000000000 softirq=3547/3547 fqs=0
> [  460.869468] rcu:     5-...!: (1 GPs behind) idle=5c34/1/0x4000000000000000 softirq=2084/2084 fqs=0
> [  460.870233] rcu:     8-...!: (1 GPs behind) idle=9fdc/1/0x4000000000000000 softirq=4301/4301 fqs=0
> [  460.871007] rcu:     9-...!: (0 ticks this GP) idle=4a2c/1/0x4000000000000000 softirq=3873/3873 fqs=0
> [  460.871772] rcu:     10-...!: (1 GPs behind) idle=4994/1/0x4000000000000000 softirq=4760/4760 fqs=0
> [  460.872511] rcu:     12-...!: (1 GPs behind) idle=0bbc/1/0x4000000000000000 softirq=3545/3545 fqs=0
> [  460.873300] rcu:     13-...!: (1 GPs behind) idle=a59c/1/0x4000000000000000 softirq=2097/2098 fqs=0
> [  460.874084] rcu:     14-...!: (1 GPs behind) idle=22cc/1/0x4000000000000000 softirq=4424/4424 fqs=0
> [  460.874864] rcu:     15-...!: (1 GPs behind) idle=0e5c/1/0x4000000000000000 softirq=5984/5984 fqs=0
> [  460.875625] rcu:     16-...!: (1 GPs behind) idle=d5bc/1/0x4000000000000000 softirq=6313/6313 fqs=0
> [  460.876374] rcu:     17-...!: (1 GPs behind) idle=848c/1/0x4000000000000000 softirq=4160/4160 fqs=0
> [  460.877182] rcu:     18-...!: (1 GPs behind) idle=a1c4/1/0x4000000000000000 softirq=3217/3217 fqs=0
> [  460.877930] rcu:     19-...!: (0 ticks this GP) idle=cbe4/1/0x4000000000000000 softirq=7886/7886 fqs=0
> [  460.878772] rcu:     20-...!: (1 GPs behind) idle=3acc/1/0x4000000000000000 softirq=4315/4317 fqs=0
> [  460.879514] rcu:     21-...!: (1 GPs behind) idle=eb7c/1/0x4000000000000000 softirq=4221/4221 fqs=0
> [  460.880225] rcu:     22-...!: (1 GPs behind) idle=477c/1/0x4000000000000000 softirq=5049/5049 fqs=0
> [  460.880990] rcu:     23-...!: (1 GPs behind) idle=8404/1/0x4000000000000000 softirq=5635/5636 fqs=0
> [  460.881739] rcu:     24-...!: (0 ticks this GP) idle=11e4/1/0x4000000000000000 softirq=2031/2031 fqs=0
> [  460.882497] rcu:     25-...!: (0 ticks this GP) idle=3434/1/0x4000000000000000 softirq=3495/3495 fqs=0
> [  460.883296] rcu:     26-...!: (1 GPs behind) idle=f864/1/0x4000000000000000 softirq=3645/3645 fqs=0
> [  460.884054] rcu:     27-...!: (0 ticks this GP) idle=3e74/1/0x4000000000000000 softirq=4168/4168 fqs=0
> [  460.884805] rcu:     28-...!: (1 GPs behind) idle=71a4/1/0x4000000000000000 softirq=3596/3596 fqs=0
> [  460.885570] rcu:     29-...!: (1 GPs behind) idle=9aa4/1/0x4000000000000000 softirq=3111/3112 fqs=0
> [  460.886276] rcu:     30-...!: (1 GPs behind) idle=10dc/1/0x4000000000000000 softirq=3030/3030 fqs=0
> [  460.887030] rcu:     31-...!: (0 ticks this GP) idle=0fb4/1/0x4000000000000000 softirq=3540/3540 fqs=0
> [  460.887777] rcu:     32-...!: (1 GPs behind) idle=fad4/1/0x4000000000000000 softirq=2645/2645 fqs=0
> [  460.888548] rcu:     33-...!: (0 ticks this GP) idle=37ac/1/0x4000000000000000 softirq=2201/2201 fqs=0
> [  460.889336] rcu:     34-...!: (1 GPs behind) idle=85ac/1/0x4000000000000000 softirq=2336/2336 fqs=0
> [  460.890081] rcu:     35-...!: (1 GPs behind) idle=756c/1/0x4000000000000000 softirq=1534/1536 fqs=0
> [  460.890820] rcu:     36-...!: (0 ticks this GP) idle=b2ec/1/0x4000000000000000 softirq=4286/4286 fqs=0
> [  460.891572] rcu:     37-...!: (1 GPs behind) idle=de1c/1/0x4000000000000000 softirq=2725/2725 fqs=0
> [  460.892323] rcu:     38-...!: (1 GPs behind) idle=c62c/1/0x4000000000000000 softirq=2341/2342 fqs=0
> [  460.893096] rcu:     39-...!: (1 GPs behind) idle=be2c/1/0x4000000000000000 softirq=2650/2651 fqs=0
> [  460.893830] rcu:     40-...!: (1 GPs behind) idle=7ecc/1/0x4000000000000000 softirq=2119/2121 fqs=0
> [  460.894621] rcu:     41-...!: (0 ticks this GP) idle=19dc/1/0x4000000000000000 softirq=3539/3539 fqs=0
> [  460.895384] rcu:     42-...!: (0 ticks this GP) idle=a74c/1/0x4000000000000000 softirq=2259/2259 fqs=0
> [  460.896148] rcu:     Tasks blocked on level-1 rcu_node (CPUs 30-42): P91/1:b..l
> [  460.896778] rcu:     (detected by 11, t=7962 jiffies, g=15565, q=48 ncpus=39)
> [  460.897395] Sending NMI from CPU 11 to CPUs 0:
> [  461.047304] rcu-torture: rtc: 00000000fb6bc815 ver: 2137 tfle: 0 rta: 2137 rtaf: 0 rtf: 2128 rtmbe: 0 rtmbkf: 0/2042 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 148999 onoff: 32/32:36/37 7,348:36,3639 4096:26899 (HZ=250) barrier: 979/980:0 read-exits: 416 nocb-toggles: 1013:969 gpwraps: 0
> [  461.047343] rcu-torture: Reader Pipe:  1919541609 11501 0 0 0 0 0 0 0 0 0
> [  461.047383] rcu-torture: Reader Batch:  1919533823 19422 0 0 0 0 0 0 0 0 0
> [  461.047401] rcu-torture: Free-Block Circulation:  2136 2136 2135 2134 2133 2132 2131 2130 2129 2128 0
> [  462.777371] NMI backtrace for cpu 0
> [  462.777547] CPU: 0 UID: 0 PID: 20 Comm: migration/0 Not tainted 6.15.0-rc1-00066-g612f2bb48fa2 #22 PREEMPT
> [  462.777551] Hardware name: linux,dummy-virt (DT)
> [  462.777552] Stopper: multi_cpu_stop+0x0/0x15c <- __stop_cpus.constprop.0+0x78/0xc4
> [  462.777564] pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [  462.777566] pc : handle_softirqs+0xa0/0x248
> [  462.777836] lr : handle_softirqs+0x7c/0x248
> [  462.777838] sp : ffff800080003f50
> [  462.777839] x29: ffff800080003f50 x28: ffff000003d9d780 x27: 0000000000000000
> [  462.777842] x26: 0000000000000282 x25: 0000000000000000 x24: ffffafb5af9f4000
> [  462.777843] x23: 0000000063400005 x22: ffffafb5adb9b8f0 x21: ffffafb5af9e93c8
> [  462.778009] x20: ffffafb5b02970c0 x19: ffff000003d9d780 x18: 0000000000000001
> [  462.778012] x17: ffff504a6d7bc000 x16: ffff800080000000 x15: ffff00001d5f4d00
> [  462.778013] x14: 0000000000000156 x13: 0000000000000000 x12: 0000000000000000
> [  462.778015] x11: ffff00001d1b0d80 x10: 00000000002ab980 x9 : 0000000000000000
> [  462.778017] x8 : 000001d6146032ba x7 : ffff00000500b800 x6 : 0000000000000000
> [  462.778019] x5 : 00000000002ab980 x4 : 0000000100009e3e x3 : ffff504a6d7bc000
> [  462.778020] x2 : 0000006bbfae36c0 x1 : ffff504a6d7bc000 x0 : ffffafb5af9f4000
> [  462.778232] Call trace:
> [  462.778233]  handle_softirqs+0xa0/0x248 (P)
> [  462.778296]  __do_softirq+0x14/0x20
> [  462.778299]  ____do_softirq+0x10/0x1c
> [  462.778389]  call_on_irq_stack+0x24/0x4c
> [  462.778391]  do_softirq_own_stack+0x1c/0x2c
> [  462.778393]  __irq_exit_rcu+0xd8/0x110
> [  462.778395]  irq_exit_rcu+0x10/0x1c
> [  462.778456]  el1_interrupt+0x38/0x68
> [  462.778531]  el1h_64_irq_handler+0x18/0x24
> [  462.778533]  el1h_64_irq+0x6c/0x70
> [  462.778534]  multi_cpu_stop+0xf0/0x15c (P)
> [  462.778536]  cpu_stopper_thread+0x8c/0x11c
> [  462.778642]  smpboot_thread_fn+0x220/0x24c
> [  462.778647]  kthread+0x134/0x208
> [  462.778649]  ret_from_fork+0x10/0x20
> [  463.888107] NMI backtrace for cpu 1
> [  463.888117] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.15.0-rc1-00066-g612f2bb48fa2 #22 PREEMPT
> [  463.888120] Hardware name: linux,dummy-virt (DT)
> [  463.888121] pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [  463.888123] pc : handle_softirqs+0xa0/0x248
> [  463.888135] lr : handle_softirqs+0x7c/0x248
> [  463.888140] sp : ffff80008000bf50
> [  463.888140] x29: ffff80008000bf50 x28: ffff000003d9e900 x27: 0000000000000000
> [  463.888143] x26: 0000000000000282 x25: ffff000003d9e900 x24: ffffafb5af9f4000
> [  463.888146] x23: 0000000063400005 x22: ffffafb5adad9114 x21: ffffafb5af9e93c8
> [  463.888148] x20: ffffafb5b02970c0 x19: ffff000003d9e900 x18: 0000000000000000
> [  463.888150] x17: ffff504a6d7d6000 x16: ffff800080008000 x15: ffff00001d1cad00
> [  463.888152] x14: 0000000000000112 x13: 0000000000000000 x12: 0000000000000000
> [  463.888158] x11: 0000000000000a95 x10: 0000000000000163 x9 : 0000000000000000
> [  463.888160] x8 : 0000006bfc655500 x7 : 7fffffffffffffff x6 : 0000006bfc655500
> [  463.888165] x5 : 0000006bfca25e00 x4 : 0000000100009ff5 x3 : ffff504a6d7d6000
> [  463.888168] x2 : 0000006c01e2bea0 x1 : ffff504a6d7d6000 x0 : ffffafb5af9f4000
> [  463.888171] Call trace:
> [  463.888172]  handle_softirqs+0xa0/0x248 (P)
> [  463.888175]  __do_softirq+0x14/0x20
> [  463.888178]  ____do_softirq+0x10/0x1c
> [  463.888183]  call_on_irq_stack+0x24/0x4c
> [  463.888185]  do_softirq_own_stack+0x1c/0x2c
> [  463.888187]  __irq_exit_rcu+0xd8/0x110
> [  463.888192]  irq_exit_rcu+0x10/0x1c
> [  463.888194]  el1_interrupt+0x38/0x68
> [  463.888198]  el1h_64_irq_handler+0x18/0x24
> [  463.888200]  el1h_64_irq+0x6c/0x70
> [  463.888202]  finish_task_switch.isra.0+0x74/0x220 (P)
> [  463.888207]  __schedule+0x2fc/0x998
> [  463.888210]  schedule_idle+0x28/0x48
> [  463.888212]  do_idle+0x170/0x268
> [  463.888215]  cpu_startup_entry+0x34/0x3c
> [  463.888217]  secondary_start_kernel+0x138/0x158
> [  463.888224]  __secondary_switched+0xc0/0xc4
> [  463.941174] NMI backtrace for cpu 8
> [  463.941179] CPU: 8 UID: 0 PID: 19 Comm: rcu_exp_gp_kthr Not tainted 6.15.0-rc1-00066-g612f2bb48fa2 #22 PREEMPT
> [  463.941220] Hardware name: linux,dummy-virt (DT)
> [  463.941222] pstate: 23400005 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [  463.941223] pc : smp_call_function_single+0xe4/0x1b0
> [  463.941292] lr : __sync_rcu_exp_select_node_cpus+0x224/0x3c8
> [  463.941366] sp : ffff800080233cd0
> [  463.941367] x29: ffff800080233d20 x28: 0000000000000002 x27: ffff000003d9c600
> [  463.941370] x26: ffffafb5b032a880 x25: ffff00001d4d7ac0 x24: ffffafb5adb49e24
> [  463.941372] x23: 0000000000001fff x22: ffffafb5af9f5ac0 x21: ffffafb5b029ea08
> [  463.941374] x20: 0000000000000000 x19: ffff800080233ce0 x18: 0000000000000001
> [  463.941376] x17: ffff504a6d88c000 x16: ffff800080040000 x15: 0000000000000000
> [  463.941378] x14: 0000000000000115 x13: 0000000000000115 x12: 0000000000000000
> [  463.941380] x11: ffffafb5af9f0408 x10: 0000000000000001 x9 : ffff000003d9c600
> [  463.941462] x8 : 0000000000000040 x7 : ffffafb5b0322ab0 x6 : ffffafb5adb49e24
> [  463.941464] x5 : 0000000000000000 x4 : ffff00001d281f08 x3 : 0000000000000001
> [  463.941535] x2 : 0000000000000000 x1 : ffff00001d281f00 x0 : 000000000000001f
> [  463.941537] Call trace:
> [  463.941538]  smp_call_function_single+0xe4/0x1b0 (P)
> [  463.941541]  __sync_rcu_exp_select_node_cpus+0x224/0x3c8
> [  463.941619]  sync_rcu_exp_select_cpus+0x138/0x2a4
> [  463.941622]  wait_rcu_exp_gp+0x18/0x30
> [  463.941644]  kthread_worker_fn+0xcc/0x184
> [  463.941708]  kthread+0x134/0x208
> [  463.941709]  ret_from_fork+0x10/0x20

I wish the back trace also included which CPU the smp_call_function_single is
waiting on. This is similar to what Boqun sees as well, where we are spinning on
csd lock for a CPU that is wedged. In this case, the 'wedged' appears to be on
level-1 rcu_node (CPUs 30-42) ? But we don't have those backtraces in the above
to confirm which specific one.

Al though, cpu 8 looks like it could itself be the one blocking the GP as a
secondary effect of the smp_call IPI not coming through?

Speaking of smp_call, may be it does make sense for EXP to not wait too long for
csd lock thus to not make dire matters worse? After all, the GP may well
complete eventually even without the IPI executing? Perhaps even sooner if the
CPU doing the smp_call wait does some other useful work as well.

> At first glance, this looks like a stop_machine() request gone bad.
> Please note that I am seeing this on most TREE01 runs and nowhere else.
> So this might be a strange side effect of dynamic callback offloading,
> but perhaps more likely due to TREE01 using more CPUs than it is allowing
> for, that is, telling qemu "-smp 43", the kernel "maxcpus=8 nr_cpus=43",
> but forcing the guest OS to run on only eight CPUs.  (Why???  Well,
> back in the day, there was an RCU bug exposed by this.)
> 
> All that aside, this is one of the more spectacular RCU CPU stall warnings
> I have ever seen, and that is with me leaving off the NMI stack traces
> for most of the CPUs.  ;-)

IIRC, NMI stack tracing on ARM is unreliable due to raisins.

> 
> If there is interest, I could post a tarball of a few of the full
> console logs.
> 
> Come to think of it, even if there isn't interest, here you go!  ;-)
> 
> https://drive.google.com/file/d/1JKmCYqK6kAwhlJZUJQeTle-o62aJXkUQ/view?usp=sharing

TREE01 in this trace seems to be a different splat I think:

[   71.612482] rcu: Offline CPU 1 blocking current GP.

Causing the stall I think. Something to do with hotplug? I wonder if without
hotplug testing, it will trigger or not with the same CPU count settings. It may
be worth adding the ARM folks as well.

 - Joel




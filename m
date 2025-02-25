Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37D19415E
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521084; cv=fail; b=Qvg57YYDOdzl884Pjq7E7droIJ9X1WEP4ZEfXfbN++v7md8ur6fFCEFzrSe0+CPck3BqHkf/qZ0G6nlsOp2X9H386VOQ9nEtdIp77+Z4+fKmD0IbRaf3VjvTrscpyo9v07n6EDnyni6CZcIrjBf1tuUVaNraPfrZjk+UfINDX9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521084; c=relaxed/simple;
	bh=E1l8lnl5FEk9O0iuoDFdoXtgyLwNdpDF5hMLWikieVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A4oqRnBVjGk0dWT1bh/grFuoYiuBxfDgF8FYDR3Lv6as74QwrSJGxK6YyKApHXSy0Fa0ed4uxXS2RjLl/UvFyvQVX5snFn0d+7gATxitBw6tHuC4nhrCax9ZZ218c/J60bAttJ94aO/GaWbb8eiUmzVJ8WX+d12IcqfvPrBGI7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eqB6G0TD; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eqB6G0TD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1KVsdYHwjZS2jEYuGMBnrDGdECUpc/IaYdqcLWdy7w9Crtv/IRVXmOPO9exlxsgpW2MgLaJnTFDZikfOsSH/2gvZxID8KJpmGqaCCsDawajpK3CXTRXTDOvghi3u33DfyzkOpEDPmXGjIJn33exliKefY9xxPos4jh2djMEgrdUOh7aObjKP9gKkRYh23ivJ5qkTzTN4D/WkKFtfK6KuJH+0LD1CSkKCHqOEWfwKl3ftLVo8btvf6s0F7QKq0Y8Rc8hbMpKBEXkb+wt3Cs+WfeqwseJB/UILadU25fb/MOWf1yvMuJYelk/XQi5tOz/HDSrOJ38cOcs2LIKuY3Rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGVZBcOd9LMwa/amZHWQEjU2+zkyfG+xgAEq2Hxw6jg=;
 b=dHj78+7VNRVt8hJ/P0k+E9ImcIRa7dNFUH8OOllC8zfzGjMsbbjZreN3HXYbkFAPBNARWT2rP89X5BHOhwxcXYoqCK7djfOhHWivXKzOioij5gqOo3yXP/93sM92yZyKlOT4TG/cvl8qJUegt1ZBdojZRygO/LbxFUuS/CIHM9MupNloKlSuIHQYqgdnTdrwHs0ugzQoYTf0N2VE+/rhv79b/Q03G6NDLyc1rQEWeg9RGFfqHNmLMVmDv3p6A6yywbiFDBhUO6wix4zqUhcgif2sDzjZJXP8zsaQ04v/h3DBW7StWZ242MPmb0JUO/NQ2DNAX+7+e6ESWMKScCgiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGVZBcOd9LMwa/amZHWQEjU2+zkyfG+xgAEq2Hxw6jg=;
 b=eqB6G0TDoAXIeGNODC0n1o2iuw4Z6pMsCAXe5IUUtveX6H71nPXWrnZwwQy6QfL0gr/JFYuN2ufeh93Xj6Rq9OCG3do/t31J27IljuBzlxf/hhNGyHtnU/Pu1EP2YBcYz4d/z9rd8CEfPGxts/fjKrIYUGZr3cbPMp90jdSm7y79SZhD2ed27mfhMJa+5H030PL9IgzkheWtMNSBTSwyYnIXHtqNWkmUC1HlXnAP9qiTihqs9TlwQ7v05mofeu2cgBJ3oOuT6fe9qXil3QD2nJImqeSFqGJHx/q+9Bm//BYDdwr7isk58ZXiCx+PyvJXNicahBCRBQDnVZJsHAtLWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 22:04:38 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 22:04:38 +0000
Message-ID: <5c7f08b3-a007-4bd4-b063-eb034373a385@nvidia.com>
Date: Tue, 25 Feb 2025 17:04:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Testing of shared RCU branching
To: paulmck@kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
References: <c5bd6873-6e29-4f44-9c40-fbdffc6d1165@paulmck-laptop>
 <Z73rFVTHr-etZ8SE@Mac.home> <Z73rn9nqlCwns1IY@Mac.home>
 <267f54c6-4604-41fc-8cc9-6adb761fa257@paulmck-laptop>
 <20250225212007.GA1806882@joelnvbox>
 <e4853773-f834-4224-bf17-f7ed895ffef3@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <e4853773-f834-4224-bf17-f7ed895ffef3@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:208:a8::39) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c256cd-0632-49e4-0b19-08dd55e865de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTR6eVlpR083dXJtazhEZmtSSHdac2FTUitLRUx1ZDRNUTVJcGhJcThRcnhI?=
 =?utf-8?B?dkppSHVSSXhDVDVWVWI3V0tJdFhZNDJ0QVZiVWx6K0RJL0djbjNlMmExdG5U?=
 =?utf-8?B?SG1NOWpEVk9qREpNeVRIQ2E2WkhyZlJmWCtrNXY2cjdRcEVGSHZxMXFDa1RF?=
 =?utf-8?B?dmRVWTRtSFQ2aHZpeWU5ZEh4Zk0yUUVoS0piZW5BM2YrcUxFdDRNY1gyMytY?=
 =?utf-8?B?TlpDOXJUSnhGY1FmQ0ViOTdFMlFPZ2lhTmxrYitwa1FCUEtWZlc3Y2ltOFVB?=
 =?utf-8?B?VXFZYVp4ZzJHSExSY2xTWmJ6c1UyUEhkb2lSWjNETDUyUTl6bUFLcEU5dTZW?=
 =?utf-8?B?bENZTm9oRU9HelZBZmRLTkxnVTJsR2tFT01GZk9CTStQK293Q2hKUGtUckNT?=
 =?utf-8?B?czZveFpJSTRNTzI5REpRSGd1UjYxdU5BWGZuQ1hCbHloRFU2aUNMTENrekFX?=
 =?utf-8?B?bHJ2UldycmhDM0tPMUFqOS80U0wzMUhXMytKMW1YeXpvdlNZTklRV2tkL3VZ?=
 =?utf-8?B?WFphUks5amJBRmxUQ094Skh5R0REVjh0R3BnRzkwdjc0UDFrUGVPOFFNS2xB?=
 =?utf-8?B?MXh5SmlLL2JXVEFSczlaS3ZGdE1WeGtIeHlhVGpDOFVaREl3K2I4YlZTTVoz?=
 =?utf-8?B?L3M4VE96SXIxRzBFZkhSZlpuTGV5OUFQRUtpZ1RFT0RzQVBYRFBZRGI4T015?=
 =?utf-8?B?V1JNZU5zeTRzRkVJcFBNTnNzU1Z2TzdRa0NHOVZaR0FPSTNITEhiZ2dGeFZD?=
 =?utf-8?B?c2dMbEFycUY4TnlXbVlUVWM5K25tczVzbXJCV1RLWkRqdXVEWFFOZzZOL1BT?=
 =?utf-8?B?VmxoUGlVdW12WXBWYVVWa1g4eXJPeTJselNMdTh6VnltMDBkOUJudkhvUWtz?=
 =?utf-8?B?KzRNMXcrdkFncjhoQ3pIU09tU05TdXAydFdZWk55SzQyVCt4Z1dsTnhDUXpM?=
 =?utf-8?B?Rlo1RjlFbE9zbXpXNDk2UkhjSFc1S3AxS1pvT082WnhUdk42UGI3d3QyNlBC?=
 =?utf-8?B?WUY4U0hUNFFyRWxTbW4wWHV0NEcxdzEvcEo5MGVRYVpZSVRISVgxU0V1dlNM?=
 =?utf-8?B?ZXNnUTVRbWdwclNDRnZoYXdYTytCYkZlVDA0SFZ4UjZLRmNCZmxteCtYQjl5?=
 =?utf-8?B?MEg4clFqS3p2NTcvYXpMV2RMcUt3OEF5bE1MTUJqRVN4Sjhwbmd4Qm9EcWJH?=
 =?utf-8?B?ZnVFL2dMZnM0dkZMbDRiL3VvS3hQSU9Ub2d0UndNUlptV1lUcFUwQ1BGbEJR?=
 =?utf-8?B?bDJTOE5hQlVnTE5rcHROUm02Nnd2ZSttV2Q2ZVljUVhmU2hlZWtVNWd1OVFW?=
 =?utf-8?B?Q2xrV01yaGFoOVhOd2c1cC9LaVpUMGZVUlN0L1BkRFF4amp0ckx4blZHd1VE?=
 =?utf-8?B?UUZxVnVlT1hwUkdSQWVHem9ycWhyeERtMjFzUUtIUlFUK1N2eVRzWkN2UWF6?=
 =?utf-8?B?V2M4ZHQxRm9mdGsvTjZNcXc4aStyVGJFQjM4TFhsdUlGRTY3RG5oNGdsMnhj?=
 =?utf-8?B?SEhNNkJFRFk0RGpDTnRpL1FneG9ZTG04MkFEWk5KWXZYV0N4WUJIWFpHS0hW?=
 =?utf-8?B?TFBxQzhva3NwUklDSUtvQmlEb3ArMDNqbm9RdFFKUVNBd0w1SjRIbnJkTlcr?=
 =?utf-8?B?TVZ6L3ViNDl6NHg3SE15L3ltbXVIRWE5L21iL1hic1dVcHY2RVVROHA3RzRs?=
 =?utf-8?B?VllkT0J5eHlIc0dzKzh1UTFFRS9qNjNxRHlDOUtTZGN0OWNZcHJWRkc0S2Q5?=
 =?utf-8?B?anVCaVRpdTNBaDA4eHZKZU9QSE5uSjk3dit0RDRISTJ6KzE5YURoeTN4RVcx?=
 =?utf-8?B?ZzVtT1ZLeHc3VHNsbmR2VG9tNTBMLzliUFlCOUVxT1JTb1BLZFdOeks5dFVD?=
 =?utf-8?Q?c47Y6j+9mi92W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU9GTi9nU3RyMVRuYm1lNzRsalRVV2R2QWU2c2lIZnZKRExCQ0NJenMzMG9B?=
 =?utf-8?B?Z3JRNmE1M3dhRGpJY1FHR1VsdEZsQ3MvQ0dzZEJFaW1RZ252dkdneUgyckgr?=
 =?utf-8?B?VXR6MVI1aEVwMHVVZS9KU3gxSW1sd2RUZG1Sc3lYbWxxZ1pEZEViRktTU1RR?=
 =?utf-8?B?S1Q1YnBrLzZUTVFpNTJFRnFMN0UvQ3Nrd1ZvZ3ZkWWwxYVZoaUdJRHA3STZn?=
 =?utf-8?B?VGM1OXozK0V1Z0pqMVBuQ012YTk5aVZzaGx3K0tReTcxbEtaR1hCeFVBOXd1?=
 =?utf-8?B?cm9NVGR6ME5TSzlJd2txSGVaYUFwZ0hISnVIZ05qYUtwK2xhbFlGWVVUMkxM?=
 =?utf-8?B?eFgwUlpwT29YMkNSV2VYcWdNRG9Hd3JKWG82ZFZhdW5yNHNxUXRxbEo2L1lU?=
 =?utf-8?B?T2VST0ltVjJsWVdYWm5UZmxzcDh1Z2toQVViVEZ4R0ZpaGNKeU1PVSswMHhQ?=
 =?utf-8?B?aVpZQUxBb2pMejZ2NTZoZUQvZUFScnJKSVNZakNKWm9SVFdxY1UwTjN4dEww?=
 =?utf-8?B?L1BTZnNzVGF6TDVDUGtIUkg2dERRbjdtZGR5NHRHWTZvZWM4L2hCSDFmQ2xT?=
 =?utf-8?B?WHpZb1hUV0dkZnN4UVRCWk5DeUROQ3FRcHp6SUFNVnhGWERuMXB3VW1EWVlQ?=
 =?utf-8?B?c0xLMitxZ0dma0JFOWNLVGxsYlpUK253SXFkTVFqcE9GQXl4d2h4UFJrWktN?=
 =?utf-8?B?cGMycXVPTFY1QmVyeng2RmVJK3pjbGM5cys5eHR6dVdYRVFrdU56QXc5NDFJ?=
 =?utf-8?B?MXpKYWcwWkU5ZjhTcUhXZmpYM3NRenQvdGlQakVhRzMxOFF2ZVpSUzdZTmZj?=
 =?utf-8?B?eHdGL1RXTmE3TlpjLzVYUWhMellQVFpYTHVmZm9id05iQzU2dE15ajY1R0Vi?=
 =?utf-8?B?TWc3SFFKTEQybFZnQU1DVlRTVWhMd0c3SXU2SG4xZXZVaGFROHB6czM1QWcy?=
 =?utf-8?B?aHVLc1Zvd3pkVGFwdzZNcHNkaUpCM0ptSk8rNndCTk42MkhTSlB2azRCc2Nv?=
 =?utf-8?B?MjR1b2JrQjh4MmRmMGlJTmNRL0RMeWhZVmpNVFZrVTREQ2EwdWIrN3lXWnI5?=
 =?utf-8?B?RjhXY2ZGSHJITFlYWXZLR2hMUHhlU0lOeFVCdTBQcHhOeWlyUmFGWVByUzc0?=
 =?utf-8?B?bUZEa2NnbUpYYlBiRXBOWUJvZ0ZUaUpTazJKaTM4V2RtN20zUTRpdDRnUlFv?=
 =?utf-8?B?dWVNZUpJMG1BaHpOMlQ5S0xEbXQrWDdsdjVIRVlvMTY4ak92Tnhqb0pkdjFB?=
 =?utf-8?B?TFlRSHpKOXlvWjZUZ1dyR1RrSEJ0ZURsM0piSzZMbXNhL0N4MkVTOG5qalg0?=
 =?utf-8?B?QnJNTlIrQ2NGZ25Hdk5hallUSVJ3WlpETkJ2VlUwMlRIelUxbmJua2tYUEdz?=
 =?utf-8?B?TkZRa1V4R1JzL0JuQmZvWFdUUTdYVWQrQW9NUjZISlJQc0gya2RINFZyTlEr?=
 =?utf-8?B?QmVwdld2dTVTVER3cExxNUNGMDVxNkdGdGVHdWRxcDRhWGMyZEltcDhXN0R5?=
 =?utf-8?B?SmJhR1M3V3JDS1BEaFN2ZGRWZzlPdkQvZGUwQUdnT2Q1TWlmaTNnOWZkOTRW?=
 =?utf-8?B?WGhxMEZuWTcxRjN6TDg4Qk1SUWNpbkVuekJBdzlHMkxiUDNCdzZvSkxXZ0lj?=
 =?utf-8?B?akM4RzNpekJySy84bmlkMEVLQjVhTDNwZjJCTGRsUU5MVGh1WWs5dDJGT0RC?=
 =?utf-8?B?aUc4enpmOUxRaUJEeG0xQ3IzZ2djV2lSK2R4anRNRSthcU9Gd0VyNVJXOWp3?=
 =?utf-8?B?ZHZPTUxObTBtaHZLTTlWY3gvd3MyVlkvdDFENDBMTTRtWTEwcTIrRDFHWW82?=
 =?utf-8?B?MkU3enNGaVNKMG9PYkxvWFNwajRSdHhoVjBQQnZPd3QzcUEvM0FncHFxdUp1?=
 =?utf-8?B?cS9vcllaUllaNGoweUY2Mjg0T3VOOWJEY0V0YmFtbm9WcU00ZVVrRUtTN1pk?=
 =?utf-8?B?eERNZEFpM0tXSndEOEtoNjNIVStiQkZIQVE3RTZueEtXQi8rTm9zOU5DYy9s?=
 =?utf-8?B?eExSVVAzcWFCSnpoTnQ4QmtWbzhCVzZQUG9rM3JDYktTb0REdmpCQjVBRzJo?=
 =?utf-8?B?eXZvNHJHQ2pLT1MvRXM0dU96YWxNQTRFbG5CRmtOQmQvS2wxNnVtUkd0cVZv?=
 =?utf-8?B?VXhwY3RqWlY5SkVxTG5RUXpwQ0JxbEpDRFhNdU4waSsrZktvWVQvdEN2czdW?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c256cd-0632-49e4-0b19-08dd55e865de
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 22:04:38.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDX7ofTIWcmQ1IoW/0d4nc39OAHqY3/uA1pi+7qtQEuUcrrlnUH9uZ1hI+5d4QR6x68qPqq4D+pesyjgXSGkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251



On 2/25/2025 4:53 PM, Paul E. McKenney wrote:
> On Tue, Feb 25, 2025 at 04:20:07PM -0500, Joel Fernandes wrote:
>> On Tue, Feb 25, 2025 at 09:54:29AM -0800, Paul E. McKenney wrote:
>>> On Tue, Feb 25, 2025 at 08:11:11AM -0800, Boqun Feng wrote:
>> [...]
>>>>>> These passed other than a KCSAN complaint involving
>>>>>> rcu_preempt_deferred_qs_handler() and rcu_read_unlock_special().
>>>>>> This looks like the plain C-language writes to ->defer_qs_iw_pending.
>>>>>>
>>>>>> My guess is that this is low probability, despite having happened twice,
>>>>>> and that it happens when rcu_read_unlock_special() is interrupted,
>>>>>> resulting in rcu_preempt_deferred_qs_handler() being invoked as an
>>>>>> IRQ-work handler.  Keeping in mind that RCU runs KCSAN so as to locate
>>>>>> data races between task and handler on the same CPU.
>>>>>>
>>>>>> Thoughts?
>>>>>>
>>>>>
>>>>> Do you have a KCSAN of this? Also this is not a regression, right?
>>>>> Meaning you probably have seen this before? Anyway, it should be an easy
>>>>> fix (just using READ_ONCE() and WRITE_ONCE()). I can send the fix out
>>>>> and put it in.
>>>
>>> Here you go!  And you are right, if it is a regression, it is from a
>>> long time ago, though something more recent might have made it more
>>> probable.
>>
>> In my opinion I probably wouldn't even call it a regression because the
>> data-race is happening on a boolean element. If I am not mistaken, this is
>> thus a false-positive and KCSAN has no way of silencing it?
> 
> You can still get in trouble with booleans.  The usual example
> is as follows:
> 
> 	bool x;
> 
> 	...
> 
> 
> 	while (!x)
> 		do_something();
> 
> In many cases, the compiler is free to transform that "while" loop
> into this:
> 
> 	if (!x)
> 		for (;;)
> 			do_something();
> 
> Putting a READ_ONCE() in the original "while" condition prevents this
> transformation.

True, thanks for clarifying. I will be a bit more annoying and say that in
rcu_read_unlock_special(), there is no such looping transformation possible
though AFAICS. The test is an if() block. But this is beyond KCSAN's ability to
analyze I guess.

Thanks!

 - Joel


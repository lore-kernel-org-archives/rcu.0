Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A72E36F7;
	Mon,  7 Jul 2025 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751860156; cv=fail; b=sDkIlhhIwfCbrrDBg0PoPn+r2fenHdwcTmD2O+5+aYEgTBs444FUntlFHs7SLKEuQ59TpbDt43+WdrmaHSwYJZ/BlKCsEfF/XFEBehRmIOdycVEO50RMus+qL1QZ0IynvrZ0yLghYqiXydluhwGgtSJ7IJ7MJiPIChmarPlxZ8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751860156; c=relaxed/simple;
	bh=a0mszH3x6wklj4/U6o73J893YJiG+8TXtf2sYAoalmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BXlbyWtuP4Buj+yx6f+RWJceZtyopC8TslPHAzJhUTdIsVCfUHM2v0pOFz016vTPHVzBhByEesHe+PzSgb2NWXbzmbGQ2G/4sS9K7vUOCGyKf5OuNvwF8WPn3xWVPOlZV6QXcj5mjmakC0Lro9SIOgRLimBhD7mBZ2sCTFx/GrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q4R0ZbNv; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q4R0ZbNv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsQi2LvSq8ZBHCYAOuU54xxNn76TL0KidxhFczYxzBOLH4OO/oqG8FCaU0Sx/7AGk5Hn4I/e5dIGivEE9t4rEpHi5Iy5AeLNvdgJypSpAjwSCNFD+JriEzJMaibjnXvFO+jNR6Y6zDfRRz45mD10t+R/Bx1TV+fpgkQ9Q1xbi45hcH1x0g620IV3Y1xIElo7eS226L+I/LnSXtrkHMD3lDd4a0IYhu+17PLKLPBaKrOoh4xprZVj6E8CW/rMOBcEurftCQNcanKDzEFPlpG1Ywe5yYkpq4sjeNGO24CgYj0Tu5dyV2riYGS+Sl3A+ZUSOrwGU/B6wpBipwD1A9HZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz/fHuPFuTz3tLgamPI4HRrQTdP8d6kRVBVulEMFuPw=;
 b=k4on1LjAeL5UB4R9I7xi+cni4+8COjsT6DWcxv8pW0vRUWDwpv044Z8ItNF9JJfbYnKtYOvjXM4ESt4n3Y9C/I1dXPZ0hqUbwyAMD7HmqHuB1c5cbFGmAD40m88yEepRW68DWuOWcS9abl8Rnb42/aQB+Ec6GmuC5ctZFZRr/eSGl+gU2BoDrsHMMoyhvcimrCaef+5v/2XNYMGd67ZY4U2+e9vS9TnjBd/YwlnNzLHXhGANs3VAWzcQn1xytPzMXcXKcKuz5Ol1DAfdG+o5V64CqGK8cMI7y/2Ihhr3NE+zcJbubYbDNtZIMDcOXaB/0BOS8T7uTA0k1k0q6ZPHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz/fHuPFuTz3tLgamPI4HRrQTdP8d6kRVBVulEMFuPw=;
 b=q4R0ZbNvEr9DDxlGFBGQniRKCgVoI9rnZnEWKFqDHFDBzxdXV5wbegfx4/5uyPGvAiZuGwUH2HYylZCeuDXWI9TJQIAb/NGfYaHyNH6MlxqrqQpL4JkulFynNrhCHw5an6Js2X5aLIK410h4LdlQUV+W+NJwiw75Z27/8JttmUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Mon, 7 Jul 2025 03:49:10 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 03:49:09 +0000
Message-ID: <ccca5cb2-0d41-4fe1-a4a5-4344b4116770@amd.com>
Date: Mon, 7 Jul 2025 09:19:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rcu: Enable rcu_normal_wake_from_gp on small
 systems
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20250702145938.66459-1-urezki@gmail.com> <aGajO8rOu_GOnjrS@pc636>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <aGajO8rOu_GOnjrS@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eee931d-05f8-41f4-113f-08ddbd093a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlVOejZpMGpjSUgxbk14amhWc1VDUG5EQWp2aDNpcGdYNDU5dm5aRU5ISUVT?=
 =?utf-8?B?ZHNoUHhDdnZwQWc3VXJCaVJQOWZiUFRBNWdyLzQ2OG1SREY1ZmVKUzNYTE5X?=
 =?utf-8?B?blVaay82WERCRGMyaGF5NDdiMGx6YVZ0U2tid1J5aUhVU2t0WHhBbVY0b2Na?=
 =?utf-8?B?N0ZaU2FNanplRU1MRjFJR1dSV1ZheW5FUlprQjg0ZzVORnpqRTB1L0dMaDZ0?=
 =?utf-8?B?N0Q1YTdhN2l0bWVsS1oyVVBnYTk5Y0RPU1ZVVW92a2ttTUpSYVNLcUNMNERP?=
 =?utf-8?B?QUJMQ0RWdTZXSGlxYVExLzJFbTJkSmFzSTFDaFhsR3VtaGl2YWFLN0NPa1pz?=
 =?utf-8?B?UjlKNkhpVE5GTE1UdHZCcmloOEtkaEYwVnBYWmM4b01rMzJtVklnSk5yQjFJ?=
 =?utf-8?B?elNINkRJWmVvdmNvcGRneFdzQ2FsZzhZYWpwRkQ1VWVJTVFTcEczeHNPNkpt?=
 =?utf-8?B?L2U5SVhtbjVsa3ltQmhyUFFIR2p6NVN3Q0tVbEIrNWg1T2Ewb2ZpVit1TnZP?=
 =?utf-8?B?SkFKZ2dLUGFnN3lycnBwM3NkNVAza2hFTHRxQjhPWVV2ZkdmU3hYa0tDVzZz?=
 =?utf-8?B?aHRWV25BQ2ZLbXpxbWl2eE1uZUNzYUxZRjBOM0Q5dzRhVXRhajJVSWtnYUxq?=
 =?utf-8?B?S0QvMlBWdmxSM1dKTDNIRkFjSnJGV1VvV3djd2gxMDZuWWhFU0ZEUFFNalRz?=
 =?utf-8?B?djZzNFUzdXBlOElxQVVHVW0rd29hZkxGaFAvdU9JVjNsVGFXTjRyYmkvK2tl?=
 =?utf-8?B?V0Yvb1l6cVBGaTRNQklYSXZWZDVSQkp3SCtLSitETHFTSFFGTjJmbFdmY0Iz?=
 =?utf-8?B?OXpqK3d0a05TNXlBR1VVOVV5UFp3cjVITTM0VE1YYVp1ZGN3ZHN1Qm1OMDZv?=
 =?utf-8?B?dTVpOGFubGlZOFJzb0tuZUNDdHJYV0hvdDV2cm5Cek92NjBaOE9DeDFxYWdn?=
 =?utf-8?B?c1FaNklDeDN6TDJRK3YrejV1TDY1V042RkpnV2R4b1ZNZHgxWForeUtNRmN2?=
 =?utf-8?B?NVFNOUNYaVpPTFNYcnppdTF2aVhnQmdrZnh4eFhSMGJtbmVBRWQ3cnZ2N1lK?=
 =?utf-8?B?ak01bmNPSVZMT09vRWd0VGdtUXZHZHNtaFlsSDVGaW1qdUhvRXkwamx5WERM?=
 =?utf-8?B?alRnaEZrSk5VamRKRXpVaitueW00Z2NXRmpkMnZCSnBQZnhXdEU0cHB0SDJC?=
 =?utf-8?B?UC9Ec1pPZVgvejN5amNZcnBnV0dQQWRPVkFsWmw1R1JibmNPZjQxSURjSElM?=
 =?utf-8?B?SUZwYlRpVkZQQXhMQ081bHZTMWU5OHlnZ2VreWYrMCtaNUJHKy96VFRHWmN5?=
 =?utf-8?B?M29uOFJkaDBUS09QaTlTajJ1eGxiL1hZQWJSNkY5TnlsWUN1aDJydDNqQlZz?=
 =?utf-8?B?VkM2NXNOSUJINi82THp3dTF1cjJoYnB5RWJoeXM1bjhHVXpzN2ZVWDkwVzJW?=
 =?utf-8?B?c2d2bTFxSlJYQXlKV2pKMDF6LzVBaEQ1aGJLNzdhVngzditVNnRUV3FmNFFD?=
 =?utf-8?B?RzJYa2pYNE5IQ1N1b3FWSll4bEZRVmtKdUdHbi9EdCtSOGcrd1dUSVNTd2Jp?=
 =?utf-8?B?VndHZWVJT1RzYWFNMjRVSUZpVlFSajdxNkh0aVBNc294VVFBc3RwV0NVZ00r?=
 =?utf-8?B?R3JqRVk4OUFnV3Uxbkxua3cyTllLaURlU1FTQ3VzeHp3bWZ1R1FJVTRPWUFw?=
 =?utf-8?B?WTNtNzdZS01PckY3QWxBM0tudXU2MUhPSklJWkZBV0p2a0RZMUhyZGx4NlZv?=
 =?utf-8?B?WDg5SVN2bis4VUVBby8rUTFHZENjRUJ1M0J0eXV4Z0xmRm9EcGFJMXlPVUgv?=
 =?utf-8?B?bW9ablg0dk9ZYThaZE9sRGlFMVBBOWZ0WTNlUHRYNlZoQ2dZc3hvWGZvSUxa?=
 =?utf-8?B?TlZlTlhzOWtoWUFwVDY2L29qQjhGRnNWQ1JwNFV3d2U4Z1RramlCeTNwVmow?=
 =?utf-8?Q?y275BTV3SDM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjdNL0N1QjIzeE03bmx2dFZPRCtuODg2dzc3c3Y4WGtXSmhiSDNvcGNyOWhL?=
 =?utf-8?B?bnFSbzZJcmtDTUpCSDhhYzlXTldxdEZ1Q1o0WkRaMWJIVm00K0V1dW5WN1Ry?=
 =?utf-8?B?NXJVM1BnazVXZzdObWhOVFNmODkrWDFBS1lkL0hjVy9rZ1RTK2Y5d21ROWpQ?=
 =?utf-8?B?OWpMVXpNMDBUdFhhU1BrQkJhUWtMN2FGRFlZSXZqczA2b3ZFVTdCMWs3cHRT?=
 =?utf-8?B?enMvVElBL1AzcWNnZEJkcTBpcDhIanVuOFFPOG9Vd2VsUlFHQ2hUK0RoK0x4?=
 =?utf-8?B?UXF4WFlSVlE1L202T2FzZE1SNUt1bXRvNEV2dGlGblhNT2luR0QybkI1cjFu?=
 =?utf-8?B?QjZPTFByNExDMm5zR21oWmJZak94S08xQVd3WlkvRDJmN0F0ZWFGRWw5Z2xX?=
 =?utf-8?B?d3BNTHNCWWJtTFgxb2t2TUppMkxQLzc4Vzgrb1doUmMxYkhRMlo1T3IzS2Zs?=
 =?utf-8?B?aDZOMGgzVjBuT3EzV2NLQ2RDM2l4dUNDaFNlZ3pOSmw3NktCTFBzLzRQM0JQ?=
 =?utf-8?B?T3Z6WUp4S3hHNk13Z1dpNU0yYmtjeXRaOFhoazQ2akVMVEdUWklYVU9TVHda?=
 =?utf-8?B?bFVGR0lSZURsMFNEVW5QNnhXQ1oyaWxKOGFGamJCQzU0ZkZ4TVBGYURDQmhP?=
 =?utf-8?B?bitoVm5KaExnZlJrb1JaYlplWGRPN0s1aUxGRDdWSXN1QzR6ajNiMlhMa204?=
 =?utf-8?B?d3VpNEYzWEtLRk1HQWVMNmhuUWJpTFJ1YTdFRUR2NWFlV05vcnY2Z2xjV3dz?=
 =?utf-8?B?Y3dGU3hmei9teGxnZE05bml0UlRjOCs4RHlnU3NNVzRvbEp6dXMwTHFVb09O?=
 =?utf-8?B?UG5TNG9JMXVvRVkvemNDT1ZxbFdvUDZML2ZHS2h0YlBPNjdrT1NETG9XemtN?=
 =?utf-8?B?UU42TjlscElvdGFZWThYcW5zbVlUODl6SDJOU0ZMaFJrSnpsVkZFSmR2ZG4y?=
 =?utf-8?B?WUdmeWJCZFhuUitoVmZjS1ZrclJmeFE3RGg0ZWRrTCt4M2dyMTVjQmpUWU0z?=
 =?utf-8?B?Y2hSbGx2eVl0amw0eUFMTDhneWlTMXcwZWN0eFFXdnRFTllEM2FMa2RIRklu?=
 =?utf-8?B?cUpKUldCVlZwNmRJTE1HbjJvb2hFdGgzZWNmNFNjYUNobkxhQXFvMTRjaFlk?=
 =?utf-8?B?NkVJbWRCdDNyQjJqenlZY2w3ZktWenVicVdiUnQySXNERm5FWkVjSURzQ01Q?=
 =?utf-8?B?L3R0WkdEY3R4alhxQk1RRVBtWHF4NjFuakJQUjk5aGdTd0gvVyswWmNqbHFj?=
 =?utf-8?B?NEJXSVovT1BTL1RuWEtuU2ZuSndkZVZaS3dFaThEbWZPc1BaeGZrc0tNQU1t?=
 =?utf-8?B?dG1veDd0RXQ2MFc1ZjY2UEh1SjlWZ2dyb211Q2Y3dGZRbkpQQWwwWTZ5amV3?=
 =?utf-8?B?WEhRbklGNkZ4UmhjaVhiYytHNDBYS296S0k4cnA2UDJMOGRkQnJUNHBnV2NJ?=
 =?utf-8?B?UmFhdS9uNGV5dkZtQkVZRFVQSGtKNGo2bnBPbFVSMG9yWVNDMkRsaVo2NUFC?=
 =?utf-8?B?M0JmY0NDZVptZUQrUTZaaHRTUXFFTXA4bXVtcjk2bG9nTWczSWJZVGRjc0F1?=
 =?utf-8?B?SVJhRXlIOUg5M1lzRDU5Y1ZiSjIvaFgxTWxxNDlVV0ZXalE3aUtZaEE1Wk9J?=
 =?utf-8?B?UkpiVzU5ampjSDd3U1JOWDNuMS9kWkUvQ2FnbDcydGdKNFNvSVY0cnYvY3A4?=
 =?utf-8?B?YzRONmZ5Q3VUWjBoSGZOb2hHYVpvcml0eHhDTmhXSzQ1b0RheGh3WnpIdVd0?=
 =?utf-8?B?YW9IR0dVbFBDZitSU0x2eFdrNk1td2xOMnBOazBLRUlVR3MvRzZ0Y1NaWEZi?=
 =?utf-8?B?ZjJjc3ovRU9uaEt4eGc5S0drcFZLbmlTeFZKTmpKYlRoNkFIWXE2UkswZWt1?=
 =?utf-8?B?SEFmRlJnR2NxRmpKNzRLTTRQYjFtOHZ5aldVWndlclE2c3oxNWFjZk5Sc0J3?=
 =?utf-8?B?MklGUE9RZ0F6Wk5WcUc1WEVXTkhxUkVUYjRMT3VGNmwveDVXUkZmRjdqL1FP?=
 =?utf-8?B?d3NTYXV4M2huNmhnaGV3NVc0OWxMZFEzY1B4dUx2V3ZXYSttc1JSeFVmbHBr?=
 =?utf-8?B?ZXVzZVZLWEw0L3FhSXJ0L3FRSmhXOFJpVXF1QXRLQ1E3R0NjL0toTnMrU0Q5?=
 =?utf-8?Q?ObfiqwqwNGCQSgvcRMXQqbI1P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eee931d-05f8-41f4-113f-08ddbd093a63
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 03:49:09.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yb9Qp1BkfXgKNOFNGYt8oKtsGBi3UmI7aIVveMdG7TCzqE1MiNax+fSyOjiGDljfGiAuo6RWs9LlarwYnswZZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112



On 7/3/2025 9:05 PM, Uladzislau Rezki wrote:
> On Wed, Jul 02, 2025 at 04:59:36PM +0200, Uladzislau Rezki (Sony) wrote:
>> Automatically enable the rcu_normal_wake_from_gp parameter on
>> systems with a small number of CPUs. The activation threshold
>> is set to 16 CPUs.
>>
>> This helps to reduce a latency of normal synchronize_rcu() API
>> by waking up GP-waiters earlier and decoupling synchronize_rcu()
>> callers from regular callback handling.
>>
>> A benchmark running 64 parallel jobs(system with 64 CPUs) invoking
>> synchronize_rcu() demonstrates a notable latency reduction with the
>> setting enabled.
>>
>> Latency distribution (microseconds):
>>
>> <default>
>>  0      - 9999   : 1
>>  10000  - 19999  : 4
>>  20000  - 29999  : 399
>>  30000  - 39999  : 3197
>>  40000  - 49999  : 10428
>>  50000  - 59999  : 17363
>>  60000  - 69999  : 15529
>>  70000  - 79999  : 9287
>>  80000  - 89999  : 4249
>>  90000  - 99999  : 1915
>>  100000 - 109999 : 922
>>  110000 - 119999 : 390
>>  120000 - 129999 : 187
>>  ...
>> <default>
>>
>> <rcu_normal_wake_from_gp>
>>  0      - 9999  : 1
>>  10000  - 19999 : 234
>>  20000  - 29999 : 6678
>>  30000  - 39999 : 33463
>>  40000  - 49999 : 20669
>>  50000  - 59999 : 2766
>>  60000  - 69999 : 183
>>  ...
>> <rcu_normal_wake_from_gp>
>>
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>> ---
>>  kernel/rcu/tree.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index e8a4b720d7d2..b88ceb35cebd 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -1625,8 +1625,10 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
>>  	atomic_set_release(&sr_wn->inuse, 0);
>>  }
>>  
>> -/* Disabled by default. */
>> -static int rcu_normal_wake_from_gp;
>> +/* Enable rcu_normal_wake_from_gp automatically on small systems. */
>> +#define WAKE_FROM_GP_CPU_THRESHOLD 16
>> +
>> +static int rcu_normal_wake_from_gp = -1;
>>  module_param(rcu_normal_wake_from_gp, int, 0644);
>>  static struct workqueue_struct *sync_wq;
>>  
>> @@ -3239,7 +3241,7 @@ static void synchronize_rcu_normal(void)
>>  
>>  	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
>>  
>> -	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
>> +	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
>>  		wait_rcu_gp(call_rcu_hurry);
>>  		goto trace_complete_out;
>>  	}
>> @@ -4843,6 +4845,12 @@ void __init rcu_init(void)
>>  	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
>>  	WARN_ON(!sync_wq);
>>  
>> +	/* Respect if explicitly disabled via a boot parameter. */
>> +	if (rcu_normal_wake_from_gp < 0) {
>> +		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
>> +			rcu_normal_wake_from_gp = 1;
>> +	}
>> +
>>  	/* Fill in default value for rcutree.qovld boot parameter. */
>>  	/* -After- the rcu_node ->lock fields are initialized! */
>>  	if (qovld < 0)
>> -- 
>> 2.39.5
>>
> Neeraj, are you planning to take this for next merge window?
> 

Yes, I have queued v2 of these for testing here:

https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=dev.01.07.2025

Will include them in PR for next merge window.


- Neeraj

> --
> Uladzislau Rezlo


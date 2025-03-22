Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE7926AF5;
	Sat, 22 Mar 2025 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742662823; cv=fail; b=HAhZy75VS2FTpx6pUn7/5jJ2hdZ7e5GKDYRzM2LJ15f4lHTnQKjq4gJ59Z+pRWlY0sUdJWBMu6Ue7kCwPqxCOdutwnFq8xgiXiohFX+AcmKhSLMAkSZ6R34cNv/cUs53j4IZzgjpd+6wT44fZWiYOaRF4O2WA8mJJVPqnshT/8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742662823; c=relaxed/simple;
	bh=aldJSGyOcm9xgD1hqzJqP2/DevhrFtJ/u8Vl+sPdDT0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tl9iFofFrfiSg8u87TZu9tedmEYRzhyRblLpbEqcmf4CET6H/rHFSX1cJIH87V7hovVsZiMZd29bnMdtuOjOWzzGEtD3JM1c90yzM97IJVrUOWRcq3V16LX5AjsJbuPv12SoMGtk9Fvh7zvXCLpQk/eu6YhNBXOoHy2XBQL59ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jW2ocVqG; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jW2ocVqG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owQGgVb1cLtcQO1zmMcAHrEJ54yPP8KOWsbbMrSkbEJyqayAG2ai4RQS/xz4+JUeb5cwDOpXOVeCiDNhee7BuXohzDJhq+fYOd5bs8iD1QbQg/49gG56Jpm4kw4bPOxNg6qWOlyXlHlYZ4ed3/V4j0l63icgFysJZjGtR7XyTid9nByJed35WPrrpxJnBEuKFVZFxaCIrqTHplpIiDI/kzrfbOP8NgTItsM6wOkBGQcv1m/tzPnrC7dsNY55GlsF5yeSc4gplQVa3Cn1j9HCk8SyBYfxIPN7JX6kppG0ACKrf2pryjgN5QT3FWWYRM99L+//jshz8mT6sGcPENP4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q12Nt2FL7J4U4SVxxA3ySQobPjKzmYOd/jr3eUDUBeY=;
 b=k2inNLAvueCHMY/ud7dZoMOyNdj9XQgPgLM18SXjYT7jDaAPK0u8INrB5wn+WdegkP13mqH7R8aXA+hpzloq8gWLsOxNQki2xO5goUUD6C6H7qiMWUrYY42wXEVI2nSlaFjl93blKo9hMXc/Bx/P/1egph6f8Gj6FGF5UuinLEGMGtOSnf8zANWJknOSZBQoLowLbOz/2ZaEb45soi1P7/jprk/gelAayF/YRxHwjBeNMWRUPkBvSfr5Who8Ax10hZTRLe9XFDaslJoLKixdTtB08IwsRLJlZlnBZzd7N6Xsba6ocUZdyXFoRVU5pXQagmHwtS37mn5aI+OJs/Wbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q12Nt2FL7J4U4SVxxA3ySQobPjKzmYOd/jr3eUDUBeY=;
 b=jW2ocVqGtR7F/hEsmSKIUSKaoBu53BHhEDuQNfdWR/TxGSV3QdqdXXAxUwrQvpDLliGr4lK26wDItNRNAZKYc69JdKrqLtGS6jvZVx9O+hUFcxxqWTcZkzPSbx+sPdKG0vomPQyBsJ4DbqKsFtjMsG0xa4eECWyhmiu8DPAwwzRAFGrXq0Zgxke1R0+kaQPZYbvEH3imL4yRX1Vl6Jc2e4jyJQNnwmaaHS97gE0o80iRI6BId7Woua7cJq22ZzWJjB15vJp+dp/ZxUrJxdaQxVP3BeUv5IKB1hA6vVpfndJtduhSBfW5zb50i3/LNkVV7jJf+JU8kVAa/o3eg5MGEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Sat, 22 Mar
 2025 17:00:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 17:00:18 +0000
Message-ID: <2a67f99e-7afd-499f-855c-69ecffd7c390@nvidia.com>
Date: Sat, 22 Mar 2025 18:00:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rcu: Robustify rcu_is_cpu_rrupt_from_idle()
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Uladzislau Rezki
 <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
References: <20250318135619.4300-1-frederic@kernel.org>
 <20250318135619.4300-3-frederic@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250318135619.4300-3-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8e269e-e18a-46ce-2042-08dd69630639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWlCck56L05venRMUG0xcEllUmJFd1h1ODRFMGVNUXRwT0xUUFNsdGRmQWsv?=
 =?utf-8?B?cWVYODg1NjVRQ1Z3UkYvR1VlVngwU0lTWHhOeW1waGZmQXN2a1QzeHQ3M3h2?=
 =?utf-8?B?RFVrWVFWVy9vdVF3b0dSYUZkWVBtOGNraHI2NUl3OTBsS3crWkxWUFlZQkZ4?=
 =?utf-8?B?NUtqRWtlVmk3cjJQUVdwVVFPZ2xzOWYyQmtvbFJhLy9RUHBDZkdSakZsQTU3?=
 =?utf-8?B?eEgvLy9ibUQ3UytFaUk2Rzh5SHNMM0hBN21ORnF3WnJEdS96eHRwVjh6bkt4?=
 =?utf-8?B?N0lyM3JXTjNaQzZ1OU9GaENBTGc3VUlkYUlwcmJmUmZDdXZsM0xZMFVNUUJO?=
 =?utf-8?B?aEVjcld2eXF5cDBxL2xOT0llam5tQ05uTnUyVXZTU1FVa3NpNVQ5SDg5K3dW?=
 =?utf-8?B?Z3R0MG52SHJ0RUlicElUcXZzZlBjSVVnMXE2VjU0d0wvR3hZZGp6L0lCVUQr?=
 =?utf-8?B?NHhtUnhObmNpM0xoTVhta0hJUE5hWnFLTjlmREpDWVRRdmF6UUgxaS81U1hO?=
 =?utf-8?B?QjlqaXZ2YnJveEp4RG9uWitVOE9aajlBc1EyZU9rTmxIUllWRCtheFg1TEo5?=
 =?utf-8?B?SjV4dms5aEpvVWxQQlpPRjIrNjBwQUxYTHQ4YWcxa2FscTZ4OTJUQS9GYzBu?=
 =?utf-8?B?RkQ1SjFWTmFZVjRVNFphQkwwVkNUNG1iOHppSXhrM2g5amNYN2V1b2dDbTk1?=
 =?utf-8?B?NC9hc05WMzVEN0NpVGFhR3AxR1ltTlVOdUFRckpaYWsxa1U1Z3FPWk9zQStV?=
 =?utf-8?B?RGNNUXRjcllEY3Znc29ERkc1NDY5bWcva0REWDhyWTArOWFVRlF4QklNYm5C?=
 =?utf-8?B?SmN6S2Rla0kvN0dncGdlVUdSV0NFWFM4MVJTTExXbkxWZzNHZHp3TUNoV3Fj?=
 =?utf-8?B?bjNFTkZtL2hOays3S2VRSkRrcVl6L1Rldkt3SXAyNXlCMlI3czQ5TW9WYit4?=
 =?utf-8?B?QS95dmN2aVFRUStHNXRaYnozZ1hBbGY2VTVJKzBaK3dUWE5Ba3c5N3NXRGNj?=
 =?utf-8?B?V2h0RlNZL2tyc0c5OC9IOHExZjNYeStYL3hBVnJicVBRTmp2OHlIMnBiclh3?=
 =?utf-8?B?Z28rTkpvVFBrY3hxSGhpMWxXRm42OFE3TGdkZlg5MWFtK1BZbk1UQTdyd2dO?=
 =?utf-8?B?QzEyaVVrRk1lUG8ySFNjVEZqZ0s1RWZNWlFCWnlkNXVOMEZ2YllUYTRaN2kr?=
 =?utf-8?B?aDhSZFAxODM2aVJkRXk3aWo4L3c3UHJJM0pqY3dBcDhtcW5odTJOeE9FR2d1?=
 =?utf-8?B?Q0pkd2Q4elhaeGFkVWFoNEtYSnV5VUN4ZjdpZDk5M2dsY1EwVU9obG1DOGw5?=
 =?utf-8?B?NTh5S1VlbGc1Vi9QZDU1cENSVjNEUU1QVGVQajVaeWdmT2p6Si9XZXF2OWdF?=
 =?utf-8?B?cGg3MlFCZzJUYk9kNGxTWmZEL05ac0NUSC9pVHBRSm1nK1pwYklQK0ExQ3U5?=
 =?utf-8?B?c1ZTejFrSkN4NmRYWHJVblc5Z0JTZ1NoUnhFMmJ3NjdEc1lMZmI0Zy9lTGdv?=
 =?utf-8?B?T3VPVEVXUzFmOUxEb3pHcEtEMXN1ZDR0QnlwQWRpYjU2ZUFSako2TXN2STdP?=
 =?utf-8?B?U2V3M095UUpLSUhWNUV0amM4K25YZTV1WW1zMDIxK3dkUWJHaTFJWFE3ZWU2?=
 =?utf-8?B?MDBpZzBpd0FyRENGeFpuUFpNOVA0TW1sYWFhQytMNGJWeW9wZ3hPbGNydjRE?=
 =?utf-8?B?Tzl4MHdPZkF5aHNiMGp4WW83WVR6SG1nOE5kM0RwbzUrOTZjcHdWT2RGVWF0?=
 =?utf-8?B?OTJOandQSjBUb0RtNXVIdTZIaGJnRU9SV2t3cmtQUENIcVdjRW1TRXFsRnFB?=
 =?utf-8?B?Yzh1K3kwdWk0dTNIQ0xhZEsyYVNNMSs0OTlzcmxBMXo0RW5QRUZwOGttMGVY?=
 =?utf-8?Q?TpeO22UzNI2Iw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHhhdVVpMmxZMHJZdnRDbzQ0M0RNTHBkNlgwa0xUSTVTbyt1OEN4V01GaVgz?=
 =?utf-8?B?SU1ERFNWQnBIU1NSc1dwaDUyTjF5Zm1Pd3hMRmNDSlE3U3dxT3FPTHpwTVQy?=
 =?utf-8?B?eUhnUjZRRkg1YnNTQWt0cnJFL2RMMUVxTG5hL295aDdHa3BlWFpQNFNBT1pw?=
 =?utf-8?B?eCt5SFIzSlVFbUpaaWx1QUFpMGx6K1YweE1LV2ZuWHAxM1NoUzVUMUlHWlJQ?=
 =?utf-8?B?b0ljWjNmUEljck5SaFpJU3hONmNUcWVFVjgvNFJvcjRiQjhRSGp2VWZydmpt?=
 =?utf-8?B?eWtqRlFtUkhVTHZ3NTRVRmFiWHdvaW1lNkEzYzZ3R0JEbU4xcXduQ0lSRFhz?=
 =?utf-8?B?WW9vSm1JVGRXUWZndEkrZjR6NG1wMTVwcE1iYnUybmZJbkd0Q0RMRFl2K3VZ?=
 =?utf-8?B?Yysrd1AreHZUQnJtUnV3M3p6R1hPaXhCTlFoc1B4NjVId1ExM3VNWCtUbDFn?=
 =?utf-8?B?Vk5wellidXhlUTI1cEFOVkx0djFmMlFCQXd6MERYY0FpbkFLbnF3MGp5bzZM?=
 =?utf-8?B?cWhHbVVnU2lOZ2FDRG1zNU96U2gxR2NwZ3h1ZzV4MkpLTVdxRGNVeHF5TmlY?=
 =?utf-8?B?U1REc1psS1h3aWtCeFBGTmxLZGNBeHpsNEVJblR4Ky9vUU5ROGpzOXJES1Rz?=
 =?utf-8?B?L3ZMMWsvVSsrdDZVSVdSV1dEcmUxcFhXYUQ2U1pVckZSWWwxL0hzVHE2aHh3?=
 =?utf-8?B?TUdYM2FxS3l1MGx3NDAvazZTc2U3NkJFRjZqNHpPYmp4MUE5NGJhOUUrWU1t?=
 =?utf-8?B?RkV1VldxbXkyNFF0R3Fic0F5TGk0R3NxTE4xNU9JNWVFVjVxUG1EOHBXWE12?=
 =?utf-8?B?cHYvZjB4enFUSDJkdS9JcExONXg4TnU4YWlmd1NodVhxVGh2cnJSNHFjYTZn?=
 =?utf-8?B?eHJicEkydlZwdXg3YmhLREoxdGFJWjFkU2RWVExCU0pDdjd6L3gxZ0VWQ0w2?=
 =?utf-8?B?eEp1dUxnSGNubEllRzR5UWVWNDliOEo3WUV3dTN0MGx2ZDB0d09zNnZLb1hh?=
 =?utf-8?B?TFROQlVZUWNGT2hEMndYYzZxb29GT2U4NHQveFBWK3RLZG0vTXRMTmpYZWJn?=
 =?utf-8?B?dDk5ZHFoYmp3L3lPWlc1VjNoR2xqSHJLcjVTMkd5d216dmZEc3RHWEZPaUh0?=
 =?utf-8?B?c3dkdTh4MVFsK3VLWnc2Wi9zY2xwY29xcHpMcDYzdzVmUmxiOEFkMVAwV2Jo?=
 =?utf-8?B?bTBpekt4bEhFMWNSMHBRVncwZ05BQ0w1U1RJOEZMOG9ad0RMa1B4a3h3bGV1?=
 =?utf-8?B?d3ZGSGExbDdldGUxcTJVN3k1OHMrOWs4VkNiTUxVMm9aZHNuRUpGcVVIb2xh?=
 =?utf-8?B?VTZ1bHRqa1hvcWJNTHRsNnFHdmkweUowUmhROGhnaXBPNG5IblBtR2xqL0dy?=
 =?utf-8?B?dzl4WHk0UU9NelBRcSthUE04d2JPMzNDM09ZQ214d2hid2lkNEV0aVZwVHNQ?=
 =?utf-8?B?eXhCeEhKYzg3c0xDMm1YVlkwWUl6ODlhTEkvYUpSem83bDFvL2xzUWZsZXYw?=
 =?utf-8?B?MHJhbFNLN09CRHFJSnpybWNnSk9YRVRZVUVobGQzTVVWWXdaN0JRbzg3NVYy?=
 =?utf-8?B?cDE2REZQWUFwaGQ3VHkzN0Z6c051WjV0UWpPWDRHcjFDVXdXRm5IcDZSMlBi?=
 =?utf-8?B?U0dUYyt0RE5JNmR0WEhFejhaSHBnSjhiYmVaaEFpQ0UybHlxOEVLeE1PV3Zz?=
 =?utf-8?B?WEZhOEU0TmRnS3d1M3pDa2d6R2lMNFNYOWZaOFM1eUtDUFZ2WTlOdzVTZHpH?=
 =?utf-8?B?M0xEdHVEYUxNdnRNeUtEcjBkcmUvM3phSzJsKzhIVE9hOEV3ZG05REdzRUJN?=
 =?utf-8?B?MXQ3cVhQS2ZEN3RiYnRjMXBXSnhCM3RyVlNRcTVEd1AwRjFKc0lqQWVMamhI?=
 =?utf-8?B?SGtMNGo5R0JEM0xxVzMwTHcxdTJIT0IzZytlMy9yQnN6d2EvT2pDK1FUdG5Q?=
 =?utf-8?B?Z3ZxOE9aK0x3WExldFZTSXZIcFc0dVVReVhYS1YwT01ZQk5PUENvUFlWN28w?=
 =?utf-8?B?WDFMbTZCSkg2aDB4anNQM0NYTFlhdFpmRk1DNmNSbVBUelRWbStCVmdYeDN5?=
 =?utf-8?B?UnJvdzRkaDhTNjQ1M1ovd1VqWVMweWQ3cWE3SEJTYVZFKzlON0xWQmlucEVU?=
 =?utf-8?Q?tHHBF9xkSWsevjAn7zIeTVhba?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8e269e-e18a-46ce-2042-08dd69630639
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 17:00:18.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7K0QsNruhhmQgzJePrqFurNbBELI9b0Wour1Unw2g6CyyJRo9n7tfX+A3YNVA9kFMPIpSE0v8Ot7xPOsqgPDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918



On 3/18/2025 2:56 PM, Frederic Weisbecker wrote:
> RCU relies on the context tracking nesting counter in order to determine
> if it is running in extended quiescent state.
> 
> However the context tracking nesting counter is not completely
> synchronized with the actual context tracking state:
> 
> * The nesting counter is set to 1 or incremented further _after_ the
>   actual state is set to RCU not watching.

I agree with patch, but this line is a bit confusing ->nesting is set to 1
*after* the RCU state is set to "watching".  Did you mean "watching" ?

But I think you meant "After RCU transitions from a state of not-watching to
watching' instead of 'actual state is set to RCU not watching'..

ct_kernel_entry():

	// RCU is not watching here ...
	ct_kernel_enter_state(offset);
	// ... but is watching here.
	WRITE_ONCE(ct->nesting, 1);

>    (then we know for sure we interrupted RCU not watching)
> 
> * The nesting counter is set to 0 or decremented further _before_ the
>   actual state is set to RCU watching.
> 
> Therefore it is safe to assume that if ct_nesting() > 0, RCU is not
> watching. But if ct_nesting() <= 0, RCU is watching except for a tiny
> window.
> 
> This hasn't been a problem so far because rcu_is_cpu_rrupt_from_idle()
> has only been called from interrupts. However the code is confusing

Agreed, and I could also see the existing code's snippet:
	WARN_ON_ONCE(!nesting && !is_idle_task(current));

.. not working if this function were to be called from non-interrupt kernel context.


> and abuses the role of the context tracking nesting counter while there
> are more accurate indicators available.
> 
> Clarify and robustify accordingly.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 79dced5fb72e..90c43061c981 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -367,7 +367,7 @@ EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
>   */
>  static int rcu_is_cpu_rrupt_from_idle(void)
>  {
> -	long nesting;
> +	long nmi_nesting = ct_nmi_nesting();
>  
>  	/*
>  	 * Usually called from the tick; but also used from smp_function_call()
> @@ -379,21 +379,28 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  	/* Check for counter underflows */
>  	RCU_LOCKDEP_WARN(ct_nesting() < 0,
>  			 "RCU nesting counter underflow!");
> -	RCU_LOCKDEP_WARN(ct_nmi_nesting() <= 0,
> -			 "RCU nmi_nesting counter underflow/zero!");
>  
> -	/* Are we at first interrupt nesting level? */
> -	nesting = ct_nmi_nesting();
> -	if (nesting > 1)
> +	/* Non-idle interrupt or nested idle interrupt */
> +	if (nmi_nesting > 1)
>  		return false;
>  
>  	/*
> -	 * If we're not in an interrupt, we must be in the idle task!
> +	 * Non nested idle interrupt (interrupting section where RCU
> +	 * wasn't watching).
>  	 */
> -	WARN_ON_ONCE(!nesting && !is_idle_task(current));
> +	if (nmi_nesting == 1)
> +		return true;
>  
> -	/* Does CPU appear to be idle from an RCU standpoint? */
> -	return ct_nesting() == 0;
> +	/* Not in an interrupt */
> +	if (!nmi_nesting) {
> +		RCU_LOCKDEP_WARN(!in_task() || !is_idle_task(current),
> +				 "RCU nmi_nesting counter not in idle task!");
> +		return !rcu_is_watching_curr_cpu();

Makes sense to me and it is also consistent with rcu_watching_snap_in_eqs().

thanks,

 - Joel



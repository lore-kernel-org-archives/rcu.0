Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED4290BBE;
	Fri,  9 May 2025 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796610; cv=fail; b=CkQzEk5FTCtUolz100257TwplhSIAufxoWSYoWfdmqKF2Z3QVoxlVTQG4WrehUWzSuzzGLWlkZasyxwR+yucxy7G8AIvSWHjQ9EyGfu2BmXHlielNce36WYojYahyzLWuFUpFR+Y6esRXCDF6btAymTXtAYDeCmRlLh7kk2zm+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796610; c=relaxed/simple;
	bh=2rGQxwpANGjFY1hiSpYfOSXCSA/XJDYhs2jplKUQKIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=opE8Q57lrKqWSyLV/yK8fd0tU7LhHoQm3rri7QPzI68NTO0nVUdjjY18oq2sw55vSpseaVSyiwooY2GsvX5Tpf4adlld4F6S72JGz961+roa5lrqbpopnC6kXk0GuVePSMzgG5e7QXqV1DcDBYYFVRb3fW1Fb2l6CGQSbLBwkKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SH0YqOY6; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SH0YqOY6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWuQsIg1nodjnEHpjVc5VZv3lKjdchnNOp0bGm9hga7swBypqed1B5zMahHqyvR5O3jXaR5oL2nED7tGAxmkXyTNngBwVwN32LmN4kTiIRKSeBUPAoWUjAKqWt8i33S9cPSKCUE8afN6k1vXMWP9wh3Movs3DSb7Kz9bJYQPxYRKM3B1QWRibgZYMF0nFAQLEodxhd1X/M5G3NuX7HPYIQ83OhcWrwqLA/gi035hm8HqDwMj/G8oiqPfD9a79MecUnuiGR3BO6GmmNnHAxXVfsZkANNtM3Frv5WPoWaS0y/JNDzgLxEvSvROH1XxM6C+ZTQw7zdYax16dPpiHxDivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsF70bzKsvKWLQz97x33CwRm07PH/iVBdhBIzlu9jno=;
 b=unrJu99b+YeCjBaPqwX439ZxqsaPJsnLKd8ae+b6smwFcXYPATCIozcWzvMmci+JpZKyIsWfO9ElXjUxjrd/OWigluRW2SHQWbtQ5PuEiDYUujx3XvRwLqTZyjhMkJurzjtDGUjG6cipcwYA4MlEJz6i76Bg4R0MCa/vTAi2FUFcOGk5OD5sJaERcBu7hFhKoh9VGPc5KsTaiMMAo7Z5/KJKd5b7P8PBOzD+gzus9iREFzlJp4TOrUfkcFX2QldEJHVJYk7Dkx4iqxeTWYLeAI8I8IJ0HVkvsJ0sh1h3ThTc+FGaxasPY7hUsz/ajvbrfyMqg4wIV3bqozuQX+ifwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsF70bzKsvKWLQz97x33CwRm07PH/iVBdhBIzlu9jno=;
 b=SH0YqOY62KiIU1Ni8ChBvW4qBLNV9rREMZ2fz32a47v9WIkQzUXpHmS1md2FJcAVKTPP7s1nie2A8nVqF6KmdtziA5q7K486y4ljAF5s+s1UrXXk+gHVFC5/Ty7no/jwjt1BXu+bXchLHkFHUL6F3YNK3Gsj6ctQkVpRNzC1paELp2XANFFFM8ifuCwApzw7d7WSIsrkYlZ2Qb66JY2pbBMLv3Q8SRKqefT6cicAcsCWUCGtwSAj0hnXhuh/Wuf5OL5QK1VgoqdMTQvTsRFwmaKsxKXSvOzFnzPwFH4a6OXksK4FJV0Va5jbo7Oh0NG+Z3g+HhnMkIVDRB/iZkfNeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 13:16:43 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.035; Fri, 9 May 2025
 13:16:43 +0000
Message-ID: <7b704746-fd7b-4c09-9f5c-cf11ba200379@nvidia.com>
Date: Fri, 9 May 2025 09:16:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Miscellaneous rcutorture updates
To: paulmck@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
References: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 6544daed-7529-4a5f-e162-08dd8efbbe01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmMxYmY2alJ5Snd0R29wa2JoZk5sNWJnNHpTQXJzM05nSnJiZFlVYjk0ajcw?=
 =?utf-8?B?ZGFMd3UrN2VsbWVDUUhRV2EyNC9mcHN1OVl4V1NMSTgwK2psdTM3QXJFNlJO?=
 =?utf-8?B?U0dJaEtxQUlhTjRpVjhZcXFxVUVmeDZEdTMydVV6TzU1K1Raakk1WHRDeFN2?=
 =?utf-8?B?QStnblZxVXhsZTVoUUppNEtVOGpZSHpUSXNkOXVkalQ5Sk5ub2ZzaTBBcFZ6?=
 =?utf-8?B?OVNnbHRZM2tMRXhiRERxMlB6VWdZSGdFQWlOajNOcDIzMGZOTy9zN0ZkWmlv?=
 =?utf-8?B?N2czeHZiR2lOaUdXNUJYYzZZbmcyTE82d3VBcWhKdVc0QjdTcndBSG1nZExM?=
 =?utf-8?B?VXBPd3hnM1UxbVZvbk9ObTJVS0NRSmJuRUVSUERrT2k5ZStjNHA0Tm4rRDBw?=
 =?utf-8?B?SGswUlc0VENSanlaV0FzMU9aM2dCNnlVY041N29FcElSTVpONXM5cEtBdE81?=
 =?utf-8?B?TWNaOTZqbnFseHBWcHdnL3BVUEFwZGxaNmI1WXY0ZE5oZzIybFV4MjMrUXZn?=
 =?utf-8?B?YURGZURwdlplWEZPVnR1am81dzVnV08rbEpLdlRFSnJXS3ZXSzRnMjRrY2t6?=
 =?utf-8?B?VjFrU3J1TFhtb29Jc1VxVG42cWtpQWtjVlZPcXUzWENLY1JiWWduUlhWcUZT?=
 =?utf-8?B?QmhJemg4SE5xcEhkQTdnbXpleGR4cmw4amZaVHBTbi9wMzBkZnp4SzRPUW5W?=
 =?utf-8?B?cUxLaHlFM1lZMEVUeFFmajdJK0wxWVEyTjFYUHZhUU9WLzJaSG1SSG91RDkx?=
 =?utf-8?B?UnBnRk83NHJtZnpOeE1jVHh3ZEFhb3BnZGxrNEo5aktZVis4eExlWFhoa0Y1?=
 =?utf-8?B?R3o1Y2NqVFU2cUtLZ1hYNmpQUXpaU0tZdVNTTFVqL3l2aVB6SW5vOUtYTGQ5?=
 =?utf-8?B?NUFDVkRYaU8vNjVRNzdLMnk0b3BXTjI2WHpIeXkvenJWdFRvK3Uya0djMmFa?=
 =?utf-8?B?dGNmSVdGanpXSjdKaXpTWW8xRktjemZPL1ZIY0pybEcyWnYvSzdOUFFqMCtl?=
 =?utf-8?B?eDRGYkFPV2E4YllGUVZjV0VSRzlrMDZNU0FobE01M2h4Qmc5NGJIbi91aEFV?=
 =?utf-8?B?NDhGL3dBb0dGRllVUEV6TTdSUFJnOEw4N01pc0tsQ3ZEeVhIdFNnUDNRRDJs?=
 =?utf-8?B?ZmxvSFpPZkNGTGJTMGdPUlpPM2xsWUZXVzhGeks1V1JIN2NMM0RnejAvdkFs?=
 =?utf-8?B?OUNFcTI2aTVsMU0wbXFySnUycnRBOUsvbGxhOUFOWFN3NnR1c0YzclYycEds?=
 =?utf-8?B?MmZtWmxvZGhhQWlTZHJyZTgwcEYrTjFZTnpGWHhnSFVUQkxTL0FqYXZBdnNv?=
 =?utf-8?B?NFd2YnZkK3RBdlA5RTBQR2E0SjFCWUJ6UzgxQ3J1MGhHektLa1NKam0vcnZI?=
 =?utf-8?B?cmMvRis0QlhoOU5sSStHN2pkajdQVUlveVRSU0F3TWQ3WCtoYVFQelpoVFFD?=
 =?utf-8?B?aTljMEdodVZ6MEJxRi9RYnp4d3BwaTZyY1VZeDRUTEUyems1UWxZRzVtVVEr?=
 =?utf-8?B?MXBGVW1sZHZKRWlHTUZXQm1ENnR2c2lVT0ovSGpnQkFHMjJFakhzMXM5MzNB?=
 =?utf-8?B?UXp6QlJ1YXdjTmNnajgxUHFvaFdreHdpMkhKY0xUK2xKaWxMbHJKdm1zMHZX?=
 =?utf-8?B?QXR4Y25acFNHdm92Q0pmdm1XVlloUDhCRlhvanp0Yk1ZZHl4a1Z3T3NrY2Rq?=
 =?utf-8?B?MTB2KzRKS0Y1N0hua0UxQlltb3NoM0JYb1VacTlPUEllSE5FTFRCbVY2VGRZ?=
 =?utf-8?B?SXFkUzBYQ3pBRmNzMlQzUUpFWnVaRUNqRnllOU5pcHFPTmdTMFI1Yk5kM0xi?=
 =?utf-8?B?cUdDbTlXQ1E2enk0aVJnTVNsTVNIQThrdVZNcEJpTGlUOEs0R1VhSGVNcUF1?=
 =?utf-8?B?WFYxNHpkVVpReVRjUnAxdVBSaFRaWFM0MVA3RDJqUUlCTzRVYlFoak1pU29J?=
 =?utf-8?Q?IDFE7ZX2P0o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnBzSnZUOWRLZEdVL0pLZEpONjc3WWxhY1BvSTBzb2l2RmVvUWQwNUZCb3pP?=
 =?utf-8?B?MitjUklpK3JoaUtqdExBdkd2MG11bHZrRnM3U2pMNFY1R1N1WXgrK01QYnFw?=
 =?utf-8?B?QVR6ajdmaHZYREVFZ1F6VmZEM2E2L3JKRTQrM25GdGZRV0I3YmtlcHZjZHEz?=
 =?utf-8?B?Y1Z3NThLMTVmeVJZdVFaYjFFSkNZWFJOalpoUkR6Uk9kMEplUjVsWFBobDgy?=
 =?utf-8?B?aUpkYWl5aTlBN0tEaGtFbStwVm05UGF4ZWxSdU96N1d6VmwxeHJVMDJZYTJY?=
 =?utf-8?B?L2QvZjdXV3ljcGoyMXVQdWV6amdNbkdLZ1hzYnhscjUxUDBtc1NCUWFTbzRG?=
 =?utf-8?B?TEphdkhnV3loSFQxaDBJUjFYNm5ucnhjdkJlcTVIbmhQcDJKZVFBZkQ0K2Fq?=
 =?utf-8?B?MHN3V2lYRVlIc1FkU1JYSkZYMzZnWHZZQjJ2aHNpeC84WnhZeWJLSUJrYjNU?=
 =?utf-8?B?K3djam1PR09BbDRFaGh6UnMrTjN4S0t0dy9mYjUzVWV1ak02MlR2MkxDUnVz?=
 =?utf-8?B?RTdBUlduS3BuRnNZQU1BY0RWWS9acUxLUDNZa0IreHRPVzBWT2pIdVZMMFB5?=
 =?utf-8?B?b1p3MUdUVXpXVjI1bGxzazg3aEFFWHZnTURDOFZ6MGw3QVpXQUpCSjhwZmdW?=
 =?utf-8?B?Z1hxcklGOXBzeU1KSUVUb3FHdi8yV3d1T0xXQzA1ZTVCRWpIWXpqUEJRMGZn?=
 =?utf-8?B?ZitkdkF6OXBuYXV6aS9ySlZ1TzkxbGlWWklKQWdMZHM2Um9XbWdKT1ZkUkw4?=
 =?utf-8?B?dS9uRzdhS09xWmQ3d003MWQ0ZE4zb1BPWXhRVDloSUpCQVFoeUI4eGVhUy9T?=
 =?utf-8?B?Y3JaUHRlT293enZBWDIyT3B4U0d4K0ZqbVZPQXY3WExGbVVzanNHdEVnZlEx?=
 =?utf-8?B?NmJ4R01NdnBueC9vVEJEYXphVkdMVnA1Ly80TW5jUXg1TEJTUUVpTUl0T0lH?=
 =?utf-8?B?MnIzcHAvSGkrT25pN1BrdjdHbXAwRlVUOEEvOGJBSU53bWw3OHYyb3lqcFBH?=
 =?utf-8?B?VkVHWWYvSnMvUExoamovd2UwSW5hSlZlbkk5K2VpWHNOeU9BZGwyUkpYY2Vw?=
 =?utf-8?B?SnQ3Z2dMYmdQSy90M1ZkdWNSL1ViMHZZcWtqa05wVEIwZVFaYU1zQTdIbjVM?=
 =?utf-8?B?Q1cxdEVqWXQ0SXVJSmg4ZlhoRkM2dEFJb0JndmJIWmlJMmdwOUxUdzgwTFRs?=
 =?utf-8?B?UmF1clYxNnNJVnMwZFJxMkdmWmovVXROU2JmbHhyMzk1TkNJWlhZMHlvQnRu?=
 =?utf-8?B?S1R1RnRqV2R4NE45dHRRdS9mVDRwUE4wRGJkTGsvaHpZNm9iM0tPdk1hbCtC?=
 =?utf-8?B?U3hvNmM0NUZBL3B3aWlpNDUvWTlLZTR0bzA2a29zUlZ3VEVRTy9kejEzaXYv?=
 =?utf-8?B?VnNnQ1N2R0M3ZVpURDI4TzB1blYyYUs1MnRHL0JoRU9tSlhQaFJxSmt0SVMx?=
 =?utf-8?B?RU5jN1dQdXhaenkzL2MvQ2FHWDVNMENzS3VaUUI4dnpkc0tFdVRGa0RzNGpM?=
 =?utf-8?B?ZnJuNU1Nb2Z0eExhL0o5R2Zxcmw3RG9hemc1RzVWcmVLVDNtTTB4L1ozR3Y4?=
 =?utf-8?B?R2lRVXJ6K0N6T3JPbXBidERydHNpNTd0ZGo0SXB0MnkyLzUrQVF4b0pDbzVt?=
 =?utf-8?B?cDYxOEg2ejZVK0d1K2t6V29SenRQY0diZ3ZEUldvaEZjQWRYQnk5eXFFa21O?=
 =?utf-8?B?a08wNmRTNHFuQmpjeTczWTlFL2NKQWJqbnFLbkR5U1ozcGMxNE5Ld0pjNmps?=
 =?utf-8?B?VzBDOVpiYmtvSmMycyt2bHB3UjkxWnQ2YmxiUUl1WEczWmNnQU8yYU1BaEVh?=
 =?utf-8?B?WUdDb1M1cVplUnRTTHc3WlprZC93K2NlMlhKdjJ3TmRnVDBNWUxqOUlJcEZi?=
 =?utf-8?B?QnV2aU1jSVpzU000VTA2YnpDdk5mK2tOT2F6UzB5Nzcxc2NtNkhIRjhHdTFU?=
 =?utf-8?B?Y2dua3p2cFo0THJlZy8vL2Y3TDRtV2s2dkh1bzNiNGx5Rm9TU0RobkY1OHR1?=
 =?utf-8?B?bzVRNnBMSmNiWGlSNFU5a1k1L00rQ1UrOVhKRmV4dWlnSVR6Sis3YWdHRHpm?=
 =?utf-8?B?S2dQTlJucENSL0JXRGw3dnhOQ3VnUnljMlRXOXYrNndlOUJkL2l4ZTlJSkt0?=
 =?utf-8?B?TEROQjk4eUlrZnJNMlpHL0dKaTV4TTlJMmovM1JUTitpOEh2NnVzajU4cFVY?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6544daed-7529-4a5f-e162-08dd8efbbe01
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 13:16:43.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEHoFoUjPSatzH94jbRBbl9cEFuwpf6KWOJtEnd5gl5ks7pvYaRbUBuv+oKgH+NqR+8eEmdIMMS651G4b5iJlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764



On 5/8/2025 7:44 PM, Paul E. McKenney wrote:
> Hello!
> 
> This series provides miscellaneous rcutorture updates:
> 
> 1.	Suppress torture.sh "Zero time" messages for disabled tests.
> 
> 2.	Print number of RCU up/down readers and migrations.
> 
> 3.	Check for no up/down readers at task level.
> 
> 4.	Start rcu_torture_writer() after rcu_torture_reader().
> 
> 5.	Print only one rtort_pipe_count splat.

Paul,
Are these for 6.16? I am guessing not so I'll put them in my rcu/dev branch but
let me know.

Thanks.

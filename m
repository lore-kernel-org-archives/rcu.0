Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D42EAD1A
	for <rcu@vger.kernel.org>; Wed, 18 Jun 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257084; cv=fail; b=YS593VG0JCLGQeCbVn5HzxRYWu6OzXZOnZlYNYT/zCIlmpiKOZBviD3XERBSsO9QnM5C9hDEGxSY0azKWf/a7ejDa1A3EkBarJMmBG0I1oqlknMgtkyzLBuED/j55WHBHPRJd69D2w+DNZ9wqp36ZsPZOarNi4str0Jvn7SRRLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257084; c=relaxed/simple;
	bh=kHmnw1MdwmgPMNnR04Cu0sTCkqhAj9PDAO6nFbYZf80=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lcj88nkcI8jxbvoy1BOtR66e4/5XG9cEmUjm7349oSbR2iJSLf4xID5kUrUNtfoFW6X1FeoyomBKd+H4gOixPqtVoRN0rlmqcs2k9L0TVF6c7lJhTqE/wWLYGjvGIWKdwj9580TJp2fS3gQL2kp3yU6AJ3gb7EAuecC0Y8QG9zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AYgywJeR; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AYgywJeR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpN5OxkGScxF6uslOq0pnIhq9HY7+Pb6+LWXkUjANKo+W8VM5fv82+qp4gX6u+QjaCfbWULSb2zie+f/O8Pz1TsiUS53acH1AKfHjDJkRGBJmGfq0UUt+iWoIMtUILixLfuvNRLp1ihMPbAP5xQA0eGuRiPCf3Rdb0fqeYCAlCV4yzKeBmoMww7GhF8YUGL9TQXQAfayNkir7Oz4l+RpAx9qbSOp0MHnCgnSNEfSwgGAs/RmSFpWFssV/Cb7LRsgr9wRU7HPXbie8rG2iPKX20jO7Kj4wN8/k8Zxk99A8st4HbbfATeASO3voyxkeZgUGs2zCqwp6SWoc+9KdPbg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l+CiFR4BzCJJh7BP+umkeXpFzbHRE1D/Eu3xunMBLA=;
 b=DgGrbpAhRWRi8d6i4z5J17E9xduLmbN4kAF9tlgPNpekxPMGxeFv2OzL/Gun2LryoS2dzVgqhsfEtppyEgsm8vgLcmka9UYPCbGuGrXuCGi+7oWOz0q8NsP6ZKp8KhYhcAMT6hV3eOpulLR84t0S387CnLk+PQPGyO4v/mIFNnycdkyPf9lvi5iO8FZt5jmHjAgU6TGPflEGgJIEMMTrzVQBNPYQEYwVHOBkrTD//fOv7RafT2ZTntLuqe2S3dYNSAKkteKgT4cLLg6LiGsY371EhH8/1lpzzPRj6t3GcE+JP2++tt5JvmOSAewtZoOw66Ll+kNBydbICgVDCE+bMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l+CiFR4BzCJJh7BP+umkeXpFzbHRE1D/Eu3xunMBLA=;
 b=AYgywJeRuGdLtRzuPfF5zZszf311AScnaTU6xTD45jJ59uZjdpxVTGmzkIAPaQ/qT/FhiTzBGrEqdeA+oZaQuZ1iGPxkXBnK0AOtdZTfu7HzDLUG02mPMbGpxLfY4UtIE6WezxlsxGK+lhR3IomVaqjRR5dTBuAW+yIZt6TBEaIUj9SDNii0KREiUVgfkCXUVrh3ji35ca8FoP/x68nc3MvI/EKZOlXI2Q7KlEZuFtqQp3/hOs3E9MR+8vYf8SPm2Xf5J6R7VFN7+2ZlR2gfL/MIy/GKRRZfAZTon+Oauqm4GCJR5TW3Y87SNrkuhCW1iL0gI7P4Q5x2MJDRuyYpiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 14:31:17 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 14:31:17 +0000
Message-ID: <d57b56b9-4c89-4544-930c-9bd24fea33bf@nvidia.com>
Date: Wed, 18 Jun 2025 10:31:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: TREE02 warning while initializing expedited grace period
To: paulmck@kernel.org, frederic@kernel.org, neeraj.iitr10@gmail.com,
 urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org
References: <b7a341ba-cd4d-468a-9d66-4aabe70a747d@paulmck-laptop>
 <603add86-47b2-42d2-a2f6-9ea1a2e1d64c@paulmck-laptop>
 <f4558fee-7733-47a7-8110-62a6753cf1ae@paulmck-laptop>
 <932236e9-78cd-4cbe-aeaa-ec177dae8e6f@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <932236e9-78cd-4cbe-aeaa-ec177dae8e6f@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e21804-943f-4861-6181-08ddae74c8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm1LK2pWUVRhR29ZbFV6VVRiMlhTNk82ZTRWUzRFOVBMVVVzemJ2ZFJlenp4?=
 =?utf-8?B?YlNBSE9saFNuWG5ac1R5NmM1dU5aSWtrTk51S0N3M0dxUzNiS285S2wwZGs1?=
 =?utf-8?B?cmtmNTh3amR0TTVlakRkenhmTWY0WGJKVXZ3MzhRaGY5dWRVOHFSZ0tQYmhG?=
 =?utf-8?B?V0JNY3VIclpxQWlBRytHaCtOQmhzQTl6VHhtcE0wa2dlc0xnVmVVbW1JUkFM?=
 =?utf-8?B?Q2NCdWk0TUN1NGdOVzVZc09uSHpMWHdnSkFFRE44eld3K3habHJ3ZXFqMTZz?=
 =?utf-8?B?S09icUNmWEJIcG84cmxMbFJJNmhCd2pmQU1yanY3MTVkTmo5TUlUa0EwcEtI?=
 =?utf-8?B?RzhLRHdnaTBlcUdtRzVPcmJ2d1VVQkowWTdUZXBod2pzTlpBeFlGSXpTZ3Yy?=
 =?utf-8?B?RWg0S09YWHRxZ3hWVDQ5d2tJNXVaNERtLzFtTTIvOXV6OEZNMWJzbnVyTG85?=
 =?utf-8?B?TW5WOCtNZXFNV2tGZXE0NFFvd0RqN1VlZDlHeGVNbGgza2xFa010Q2VyT1F0?=
 =?utf-8?B?cThLdFVhdU1DMGcrbHQvaStQcHAzc1lzbTlpTS9lNDN2eCtYZlpzTy9RMTFa?=
 =?utf-8?B?Wis5TFRXaTZwWlZwQklnYTFVUUsyMk5TeHFyQVF3T1AwMisvRnA3dHZMREpT?=
 =?utf-8?B?YTQ3MUdOenNnbmQ2dlNWNEVnb0lIdll2eWJZVjV6NFg1MnZvUXVDRGV4ZUlG?=
 =?utf-8?B?dzlRZnhwWW1qemcvMnlmMG03bDZ6MDZubjVaREMrbjgvck1kWkNSZWpVN2t4?=
 =?utf-8?B?N2RMUlFjMkVPU2xkK01sUkYxeDVEeE00d3NsaGVZTnhvQnQxL01iTkNzTFFh?=
 =?utf-8?B?Mll1MmtQTzdHN1phNllWZjlhOE1xU29KNDdSUFlGcXZNYkpTZjlQMUdvQ2dY?=
 =?utf-8?B?VzJsdGtZMXBlaHJWcURub3k5TFRnWENPZ2xYQVJYQVpObVJKbXlIejdnUWNL?=
 =?utf-8?B?ekNhLzVzMVQvRVJDb2w3RkdXRCszUENSLzc1a3liTzQ5eFA1OGdaRXZVTmoy?=
 =?utf-8?B?ODZvbjhqdVZpdUpsWldsQzlHYmlNQVo2UkhXQVhkNy9xNmNiMENLR2lHYi9p?=
 =?utf-8?B?dEh1TmtmcExLNHBtTFN2dW9qVERwSnFVME9DdGlSOTA1UTh0VVVyd0pScFB1?=
 =?utf-8?B?T2hleEc1Z0gxRVNxK3phMytLMUNyTE5wcjFXNE5ZMzNCYk1sWS9UYjJHeUdn?=
 =?utf-8?B?N2NaR2NtMDhRZnJSMHRJdG82bDhLaEtBcVlnZUtVYnQreVdwT0tnbndoOUlh?=
 =?utf-8?B?cXkwYXprY3lySGNuMUQ1U2JUZGt6ODJtOVpzcnZSRVRVd1VYY0FublFnVUFm?=
 =?utf-8?B?NU1KTVc4R2sxZ29CckxmRTlscjNrVm1UOGNsQnJ2bm00aU9HeTNMcGxzQ1hS?=
 =?utf-8?B?b3BQZjdtNlVGYytvSmZLbExla3ZMTjVhZEtocmplZ0dMZHhHUVJJYTVtOWhI?=
 =?utf-8?B?ZXZ4OUphTDhpTDZXdHhsa1FGYUFWZ2dvQXpRVEw1SDRRVW5kaUVnbTB3TmZw?=
 =?utf-8?B?QS94TEMwTTBBZGtBSkN0amdQb2hlUUxuSkJDaWozTW8zTUZ1WDRKanlLYVVJ?=
 =?utf-8?B?WG9yLzVsV3UxYmNML1h5VUErTVFxMmF6KzBOaVZqZ2o3bGNiZFU2MitRa1p0?=
 =?utf-8?B?RkFxMTRTeTlvWlpiakthejZMVjFJdEc1YUZkYUxIUUxSWkxwWFI0cDQ4SFFk?=
 =?utf-8?B?R3BIUjRFSzJGVlVvajFVek5rZHkyRm9oLzkvVS9jaGdrRkFyMTJPemVDb3gz?=
 =?utf-8?B?ZjUyMnRtZHUyaGNHOUYrUnRVMVF0d3dyNDcwdjYvdW5IeWpyZWdCYUl0bG9q?=
 =?utf-8?B?RzcvQXFmaWQyZjg4cnUyUHBPamFiQmc0Q3ZSdEJndTIyaWF0TUZQNXZNVFk0?=
 =?utf-8?B?azB0U3c5eW4vTGFDYTVkajRTOHVkaFEvRC9kbkpSZXd6RUR5R2diNFBCKy9Q?=
 =?utf-8?Q?8LzikGWbV2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blUrWGR2bmxyR1JoYmlCSThtN2pDM3h0Q1ZJelUrby9uazRyNVlCZVJwbzI2?=
 =?utf-8?B?aitGRU80ZWd4UUV4ZEs1THY1M2NNVXpqcktBZXJKSGdYOXM2bHhOcUMrRXNF?=
 =?utf-8?B?Ujl0SWdWSy9ZZTlUTC9iTjZXUDkvbHdQcjV5eldIWmRPS0gyODJNMFAvSWZ2?=
 =?utf-8?B?bE1HOGhKZ0VpOVB4cU5RUlBGK29PZXZZREFPQlN5eGJsWUtKZjh3cVAwd2po?=
 =?utf-8?B?a3Jud0FwRHVTejN1NXF5M1ZDSFBXWDNtcUUyRjA4TTVDK0I5eVVUOGJGVUtl?=
 =?utf-8?B?K1NGZStRY2ZHNWU4TTlCVFdjeDcxa2hLdEVSUFh2S3ROSzJ0NENYS3ZFSVBR?=
 =?utf-8?B?L3ArNnZvRzhmYkpjM0tLbXVUVGc1ayttNjJWVmZGZzNaODA1TUpoR0h2bG9U?=
 =?utf-8?B?c21iSzRXZms3Zll4S012Z2ZXTHJZMEhPbHJwTVVqMnhmNFNFcnNrR21YTURR?=
 =?utf-8?B?VWJYQ2E3cEl0ZFVtRmdFcEZPSGhZQkE0YTI5Wjkyc2NUaDdqZDRvRTNWOHBE?=
 =?utf-8?B?ODhvZldqcjFrdUQxRWJGSHAxQUs1cXZvRFczeHpFTWpraXQrYXJTZGprbW5x?=
 =?utf-8?B?cnVxTCtsT3NOUDJWWWxmUHJkWUthVUQrSFFZZWNwMVhJQjViZXVNR2tuSlEw?=
 =?utf-8?B?TmZHVmk2WVZVeFVPK0RxR1JycDdtS1J2L3pPbEdpb2JRdjE3a0FyZnpPS0Qy?=
 =?utf-8?B?bEVmTlVRYkRGQk8zRTVRenBrRzJjQ3dIOUlobnlhZ0sxZy91ZXVsOGR1citx?=
 =?utf-8?B?aGJJMHl1RERkUEJGUnNkWkIvT2xWcDZxQVVqOGgzSEdpNHEzSnFsYUJkeHll?=
 =?utf-8?B?K3JJNDhOTWtDRWN3MmJtS2M2QVU1OVp5WVJNTkpQZnFRd2tMRUk4OUJHRUdK?=
 =?utf-8?B?STl6YmVkZ0UvaU9KeE1Gdm5WUGx4MDhsL1dQYlB2VkZRYUVPclB2cWM3Nzcv?=
 =?utf-8?B?WExJR1dTTzZKSitFQUw5NkRjTWRJbzBoVUNsQmp4NWhJSnhmeTZ0TjhMaUcw?=
 =?utf-8?B?SVY1UldSdlhCR256UWY4MVM3ZGIrblNLMVNwSzNVbGluTzczQ2s5WkVnOEMy?=
 =?utf-8?B?L09vOURXWlJzVjdTMEIyaFVQeHdRMHFUVUM2Nld6L2tXQmttb3JvZ09Ld0Z4?=
 =?utf-8?B?aGg2aUpCQWx4NUgrcStPRUh1ME5nOERlbmNrdnJlakQzSWkxdlc4U2ZsWFd3?=
 =?utf-8?B?eGdmcDY1MWY3bHd1QnVFbzdyR0ZFTnlpS004N0dtTlVEZVc3SzBHWXVrY1k1?=
 =?utf-8?B?TDQ4dHkwNUE1c1hTSjdHVlNWTnViZnlMRVNKd012NktmUElKT0IzSGwxU00x?=
 =?utf-8?B?UU9PSUxGRlZMZzVEeU9hb3R4TVhoMXd5WGJhMnZpTVJ5ZFNySFdRUHp4NFVh?=
 =?utf-8?B?ZDNzeTk5SjgzaHFSN0VETU4zYTJKdnF6ZXltekZoTC9OZ2VUTGFJMVlsbHRo?=
 =?utf-8?B?K1Y0ZGdyZjJzQ2pCVFgxVmZRanRhbUpnaWRQelNtSy9STXdLL1Rwa3hzeW1h?=
 =?utf-8?B?eVY2czN3VU9mYm1kbFNsUG1DZ1BrWXRVbGM5OElXbVRTT3lISVJNYU0xcHJZ?=
 =?utf-8?B?N1Y0NjJhL2ZqN3ppQWZKdW1lUUh4WjdaSGVJU1EvanE2NkZQbXFxeUd0UXRu?=
 =?utf-8?B?REh2Yzh2NHJXeEJMNWgwL3dnTi81RXQvdEtvbFFLUUg3ZlM3VzU4N1J4RTVY?=
 =?utf-8?B?dlNWVU9ZUnFsK3IzYWZjOUptWmVxcE1mTFNtMDlPNHdqdmE5dHZTVHMxdXJ3?=
 =?utf-8?B?NEF6ZlVaM2Z2ajRJbjc1UHFDci9XN1ZIZ3FNWFZFRFA1RzdWMlVVeVp1ZVZz?=
 =?utf-8?B?dFFhTkRCZmJ1U21ibE0zbTZudGpNay9tc29MRzhxdzI3Y1J4dm1rNW12angy?=
 =?utf-8?B?U0k5clB2TVJ0Q2NlWUxGa2tlaTEyY0U1L2FyZThibjQ3dExtaXRqNGFxd1hI?=
 =?utf-8?B?Nk4vK0VpTE1zd3dHN25XVEpoblJ6SnF1bTczT1pJYXY3bTA5OVRnd2FNcm1F?=
 =?utf-8?B?U1JjNXArVW9SaU8zT1NBWnBEdzRqdGhDVVg3eTdwQTIrRktBY3lOK1NCbE9y?=
 =?utf-8?B?MFV5TVpnMHJqcDBPb2EvSy9wYmNYbHVxWnE3VzNlUXdENU1Mb01ZNVZHOE1y?=
 =?utf-8?Q?+OIgFoKDBYBNjxg8UxCJrLw36?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e21804-943f-4861-6181-08ddae74c8fc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:31:17.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LCYdDqc+vE52wdJBxBjZwfyJDa0lHEHnzJLDIoXcz+aI//Q6pZDrYL5OBl9rXFuxOX3Nc6OwB/vVpjOfYSPPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468



On 6/18/2025 2:06 AM, Paul E. McKenney wrote:
> On Mon, Jun 09, 2025 at 09:14:42AM -0700, Paul E. McKenney wrote:
>> On Thu, Jun 05, 2025 at 08:45:19AM -0700, Paul E. McKenney wrote:
>>> Hello!
>>>
>>> You remember that WARN_ON_ONCE(nr_retries++ > 10) we are looking to add
>>> to the __sync_rcu_exp_select_node_cpus() function's initialization of
>>> expedited RCU grace periods?
>>>
>>> e2cf1ccc99a3 ("rcu/exp: Warn on CPU lagging for too long within hotplug IPI's blindspot")
>>>
>>> Well, it triggered during one of 14 TREE02 runs yesterday evening:
>>
>> And again in TREE02 today.  The usual distractions have prevented me
>> from doing a long run, but hopefully other things will settle down soon
>> and I can get a better idea of the statistics of this thing.
> 
> Yesterday's 20-hour run got one hit in TREE02 and two each in SRCU-L
> and SRCU-P.  Which might be due to a guest-OS migration event.
> (The rcutorture runs are guest OSes within a guest OS.)

What was the jiffies value that the exp GP got delayed? As you mentioned, it is
expected to be short, but I was also wondering if nr_retries captures the impact
as well.

> Except that they all happened at different times.  Besides, the system
> subjected to the migration was orchestrating the test (via kvm-remote.sh),
> not actually running any part of it.
> 
> Well, time to fire off another test, then!  ;-)

;-) There's also another IPI-related issue Boqun was seeing. Basically, if the
CPU receiving the IPI was not responsive, then the IPI-sender should just give
up instead of stalling the sender-CPU. Chances are, if they didn't stall waiting
for the IPI to be processed, maybe things would have smoothed out enough and the
GP completed due to some other reason anyway?

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
>>> [ 7213.736155] WARNING: CPU: 4 PID: 35 at kernel/rcu/tree_exp.h:419 __sync_rcu_exp_select_node_cpus+0x23d/0x350
>>> [ 7213.737487] Modules linked in:
>>> [ 7213.737907] CPU: 4 UID: 0 PID: 35 Comm: rcu_exp_par_gp_ Not tainted 6.15.0-rc1-00065-g11ef58d03471 #5265 PREEMPT(full)
>>> [ 7213.739348] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>>> [ 7213.740845] RIP: 0010:__sync_rcu_exp_select_node_cpus+0x23d/0x350
>>> [ 7213.741675] Code: 01 00 00 49 23 86 70 fc ff ff 0f 84 1f 01 00 00 4c 89 ff e8 55 b2 ee 00 bf 01 00 00 00 e8 bb aa ee 00 83 7c 24 04 0a 7e 04 90 <0f> 0b 90 83 44 24 04 01 e9 61 ff ff ff 83 e2 fc 89 95 60 01 00 00
>>> [ 7213.744176] RSP: 0000:ffffa4a540163e68 EFLAGS: 00010202
>>> [ 7213.751921] RAX: 0000000000000000 RBX: ffff89b45f56c900 RCX: ffffa4a540163d64
>>> [ 7213.752896] RDX: 0000000000000000 RSI: ffff89b45f51ac18 RDI: ffff89b45f51ac00
>>> [ 7213.753865] RBP: 0000000000000005 R08: 0000000000080062 R09: 0000000000000000
>>> [ 7213.757852] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000003
>>> [ 7213.758847] R13: 0000000000000004 R14: ffffffff89563e08 R15: ffffffff89563a00
>>> [ 7213.759842] FS:  0000000000000000(0000) GS:ffff89b4d5568000(0000) knlGS:0000000000000000
>>> [ 7213.761176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ 7213.762173] CR2: 0000000000000000 CR3: 000000001de4c000 CR4: 00000000000006f0
>>> [ 7213.763402] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [ 7213.764624] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [ 7213.765838] Call Trace:
>>> [ 7213.766271]  <TASK>
>>> [ 7213.766658]  ? __pfx_sync_rcu_exp_select_node_cpus+0x10/0x10
>>> [ 7213.767616]  kthread_worker_fn+0xb2/0x300
>>> [ 7213.768256]  ? __pfx_kthread_worker_fn+0x10/0x10
>>> [ 7213.769049]  kthread+0x102/0x200
>>> [ 7213.769596]  ? __pfx_kthread+0x10/0x10
>>> [ 7213.770238]  ret_from_fork+0x2f/0x50
>>> [ 7213.770862]  ? __pfx_kthread+0x10/0x10
>>> [ 7213.771524]  ret_from_fork_asm+0x1a/0x30
>>> [ 7213.772175]  </TASK>
>>>
>>> TREE02 is unusual in having not one but two rcutorture.fwd_progress
>>> kthreads.  Although TREE10 also has rcutorture.fwd_progress=2, I normally
>>> run only one instance of TREE10 for each 14 instances of TREE02.  Also,
>>> TREE02 is preemptible and TREE10 is not, so maybe that has an effect.
>>>
>>> If this is the way that things are, we will need to use less aggressive
>>> reporting (maybe pr_alert() or similar) and reserve the WARN_ON_ONCE()
>>> for much higher thresholds, like maybe 100.
>>>
>>> But is there a better way?
>>>
>>> Or are there some ideas for making the initialization of expedited RCU
>>> grace periods be in less need of repeatedly retrying IPIs?
>>>
>>> 							Thanx, Paul
>>


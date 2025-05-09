Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE3241697;
	Fri,  9 May 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817657; cv=fail; b=DMSiIV6KaR1KKyRLeb0zwpPgk8Id0oBu2C6ZRZ1Ke0hkXRpYIyNDq2n3cCeYpXLKDvoxh14UxT/dSolrsSUzY3tP2jEeRE3PvUgR86PTfgM9iV/3RyoG0V2fCTqwOpWVIo49Ylu2Ay2lVHiXyYajZ7ITEB4xR+cZVWwvn8Dn9aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817657; c=relaxed/simple;
	bh=zLHimvalki63b9Ndvyw9bQPjYnWFuWrK9hlFMrUksfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mcDAJ2zDRNaj4mt0xyPNsNaY9suYdP14OMVAV91FZ3T+WrL+wa6IEOO5zW3SUO4tgGX9ruygZh6I/94C+/LWuVVxSGIW+76yU9RV5qOHbwxY8LvlbVxfZJQozBBNhHDo6yWB3sqH69IKnArVdLqem4hT4l5QD329T2Ln4P1mXA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A+tn1j0S; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A+tn1j0S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYS9B9GWLuCPGfFrzuHrggezWn5PSAAg1W6TRk+0w7TBvHB94Ss3ynViT42J/bTCb7vpbvuxp6pzBMLTTlwB5ejC4yREv8nQ+D0cXJUhfXvS9rxAeX2xhPKHeTkUqr3AVWS+NmKrfKwhf7jvJpfp2XXcVDekeGyhT5aLjtZP1fIM/QQ+MhIl3ve3eRrdKbmNxCRpG9ri7MgAqGhvnk343koaXGoPWSwXABeF8sq2jvAbKCPK4ckPaDFPJwHgqmzo8iyY3jUsXlIjbzePp5CC1wKZDUMog9tkD9FgDg4p5iecPaqnsYAJHmQrDRKq6XfdbUouTnoEWpcwDwNQf6Jexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uvb2ZBeo0Ua8Xtvgqn+JrP6tyMMn7nZPj+v6L/Ov9Cs=;
 b=WCU4ptVwAfXNlX1SyPnIqIuykQQraBjuE9Rd+iqGBoH+LmDWRdHx4dhnFASCs9kuXFnVY/b3mjG+3PYyUmgM5Fvjl0p5srWXMnwlOKXum/f9zWW0qr8fCM7JuNSYioCkSa74op3894hGOwoXab6oLJORYMz7Kzh/7k8IYxu68t7LjEOD6q45PatrhsEFPTL3F2ZhRx9AKrHF8gbwZb+eTUJOxr2SBBQWdeOg2clkCFqzbEBpDKTrlTgknZ5hZ69AA657AaBokN3Dqgc+HyzpupBI6QZPSII2TOGMLqbUF8S+Dstkj2HJEaUOYZWrZOMVoG41waqSajqGaHnR7I7ALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvb2ZBeo0Ua8Xtvgqn+JrP6tyMMn7nZPj+v6L/Ov9Cs=;
 b=A+tn1j0SPThBUoRC9L5nEhwpQw5DXsyLLjKX6yQ5n/8s7Iz7gDmtpxfCi0P7zYI/g9e5sTngjlsWNFzH8Ec+kIpZe4Xd6KhGeC9qxJF20x6Dl4liuQYWzeQGn3n61fPDEwlJ8GVkg0RXYvqBGj95655CLLhqJX+N/d+8haYznbXuofCGYWiH1mh6H/6TYwMfM1Ibb4iElmX+ce+zo2MNXGFULZVk0z2aOKgnEAXsNU2QAaELXJivm+k41DjWlV3tvDwAyIF4/Jhst9P2a92KJpXSu3UAeQe45omM5o4A/DRKyFYjim05cmx6Srx0ednuRWJ2jaXuz9fDTcAvnl6Adw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 19:07:32 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.035; Fri, 9 May 2025
 19:07:32 +0000
Message-ID: <23f488d7-d369-46f2-8da6-c5fd2af0f9d7@nvidia.com>
Date: Fri, 9 May 2025 15:07:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread
 pointer access
To: Zqiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 urezki@gmail.com, boqun.feng@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-3-qiang.zhang1211@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250507112605.20910-3-qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: cf69fed6-e252-4832-71c2-08dd8f2cc058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDcxRTVuZ1k2NVhVSGFrYkJPYm5aZWpOZEppZFhEcHdudjEyRi91VXp6cDEr?=
 =?utf-8?B?YzZYUHBoU001SFM3OW8zUXhOSmhHYTIzTklJVWwzMHJhV3puL0ZZK1FZRjRH?=
 =?utf-8?B?bnNqZ0g3ZE5rTUtwZXE1Uy9UaWZCV0pBN0lxWGFLeUpyN1NiZHdqVUVCMUJy?=
 =?utf-8?B?VXNMandZYis2RDVBblZGRVU1WVNxUEhVZlBGb1ZTMWRZV0JURmxyOThTSlBo?=
 =?utf-8?B?Vy9SNmUyTzZqbDJLSkk1bXRNYlNxWFYxbzZNR2hzcG9tK1Z0eDEyNG1hcXFU?=
 =?utf-8?B?QU5MaFhzYllFWnoxTlZSMG9FNGVVMHNiQmNZbXl3bDhicFozQVJOVWZCbWVE?=
 =?utf-8?B?MEhqNEY3VWQ5STduYWI2SjJJbFZ3UE9ENmorc1BtY0ptbW1uUktBT3hsL1B2?=
 =?utf-8?B?c05VeXNLODZpM3dKSFcyMWl3L01zSmdEaG9SQzZOWTFjWmVlU0VKZGRiUHNw?=
 =?utf-8?B?bUpIVTRsZWJLNVhiUXJWUkY0VmlmdEpxUDZRcWhwSXJSSEZWUVdQTFBXYWV6?=
 =?utf-8?B?SnpiTEFGdnUxSGdSQnVZb2pBRjJSb2JUQnFMR2x6L0FFSnlzRmhTQ3FGK0ZU?=
 =?utf-8?B?c2s0THJCelFlY1FFVVpjdzhnWFRDWUNvVWhFbGZlRjlzcGJaWURnQTRDa1NX?=
 =?utf-8?B?bFB0aWdwMGhPL2J4RDRtOVpJejQ5RWhnUHR3Z1RXVW9tWUlvNmVyQWpSWVZt?=
 =?utf-8?B?amVVamVjVWVsM3cwdi9zK2gwaVV2d1VkU2c2aEREQ2p1Nkl3VkNEeGtnTUdr?=
 =?utf-8?B?djVQNWhSVmZKWktvbGU4YnRJWml0UHdKTk04WFUveDhOZkNaL3Q4cTNDL3VP?=
 =?utf-8?B?bG1SSU10MjNPcUVjU0lQaldUSmNaNUY0d2ZlUVNKQlFoUnV4bFYxSDFiUnJW?=
 =?utf-8?B?UmdYbGhkTXAyQjRsV0paQ09iU1l4Qm5LclQ5d1AxT0Jxa1VRUHZZOHk5VDVG?=
 =?utf-8?B?UjZVZ1o0eVRkZzFmcjdicHRIVkFkNk5odG8zTVNpNlA3MnJ1RmNkUHNBckVC?=
 =?utf-8?B?RjFnTEJYQzB5UHErc29zOGc2Wk9aSlNOejd1VTZRMmZQZXVlMVRDRUdLVm5P?=
 =?utf-8?B?OTRFL2tnRVpQYkNxa2VwUEh1Z25JTTdMN3BnbTczMjlJVm16VHczLzlhRDNt?=
 =?utf-8?B?NWowVHNIWmZDTW85dTBNSUJxdklxZjJ1eGh0dllhN242UFhnZUZBWE93K1Np?=
 =?utf-8?B?MVkyeDFWUEpBOGtMd3NXOTlDa0piTmxhdkhzQzcyM2Z3dW10WnZSSUN1NlNU?=
 =?utf-8?B?N01lYXVLQzRhSCtBRHFacm4ySk1tVlIyd1FQeHV5eFU2VjYrWHFvOVFkeHhH?=
 =?utf-8?B?ejh2Q01NdGJFMUlQRXZYdWJ2cW94Q1gvdlhOVmFtSm42TUlrZUhWZkx4ZTNC?=
 =?utf-8?B?TU5ZS1ZjalFlamdZa1g5MHlQMWJvSklZSU15T2NiY2NSc211eXFJc010ZmNw?=
 =?utf-8?B?b3BRdTVOYnRXRHladEIvRldoUXFjTjEwT2lESkt2Mko0dWszNFo2d05iS1Nv?=
 =?utf-8?B?RU0yRm90Q25Jc2o1Skd0bUE4K3o4aWFaaWJyUEFoYWIyZVNYRFR0WGtTSkQv?=
 =?utf-8?B?a1JqcW1TRCtDSllCMEVTMzl2dTl4T1pEM0ZKZmwyWEtJWjZPTlRRczFqVFF5?=
 =?utf-8?B?aUxTbTJ1dndQV0p6U0hDbUtPc1A5N0o0WE9zVjlrZzZYSnRDbzNlbFhLb3VW?=
 =?utf-8?B?cVd1bHZBcldnakJPaGtmYVBZSGgya2JDc2lOMVppeS9EaFZQRHBZV3BYY0E1?=
 =?utf-8?B?ZzU2QW9BR3BUYXE5VUE4VnVXbHRPb01ibHYxMmtneGdsYWFMS21rOXpxbnZW?=
 =?utf-8?B?RzVNVFRBWE5peG12VW1HNXROdlo3YVptaGZ4OTNaS1oyeEIyekgvbXk2YjhB?=
 =?utf-8?B?dXd6bmRWZ2ZLaWJzdVBYamNqVi9PNkQxV2JJY1ZhZXc2T0IxdzFpQWpOVTgz?=
 =?utf-8?Q?b+1wVS/BeCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlQrWGpTOHJMWkh6Z3JaejNycDZ3N1FjY29PNzRIci9nREtNZXRKZkx6TE55?=
 =?utf-8?B?UUhUK1djREhxSmY4cVh6d2JFa3Y2SDlTT1h3VzlZcVg2ZjdvTk8veSt1Mjds?=
 =?utf-8?B?ZWlqWE13MHB6eUV4NzdQMXBWZk53amZQc2FmeUY1emNlcjR5aTdBWmZsV3lS?=
 =?utf-8?B?U01vN09ndHl0cUlGZnRVRFpZTlBndzJVSng3WllYTHljNTY5V0FFTFR3TFRm?=
 =?utf-8?B?azhCdUZXVHcwVllvMVJ1QnhyRnU3cHdneWJzamh4bXFYVFJoMmVJSW5wUFU1?=
 =?utf-8?B?VUpPTEpyYWdsSkNRaXh5TlQ1bGpFZk8rRG95TTZCVzF6NkJqSGlON3FSSnJW?=
 =?utf-8?B?bWdqR3U4dk43YTcranVlVU5BNllvZWlPOFpZVVhjZktJWkF3N0pEZmxOakky?=
 =?utf-8?B?MC9yeEw4aXhOUnRBa2E2dFNGUlZndkdab0w0djliMTV1RElCbTNLUm5yb0RN?=
 =?utf-8?B?Vm9HVEtNWm9FWWV1YXpURHg1RDZjMTh2SGpFY3I5eit1WC9xZkxGbGhpOVhn?=
 =?utf-8?B?MDBuWTU5UFJlVjJpME9oSEhyclhEcHhSeGovdW02YVRJQ0pidldwQWhsNm4x?=
 =?utf-8?B?b3haRERvcFo1K1ZkUFNrbmhkcTRxVjRCL3JGUjAwNmczOHFuckV6dDFVNUxn?=
 =?utf-8?B?NktVMm5YUXlIQXo5QUFlQUJ6bHdpMlNYZTNrM3VXL0dhSFdraVJMZmtudmtq?=
 =?utf-8?B?Y3BxMWc3dmF0RnR0ZGh3NytqcVYwcDBORzFRL0paZVNXRDBIcWdNKzVLUWg3?=
 =?utf-8?B?NjgzZXZCbGtNWWIzbGE5ZmlvQjZGTTZqQ1o4OEt6cThEdUo2WXB4MGV5MU11?=
 =?utf-8?B?Wm5zU0QvOXlBdjkzNmNURVRLRXFGemZ3TkNTUFVwUzFkK212YlBOWWVoVE53?=
 =?utf-8?B?Y1hKang4aXF2M0tkS0dPZHFRZmlNZC9kdC9adWNJQjFEcUloRXNDUlJxa2R1?=
 =?utf-8?B?dm5KSEwrRXFxNk9zRWZ0MWlVSmdvVGZ5aVQvVmN1bU1EZm1WYU1mSUwxUkhN?=
 =?utf-8?B?ekljNVB6dmF5KzlPUllveW1xbVEreWNGczZPNmpHajhyc2dtVEIxNnJEdis2?=
 =?utf-8?B?OUVqTkQ3NjhzdkpXSGpjVEVjZm1DcmZnWHg3QjVzVTFvQWNVVHhjNGZ2U3kx?=
 =?utf-8?B?NDFHM3pxQUlzRElnZDFlVnF0Y0ZVMVJiYkNjZ0NLSU9lUG5DcVhGRTBzT3l2?=
 =?utf-8?B?WmZSQzVFWG9SNkJrNjROVlFjMkZQRVV3emdUUmd1d1dhalRPTlpmbTVUa1ds?=
 =?utf-8?B?VkxheTJqa29yUk5KTzFVdzBHZzdRalFvRTdabExaYmhZc09XY0t1bjFPOWJW?=
 =?utf-8?B?a3FnNlRpYVZrdnpjUVNHSzRvVkFNVTJGWW1VSEUzYVcwdEVtVGRKQzZoNnVQ?=
 =?utf-8?B?Sityald2bDE5ME9rVW80amp5aXVzd3hrWUIvYWdXVjV4N2NiZUlCTFIwNVpB?=
 =?utf-8?B?NllTZEpveUd4Q0FhNk9DeisrdktRcWxpTWRwa2llL0hsU2QyL1dEU1Rjcnp1?=
 =?utf-8?B?RWZVbjBpRS9tMVY1eGtPWmVOSFNSNU9mNk1iUVNSV2VlQ1pRTnNaMHhNWXVw?=
 =?utf-8?B?QzlOaFYxVXhDUkRpRkc5VkhLYnJZdWR5Nk42VG1VaUlvTFZSS2krbm16Yk5G?=
 =?utf-8?B?N0ovak0zK0RIS0Vvem1YYW9jME15ajZzbHAyN21yV1ovNzFlZUVTaDNqbUJ1?=
 =?utf-8?B?SDR0T3I3SWlaekk1dm8yT1VXcHhJWE56Mmwyc1hRb0krV2RnbHpmVzE3YjZ6?=
 =?utf-8?B?RmNOK29XNk1IL0g2MDBqeVlVOUZNVDVZdnpxZ2M3Q3ZVTEpTSE1zWVkxSVR6?=
 =?utf-8?B?RHJncCtOWkRTcEJ2cUVvdXp4RjFoMXNINzR0SUZYeStlMWQrUm9xb1lHWWlF?=
 =?utf-8?B?Q3AxVDIyUitPaEZ4Y0ZTS1dxT2o3dGhBc3FkcUxoSjMraTNQYWVGRTNvNkt5?=
 =?utf-8?B?eUFqNHFoZHY0enY3ZHFxMWZnVkFSN3JacndBa3pGZm02aGdlWHo2MnczNjNZ?=
 =?utf-8?B?RWZwdW9OM2lzTzdRcmNMNXpkak5WOVJ5MzRjSE84RVFKM2krSlF3M3R3VlM4?=
 =?utf-8?B?TnljMnhLV1ROUEU2V0xRSVA5bkZraC82cENlYkFFMzhKbng4dFNTbURGZFQr?=
 =?utf-8?Q?Mf9lN+SyUFHEbCbCOvbqafMQj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf69fed6-e252-4832-71c2-08dd8f2cc058
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 19:07:32.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiFHAPrECB+evJOm/M0jE/NUNl8NFEqih1okafHtvXr2QRlkTsUE8AIQ8AgxBwM1Lj1GlvWrFyg8T2Ox/GuiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396



On 5/7/2025 7:26 AM, Zqiang wrote:
> In the preparation stage of CPU online, if the corresponding
> the rdp's->nocb_cb_kthread does not exist, will be created,
> there is a situation where the rdp's rcuop kthreads creation fails,
> and then de-offload this CPU's rdp, does not assign this CPU's
> rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
> rdp's->rdp_gp->nocb_gp_kthread is still valid.
> 
> This will cause the subsequent re-offload operation of this offline
> CPU, which will pass the conditional check and the kthread_unpark()
> will access invalid rdp's->nocb_cb_kthread pointer.
> 
> This commit therefore use rdp's->nocb_gp_kthread instead of
> rdp_gp's->nocb_gp_kthread for safety check.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Is it possible that rdp_gp->nocb_gp_kthread is valid, but  rdp->nocb_cb_kthread
is still invalid (because its creation failed?). This seems a bit fragile to me
to assume that if rdp_gp->nocb_gp_kthread then rdp->nocb_cb_kthread is valid. Or
is there a path that makes sure this invariant is always satisfied? If so, can
we add additional warnings for checking this invariant?

Also from the other thread, it sounds like there is more work to do here
(related patches so I'd like to defer this to 6.17 - feel free to keep posting
patches for this work though).

Thanks!

 - Joel

> ---
>  kernel/rcu/tree_nocb.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 1596812f7f12..6679140bb0b5 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1146,7 +1146,6 @@ static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
>  static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>  {
>  	int wake_gp;
> -	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>  
>  	WARN_ON_ONCE(cpu_online(rdp->cpu));
>  	/*
> @@ -1156,7 +1155,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>  	if (!rdp->nocb_gp_rdp)
>  		return -EINVAL;
>  
> -	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
> +	if (WARN_ON_ONCE(!rdp->nocb_gp_kthread))
>  		return -EINVAL;
>  
>  	pr_info("Offloading %d\n", rdp->cpu);
> @@ -1166,7 +1165,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>  
>  	wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
>  	if (wake_gp)
> -		wake_up_process(rdp_gp->nocb_gp_kthread);
> +		wake_up_process(rdp->nocb_gp_kthread);
>  
>  	swait_event_exclusive(rdp->nocb_state_wq,
>  			      rcu_nocb_rdp_offload_wait_cond(rdp));


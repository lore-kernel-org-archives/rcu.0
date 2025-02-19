Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F01F4608;
	Wed, 19 Feb 2025 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978955; cv=fail; b=dnuAZ0zw8MVer34brDXo06J/sRR2c4ayycKwc7CSnLKP2Njr2/JgOgRoQLMy4WbmjZXMwwi8qlfOxEM6+GYPD4iqa3pgZWBdITl396kvgAAv+3Fwhdip12S14ZjK40uaw0Fjet9ZyScw+afMj6mGqLIl6v2tIFkltAV5YzYiEB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978955; c=relaxed/simple;
	bh=EvQc5SDjqI+f1F0034STJ2NceOjXJFhgI5alTyjN1Wc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nn/Cgd7C3tT0wm+EtCNUTkv1bVfpZ4ArEQQlorWL/RAr4fH3hhXnF2e36juBgqmHuDKaJBwnF0WxUU+fMKMXCcUzmOOqErCjOFWyC6xAQUzMxEwBFbpaRLKi0EeW6r+lQiWzlBR5YB8htyOoVCvRAHQJP3tvUrd21y5lbGXyVeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AeuefFlr; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AeuefFlr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM4MOm+mTlUJL67LxgfsqzHKFvl8mA5tHGxLKWuzx74QRjFE7LAMDHPW2m8Ctm1tRUwGWKDNon4cxALgjVxFXk6n571YwTWJoA3Qdyt3olQeKKkJOumXhmRIyy/sCtcFWXcLXJzI2QdqqtRkdyS8Iga7hARCS2dPCXZRpm0KC2gFX9ed1WfibbK03UlWm7YRRwpkO3wJ9JZrpyoi98VX5PAzmt0Xa/JWhWrGWvHpSmEUREa0/BN8CYtaMGTo+9+zUVWo21YEbRODovVj55JEMGz0YPlKSs8hjX6kWKsRQQtnjGuF49Pc5Qc/8zPzEiP6bagWPpRkgSe0ifjY4q5aEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/5n+3vT24XiXjfqUGFQ96zsBfJdKPz8pMOgLJmaORw=;
 b=mmEPoEp802NZk0MNnraw7DZiFmFZqfCCfZrUEUAzVdhk0nt0nIvJFYUWhIQUtYl2ccWZ0Dzx/jY4HFe60dMiSkrNX0bsUsXPolWLlfDe26ovhRCXGyHoL8r7/Cw9L8HAbgOCR+03p5l4BS5djF0Xm+NLIQdpkkLDMMtC7jutw1WkPedgDSPYzWuZD7nrYMWkpYPDAUqQS15H5B1D9qJaxKDpJsADeh6f+L5QH/elrinIk9iIQajY3l51MtLcRrg+OTzTjPAdmKjMxz26s2tcyPdlwHRc0Uucecnz3drB86w8IXTSuWUpfAgKjL5O/kieT6wQiViiu0sMjKRPUkjssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/5n+3vT24XiXjfqUGFQ96zsBfJdKPz8pMOgLJmaORw=;
 b=AeuefFlrqypST1f6x4KWVNx8zVZc72LUJDvMdFxs7NeHuB6Xp4M5QU46tM6T9EmfUZuLLnKx/UeRFl4YRSPviFY/puzUFfAXFipL7Mxy4gbbmN0WLG9tbosZ9qYzk/5T1yB0/zmbEzcnk9WY0UVEmBe5zUpmc8UB0lrFmNv8C6L/WSZiNCctMp36LuBPOZn/BKM4cjS0lKK4KgbOi2IO00Jf0Q2q6S1gavjwvbm4fgba00vApHYK1Ehc/vTWsny9i5YggU8tPc4bOOARuvii3Ru1e5OSsdHnUQd35tbKvW6k9SaOQWoWGaNS97uiS03Etx6s7/THQ8YcOyZnwtfDiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 15:29:09 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:29:08 +0000
Message-ID: <0f7d2b4f-3415-4764-9569-379738d6c599@nvidia.com>
Date: Wed, 19 Feb 2025 10:29:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Joel's email address
To: Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
References: <20250219125425.1175676-1-joelagnelf@nvidia.com>
 <49abc218-cad3-4913-a729-82e5aa78a0cd@paulmck-laptop>
 <Z7X2NtrfcYslZ8UU@Mac.home>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z7X2NtrfcYslZ8UU@Mac.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:408:ac::44) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 585e6a51-c71f-46e9-fe02-08dd50fa2731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1YvTDd0UU9FY3drVXdQcXBIR2tIZGZpQ0JGR0NIQjUwR21Ud3l0dzFjQ0Rv?=
 =?utf-8?B?alh2ZEhzOGgxdGVzbytPeG1zcUs3dnY5c3NEb3I4V0ZGcjR2a016YWd5ejZT?=
 =?utf-8?B?WkRqcWNpaVJHL2ZnRnlVaDUxMExydkZjSEVxSjE4cU9WMjNhbUtwZFZob2dO?=
 =?utf-8?B?aXpjNGk3Rm9nb2s0TFc4bTJRTHk2SDhETDl1a1dGeHZTWndFbFllVlUyS1hT?=
 =?utf-8?B?V0hTZksrZG8xWEtDV29ERm8rQTlwUjBnaUpwZmVMSURianp1VlFPVk1Qdkd2?=
 =?utf-8?B?Y3ZaUFN4bWxNSW1xbzBvUjRxd2lsSThRRkpOekdPekord1FjMURrT1FVSTVk?=
 =?utf-8?B?dlc0UGVJQTNQUU1XRDB0TmhCazZhU1ZyTmxqeG1VVnc0ZW5IZlpNQUFFVUxM?=
 =?utf-8?B?eXJPK2R3TzRFaUJ0czVVcGMwd3YzbjFsRFJUdlgxTk5sQnBOcW5pN1hxOHdL?=
 =?utf-8?B?ZmFsaVRJNlY0WEcxVEtEVEFtc0pzY0NRTnpZWmJlOVAzeVlrcjhtdkR1ek56?=
 =?utf-8?B?eXcxemRLdlFFUnQ5R1lXR2w3blpzcVlpRXFRbFdZK3VLQVpBVENIdUVRck9p?=
 =?utf-8?B?QUxYSHhSMmZEODRRZ0Fwcm01K3h1bGx3eThSblhEUVNwOTROZ0pHeWlFOUlI?=
 =?utf-8?B?MFdzcXFWUmh3RTNCU21ld01kdUc2d2Z5WjVhL3FpbGFUZm1RdWZxaFVOb3Q0?=
 =?utf-8?B?VWU2YUFVV2QwclBxVFNyWnpub0lMZ0JBYVNwcVhxRDVUbTRBS3RNbVhEOS9P?=
 =?utf-8?B?aWtnOVdQTWxxSU5sWEdCOHM3b3hZV2xlVGJBVVAxblpRUGpvSHZ3bmFLckQ3?=
 =?utf-8?B?S1lGN3Vzd3NlZ0F5WnB5RzRmTi9aR1hrNnhjRjNvZ0ltcUNWeUFvSDdwb3NU?=
 =?utf-8?B?VDV4WE5VUDl1bVFQdjlPNmdkMWlJSDRpUXpIcWJwSkk1UFRwSHA4SlB0L0xu?=
 =?utf-8?B?K0JwbFBPcVYyT1cyUDdJWk9kWXpyL0RHWE1xTmZIbjlHMTJRVG5qalBPVEZr?=
 =?utf-8?B?ZWswRVlWMkNteHpwUVVOU0toc3o5QWVEVEJ3cXhjUDY1S0E4N0NaQzhFRFRF?=
 =?utf-8?B?ZGVNVEF6TWl5OTN4Wkh5VHdMMzBhMEp0ME5YMXBaY25ZbnQ2Rjl5RTk0ZmRS?=
 =?utf-8?B?TXB1eml5MzBrMGhCWEFXOUJnYWRycnhoVTNvWlhkenIzdHR5R2ZnWWdMMDFz?=
 =?utf-8?B?WEFKMmFFQmljOTJEZExRY2FyclhWbVVMTzFPZzFSTWxLT2J6UmlGZTJuRUsv?=
 =?utf-8?B?UWFVQzZHa2tCMlBHUzZIWTJCRmtZeTJZeDhoSGcxc0I1NlIzLzhxcG9sQmxG?=
 =?utf-8?B?ZmZaaHdJNWZoUmdPMzNXSTg4b0ppeWt0cjBHaUlDV0l0Y1ZZaWdLb1d6dzZp?=
 =?utf-8?B?N2ZNWExPTmZuWGE1YU5jQ0Fvd3VOSkQvWDcvSVR5MW4wdy9jVHVEdkdrVkk4?=
 =?utf-8?B?anpCWVYxd1AvdDNXU29PQnZWbGxjZmVYQzg5VnVSazA1MVFvUm1pR1RldWx1?=
 =?utf-8?B?K3JzTWY0L3hrS1A1YXFUR3VuVXZ4TEtiZUxic205VnI2R0hudTlzZXNZSlFy?=
 =?utf-8?B?dmZhS0dPNFJ3Y0JtYUJHWkt1Z3o2MUFMOWtOM005YzR4NmhkZk1vQ0U3cTMz?=
 =?utf-8?B?czZBdzhYWEVNSFRCVkZDSUlVQ08rc0dPNlY3Y090UndUYnNnc0NyQUUzR1M2?=
 =?utf-8?B?TWZBVlNtRVJJeGF5cy9WVXF5citUT21TSWNScFFIbHZWQjVld1JoZFEwUVBD?=
 =?utf-8?B?UGM4bFIvc1J2MXRqRWxhTzd4SWdCb2tFU3BJaWp5Q3A5ZkJIcnRUSHBRRjZq?=
 =?utf-8?B?Ri9QaHRJaENsa2pRSERDY2gyNndhQjUvZkQvd0EvZm95VU5DbnFGb1lKS2pu?=
 =?utf-8?Q?a66WFFVvhbh4s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXplNmdOQzVYSWxWaHg5OUs0YVhndlFOMmtkYjBHQ0V4N1c1Vk1NdmN5U1A3?=
 =?utf-8?B?R1BWVDlzVnFnS2JvQ0lGbzhwYmU2aUhWNmdqOEw3a2tLcHFKRjdHbVhTOFBk?=
 =?utf-8?B?cEJCaWZaNlVVaWhrc1NzdTdlSzNrbGl0cERSek5wQnd5OFl5VWpwN2RVMXQ3?=
 =?utf-8?B?Y3d2UW1sRFBmTC84dmpCVXpFaVJ5ZkRMbGsrVFhYNkZGR1VpZ1JGckdKOTV2?=
 =?utf-8?B?UTkrbVp4dng2a09VT0pZNFZKRVlocjRYdGx2aFpwUFNFN2dBSmMxcy9hMjlw?=
 =?utf-8?B?VDd4aDI0L1RQemh5OUR1clNBVzlBZ1BXZTBjdHNzSHdPYXdUWm5IRXg3cHcz?=
 =?utf-8?B?NHBzM1ZEMkF5Q3NBWDlKa1F3NTl2cDdGQ2gvUFlCSXJJK3huTVlSOW1yUjRu?=
 =?utf-8?B?OVJqU2dZZ1BvL25mTDNyWXM2UEpDVTVyRkVQRGlZWW56TFVRdXAzR0s5S1Yr?=
 =?utf-8?B?WEFCWlh1cXdKcnZ6QzJ4NTFaVEhmQU5oRytmMlhzMGQ3ZXZkcTNJdHZKaFg0?=
 =?utf-8?B?U2xpdjl3MEhSVDE4N1RnN05JVko0Tzk4S0hMNmZNSU9valQyMUY0ZGozNVkw?=
 =?utf-8?B?M28wUG9hamJVc2M2QkpLSHhLVGlmd3JxejRVZVQxMXU3MWFiUDFWUmIzd2hn?=
 =?utf-8?B?NUkwQml1V3FuMXZiVjNocWV4NUVCVEZuK0xOMVJ3ZmRwTGRoRnpTUlhRS1JE?=
 =?utf-8?B?dE04Smx3eUMxcVA0ck5GTHlmSFY3UHFUWGl4SUwrMXd5ZFI1eFZQcUIrUEFx?=
 =?utf-8?B?b0FNUURhM1lVNXNMdzRFMXNaL283VEdFNk5UL09VVHV5RWFvZS9ydVhURUVD?=
 =?utf-8?B?bFFOR1NqL2FrZ1BPajFzVG1UbWFwbWxzMW5BM3UwcnVRWGM5aWtueTN1d1pl?=
 =?utf-8?B?Z3JFOTZJa2pIL1E2SFhDakw2Y3pEY0RGWCtYZnZBQXJuTGlEcnJBUEZkM1pV?=
 =?utf-8?B?bVRWQ2tjVCs5SEUzajdLdUx4bkdmbzB0MDlFZURsWkN1SzRORjZMdUJadGI2?=
 =?utf-8?B?aWNrZHN3MGlSNHh1RU9lTEYxd1JnVFBNTG83enBXaG9MM2JBV2FzR3RZVVNW?=
 =?utf-8?B?Z1lZWGlUOWgzc3dWVC96UkZhdVdsdmxvK3E3dm8wcVZkQ1lHaUk0aXh1bEpE?=
 =?utf-8?B?S2ZuUUFtbzY3V0ZWSnBRejIrb0F4MENRR3JCTUhtRjZwakNRK1MwNllxMlFD?=
 =?utf-8?B?UGs5THFSL2NwSHljNnd0SW5KQjhtMmdoSGJ6cWZSZDhNOGkxekVucEV2VjU0?=
 =?utf-8?B?Vi9KeDE4M3NFaVQ3UmtHUG9nK09kUDNoYzRldG9peWtaclU4UUtmOUxNeWRk?=
 =?utf-8?B?clNMTGgyLzFhaExyVGxyd09wWGRQcWxxQi9XVU1mREgzVDV4SDZUNFJOSUlT?=
 =?utf-8?B?MWVxa0JBbHQ1YTdhYjJkZHNpSWlYU2lKbzFUMk0yU2xhK3RwNHFEOFFZUFll?=
 =?utf-8?B?WFlpOUR5N2tkNnQ5WXJ4WHNYTzJIbHhDL21hQms2VGpKTForUHR2MWF6Tk5w?=
 =?utf-8?B?TFlKT3ZHTnhUYkJUVmpJNjhzTTV0dDNvU3dHUmMrK3QxTTFzcTdBWnEwT05l?=
 =?utf-8?B?bWNMK0FkMGphaTNWSjVKRHV1dU9sU2NSQ2hQVldVZzVYNkRmMlZ1MDI3QUdZ?=
 =?utf-8?B?UHRkbVM3UXV6MVc1VUh5WVlVcmgrVFBGSkpwSEhPVzBjSzJJTmpJZElKVmha?=
 =?utf-8?B?eXdDdzk5R1g5cXZyODh5RWdGRmZHc0xDUGZZYkt6MVAvZXI5NEErZkRmVXZB?=
 =?utf-8?B?bXpVWFgyOWRvOGdvK2N5b0pZbGJNSzVLSUJnSmc2aDEwY0diQ2ZPdENHUGJn?=
 =?utf-8?B?WGxNcXNrYVVGVUE1eDBTTmpRZEJXYzdpN3JLdDZHZ2NnZ3VZNEp3dHBTZHdX?=
 =?utf-8?B?bHVBM3NjRTZKajl2R2lhdzFVUldWaEJ0ZTkrNVVmeVYwR1RIdWlVYndWYUtu?=
 =?utf-8?B?UzFiMjFFK0xjVVpUV1hReXExdHFjTXV2azBPWWZ5QnZlYlE4TmVLUUJrSWhN?=
 =?utf-8?B?L25ieE9vZjBzUmlFYlk0cHhFOWZzR0RKUEt5R2Rzd1E5cnJVaGJ4d0ZubHdl?=
 =?utf-8?B?MEhuVzNRQ0ordGppdEt2eFZ5SURuOEZvd2FNa0lDeFA3aGZYWVgxZGxocUlT?=
 =?utf-8?Q?OMS9AlynGJNWSJYRV1RmWtXhS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585e6a51-c71f-46e9-fe02-08dd50fa2731
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:29:08.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PH7R7a4PoOZYZWIKF61Ijmr2PV+WEy8W9DQp6ZlJ9QR46Pj+S/5TwWQ3v6XMVk55eAAlFijelY/NFsMDCVhjgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897



On 2/19/2025 10:18 AM, Boqun Feng wrote:
> On Wed, Feb 19, 2025 at 05:23:08AM -0800, Paul E. McKenney wrote:
>> On Wed, Feb 19, 2025 at 07:54:24AM -0500, Joel Fernandes wrote:
>>> Update MAINTAINERS file to reflect changes to Joel's email address for
>>> upstream work.
>>>
>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>
>> For RCU and LKMM:
>>
>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>>
> 
> Queued in rcu, thanks! I guess it's fine for this in v6.16? Or Joel, you
> prefer to v6.15?

Boqun,
6.16 is good, thanks!

 - Joel




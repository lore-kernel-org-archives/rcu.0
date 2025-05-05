Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2B2561AA;
	Mon,  5 May 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452289; cv=fail; b=Bs3GdIr+8L7GXXFNoGOWQoMLCLOdenDBAo1Nm2enrg1beTizQytssG2k+9I3eWoxsAKsRoZGEcu2SKE4tU269TfrIEz3CXWaiepelee8VMEHEvrHUpzdXMYsWDsFR6vC5s5MoGW5wLd9SdYQSu5tS3kLqBCJweq9MaMpOUefAiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452289; c=relaxed/simple;
	bh=90KoVzSWtwOizFZLxsUTdu3MdD9VBc/oIt5g7WoI3E8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j0Z24knK9vbv1/ZHlQQJPKM0xsjKV9RBAa91+kOPLsI4P/Oyn9TOUHX18pZYBeW61mDsm1Ci8eBDzEmYG0JWYm3Xnt271YW6Ao69R2ll/s/Sz0oET2FYSS8gu8ZtG20pzjULnNLLhgBzBqSkSL81alpZdnVPRIp6TYhxLXvA1p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s+jXtMk6; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s+jXtMk6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkgIZaLDKvdNQqSqh2mlN8a0k9mB9jlfCV4W6/ayabe0nyeFvcqPmoQZGbAsR9U/KLwh7Y029MS5UUII1gOs9X4kVX8AaFkcmNENDaLKJiWshxxTLQNL0+Y+5xfKIceDdmpaWcgNOyyySmNkSbrBdPxcmfvvktea+V9gHkJZSozrEwP2jwcKHnexitl0/NzK+SPfss5xvLSgc/1vIy+R+90+566y++6xEqVk30PhvEsF4PLz+oOE/PkUi5KdZ9IH2zNEL3IhpIOWcYBb+K7DGtFDILDBQ4uiM7MdvYe4kVKUwogueP/+mdAFB/asYWthYyFtuoQOFeNTmC4i1UWtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tAC+ZqDqMh4ewtg7FqIYwbavNri5zaMTGxInTYW26Q=;
 b=pEjTK9VrrhmvaEdUeIrocr8Kn2P0g6MQGUMDbJBtbknUd50WpwDVDsKGOwLa9CBe3ddZtyz5kufyMUG7Hl5O4dHih4SXnwY+La5SmcHth/KrvhVK9f2znv+84NrEOTOelEoKmLsHUfCuwRbhQzDO6erea5gicTkK+i2+7jm8/sxb3GBpfEd8c8jaxuiu9c5OJGlaBfhSZFD+1pz2FFPS56TzjahGmMU3fi+efYzWalWuE+CT3Xf8waePmwxnPZhO9nlZEVnCmbgShUDV8qvpQ1ynrAA6ohJnCsEbZETTpSbtWhlJVoUqxCZ4oR+HK4S0IF0GGP/UXQSYYkJwSNHXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tAC+ZqDqMh4ewtg7FqIYwbavNri5zaMTGxInTYW26Q=;
 b=s+jXtMk6M+rBw+WwNlqIXqvkNNmZHeUC5GuoarevsRyaohbAWMFd6qjPf/qr1qwOOCuabl9M3Mwc3JqhygiLfL65bWonFdjiTCHWXl4C0/1/ygaHsNCN8ui8SU8sdIlLpev03WthWA/hrUgZB6Ey6g0ZLS+cD2+//PCIJjN5HC4hG6bmZX5e1AGiX06UMdxC6tHHakWhj8zcHwXcaFdeVTygDrN2vXjNKhcDs2N+ukweMbArtT9guh/FYbH3HnSsgOu2gNDs3JGInMgSLt+3+cgl6l5c9q+s+nR61Fd/VFyQXmzNro0JtUufU7HakEt9hU7yIcCpUjSY3b6A9kHZuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 13:38:05 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.021; Mon, 5 May 2025
 13:38:04 +0000
Message-ID: <6dc114e4-83d3-40ff-9642-114552f40a75@nvidia.com>
Date: Mon, 5 May 2025 09:38:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu/nocb: Add Safe checks for access offloaded rdp
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Z qiang <qiang.zhang1211@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250428095403.22889-1-qiang.zhang1211@gmail.com>
 <aA9U9QvB2t2MLuU2@pavilion.home>
 <CALm+0cW2tXM-HvzoMsNBk4DNyZ-LuUkGj5M4wVLJixSvUDP+Dw@mail.gmail.com>
 <b1d6d155-de0a-4715-9de6-45d3d9e5c9a6@nvidia.com>
 <CALm+0cUx2siBvaRYwWGsN21PC=UUUy1EqLTRe5HmRW2ECWtUWA@mail.gmail.com>
 <2c8098f0-2010-4714-97ca-7f46629d67f8@nvidia.com>
Content-Language: en-US
In-Reply-To: <2c8098f0-2010-4714-97ca-7f46629d67f8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: e26f20a7-f0d4-4e21-2797-08dd8bda1011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHNsUENGeEZIaCtsNHlEOGdvckpJWUZ0MjhBdjM5OXVBaktYRHJGbEkvSUph?=
 =?utf-8?B?NHpoWjExaHlSbzJmTWRjSFZOanJQWG9UbjJCUFJSL3puZno1ZVoxWTlsSk1B?=
 =?utf-8?B?N29MQTFLNnVsdUVieXU1bGYvNnd5MlZXaGJYWFdxYmJYajdYNllFU3N2SUdD?=
 =?utf-8?B?V1lBM0syaVlyMld0clF2YnJ4YzB4ZnpESXo4TzJIQnRoWWM5ZE5Oc25qYlYz?=
 =?utf-8?B?bTZZUy9LbSsvZnZ3VFpNc3JCUzRFQ2xwd1JydzM4K25NRDNoSXJyM2d1MHBi?=
 =?utf-8?B?YTZmbitkOHpIeGhtWWpMMk9iSmI1RG8xVWZ2UEN6eWdBRHNMd2YzTlpvbjNT?=
 =?utf-8?B?NFlQbVdZalpocnRQdk95TjRERDFPQjcwSHVrTDNYNFRPZ2NJV3N6MDhQZXh6?=
 =?utf-8?B?WmZ1djQwYWV5MjJQc3pMWG1BUkxkMWhPamQzRUx0UlhUNVZCVWVGYUNncHR0?=
 =?utf-8?B?MUM3MnlIOUNaUkV0azF4enJXc21MQzIvMnF4VEtsNDZBc0lLdnZYRTA1NHZz?=
 =?utf-8?B?ZkxVblBQR1NkNEFKNFRWYVowMXErZDhCREtQQ3h1a1A0RlJrRkFiUlViem1a?=
 =?utf-8?B?NzI3UkhHQ3Z3cG5ncWtORzNqcFVDMSt5U2NJS2dSSUtvTGtZUmtnUXR6MWdp?=
 =?utf-8?B?QWR6dE1aN1EwZ3hES2pFMWNuUTkyMHNHb1ZyVjFHb0MxNS94Z3ZMMkQzRHFF?=
 =?utf-8?B?enJkOGg5bC9qTlVid3VvbHhlVk0xL2ZyemRSWC9WV0M5ZkEycnRFcEd2MGI4?=
 =?utf-8?B?Uko4cStuNEhSc2FRZU5aRFpqOEpnb1dqTjdTcFNLa2JKMHBvNFY3K1RXUnds?=
 =?utf-8?B?S28xK1ZDVjdGZ0w0SE53M0tWUTNtL3Z1WUJpL0F4azBEVi9rdlhNTHY0Q3BE?=
 =?utf-8?B?aHViYTdSMktubDhiQlJBUnNXRVpETEViTS9KeVJqaG4wV3EwK0NsQjR5VkRk?=
 =?utf-8?B?cHo2ZGtRWWRLV2xYWnk2Zit5bktUWDVaLzZ0aUNOTGNWcU1scUpxWnl3aTll?=
 =?utf-8?B?cXNGOTJONURIOFhVb2s1QzF2b0labzhac0dzSEdiZmpDcXgvbGFxT1pzby9h?=
 =?utf-8?B?MHVqQ3hEZkQ2UWdRelU4QldWTnZKSExTZmRkUmZZdnFLWjNaVHlNVVhIaEQz?=
 =?utf-8?B?bjkvNWxISmYrYWZCR2tWSU5kbnoyYlk0MDBtRmgvY0JLWnA1UFAwcUFFMDlt?=
 =?utf-8?B?RjdhS2FFaDREbFdrRVN5M1hibkhxQjY5TDlzY2YrWWMrTWI5TmtaT3dFa2s0?=
 =?utf-8?B?ZURXY1dqTldiUnZSVkc0aVhLWVVJV2FDdlpCaldMY0lIYUxDTUM4RjdpRjE2?=
 =?utf-8?B?bjVRWWtJTjN6SG1nYTdLcFpHd0w4VzhQeUhWNWE0WVFMK0dJY00wVk0yR0F3?=
 =?utf-8?B?Mlh4ZWF3UlNCMFlWU3lKMGNEdUUvNUIvZG1qdEYwMXFLUW85d0RFYU0yYUVn?=
 =?utf-8?B?dmIzcHB2SnhOUEVFKy9BTzExRmg5VjlidW1TbDIyU1k4QW9DS3JDNmV1SmpD?=
 =?utf-8?B?L3JaQy9XZzRtaGNZTTUvWUJmS0xLdXVJUExzM3FSOGJFeFlVY3BPQ2JsNGJB?=
 =?utf-8?B?SW5GanpJWXdmR3lFTXM2bVJsWGF4UmtQVkllbkxZZXlka2FzR0c4TnB6bnRK?=
 =?utf-8?B?Ny9BMkxpNzZ5eGxMTENjNHI2VGZaaWFmYjVpMFJxTklqUHF0OEdzUlg4RTlx?=
 =?utf-8?B?TlJYNXkzRDcwUkxtYXQrY3hNY2V2WUhUbDVhVktXVmZXeVlNSkNMbG8xTUxC?=
 =?utf-8?B?WFc5cEpNeS91T3NZb0tUOFN6bzdoVEJjZmRvNDhUUUpnWE9pb3N0djUwdytX?=
 =?utf-8?B?K1lXOXFLZDZtOEllekcra1BuOTcxKzQ5YWQ2SEJLSTlPTjVTQThTN01VOHls?=
 =?utf-8?B?RkFEYUlVd2VkZDhITGtIZ2hyd1VZbmlhd0dpQnZSazhtRFdiMVY4UExtWjFH?=
 =?utf-8?Q?96+Ur226PAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlN3bUZjZWNRUm81RVMyaUNyTEs3MFVvZDczYU1uRWhqQWI5ZVo3S21UQ2Fl?=
 =?utf-8?B?RDNjdW05OHhFVGJ3UHFDcDJoQUpZcDVGR3NXRGZGR0xqZkhJeEs0eFBETEkz?=
 =?utf-8?B?dy9ETUpQR0NkWXd3VnJ3b0NPUmo2RlprSFRrdjRieHc4ZTRmSCtUVWRZTGNI?=
 =?utf-8?B?U0R1OG13YisxaStiM0c5QTNMc2hBcDdHY0RHU21BVjRkaDRxeHE2UVZ5d0hy?=
 =?utf-8?B?cVZiUFQ2eS9ybUFmMDZQNWc4ZUNhdWFxeEFuWW5mbEVzd0hwYXVyV2FZWFVU?=
 =?utf-8?B?R1UzdW41VUxlbzdLdkhDTzVXR3JLMitqVkxjNEg0ajNYUUcvU3NhdE9md0Jy?=
 =?utf-8?B?Ly9tdUNnZFBtRTdFVVFSZ0pzY0JyenM5RE5QMjNLTVJueXNiSnBBSW93dE9v?=
 =?utf-8?B?cFFTdDhWaGNFdU9FT0YrZElpNDZSbFNjWDFadGNoRXl0Z1grYmFxUFZHZW9H?=
 =?utf-8?B?SE41b1JzZTVQZzN3YlJqMWFpeXJKWDByYjI1UTJxK0htcDdvNHdyQlhYK0Vk?=
 =?utf-8?B?V3Q3bEVwS2czV3UrVkhQQUxvZ2J4NXoyalBLV09YcEU2bmxXUUpBcEZNSEdl?=
 =?utf-8?B?OGczaHdqMFJFTU1ub0ZnaVZjSm93bEduTVdwNUh6d1BnSkdGcjkxMUJub1Qv?=
 =?utf-8?B?d0wzU1ExZ201dTc3cEFGYlh4azlESXRjaCtkbWRDOHl4dWpwTmpNVjZlMDVw?=
 =?utf-8?B?TmVEZy9DMVdKL0VBRUtKMk5hSkU4dG5pTVhYMGoxOTlJOXRWREpJbXZCRHhy?=
 =?utf-8?B?K0lmNWZXaXZzT3NKWEI2Uko2QTFHTTRZVkxZcDNxYWMybk90UkJnMmVFTnBl?=
 =?utf-8?B?azVRNDZFTHNDWVBmTnJGZ1FIOXUwUWhlQmNDQjEyV3B5T2JxeDhSczNUSUo2?=
 =?utf-8?B?WVltT2JWem0xV1B1REx2QWRxdENlbDhNWTdOVklHM2hONnRlSTlHNUx3ZUti?=
 =?utf-8?B?OHp6bUh5anhRY1JPWmNFRVZvOVc0ZTgwbzdBYXZTTnZyUUxvNTJqdForN0Qy?=
 =?utf-8?B?TWdRK1RYWWxVL2lKclIvRFpzYjRyUThTN2NSanlIRXd3ZmF0OCtYZGlna3V2?=
 =?utf-8?B?SjVJM09NaXdwWDEyWTV0dHZGaGE0bHNGOUorVFJrNFlVbzFrOTh6UDhtTnRr?=
 =?utf-8?B?bnlzZkFhSUpjcSttYUlINjJBT1lYSXlOWm9PT1NGSVdTZUhUQ0pnREFBZ0Qv?=
 =?utf-8?B?aTBiY1kySFdxL3kxdGRySHVyd0xVdjBoVURoNjlNeWZFaUV3RGd6Vnh6Ums2?=
 =?utf-8?B?aGtxWVNRVzlTVWVZWG5KUFdYeXZsMU50d1VXNWFiSnBEMEdxUU5UblJWY3hu?=
 =?utf-8?B?d3plcWZNb25LeFNmbCtObi80TWJ5Sis5QmJQZVpYdXp3S3g4RVBwNGdVMGdQ?=
 =?utf-8?B?dG5jUTh5QUtPVi9LSDZGVk0xUGZBUGxhQ0VZcTdlckNQbGI4VlU2N3JvM1Jh?=
 =?utf-8?B?NmJUMHVTTkJabkhSRG1xUkJwaEs1UXJvMWJWRXI2Uk5qWGNCUis3RDRxa1lG?=
 =?utf-8?B?Ukg4NmVtektRUktUZlp6QTVIcGpsWDllY0wyS25CVjArRjJhY2JBY1ZMd3JD?=
 =?utf-8?B?bTRyQ2JSVHV2SFJ0bnB6Y3Jxa1R0NGJjOTF2TnBHZVlQUWxrZmpkand4N0c2?=
 =?utf-8?B?WUtzbG5IQjhOMlJXU1RUV1JMcVBOcm8wdDNHZHAxaUdGcXl5RDBiUlJlTUh5?=
 =?utf-8?B?MmUvTEc3Mkp0WUR5bTFDRGhseldNcGhFdXV4ZzIvcHh0MUdjeVloUlZ2TWRm?=
 =?utf-8?B?QlV3QXR6YVc4LzQwRjRVWEhpWjdGWEVOQk9NS0RkT01qY0kxb2xCTWh4d1RQ?=
 =?utf-8?B?K3BRMXg0cnhsUy9kOXRkNFFVRjNzUVhGVHpkZWNWdDZoWU4raFMxQ2JOdFhv?=
 =?utf-8?B?NXdza3Z3Tk1oSnNQTklzNG1hYmVWUmdvTlQ1cmI1NGpNUXBVSnNqd1FwU2Qz?=
 =?utf-8?B?aExxWDRkZHBPR2p3ZFFmSWlnQTRwUlNMQitac2owNTJqamVvS2U0ZE4zWG9U?=
 =?utf-8?B?SjVJUkpEMXVmM05FYm9GRklPYjlXVEs4NnBySGRsVmxuMGJOMzlHdGdrUzBJ?=
 =?utf-8?B?aEh4S2VwT1BBZC91ZitWMEIyN0dGU0tjUUpUWEpOWlF4SkhuQTVjVndjTEhT?=
 =?utf-8?Q?UfwH4YLtJZ0oF8G02wJBEfYAb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26f20a7-f0d4-4e21-2797-08dd8bda1011
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:38:04.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qmx3XiiGzUybkaEHlR8RrWRj0+2xymE4UBO+qYveuIj5Ea3iM40v3IXRrOabTmtG4nZ1OjFeaPXNLX7EyU+xwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319



On 4/30/2025 12:14 PM, Joel Fernandes wrote:
> 
> 
> On 4/30/2025 10:57 AM, Z qiang wrote:
>>>
>>>
>>>
>>> On 4/28/2025 6:59 AM, Z qiang wrote:
>>>>>
>>>>> Le Mon, Apr 28, 2025 at 05:54:03PM +0800, Zqiang a écrit :
>>>>>> For Preempt-RT kernel, when enable CONFIG_PROVE_RCU Kconfig,
>>>>>> disable local bh in rcuc kthreads will not affect preempt_count(),
>>>>>> this resulted in the following splat:
>>>>>>
>>>>>> WARNING: suspicious RCU usage
>>>>>> kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
>>>>>> stack backtrace:
>>>>>> CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
>>>>>> Call Trace:
>>>>>> [    0.407907]  <TASK>
>>>>>> [    0.407910]  dump_stack_lvl+0xbb/0xd0
>>>>>> [    0.407917]  dump_stack+0x14/0x20
>>>>>> [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
>>>>>> [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
>>>>>> [    0.407939]  rcu_core+0x471/0x900
>>>>>> [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
>>>>>> [    0.407954]  rcu_cpu_kthread+0x25f/0x870
>>>>>> [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
>>>>>> [    0.407966]  smpboot_thread_fn+0x34c/0xa50
>>>>>> [    0.407970]  ? trace_preempt_on+0x54/0x120
>>>>>> [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
>>>>>> [    0.407982]  kthread+0x40e/0x840
>>>>>> [    0.407990]  ? __pfx_kthread+0x10/0x10
>>>>>> [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
>>>>>> [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
>>>>>> [    0.408000]  ? __pfx_kthread+0x10/0x10
>>>>>> [    0.408006]  ? __pfx_kthread+0x10/0x10
>>>>>> [    0.408011]  ret_from_fork+0x40/0x70
>>>>>> [    0.408013]  ? __pfx_kthread+0x10/0x10
>>>>>> [    0.408018]  ret_from_fork_asm+0x1a/0x30
>>>>>> [    0.408042]  </TASK>
>>>>>>
>>>>>> Currently, triggering an rdp offloaded state change need the
>>>>>> corresponding rdp's CPU goes offline, and at this time the rcuc
>>>>>> kthreads has already in parking state. this means the corresponding
>>>>>> rcuc kthreads can safely read offloaded state of rdp while it's
>>>>>> corresponding cpu is online.
>>>>>>
>>>>>> This commit therefore add rdp->rcu_cpu_kthread_task check for
>>>>>> Preempt-RT kernels.
>>>>>>
>>>>>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>>>>>> ---
>>>>>>  kernel/rcu/tree_plugin.h | 4 +++-
>>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>>>>> index 003e549f6514..fe728eded36e 100644
>>>>>> --- a/kernel/rcu/tree_plugin.h
>>>>>> +++ b/kernel/rcu/tree_plugin.h
>>>>>> @@ -31,7 +31,9 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>>>>>>                 lockdep_is_held(&rcu_state.nocb_mutex) ||
>>>>>>                 (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
>>>>>>                  rdp == this_cpu_ptr(&rcu_data)) ||
>>>>>> -               rcu_current_is_nocb_kthread(rdp)),
>>>>>> +               rcu_current_is_nocb_kthread(rdp) ||
>>>>>> +               (IS_ENABLED(CONFIG_PREEMPT_RT) &&
>>>>>> +                current == rdp->rcu_cpu_kthread_task)),
>>>>>
>>>>> Isn't it safe also on !CONFIG_PREEMPT_RT ?
>>>>
>>>> For !CONFIG_PREEMPT_RT and  in rcuc kthreads, it's also safe,
>>>> but the following check will passed :
>>>>
>>>> (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
>>>>           rdp == this_cpu_ptr(&rcu_data))
>>>
>>> I think the fact that it already passes for !PREEMPT_RT does not matter, because
>>> it simplifies the code so drop the PREEMPT_RT check?
>>>
>>> Or will softirq_count() not work? It appears to have special casing for
>>> PREEMPT_RT's local_bh_disable():
>>>
>>> (   ( !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) || softirq_count() )
>>>    && rdp == this_cpu_ptr(&rcu_data))  )
>>
>> Thank you for Joel's reply,  I also willing to accept such
>> modifications and resend :) .
> Thanks, I am Ok with either approach whichever you and Frederic together decide.
> I can then pull this in for the v6.16 merge window once you resend, thanks!
> 

Frederic, there are a couple of ways we can move forward hear. Does the
softirq_count() approach sound good to you? If yes, I can fixup the patch myself.

I am also Ok at this point to take it in for 6.16, though I've also stored it in
my rcu/dev branch for Neeraj's 6.17 PR, just in case :)

 - Joel



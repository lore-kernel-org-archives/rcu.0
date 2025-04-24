Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65C190068
	for <rcu@vger.kernel.org>; Thu, 24 Apr 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507860; cv=fail; b=E7VyC7OLzRzjBssiFZbCMS4o7a9NkcG5bsZ3Wi8QuebjIGd60if8BJQTlTVGeiQDQWKc6tsHgsDOH2Wz/brZxoawVMgcS0SvEh2c3KTJNjz9N1pqDHUYUNvRCmLFPVaGSGMMZDdv5fwknk8bA47gtTMqwXHT5YPW/CNjGduNAGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507860; c=relaxed/simple;
	bh=wlXRwD+M7rUYYQlhWVlJGjEjMbt+SUJnsYwu4j2VCSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFGjG844QnnWg7LXcyxJpxPZbGh+RUiy+VJsVfG7w/qXRCU5fgAOYyKoouzc21XKINjyV7ddYwR2m3gSjazEBgv8e87QtAe5CNBMAt+oY3ScLBwAVQVSObFCoC1WJZ/rA0ctnJHgMeuw/RhiqnoN6isjTcATxSoPEqmReBsOBkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VEmsno8U; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VEmsno8U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5r3FaO80CNahumy6gti/ZZkSjr0F6LUtR783nKn5zZrUlYA+mf7y7TjIWZaMxJCJ2POrdgoAtRtNdcH4SYqFCAHjTBZq3UXjKWfzCHPypm/B14epX1BBAKWP+/vI51FYTf94SdkqeOAb2JyfKc8Jzw/hUIZJ8qn737E64gambvaBEFvUiplCyM/wv/L53BctiOkqD4ohktzqSB7Ck4yAi78Ay5Ln5j6c93kZDgRc2hCKfsnidcUl0EarV7E7zXf6HE+pPdRqLnudVnjLj7Gu2bXI18TdutJSQmfbbXuRJkTeUQYKLU1XXWJMzl+Dxv90lV4Anj4UWv+a6y7QhQrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VxT3VpF3KY+n6euCm3h18rHhxH6RRGESbKoGwYnusY=;
 b=Vt/WeY4IStEDmTHWCPVivFfXrzOEak8rb3U84oLImlZ0wVXTyiQgmzeDpMjkIlI15jS8DIFszC5ggLhYEb816ndI6vXvGOkXjWtaQp0wkA5qbPgA6gx8Z/HGopyVVWnTZ6I+fgMuZUmKst3kDiq8cGqw0hraUFwaiE9002hoZfUPM5k4QzHt09oVy9r5I9qtrMUld8NrOWOuBybC2qJtotPs7mZm8bTz1pNvagUyipwRXuuSph6YsOMHds6jlSwC6GANh/gjCynEBtYxoDmwl47PHMkic3S7gIeiEinkfLLf3rBjsmXtoWenNcV8EkVMikj4uNU79TuUCNPL5i+swg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VxT3VpF3KY+n6euCm3h18rHhxH6RRGESbKoGwYnusY=;
 b=VEmsno8UkSKY8rdNTw9DugLBf9vbIGsZE0ao5UQa6PHzGJGld0tqv6AlLkA9ILJwsJOMjrsrcSBqm++e2FUmdsYoC1Ko7NdE8PNPN7udbb1YzQsQmgfSE/rce7A/QY0Bbvv+IYa+yy+TUdLdrp9Av4j1nhVD7evkDWqi8fx5ycruiGKLh5WqKOYi7DrVhkUlrXRJLUwGROXwbA4N2C9rqqDiA7A1n9mjPj2VxTg49T2WTYo8VcTRuMjRotuJCeDs2kVx0Q39sGgy6GVRpKTROt37Pg181KVzvdZW4e+VNmAD+XZbqM/7OHwMtMMJKy4EmwDRGAEzuHOgBdE3kvmatg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 15:17:34 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 15:17:33 +0000
Message-ID: <849e0751-2911-4b71-8274-725255f4826c@nvidia.com>
Date: Thu, 24 Apr 2025 11:17:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] rcutorture: Perform more frequent testing of
 ->gpwrap
To: paulmck@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Cc: rcu@vger.kernel.org
References: <aAiT_KWYN-gP-2MN@stanley.mountain>
 <f8669b6b-63e0-454d-8a58-09043015bc61@stanley.mountain>
 <a2090431-7299-4fc3-89cb-114026f482b1@paulmck-laptop>
 <616131f6-5365-40ee-ab57-27d484077a31@stanley.mountain>
 <6b26b3cc-6429-48c4-ae58-868d6512f0d3@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <6b26b3cc-6429-48c4-ae58-868d6512f0d3@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0b7c75-4419-4fcb-3d70-08dd8343235d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVZkZ09JQ2hSa2MrS0pCeUZqMXZ5UEh4akdjVHVuZ3A4a010VGtCSnpEREl3?=
 =?utf-8?B?Q1E3MHpVSXkvSVpBeUluZ1FQeDhZRUN2KzZVUXYwb09ZdWVnL0kxZ2pCU2tl?=
 =?utf-8?B?Zklvbm5nK0FVbVN2VUE3L2N0Nm45QXZvUDd2M2JEbGNCaUs0WURlZ2dldkd1?=
 =?utf-8?B?Y0lDMFpuSVdacDM1T2UzcEVRRUpndzA3WEdGOVpTQkErRm5VS0hFdnNOTGV0?=
 =?utf-8?B?OExncFQvcXllZWNiaDVsWmlYKzZ3aXQ1c2lrZEpFdVlsOGx6NTRYTHMzZ3N0?=
 =?utf-8?B?bDgrTXIwejRUM3N6R1B0VXZvNS9aSlhqV280MmNNY2Nlcmo3RlRmdjZQTkpZ?=
 =?utf-8?B?NFFHRHpuL3FUL2tCQWRJSmNsdFdSV1RGdENsR1N6TkR6MEk2M3JSdGIyOVRk?=
 =?utf-8?B?ZmZyanhITFlrSXByb0JEd3BNN1Z6ZTB0Uno3RUc3VTBDTFdsRE1kcE81WGlR?=
 =?utf-8?B?UU1SR1Brc1MxVGRYTFI2SUltRVhCR3BGc09JbXVkd2cxeTEvaUxTM1RBMTNr?=
 =?utf-8?B?bnJCYU5VSUUwVGFaQ1pBWFpQWmVQZC81NU5lcFErTDhyUE9BMmpvVVdiVFI5?=
 =?utf-8?B?bDduWlIrNFlxWFF5SFk4RERySm82MHpaR3pjTzFTZ01TTGVXaGZONHR4UXlZ?=
 =?utf-8?B?Y1pPSk5ZTEh6UVRjNTd4cjJGbTRqWGYvMWRQa0Zja0EwbU4rRkdNNVRjZDRU?=
 =?utf-8?B?MytJbjBBbW5jUXRsTk1KMm83dGlmdUd4dzFLQTVqZ3FGSGZJTkRkTGhySjV1?=
 =?utf-8?B?d1I2L3IzZnlKN0VBcGpLWHo3eDJlZFZoK2Z5V2luTHRMeFR0YnBWcXhTelNQ?=
 =?utf-8?B?YUhaMHA3RUxBUDlhb2I3dDAvZkJmdkRJNEVlRkQrVnFpWG94TWh5WXNqamp4?=
 =?utf-8?B?L1VNWExRaDJJVFptV0wzNHI2OUM1QlEzREt2VDdGd2JTTmJOREJLcS9KdHJu?=
 =?utf-8?B?cmgvWS9jNWZJZDFUQWZLSEVhREdxZTdKc1VuR0ZsTy9tUFJ4Zjh3bS9lcEIy?=
 =?utf-8?B?Z3htekEzck9QMzZ2OXUrKzY2ZGFzV0JMOGZTc2gzbmx2a1crOUpMWERnb296?=
 =?utf-8?B?ZkxrUS9TZEsxY0JPZ1k4a0pDZVZHOFk4a1VtQVlaTmFsYm5WUE1rSTljQTRl?=
 =?utf-8?B?SXJ5SWs4cEhFSlVOZzdKMXVuSHN0TzBrRlBYYjZqa2haMS94UzVLWTBFOSty?=
 =?utf-8?B?YjFvSS8zTGNqYm9WVnVpY3ZKanZOT3ZvVDRFbVJmTnA2cVp4MDFxWThkdFVW?=
 =?utf-8?B?amdESEt3ZFkvRjZxOFIxVjN2VzdVbHZMQUlPalBzc20zb0RVTWUrcFVTQWRX?=
 =?utf-8?B?dXIyVWpNUmVmN0JkRXhuTklORmpuckpTUkhMNUdMRU1ScGZpM0F0a2Y5UUY2?=
 =?utf-8?B?K3BLTDB0Y2wvWXNxN3ZLc2xGOG00Y01lNWRsZU9DZ285UUUweHQ3OXJzb3hs?=
 =?utf-8?B?cW03RmFYcG9zTGQxNGU2dEhNSWZQRWRTOUVPOG9HWmxTbDBDcG9QQXE3Sno4?=
 =?utf-8?B?RXhpbWdzMmxObk5rUk9jeWszS1Z0TUt3SUdxR2huNkl2VWMzSFp3THZnYUxo?=
 =?utf-8?B?VDA3SC9QY3JCTFUybXRkVUJTOW0ycnhjUnA2R0U5MmRXM0FCZWVRbWlKT0xB?=
 =?utf-8?B?RDkza09MNWtoYVVNSTRYa0VQMTlvdjAzdDF1TnA2eFc2cXllYjd4MTV6U1dj?=
 =?utf-8?B?a1BpS2Z5TDB2aXRDcjA5OFFOWmszOVRpeU9TaUdIbkJxb1M3YzNxQ05VbXhq?=
 =?utf-8?B?djl2S2hvd2R0dUpvdXJVeTZXTzR6WXlRRWJlMjRoenQ5V0hVZVhLSFdiaXVU?=
 =?utf-8?B?WkNlUjhlRWExUFg0NXBqYTh6cHhsTTg2VU9qa3hZL2xJVE9GVnJPKzJYb203?=
 =?utf-8?B?RkFhdjE2dklFRHVRanhVWVp6RlpZZUU1SkpWY3pqTjU2WDBIY2JCSldvUHZS?=
 =?utf-8?Q?MLXOP/DahCc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWg4eEpZYlZnNy9RTUtBQmozRmF6SjAzdVNkYnlRUEs1UHFtcFZYZFBkdWJC?=
 =?utf-8?B?bnhPTHdud2hzSU1waGdhdjdQcHBrNDBXQ2xlZ2ZoR3UzZHVBejExbjZjT1h3?=
 =?utf-8?B?cjdnV2o4ZHhaSStxYmpVOFp2YTFkRGFLbkt1dXpsNGZUeXVmZ010YzdqM1ZL?=
 =?utf-8?B?bzJSaUhXbWJndEU3WXlqRHQ2WVVVQmpuK2RGbjVkcms0NUVCTCt2aExLN2RB?=
 =?utf-8?B?QVBjbTV4UW16UTJISU11YW92ZWlCN0lMUjZqTUtaMXhCTDJFL3UvSzRwWnBI?=
 =?utf-8?B?TVpCVkVETGp1MzBMUThEMVpWUng3Z05qbXRMSTN0bGFiK1UzOUhQRkVRQk1q?=
 =?utf-8?B?Zk9laHd0dUZaRnJuSmZkRW4xazhSdnVmdEcreVo2eFp5ajhUSG11MVhYTk11?=
 =?utf-8?B?SWp6NUNEMUQzUUZhUDF6bmc2cXovclNVaDRLemZodzhMMlN2VEF1RDRvNGlj?=
 =?utf-8?B?Y2hlQTJYd1RYNk9TYzlxMFhtS1dqWWZJOC9WNWVGQ1NLS3N4VWh6UVlzS2lF?=
 =?utf-8?B?Vm9lTHlFUVRkcjFzTXdTaEpEWnFzN1AxYVFUUVptcXpoV0FDSEV5T2ZGZ3hw?=
 =?utf-8?B?ZGVQbjJZNEJ0emlGNFhQRDRTcStjUlk3R0JVd1dVN0FzT3dNVmtjdnB2dEJM?=
 =?utf-8?B?NGg5Um9USGZYMUZ6RnJvaVRqdnE3SUZGc2I3U0xmWVBqOVI0UVhheU0za040?=
 =?utf-8?B?RGJ0Nmh4Qng0aEdXMTZiVkQzWGRJUEd6dWo2bTU4NFUveUptMWxPSkVwWXQ2?=
 =?utf-8?B?K3JwRDljVnhQYWRqbUxTQmpNdUFpeEFFZDdydlpvMUg0dnVpY1ViMjlzaFVE?=
 =?utf-8?B?ZGcwbmxralc0YUgxbDlmakNXdmZhZVE5engxT0hXZm5jSWtsNFVCdXRteDR6?=
 =?utf-8?B?MHhVL1JDNmlwcC8rZ2ZMVUJYczk5dVEyYnk2ZFc4NURhNnhDYzUzQUoxNEoy?=
 =?utf-8?B?dlFyZmI2N1o5V2owanRwZ0tZZmZBWVNDS3JBMGh3T0kzd1E5REdRUkpvZlJz?=
 =?utf-8?B?RkdwMG1qbkFOR01CcjB6UGZrZEpmOFBHQXdBOTdFVy9JM1RzcnNnNDcwb0F5?=
 =?utf-8?B?Sk1JakVIU2FDVU9EYmFCNzhNVTMrVE9WL0pxeDR6U3diV0ErV1Q4Z0g5QSts?=
 =?utf-8?B?SnhoUGFpdlY4ZXhoVFdNbTlsTHBQMEVodnJvN2VHRlphblFOUDY0Mnc0ZE9o?=
 =?utf-8?B?aXlrMllPU1E0U0lxMjRnU2JEWGlJdmpBMlFJdElUY29Ub2xMeDB5TFE2ZXlC?=
 =?utf-8?B?MEdCWGh2emdzejhaVkp2MkVnWGhNdmhqVlJtWWdjRktST0NGaU14Q2ptVlVJ?=
 =?utf-8?B?NUFXeC9pazdUYi9QLzM2NTV0Vkdibzg3ZlVsNXZiM21GZjB0SnRsVUFJalVG?=
 =?utf-8?B?cGVSaGwrQld1aC9nWW0wREZJSTVCQnp2TG4zR0l1enE1R3dkaUFzdEM5elBa?=
 =?utf-8?B?YnRpclovSHBLYUZacEh1M0ZaM0NZbkpMQnlEd0Y0RkhoUkhOc1FtRDZrbS8y?=
 =?utf-8?B?S0hvOS95bHplMThhTzM3cURKWW9GQWlVVVM2NldISFN0dk9ReGVhWlpucHJD?=
 =?utf-8?B?TnJwVGpXMzNYZ1Q5K245YXRuQXZKZ2ZicS9ISEFPa2dRZnkwU01BMUl3UUdL?=
 =?utf-8?B?OHRkc2ZQNmx0aVc4OWo2RW5NTGlESFFrbzdINWdOVE1KMi9KN3ltSkZQUHRq?=
 =?utf-8?B?bDdyNFVvL2JHcDFKK1psODhpL0o0N0NEOHBsMHEzWFIyQVc5Q2ZBblNxOGFz?=
 =?utf-8?B?amFZeG9RRk5FbE1rNDZPWUorbFVteFRKWklTYXBFUi93TWkxa0hTTHlUVW4x?=
 =?utf-8?B?aEE1MGFoeDlhVXc2RG1PM09RaVlncHhPbFg5WHYvSS9kckpLV1NiUFZybmFV?=
 =?utf-8?B?SXM3NlJVN1hJRUlsZllrVlhmZ25tMU9QVnY2T1F5MlNwTGFuRlNGVVJVYnp5?=
 =?utf-8?B?eTh6MHRBaEYzTlpsQUFaMGpCSSs0c0w5L1pSTjNxMnR0bFNaWGNVQlFaRTJI?=
 =?utf-8?B?Vk9oMjhHekd4VTRsblY4NWg1aCtpaDBGY0dtbGZuVG1lMnlnZlozcm40bEhL?=
 =?utf-8?B?QkhMVnAzaGtvK2ZqV0tVQmZqRXlYeEtkNlBPb0cwZWI5MDFYdmpqbjRSNmVl?=
 =?utf-8?B?MGJRRWhHVm5RRlRUckliV3g3SmxERWZYR0ZBRnhjN0cwZWZHTm05UmM4MnNI?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0b7c75-4419-4fcb-3d70-08dd8343235d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:17:33.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MYIQh4m+RoHjL95c7WhYgh09iCK029UiNgKLI8IUrhfl3y1HM5VRFGpaI65Ed04TF5okTgPouzODtNStAjuJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609



On 4/24/2025 10:44 AM, Paul E. McKenney wrote:
> On Thu, Apr 24, 2025 at 09:54:14AM +0300, Dan Carpenter wrote:
>> On Wed, Apr 23, 2025 at 05:41:37PM -0700, Paul E. McKenney wrote:
>>> On Wed, Apr 23, 2025 at 10:19:56AM +0300, Dan Carpenter wrote:
>>>> On Wed, Apr 23, 2025 at 10:17:16AM +0300, Dan Carpenter wrote:
>>>>> Hello Joel Fernandes,
>>>>>
>>>>> Commit bd57ec707441 ("rcutorture: Perform more frequent testing of
>>>>> ->gpwrap") from Feb 16, 2025 (linux-next), leads to the following
>>>>> Smatch static checker warning:
>>>>>
>>>>> 	kernel/rcu/rcutorture.c:4586 rcu_torture_init()
>>>>> 	warn: missing error code 'firsterr'
>>>>>
>>>>> kernel/rcu/rcutorture.c
>>>>>     4576                 if (torture_init_error(firsterr))
>>>>>     4577                         goto unwind;
>>>>>     4578         }
>>>>>     4579         if (object_debug)
>>>>>     4580                 rcu_test_debug_objects();
>>>>>     4581         torture_init_end();
>>>>                    ^^^^^^^^^^^^^^^^^^^
>>>> Also:
>>>>
>>>> kernel/rcu/rcutorture.c:4591 rcu_torture_init() warn: double unlock 'global &fullstop_mutex' (orig line 4581)
>>>
>>> You lost me on this one.  This mutex is acquired by the earlier call to
>>> torture_init_begin(), but only if that function returns true.  If that
>>> function returns false, yes, it releases fullstop_mutex, but in that case
>>> rcu_torture_init() returns immediately, thus avoiding this invocation
>>> of torture_init_end().
>>>
>>> Or am I missing something subtle here?  Or missing something obvious,
>>> for that matter!  ;-)
>>>
>>
>> I explained it badly.  Joel's patch added a goto so now we call
>> torture_init_end() twice in a row.
>>
>>> 							Thanx, Paul
>>>
>>>>>     4582         if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
>>>>>     4583                 cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
>>>>>     4584 
>>>>>     4585         if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
>>>>> --> 4586                 goto unwind;
>>>>>
>>>>> set an error code?
>>
>> Here is the goto.
>>
>>>>>
>>>>>     4587 
>>>>>     4588         return 0;
>>>>>     4589 
>>>>>     4590 unwind:
>>>>>     4591         torture_init_end();
>>>>                    ^^^^^^^^^^^^^^^^^^^
>>
>> Here is the second torture_init_end().
> 
> Ah!  Thank you for persisting.  Over to you, Joel!

Oops, thanks for finding both the issues. I will move the torture_init_end()
further down and run some tests. At first look, that seems like the right thing
to do:

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 92e2686a4795..bb9a8e718533 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4582,13 +4582,17 @@ rcu_torture_init(void)
        }
        if (object_debug)
                rcu_test_debug_objects();
-       torture_init_end();
+
        if (cur_ops->gp_slow_register &&
!WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
                cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);

-       if (gpwrap_lag && cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
-               goto unwind;
+       if (gpwrap_lag && cur_ops->set_gpwrap_lag) {
+               firsterr = rcu_gpwrap_lag_init();
+               if (torture_init_error(firsterr))
+                       goto unwind;
+       }

+       torture_init_end();
        return 0;

 unwind:

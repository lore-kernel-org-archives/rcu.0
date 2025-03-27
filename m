Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A517BB21;
	Thu, 27 Mar 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092542; cv=fail; b=TYuqm00Onn5zdmjc0b7JVyjsfOOtmA00ZvnamX7jxHL+r0lcGBNvmkDgKl/Iap5lfSl6jX4k/zz4peJwJGuL/NilwUy8KaUTaEzrILTO/3NqEl6rTz4tE3tT5qDAxKN03vkQQ8wpMPPe2oITj3RFEaLViuAxAyY7GpC1wn+jPBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092542; c=relaxed/simple;
	bh=YDc+s/SfTZwccJjK3TVfuQVbOCKsB3+/g5pNMlatTr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t31LNrLm9KxDqvTyvtIOtNLcvO28WucgQmgNCN/P5g8VmAcRESThfciOTOzQmwSKj5Ko7H1RET0nIIvYKoa7pQ3wKULpi7LfpN/PYkB0vnUOECMuPCCDzYPM/vbDYB0V+b/ysjcISvEPlVPns7r3EaYwHT1VfTz8/FXA/N6yX7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VzD1cr2b; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VzD1cr2b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE2tDXKGKj6ilKyjReC6yYwTw7Vl+Hkd3avcz0uFy1Itq0fwyik5TFM7BWq41R6GE7n5Eai37EorXpaRp5Gzswmx629hl3BWw3+UEVOScBcL8YaofOilCWEvu1bfK+9soNePrt6+c9jQNzhHedjdoWD4/RMK9ZTS8JdywKfDP4Nl0uVkbW5g8XLV2FzCT91473Jn43WchbKR4YH1VKGZaqvz1KOrWulXBrwxeH/fuDbyj8SjaiMS6jASRtgTB/2kMrFM40gNlSiuTpSL02IBm77F+FKqveOZPtW/E94U4HAVotFC+1IoEP0iIaD+2KPDlMUmOYoBCJJ0xKMnNVG0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQSWPwLn0DvyHpbIWYgTYgEReYjFdvR3JgBjbEDxDqI=;
 b=eqkLtEl/66S0IT6Mmk+I9v5PWwJU8+k+YCBBY4BBxFivA3UVsERlvsdjxp6lGwAJmeGDtuOG2M2+H4zl70hPQJOptVQitNXrCHtqVr+ji6yZJLOou9mRn6acdLYjc0bu/YrKjr4i5ZEHXm34ai13Iujq/rt36wTjukbz70hKpBvbzEEBANu0t6XXGryPbqx35h74uB0xI6HcN9mEx7wShiKE89NL7x4xJn98dR0FkspZ0MaO56J+C18iSdZ+LNsjEuBbHI1HBeXA0YT/nPG/vQGc7U/pLLT9+awygAF+qL5tVQdh3mVC5Vor92J4eiSB21EWAhkgM6fNsuHemL5fOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQSWPwLn0DvyHpbIWYgTYgEReYjFdvR3JgBjbEDxDqI=;
 b=VzD1cr2b187IbYsgnBtbOJbtkRxh64XuCNXKL0uhvNpRF9RfFFDTL46nB6yPKWDxTslugmxl77ShMGEJx88IU7WPGnP2ZAqe49OJcWQTLM5OyFEQmF63J+DgTV8Sk9vhmeH4OInXAVyAfEO1U+pJVw0d7xEbzzjGuWEsbfBVdD9djYguCmEj4HtFZI7EuNb/rWG8zvpGJvwcm13s4Mit1R9zSB9IRYhMOBiNC4H1TbY1scr2DJHuZrFWi5rZtT4G01/B5MNsuAPSLdnfmovWVJ3BAB1bIFnSSSOndCvu+Po3FEaTcKIKSkF1uEMR0PoAlhNJiSXpjnDi/DT7LfXLGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:22:16 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 16:22:16 +0000
Message-ID: <9ac94cda-3962-44d4-80e7-94555b104cf2@nvidia.com>
Date: Thu, 27 Mar 2025 12:22:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] rcutorture: Add tests for SRCU up/down reader
 primitives
To: paulmck@kernel.org, Z qiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rostedt@goodmis.org
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
 <20250310183809.3576320-5-paulmck@kernel.org>
 <CALm+0cWn_wh_QnR0k-QDVTwgdBdXTEd1Xtk5SM+T27ejCchPJw@mail.gmail.com>
 <762ee713-a38f-49e5-aa4a-57e4a4da687c@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <762ee713-a38f-49e5-aa4a-57e4a4da687c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0399.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 643e384f-7b24-4449-1e7b-08dd6d4b8a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkZuaDh1UWRTZDUvb0VIV0JBQXVheW43ZW5RMjJaMmNYbHdyUEN1SkF0cVhN?=
 =?utf-8?B?ZURGbkY1TlZlMEFSQXRBRi84b0MxNWdyRkxidUk5emVGNDFJS0l0by9zRDEx?=
 =?utf-8?B?SjVHU0FBV1ExaWc4OHJQL2lvU2JXSnl0OUE1U05YNDJUUW1EOVF1KzFyZm1o?=
 =?utf-8?B?Uk1ldEVIMTRMd0puTmI2LzlhVHRMYW1DZVlYSzR4U1NCVjZpbVBlL1BBMmsr?=
 =?utf-8?B?VW9rVU93bzdNdlA3OHh3OFpNaDN1WVZGNkptMExzeHI3b1FMYjdIaFVVYzJZ?=
 =?utf-8?B?NnpuRE5ualA3VXJxWTBhU0lzN0l1bzhHdmVEbXd1RmVIYzc2U0lrUjhqMUEr?=
 =?utf-8?B?anF0QkhXNlpRaWFndlR4aUNlRWZoZnJsQ2NLb1pCcEJCVllXcFZvSWVMUjV1?=
 =?utf-8?B?SnBzWndldHBqVDlVM2E0ampIMzY1OXErd2hTbldJY3pzWEc5REtmMTRVVU80?=
 =?utf-8?B?a1J5aWFBNkJMQlpKV0k0V1hReGM5VVVYdmJCRUZoekc1MGYvcGVpekd4WURs?=
 =?utf-8?B?WVZpbDNVaFlNTnZGY3JWcjhXS2hYd29COVF3ZkxMb04vR3dLQlBXWFB2Wloz?=
 =?utf-8?B?R0oyY2tBWlFJQzl6dHJzbGJoS1o3eG03ZXFBRGtMZFh2dkdoQlVvYVI3ODZR?=
 =?utf-8?B?NGtGbXJ6cTNJVENRa2J5YWtyZXJIOXpvaTJNQkU5OG9xak5BclRmMTVvOFpK?=
 =?utf-8?B?dWg4dG5Dd2pHdzA1RGtGMjJ2WllaUXQxZTMwNndkdTN1dHA5cVlrNk5sMzFC?=
 =?utf-8?B?UmN3RkU0M1VaaWNwM0pzL2MrTXZiazdQd0JKUytxK3c3d2c5aC9WaWl3SzRI?=
 =?utf-8?B?bG5DVXc5S0QxUTlVc2NtcitRK0dUenYwRUhxUVF4TWgvbG1QNDBQaTlvSmVn?=
 =?utf-8?B?OHlPaHpRT0RRY0NRTnBVUHA1N2FESldPYjI1VlZ0Rnd3QTk0OE9CVkNsOHFE?=
 =?utf-8?B?MU5IMFFrL1F4VlE3MGc3M0Q5MTRMTFZwK1VGM3ZsS3FuTnhWVEJ0b3hvZ0Zm?=
 =?utf-8?B?bzdxWGxkZXJ0bms3ZGF0TlhCdmtIazI2bkw4NFFvQkFkQnAxNHlYUjluNElE?=
 =?utf-8?B?L2dDYmx2YkRBUmozR1QvUyt1emk1anhNMkxIQVNVZ2lXVVEvQ0FhelNMR3JS?=
 =?utf-8?B?ZE1ScEx5aXIxV08vSE9YY2hyTWRIRzhsOUNDeDJ2RXRjbHMrN0hjaktZdXNm?=
 =?utf-8?B?MUZxdmxFS0pHck1CVUNBS1pLMVMvMlAyMXFZbHE0UWMxQ2lvZnlMeXZjaW9y?=
 =?utf-8?B?OVQ2UXlUZGZLMHZpTHFmYmZCRTVnWkt6RlM5c3E5REVWeFNSdWs0TWFjUnpp?=
 =?utf-8?B?VDBnZzZKSXBRWXk1ZFdhV0xLeng2R21YaXFNL1hEVWJxM2RDYno3VEp3RHY4?=
 =?utf-8?B?b3RFVFhEaHdjRHRXQ2Nra0dpSGxCVkRCSVNVQUJjcEk2enUzRmFTNHo4UFVD?=
 =?utf-8?B?QkxqaWRxZGhtVThhbi9kNnFvSWJZem1vUW5FSTBkV3haV3IyNmxXOHlIcmY1?=
 =?utf-8?B?aGpqUU9SazBJYSsvRWh1ZzFoQmJhVzM3MHdSOHNzWFF2RElnbWRjV2Q4bVR0?=
 =?utf-8?B?QkRRSVdUbkdWQWdTZjg1dFEzWUFlNHgvazRTNzhMWkgzWjZac0VuM1ZzMERB?=
 =?utf-8?B?QUx1UUpOeXcrVXJKNEdMRllFR09aZ0N4a2dhdE12eDU5UVZFY3FOeExDR2c2?=
 =?utf-8?B?K0ltTmNUYmVvMGZObks3bWhOVjF4eldKSm94a2ljS2xpd2xkVTRqUEdlUC9t?=
 =?utf-8?B?K3Q4OHpadUlDM0J4czNZZXBiUnlnaXVWdmJ6NWFCdkNOY1VRT2UxSnIvREg1?=
 =?utf-8?B?U3orcXVCSE5RUHRJMDhOWi9Yc0h1T3VJRC9TdjhJV3IwRDJ0QXJRakYwN0dp?=
 =?utf-8?Q?kg8+7BpvH93Ob?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1IrbnVHT1NoVXhCbk1iYzczSnhqUnZGdTdydURyd1ovdkx3Vm51V2ZkMGZK?=
 =?utf-8?B?ZWVrTXhLWExFeVU4aTJXbU1HR28zQ1FueDVRamhLQkFxZ0JKV29yd2JENDgw?=
 =?utf-8?B?SVpkVVozblpFQmsxa21tYUhYVGpzbERDYVBDRWF0TDJhRHBSdkpYaXJwYWda?=
 =?utf-8?B?Myt4T3VRUHRZRXBwMkNQRzczbkJvSEhSNHdMWTRNcnV2QTQvRkpJWGQrYUZi?=
 =?utf-8?B?Zm1WWmx1TndHN0lMNityNERPK1BpZXM3ckQwWTd0SlJQYXRBaEYvZ3QzT2tD?=
 =?utf-8?B?c3A2c0NRRW0reHR2WG4zTkg0NEVsVWszWENqZ2RwWThqSFhCM0M5NTloYmpZ?=
 =?utf-8?B?YmxITTFrR2ZTcytFNE0zaGE5WWR4STgrRTJmNkFtUTlSVWVnenlneXJEcmtJ?=
 =?utf-8?B?dmsybXEvWFJRdnREbjFXSmlUb3QwL1g3bzBRblRHTklCUWIyY2xCTEhpN1ps?=
 =?utf-8?B?cDkzYzlQYjY2S3czZzhmQmlncVpjTExXU0dBdW9hQk00RzBTV241WmlQbTVO?=
 =?utf-8?B?T2Q4bHpycTJ6dXczU3I5N2xGeWI1bElpcGxxeURBSGZqZnpYclhkdHUvVENJ?=
 =?utf-8?B?OVpnVUFNM3p0aCszNXRkZnc5c096NnNWb1hJRnZZZWVReGptQ3R3N1VqK2Y5?=
 =?utf-8?B?dWI4YmQvOFpjNU9CeUM4eVZKd0pUTzNXVWd5K2VRS0gzNlQ5cGZwMitUcGhV?=
 =?utf-8?B?SWEzUmxVMDNwVGkxc0Y1ZndvT3duRDhDZVM4S1JDQS8yNW1jNHphRlRkWG51?=
 =?utf-8?B?bnpjYjhJeU9BZHhCUWdmcWlHNGdrRE5Na1hKRFBkQ09mYjF3T1YwQnJtaE9H?=
 =?utf-8?B?VEpSb1llaXFYcFkwa3BXT25IK1A2STZVcXZOWmk4Z2U2N0cwNjVSR2pzbU5Q?=
 =?utf-8?B?T2JpdUl0OGhGVStMSTZ1ZEdJa3Yvc2tQbDVmNEJQL2h4SnhwdXFTZjhQdDdG?=
 =?utf-8?B?ZUV0L0c4WSt5QWFrY0xyZEJoNXRaSlNia3V6ZkNMb1J4OW40WFFsbnczM0Zk?=
 =?utf-8?B?K3JFR2xUUHJVNnhaMEQ2aitMOXBudDlmL241aDZSb3JPUVFKUGh6QlcrdUxR?=
 =?utf-8?B?YWttQmhYRzFHRjFnVkZhMGpjd1luOG1QTTFoL1FCM3Q1VGs4NFg3ZXc5THpa?=
 =?utf-8?B?c3MzSGpvQ29GZ1d1V01HcGM1bmhIUkdKL09rQXF5RzdPYnB3VkozS1czVVNp?=
 =?utf-8?B?VUtRVk44b05US0tVeWxwOWFwbkxPTVhZMENFS3FBOC8xQWVnRC90Qkp0MWcw?=
 =?utf-8?B?QXl6YzFxSGRjWG02OGhLTmRjUVBPRGpLeHJMenFud2cwdkwvSmVad3R0NkJ2?=
 =?utf-8?B?NVFmMkRFWDdJVkR5cGhLZWsxdlEyb1NtRVA1K0M3bmErV0JVb0hSRkJOU25R?=
 =?utf-8?B?STM3cjgyRkU1Sk5tOGNORi9ZN202LzYwa2ZuVGN4ZU8ydE8xK0hwdUVuK1p2?=
 =?utf-8?B?M1lhbFFJTWdBanZWS2hOTWpjRGFyMHlWaHVaNlB2TE82ckV5SW5vVG8xc2xq?=
 =?utf-8?B?ZmEydUFMK3V5OGlCK0xmQi9wdjhtU1B0NDQ4WVdldS9kRFhETlJ2RHZ1K2JM?=
 =?utf-8?B?SHh5SThsZjVLaDF5dVN1QVVZQnF4M1MrZU1zQkFPQnBFYld3d0t5SEhtU2Vo?=
 =?utf-8?B?R2dXanhrN0luYUF0MjVEUDFVUkxHK3pXWEFYUDFaU0xYdGxTUU4wZ1NTN3Qz?=
 =?utf-8?B?dXY0YjFLSVFxbFNmcHpkVHlrSEVVcC9BNFA3c0pCRzgwRkFEY3JuaGJ3VEY5?=
 =?utf-8?B?RWZ0STRRdCtxUVE1ZHZGZXJrRFpTTklHMTNJYi9YZ29PenJVQmQyZTlHcEdP?=
 =?utf-8?B?eDRTMXQvUzc1Zi9EU3pVaXdkSTY4NnNmWm5aTFdZdlFxUzNzUkJwTkZNU1N6?=
 =?utf-8?B?T1lCcUxKZTRvWXZ6VnJwOG9aTmhiN2dEYi94RDNpL2RFVkN6QjRVMEp4dE85?=
 =?utf-8?B?OEsva2dQZ3h6U21HcVdBcWRyZCtHK0YvUnlGT1poUnJuV0RWMG9KMGdoaC9o?=
 =?utf-8?B?KzRIa0ZkWTYyNzM1eW92RmFhRmFkb2xkbEtRQlNSQ1BRNEVrdWpXdTR6bDU1?=
 =?utf-8?B?RUo2b205RkticHJ1UkgxakU2ZXRZOVJNK1ZPL0ZCd2Uya0pvV1JTTDFzcis1?=
 =?utf-8?Q?rppUeB8nT5vorS1bXDi/d0+D5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643e384f-7b24-4449-1e7b-08dd6d4b8a0c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:22:16.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zz/BeNYfHFJc0pc1qH1gUYKcTzGNByNJn6ZM6i7LDz4hN3DLLHE7dxXfVLg1kJgKQ6As9nlBBm+o3x6sqd0Oew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621

Paul,

>> If rtorsu_hrt timer is still in timer_queue, invoke hrtimer_cancel() will
>> remove it from timerqueue and directly return, so the rcu_torture_updown_hrt()
>> will not be executed and the rtorsup->rtorsu_inuse cannot be set false.
>>
>> How about modifying it as follows:
>>
>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>> index 04d7a2173b95..ecf3d3797f7e 100644
>> --- a/kernel/rcu/rcutorture.c
>> +++ b/kernel/rcu/rcutorture.c
>> @@ -2502,8 +2502,7 @@ static void rcu_torture_updown_cleanup(void)
>>         for (rtorsup = updownreaders; rtorsup <
>> &updownreaders[n_up_down]; rtorsup++) {
>>                 if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
>>                         continue;
>> -               (void)hrtimer_cancel(&rtorsup->rtorsu_hrt);
>> -               if (WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
>> +               if (hrtimer_cancel(&rtorsup->rtorsu_hrt) ||
>> WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
>>
>> rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs,
>> -1);
>>                         WARN_ONCE(rtorsup->rtorsu_nups >=
>> rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n",
>> __func__, rtorsup - updownreaders);
>>                         rtorsup->rtorsu_nups++;
> 
> Good eyes, thank you!  I have applied this fix with attribution.
Could you re-send the series, or should I apply the fix the patch myself? Or
provide the new patch inline here.

Thanks!

 - Joel


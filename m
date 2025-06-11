Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1FC23C516;
	Wed, 11 Jun 2025 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678564; cv=fail; b=tyyfp8djw5dcoxTPOSISIz76+ssMKUPPC7Vc1vCEBfPy9rePW8Mr3KB1Cht4slWPV368NtnBwcRuQ3H7lbsxaXOIILwaj23znSa9PDQnqZOxLI55vfqzCYRWtowg/X+NUQ7qOtyJorWMqzimHGgphePbCQxFUdRPPuR7u4X+ROQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678564; c=relaxed/simple;
	bh=XpxX2sVlf8pezQtolChXSDu9H6ltm2EErib9f23nAQA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kh8cVDrGPRM2g/Ncu24qRynYQcsxo6RQpAifDyuHZwXsfe69BnWTDiO+dFqKfv1DqR+RY8cnAF+I5nK3aMOc2w2m+Lk06ogZONtMQLRuTyEHIjS+3zvELY6zJaZroH7x9YPEH31uWyDEIPNo90TED4FkOJicgUiXzVWW0FwI+MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GyxJtQN2; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GyxJtQN2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rf8xDWO5yx8KVn77ribXI3beY+forZeXXj3geW5vpYgu3uCpmbToBQVljL88N85AAAXUvP3fjDvBcN7lpTkHJwFYJlN8PZCSZZvzDUlxlXOYgpeNdiyZt4ZBhNO0ozmV1mQNnmXinTQufjfEqky9yzc1KRyH1+arodRHzg+xcPP+Wds5FweAGLgC9vilbFxtkHrZ+Tiy5/G9RUF1sgw1RzRNdS9l8HLhHk+te1v/3yjk6I5vOdepDP9FwB05IPUiE15BDCFoDNrcY5JsI6KX59Cajk+++athac4jJJXR2e5J40JHm/PGnKahAwddE8u+IRjAqOBp9AjHGuNYobrHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+nqXGlthLLuStUBQvOs/HkL7pKo+SW7W5LafsykX7s=;
 b=r4g6kD5iMCd3VlLR09Cu3x1jnvHhY2C6+ZfSZcGGKI5BlPi8yFpdD6OlSlbyBCPy42WXXltSVdHCP1MvKASa2FlnAIUse0sRG0WpcJ0Vj4Y97AXtxdkR12kogegGXT5AnNh1Iy69WbOir9s+pHWVKSQgfo0f6jHRtg20l+bEQhztx0rQGrXPsD4mxGwCzyfJlLzmndaD8rsIYUnLEqJvjMcZKOZHLvQxaK50E7DJUv8jGjJ3JP8qAP/uJqdiMcvXnVD4+pQQMH3GBHvPB8iwxhrkvTcCmDEHD+9zc5nSBqFotpF/jGyiHa6aPw6PUuN3ik2pI1BFwAJ28geotaTVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+nqXGlthLLuStUBQvOs/HkL7pKo+SW7W5LafsykX7s=;
 b=GyxJtQN2JNAIGVdTNQRGKK2un8msFjJbCSV8vCX4cPmb2CHYhDtWSQBkRhjoGtP9Nov97nHwM4qf1ZjyG/+8HXxEUUgTIzePYnogoWTO1eISQYZ/hoMkOe9EFqW564BivKLQJh2uxYoqi8PkWMOlBgvtkCQ70SGesZeXOpI8AxAvqKX7du0Fa/xQdqZdwWgQ1QxrRfNqTItWGVSI+Qe4T8oq44DZ9gPR+AUf4Po9YK5wnLsMTIUPtPrSOMgKXdynWJ0XfONWCeQHq5TxBfYktVGiTMKczgn26nLzRXdlz+Osbq9rFIGZkzpR8OSCaXC+a+9jimT2LcEtcwlvcbHSyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 21:49:16 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Wed, 11 Jun 2025
 21:49:16 +0000
Message-ID: <fcac9488-a755-40a3-a643-b7cf7288714e@nvidia.com>
Date: Wed, 11 Jun 2025 17:49:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Documentation/kernel-parameters: Update
 rcu_normal_wake_from_gp doc
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20250611175658.91361-1-urezki@gmail.com>
 <20250611175658.91361-2-urezki@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250611175658.91361-2-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 95512fa0-4310-42bc-6804-08dda931cfad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVJBbXd0WUVVaThpOExJUDZOVS9jbUlWZytraHdlQnFzL1NUMzVkdUloaTgw?=
 =?utf-8?B?WmNhOGt4cUR3WXRGTm9hcG5PWVNsam5JUUV3Z0Vma2RJSnlZM2U1T282Tkk5?=
 =?utf-8?B?MlNDQmJSMTk1RUg5emQ1R1dmVCtnU3IxNFd5UEExbytpQjZGc3lyMzAxZFpP?=
 =?utf-8?B?dlJTYlpUd3puNnRVSXFOZkNham1yZUUwdWNFeFJHcnNWK2diVjRpN0c2dlAz?=
 =?utf-8?B?MmVLdU1NV0d5ZFEwUGplaW9hZ3dJalpYMkdBbTAxd01hYVFVWlpLZ3poT09I?=
 =?utf-8?B?cDFTTFNRanZWdS9KVGxJazJwbHNrb2JZSVlTeTI3eUE4T09vYjVUWWpmUDBm?=
 =?utf-8?B?d2s1VEx6WE5FQmJJeVZmWDg4M1VoUUgrRXJLQzJWZEhHK0xjVTcvZjBGN1dI?=
 =?utf-8?B?anV2SEcvODh5NE45OW9LY0o5R1NZS09wVGJwNWVldkdkQTY4ZWVVVlV1cnNM?=
 =?utf-8?B?cUxDT0N3U2Y5UExpeHFwLzFKNWNmYXpXclJ3Uk16QUxDNDU5UzZTWGhQMGRN?=
 =?utf-8?B?d1BXUmx0T1owZ3ZVaEdyMDFDcWJMZVpBOFB6ejZncDQvRkZHYWxIWU5zRTRm?=
 =?utf-8?B?Qkhvc1pHejdMaDRHZzFPZlRvRVhEZE0wcEd5Mkk4N25jQldyR2UvditlK2FG?=
 =?utf-8?B?Njh3Z1R6MHRqcGFFTi9yaHlFNHdyb2pZeG80QlkyTFZJVys3OEpHeEZyMTlm?=
 =?utf-8?B?aTkxTnIxTkU2SmpYNjhHLzRybml2TTYvUWk5amo4aFM0SVhGamtEYWg5ZitD?=
 =?utf-8?B?TDhxUWhTUm9ndURxMndMb3djV0RaakxOQkdXSFF4eHB0OWJKSVVKSDlzYVlw?=
 =?utf-8?B?V2tiQUdNakFJV1VmMDFTeFkyRzgyWnNFUWtRMm51TlNZekdFUk5OQ25RN0VO?=
 =?utf-8?B?YThUV3BaTlVtRTc4VjVTRFNjdGRaTlEyNGFSckNlME9VWVhZelcyTHJEdWZW?=
 =?utf-8?B?alVJMVlHSHZLNDRjQ1c2Nm1BWVNsRjdhSGhZL2s4cXNVaCs0RDlJTkVwL0li?=
 =?utf-8?B?SVBKNTRPeFVzUG1EUkVXWTl0a0lCRFI0RmM4ellsRWhKNUxtckdGOWsvZVNG?=
 =?utf-8?B?Z3J4eDlwYkVIV0lNeGZVeWdKZlEvM1A4NHBMTXVpK2h6NElPVmNxMlJoQ1h3?=
 =?utf-8?B?ZEpQdXZYenZEZVhqblNaeTdXT01EUDVXZXE3NlJkYWFIdmlsZlB0VVppWnlP?=
 =?utf-8?B?UmcwV0V0STNrd1psc1pBYmRMRFhhVUE1RXlLQzJ2MktkMEh6Q1hLbThudThk?=
 =?utf-8?B?WXcrd0YyT0FIanhtNlJaQ2k4aHVTU1JrQUk0NE9kWWNSVkxLMnhadzZKMEpt?=
 =?utf-8?B?RFhVUEVxdTkrcldEOGQ4bnAzd3p4M3dVcHZSMkpsdFE3ZHlTYnQ0UklRRWFR?=
 =?utf-8?B?NG1hRi9lRVhxSnpYZ1BMczVSbFBqM1l0bmE1WnRNZk1BenZTSVA5RjdSQ290?=
 =?utf-8?B?blN2RFVXRzhqRnY2U2xaZjRqZktSYjZvbGhrWS93VXV1N0xhK3pPQndqWm01?=
 =?utf-8?B?YkhWQXNPQkFSR2l6Yjg3eHp5RUJSZWJBa3lNZ0xRNThIYmZFTVNObG5DT1lB?=
 =?utf-8?B?N2NwL0EyeEIzd2h3Q051eVhZWnB4QjhJMHVRNVlqcjl4Y2h1dnFwZmhHQW5Z?=
 =?utf-8?B?MWtOVDRMMTdPQUNHVDloVE9zbmFmNFVkRUVhRzgvWUhLSHp1T0gxMmFFcVU5?=
 =?utf-8?B?c2xZUWY0WnQ3WEtPdFRESFJXeGd4bXlEa1VIQnpzeDVOaFNmUzFEN1JXRmZ6?=
 =?utf-8?B?ZytSRTFLRnlXcEVvaURuTGFWRmF2WDFxd3NwSDRUWjczaWNxV3BZSXZGUElP?=
 =?utf-8?B?eGhJUHFtQmM1U2xaV1dTOW13SUgyZmdzWHJ5ZWJOeUNqbmdjdnVjVWJoQ1c4?=
 =?utf-8?B?eHlvY1BqNjY1R0hreXEyOStxZGpCaCt3L1NkOWRIaHJ6OVJmcE4ydWwweEp0?=
 =?utf-8?Q?pNviNFXH86E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDh1NTJBN3lPV2QvdUJ2S1N4UnpNRUlKNGZvS3FSQnR6NHovektJUEpJWURj?=
 =?utf-8?B?TjVkMGs4SzhQRnJGZXo3Y3JFUnVMaDVqWEtCV1R3R2tpUldXNFplSXpoUkZi?=
 =?utf-8?B?VzEreUx1eFNza2RDamJBTWI0Uy9vMWgvSm5BWGo5NmRjK0N0c3RobWFDL0E3?=
 =?utf-8?B?OWNySjAxMm5qK3FXMEpTNC9ubHNzTmMrWER3dEJHTEMrdnhNRm1Bb3NlbE81?=
 =?utf-8?B?YU1LVHVIWENoSGJXdFM2ZHRzTVdkT2JPR0RTeVhROXBRMXV6UE90TVFPUTRU?=
 =?utf-8?B?UmkyT0IwdmhOYXEvcmZCNm5Ca1g1SnpKelpLaEpRQk04OTZzRjVrdmZOTVFB?=
 =?utf-8?B?ZFVCdng1TS9IODI4TGhVYUt2NVROazNBSnhlWjVvU2tsODlCU0N3czF0RFRF?=
 =?utf-8?B?WE8vR1VJNmg1ajRpWUwzS2pjQUpVWExYSDVEMTFUOUhCdXczdHZqK1ZTWmtS?=
 =?utf-8?B?c3FlbDhxU2VsbG4yL0JIbXZ1MkRrN0VMUHpGdFJ1blRtUS8ydmdiWHBYRExQ?=
 =?utf-8?B?Qy9PQk5US1BDR3JCeXVvdHdCYW9XQXVIMTRKTlIyNFNrbmJsMXRRRWMxRUFi?=
 =?utf-8?B?VlhlYnFZRzJSMXVEQVN4YjRneUZ0a21NajB3WmtUUURHWnl5ZFp5YjE1YTdm?=
 =?utf-8?B?RzJDakY0c0FEOVJkUlRPbXZmMTd1bE1RZzgvdVlMU01TYlFEb3JtZXdNa2RF?=
 =?utf-8?B?RGxVRFhDVFIwZHNxaTNGN0F0TmpSYnRiSUJLNFhuYWJBd05OeXRIeEdyc2RM?=
 =?utf-8?B?SEgxdk45NVNFK2ovOG54eTlTVVdZc1praGNWV0UxMXY0OXYwcldXK21CVVIy?=
 =?utf-8?B?a2Mza05BL3c0Z3VrZzdsam1pSWFzMW1UdlRCZTcrMlB5Z3p2c0VWUmZTTnBX?=
 =?utf-8?B?SHlCbHZRTWxiMVpwMUJlNjR2N0Y1aDdzZmJ4T3FmZDNQOHNtWXY2dXdVR1JH?=
 =?utf-8?B?RDB5cEpZVWpmWTlkS0g2QlB2eUMyOG9Ja0JIcU9TaWE5a3FLR3FIMEdoREZP?=
 =?utf-8?B?aUtjMHMvY0J3TzRDNWpycmxTbnJkeHowK1hXaEdJMGJsaDFaZER1TDdRL1dq?=
 =?utf-8?B?MW1odjVyb21DU1NKaStabnViQStmU1FEVjF1bG9yb2RqUHhOYWxtbEMrU2Ex?=
 =?utf-8?B?SmxzUmJVNTgwTkd5ZUNOZHlJWnl0dFQ2VlBla2xLejBDMHlOZU9KWVpNbkZh?=
 =?utf-8?B?U2ZVWE9QbFZoWDZ0aTJhWUR4TUdZaitKeXVCbnhjSmhWTnErNmF3VFpXNjhP?=
 =?utf-8?B?VnNpaEpQQzhaOGNhNnMwdzFYYTRGWWx6T29ucUxzQkRETUhNMVlYMWpDbWJy?=
 =?utf-8?B?SVRsVjV3emRsMFlMQ1g3RUd6alVuMytKeERLTHFZVU1hMDNGU1hIbG5vNk5a?=
 =?utf-8?B?Y2lXY09JbExEZnBjTS9SYlFIZThNTmFqK1hkSXlZc2RmOWUvT0ZPdWRrT0xH?=
 =?utf-8?B?bVRLVERidWtDanZ5L21zUFVTNldqOGdXamN1b2srUGdPcEUyYllDUVhEUVBm?=
 =?utf-8?B?dEVCdXdqVkk4Z1YvVklQRDJvb0NPQU9pUXVJVXF1eDhDeG5TejJDUHlDR21k?=
 =?utf-8?B?b3N5OXQzWFlQQzNiLzR1UHlMMFFSQytjd0pEekJwcXp1S3lVZGNLWHkzSkVJ?=
 =?utf-8?B?Z2pJNnpUd3BFSTBDRjY3THdKUnVwRHlRWkNuUG1hSkxxNjB5MzVxMzNSYksx?=
 =?utf-8?B?RjVIT3RFVzRNSjcxMWRYd0haazhsZkpqVmxFSTF5SkVzbmg3NTZXcWp3bEVh?=
 =?utf-8?B?R2ZyK1Q3a2Y4cUZrVjgvc2JpbDB3SnlCQk9POUNEa0Exa05qWnkyK2FUSzhW?=
 =?utf-8?B?TlhrTlp4NktCYVNRVW92RTdPcEx6NjVib2N4M2Iwd3BIQi8yRHV6SG8wajIw?=
 =?utf-8?B?c0w1YnBSRFBrUVNKdTZGR0Nyem1nb3hVcHhtMFZMT1U3ZVg4SjJweWdmcnNB?=
 =?utf-8?B?ZGgySzVkTmR5YTVKTng5ZVVmOW5OZk1Ya3JHem83Nkhlay9aeG5rM1pGSGx5?=
 =?utf-8?B?V1kzUC9nL25DRlRQcHlmcjVJN29DR05oaG4wWnhkbzlXRktCTTErVERkQU9j?=
 =?utf-8?B?RFJJVzhxNjdxcGI0Tzdua0dwc1VXTXNkR0tmNUk0MzdOL1I5T0pVMDU5VXZ0?=
 =?utf-8?Q?zn/PQvuCquluQiKamPw4yvBum?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95512fa0-4310-42bc-6804-08dda931cfad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 21:49:16.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTo3vpQKi8OslxXM97eQ3rTurkOIKs6pTNwAPGmECcEU4Ojlu/6VarQwAzFLnoWo7IAHIZN/VvSxbpIglMSqSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478



On 6/11/2025 1:56 PM, Uladzislau Rezki (Sony) wrote:
> Update the documentation about rcu_normal_wake_from_gp parameter.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks.


> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f2c0874da9..f7e4bee2b823 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5485,7 +5485,8 @@
>  			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
>  			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
>  
> -			Default is 0.
> +			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
> +			disabled by the boot parameter passing 0.
>  
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous


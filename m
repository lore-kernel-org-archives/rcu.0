Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022133.outbound.protection.outlook.com [40.107.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7322129B
	for <rcu@vger.kernel.org>; Mon, 15 Dec 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765827526; cv=fail; b=qLhe1WpluLBQK31equp2681roGMhn+b3QZrP7NupssDCVZHdZLlmnTbdXi5uaJIqtdmMXDD2OL4nuIgGmU+1OpDeO3b2R3UdjE1cNyYlbm3TGGB9uOMqOHVGD3A2jjFclNfhGOgaPltaAizTdrKWv0AQv11KMNhGO5hX2Wkuv4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765827526; c=relaxed/simple;
	bh=s4BjjEVrKgJbWcPAvuMJdPk7u9gYZgA1ke1z/WwNNlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pmE6o/areGIbsnYZ8MuyUEAMEuPusdWRWqhOWHIOhi7hYrnV1185sLfwnrynTK8XED4deZku/NayTfI8eJW7dNJzmPsml7CJoA3NtYpLhy/7mqdQaSmzG87WufFzzZzxSoitCrmLG4Ddg/Fqq+KUdnVfbv2B9PJR7G04Ffaa1cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hPGRdByA; arc=fail smtp.client-ip=40.107.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hPGRdByA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biJcywfiiVEIRRzpp9k9lKyTXkuG17WpcLqbD7jnAT7B+U+ksIPUbA/5HDUG42Mc0Gv5FnAspwwbQ9Auhf5QDZQoWHqf3PTnNW1P+9sC22LgW8FSjru9FFqB00sOgTCzEDeERWSgmpI3vkfqy/+Ea+FzZixUdpiyc4/3QkCRM8VrZbk4059Pm+xdcsQY89CmClYG7gTYBqDmFYIRog/NkVksc4w6tdcYo6ikYvleVzrNJNjXl6oWQ8pHplCUiPonxOLqPWn/u7BctlhmvIP1nYMIABe4wFSG8ottFJaEcAtz73tkv3lwY4u4WQVKrx8sOoNiPv1QcniLTX00yDLF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LJk9BdYgwGtFIdJhRWlYHUfvHnaP/Il+/NIXqDAwBQ=;
 b=FECwa4ng5eEcXtJfc3ODXeb4s9WmCR+0qTKbG7jd6lQwDAMB8+c8vQbFx3v0pb0p6z2xdECfdU/p8b3grI7YvDlzfMxmEYIbEp3bEjJv0B92APhHN5JqjBaA86U3txHzmGfkvygzoRSNVGPI/Am1HMu5DMP6T+8Ih/990sAOAVkH8/M7LrK7BO6ZcFCfbKFFVgqCdMQi44SqQNGZXdhNoLljIJhVSJl9po5kjSNYPXICyd2KrqdGAaLP5LSjIcHTqNOOYqBwOktB7qY1JAHaxUbUznIFShXOUIZfgDj1AemT7oyOCeU7fc7xcl+6XXWbbGlWOQfrCYrY02HyQFR+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LJk9BdYgwGtFIdJhRWlYHUfvHnaP/Il+/NIXqDAwBQ=;
 b=hPGRdByApFZTHB1TfO1UcFtcDWfAXj5fwp59ut/zp2AdHuvq1y6qICaWfiFrRHDz8y+yCtvf4ciG2oYR4AZ+SexAoTO18CqkZrYSXaN5NvCVKV2GvlfJqt8xB2rXw3yKhtPYkTzQIHzSFlwKWKTtc5J4HZRnA2GUgwVdfcRa10T0H28BqISVXpHjm+EcdQMOnNtSjvFqKuJF4v2LJunbvjrC/FBYkCZrQgyV1/Xl8FuFX6DiKkyuQE17Tt/NdmtQ6UhHtxK7N19ltN+zC7ynt/9uIfjZHFL+Zx35m60D0SAhkZaqAkCBJOLDY6YaIDj7VIIyRFVOm04pMignaff21w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9243.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 19:38:42 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 19:38:42 +0000
Message-ID: <6661a53b-918e-474e-b3d3-ffa70c39d667@efficios.com>
Date: Mon, 15 Dec 2025 14:38:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Handling large numbers of hazard pointers
To: Joel Fernandes <joelagnelf@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>
Cc: "paulmck@kernel.org" <paulmck@kernel.org>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
References: <1ee9bfee-d754-48db-b72d-763193cb92ca@efficios.com>
 <31331836-E9F9-46DF-A8EA-010379A56677@joelfernandes.org>
 <EF62E36B-7A3E-402F-ADA6-A1D443DA0ECE@nvidia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <EF62E36B-7A3E-402F-ADA6-A1D443DA0ECE@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::33) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e895079-2d96-4962-d5a1-08de3c118d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlRyL1Q4Ujk1SEdmdHdGRUtReDBOV2VpMHl5a1pJSTg1cXh2U2ZjOE9HL3Aw?=
 =?utf-8?B?bnNqdlhDUXNHODcwV01PbmtGOWJrbVpMV1hhd0pTMDhDb3d3V082SWt4KzNX?=
 =?utf-8?B?ejkvL3ZOdVdxNGM4NVpMZjd1RnBHNTVLMzhhM0prdURyb3lLOHBXTzhwMHl6?=
 =?utf-8?B?OXV1MFVydlpZTVA1b0J3OEY0QTZTeGhQWWhydE1TZ3M1L2dJS0NaTHNlcnlH?=
 =?utf-8?B?M3piMnZCRmlydTRtUTdodVNUN2kzTmlUVE9udkxLNkRwQUtwcVF1Z0JlSGEz?=
 =?utf-8?B?aENpL2lYTjlHRWNEbFBIRWtTTmlEVzJMckNEZFV4QWZLTW1TR3dLeHo2L0Yv?=
 =?utf-8?B?UFVBU2FJRGRtNEtoNW5DckFwVzd3MDhKR1dvUE5iSzkvdHlTSDN1eWFpeURy?=
 =?utf-8?B?aTRhakFBa05ybTRiMUJWKzZHMU9qL2dJMzZiT1hFRXNjbmYrZlFIOU5GNTdM?=
 =?utf-8?B?N2plSUVxWVVodnptYm44MnNZNDlNSlQrMm9TQ3cvbUtnVmJHODhhMEdocExH?=
 =?utf-8?B?RDRtdnlIUE1TWFZ3RTRoTFoxb0ZVRjQ0TzVoWWlkVnBndVpwMVRpaG1kaThB?=
 =?utf-8?B?b29wTVkzL2EzTEJjd2UwSjVBNk9NMG1KNWp3cml2NW5OaEUxTUcwWWd2cmk5?=
 =?utf-8?B?OG1zSEUyL3ZmSmxDNVNCN2pQTWNjNVdjbUNwdkQvbys2Vm1MUHVFVHhtVFh1?=
 =?utf-8?B?cjNNU3VFcFpxRTVFUG1NcTFrTzR4VS9iUm9ibUhCd0xPdXdla2xIYTM1L0RU?=
 =?utf-8?B?RUVKNUNtV0lab3Q2NDR6UVdmKzFib3dBdzk2dXlVRFpyNElWaFlkSUJReFE0?=
 =?utf-8?B?NWVWeFJNMHRBT2tRVlBLYmRVQ2hvc1dSaGlZVlVmUFdhWElDRXhCZXJSeTBT?=
 =?utf-8?B?M0NnQllwcUhaRHF5WFE5NEJGU0NYOUhnNm8xbG1uWFEzbUxUaUthTUhVeVNv?=
 =?utf-8?B?Z3BVMmlEdkl5ZjFCMHZvbWlIVnVWU1RsdDJaS0grQXRSdmIrWDRiNGppK0Ur?=
 =?utf-8?B?WGU3Mm9Iblg5K2VMMzZybVV1S3MwOVJiNENaU1VPUFVTUzNSclVoWUEwUitK?=
 =?utf-8?B?dFBKd3RkK1dkcTFuc2NvWWZIYU14VnYycHM4cm03VCsrczY2WlpkNnYrcVZS?=
 =?utf-8?B?QUJicWdFVkJlNnJ5b1BuU3F6aTBWbkJRWUY1OVJlOUFFNVlvTEZpV1NYSitS?=
 =?utf-8?B?dCsvcXBLQnRGTFhmTFRFODZMNVdvdEhndXRiMTJlbjBHTlZ4cG1OKzZQeUlR?=
 =?utf-8?B?S1h4ZTdhbmxtYWd4UDB6dVIxM1JpUWZqeGkxYXI3TnJsZW8zc0JkdVpEcXl0?=
 =?utf-8?B?TzhKM0thRXR4eTNhOFBwYVdITmU5eC9KdlJYcFFrSG4xUWdNSlNxMFFHSm9N?=
 =?utf-8?B?bEkxT1FaUDRDNkVBMHQ3YTJDMFMwSm9jMURmaGxKSDdzK2t3SkUyc2E3YTBL?=
 =?utf-8?B?dmw0UjNocEE5dHVTMDh5ckVCM0FXNzBWNnJ4VnU0YndmUUo5c015SFhrTTdq?=
 =?utf-8?B?TUxBQ0U4Sm1BMWtmUEQ0RlZ2MWJNREhEZmNPSnZpZllKSXdNZnBvczRvdndj?=
 =?utf-8?B?enNrbi9tVC84RlFFQVhCbkU3dEsveW52amcxZU9FbmFMUWRWeFB2QmZHcysx?=
 =?utf-8?B?MGZieGgvZjhIWlNTaUpxLy9QV0RlaGpwMHdQUDZNUElkcHlxdTFqYTVJM0c1?=
 =?utf-8?B?RkUycXVERWVTTENPZTFWaE5nNGh5L0t1L3pYRm4yQUtpTnNZcElTUkxUUXRi?=
 =?utf-8?B?ckMxaGVob2JYVmgvTGJMbEV4MkZsWU53RCtnRWhQYlYzTldEZ2QyaDgyNjNp?=
 =?utf-8?B?R2EwSnBZSzJJUzRYQ2RMSHNZWmJ1VFRIaU1uNjltckkvbWRabzRhaEFhNEhS?=
 =?utf-8?B?TE1JVnFEN1hSeGs2MC8vUFZPeHRGbjBjQVpoL0szQ1JaeUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDMvNFp6c1lZOHRQK0VtbEgyQTVYU1NFQ1RjVkU1OGVxZmRMYXlNQUk0T2Ju?=
 =?utf-8?B?Yzhrd1FIZTJ2YTBGQXRueitQSHFWK2YvZG1oWHRLbHVjY1hZZDZQUk95Q04y?=
 =?utf-8?B?SlFwVEdvVGtvM1ltS3FESzdsbllrS1BoRDJBcDFvRU8zT1loR2RaTVk3bSt4?=
 =?utf-8?B?dFR4UDJZeGxQZU13TGtLTXZ6NmRoQytoYm9OcC9FYmJoMzUzT1BVV2FXRkJp?=
 =?utf-8?B?UkxOWmFoR0xJMzlabVVTV3NBaHh0dUl1eHdaVUdTRmNQNG54aDdWZzVUd3JB?=
 =?utf-8?B?b2toTXBwems0bnVwOWNPMW1mTEdUeGh4TE9qUUw3MjRvbzU0emJVdlN2aDEr?=
 =?utf-8?B?VFRkOWFQY09sanZvK242UzlEcEZNYTRuRVo0aVRtVC8yaG1ncnlncElmNWNq?=
 =?utf-8?B?MDMyblQzdHhSU1FiVEJJeDJ5TkJBL0dWM011YUd2eVBQeGxlbVNKK0VnZzNw?=
 =?utf-8?B?VTB6bkl6SUhZSGdkemg1eTFOVXBTbk5wZHVONTFBazdTb3VyS0hleUVFc0Zh?=
 =?utf-8?B?WGc5RFh2M0xOWVl5SFNaa3lDNWRnYTd0NUZ1UHV5K3BXWFM2SEhpVjNSK2Fa?=
 =?utf-8?B?VFRac1dHai9JNkV0ZlFGZ1BMcE5qU3dWdWxFc2lIZUI3UG5VdjBlWUJoNVZ0?=
 =?utf-8?B?Q09HaTBRMk9zS3k5dXhXUHcxcU9IU2hjeXFIVTcwVDhBRUxoNzFFWFpUV1Uv?=
 =?utf-8?B?ckFETVZvdnkrdnVwOUtVczhOUEZCNlBMSUZpdVFvSlZoMURwVmk0aXV4YUJq?=
 =?utf-8?B?cVVUbks0TFpXVHVDN2V4cTFBblBLSHhkOE9leFN4WDNibE04QUYzRmt5WGVM?=
 =?utf-8?B?RXp4dkJWbFNFRG1Hek1jQWFhWm5iZGdrM0U5RUxQTUNWS0Zab2VKMXFYMEVY?=
 =?utf-8?B?aDBrWTNKNThQUVNtekxuQ1ZNbHUrOTZMV3A1eUFVUmw0ekcwRXFuUDVWNVd5?=
 =?utf-8?B?Vkd5ZExiL0hVbGcvTFJRVnlJQ0xMT0NNUVgwbVJ1MW96Z3dqK2s5NTF2cmRV?=
 =?utf-8?B?RFQyOGY2WjJPSUQwNVZnMGlGN2ZwRDRYemo4RXFtY2hrRVRMQ1hUTVVOcnVy?=
 =?utf-8?B?RGxrQnd2WXUxTXNEZ3BNMC9VREoyUkFVNmpaN3Q2S3lTbmNVRm81cGMvM1d2?=
 =?utf-8?B?L244VFhzNldiemdFbUp1Y0ZYYk1ZQTQ2dC9lMkh2ZVpINHRTd2syc29UR3Ns?=
 =?utf-8?B?RDV3bmdzMSt0dU9EQ3ZLSWFVcFVvN1lITXRwK1Q1dy8rQlZMY0V1V25VNWEz?=
 =?utf-8?B?Q3JhMUR6RU13cVIwYnFra2RJL2RSZ2hWcXZYb0RrMVpGdjNvcHBpZzloTjdR?=
 =?utf-8?B?aFl5UUh3SWtpMlZPU01ZTlVLQnUraHBmYk05SXBaak45RUhUbE4xWVdYRXRI?=
 =?utf-8?B?WnFrNTd2U1Jpd3N0WDh6SlVpWGZxNElaMG1ZM3I3MVpodXFxR3VKRTZPUDM5?=
 =?utf-8?B?dHBRWFRaWSs2TktwK2FMa1R6eVNLWFJzTG1WUGJyQVFydzV2Q20zaC9rZlRP?=
 =?utf-8?B?MzliU2VLTmQyY0kxWXVuRjdMZUM4NGNSMjJOYllQSmNwZTY3bXQ5Ri9yMGtH?=
 =?utf-8?B?cEFUSVkvUnNmS3RLOFhSZ2haUU5tU0xXcVk0UW1jbWcxQUJGM2NKZFU5WURD?=
 =?utf-8?B?QVhEODhUVnF0NDlUT0dOeGJiTkV3VXBEQ1RrZ0kxZklZQ3VEdy9QYldrVTFm?=
 =?utf-8?B?MEQwR1d4NDNqbmU3c1MzMG52RTFaZ2I0blhmbmt2bnpxMnlFQnFYRHVTUUlM?=
 =?utf-8?B?eGhtL3l0cWpqV2JwWmV5V2x2Mk85eXIrYnk5T3pJaGFheGplNnB6dHFxN2FS?=
 =?utf-8?B?ZGhLbUR2OVFja05tODdDK3dsOWZGQk5ZcGh5bTAzR2licTVzcU80TWJyNkhD?=
 =?utf-8?B?TndXVWZKdFNlMExpZENhMk04ZThDV3l6dTUvaVVWczJ6R3lQZDROM1Vna3pr?=
 =?utf-8?B?a2FCdXMwMytTQ0ROUHZLK25lTEdKTFV4Z05xSVlHTi9pUGNTUHdYdE0xenBj?=
 =?utf-8?B?cVdoNFM3c084MWgwdlV3OWpUREg4L084aFNRQTVnRGxIU2F1SUFnT2laV1ox?=
 =?utf-8?B?Yk9rYWwxU3JQUDVPaHZIeW1FYVpIL09DOUsxU3BxaVJkZzlzOWpFVWZ0VkhV?=
 =?utf-8?B?ems5U1E1R0xuRmFrTEcvTitPYzB1cllrVG1Ma1dLY2MvdjdMMWJsY0w2NmVa?=
 =?utf-8?Q?jUnJtLMNKCC7n9x5iDSU05M=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e895079-2d96-4962-d5a1-08de3c118d5e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 19:38:41.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6rBU6gyRKvbh44IkMkOAEhfJrfRcJ6KpGw/5BQKFrqgxsIBeepl8ObHkkwVRYrvtmzdPxvuitSLJV+L+Jyng9URfRBWZfhKmovxAJVupfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9243

On 2025-12-14 18:26, Joel Fernandes wrote:
> 
> 
>> On Dec 15, 2025, at 7:36 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>> ﻿
>>
>>> On Dec 14, 2025, at 10:43 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>
>>> ﻿On 2025-12-14 02:14, Joel Fernandes wrote:
>>> [...]
>>>>> We have had similar issues with kfree_rcu() and running out of preallocated memory there meant we just triggered a slow path (synchronize) but for hazard ptr I am not sure what such a slow path would be since, since this problem appears to be on the reader side.
>>>>>
>>>>> Perhaps we can also pre allocate overflow nodes in the api itself, and tap into that in case of overflow? The user need not provide their own storage then for overflow purposes, I think. And perhaps this pre allocated pool of overflow nodes can also be common to all hazptr users. Ideally it would be good to not all the api user deal with overflow at all and it transparently works behind the scenes.
>>>
>>> With the preallocation approach, how can we guarantee that we
>>> preallocate enough, and if we cannot provide that guarantee,
>>> how should readers behave when they reach that limit ?
>>
>> Sure, see below.
>>
>>>>>
>>>>> I think we need not worry too much about cases of preallocated overflow nodes itself running out because that is no different than reserved memory needed in atomic context which need a minimum off anyway right? And we have a bounded number of CPU and bounded number of context, so the number of *active* nodes required at any given time should also be bounded?
>>>
>>> So the "simple" implementation presented by Boqun at LPC2025 was limited
>>> to preemption disabled context, but in general there is really no need
>>> to require hazptr users to disable preemption for the entire duration of
>>> their hazptr protected critical section. This means that tasks holding a
>>> hazptr can be preempted or blocked, which increases significantly the
>>> number of concurrently active hazptr we need to preallocate.
>>>
>>> So I'd rather remove the preempt disable constraint across the entire
>>> hazptr crtitical section if it's not too much trouble. And it appears
>>> that backup slots preallocation is the only fundamental reason that
>>> would motivate this constraint so far.
>>
>> We can remove the preempt disable constraint and still not require stack allocation by simply embedding overflow nodes and any other context, in task_struct right? This is similiar to how preemptible-rcu tracks readers.

This misses the nested hazard pointer use-case, e.g. one function keeps
a hazard pointer active while calling another function which itself
uses a hazard pointer.

Keeping the backup slot on the caller stack frame takes care of nesting,
which gets tricky if the backup slot is in the task struct.

>>
>>>> ... By the way I wanted to emphasize my PoV, that requiring storage provided by the user seems to negate one of the big benefits of hazard pointers I think. Unless there is a solid use case for it, we should probably not require the user to provide separate storage IMHO (or make allocation internal to the api as I mentioned).
>>> I think the solution I have in mind takes care of the negative aspects
>>> of preallocation requirement. Here is how it would be used (see
>>> [1] for the current prototype). The "backup slot" is within the
>>> struct hazptr_ctx, so from a user perspective, it's under the hood.
>>>
>>> The user just has to provide a context variable on its stack.
>>>
>>> (untested example below)
>>>
>>> void *ptr;
>>>
>>> void fct(void)
>>> {
>>>    struct hazptr_ctx ctx;
>>>    void *addr;
>>>
>>>    addr = hazptr_load_try_protect(&ctx, &ptr);
>>>    if (!addr)
>>>        return;
>>>    [critical section]
>>>    hazptr_release(&ctx, addr);
>>
>> Correct me if I am wrong but I am not seeing why stack ctx is required if ctx and any space required can be placed in the task struct (and hidden from the user). For interrupts, we can just use per cpu storage split by context like qspinlock does, I think (unless we are going with the wild card proposals).
> 
> Oh, I missed the chances of different threads requiring protection of different types. Maybe it will work if hazard pointer sections cannot be nested. Or we can wildcard them or something on preemption.

Nesting of hazard pointer users (even within the same thread or irq
stack) is my main concern here.

Thanks for the feedback!

Mathieu

> 
> I am going through all the proposals again.
> 
>   - Joel
> 
> 
> 
>>
>> Thoughts?
>>
>> Thanks.
>>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

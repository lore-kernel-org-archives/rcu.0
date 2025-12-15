Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021100.outbound.protection.outlook.com [40.107.192.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49DC2C2374
	for <rcu@vger.kernel.org>; Mon, 15 Dec 2025 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765827276; cv=fail; b=IxG+wwCl+6YJBz8VVTBBxoGH+s3/il+5HjOhzVKjsV471SVYXPzkLQ0qHt1xlYivNMCHKMUyWRFnT+VKvNtV0qsvumSW3ZLk9O/MfxQIfDWdBRO9xlfqFaz6MAJysAopyR/ApIQ+9vS08apFpPVu3ltsDaG7+Asc6HMjkau1ghU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765827276; c=relaxed/simple;
	bh=6zaVbqefljhbDp0kVe2SQjZn0w9qVt2nc8iW7zweISM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rm6rOSfXGAarp07+SIsJEI1ped70EmYTW0DrJRtPc+n21eYumnKbWQyMz0skxZBKvHocuC69TnvFvvR9NRSCAhO2zgOIYz/bt4qZ6bcZsDYx7pgWVDCONvlv1vITPwTKVr/rtJZGPAaktiuDZj+oX3hgafuka8om65dYImYcZqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mePCioGo; arc=fail smtp.client-ip=40.107.192.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mePCioGo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKWnxVVTdINx0denv4zG6qio6XU/eNrLZKcjR04Q1xdLD1TlzPYuwUfpl8gglk+0UqViG877AGVI5JIjzADxJpaSQlChXoZLHNMMgaOUIM8XNQUX2SSkLrSRni2A8udlwQfBfbqTdhTFxb8EQIeDNAHqzAoSarHENnIybqkf2WvOpxvbsmPnLJ9xnYYRs0cIIXyLZaxfZfiypbQsQ1EHNibDoUM/U5Ov9v+NzF0xe4ZzVIMb+0gvwESCOS+zFWjzOf7Vop5WlLEfG100p0TQNerFf2MXy8irn/HgKEsp9bnplJj5vgd0Eae3UiHxa1V7GOxQFoKLCdKtq7jZHw36Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwyOVPiJtbMkcPE5wESyQpN44lYcXVuEKy/qOHwMlbQ=;
 b=WUl1KKnOQI3koVOOaUcr2gYjpr1Kiv5HSC09IEVPQ8OLmrGEyIIDemdk/r/V6X4ylMDnzEEzGBY4WKVY3c3JeL8iG6u1b2f9EHA4SJBz4QWcDr0AVTLbF2BGcqahZyKEPTVcHV0d3TeQTkEunKRUlrNqPX8WxF4A7ReNDraVSBiTRLwvRrBJbHXqb76dk26Bu61f4Vof8N5MZLNl4ZASerET7Y2lHQtxjmrD9tJRmNnsKZI+dGvSP5HQI6wBNTdPr8qS9QSH2Dw78srDo7EEOuqqwLbIwrzoGNOm10dqKq1B+4TKxC02KPG6PgFJfG/p4PdhUhSZvokNRYvWizbkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwyOVPiJtbMkcPE5wESyQpN44lYcXVuEKy/qOHwMlbQ=;
 b=mePCioGoso3Yy0c8v/rzLnAClzRtl2FaPtU/k2UZikNF/rhfv34OxJaWS1udOPwfafXNqk2njHrPG+rrWucIcNkLnvZdcxu3Dbvm1yqrytVjQvEXB+VbvZqBhs0OMtObYLdv0m5v96n4s7QItDZcEN+Cpue/6IYV8Ax6x1ZtWVUdm+Q5ylMF1ikbPkG1/EKVxnjB+aWM6pTEO89qLg09lOi4ha8h7poKlaI4tNOlj4h05vifmU2JUyPFxnpBWArY/PrcMD+/AcE8PH33xkP83bIR76Hr7Ol+QSV3TWoABgXaT2GVjVL/7MaC9ZBU92XkbA6CnVcNiCkATsevbMH4Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6513.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 19:34:31 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 19:34:31 +0000
Message-ID: <3b3fc28d-3e95-4376-b0e0-e3ee41564c82@efficios.com>
Date: Mon, 15 Dec 2025 14:34:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Handling large numbers of hazard pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
References: <77ffb53f-91fb-4bd4-96d4-e16b0e6ff0f1@paulmck-laptop>
 <091915fa-d6a9-4aba-99c6-d93d9b65e0de@efficios.com>
 <961B6DB0-3071-41D0-9AB6-70B76C547F19@nvidia.com>
 <207B1F17-D789-48DC-88E3-352ECF0DAF11@nvidia.com>
 <1ee9bfee-d754-48db-b72d-763193cb92ca@efficios.com>
 <aT8iw4zfk3sTKtMH@tardis-2.local>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <aT8iw4zfk3sTKtMH@tardis-2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: 652fcdc6-d963-4056-5592-08de3c10f804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDZHYjNqY1RFbzVCaWtXaUlRalNYeWlBMTc1Nnp4aDc1RGFtZjVUcWFmc2JE?=
 =?utf-8?B?TnlJZHNXMHhmTDdzUkxPZGk5dGxSVk1qRjd2Z1N6aUN2a3FieDJqSWRLTnQw?=
 =?utf-8?B?NFdQNkhNbS8vdDlpUWhCS214Mm1VaG5QakJCT3dORkdZS2JwREtKS1pZaGN4?=
 =?utf-8?B?djl0QlpGY3VDRkF2d096WWNnK2VkK1VOQlpQd1NNNVVQQWVudXZjaklZKzBD?=
 =?utf-8?B?ZDJhWWVnS2dIczdWUEJLV01XMitNMEF0cWFIcFZIVmZzUk54ZUhxcElzQ2Fj?=
 =?utf-8?B?dzBqelRDWDRnRkFwbDFQUUdRQ1J5bTFwKzY3UW91QWZsZE1wR2VRbm8vSkZT?=
 =?utf-8?B?c2hrUVFBRlA0NnBkRU16dDQyREFFelVNdlJDWlNyOTFacjZQdHFodnZ4Zkpa?=
 =?utf-8?B?d3YyM3M4UXlQbUROdG1jejhWMVB6cndzRjl0ZW1wT0E4Zll2RTNmZW5xZEMv?=
 =?utf-8?B?YU9RbkdlYXdMUlQ4VGxsWGJYcmd3dkxWUGkxYkU5U2syNnp3ZXZJQW5hMDNn?=
 =?utf-8?B?Sjh3ZE53UHF5QmNZTEdseUtXQlg0aHJZMXR1cnIyQlNtQ1FQdzlRMkwzem1V?=
 =?utf-8?B?SWg3ZW1MMmxlaGhORVZBV3UyeE9WNW5XblBjRDlZOVEyZUxOd1hlMmJCTnFT?=
 =?utf-8?B?U0VIekJmMXp4Tks4MU5DRjJEekhxNmJENjN6OStDNUZ4RGpkVlpFZmpFRFgw?=
 =?utf-8?B?SjZjVjdoU1BFT1ZCWmc2WHBZNGlFYmJiSlVyNTdZaVZQbXpaYW9QbTh0K3FR?=
 =?utf-8?B?WFVFVERSektrMGRUSnc1cjBaaWFFclRERXRnTnFZbDArWGpBWEQxVDdXeHNC?=
 =?utf-8?B?OExRc3RGZWNvbXpqQlZ6ODFMOTE3dEUwdVpWMlpEa3IrSzArdXNKM1BMUXoz?=
 =?utf-8?B?REdaNmd1MGJmZnRsUlJjd1BYbGIxc1I4RlpPZUZwZjZMY3BlZnZRSDhrNkIz?=
 =?utf-8?B?VVRZYjVUT2x0RGFhRGhTYnBBWnVTYWd0SFRDRlNJa1EzVmd1YlMyZXJTNmlv?=
 =?utf-8?B?NkVuWVBsbFJjRCt1dkN0RXNxazdYMHcxb240bDdHRmZjOEN5a0lucStzY0xz?=
 =?utf-8?B?NjYyR0ZYV3NXc1d6OWtLVEx4YjVFVEVjQUJZSGpGa2hwdHVXMWZYTEFHcU4r?=
 =?utf-8?B?S3p4WkptQ2NUa090UmdmZlJzMmFmdlVLMEgwSkpsOVZnMW9LSzYwNXl0S0RK?=
 =?utf-8?B?dmpQemY4dU1KVE55QWIwSXNhK2p5cTdlQmJBS1UwYmY5MExtODJtMXlUbzdY?=
 =?utf-8?B?TXZ2ZmwzaDQ4ZGNSZllrREZzYm1NMTZycjkyU1ZMZGoyUmNyZk8wZXNGZFk1?=
 =?utf-8?B?enNLdjNoOFIyaW9TK2JpOFBuakVmdXNxM2p4b3hsWGZudzdJbVJicUhIZHR5?=
 =?utf-8?B?MFZnUTZoU1hXMnptYlJqaWVkMVhYRkNlY0RPanJLbGgrSXFnbjMrL0VLSUNS?=
 =?utf-8?B?MjBCaTc3QnVrTmlZZlNQMDV1bGg5ek5ZVTNlMDRGdXYreXBxc0RGT2RjR2RI?=
 =?utf-8?B?TUtoVHVkSGxSZmkwZzJtbjhhL1htbWRGMXRKbjNBZyttbkJXRVdvMlNYcVds?=
 =?utf-8?B?dVJySDV4Sm5GQjVYRnJVejUvU2lRL2cyenBtOFQvUEJNKzlLN2hCVGhBdjBC?=
 =?utf-8?B?c1A5WWY5a0F5Y3duRnJQdW00RnFoUko1S3NmK3cxV1g2dTZPbUlpWWcySHQv?=
 =?utf-8?B?SlBEU2ZjejYxSFFDMjQyeWVSVjRBMFN4MmVKMWh6WlltWE1iTUREZi95V2RF?=
 =?utf-8?B?bWNpaHpmQittRWFxcUZpbG1UVUMvbkR6Q00zVTR2LzZKY0RubHAwY1ZIZHUy?=
 =?utf-8?B?dzZWM3RtTXE0cEw3MHF0cHZoV2hKRHZSNWF3bW1xQUZuSEcyM1oxVnFrRWdO?=
 =?utf-8?B?NHBWRWk1N2FTSm83SmxIdmJ2M0FVV3p0QmhRanBzUnEvc1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTB2RWV0Q0dTVnd0MFRXRitGSmdRMWxxQ3VCZit3UFZDbW51Yit2ZWFIYlNM?=
 =?utf-8?B?dmJwZEpteGFLVUpkNC92N3hlVE5Dc1ZjdTRNRDFlWDdia0VUWnQrREhyTXk5?=
 =?utf-8?B?VStUeDNOMms5dzFodFpKREU0WWtKTnd5SUQ0Z1JOOWxiMzNIRWplNkQyb3l3?=
 =?utf-8?B?NGllRStSRGJmSUVYL1dTK3M0czYzSEVwa1h5UC9EUW0zNmkybnJlbEZRYXAx?=
 =?utf-8?B?TzJLWjJ3bzFjWGM5Lzd1WE5oV0t1cHJXbmVRcUJKN3ZQUWdubjBxclBVRklR?=
 =?utf-8?B?QW0zWTM1VUtUQmhjWkdwbzZvaEt1ajU5TERyemVacjlNUDRha0k2aTQ5L2hP?=
 =?utf-8?B?clIzN24ybVNweVgyREtEajBWWkNPcHNvMjRXWUNaajhJaEU2OFF3Uy9DNTFp?=
 =?utf-8?B?TDJKWC80ZzZ1UENXdjRVbytwUlhRRzMvRFRKVUxZajZMQWppVkd3bm1yOXQ4?=
 =?utf-8?B?VXNZYjJFUi9UMjB3YmZjcjdnTTdSNWcvU1I0ZXVpNTZvTHdMOExjZW1ZbW9F?=
 =?utf-8?B?S0RqNCtzNGVDbXNIUisvRXNXQVpKcjVzTHNOcUsvZkxzU1JpbEgwTitxUjI3?=
 =?utf-8?B?cUtGaGVvZjR5c3BCcmZkbE1uUElOUkFSUG9DTGVaRVVRb2IvVm1Ud3Bnd1R6?=
 =?utf-8?B?enRpZGpSdlFHYjk3LzdLUmkxMkFlbVUrc2lWbUlqVGdsVGIrTmZzRy91TEpa?=
 =?utf-8?B?K0o4Vm91bEZ5MU1TaWw0ZVQ0VERmaXJKQ3ZYTUJRbVUvT1V1Q1A5VjBpeUR5?=
 =?utf-8?B?eHMzZytudmdWV3ZDN0E2V2Q5djkyMy8vbWFod2dzcklBVFRNa2Y2U2FBQkEz?=
 =?utf-8?B?V09oRCtIaEwzU1J5eFIwZlVvSmtLZUNodmV4MlpWc1dnb0V5Z3lBbHFJUFBh?=
 =?utf-8?B?dnhORjI1QWJqOVkxbk41ZzVFUEQwQzk3MjB6ai9sZkVRZEROUEtja0xXZlVW?=
 =?utf-8?B?a3dUSFFPeUhWaVlOSklnOU1vTWZQTWgzbVVKVnh5OTd0UHhKdlVHcU40UFA4?=
 =?utf-8?B?Y2VjNkxSYnIyVEJONHNSWVNUYlBRVzZicmFDQ3E5WGhrRDEwVEJkNDdRS1ZS?=
 =?utf-8?B?a296Y2FENUMvOTlPL3NBRXJjL3Foell6ZG43OGNubVF0ay92R3B2YzNKQ09l?=
 =?utf-8?B?VDJSZ3ErRmhtU1ZGOTZNM0thcnJGNW9XNlNHQTBPSU85cHM0SkJKWnljYmxM?=
 =?utf-8?B?WUhuSE0rOW92NmlZMUJWRlo3anV2ZmJaQVloaUZwQk9Gb0Vkai9aQTV0Ynlx?=
 =?utf-8?B?WjF5ZlpJOGxTM0pQczBmNmtHWTRyQjdWc0ViUko1ZFk2YnpvcWozL0FUNmNl?=
 =?utf-8?B?Q2tKczE3TjJLWTFsSVFzdno2Ulo0U0pZbFU5eEI4RDMvbC91RElGKzZCV2xH?=
 =?utf-8?B?aEV1TCtybThWSFkwMHAxa242eUt3MnN5QUx0bHN4cFdtdTlTZms3UnZHUnA5?=
 =?utf-8?B?aWZheS9Pb3c0MWpRdGw2OXA0emozNy93b01wWkNOSDJ2VzM4bGxYRWRWM0J1?=
 =?utf-8?B?Q0pyeFNJYkNWaWlBS2JmNWxtbjNsM1dEc3lRalY0c1Z5Q1o1QWpoT2s5VFRC?=
 =?utf-8?B?WVV0ODNTdUczWWFIRnE5SElIOGNyamJYaUppU0VqL21NazNSQjVJc3czZGQ0?=
 =?utf-8?B?czRKZVpuRHNmc2FGVEFDK0ROdFo2MnplVTNLOFVIUlR2K1E3RWdoMm9PYWU0?=
 =?utf-8?B?dS90d3hQZTJiSWp2d0FEczgyMzdtMWRkNTcxTHJZMmk1SzNYdEdQMU9rK1o0?=
 =?utf-8?B?VXlPeGo5TmlybTEyc1lwbTBsWnFHRXJBOVpHeitGKzRVQTd3K0x1ZVVld2tk?=
 =?utf-8?B?aXkyUlJwM1JrNGtFelprZXo5NVhMdUFjWEVPeEZuODlJVm50aHo3ZDVJQ2dT?=
 =?utf-8?B?MnhqV3pDempOOVJKd1pTd2FpSFVCVnkwVEo3cFE0M0xxOUppV1RoNkU3U0dj?=
 =?utf-8?B?UmdqNHFZMkZYbTlLekVmUDdySy8wa2J1WnhUWXg2WkhNTStPZGZ2SFliQ1Ji?=
 =?utf-8?B?Y3FlQXF2eTVNMzdvODJ0TGErRDY0Q0VKRFdQdVN3UDhxNlppclhEY0RiekRX?=
 =?utf-8?B?eWdwWWZQVTNkc3lpOUlhTytyekdYekVTbzJmWE1KMmQwZkZBMEVwRHFLdVNJ?=
 =?utf-8?B?RHNyRkVaVFRBQUxZbEdBUVBVQkg1MWxGR1FYaC8zM29Ib2VjUWZXT1N0ZktG?=
 =?utf-8?Q?hvg2jL+JouH7QW3md5BvsXM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652fcdc6-d963-4056-5592-08de3c10f804
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 19:34:31.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3I6nPojZutKNqSAs6uBisgfUwBJOCTOMbaNBVMhhJe559xteYDmY3Fg3HP45L6euDYPSNwQZXGvKRpkJVYawo9O1olXRDkIiDd/http6CUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6513

On 2025-12-14 15:49, Boqun Feng wrote:
[...]
> A few issues in the prototype:
> 

See [1] for the updated commit.

> * hazptr_load_try_protect_percpu() needs to either be called in
>    preemption disabling context or disable preemption itself.

Good point, fixed. Added a "guard(preempt)()" within the scope of a
for loop so preemption is disabled for each attempt, but not across
attempts.

> 
> * In __hazptr_load_try_protect(), seems to me that we shouldn't return
>    after hazptr_chain_backup_slot() being called, but rather continue,
>    otherwise we would miss the updater changes.

Good point, fixed.

> 
> * As I mentioned above, since we allow preemption during hazptr readers,
>    then when we have multiple users, it's likely that the per-CPU slot is
>    used at most of the time, and other try_protect()s would always go
>    into the slow path, which downgrade us to normal locking.

Fair point. I've modified my implementation to have 8 slots per cpu
(rather than one). It fits within a single cache line. That should
allow a few preempted tasks to keep hold of a hazard pointer without
requiring use of the backup slot.

As for the overflow list, I've done the following changes:

- It now has per-cpu overflow lists, so the fallback relies on per-cpu
   locking rather than a global lock,
- Protect list add/del with raw spinlock rather than mutex.
- Introduce a generation counter (64-bit integer) with each overflow
   list, allowing piecewise iteration of the list by synchronize. The
   generation counter is read when beginning list iteration. Each
   time the raw spinlock is released and taken again to continue list
   iteration, the generation counter is checked, and retry entire list
   traversal if it does not match the counter value at beginning of
   traversal.

Strictly speaking, the main downside of the generation counter approach
is that a steady stream of list modifications could cause a synchronize
to retry endlessly. I open to ideas on how to improve this.

Feedback is welcome!

[1] https://github.com/compudj/linux-dev/commit/730616cd2989b710b585144ac10fc34b4fd641ea

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

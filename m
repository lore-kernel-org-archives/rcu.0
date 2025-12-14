Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020087.outbound.protection.outlook.com [52.101.189.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482CDF6C
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765679888; cv=fail; b=q/KFKzuuE2GGLsEkVF0a74BacWUZRcecUi6Ifng81nIEAutn0T/SDRIBconHR37RIF/9JwYFAJuP8nHQtLNlPWWcfaz7AVvIsZb6qgc21z/97U2duzj+fVnly45H6LopHWJCyGLVSZ/fCPOr1D8nHTDz9vw8N8PwwtKE5myG2eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765679888; c=relaxed/simple;
	bh=KmIO/ixT8QotrqRqKZ9aPmTVSFF5C5JJUCbG7BnAlXo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aa2gc41NPuC7/UI93qYYtYMf9DW9kpBsuMNDEiHd2YIQ5lCUrdDDfsV/JRS96SJbOy+fCe1BjEVi1K5WIqTaZwQXJSe0Oy3D2m+Y9TZcW0g49wFbZ3ByLOAVdGNJ+YbhJ7kVj24CYGfoRXMv+nk1AiUwWPjvDpC+ehZiagYX9Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Ybc4xdC4; arc=fail smtp.client-ip=52.101.189.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Ybc4xdC4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIKI4huha+hOypaDP8YlDC3Li0FAuoFmyMJn+p41MfKW6oaqkZn9L+/DgO9TQw7EUhE/1DA9x73OADvDI/KA2FkdgLO60IWzMseGBrwljX9ufXCY9fXfEwdvIDdc6PzHdy42T/OGca4eHaep202TiIw6oQG/GFc+/n9wrrG4eQsn7OCEKwFQ94nViSYKCp0OAhWBfQMyVZ+fsgSWAC0ZsTbh2OvPNjXJSf1wiCCHe4OFmecqC+k3nXX5J5MD/AgK5wJqj+f51DhUy9s/ij4mMhypiWx+182GtmolgB1pFmeW3LNCIhJbHcGXnROmKw28p/VW4y4FgUXxoQHPNX9vGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4lYj8TfANXvBIpMv32e5TPwYrloYr0/fbLVLPn9nXA=;
 b=AhsxNV7xBnp2Zu+oUSEEIWNbfO+P6Ye5yJQEjI+7GQwvxZbhV8lTcesiu27rioGfvF900Zcq4IB8MjiSwxCLLc46gWxeO7XkSanFf/cVGIv09NUa4b9Ooos/D0qZuxWX49O+nTiyPNSDgRacF1Mixo/22GC8yq/tItDgTIq8HxLaCkFZJmEd51Mb8hqBXw7i57/uRP9jAozNzI0gOgL/MZ3Vwse9WESUfVwRXuaWaD2aJaoYW9VLh981r8CVtnWVe19OBvQ/8u9JjAu17oJNeFUNq6S7g9oNgclyfCyo9/9W/KV2tQm1Axz0FBach8vYKTEXsOo6FypyscPxsVlEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4lYj8TfANXvBIpMv32e5TPwYrloYr0/fbLVLPn9nXA=;
 b=Ybc4xdC457C8SR2BpLgCvM9TaB395jstfWXJw4lRZl25YVZZmYQEgW3HmmELFy9Ai8Uc9JX8DUulLt9uFruEPYEJUep//4juUWw1pu7RlnsDE2TCfvN4erd7vJw8WeFJqmxBV+CvPHNq5c82x/EXu9uZGjTpT/I0+fEZ+8LeccGO5s6u/LmMezpvyvD4l4thvv72ETwlALWa1u7ZITNBE/t4QyJx1wuzekh1d1DylCpxs/PCRxK9qJ5DVhyKxifn3VpkNDa3othYYVQZm/XasA5ICGAZueFNCyXzOJNpDLZ/z45bffawCcN0L6/Lg0M8IFiE/I3jpsN+683tApHGfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5805.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 02:38:03 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 02:38:03 +0000
Message-ID: <091915fa-d6a9-4aba-99c6-d93d9b65e0de@efficios.com>
Date: Sat, 13 Dec 2025 21:38:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Handling large numbers of hazard pointers
To: paulmck@kernel.org, rcu@vger.kernel.org
Cc: boqun.feng@gmail.com, mark.rutland@arm.com, roman.gushchin@linux.dev
References: <77ffb53f-91fb-4bd4-96d4-e16b0e6ff0f1@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <77ffb53f-91fb-4bd4-96d4-e16b0e6ff0f1@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0047.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 355744b2-94bd-4ccf-b085-08de3ab9cdfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWFBT3ZPQ3VIRUduOU9veUY2NkNaalBFMjFGRG9xcU1sYkhhQnVWVHA1RnZU?=
 =?utf-8?B?WWVTM2RLVS9LTncvWmUxUzZFdjhkSTVJTWNtdmR0NE1tbytpS25LRFhRQXFV?=
 =?utf-8?B?VGRPbHQrTXNOQ3FhR21pRHFWTWg4a1pqZ0VzeEhCV3lLOWYrVmhicnJFZDJh?=
 =?utf-8?B?K2dyZFBpZVY3TWJzTXBVNjczRXE4MGZ5SXdtYVd3N25SemJrR3gzT0lFck4y?=
 =?utf-8?B?STJzVDZ1ckZ2d0owQjRHaXJSU2VTV1ppU2RIeXFXdjlzOVA3aXFXQ1lxRDh1?=
 =?utf-8?B?Z3M4QUhFcTBBT3d6TTduVDJzSm1SOVowV1NwMk9DOVFSK3ppQXNYY0JaVGJD?=
 =?utf-8?B?M2dzWmxmQWdXM3h0cEVFTjBCVFZncUtIQnR4Nlk2V3g3V2F3ZzgrYkRhemtv?=
 =?utf-8?B?cjJFRWMwdjNtR3NiQ1FWMWJ3VERpbW1zSDdwYk9IS2VIZkpZcllCM3VleFk1?=
 =?utf-8?B?TnlRMTdEVUlDK0tTZGk3eGZZa3pwZCtsQnBIMW5uRG9JcWFmaVdMR0FHejZ4?=
 =?utf-8?B?RGpEeGpzc2E2bXZ1ZjFpSlFTT2dObndVUy9leTRJTkFDbFlUQkttRWVIeEUy?=
 =?utf-8?B?d0hqWXpwVGhzbm05SWw1QVhvNmttRHV3MHc0T0FUaDVrUEJwQXRmd0Q4VmFF?=
 =?utf-8?B?QnZONEJlRUhDZDlKeXhSMmxRZ1VyaFVTbVE3VktBUXpqZHJxQ0xTNEV6azVy?=
 =?utf-8?B?SVB0MFp0anZ5NS9FN1Y1QUJKOVlzRnFMWnozMXFjdWFjQmx3RlI4WUl0NUQv?=
 =?utf-8?B?M1N4bFNtaVpRNkdRbDFKUkNtdmtiL0J4eTNoNVpINWxHZjloUHlyT1FmY280?=
 =?utf-8?B?S2tjSEVleE9sYmM2elIzcVlTTDRpcVZ4OFRSbEhybVR2UVgyRU1iSkU1Zndq?=
 =?utf-8?B?ejQrZ0ZVaDdka1c4c2dqQXZSczBjb2FOeEphamFUM1ZVWk1hcVdGS1dnZC9j?=
 =?utf-8?B?NjdUWUR4c05ZNFJwN0kvdi9XK3lQUHo5MllPTGsvcHExVHNOamcxRUd5WnFL?=
 =?utf-8?B?ZVcvR1FsNktIR0tqRDFWelo5bTcrNUlPZGhpUmJrWnA1Y3ltYUFxYmMzQ3d3?=
 =?utf-8?B?MXlKdHFCWFlaZ3MwVHlGS3RQVWtlbVFmRlZjd3g0czZNS0dqR2p3djVRVnk4?=
 =?utf-8?B?ZDY1TnlpUWZBTTY4RkxTUVEwZU1BcWcrM3hTZTIxcXJKa0M5TFBsYnB2MnpT?=
 =?utf-8?B?bjl6Y0dLSitKVEgrdklKTE8zM29LZGNFUzZWeFdHZ3RncEhuRUI2cG11a3Z6?=
 =?utf-8?B?clFhd0RQcnlHTXlPaVZGRmptZlZITFFlQVFtZ1p0WlFZS0xsNW1JQVpLdnZr?=
 =?utf-8?B?ZmtmREhrVWVsREJJN1p1dEkyYlA1dkt0ZW1UWTlzSTdDV1duSGJuamRvU3g5?=
 =?utf-8?B?RVpDOFBzc1p5M2ZpQ3VsU3BmRGFGOE5ya1RObC8wSjQ3WkZROWNKemJPckZu?=
 =?utf-8?B?UDEzWjZFZW96TWJTVGNjQUtOTjdQVmYvZEJRVTFuWjN5SmtidjFjZlJST2k1?=
 =?utf-8?B?YjcyVjJmUm9XdVAwaDloVm84ajg5MjNYMmZLWVlNWkZEaTlWVHBKa0crRXJj?=
 =?utf-8?B?MFBDeVhVZTVEbTJCTy9TUmRlaXgwZldoc3NvUVFYWEtjL05UU2UzVWNtYkxP?=
 =?utf-8?B?SE1vQzVMQkZ5ZGpVZlQzaVBXVXhpNlF2Q3E4OEk2V252cS9DaHg0NVpWQjY3?=
 =?utf-8?B?STlKaTBXNEw5Wm9kM2lsdy8yRGFIL3ZPRHZCRXZnS0VnUm5YcjBxbUdVMU9W?=
 =?utf-8?B?cm80Z2tac1FyR2pxWFZtTit3Nk9GQU94K3AwUXNUU1dUOFJIZkl1S25JWE0w?=
 =?utf-8?B?U1N2ckUrTmVRVHg0V3lqTUV3Wm12aklGTVlnWG9lK1Z5cnpObU5YU1hDbFFm?=
 =?utf-8?B?Q1dVK2MvSmZPQ2wyTE1sdXUzUHFsbFNnb1N6NzFCUVhOeVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWtOekxQZXA1RkxocVdCQ1FaeFFPNXpCVEtvTERJL0JhQVUxVU13QWdxaE9L?=
 =?utf-8?B?NTE2ZzVvNWY3ckJ2em9NQWw0d1dLREFmYVFMUHo0Q1VDM2JqZEV0anExUXdo?=
 =?utf-8?B?Nm9WeU9ZeG9haG5BcU5hUW1uUHBVVkJzR1VzaVRBNzBscms0S2FCVjlLdExk?=
 =?utf-8?B?NGMzMWtvbHkvTXNmREJpTnJsOXlzbDNBazl6NWZVV0R1VlptSGc2NTVLdTZL?=
 =?utf-8?B?N09zOHo0N0V2TXdya1dvNFA4cHp2bXdEZXdPbVhiQWE4ajNSVUxJOG1HbkpT?=
 =?utf-8?B?TVkzN2w5ZGErYUxDbTNzeENucUFGbFgxQUdWZXphcndXMC9jV2xnV2Erek4x?=
 =?utf-8?B?czA5K0J0RzRsWG5qeWhydjlsNFJZdE9vYjdsS0tjVjZIMVEzUlA2d0szQWVM?=
 =?utf-8?B?MFdPVnpIeGFGZ3doSFRCUUhFUGJKbTJwViswVzRXVThWK2tZdk94ay9tZjJO?=
 =?utf-8?B?TWNuVUdVRUJpVXhuWnJoTkV5RUZlYWRqTGxxVmlKMXRJREpHZGowdnB3VmpQ?=
 =?utf-8?B?blNUNU11dUQwMjVMVm5mYnJXWGtQWXFDZEZIS2VXNmwzRUNRNEtDY1FSTUNK?=
 =?utf-8?B?Y04rcHV2RlhQMG9pdi9zT29adDNOOXZibm53c2pOQkpKS1VQbW95OVpyNEhO?=
 =?utf-8?B?U3R0UmRNRkRlZDdwZ0djMW1XeGtuVlJGVjVqdTdMek0zbndjZ1RJQmJMdDVT?=
 =?utf-8?B?eWdUK3F2bkxjWjZNQnl1NUs3VERCdU43NHFobG9PSEN3dmJRb3VZcHorWU43?=
 =?utf-8?B?M0VOdkoyd3NqMXJCLzhLcEkzYzJ1cDBTeFIva3RpR3lHL0FOZll3L0RZY3A1?=
 =?utf-8?B?SU1kQUo4ZlpEdmRlUXIwUkZPQXB4eHF3ZFlRUnhQTkR6dUhqYlZOMEZCSjZv?=
 =?utf-8?B?eHBuK1BPemhsWWgwL0NtR1k3anJsR2x6Smx6N0VleS9YblJyaW0zUUxHVWJO?=
 =?utf-8?B?K0ZqdnVKL3V0R3NQK3hWSlE0bnZWWk5ZZ21OT3RKL1RrY3l6ckNRWXZ6MHJD?=
 =?utf-8?B?QTB0a3REbk5SeVErZW9iaTU4V3pYYW0rajNLejBxMTNNUHZjRG5LYTVVMHdr?=
 =?utf-8?B?QkNDeGZqZk9zbnVuVjN2R2xIUlBwajJKa2t0NnJ4eWRpcXlUSTZjYlBBbkx2?=
 =?utf-8?B?N0R1OXBYSWlUeXdZTTdBU2t0ejBYUEVCZjVFU0xIUXBqUkxHdHI0cmZacVdC?=
 =?utf-8?B?NEI0anE4T2hQVHIyMEprc25RcGNpL3F2ejVJL3FNYWtXWGZZRi9DSEdQSjh2?=
 =?utf-8?B?MThrazJXNGhpb3UxOXVjZnhBTXZtVUMrR0NiUjZiaFgvY3Z2Mm5ac1VaOWxW?=
 =?utf-8?B?WjZjaE4wR2l1R2F1S2RRTjh6Tkl2M0YxQ2kvZUtHQWJBa0pmYjZFaUlnNDBM?=
 =?utf-8?B?RHExMitQM1QxYWVnT04wMVEyb09sKzhvdGU5aFhscXFIZFBzVlhLdzV4UVBO?=
 =?utf-8?B?dHFGcGgwMTdIRlRMb1ZDNmpSMmhzQkYxSUs1Z3duNHN5MTFBRUtDNnBRVW1v?=
 =?utf-8?B?cTF2eDJpdGlOU1hjOVBxUmlHZDNuZHVmK2M0MWpVeVkwWXN5Q0U5THY3NEJz?=
 =?utf-8?B?Qjh5VW9heS9OWHVKM1RBY2d3QnBjN2k2WHpFVzNNdUQ5bFYvR1lnbzNoak9v?=
 =?utf-8?B?dkZTdTVZZ2pKQ28rODJkT0d0S0NoaDhybHI3cnFudWEwL0h0TXVCUytnWnNv?=
 =?utf-8?B?VnZBY2o4TjhoODhNaDluVWR0U3hrV0J2L2ZJMTN6KzRtQWRuVFF1aE5LZEd6?=
 =?utf-8?B?OXE4MW9YN3F0NUY5dHViOVhURThFcTliNjlhVjZ1Z2xpSEkzMnF4NFY2eHlX?=
 =?utf-8?B?aVRidy9rcC9pUnRlcE9Hb1g2Q3lCSnd2OTNTbGY1Nk1MSXBSN2xpdGUxNG1q?=
 =?utf-8?B?UUxZdHdiRzNZeVF6OEdwRTFQWHFVWnlHWDRQZi8vZks1RGNhRFJDL09vdW9Q?=
 =?utf-8?B?YStnUHlrMmJndENTL3pNL0duUGh4aFJ3TlBMQVV4dUwvMG5PTHZiN04xLzlO?=
 =?utf-8?B?ekV0dlBVVkpyOXBJTmtNdkZwOG1TMC9YUFJKY3ZiYlM0SmNPcks2T3d0dGVV?=
 =?utf-8?B?c01OQkdQVUI2NWpTaXJoU0JSbWw0V3prbHllMWszUmFwZlhVdldZNWY1ZDFH?=
 =?utf-8?B?UEVNaXN4SXYrRUhtZlZvcSsxa0Z5ZVFCclAvUTNpclp3UU9QcnNsanZRWGFP?=
 =?utf-8?Q?d5Ov49vwKA7Z/ASXZxE43HM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355744b2-94bd-4ccf-b085-08de3ab9cdfa
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2025 02:38:03.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3J9720+5+oKbgWNvYpGrM8UI3g7+sraVgA2cmXzqTbhKIiR7GbU+F3qfr/yLbHnmzNvQc+Az79AjvtSM3Nt8Xh9CZIitav3kAG9yKsPz+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5805

On 2025-12-13 17:31, Paul E. McKenney wrote:
> Hello!
> 
> I didn't do a good job of answering the "what about large numbers of
> hazard pointers" at Boqun's and my hazard-pointers talk at Linux Plumbers
> Conference yesterday, so please allow me to at least start on the path
> towards fixing that problem.
> 
> Also, there were a couple of people participating whose email addresses
> I don't know, so please feel free to CC them.
> 
> The trick is that in real workloads to date, although there might be
> millions of hazard pointers, there will typically only be a few active
> per CPU at a given time.  This of course suggests a per-CPU data structure
> tracking the active ones.  Allocating a hazard pointer grabs an unused one
> from this array, or, if all entries are in use, takes memory provided by
> the caller and links it into an overflow list.  Either way, it returns a
> pointer to the hazard pointer that is now visible to updaters.  When done,
> the caller calls a function that marks the array-entry as unused or
> removes the element from the list, as the case may be.  Because hazard
> pointers can migrate among CPUs, full synchronization is required when
> operating on the array and the overflow list.
> 
> And either way, the caller is responsible for allocating and freeing the
> backup hazard-pointer structure that will be used in case of overflow.
> And also either way, the updater need only deal with hazard pointers
> that are currently in use.
OK, so let me state how I see the fundamental problem you are trying
to address, and detail a possible solution.

* Problem Statement

Assuming we go for an array of hazard pointer slots per CPU to cover
the fast path (common case), we still need to handle the
overflow scenario, where more hazard pointers are accessed
concurrently for a given CPU than the array size, either due to
preemption, nested interrupts, or simply nested calls.

* Possible Solution

Requiring the HP caller to allocate backup space is clearly something
that would cover all scenarios. My worry is that tracking this backup
space allocation may be cumbersome for the user, especially if this
requires heap allocation.

Where the backup space can be allocated will likely depend on how long
the HP will be accessed. My working hypothesis here (let me know if
I'm wrong) is that a most of those HP users will complete their access
within the same stack frame where the HP was acquired. This is the
primary use-case I would like to make sure is convenient.

For that use-case the users can simply allocate room on their
stack frame for the backup HP slot. The requirement here is that they
clear the HP slot before the end of the current stack frame.
If there is enough room in the per-CPU array, they use that, else
they add the backup slot from their stack into the backup slot
list. When they are done, if they used a backup slot, they need
to remove it from the list.

There could still be room for more advanced use-cases where the
backup slots are allocated on the heap, but I suspect that it would
make the API trickier to use and should be reserved for use-cases
that really require it.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

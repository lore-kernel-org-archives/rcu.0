Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.95
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323603;
	b=a2NbfFJMWkKcgiiiodqTpPWVKZPCxMSULOm8nXGf6Ow/OitG4cdzYwyTe2uJUnVxWv1k
	 AFPsOoJBwC3IC+kAgv2uj7sNXvD5omwI8+iqkyfXd5z8jD/DmfMdzTMGy2GyqU4j5sSv3
	 YsFM6sMV8FAPmyzfsm86RudqHX7M9/zso3TWhX3pSoCBzQ6zjF64PIZHOVUX2X7ZmirQg
	 vzRHpqvKNHQ8F8WQOhddtIm7Whv9jgiDTD5z4teIXib/VGx6O17I6wRcX7DUCEeUk/fLu
	 7sJ3cnkZ1tUzjxNk3N86xHhr06b4WDTJgvPnPw6238qknmUmJr4w1T3/XuW/0w0IbAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323603;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oL4Sss3/RXJskQ1wfw01P4nZ95QzR491f7XCJtwxkCY=;
	b=ZwOcjunqY9XLWwbLDSLfZQJ3B1g4bIw5aqhZML1W40Zu/d1OjjaCS8BK9EArMhLjbQKs
	 m5yiSC9GHDjBsdFXKFHEBrZmBJ0WDGa3H6+ZtG6VVq2oA9v4GbDQeKpmcI5q4HQbXB2JZ
	 FK1KP2nVcb/ug0twSwAd47jPfOnaeYct7N3SL+UHS943/0X1LzA2S5T3spQrlNfEp3Zz4
	 WuJs8xIuQD72ZpVdz0gtl6COcc6rSocN+TbhJvMSKfj1WQ2DTqhjfbjYjCauDuxRvh7nK
	 dC1TxQKa2WkEYdftOJi280968ifgqkP1StvAKmhHkZMhHq4CUJtUItdeedVhn0jz33w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=SWpCeSX3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.95
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021095.outbound.protection.outlook.com [40.107.192.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CFE606A31C;
	Tue, 10 Nov 2026 15:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55CFE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=SWpCeSX3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhOb9/Ka8hNB+0pxZXTTgwEHA3qbmPCcSE4A16kwqkNdZNgar6flVzmQ/zZ049ECovPqM7MqHwrmCnOKFh7WS9sODSBdwry5NxgjUqlMBxY/EDBeY53GtKOWyKSMCuM3hWGOHgtxpCHe4YeX2iNBNz7HRw72O1480PD/Z7Ps3qhQs12ChA1rgEMr4rQdRkakvM4p2CqYtbKTdGCfkdmGAbRPZbdgvROu+BXBkXEyjL7dWzTuE9lXSiQhX4DHuqUFAvYxk/PV7JgazpbqxGi3e6zOPabo5flUjKYLLBUmlaI2hReJPMDavV+3PJdifQz5ERCwZabCKgdFCkUNn4vAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL4Sss3/RXJskQ1wfw01P4nZ95QzR491f7XCJtwxkCY=;
 b=bjUPATveiSEx8M+0G5dEd8B/AN6oRiM+cX1Gz9iju4FkuuPpAqXdkF8FghQXgj+VzGcpO8/+NAFXoqHRw3X/NSgTEUiwjL+CaM+irj/0pEKQLLdLxNAP9liYDJ0tDT8f/uC6Lg42AqAH0+JFV/rYArZdfhtGCRyK7OJtem8MDkK1840rbLom6XPedyrMNcREv5Pf+Sr7OcVDkco/HfMkRdIb53c6UptskIE7dtcy0kzuDJ74DlwCqZXJ9JNblcsyA/hYf+U35IURbTnpXDrv/kI0q6g2FqkKBDkIXrexdhTZshNE/uhzaaWhtoosm/B9lE2b7EyLcuzhVBrvazn2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL4Sss3/RXJskQ1wfw01P4nZ95QzR491f7XCJtwxkCY=;
 b=SWpCeSX3r7EKHkM1rJ9CSDViYRI/mKEmscMyIjF2nHVNNqStJZg7wnbQO5tDuOj8qEgXHdFFDX8wjDOhmnVzOqa2LevFPn+Q8Qig5J9s1Dg9W983yWlY7wKPZ7oDziIYYL+ls0MpiGA4xi14JjArI0ibF/CW0RC0WOxqljjcJ/XYC8WpSQ+OSXL+sL5+IdsUGU0b60Yer+cEyImYoXczVVHYofEAXk7FVuuHZ7DiN2kaAT77DF0Q2Q8IEZZGzxcpZaHL6SwATUCAW6ZxcUWL2MBKvyGWX8BquwDxHrb7bx+3rut2TRzQB/GjYnfRezrsYkb2RDPR8gP/GQFUHhhUBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQXPR01MB5460.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:13:21 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:13:20 +0000
Message-ID: <e414a246-3446-4419-971b-c0a430e53f21@efficios.com>
Date: Tue, 10 Nov 2026 10:13:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/12] rcu_txn: Add a doubly-linked list coherent in
 both directions
To: Puranjay Mohan <puranjay@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Liam R . Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, rcu@vger.kernel.org
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
 <20261016133319.433617-7-mathieu.desnoyers@efficios.com>
 <20261023182218.479327-5-puranjay@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261023182218.479327-5-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::18) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQXPR01MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 0244f275-bdd8-4e96-8338-08df3f3d27ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|10067099003|4143699003|261028144727099003|261026140227099003|261102123227099003|261009223027099003|56012099006|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	Nvx9dFJJWl3R5OZ9HUpqx9hvPiQgIDXaDdSZrvILBuaPkb9eNe+4wKggvjwAxS49qphM8Xx3l3CxOcVZWWF6jYPvazqeAgGeYvpeJySKULB5MTJ1uyxz5OurTVyt179cqVEMh+SogeZrkgCAemuR4YeEhXFlvoM/M1xacxC9wHeF7qBhyyAWR5RLLZ3hmWc3MxuSQMJ1Fk21dzGq+xqWEIjqcTYDOkIZHT/V+0YN1xjbRkMuAzOsGcyqMM2aczPIi2KBK3FElqKpbJum9xa5/0BH/34nlsrKaUHucf4nW4sfVjfJgndZmFSy4pV0Lg56a539GO1D40pA3Xj6rXD0D/agKp2h2Lj1g69mX21AUHMSj1g0ripU0bIKRRzYTJ4r3Dd8AbdLMo9VOdVqKjTR9qTHd1p6Qu5yF9YVlvblWrj17NjYx4ze2ko2CHYgKdrYgp1GLjdF10NklgPv1ZM2coOwyktTN/tuVBOYBUA5vWpWBrXMgMP2qJM+L+PAy7rqpRsKBoAfie/jJQ3x2MW5CUx6xrblvfRWzX38Ozxn5rtDigYkpgnjsGqGPsBprc9XIY0eWeMsnDeLPcpOLz4pAg8Xq7jWi697UNvKmMkWfq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(56012099006)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFBtV0wrbWlkVVRRdXgrRDltZ0VjbHVyTU9wRlMyL0tyUUlhYkZhQjVGUEFm?=
 =?utf-8?B?NHY0OVhEYTA4bUwxRXdhUXN2RTBsY0s3emJKbFRHcEtSMFJJK2NuU1MyNWIr?=
 =?utf-8?B?YlFQTUJ4Y0ZYY25EeTdUVTZvMlpUNEUzU3RWaTdtU1RtNUR3ZjU5UUFyTzJR?=
 =?utf-8?B?S3d5bTB3Slo3WHNSR3JYb3lCQkRCY2l5VEM1c3dJK2pkeCszSDhmNWJrWFR3?=
 =?utf-8?B?bWxNcUUzSFNMVmxqY2VIMkFRdzlLTmpaOCtWR2dRaEdDUFlDSnhmTTVPaXpX?=
 =?utf-8?B?ck14YWxNQ3ZOODcrMlFRQWVMWjl2QjJvcCt2dlMrK3JtSVUwZmQ4bmkvWkhH?=
 =?utf-8?B?VkErZmEzS2JkN3ptdExOdW9xc1E1WUZFWDhhQjhzeWNKVk9OWjliSTRGUGhK?=
 =?utf-8?B?SUc3dzgyb0ZBSHZET29oTjdVaWtkVkpsUmprc2dETyswSnFPWExpeWZnTm51?=
 =?utf-8?B?WDZnb0tXTGZ6MEJlejVENE5vSGpVZXJ4bmowWVBxSmpPb09tSUNnazl6ZGdQ?=
 =?utf-8?B?eFgzU0crRktmUnRoTjZYdlo4Q0IxRU5Ua1U1NHlLSGxleHdxcDVEYmMvTU9M?=
 =?utf-8?B?NHl5U05Jb3IwY1FBcjNBVHBiSUlqZUxUZHpkMWRvUitLbEhIcC9WU2JkZ3Vw?=
 =?utf-8?B?WGFSWW8rU296MjJLYVVkWTFXNDVyeVgvTDZ5VFdlUWpIZ3BZK0ZrNTRpTWp4?=
 =?utf-8?B?enRqL0JUNmJ4UHM4RFFxVUFDSFIyRDBQQmp5WjdCWGppbERGcUxjM01DcWlq?=
 =?utf-8?B?NmZSNFRMU3EyZ1lYWGJ0NzJqalcwRFYzYmtCNTV1TnlBUWIwdGR0cGFSbDBP?=
 =?utf-8?B?QTlZUGNxOG80NlhGRTlrYVJYRTZqZzZhekFQU3YvckVCS0NVWXFkMjFySnRq?=
 =?utf-8?B?MW0rZDZyWFNxOVRDaWZFbDk5N040NFlXOUt1OXJZSlI3QTNRVW92ZFg1cWk1?=
 =?utf-8?B?VUY4M1dVMzg0MlhwVUZVL3YwR2RQQWJpb0R4dG9KTFlKa2sxV3pZbTFFZTJr?=
 =?utf-8?B?VFpkN2dvbVd2QjRaaG00aGVyanBCbmpOdW5oT28wSDdyUXFsNU5QdVFZdUNp?=
 =?utf-8?B?N3ZOYTltQnc5QzJkZndrTjJ2ZGVkeTJMUVZvVWVkUEkyZjlxSGx6OUNpYmR0?=
 =?utf-8?B?SGQ5Tko5cjU3Y3A0UDhTOEZCSXRyaDJBdS9kQlk1ZWtYOEdOSUppWW1OekF5?=
 =?utf-8?B?TWU0WWIvRER5L0kxY1Q0N09Xd3BOTnF1TnM4MXV1RGY2MUNoRlVEQXFTLzRY?=
 =?utf-8?B?SWFjOGdDcnNXRWtOL3JmUUx4OVowbTBxVlFDZlE2a1hNT3crc1RsY25aQ3VO?=
 =?utf-8?B?SHRYb0xSMEkvZlN1R2hZTmFxVzQ5M1JFUHFSdnFvSk1td2QyUzByTFZjMzRZ?=
 =?utf-8?B?c1lIRFd3Sjd4NEJoeDRtWmQzZHd6aTR4cXRjQ2JlbEZoaFhzYzVvN2x0WHBy?=
 =?utf-8?B?Q2hUNndSanJMNEVZMXVnZkdTaWtMeVJ5N2lVaW9ZMW5VamFHbUdHQTg0dXhS?=
 =?utf-8?B?U3h2SlFHSlNHRCtkbWIySmtpRnZtTG5ROTdGQVhTMDBFaks4QUlPYVU3UTR1?=
 =?utf-8?B?MEtiUzcxNmRzRThqd0w1bDZFOEUwTmU4alVFQ1g0dGpyNlkzM0FSTEJzN3Bl?=
 =?utf-8?B?UGRpMzFNZUROTk1GazJCWjFGYjEvYVRLNXJQMFliaVdBNWRnVFBVc3JzTTNt?=
 =?utf-8?B?SENRcDM3TVNUbm5aTmF4bHF5WHpQVFRzU3BaSE9rRXN3WjA0cEt6VWVqYTM2?=
 =?utf-8?B?Yk80NURPYmFxejRXTTg4RnZ1Zm1ZUHhRcVA2bUVCQm9SWUY5am9xY3ZaTm9O?=
 =?utf-8?B?bldva1R4UlRLWDZ6UFdNdm5zdDFIMU1iRmdnU2dpUW9EV1lXaFlUVEMzUVk0?=
 =?utf-8?B?SHNWZmREU3FkSDBBbEVUVmFJdTBPU1Y1cE4xQm1laStxZmNxNVJDUGJ0M3c5?=
 =?utf-8?B?VWpPZG5PTjY2WEVSYldsLzg4eUkxL2lUUkpHOEVzQ2lCam1XMTFtZkc5WVpq?=
 =?utf-8?B?Rkd0TXhQbU9tUWUzaFJYQlFtWVJuVjVUcEZ5dUN0eHV4cE1CeFU4S0hxTVZ4?=
 =?utf-8?B?K3g5eVNxMjRjSm8rVU9hbXNqK2N5NjdML0hYcjRHdnlvRVdLZVRnYzVWcGU1?=
 =?utf-8?B?cisyVWFORStZdkJSNVpWaXk3ZHh3a3V1SHA2bXpxSEkreHl5em9xdXZLaFR1?=
 =?utf-8?B?dHlIOXcxMWd3a1owdjFiZ0lZU3hzN3EwOU1aOE4xekViS0lwMjZKcXBtWHpT?=
 =?utf-8?B?ZnRiaHc1SkRxWGdzSXdDeVJOOXFwUEhQUEhsdE43MmRmT0lxcW9TYmRYb3gr?=
 =?utf-8?B?NnBDckpEWk85c3ZpU2N5Q1ViZXQzbjNZc2tKcmJPbnRsYVhMaUZQR01zQXZo?=
 =?utf-8?Q?Mzas+bZVKDQo+8zr9yppWQPgwUIJ14s/wBsxO?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0244f275-bdd8-4e96-8338-08df3f3d27ce
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:13:20.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfH8838MvjNwhYpnDgtJv32HKFqpUbSamwHe7Xdl5xyEKm7XNcrVCIDUENUH5xN8riGGB5nCnxmyX3TaPMcmSL9HkwcaU9a36N97pmadhuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5460

On 2026-10-23 14:22, Puranjay Mohan wrote:
[...]
> This overstates it a bit: a reader can read P->next == N and then, once
> an insertion of E between them commits, read N->prev == E.  The commit
> message puts it accurately ("never finds the new value of an edge and
> then the old value of the other"), so I'd use that wording here too.

Agreed. The next version will use the wording of the commit message in
the header.

Your points show two levels of coherence, and the header should name
both:

- Per-node coherence: a reader never finds the new value of an edge,
   then the old value of the other. Every operation of rcu_txn_list
   gives it.
- Per-walk coherence: a walk visits every node that is not moved
   exactly once, and ends at its own head. A move does not give it,
   as your examples show.

[...]
> That has a consequence for iterators, which should be documented: a
> reader standing on the moved node can skip or revisit nodes that never
> moved.

Agreed. The next version will document it on the iterators and on the
move forms.

So the next version will present two ways to move a node, and the
caller picks by what its readers need.

The move itself never fails, never sleeps, and never waits for a grace
period. Its descriptor goes back to the per-CPU pool through
call_rcu_hurry(). It keeps per-node coherence, which an RCU list cannot
give for a move: a delete then an add are two updates that readers
observe separately. The move fits:

- readers that take the first or last entry, or that reach a node
   through another index, then read its neighbours;
- walkers that tolerate a skipped or repeated node, like an LRU scan,
   when the node moves within the same list. A walker standing on a
   node moved to another list would never reach its own head;
- writers that cannot sleep, like a second chance under a spinlock;
- moves composed with other edits in one commit, through
   rcu_txn_list_move_after_prepare().

A writer whose readers need per-walk coherence can instead delete the
node, wait for a grace period, then add it back. A deleted node keeps
its next and prev, so a reader standing on it leaves in the old order.
The add comes after every reader that saw the node at its old place. So
a walk sees every other node exactly once, and the moved node at most
once. The cost is a writer that sleeps for a grace period, and a node
that readers do not find during that time.

With this sequence, your reader on A walks H -> A -> B -> C -> H. So
does your reader on C.

[...]
> Either document on every move form that the destination must be in
> the same list, or give readers a way to detect it, like hlist_nulls
> does.

The next version will document it on every move form, with the
reason. A move to another list can use the same sequence. A reader
standing on the node finishes its own list, and ends at its own head.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

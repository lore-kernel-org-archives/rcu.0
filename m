Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2095.outbound.protection.outlook.com [40.107.116.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9838F9C;
	Wed,  9 Jul 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071488; cv=fail; b=Roc1PhCo7ktfC9X+ZtApT/AQmA5QNq4nQ5dQDVhzsYQTiIR6271rTkZXVhJwMh5RTNa2sP8HCwb8zcP3vp/zcP5HaBwmk2b9sD4DhJ9jGnuQsGnxTYZ5YMI928ee5mR7wBubIvHneeLCANY87+A8N1NniXmyLAXsbAZVlVp04wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071488; c=relaxed/simple;
	bh=bV6l6mQcE9Lg7TRQ0egPjdGgwyaJ7e+ZfOlK5YpIBvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H67pw0R+x+xr8gdl851I3eV2GGgKx09V3z6SgcS5V4QLmPGAh4CH2YA7nm0/2rMfJ2X4LcIMy/dabnO12hYLrkPX9eBo2lVRjZOFQWKbjL3B0Rv75l3i5trhq7j/SBXd5uQHo1CbPYi4rTlLDPCPoOXZWFElvAJWL7FPXdapq3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XX6WtSZj; arc=fail smtp.client-ip=40.107.116.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XX6WtSZj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX/s/aCvJ0fHUcPo9jvcuR/b0xct+AcalKzp2HTHJSUZIfU9mqeZiAlO5+I/HtUBFxAbzuldvj7Kp6E4vrjY/QPGxUx2t0c8mWMIAwFGOpGuARFZHAHcu02wLwiFksk7fCJtuq1eTFuP/msYV7xVt6ATjQAzz6JbOEmPpcwAn74iODfCpSeeMlMG8Hr7WacXS/tyzJ8jlrSV5GJYvlUwWL/9Pd8kwhBSUUkLIZlxzmS5xxW5Nt5Rc96BOQkkuvlNRqaHWosV1UqCKsDppRlFQy0eAIRcjCZE92ZFIb/g9g678WFcDYA1JIvro3jvrL2B7j1y9WLqswtjze30dpKr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/l42+OgyBmW7RQTCSxgMqwHZik5Q7o2PGcPCbZ1fuQ=;
 b=Cg778vnc6RgolIqfub7fgXcrN4VlYAZ1ORFvkvq9rpgmzsDVJut2jNOSFWGowXI27VC7CvVHHpbu2uh9xGBXk0SteHPvLanc1qMXOdMlleT2CUrv3WwAnGnx7rWEBKfbPcM/pgoq/QuIV4CQr5Oy8Zt8yjtaaFFG04ngGyV96FhG/YMj0nKUhRvu4StgpqOifRJANQXnmDb6feQTfQ9CPSLwwSgHFSaIGK/Saz2afg4KnXJD6csbjeOvfYacZnqBoSHb+ndfMRB4AdPokYiNIyy4xA13iZjLuhJyr7Qsy5YvBGm9ibhBPnJlDv/6ZXDL5eJQQohqatImIZkmJzFwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/l42+OgyBmW7RQTCSxgMqwHZik5Q7o2PGcPCbZ1fuQ=;
 b=XX6WtSZj3fdghUS8cQ6K57vz4jvdzcOODO0CmXkyJa/U1t2qz7lssRsRrWRTsZ/sZ3yKk3ppnALGUf0QYJuzl4XuOVp7t5yrJbUBbfgJ1Oipl1kqEQ4Wikv0bOyV1xc6/Oc9r2qkfN73nBMPUJKm64fIAPCKt9gDbq1zGpfYXpie2ge2h0XXB+atvW1l15F70+qtEp7BRD69cwpo0lR41XLoSf4ThKyXK42s8OZ7rOMyLN1fANLxhmnJs5kMUaKkv69I2pvBqw8nfsBiITeeMJ61w9e3neLppDO2GhAK9CsXFDAblgcp8CB3b/wpOPrRCEBYPlvVQmZhp6IMVh2hKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6442.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:49::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 14:31:16 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 14:31:15 +0000
Message-ID: <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
Date: Wed, 9 Jul 2025 10:31:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: paulmck@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
 <20250613152218.1924093-2-bigeasy@linutronix.de>
 <aFL1pIGMDX5DG9f_@tardis.local> <20250620084334.Zb8O2SwS@linutronix.de>
 <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bb7650-a20c-4ee6-1f7d-08ddbef542d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1FicVRQNmdCbXBDYVdrai9WSGxvNXluNkk3dXFUM3IxdnF1eEcrcmg2UnVh?=
 =?utf-8?B?WHJJU2FFcExIVTJvRFhsaEFHcDNTbHZxbkN3dWpvOFkrSXJFVkpUYnJKaXNR?=
 =?utf-8?B?bDdUbGVMbzlrQkFENUUybWdPNXc3QnFqam5rQ3BDYlptRWZLY01la2tvSnJk?=
 =?utf-8?B?NW93clR2RDhoWUw4SVdDNW1xM2x0dFhFTDBqNDZSWEIyZXBBSlFlOEZPU0da?=
 =?utf-8?B?RmNLV0lTTkQrK1JDVmxvTks4bVVVYkdQeHJQbkM4TFZUbGpPYWtVYW40cXRF?=
 =?utf-8?B?QWw3QXpvbGh4TUhHUXVIc3paSU40VEMwMjhxb0IxcW9NTERnVWpIdnRiTGwy?=
 =?utf-8?B?b3hTb0RUUHlsQmdPKy80N2VuTElMK3g2Mm8rR3BtMU5pQk9JeVhqOTFrNFRQ?=
 =?utf-8?B?Y0o3ZnBsUW5CQlk0eDhxK3gxNWJCN1BMTDhEbjNPODllS3FnbjN2bVVZaVcw?=
 =?utf-8?B?QVpVenVZZWJBUmxTNjJiNHpSTklxYTJKM3FnOEdoOHNSeHR3NFhvbUVFUmtG?=
 =?utf-8?B?alVRcDdDdHl5YVIwK3FIQUU3T0ZQekdEVUx2b0RhcWcwMkRwb01KRUZyWFpI?=
 =?utf-8?B?Nyt4RG5lZGVacEhGMG8ya1k1cm5wdzhkYmtvblFMemVId01SUDJxWW9MYmxP?=
 =?utf-8?B?UEphSDVPRWtTS3hLOHcwd0ZLRFBzb2xUUUhPdTdCcTZBTFNnYnJ4K25oeVI4?=
 =?utf-8?B?TklrUTlhWWxQczRHVHlKMk9HZ0VTd1p6WXRNSnFZb2lsR0FZZXh4amsvUDI3?=
 =?utf-8?B?Nk1JWStrR05QMlZsNlFNNEwyaEFZakFzV3lzY2F5bTNLRkZWN1VkS1Vydm5Q?=
 =?utf-8?B?NjZvenJNdlNMdXI0UHJlR1VOYm5TZ3pGbmxmQ2NJeUFwSG5oUG0zclI2NHF2?=
 =?utf-8?B?TnNpcytPdkpPN1FDSmplSlZCQi9CcHZkcTBkWm5oODIrOHFMd0dEN1hYS1Zy?=
 =?utf-8?B?S0E2d1BaTDlCaVVDRUFvNTAxNHd6WG94Skh2N2krbGZGVjdDMnZvM1RCb01z?=
 =?utf-8?B?N3JqMkZyZWZkOGVVNDQwM1J2Y1pVekloNDBYRnczOWMxNW9pclgvTVhGbTJ4?=
 =?utf-8?B?TjRJeGRMdkVIRHJKQnBJU3hVSHpPcXRkU21OeVEwMDVoTWhnU3BMemVCK1Bh?=
 =?utf-8?B?bDBTTkZqbE5ZRDNmRkM4YWFVWFhQZzhGTTVEOWZkNG5wT2doalIrS1N5MW1h?=
 =?utf-8?B?N2Y5dnFsUjlwaW9oYUdWdURCVDJsWE52dDgzMzdDM2lSL3gyRzRnQ2xsZGtv?=
 =?utf-8?B?OXk2dVNSY0hwVTMyNitsSnBqZURvSjFObC85NkpZZWNHTnUweVdCRU1Ga0pW?=
 =?utf-8?B?cXdEV041ejNNZmR0aitUUnZ1UUlZM0xmMmdkT0MrOFNBYklWZDVGRW11a2NR?=
 =?utf-8?B?RHpTZzIxdVNIRWhPSG9NT2loekUxSkdyVlAyZWRXNlZUSjhJUG1UM1MreFF4?=
 =?utf-8?B?cmFoWFZzczE3bG1QSk1adFQ1ZnNLYXQzdVdFNHcvY0YrYlR5T2doTzljNzgy?=
 =?utf-8?B?SzFabHErSzJjWDNFTjUwOG5WLzdIaVhjbmZCZnZRa3dudlVKNndYbTZHWkVF?=
 =?utf-8?B?WU42QkNnSzc4djN0Yk9LSElCdnAvMG96MzAzK2RaRUFvODhmYzV3bXJSY2Fj?=
 =?utf-8?B?Ui9ya1NTT1dmZ0NUYzRtckk5SFpVeS9QUVA2c2kzQXZlMGxwVVo4WllSWVhv?=
 =?utf-8?B?cHJaV0VJVnFhQUMwRk1pSDRCQU0rMTYyQzJPWnZTYUdERSswNlNOd09iVWgz?=
 =?utf-8?B?eG5zTDZWSEF5MEY2dlo3MGo5MXhSVFBVK3dLZFhkeXJoY0M5SWE1T2Y1V3J6?=
 =?utf-8?Q?kR3MU343rYirvjRYKJIdE5Nmh5UGRueYJAOg8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21xVDc2dVZDRXc4YkxlcEtJWW43dFRVeGFzLytWSUZsQjY2T3lxR3NaR002?=
 =?utf-8?B?WkgzWXhJTE03Ky9jS2tab1p2NVV5VzNzRkQzRWJzZlJWb1JERWhERm1Hc0FG?=
 =?utf-8?B?YjMwNHA5Q01rWXduSFArY1BOZ1dSKzZyMXNiSDJ4dXBoclR1WEI3U2IzMnpX?=
 =?utf-8?B?Z3I3b21uN21DbE5GNGRxNkliOXBhSnYrNTVmQjdFQ2FZeGFMV29Xb2MzaTl0?=
 =?utf-8?B?NllRZHZWN1NDT08xeWdRSjVlbis0MmxXMVFPMkNzQzRLc214djQ3NUpwclNJ?=
 =?utf-8?B?WlVLMXRzRXBObGdiTGdLV2ZFV1pGVkNLeXRZZ2FmRElMcFZPQjJ2cHo0T2s1?=
 =?utf-8?B?V0o1cXVIT3JiZHdESk5LOGhNSEtWMGN6TXoyQzVFenhsQThOZFNkZEZOOGdH?=
 =?utf-8?B?dENzQm0xaXVhb3RINS83OVltc0xsQWVHTksxc0o5YTJWM3phbFVDZTRxTzRP?=
 =?utf-8?B?QVFTWkJSdXZieEsvNDZkYitHR3ZrNzZiNXFBRHNxV2Z2VXlNUHJYNUtKdlZs?=
 =?utf-8?B?dHVXbzQxckJNaVFoMVd1WTA2VVZoRWRIS3dhWXVpZ3NPVkN4MmdGclg0WkVm?=
 =?utf-8?B?dU9KWEQ0bUZTdC9sM1cwZk1OeFU4Y3QxUFltMGdGcTdSY2xsa1pPSTJ1VzN2?=
 =?utf-8?B?WmN1TWNiUndtUHBnQU52TStWYUFpUGhQRkhHOC9hQlphMUk5MDFrOGhBZVA5?=
 =?utf-8?B?aWlnajhiaTNwRVdGQW1wdXp1TFViSnJvRFNXMjN3UTkyNDlLRmQ3NllxNGo2?=
 =?utf-8?B?TTlPWUh3ZjBjZzhlREk4UzArR3NidGJQVnVLdTRtSGU1WHlhZEpQV0hwbURi?=
 =?utf-8?B?cFk2WC8yQXd0SzNGNkdyNll0WGRtWDE2VzRld2hlSDdCRXFoekNrMFlMbW1I?=
 =?utf-8?B?anRsMFFQeGtpSmZ3RnR4VVdFVkVsWW1ONDFZTFZEMm9ySkVWTkxRNlR6NlB3?=
 =?utf-8?B?WW9aT2ZsYmpuQzlYUG5wOVBlMWVJSUZNSFFTL0FyTXRvdnVUb1ErazZlZ1Nh?=
 =?utf-8?B?STlJMWI2SlJSNUswaURzbUdxcHFpdXBPaExjcDUvZTlnbUlDUVB0VHdKa1VS?=
 =?utf-8?B?V2VxQTJkbmd5NmE3Mit4cU9aVFQwRkg2Mm5sUnQ0VGU1OG5GZ2ZvSHVyK2NH?=
 =?utf-8?B?Qk5wbTFJTXp3Zzc3S1gyQzg5UTBRaHdHd1pWV3pBNVV4R3hlTzluSXhaK0Ru?=
 =?utf-8?B?ZXFIR3JCY2NPMkJ1RjJEK3dGNHhaRDNXRDNja2VnVzA3TlJVZUkvOVRIclYw?=
 =?utf-8?B?Yll2OWp2WlRFSTF0ZXdOSWtOWmN6UGpwYTJtczlTVjkrbkZHS2VaU2dxMVc4?=
 =?utf-8?B?RmszRFd1L05FcWdZaEVKWXQ4M2U4TklYRUhMQitQeldndENQRlFFMzEzTWlw?=
 =?utf-8?B?Mko5akUxZWJmYnhWT1h6SUdiQm9xVXd6ZGN5N2FWTXpITFZEdExWS2oxUzJ4?=
 =?utf-8?B?MDV0NitUMURnNEhpemUvaDdxV0FyUTA1VnBldlM5bEhvcDArYzhwV3ZWVkNK?=
 =?utf-8?B?Yklsay91UTVaUk5FazRuMmJjQUtZazViTXlVNmkzZFIwVTFyZCtSNVRjZ2l0?=
 =?utf-8?B?NEJSeUowbmVGNEdYYlAvQm1HaWZaUzFSNWsyODJydlhMRTFNNVpCMm1BZzRy?=
 =?utf-8?B?dTZCSmo1RTZOUkozVEVrODc2UFdoWjE4TVlEb1Jwd2xObUo3MUtZS1E0QXRw?=
 =?utf-8?B?ZVlkWjVuLzc1bUVtVmtjTEpzOXJuSFRXMk1vdVFITTVNTDhmQ0RqaCtIZjFR?=
 =?utf-8?B?UFVyd2xibVRKRGNrdmY5dVdCUlNIVUZiTlNTMXdONHR2elhsc0FwMGEzNHRR?=
 =?utf-8?B?RW9PVlIzU21DR2p4ZmFma2lWOWMyZXM4S0dBRXhqeU9wWFJVbEhJVHpXUEFp?=
 =?utf-8?B?aC95czVZQkcvREZXMDhyTmU3bitjM09iNVpCZzg1RUNPbWNFZktmWXRNdCtM?=
 =?utf-8?B?VllWZ3dILzFUUkZsdTZWOTA3Sm54emxoY0t6U0NES1hvcUlPMmF3RjVleElM?=
 =?utf-8?B?UTJsRmFFQklRT1hNWmdBRWkrWlA0ZTNWMVd6YnF2WDY1blE5QXlyOUh2S1li?=
 =?utf-8?B?eWg3MUM2dERQd01JN2t6OTgxYzVDRDRBcTdYUWQydm5nZ1Rlb1lCR0MxdEll?=
 =?utf-8?B?V0R2MFZrM3MzRDlha1llekx6RlJUUVRCNEhjb242cklESG1ac0IzSVpxZ1Jh?=
 =?utf-8?Q?Ud9UiimIErbTFVzZzXScNeI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bb7650-a20c-4ee6-1f7d-08ddbef542d1
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 14:31:15.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKeTJF9PYF12VmiOmAC7wYAzpyLn06vpdXkTXiU9+cluyrXwANxNdnF7m1KnZSzmcs37gKHe+2EgKyj7YKTpuktGjwgRVLYcO1foO1NYIFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6442

On 2025-07-08 16:49, Paul E. McKenney wrote:
> On Tue, Jul 08, 2025 at 03:40:05PM -0400, Mathieu Desnoyers wrote:
>> On 2025-07-07 17:56, Paul E. McKenney wrote:
>>> On Mon, Jun 23, 2025 at 11:13:03AM -0700, Paul E. McKenney wrote:
>>>> On Mon, Jun 23, 2025 at 12:49:41PM +0200, Sebastian Andrzej Siewior wrote:
>>>>> On 2025-06-20 04:23:49 [-0700], Paul E. McKenney wrote:
>>>>>>> I hope not because it is not any different from
>>>>>>>
>>>>>>>    	CPU 2			CPU 3
>>>>>>>    	=====                   =====
>>>>>>> 	NMI
>>>>>>>    	rcu_read_lock();
>>>>>>>    				synchronize_rcu();
>>>>>>>    				// need all CPUs report a QS.
>>>>>>>    	rcu_read_unlock();
>>>>>>>    	// no rcu_read_unlock_special() due to in_nmi().
>>>>>>>
>>>>>>> If the NMI happens while the CPU is in userland (say a perf event) then
>>>>>>> the NMI returns directly to userland.
>>>>>>> After the tracing event completes (in this case) the CPU should run into
>>>>>>> another RCU section on its way out via context switch or the tick
>>>>>>> interrupt.
>>>>>>> I assume the tick interrupt is what makes the NMI case work.
>>>>>>
>>>>>> Are you promising that interrupts will be always be disabled across
>>>>>> the whole rcu_read_lock_notrace() read-side critical section?  If so,
>>>>>> could we please have a lockdep_assert_irqs_disabled() call to check that?
>>>>>
>>>>> No, that should stay preemptible because bpf can attach itself to
>>>>> tracepoints and this is the root cause of the exercise. Now if you say
>>>>> it has to be run with disabled interrupts to match the NMI case then it
>>>>> makes sense (since NMIs have interrupts off) but I do not understand why
>>>>> it matters here (since the CPU returns to userland without passing the
>>>>> kernel).
>>>>
>>>> Given your patch, if you don't disable interrupts in a preemptible kernel
>>>> across your rcu_read_lock_notrace()/rcu_read_unlock_notrace() pair, then a
>>>> concurrent expedited grace period might send its IPI in the middle of that
>>>> critical section.  That IPI handler would set up state so that the next
>>>> rcu_preempt_deferred_qs_irqrestore() would report the quiescent state.
>>>> Except that without the call to rcu_read_unlock_special(), there might
>>>> not be any subsequent call to rcu_preempt_deferred_qs_irqrestore().
>>>>
>>>> This is even more painful if this is a CONFIG_PREEMPT_RT kernel.
>>>> Then if that critical section was preempted and then priority-boosted,
>>>> the unboosting also won't happen until the next call to that same
>>>> rcu_preempt_deferred_qs_irqrestore() function, which again might not
>>>> happen.  Or might be significantly delayed.
>>>>
>>>> Or am I missing some trick that fixes all of this?
>>>>
>>>>> I'm not sure how much can be done here due to the notrace part. Assuming
>>>>> rcu_read_unlock_special() is not doable, would forcing a context switch
>>>>> (via setting need-resched and irq_work, as the IRQ-off case) do the
>>>>> trick?
>>>>> Looking through rcu_preempt_deferred_qs_irqrestore() it does not look to
>>>>> be "usable from the scheduler (with rq lock held)" due to RCU-boosting
>>>>> or the wake of expedited_wq (which is one of the requirement).
>>>>
>>>> But if rq_lock is held, then interrupts are disabled, which will
>>>> cause the unboosting to be deferred.
>>>>
>>>> Or are the various deferral mechanisms also unusable in this context?
>>>
>>> OK, looking back through this thread, it appears that you need both
>>> an rcu_read_lock_notrace() and an rcu_read_unlock_notrace() that are
>>> covered by Mathieu's list of requirements [1]:
>>
>> I'm just jumping into this email thread, so I'll try to clarify
>> what I may.
> 
> Thank you for jumping in!
> 
>>> | - NMI-safe
>>> 	This is covered by the existing rcu_read_lock() and
>>> 	rcu_read_unlock().
>>
>> OK
>>
>>> | - notrace
>>> 	I am guessing that by "notrace", you mean the "notrace" CPP
>>> 	macro attribute defined in include/linux/compiler_types.h.
>>> 	This has no fewer than four different definitions, so I will
>>> 	need some help understanding what the restrictions are.
>>
>> When I listed notrace in my desiderata, I had in mind the
>> preempt_{disable,enable}_notrace macros, which ensure that
>> those macros don't call instrumentation, and therefore can be
>> used from the implementation of tracepoint instrumentation or
>> from a tracer callback.
> 
> OK, that makes sense.  I have some questions:
> 
> Are interrupts disabled at the calls to rcu_read_unlock_notrace()?

No.

> 
> If interrupts are instead enabled, is it OK for an IRQ-work handler that
> did an immediate self-interrupt and a bunch of non-notrace work?
> 
> If interrupts are to be enabled, but an immediate IRQ-work handler is
> ruled out, what mechanism should I be using to defer the work, given
> that it cannot be deferred for very long without messing up real-time
> latencies?  As in a delay of nanoseconds or maybe a microsecond, but
> not multiple microseconds let alone milliseconds?
> 
> (I could imagine short-timeout hrtimer, but I am not seeing notrace
> variants of these guys, either.)

I have nothing against an immediate IRQ-work, but I'm worried about
_nested_ immediate IRQ-work, where we end up triggering a endless
recursion of IRQ-work through instrumentation.

Ideally we would want to figure out a way to prevent endless recursion,
while keeping the immediate IRQ-work within rcu_read_unlock_notrace()
to keep RT latency within bounded ranges, but without adding unwanted
overhead by adding too many conditional branches to the fast-paths.

Is there a way to issue a given IRQ-work only when not nested in that
IRQ-work handler ? Any way we can detect and prevent that recursion
should work fine.

> 
>>> | - usable from the scheduler (with rq lock held)
>>> 	This is covered by the existing rcu_read_lock() and
>>> 	rcu_read_unlock().
>>
>> OK
>>
>>> | - usable to trace the RCU implementation
>>> 	This one I don't understand.  Can I put tracepoints on
>>> 	rcu_read_lock_notrace() and rcu_read_unlock_notrace() or can't I?
>>> 	I was assuming that tracepoints would be forbidden.  Until I
>>> 	reached this requirement, that is.
>>
>> At a high level, a rcu_read_{lock,unlock}_notrace should be something
>> that is safe to call from the tracepoint implementation or from a
>> tracer callback.
>>
>> My expectation is that the "normal" (not notrace) RCU APIs would
>> be instrumented with tracepoints, and tracepoints and tracer callbacks
>> are allowed to use the _notrace RCU APIs.
>>
>> This provides instrumentation coverage of RCU with the exception of the
>> _notrace users, which is pretty much the best we can hope for without
>> having a circular dependency.
> 
> OK, got it, and that does make sense.  I am not sure how I would have
> intuited that from the description, but what is life without a challenge?

That certainly makes life interesting !

As a side-note, I think the "_notrace" suffix I've described comes from
the "notrace" function attribute background, which is indeed also used
to prevent function tracing of the annotated functions, for similar
purposes.

Kprobes also has annotation mechanisms to prevent inserting breakpoints
in specific functions, and in other cases we rely on compiler flags to
prevent instrumentation of entire objects.

But mostly the goal of all of those mechanisms is the same: allow some
kernel code to be used from instrumentation and tracer callbacks without
triggering endless recursion.

> 
>>> One possible path forward is to ensure that rcu_read_unlock_special()
>>> calls only functions that are compatible with the notrace/trace
>>> requirements.  The ones that look like they might need some help are
>>> raise_softirq_irqoff() and irq_work_queue_on().  Note that although
>>> rcu_preempt_deferred_qs_irqrestore() would also need help, it is easy to
>>> avoid its being invoked, for example, by disabing interrupts across the
>>> call to rcu_read_unlock_notrace().  Or by making rcu_read_unlock_notrace()
>>> do the disabling.
>>>
>>> However, I could easily be missing something, especially given my being
>>> confused by the juxtaposition of "notrace" and "usable to trace the
>>> RCU implementation".  These appear to me to be contradicting each other.
>>>
>>> Help?
>>
>> You indeed need to ensure that everything that is called from
>> rcu_{lock,unlock]_notrace don't end up executing instrumentation
>> to prevent a circular dependency. You hinted at a few ways to achieve
>> this. Other possible approaches:
>>
>> - Add a "trace" bool parameter to rcu_read_unlock_special(),
>> - Duplicate rcu_read_unlock_special() and introduce a notrace symbol.
> 
> OK, both of these are reasonable alternatives for the API, but it will
> still be necessary to figure out how to make the notrace-incompatible
> work happen.

One downside of those two approaches is that they require to somewhat
duplicate the code (trace vs notrace). This makes it tricky in the
case of irq work, because the irq work is just some interrupt, so we're
limited in how we can pass around parameters that would use the
notrace code.

> 
>> - Keep some nesting count in the task struct to prevent calling the
>>    instrumentation when nested in notrace,
> 
> OK, for this one, is the idea to invoke some TBD RCU API the tracing
> exits the notrace region?  I could see that working.  But there would
> need to be a guarantee that if the notrace API was invoked, a call to
> this TBD RCU API would follow in short order.  And I suspect that
> preemption (and probably also interrupts) would need to be disabled
> across this region.

No quite.

What I have in mind is to try to find the most elegant way to prevent
endless recursion of the irq work issued immediately on
rcu_read_unlock_notrace without slowing down most fast paths, and
ideally without too much code duplication.

I'm not entirely sure what would be the best approach though.

> 
>> There are probably other possible approaches I am missing, each with
>> their respective trade offs.
> 
> I am pretty sure that we also have some ways to go before we have the
> requirements fully laid out, for that matter.  ;-)
> 
> Could you please tell me where in the current tracing code these
> rcu_read_lock_notrace()/rcu_read_unlock_notrace() calls would be placed?

AFAIU here:

include/linux/tracepoint.h:

#define __DECLARE_TRACE(name, proto, args, cond, data_proto) [...]

         static inline void __do_trace_##name(proto)                     \
         {                                                               \
                 if (cond) {                                             \
                         guard(preempt_notrace)();                       \
                         __DO_TRACE_CALL(name, TP_ARGS(args));           \
                 }                                                       \
         }                                                               \
         static inline void trace_##name(proto)                          \
         {                                                               \
                 if (static_branch_unlikely(&__tracepoint_##name.key))   \
                         __do_trace_##name(args);                        \
                 if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
                         WARN_ONCE(!rcu_is_watching(),                   \
                                   "RCU not watching for tracepoint");   \
                 }                                                       \
         }

and

#define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto) [...]

         static inline void __do_trace_##name(proto)                     \
         {                                                               \
                 guard(rcu_tasks_trace)();                               \
                 __DO_TRACE_CALL(name, TP_ARGS(args));                   \
         }                                                               \
         static inline void trace_##name(proto)                          \
         {                                                               \
                 might_fault();                                          \
                 if (static_branch_unlikely(&__tracepoint_##name.key))   \
                         __do_trace_##name(args);                        \
                 if (IS_ENABLED(CONFIG_LOCKDEP)) {                       \
                         WARN_ONCE(!rcu_is_watching(),                   \
                                   "RCU not watching for tracepoint");   \
                 }                                                       \
         }

Thanks,

Mathieu


> 
> 							Thanx, Paul


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

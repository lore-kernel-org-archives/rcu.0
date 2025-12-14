Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4697929E10C;
	Sun, 14 Dec 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698642; cv=fail; b=X9UDYZJHyRYCL5PB7ToSKdbSksXE601yoaFRDGT6mYC11UiwIRt6xqSppWcX8Idj03/vyV/FWhFfShlW7C4tpfJtBS/dt5MV3p+NyL736nqBZMeLi8AF8oMOB0DRaw4KhKj3j9E/V2ez1j4PAhWYeQNG6GUML6Yj+oxngya9cXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698642; c=relaxed/simple;
	bh=KHj5KBksJyGQa0X8+SJQ3dBkLuz9chWl3cPA6M8IVzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JXVxQB6lrAPnKKRvYoarD24tPlHmmcF2kIvbInNFJJu/eZoPlNYuZy2Q851nJvSUgM3RBm9KoyGE1fGvqHovjJ9pOUC1D1h305eXGslvI02zN7Maq5U29z7xVmoFURfb73x0U1d5ZrxWstIQJuOiWqFGFG+wXehUoPHVEdbUQSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WkTQSxam; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WkTQSxam"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVmB76LgUa/iwR/p9Bq1WssxO7uom2gJJZRWtI7QFnEPEsRu8SN1LpmJd2b+GPmxsngCeTUhRyOWK+A9KPxAiTSjDaH97QUcgwT5kjoJOSKSrW1+VEtKyNNcW03LLoSWelgficZcQ89lnqtINF87+u0Xh9fAMatW1Jmh+VjwwIvMzc/S/8LCEPzUQHV4rHMQBgfrsrbZDppMMnjk7OkU1Yd8/t6ZBPUKyg0WlegGoeJTb80YV8xrE6s/SZ6oQZip6nWgB7SvhSWzJWnb8lfdCkB1tH6/d3DDpU+N0QbNIMyaiGk+OUn0z9PjHDhzBpNfCTK+dhhAkZmtnstbfsEiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHj5KBksJyGQa0X8+SJQ3dBkLuz9chWl3cPA6M8IVzo=;
 b=Q5tDjh0eSoDqBkqpkjhT1a4UAAdqIELWLSj+xbQ2dDkDdJGXe6XdNP9O03LkVtgR6USpFkHGJiIetxE+ucFNIXMdwzGc/qgcapaAPVnhwGx+BS3UGYiwlH0sxoxhnEZl652rcpTQ9rJ9IiTQ/F41en/m9GMEG5/zPR+3OmpqiJgaitGmmCNEGe9/kreYJMGcz8f9ho+M/kumbSOi/xmuATUziAvEu9s1Rt1qU9ZO8sEbP9HguJm42GnW9Ks/gt786liBIcsmxPIUSXEcSHbzWoIuMpm8y8TrNU7Z8Wj4a4n3GVAvB1cOSwi2+wnUMzJZKAo9SLreo63FJHLE10Co3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHj5KBksJyGQa0X8+SJQ3dBkLuz9chWl3cPA6M8IVzo=;
 b=WkTQSxamPjfFvDZummwlAHBEdpTerRy5ckhqckO1x3maeGPxPfVtXqEnksrx9M0tIPT+6nc02ytfc3+YNwahEMH1HsH+teWTgbGrdfTJobyECQkfwN0lQQo+Vz74fuFHdXRf9sWAON+hDQ7pHWCc/qlJNYH9iyM5BZpU5RRFHJthnD1+rWtn3nXyZxNbIU8EwZYEt/AVhlPT/KyOvGQXh3gCPPtLHw9sgSGOxPSP6tu2KJjyj2x5u+DkSXYx6p+W0xinyp5FIihFOG/pS0IvmXV47n0xnXnj1DZ7PvuX9449amvGJus1vUepqX7BmGq7gNpVa3V6zG7sSdVq4T79Ng==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 07:50:34 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 07:50:33 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
CC: "paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org"
	<frederic@kernel.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] srcu: Use suitable gfp_flags for the
 init_srcu_struct_nodes()
Thread-Topic: [PATCH] srcu: Use suitable gfp_flags for the
 init_srcu_struct_nodes()
Thread-Index: AQHcbDgmEAgtPDQTCE61yrO+bVbgcrUf7ZWzgACNMwCAAElvhA==
Date: Sun, 14 Dec 2025 07:50:33 +0000
Message-ID: <811D4BC0-A080-47C5-84AA-24EDE1C4EF6F@nvidia.com>
References: <20251213135518.109887-1-qiang.zhang@linux.dev>
 <2D296DB9-2F60-47B2-A48A-D490A291A0EB@nvidia.com>
 <e4030c94bbc55d1e78f0d26039561f583ff0cadf@linux.dev>
In-Reply-To: <e4030c94bbc55d1e78f0d26039561f583ff0cadf@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|LV8PR12MB9665:EE_
x-ms-office365-filtering-correlation-id: f52c25e6-508c-42e2-9a0f-08de3ae57638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODlWOGRTMnlqejh5OWR0SHIyMlpNRnNwTmc5a041aHdjUDVLSXhvL2tpK0Vl?=
 =?utf-8?B?NGFmVjgxMlpwNTk3K0VEQlE4VVA0cENsT1dOUW1EbkFYN3JEekFMZG1hV2kx?=
 =?utf-8?B?dTFmOVprM1ZCNng1aWlnblN3cTkyaklvdk85eS9WS2MrS3VzblBDdk1zUkdu?=
 =?utf-8?B?Y0RmdTNGblN0NmkyQXFmc2RVQ2NoU2FLVmJ6MFZOVGExRFFaSWltN25KM055?=
 =?utf-8?B?bDJIV1p2M1dNMm9vZHNLeFVkYm91WGhYOUd2bUZQRnR3QzJRM25NUmZiZ3hn?=
 =?utf-8?B?Q0hYYS83YTlvNmtHcVlWZ0lqVzIzNG10aVhTVnJ0Y3hhTXI3dWVtOXFrU2tS?=
 =?utf-8?B?YUpjaUs1aUhSd2xHQUtiRVRkeXRQTG9GSFk0djlIaWNYeVBQQVJRbHdrUDM2?=
 =?utf-8?B?a0dRMUR6T0dkYlBiTmQ4UWZ1V3NQMnVuYkl3YnI3dHBJSlNLeUtsV2NEL0wv?=
 =?utf-8?B?RGVHTVFweXhYUFluYlEybUJBaW4rNUk2VXNXUkcvRkJsUnRTZGZERTNLT2lO?=
 =?utf-8?B?RUpFNldjVkZpZnpXWDczcEp3a001bHgrUUJ5MVRYN0xSSFlnNXlhLzVMc3lH?=
 =?utf-8?B?aEFGcEJHb1BuWlgvaFUxK002QktiSStwcDJTbW5FV0E2ek04WjB6ZkQ3Q3VS?=
 =?utf-8?B?TFAwQ0Q2djlpZzZYUzkzSDhoUlVFYUJIMkJiejUwQTY2bHY4M25qbkdPYzA4?=
 =?utf-8?B?Y2ZPSDh4U0EzVm5rcndwdVR1cGdIeHJEMmhLcHIvR2JydmN2L2lzOEk5M1Ay?=
 =?utf-8?B?dTJoRHl0cFN4dDdmMEdTWmFQWm5ZOUFHRTF3SXhUNVptcDJrUFRwOVJZVTNo?=
 =?utf-8?B?cFh1UHh2dUNPeW9CdmZUUmRmb3ZaRDRlckpSYnJ1Z0V3U2k5NlBBdER3REdN?=
 =?utf-8?B?Szg1NXhpbDU2WEJHUFloYTlLRmVVSDlheGI2LzZWcURDQWd3TlFQMWlPR0Y4?=
 =?utf-8?B?d3RNaVdCc1p2RjZOWThxb1EzT0c3aDU0T2diNDNCcSt1MmRxRjI1c084RzNX?=
 =?utf-8?B?VnR1TjN6Y0tmcVpIODI5Y3ROdmJJTUZjeFFwYTJnb0FySHdrOFh0WEY3TWpK?=
 =?utf-8?B?L09Ubjc1cGdOZWpkY2ltYzJVcjdyRmxhU1ZTblZUb0MxUG9xQWJZZzY2UTVl?=
 =?utf-8?B?MmFnSXBMTlVxZHVUZmJoQU9qZ0ZyZ2R2bFNVakcyVmpXQkx1ZldwLzVQbW9l?=
 =?utf-8?B?TUZXanNFYTZCSVVCWjBmdWMvV0lwa2tYUnpXZ2Jxd1RnR1RrS01vVk1KYjZ6?=
 =?utf-8?B?RjNsNEhaZFZRZU9QTnV2bURHS1FGUE1kd1FBZWZzMHVFcEtwakRTZ0hkdFpP?=
 =?utf-8?B?S1h6TFdOYVUyc0RjdzNSK0R1Tm4zZ1BFcEsvd2JxQnhqUHpCaURtendmYWpl?=
 =?utf-8?B?WFZVT2NmK0FheXAwVlRvcG4yRnhrS3NTV1dDQ1RLbGUrREpzelNscHFTcWpq?=
 =?utf-8?B?d24vK1BzeStuSHhzVlVqZ01Kdy9aaHpjMXJWMGJyanpIcWtkbTMvQjJ6NXlX?=
 =?utf-8?B?cGpYbHlsV0pnNk5zUTJVaEtKbXhkdFppTzNvZzc5QTBpRjgvWFA3V0NxYkhU?=
 =?utf-8?B?dWsydmpHeWZWZGxZMzF4bWxIdnpkSzdjMEpHbEpvdGNzZnJaM0NqcGI1Wnpk?=
 =?utf-8?B?Sk1nUCtnUHhtcGFxcWI5dW1oVkVPYzgwM3luZGZxV1YwZVFoNXFtbEtqVmMw?=
 =?utf-8?B?d2d3SGhQTFR3bkZVeHZGUWR3RzI2SWpmblJ4ejlLdk4xSjEzVCt3eFQ1S1hN?=
 =?utf-8?B?UzF3c2syS01MMmtmQXgxZHNkWXhWRzJmd2ltWk10emxONEFaVkZHcThZdTdM?=
 =?utf-8?B?UkNpdU0yWEQwS2gxZkNxQXBQUVF2WVZ0cExySnVvOFJTazFaVU9LdEhZN0xN?=
 =?utf-8?B?Wk9mZFIrZlZlRW1LZEthVWlsZzdPWUJiU0JXUEdvRXBldVlna1UzTFdFYVhN?=
 =?utf-8?B?RFU0QzlNamNobkxqMzlGQjRhVXZabHNuVDNWWEVRakdTMDJrSVRtbHlSbzln?=
 =?utf-8?B?TzhaMWpxemhqaGFoc0NSYkRLbUJzVGdmVnVUbTlLdTNUS09MWGNVdEh0V2Ji?=
 =?utf-8?Q?9w3moY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHZsY0g0NC9hTFYwODlJMkJrR3g4Zk5lSndDc2lMOHZVSU5HT1JZQ05wM1dC?=
 =?utf-8?B?Z0JqZXBWMGZHOUJnay9BSUNOZW1CV2dybWxPcTNuVXNicW9lL0RpanZ3S0wx?=
 =?utf-8?B?OGZYWjRxeVJYR0RmMlBSV2I2MkZBdDlQNy9HVG82MHZIZjg4NzhSd0YxNGJO?=
 =?utf-8?B?SG9YNS80L3RkeklBR1VmUE0rUXJiRnJxcWVKczZWTy9GZDl3c0ZBTWVVN3F0?=
 =?utf-8?B?aXViTGYzNElSNGlHdzREdWI4eHQ1TnZsRWt6cEwzK2w3ZHZmV05SR3VHbzhs?=
 =?utf-8?B?a0tLbWpjVHFaV1orQ3RkaU1OZHVFMy9TOGNDOC8zUDcxWXJrRjl3MnFQbVA2?=
 =?utf-8?B?ZHZKWjE1ZDVsTSswRWprK3lHaVR6MFZoSGk0MDkrM2k5YjhTZUt1WDZJMnpI?=
 =?utf-8?B?SDVWQncxNHVsYUZsWU9lYWd6QllEWTB5eHlhdmliNWJXRnZJUElIRnBialFU?=
 =?utf-8?B?dzlUaVllamhhYkEvNnhyZzVoVjhiNkJsaXVhWEl4SHA3TjZlbCtJcDNPOFlh?=
 =?utf-8?B?cE0wMktSUlBsUEM5V2wvY3Z0Ymp0ZlVYeGdvTXV1c2VUZ0YvWUFWajYzTnVX?=
 =?utf-8?B?RUUrOXBFZlE3RnA3WUtJcnpYeU9aUjV2Nk5DNlFCN2UvODBQM3hodkdodmtS?=
 =?utf-8?B?V2xZc0tFbkVGVk11b2RWZmN2dURkZFJ4b1k1dzVTNnVKbTZBaWFzUk5PR0k5?=
 =?utf-8?B?Y2gxZjZxb2VWVVk5akNoUFVqZmNJWFdwN2VZYk5DcWJSczcxcWJTbHNxeklP?=
 =?utf-8?B?MmwzMVVFYzJKRUo2dHNRVndRUDVDTWZ2cXZJTm9vRW1nR1VvcCsyVG9nQStH?=
 =?utf-8?B?N2pnTVlGSHBsZzZHOGxyd05BNjFjbkxHNEtRNDl6YVZPcnVZSnBiS2VDeElv?=
 =?utf-8?B?eXQrSlNUY0U1ckRPeDRRZ2xKbE52SkkzUEpqcVBvQzBJWGN0WWRUek1mNUtI?=
 =?utf-8?B?VDQ0UVpCLzliQ1dhSlN6emI3ckFqd2lITFBXZmFLMk1WdTdkQ3NSeFNjS2ly?=
 =?utf-8?B?ZzRaZnk5Q3VCTHlEak82a1VNRkRiNEdoTG5ja2M3eUpEYVBmVitFRHBkWmpC?=
 =?utf-8?B?VEpEYmsxTFZtZm9EbGxUNUZycmQvcW93ZWswRWx6aXE0OUhwMjVpS3Bsbk56?=
 =?utf-8?B?dzVVTFlhc0NjUFpTZjdja0Uxd1grdWptNzlXM2NzTlBYTXVNN1lvTlYwTnBL?=
 =?utf-8?B?SzFBaVYxMkY5VGNWNGNzWTBockpoU0J3eTRvWXVhc1REUURvY2NyYWd5UHQ2?=
 =?utf-8?B?TjJHbEpaMFBKRjk3NXFLQ2pxLzdHMHIrcy80U1hjS0Z2OFBiYWtOdTVndWE0?=
 =?utf-8?B?TlY2cWZSUVlLdUhxN0t5cW42Ykh2akg5UHA2b3JQWm5Vcmw0WmVFZ3RiQnNB?=
 =?utf-8?B?Skg5b1JWOXdTRnVub0ZzVndIbzRJVUJtUFpHNFBtdzZFaDdUTkxHeS96R1hG?=
 =?utf-8?B?UmlTTDN6Q1c4VlZVVmFYN0o3M0x5RVk5Y29YQjBIT3pTQmRFUVRJRE9DTnRK?=
 =?utf-8?B?VC9XUmpSclZtZlVCOElOLzZkajFTRUdhSVo2Ykg4SDZ6QldZU2VuOGRUMVF5?=
 =?utf-8?B?RHBvWml2dWdOZm1mWTl5QWxpdGduaHR6cjZrOTNkU0FqVjNwSFVpd25mc3pj?=
 =?utf-8?B?d203K0JqWVBpUk5QbGNqV3plS2ZFZ0NqMm5qcWhPcndwM0pvQTdVT2FDUHNs?=
 =?utf-8?B?c1NqNDBJOU5Lc3h5TVRwNU9MOTRjSU1SSHJEeFZVL0UwNTFpdHhveFlJRlhW?=
 =?utf-8?B?b3NpWGNzaDNaQ0QrWlhucldHWmFpV3hIMTFxNCswSmF5c0d1WUVreVEzamwx?=
 =?utf-8?B?T2M3dloyMytVdTQzUjZNWEJFQUZ1L0FmcGlNWjh3WUt2cEdRU0lCbmNWaXZZ?=
 =?utf-8?B?ZFAvL0FGL1RMRCtnQmZOTWtoZG1XeU95TitOS0ZRcng5ODFhZUVma3BwbFlK?=
 =?utf-8?B?Q2c3M3RHQVRIbXpjeUk0N21zQjlqTTk4cnBQR2NkYitMZURpb2pkSmZ5L3d2?=
 =?utf-8?B?UlFtcStBNnEwTHVmenBvcUdKZjdLd2QxVnRpTTZhL2VYQlhpOUIxVXdoVWFZ?=
 =?utf-8?B?L1R4Z1ZBY3FzaFlJOUlPY2xPVjlqYVFydHRlcm9SakJPMnp1SVhLc29vVGtB?=
 =?utf-8?Q?2cjriCPKeoytTB09bOT2uY2Up?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52c25e6-508c-42e2-9a0f-08de3ae57638
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2025 07:50:33.7929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14pe/JJV/pLf+xHp56qyn/m0hFnfcGv0eXTDxTRDvTYz6rhOE2Re8NVpaIS5TaVyhbiUK7n6SRZ8bm0OrA15dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665

DQoNCj4gT24gRGVjIDE0LCAyMDI1LCBhdCAxMjoyOOKAr1BNLCBacWlhbmcgPHFpYW5nLnpoYW5n
QGxpbnV4LmRldj4gd3JvdGU6DQo+IA0KPiDvu78NCj4+IA0KPj4gDQo+Pj4gDQo+Pj4+IE9uIERl
YyAxMywgMjAyNSwgYXQgMTA6NTYgUE0sIFpxaWFuZyA8cWlhbmcuemhhbmdAbGludXguZGV2PiB3
cm90ZToNCj4+PiANCj4+PiBJbiBzb21lIGtlcm5lbHMgd2hpY2ggaXMgc2V0IGNvbnZlcnRfdG9f
YmlnIHRvIFNSQ1VfU0laSU5HX0lOSVQsDQo+Pj4gZm9yIHVzZSB0aGUgaW5pdF9zcmN1X3N0cnVj
dCooKSB0byBpbml0aWFsaXplZCBzcmN1IHN0cnVjdHVyZSwNCj4+PiB0aGUgaXNfc3RhdGljIHBh
cmFtZXRlcnMgaXMgYWx3YXlzIGZhbHNlLCB0aGUgbWVtb3J5IGFsbG9jYXRpb24NCj4+PiBmb3Ig
c3JjdV9zdXAgc3RydWN0dXJlJ3MtPm5vZGUgY2FuIHVzZSBHRlBfS0VSTkVMIGZsYWdzLg0KPj4+
IA0KPj4+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdAbGludXguZGV2Pg0KPj4+
IC0tLQ0KPj4+IGtlcm5lbC9yY3Uvc3JjdXRyZWUuYyB8IDIgKy0NCj4+PiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEv
a2VybmVsL3JjdS9zcmN1dHJlZS5jIGIva2VybmVsL3JjdS9zcmN1dHJlZS5jDQo+Pj4gaW5kZXgg
ZWEzZjEyOGRlMDZmLi5lNDU3MWI1Njk3NTIgMTAwNjQ0DQo+Pj4gLS0tIGEva2VybmVsL3JjdS9z
cmN1dHJlZS5jDQo+Pj4gKysrIGIva2VybmVsL3JjdS9zcmN1dHJlZS5jDQo+Pj4gQEAgLTI2Miw3
ICsyNjIsNyBAQCBzdGF0aWMgaW50IGluaXRfc3JjdV9zdHJ1Y3RfZmllbGRzKHN0cnVjdCBzcmN1
X3N0cnVjdCAqc3NwLCBib29sIGlzX3N0YXRpYykNCj4+PiBzc3AtPnNyY3Vfc3VwLT5zcmN1X2dw
X3NlcV9uZWVkZWRfZXhwID0gU1JDVV9HUF9TRVFfSU5JVElBTF9WQUw7DQo+Pj4gc3NwLT5zcmN1
X3N1cC0+c3JjdV9sYXN0X2dwX2VuZCA9IGt0aW1lX2dldF9tb25vX2Zhc3RfbnMoKTsNCj4+PiBp
ZiAoUkVBRF9PTkNFKHNzcC0+c3JjdV9zdXAtPnNyY3Vfc2l6ZV9zdGF0ZSkgPT0gU1JDVV9TSVpF
X1NNQUxMICYmIFNSQ1VfU0laSU5HX0lTX0lOSVQoKSkgew0KPj4+IC0gaWYgKCFpbml0X3NyY3Vf
c3RydWN0X25vZGVzKHNzcCwgR0ZQX0FUT01JQykpDQo+Pj4gKyBpZiAoIWluaXRfc3JjdV9zdHJ1
Y3Rfbm9kZXMoc3NwLCAhaXNfc3RhdGljID8gR0ZQX0tFUk5FTCA6IEdGUF9BVE9NSUMpKQ0KPj4+
IA0KPj4gTml0OiBwbGVhc2UgYXZvaWQgZG91YmxlIG5lZ2F0aXZlcywgYmVjb21lcyBhIGJpdCBo
YXJkZXIgdG8gcmVhZDoNCj4+IA0KPj4gSW5zdGVhZCwNCj4+IGlzX3N0YXRpYyA/IEdGUF9BVE9N
SUMgOiBHRlBfS0VSTkVMDQo+IA0KPiBPaywgd2lsbCBkbyB0aGF0Lg0KPiANCj4+IA0KPj4gSXMg
aXQgYWxzbyB3b3J0aHdoaWxlIGFkZGluZyBhIG1pZ2h0X3NsZWVwKCkgaGVyZSBmb3IgYWRkaXRp
b25hbCByb2J1c3RuZXNzPw0KPiANCj4gV291bGQgaXQgYmUgbW9yZSBhcHByb3ByaWF0ZSB0byBh
ZGQgbWlnaHRfc2xlZXAoKSBiZWZvcmUNCj4gYWxsb2NhdGluZyBzc3AtPnNyY3Vfc3VwID8NCg0K
QWN0dWFsbHkgdGhpcyBpcyBwcm9iYWJseSBub3QgbmVlZGVkIGJlY2F1c2UgdGhlIHNsYWIgYWxs
b2NhdG9yIGFscmVhZHkgZG9lcyB0aGF0IGZvciBzbGVlcGFibGUgYWxsb2NhdGlvbnMuDQoNClNv
IGZlZWwgZnJlZSB0byBpZ25vcmUgdGhlIHN1Z2dlc3Rpb24uOy0pDQoNClRoZSBvbmUgcmVhc29u
IHRvIGRvIGl0IG1pZ2h0IGp1c3QgYmUgZm9yIGRvY3VtZW50YXRpb24uDQoNClRoYW5rcy4NCg0K

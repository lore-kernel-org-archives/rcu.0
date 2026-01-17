Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111E274FD0;
	Sat, 17 Jan 2026 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768639719; cv=fail; b=fVIV2tYRGjEA/wbLTMmdg3z7O0jKo+Igmfo8NW+hEiMmTl8Piy8YzRTnysCdnZIXjM2Gwl8IsOYguk4oFzZ2tlkswDtheeY8yMMdcO6YscTa0OA0UKMlxQCYynZTmyPjJ3qmFOljHKcZLi3N4u+estQOnCh4aLpsu8xKOm79VhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768639719; c=relaxed/simple;
	bh=RNWH60cH0G7UorRvUBWPaFAR9fZGjqFVGkFQSnsiM+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYUEkVuUjdMB64mGyiMAFubSPYWs07npbqkWejGrIXZDQ2UxXv7hQGbBorkg4EUMPLHv5ocSPlxg7Lo1cQJPpV5QFyWdzouW/v7hrZvxWxHz+y5o0bWlk/Pzbx2b7NkxvWdzaYVYHJbkuhqIc5LaQiSBJd1EaGzIf5fkd8n6cs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FC7ARKZ9; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FC7ARKZ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZsor6JXZ43iePFg7zDBtup3VpvZ/CkWoqAYUttRDKp45c7TnoY2i734UiWwDmvI/jm/hPmMC2Q4ghc0Xl6LeQ3dDxNhKQZFUPw+2ksl5W4jJZq0gkdhBr775VvoN4M5yuWDZoBntEPQjg8rOpXCEC6oavkcqwWJ7dGeSZRgE3P0M+Wb7IeTFonEVUo4pQqYCWIqytD49ASSDZrmX8gTXFQ5tWhzhkiNR4HmhPgaJX1OlHSG1h7ddIdgtqw3LFY8/R1Lg+74VkzlnIlshTytYkLmXt1jUp8g0rKH/lSCtOv8WWwo+Nb4F+YtUMpX2wWZQqeQX4+Zka4jwow9ofrNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNWH60cH0G7UorRvUBWPaFAR9fZGjqFVGkFQSnsiM+w=;
 b=I7mFR0X8DUM+MZXgkGQ3DjLW/l92fvqEDG24ztFispzCCacvgfRKmgw7Vs8jqs5LKXEsHmYYmIsJUQ1ttNXN1AkVzDb4ARgWXDp7VzNoGx1jE54zFUDTCss05mvnlMIqgCVLzlAmqF/p88g9UsclVwUu80W0xfdDNFu7oeGB6+6+bKtnDbEtf2hD1rYmMqwDb4Qm3dlqmu/V8tAcemGvy27bXmygKyrMy2nHizWCw3uobOa7l2vTX6H9uCYnXB3KWjBj/XB+thRRW59ZH2xCUBOGfaR13rFAP7mKmSupq+RT8MypRNLeVGpvmvoRJVv72Ix6PGj5f4SeLOPRT+20yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNWH60cH0G7UorRvUBWPaFAR9fZGjqFVGkFQSnsiM+w=;
 b=FC7ARKZ91Uw1wqODB5fs/bReLRB13Mp0F2mK7J5dOGv9mOzHs90tZkHpj39JlgbbKrdyKdm8y+6CJcPYSB1s8rvtT7Vkyu5nnSqLoBiKnS0UW+vzPm2ttnSO/AE9Ny/OAq92xzLyLnN0ibDOY3lh0UFNg9If2KbxcPdboqGDW4pMU20/AAiV9HN2Hial8MWiCM1crCKJaRVNTSPfQKgrx7Vm33MsAnoRF9KhgTRGflxUBgnm3mNcQDI6QGLhbfBbGLh+3Tiu8zv3Y6AiOyGIoONE2YIIbqDcgtAFyfaNH1cyVN0lUw6Z0nceaEgsVcDT8lbSgKKvKCAuRyhJ2fGXnA==
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Sat, 17 Jan
 2026 08:48:34 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.005; Sat, 17 Jan 2026
 08:48:33 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Samir M <samir@linux.ibm.com>
CC: Uladzislau Rezki <urezki@gmail.com>, Paul E McKenney <paulmck@kernel.org>,
	Vishal Chourasia <vishalc@linux.ibm.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, RCU
	<rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
Thread-Topic: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
Thread-Index: AQHchYRpschSzDs2s0aYlXrXOHLBTLVV5sgAgAAqTnw=
Date: Sat, 17 Jan 2026 08:48:33 +0000
Message-ID: <B7C99D22-0544-4177-A299-E3D458EA55F6@nvidia.com>
References: <20260114183415.286489-1-urezki@gmail.com>
 <1c6b741e-acfd-432b-bd04-4534c2e2511a@linux.ibm.com>
In-Reply-To: <1c6b741e-acfd-432b-bd04-4534c2e2511a@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|SA1PR12MB7409:EE_
x-ms-office365-filtering-correlation-id: df534bee-0bc5-46e2-405b-08de55a5327f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UXlTZW5WVTNRL25NSHhtMjZDV3pydUxFRnZUNEgxdC9nOWdPOVUxNk04alg2?=
 =?utf-8?B?ZHB1OU9pME1GSXo3NUZscUUxWFZSQ245SFdSQ0JhNERtMjVEOFBCeFJiMXQw?=
 =?utf-8?B?WEZ1Y0U4aFRmNFRNc2pYSUpmenNiWTk0VS9HOHZFVXVHKzZlVDIrYTgwbGI5?=
 =?utf-8?B?b0RYR1Roc2JOMzVnVmJhYkJPS1FuQlVGd2NOMlQ3NnhJSVBiRm10T2Y4MFRF?=
 =?utf-8?B?b3piTFFEY3lnWHZMeC9PNXdOWW56dnFjMFI4cnhXT2JaSVJERkVkN0lNY0kx?=
 =?utf-8?B?R0NJY3NYVitlUEFhNFNmWHdaekcvMmhhYzlDU3NIMjkyL1ZFelpjeTBUcFdV?=
 =?utf-8?B?VjVJMjhmZmZCbDNuNG45NDI2VG9YMUhySlowTmRaVktFZzIvbU9uRldSdG41?=
 =?utf-8?B?NmFCSkJobm14VG9qNktuQ1pyT3pDd01wcHNSNHBFcFNBc1pidTZCQjQ1MkFk?=
 =?utf-8?B?cFprRWJyK0oxU3lWaWVxdmZCY3ljSC8yMDUxNmNHWWpncW1mMWw5ckE2ZTV0?=
 =?utf-8?B?ZU9NZmhrT0Mxa0JyTnZnQzNhZWdYSzhQMC8rMm9qcmN5aWxJMXNwSnpuTkVE?=
 =?utf-8?B?UTgzMFErMTNaaEJyUHhSY1V3a2pwc0pySzZOanNNaEJaK0VGT2lTL1ZjRjFL?=
 =?utf-8?B?UFV6c1Z5Vk1oeGJVb2xGeEFTVy9GZFRtR1pOUUZYczRMVU9jdnIzeGVzdlVw?=
 =?utf-8?B?MkluL1UzU3VQM3gxVm1rVW1nbGlOb2M1cER6cnp1V1M5cmU5N0tlb1NrU3NZ?=
 =?utf-8?B?S1JEZnFvNFRqeWtFaFZCb0ZXSzZ5emRSdjlyYy9Mc3FNa3NZWDVlMTZIUURs?=
 =?utf-8?B?cGd3N3FpdUtMSS93eFdUcnpjQTRPS3VkZktKQXlGQTdzSmpHbS9vY2NudTNk?=
 =?utf-8?B?bVVRdmpzMTV4dkJ1NzhYdFJPMS96VkpDeEdPbmxKNDlQRllUMzR1RlJsdmVw?=
 =?utf-8?B?UXM2QStobnNRQmpucVNYSi9odVRrc3FYeTFRVG4wUmVudlQ5WHJxVlZXTnh4?=
 =?utf-8?B?NkpNUkZFYjQ5YzUyM1JRelBtMmxSNXg3VitzSXQ0V3M4Vzd1d2V4VVpnblEv?=
 =?utf-8?B?Q1RjNTJJUythZ2NVaUdGUlM2U1dQNUptQXpubm1COUNobzd3OXdmMnF2VkFL?=
 =?utf-8?B?YVNKV1ZCS094UE1wZk5tTnlER2lYenowVDRMbzRNcFBkMlYrWmhJcGpyYlhy?=
 =?utf-8?B?WG9CNzRvRDIrMGZCbXdjYUtoUFZOUWduM21MWDBDa2RWc1J3QzVCOXBnTWxy?=
 =?utf-8?B?ZkhGRmhHTm9uV0lwbWtNTVk2WU9kU1p1MEFCS2lDdEh3dXQ0d3pCSTl0cUhj?=
 =?utf-8?B?MXpscnlQNS9kMlA4dkJHWm9ETWNwS1J1azcram9DVnhkUkhMMWt2SE40Y0Ja?=
 =?utf-8?B?Z2xsaXJZc1VPOTIvRHUxZjU5b1VhOUNvWUZSODhQNEQrNlI4U29VeE90OGtI?=
 =?utf-8?B?S3g2N1NkS3dCUDZvbnQ2TzdtNHhBUzZHajNSRjRCVkE5ZWZ6NG1OMWJZWlZW?=
 =?utf-8?B?dFF3WC9lT01FWjFkSEpobWVEd040S0RCNW1aMGVNSnV2V0RtdVpZU1RUNVUw?=
 =?utf-8?B?eU12dlRTQ3BsMm9jNVVRWXVva1cxSld3dEtxbDBEaHdLOGlQd2E5b2FqQ0hY?=
 =?utf-8?B?dHU4ZEM0bVFXRGR6ZWxpekhXZDMzRis3bDZ5MkQzekdlWTloZlZUMTN0bXZL?=
 =?utf-8?B?aFpXWUthdFQ0N0ZLVHlKZnhIcG5GWG1xZnZ6eXVhN2lHRTd6ako4OXBzeHFJ?=
 =?utf-8?B?Ry9Ia3dsL2FaUVpxQjh0dWRhNVIvVE9uV1ZUZDdZcmlEelBRL1dDVGswbXF0?=
 =?utf-8?B?N3l2N1lKQXBORFF3VTdSKytkclcySzZPTFJiZFNxeXN4MUFsM05kL2RFaVBB?=
 =?utf-8?B?WTMrOGNDQmc1Y285SnYrQ3V5R1JUMmhWQ3RkeklBbjdxZlRKVmRpQ1VkR0ta?=
 =?utf-8?B?QmtLQzJhNWdDUzY1ZkVxSG85VStrS2FWWEtxN0hyRCtMWVd4YXU1MGU0SWNP?=
 =?utf-8?B?bDhGbExCakdjYVNLZnc2ZHpxcVJDVnFVRlQ3U2tsclptQjJaNDVGbEIzR2ZU?=
 =?utf-8?B?TXI5elZaTElEWjB5NHROMGFYamtPUStGNVVsSTRtVFI1RjBFVGF4ZWVBZXVX?=
 =?utf-8?B?NVUvYStVWEwyWmwvZlZiSExrQ0I5a3FTeDJCZ01SWklqbVZqSEgva3RDNy8r?=
 =?utf-8?Q?LA8NnTYo/ihG4nrLy2pX1Rw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1l3YVhaQW5tMzVFRUNnU0swUUdzTmsxRmd3MTZUdEsySkRtU2FrTzdhVllh?=
 =?utf-8?B?TklSZ2xjMkgwWHk4aVpoR1hoZzJkK0h0QWRIc1UyQTJCMXNXUC9WcWcyakpK?=
 =?utf-8?B?aWd6UUJ4cExGV3czZUhOQnlseFRxcWdrWTBKbzhZSVo0MEJseWtCYW12Tk1X?=
 =?utf-8?B?blZJWG8xRXdPb2RCZitlaTJvd01uNVYvQ2szYmFaOE84eU9OR1hwdUtLeEVn?=
 =?utf-8?B?cjY0Z3lDU0swU1BybVgrTVVPZ3RtbjNKeG1oZ091UE5aUm5YNTJXNXNKd3Vi?=
 =?utf-8?B?bFhKUmhNL1I0WDExRnBwVkpuZ215NjIvR0M5QWJMakRibC9DUEE4MFN3TTlt?=
 =?utf-8?B?QlBXeGNiVm9IbTRYVUtNcDcrY0JLZ250d1ZZQWpSR05HUENBZS9vRmxTRHE0?=
 =?utf-8?B?NWZVeGFLcTV0clZoangrRS80VFNZNkN1bU9GTEZpMTVnTlBKUEZRVCs2REZh?=
 =?utf-8?B?ZXArNFVkZEZveG85NHhHbXdsWXNJQloycXVNWkdicHB3WkE5Q1VrOUs0TDBT?=
 =?utf-8?B?eU9lVnFIQ1ozQXI5dVNkQUxpeC8zTDdlUnA5aUNRRkVPa1prWEx3SHVrcTNs?=
 =?utf-8?B?TzJtWmUvQjRLQmhEUnZ5dURJemZITGVBTXIyNytWdkZUSmFETzM3Y0tEcmtU?=
 =?utf-8?B?Sit2a0pzckpKa3ZwRis3Y2MrTlZPSzN4elQ4dE5mM0tGMHF5L05tQXFGc2Vt?=
 =?utf-8?B?aDVVWUoySUhaK2VmT0dYanVyQWh3eS9hdG5qWmhvd0h0WHc5d25qM3d1WXZQ?=
 =?utf-8?B?NFZvSE5wR2g3N0lLSG9KSzM2TTVhV1BRcVd1OFllRkZHekV3cGQwQWt5M3lk?=
 =?utf-8?B?aUJXVllKSEl4dzhTUkZxSzhCbEV4TllTYmdIR0VLU2FSZkZnaVpUK2trcTBy?=
 =?utf-8?B?ZnFnS1ErWjFiNElPVUMwTGF5VGVLWXBHZUFpUVhpVXJQMFltdHl3VGQxWW1s?=
 =?utf-8?B?QWhBQzQvU0doVktEYXRWd09SMmpPNkw0R3pzNms0TktiUzdFck83OWJQNW9l?=
 =?utf-8?B?V0NzZ1JLODdtQ2VVU29iNi9PVnE0RXhVMXN3bGo5Z25IZ0ZqZFNzNUx5NjZN?=
 =?utf-8?B?UzZUcTlKWXZpaEZjU0ttRjlYQy9mdW03VmtxWFNPNEJGTFVodjBOTzhlZEZx?=
 =?utf-8?B?bG1tS2RBd05OWGFWZ0hNMjV4MmxGVzhCUDVVclZtZlFwNEJRQ1hxS1UyZW5p?=
 =?utf-8?B?dEZESlBXdE1WcWpOaEZzTm04V2p1djZmNy93SmZsNW1WTk84VjY4cjU0d3pK?=
 =?utf-8?B?Zm9zRTcvY2xrTFJPZmIxU0tuRzJuYm9xMEZqS0FzQU9hdlI1bWJMclNVdWVp?=
 =?utf-8?B?cHVsUUlpdlNkbGVMTHorRHpOSkh0dWNNZ1pkUlBSazE3Sk1mZ0dHM2dNdm1s?=
 =?utf-8?B?WldnVUdjUjgxVDJ5R2REdm9FRVZUYzZCYTVzWHk0TC9JTmd3Uml3dDFjSGQr?=
 =?utf-8?B?MzVuRUFvTFVSdnB0VVpUSWh2UE1NYmpTY0t3NUNFZWxhMExkZlpQbTVPamNy?=
 =?utf-8?B?VEd4a1hRSzR3YVlLQUtRcDJTUUd0M1Vjc3hNNnRLcHpleXFsaFV3M0ZuQkFZ?=
 =?utf-8?B?WTU0L3VPTzFhSVA3Z1VrVkhiRHVnbSt6OVFDdWhDd0ZadDBxQVlqSDdKdHI3?=
 =?utf-8?B?Z0J6c2haM2pLaEVzR2U2cjIxNlhDd0J2aGpWSnUwUnhqK0NnMDNyMzd0eDlx?=
 =?utf-8?B?ZVlHMy9TNkVpWTl5VEpDVWtTZERZaGtwNWFxSGV4VzhWZlAzM1FPUWY1UmND?=
 =?utf-8?B?bnAydHU3b1BzVzJwTmYwUDJpd0trL25FYnlSL0dIOUlaSDQzWG9FL3VVMlhw?=
 =?utf-8?B?aDZpNkFGbXNHRmc4eS9aVE1RYU1MSWRqOHBwdW8wd045YkNBcG9ObmN0NFF6?=
 =?utf-8?B?ellIWHVkK2ZLelN6QTFKaXY3cm9UN1lQNEx2MnhFaDlTRmhiL0J2YW1pMk9Y?=
 =?utf-8?B?V2RicTcyNjkvUnVVYXl3dkphbkErMjZjaUtENjB1T0gwY2hjMmpwUUNERk1Y?=
 =?utf-8?B?dXNEMzcwOUVxa09YMko5ekRHaE45ZVpDNWl4djR1ZlFjbHZBbTlheEF1NjZK?=
 =?utf-8?B?M0laQ1ZyOXZYc2FRL2FaQkV1akVFK0M2cllYcWNSU0k0b252UWI4bGdtUzU5?=
 =?utf-8?B?ZDNCUnYyKzFqYUVHU2MwWUM5aXNwdkYrT250TE9FMUFISXdqV3Y5dDMwUkxZ?=
 =?utf-8?B?c0VtRFFhNzJuT1g1NWVvaVF4NlNXdGI3MWxxSjRDbU5TZWJXLzV1MmZSek5t?=
 =?utf-8?B?U2dKcHJDeXlOeHRjWWhnTWd3RVVPeWVuOVVPa3AzTFA4Njg2STFrUzhUTmtF?=
 =?utf-8?B?Q09JM0UwZ1lzZlhrZGlUaVBsMWZpNGIrRG4zaG5SNXgzc2M1NG5TUT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df534bee-0bc5-46e2-405b-08de55a5327f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2026 08:48:33.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOzKsT2/ZXtnAvw4+C4/gVVgu090dUl6LnVwOiHC9Fqg81yfFhqQwgu05UYk/Ol7g0O79700CJlR2P9Uh1IB/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409

DQoNCj4gT24gSmFuIDE3LCAyMDI2LCBhdCAxOjE34oCvQU0sIFNhbWlyIE0gPHNhbWlyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+PiBPbiAxNS8wMS8yNiAxMjowNCBhbSwgVWxh
ZHppc2xhdSBSZXpraSAoU29ueSkgd3JvdGU6DQo+PiBDdXJyZW50bHksIHJjdV9ub3JtYWxfd2Fr
ZV9mcm9tX2dwIGlzIG9ubHkgZW5hYmxlZCBieSBkZWZhdWx0DQo+PiBvbiBzbWFsbCBzeXN0ZW1z
KDw9IDE2IENQVXMpIG9yIHdoZW4gYSB1c2VyIGV4cGxpY2l0bHkgc2V0IGl0DQo+PiBlbmFibGVk
Lg0KPj4gDQo+PiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYW4gYWRhcHRpdmUgbGF0Y2hpbmcgbWVj
aGFuaXNtOg0KPj4gICogVHJhY2tzIHRoZSBudW1iZXIgb2YgaW4tZmxpZ2h0IHN5bmNocm9uaXpl
X3JjdSgpIHJlcXVlc3RzDQo+PiAgICB1c2luZyBhIG5ldyBhdG9taWNfdCBjb3VudGVyKHJjdV9z
cl9ub3JtYWxfY291bnQpOw0KPj4gDQo+PiAgKiBJZiB0aGUgY291bnQgZXhjZWVkcyBSQ1VfU1Jf
Tk9STUFMX0xBVENIX1RIUig2NCksIGl0IHNldHMNCj4+ICAgIHRoZSByY3Vfc3Jfbm9ybWFsX2xh
dGNoZWQsIHJldmVydGluZyBuZXcgcmVxdWVzdHMgb250byB0aGUNCj4+ICAgIHNjYWxlZCB3YWl0
X3JjdV9ncCgpIHBhdGg7DQo+PiANCj4+ICAqIFRoZSBsYXRjaCBpcyBjbGVhcmVkIG9ubHkgd2hl
biB0aGUgcGVuZGluZyByZXF1ZXN0cyBhcmUgZnVsbHkNCj4+ICAgIGRyYWluZWQobnIgPT0gMCk7
DQo+PiANCj4+ICAqIEVuYWJsZXMgcmN1X25vcm1hbF93YWtlX2Zyb21fZ3AgYnkgZGVmYXVsdCBm
b3IgYWxsIHN5c3RlbXMsDQo+PiAgICByZWx5aW5nIG9uIHRoaXMgZHluYW1pYyB0aHJvdHRsaW5n
IGluc3RlYWQgb2Ygc3RhdGljIENQVQ0KPj4gICAgbGltaXRzLg0KPj4gDQo+PiBTdWdnZXN0ZWQt
Ynk6IEpvZWwgRmVybmFuZGVzIDxqb2VsYWduZWxmQG52aWRpYS5jb20+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBVbGFkemlzbGF1IFJlemtpIChTb255KSA8dXJlemtpQGdtYWlsLmNvbT4NCj4+IC0tLQ0K
Pj4gIGtlcm5lbC9yY3UvdHJlZS5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZS5jIGIva2VybmVsL3Jj
dS90cmVlLmMNCj4+IGluZGV4IDI5M2JiZDlhYzNmNC4uYzQyZDQ4MGQ2ZTBiIDEwMDY0NA0KPj4g
LS0tIGEva2VybmVsL3JjdS90cmVlLmMNCj4+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+PiBA
QCAtMTYzMSwxNyArMTYzMSwyMSBAQCBzdGF0aWMgdm9pZCByY3Vfc3JfcHV0X3dhaXRfaGVhZChz
dHJ1Y3QgbGxpc3Rfbm9kZSAqbm9kZSkNCj4+ICAgICAgYXRvbWljX3NldF9yZWxlYXNlKCZzcl93
bi0+aW51c2UsIDApOw0KPj4gIH0NCj4+ICAtLyogRW5hYmxlIHJjdV9ub3JtYWxfd2FrZV9mcm9t
X2dwIGF1dG9tYXRpY2FsbHkgb24gc21hbGwgc3lzdGVtcy4gKi8NCj4+IC0jZGVmaW5lIFdBS0Vf
RlJPTV9HUF9DUFVfVEhSRVNIT0xEIDE2DQo+PiAtDQo+PiAtc3RhdGljIGludCByY3Vfbm9ybWFs
X3dha2VfZnJvbV9ncCA9IC0xOw0KPj4gK3N0YXRpYyBpbnQgcmN1X25vcm1hbF93YWtlX2Zyb21f
Z3AgPSAxOw0KPj4gIG1vZHVsZV9wYXJhbShyY3Vfbm9ybWFsX3dha2VfZnJvbV9ncCwgaW50LCAw
NjQ0KTsNCj4+ICBzdGF0aWMgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKnN5bmNfd3E7DQo+PiAg
KyNkZWZpbmUgUkNVX1NSX05PUk1BTF9MQVRDSF9USFIgNjQNCj4+ICsNCj4+ICsvKiBOdW1iZXIg
b2YgaW4tZmxpZ2h0IHN5bmNocm9uaXplX3JjdSgpIGNhbGxzIHF1ZXVlZCBvbiBzcnNfbmV4dC4g
Ki8NCj4+ICtzdGF0aWMgYXRvbWljX2xvbmdfdCByY3Vfc3Jfbm9ybWFsX2NvdW50Ow0KPj4gK3N0
YXRpYyBhdG9taWNfdCByY3Vfc3Jfbm9ybWFsX2xhdGNoZWQ7DQo+PiArDQo+PiAgc3RhdGljIHZv
aWQgcmN1X3NyX25vcm1hbF9jb21wbGV0ZShzdHJ1Y3QgbGxpc3Rfbm9kZSAqbm9kZSkNCj4+ICB7
DQo+PiAgICAgIHN0cnVjdCByY3Vfc3luY2hyb25pemUgKnJzID0gY29udGFpbmVyX29mKA0KPj4g
ICAgICAgICAgKHN0cnVjdCByY3VfaGVhZCAqKSBub2RlLCBzdHJ1Y3QgcmN1X3N5bmNocm9uaXpl
LCBoZWFkKTsNCj4+ICsgICAgbG9uZyBucjsNCj4+ICAgICAgICBXQVJOX09OQ0UoSVNfRU5BQkxF
RChDT05GSUdfUFJPVkVfUkNVKSAmJg0KPj4gICAgICAgICAgIXBvbGxfc3RhdGVfc3luY2hyb25p
emVfcmN1X2Z1bGwoJnJzLT5vbGRzdGF0ZSksDQo+PiBAQCAtMTY0OSw2ICsxNjUzLDE1IEBAIHN0
YXRpYyB2b2lkIHJjdV9zcl9ub3JtYWxfY29tcGxldGUoc3RydWN0IGxsaXN0X25vZGUgKm5vZGUp
DQo+PiAgICAgICAgLyogRmluYWxseS4gKi8NCj4+ICAgICAgY29tcGxldGUoJnJzLT5jb21wbGV0
aW9uKTsNCj4+ICsgICAgbnIgPSBhdG9taWNfbG9uZ19kZWNfcmV0dXJuKCZyY3Vfc3Jfbm9ybWFs
X2NvdW50KTsNCj4+ICsgICAgV0FSTl9PTl9PTkNFKG5yIDwgMCk7DQo+PiArDQo+PiArICAgIC8q
DQo+PiArICAgICAqIFVubGF0Y2g6IHN3aXRjaCBiYWNrIHRvIG5vcm1hbCBwYXRoIHdoZW4gZnVs
bHkNCj4+ICsgICAgICogZHJhaW5lZCBhbmQgaWYgaXQgaGFzIGJlZW4gbGF0Y2hlZC4NCj4+ICsg
ICAgICovDQo+PiArICAgIGlmIChuciA9PSAwKQ0KPj4gKyAgICAgICAgKHZvaWQpYXRvbWljX2Nt
cHhjaGcoJnJjdV9zcl9ub3JtYWxfbGF0Y2hlZCwgMSwgMCk7DQo+PiAgfQ0KPj4gICAgc3RhdGlj
IHZvaWQgcmN1X3NyX25vcm1hbF9ncF9jbGVhbnVwX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQ0KPj4gQEAgLTE3OTQsNyArMTgwNywxNCBAQCBzdGF0aWMgYm9vbCByY3Vfc3Jfbm9ybWFs
X2dwX2luaXQodm9pZCkNCj4+ICAgIHN0YXRpYyB2b2lkIHJjdV9zcl9ub3JtYWxfYWRkX3JlcShz
dHJ1Y3QgcmN1X3N5bmNocm9uaXplICpycykNCj4+ICB7DQo+PiArICAgIGxvbmcgbnI7DQo+PiAr
DQo+PiAgICAgIGxsaXN0X2FkZCgoc3RydWN0IGxsaXN0X25vZGUgKikgJnJzLT5oZWFkLCAmcmN1
X3N0YXRlLnNyc19uZXh0KTsNCj4+ICsgICAgbnIgPSBhdG9taWNfbG9uZ19pbmNfcmV0dXJuKCZy
Y3Vfc3Jfbm9ybWFsX2NvdW50KTsNCj4+ICsNCj4+ICsgICAgLyogTGF0Y2g6IG9ubHkgd2hlbiBm
bG9vZGVkIGFuZCBpZiB1bmxhdGNoZWQuICovDQo+PiArICAgIGlmIChuciA+PSBSQ1VfU1JfTk9S
TUFMX0xBVENIX1RIUikNCj4+ICsgICAgICAgICh2b2lkKWF0b21pY19jbXB4Y2hnKCZyY3Vfc3Jf
bm9ybWFsX2xhdGNoZWQsIDAsIDEpOw0KPj4gIH0NCj4+ICAgIC8qDQo+PiBAQCAtMzI2OCw3ICsz
Mjg4LDggQEAgc3RhdGljIHZvaWQgc3luY2hyb25pemVfcmN1X25vcm1hbCh2b2lkKQ0KPj4gICAg
ICAgIHRyYWNlX3JjdV9zcl9ub3JtYWwocmN1X3N0YXRlLm5hbWUsICZycy5oZWFkLCBUUFMoInJl
cXVlc3QiKSk7DQo+PiAgLSAgICBpZiAoUkVBRF9PTkNFKHJjdV9ub3JtYWxfd2FrZV9mcm9tX2dw
KSA8IDEpIHsNCj4+ICsgICAgaWYgKFJFQURfT05DRShyY3Vfbm9ybWFsX3dha2VfZnJvbV9ncCkg
PCAxIHx8DQo+PiArICAgICAgICAgICAgYXRvbWljX3JlYWQoJnJjdV9zcl9ub3JtYWxfbGF0Y2hl
ZCkpIHsNCj4+ICAgICAgICAgIHdhaXRfcmN1X2dwKGNhbGxfcmN1X2h1cnJ5KTsNCj4+ICAgICAg
ICAgIGdvdG8gdHJhY2VfY29tcGxldGVfb3V0Ow0KPj4gICAgICB9DQo+PiBAQCAtNDg5MiwxMiAr
NDkxMyw2IEBAIHZvaWQgX19pbml0IHJjdV9pbml0KHZvaWQpDQo+PiAgICAgIHN5bmNfd3EgPSBh
bGxvY193b3JrcXVldWUoInN5bmNfd3EiLCBXUV9NRU1fUkVDTEFJTSB8IFdRX1VOQk9VTkQsIDAp
Ow0KPj4gICAgICBXQVJOX09OKCFzeW5jX3dxKTsNCj4+ICAtICAgIC8qIFJlc3BlY3QgaWYgZXhw
bGljaXRseSBkaXNhYmxlZCB2aWEgYSBib290IHBhcmFtZXRlci4gKi8NCj4+IC0gICAgaWYgKHJj
dV9ub3JtYWxfd2FrZV9mcm9tX2dwIDwgMCkgew0KPj4gLSAgICAgICAgaWYgKG51bV9wb3NzaWJs
ZV9jcHVzKCkgPD0gV0FLRV9GUk9NX0dQX0NQVV9USFJFU0hPTEQpDQo+PiAtICAgICAgICAgICAg
cmN1X25vcm1hbF93YWtlX2Zyb21fZ3AgPSAxOw0KPj4gLSAgICB9DQo+PiAtDQo+PiAgICAgIC8q
IEZpbGwgaW4gZGVmYXVsdCB2YWx1ZSBmb3IgcmN1dHJlZS5xb3ZsZCBib290IHBhcmFtZXRlci4g
Ki8NCj4+ICAgICAgLyogLUFmdGVyLSB0aGUgcmN1X25vZGUgLT5sb2NrIGZpZWxkcyBhcmUgaW5p
dGlhbGl6ZWQhICovDQo+PiAgICAgIGlmIChxb3ZsZCA8IDApDQo+IA0KPiANCj4gSGkgVWxhZHpp
c2xhdSwNCj4gDQo+IEkgdmVyaWZpZWQgdGhpcyBwYXRjaCB1c2luZyB0aGUgY29uZmlndXJhdGlv
biBkZXNjcmliZWQgYmVsb3cuDQo+IENvbmZpZ3VyYXRpb246DQo+ICAgICDigKIgICAgS2VybmVs
IHZlcnNpb246IDYuMTkuMC1yYzUNCj4gICAgIOKAoiAgICBOdW1iZXIgb2YgQ1BVczogMjA0OA0K
PiANCj4gVXNpbmcgdGhpcyBzZXR1cCwgSSBldmFsdWF0ZWQgdGhlIHBhdGNoIHdpdGggYm90aCBT
TVQgZW5hYmxlZCBhbmQgU01UIGRpc2FibGVkLiBUaGUgcmVzdWx0cyBpbmRpY2F0ZSB0aGF0IHdo
ZW4gU01UIGlzIGVuYWJsZWQsIHRoZSBzeXN0ZW0gdGltZSBpcyBub3RpY2VhYmx5IGhpZ2hlci4g
SW4gY29udHJhc3QsIHdpdGggU01UIGRpc2FibGVkLCBubyBzaWduaWZpY2FudCBpbmNyZWFzZSBp
biBzeXN0ZW0gdGltZSBpcyBvYnNlcnZlZC4NCj4gDQo+IFNNVD1PTiAgLT4gc3lzIDMxbTIyLjky
MnMNCj4gU01UPU9GRiAtPiBzeXMgMG0wLjA0NnMNCj4gDQo+IA0KPiBTTVQgTW9kZSAgICB8IFdp
dGhvdXQgUGF0Y2ggICAgfCBXaXRoIFBhdGNoICAgfCAlIEltcHJvdmVtZW50ICAgIHwNCj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+IFNNVD1vZmYgICAgIHwgMzBtIDUzLjE5NHMgICAgICB8IDI2bSAyNC4wMDlzICB8
ICsxNC41MyUgICAgICAgICAgfA0KPiBTTVQ9b24gICAgICB8IDQ5bSA1LjkyMHMgICAgICAgfCA0
N20gNS41MTNzICAgfCArNC4wOSUgICANCg0KU28gaXQgdGFrZXMgeW91IDQ3IG1pbnV0ZXMgdG8g
b2ZmbGluZSBDUFVzIGFuZCB5b3UgYXJlIE9rIHdpdGggdGhhdD8NCg0KLSBKb2VsDQoNCg0KDQo+
ICAgICAgICB8DQo+IA0KPiANCj4gUGxlYXNlIGFkZCBiZWxvdyB0YWc6IFRlc3RlZC1ieTogU2Ft
aXIgTSA8c2FtaXJAbGludXguaWJtLmNvbT4NCj4gDQo+IFJlZ2FyZHMsDQo+IFNhbWlyDQo+IA0K
PiANCg==

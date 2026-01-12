Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EC1494C3;
	Mon, 12 Jan 2026 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228638; cv=fail; b=TY/celuoQwzftx2Ox2CzyM8Bx6ev6+mfr8pigmp8euKBedUlHVF6RjDLLRqMQAjIvD1YRz2lmvZId4arechmkrrJnGRGq1lz7xNx2RQGgHVVSkERt2g0Tuw16J5Lf8a+QTxubUw+4vs/rRe+Jqx6zSRDs9aNHmm1yYvQsBXQeCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228638; c=relaxed/simple;
	bh=GgteCHm1ctrobphpJynr4P7rq/ShPEpPRs7cWFzJXDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXzDjGYNKdwiJwWzLVTDDWODV4MXSygN8425S+ltbPd8RD2NXoUXC/JgTjP7WU73+MEkmT/EJUZEA9IlnT4roCt8Yv71Dqtm+AfEzgje3/AaKxWDau6QvVGhOxyQYdYlqm60+Y8xqEmzD4bvVtnSaia3V33Sk1sxQm6p9uOUpo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DoE6PggC; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DoE6PggC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oA8f7oykKHdYtGZj6qcOi4wYQt3d8QrgdQX1z8Af6pPR+3vx5XH+Skn3pO2eSy4xDdlFkf7+/8aTkU43gLrFxdZYEY70ZUpLGwWRCuj1RQ4Tzeboj7J/HJnbHjRiK0P8goQXCJ0YeNS59Jvr4cEd7/5M1BwHr3h3u9HqCFlEy+IrD1Y/8w27rCkEcbeyCrrjcrGIZF8M9AywokVN6Mz/i2V1nEmNUSEi5ag3HazsqU9EUFe7QrKejzUrR7NPt4Lx26+sCWxG8J0O3Puq+O5C7jQWgQohekQNwrdapoI77faEXrZ/5/zLezpqconJCv9sn8aANgVeosp9XWXeGfCovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgteCHm1ctrobphpJynr4P7rq/ShPEpPRs7cWFzJXDw=;
 b=xvomP7TVyvCegnmy+uxVeYrbJaLD43jhkbeOQO5zMu51lPIOGF2UwYgXBcpoXHyeGVhgLcORlWN44TC8myR1nDenQy7aVljEQIuNcytIWu+wt9C7xoBUNJRQT4WAVeSG/3nkvxpjOenXd7zJTiwxPXtAYXsrDNMIWT1OLQDBIrot+ZGZc+r+ZeRaXd5NVaBnLcpXdOEsK5/vOAQbfulzRvZ12HoVEZFPEsaWlYSTGIgsVHxZ/PIUNoex6IyGLPQ4TbqCkFEkIYNxTORTVedRyL16fDlb0cfmXkqcHkRS+MmZKbiZS+mOS2wvcExJUTlcHs1qOuTvUeE0xKJNF2WSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgteCHm1ctrobphpJynr4P7rq/ShPEpPRs7cWFzJXDw=;
 b=DoE6PggCSczQsRlWxRsDVYmlGfUkaPFP0D8IeT7p3+G7UEGzV4Zk5Fbuqk1JDvhujrpqklLqNeCrTtWbx3YZzH3B7lW/7yDLXmeg/THmHaOjmUam3OkUXhexiA9ZgpcB4NFnHViffKzGmW9sZf+KNtnmHD7VQ0PoJ0ODSr+u3TFT+Mwf6Ylh/vzs07Bjaw1Y+uFRmpZ2uWXuh7hp+fF+mGCvK95pkGkrHJqjKkedbdrx7Xv98q1g1gTF9wSzKJDRX04+MpyYnFDMWv7HEFafCi2wWAzX81YGzwedwao8XTmJufpJpU8RQXH8b0HmaBuAzGp7WWsfKktHWCE0Fw2/IQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 14:37:14 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 14:37:14 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Vishal Chourasia <vishalc@linux.ibm.com>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"frederic@kernel.org" <frederic@kernel.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"urezki@gmail.com" <urezki@gmail.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"sshegde@linux.ibm.com" <sshegde@linux.ibm.com>, "srikar@linux.ibm.com"
	<srikar@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Topic: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Index: AQHcg6gSQ2wH1CXqL0ua+MpkTxEkB7VOkQWegAAE8a6AAADeAIAAA74f
Date: Mon, 12 Jan 2026 14:37:14 +0000
Message-ID: <A80BD0D2-181C-4C63-92F0-0B9E52F68F8F@nvidia.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <1654BF46-EB82-46C0-B03D-848C22CFAB4F@nvidia.com>
 <804E7B47-F515-4592-B12E-84AD251EB07D@nvidia.com>
 <20260112142350.GM830755@noisy.programming.kicks-ass.net>
In-Reply-To: <20260112142350.GM830755@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|LV5PR12MB9778:EE_
x-ms-office365-filtering-correlation-id: 63110c33-fcd7-4bea-bc33-08de51e81406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MHdLL1lKVDZOUTQrbzgvSXV1VC9LNS8xT3QzZlA5OTZ4Q1RsZGNKQ1FmRjVu?=
 =?utf-8?B?SHNmZ1JMV2ljUEZUTFl5bFBtNitjb2JQTDF4L0N6M01XRXprSTVkdklnWTZx?=
 =?utf-8?B?aU9KdlpnMjQ0bWR6WDZDMTRzblN6Y3N0M3NQbEY2VmdGc2c0V0V1OHg2RjlT?=
 =?utf-8?B?QjhLTURKVmUrV3ZCQTE5ZGwzajFBZnA2aTlFMmtJVXcxMVQzbW16S1h2UHV5?=
 =?utf-8?B?b1ozdnpoekx1VGhKRjlzekJCS3hMcjdaLzlkSHhXYStRbXlkL2JVdUZLN0ty?=
 =?utf-8?B?ZHlVcU44VFIzMnNGU2FzMU9tUU5BWFRWbDQ0S3lLenJXQUhGYVB6MUFiN0Ny?=
 =?utf-8?B?cWE2TnpKblJFaTdCQ2xCZGE4WGNiL256TitYMVVJRFJrclZlMWdQS01XYmcz?=
 =?utf-8?B?TUN6ankzeUZiVndjL2dzNTk5YWRlYm9LUnNFOCtpK3NmdTFkcTRlKzg4dnRr?=
 =?utf-8?B?MkRwV003Qis0VjRwM1UyMkc5TUVEZFB1MGE4UEpHdmlQWXovY0QwWTByTjVE?=
 =?utf-8?B?bEt3TFhxVTg1QUhCRFpNNTNCeERQUWg1Rkp1R2VVeitWSEhjd0JZU0FWSSsx?=
 =?utf-8?B?NTdwZlRFZGZDWVNtbWtZVmlvR3lmNTBjamV2VDlIc3BRSWw2Q0lrOXVLV3Ev?=
 =?utf-8?B?MU90QmxVRE5rVGd1ZDd3S1VTc3hxaTV1NTlYMkREK3Y5M3p0S0ZSWU5CZmF4?=
 =?utf-8?B?VUNrK1o3bzVRWXdmc1U2YTFWSDhVUitkNHdrUGdWTnRoSDFTYkFNb3RVcGFu?=
 =?utf-8?B?SE1yMEFQSHlyVnF5ZFRLWnF3K2JSVXIxRFZMalcwVmN6cm5BRC9LREdQWUxU?=
 =?utf-8?B?RllTZ1d6UWluU2JMelN4NkVwdWY1YVZMV0Rtb0JMRTVVd0g2WElQalJrZER6?=
 =?utf-8?B?Y3BRUU9aRzRSTnF1MjFiaWNnb3dIODU0enlrYlA5d2dGS1FXU2MrdmpHZVRV?=
 =?utf-8?B?VTdjUzdSaG0xdzNHalIzcWtyalBYbjlWMGdPRjZQVlFxd0lXR3R2U2FyVlJJ?=
 =?utf-8?B?NHRiMDNjZ1I0VmZTZ0g4Nkh6WjhRWmphVFk2em91QVEvVFBXTk80YzNKdlRB?=
 =?utf-8?B?WTN2UEsrcTlRSXFKYU1mTzVSWTRaMVpmUE56RzA1dkRIOWxHU0hzdzJuUFFR?=
 =?utf-8?B?V3Q5VzFRSWZPY2FVT0hZclBHc0x3eURQTlFCK1prUUYrelF4b2o2VjlVZ1d6?=
 =?utf-8?B?QmJjOXBvNWM5Q2tSV0JLbjViVUI2QmtiKzRUaGFqZVNYbTBEa3c0UE5NeUIv?=
 =?utf-8?B?UTh3ZXZUNERDYWhkWVVSS3BMalhxdXRheHQvc09sZWJLN0lqK2FjenVuM2dk?=
 =?utf-8?B?OEw3c2ZEelBMWHVmaDRqT1lhTG9HeEZwSDJ6VjlyeUg5MjZXblNVZENpQjVV?=
 =?utf-8?B?Qmk0RmRtUWNsNkdkV1p3R1BBZVJuK2hhQVY1Q1kvZSt5eXJCMyt3WGEzM1Zr?=
 =?utf-8?B?TlNoSEsrYnNxT1RmUXpxNlREaU1Yb3ZESVNSMW1laitkWXc2QkhvZkRmTjlo?=
 =?utf-8?B?ZC9VT2pFeTRiRmM3R2VUVnF0ZldEVWtwL0VZemxIMHB0QXB2YjlYR1FJNmtO?=
 =?utf-8?B?S0xXTjZIZ2NjRjJJMVlFRFJseklaTnM0bWp4OHdaK25WaE5jaHNzdHVsR2Zj?=
 =?utf-8?B?YW9hczRoeE9uZGdudFl0azRSaFVNMXRZajNEeUp5WnlISk4zLzhObWx6TCt6?=
 =?utf-8?B?cWJuWWhsYUlUUzhqSTdaajBLOXNUVnpCNS9PVXhRUWVMVW5SaXdYTlJnMkZv?=
 =?utf-8?B?NTJOK0NXYXQvUGM5eVltb3lwdHY5OXhNaExuOU5sUW1IRzlJNjBUNzh2RzFr?=
 =?utf-8?B?eVFFTEpVZ0s1WnFzV2o2QU9GODdnTU5FMklUQU5CZy9RSlVjS1BsMk90dWw4?=
 =?utf-8?B?OHRaYjVvUkRwdTNxeHpGZmY2MG5yb2dUU1V5azZtY09kcUJISktpRFJucEIr?=
 =?utf-8?B?ZlNzOFJsTEpveXVtOWhxdU9MZDdhejJJVVdTSXZabnJHVk1QQ3BvYmRXUGFk?=
 =?utf-8?B?TjY1d0VxdHRxcWVvdUFhYlg2NGZyYW9FSWZlUUdIYWF3VVA3SWttcDRzTElp?=
 =?utf-8?Q?5FFenW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0xxZW53RUczUXk3aUcvL0I4WlcvZmo1aStLdVFRMGpRb3BxWWhQUVp2eEZp?=
 =?utf-8?B?UDcrUWxKMTAzS0xDUjZOMUcrbDRwVDZrS211STIzZzMybitPbDF5czc1OVlP?=
 =?utf-8?B?c25QcmZEMll3OTlNazZHSGtuYit3UWJGanRuTzJCaHNaRFBYUVV0Um53L3NO?=
 =?utf-8?B?bi9JbW5LVDdlNDNVWnJLVGh0bEFyNkN6OVlWd3VZNjVoMjJ1YzZFck9uaXJ0?=
 =?utf-8?B?SlpqeEI5ai9Gdnh4TWpBa2tlOTMrNjRERm9NN2pTcFJOMTZwT1ZsaWlUMi9L?=
 =?utf-8?B?UEJxeHA2MEtUMnBTV0gzWWtYTXlmMjBJWEhlVG00dnBKdVc0cThPMEErVDgr?=
 =?utf-8?B?UlFlMGVSNmVqSEhEbDdoeEtOMks5MGhkVldGRUt4a05TY0RZZXlkSytRNUt1?=
 =?utf-8?B?NGRtM091dzBaQ3RQK1RXME0xdTNkWlgxL2ZVVmtoYm9rOTcxeGFHNStjcnJn?=
 =?utf-8?B?SHpybHdYWXFTanBLOVBrejlIQ3hVWmNkWmg4ZWU3cUxqV1lOVHUzTXBsT3c2?=
 =?utf-8?B?SHFaNUVOMWE3NkRQZCtIaUtlZUV6WkFHZU9wOWE4UlF1dEJ0dVFVeGlNSW5u?=
 =?utf-8?B?aUNPOWpCQU8xcW9wVDlVemc2VGZVaGpwU1p5dkhuaENPZ3JVTHJVQVFPcEpu?=
 =?utf-8?B?Y3dlbkcyVHpzVnhJLzR2K2hFSThGZklYMlFiNk5MeVFBMk5JZ2N4MEk2Rm1T?=
 =?utf-8?B?UHB1QjAwZEprRHVLTUlmUWpRUkhkN0duTUtxWTFYMVpyTjZBRTd0eHRoUWEr?=
 =?utf-8?B?NVJwWWU1REgyRFNoaldwYzRBaXkxTmhRY3JZTVRIRUVLK2Z6MEVMZEJoczdP?=
 =?utf-8?B?Zy9sbUZkaXBIQkxlaDBvL0YvVWZRWXlnUFhVdWJUcDJmR212VVVJODBkRjM3?=
 =?utf-8?B?Szg2elVjVlZ6TVh5OUNjbjErTm8xd2hnMkhSSG52dlNXM3N4OSsxOC9vME9R?=
 =?utf-8?B?RStqMTQ1cXIvYUZXazZvTTNZSjVSYzFOSXVUYk5Yc1krWDgzd0hQMGxocW40?=
 =?utf-8?B?NldHdC9PaVN0UTlicTNQQ3BHakJ0MVBSSVlOalJqWEZSTjlaempYNm5ydDdW?=
 =?utf-8?B?R1ZXZkxyV1ZIYlFCZkJWMkRnd2NEeEJmT1hZUlptZHp6MnI0ZERkMWYwY3l6?=
 =?utf-8?B?UlRLV0pLYnpKN1kxUHl4dmZEVmU4aTh4d0xwMnR1MVhiU0ZrWGxSS3Y0OUI2?=
 =?utf-8?B?aWpRbXgrNUtFRnBtS0pxUGJ2U0VycS9rcjFzamovWG91Y1JaRVJJT3N1dmhE?=
 =?utf-8?B?ZmIwd2dub0Z0SGZlNXpSQVpodlRMdlgwNDhXa1p6V3REWXUyQldqSG5NK1ZJ?=
 =?utf-8?B?Sk1PbkhpTFd2ZExTaGRtTm1WRW1Vb2ZXQXB5d2MrcWJSMHhwMDc2aDE2WUJ2?=
 =?utf-8?B?RmRBL2s5aVFoTWpKcTNGeUR6SGp3bUNteXc0TVRRTXdIb0prTEpkNjZhaWJT?=
 =?utf-8?B?UHFXRVVpVWVVY2hBSmhXeTcveEdJN0Vnam9RMjNaOVV0ejB3azgvY3JRYStm?=
 =?utf-8?B?YUlSNENYaHg3aXVzYU1TZVNIeEtGeFdHMUt2NWpCY3kwYkNCdVpabjNSY1hO?=
 =?utf-8?B?WXExem42V29qUHVCVkIrNnZtT0UvbXprQ00waFpuaW1yNHJBWitlakY4MVVJ?=
 =?utf-8?B?STVWb0VVcDhNdytQdjdqeEdRckw5QS9WMmtxem9aNEpienNHekloU1Vabm96?=
 =?utf-8?B?TXduSkZhNEEza0FiTlNCRnNaTFh0eVBoL25VcFhrRERSNlAwRU9hbFdZV2Yy?=
 =?utf-8?B?cXJ3MnVxdVNrd1VPamwwbWJqM0NucUdIUHhxdTcyZ3BiRXU4Si8wNHdMUmsw?=
 =?utf-8?B?bDVNR1FNZnozTDh1Rjd6NCtJb2RrUEgzY2lwYkJUOU9ISXFEY2lIRE1BNnZW?=
 =?utf-8?B?dGR3QndsZ1lxQ1Q3bkU4bVBkY1M1MXNxaXRHUjJtR3JYRjIxUWpjeFdaNGFK?=
 =?utf-8?B?Yk1xUnZvbk01TEZSTGNhVGt5bU5WWVl1a3FIdHhiYVpXb003MmZuZk51eFhm?=
 =?utf-8?B?bHg0U1N3b01IRXZ0QThxTXlrM1g4ZU5xalV2dmNuTkxsYlRmeFFtL1hPR2Q2?=
 =?utf-8?B?YTZOdlJPaGpMcGFSdEFnYTVoUW91aUJmUytBcG1GMHNnTnNRM3VxeE1CcjNm?=
 =?utf-8?B?NFArY1VxUjBTS2cwOGJRZjRUUmdsTE5mZWY4TXJhYTdaTWFiekZCVFJZUDZL?=
 =?utf-8?B?WUp4T2c5RDFBcjI5NitHLzRFM20xTlFUV0ZTYkVnbTNpREhoQkpUR0hycllQ?=
 =?utf-8?B?UFJiVjExV0JIYzdMT1YrL1V6MGVwWGpmb0Y5TUxoQXRXUU9iV0tKYW5lYmZ3?=
 =?utf-8?B?aGtoMG5TYm80NTBrMFZucWs1QWh4a0pMY3pscEpKK3NORzlHNEhnUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63110c33-fcd7-4bea-bc33-08de51e81406
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 14:37:14.3012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M01bVE9D6Eql9f1Vnnb3bV7P/s7VlIbESlrM+RCMuRgofiZsYsV3CsgMMV4D7uKhu6ytF3IZiG3tJannffI82w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778

DQoNCj4gT24gSmFuIDEyLCAyMDI2LCBhdCA5OjI04oCvQU0sIFBldGVyIFppamxzdHJhIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIEphbiAxMiwgMjAyNiBh
dCAwMjoyMDo0NFBNICswMDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4+
IE9uIEphbiAxMiwgMjAyNiwgYXQgOTowM+KAr0FNLCBKb2VsIEZlcm5hbmRlcyA8am9lbGFnbmVs
ZkBudmlkaWEuY29tPiB3cm90ZToNCj4+PiANCj4+PiDvu78NCj4+PiANCj4+Pj4gT24gSmFuIDEy
LCAyMDI2LCBhdCA0OjQ04oCvQU0sIFZpc2hhbCBDaG91cmFzaWEgPHZpc2hhbGNAbGludXguaWJt
LmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiDvu79CdWxrIENQVSBob3RwbHVnIG9wZXJhdGlvbnPi
gJRzdWNoIGFzIHN3aXRjaGluZyBTTVQgbW9kZXMgYWNyb3NzIGFsbA0KPj4+PiBjb3Jlc+KAlHJl
cXVpcmUgaG90cGx1Z2dpbmcgbXVsdGlwbGUgQ1BVcyBpbiByYXBpZCBzdWNjZXNzaW9uLiBPbiBs
YXJnZQ0KPj4+PiBzeXN0ZW1zLCB0aGlzIHByb2Nlc3MgdGFrZXMgc2lnbmlmaWNhbnQgdGltZSwg
aW5jcmVhc2luZyBhcyB0aGUgbnVtYmVyDQo+Pj4+IG9mIENQVXMgZ3Jvd3MsIGxlYWRpbmcgdG8g
c3Vic3RhbnRpYWwgZGVsYXlzIG9uIGhpZ2gtY29yZS1jb3VudA0KPj4+PiBtYWNoaW5lcy4gQW5h
bHlzaXMgWzFdIHJldmVhbHMgdGhhdCB0aGUgbWFqb3JpdHkgb2YgdGhpcyB0aW1lIGlzIHNwZW50
DQo+Pj4+IHdhaXRpbmcgZm9yIHN5bmNocm9uaXplX3JjdSgpLg0KPj4+PiANCj4+Pj4gRXhwZWRp
dGUgc3luY2hyb25pemVfcmN1KCkgZHVyaW5nIHRoZSBob3RwbHVnIHBhdGggdG8gYWNjZWxlcmF0
ZSB0aGUNCj4+Pj4gb3BlcmF0aW9uLiBTaW5jZSBDUFUgaG90cGx1ZyBpcyBhIHVzZXItaW5pdGlh
dGVkIGFkbWluaXN0cmF0aXZlIHRhc2ssDQo+Pj4+IGl0IHNob3VsZCBjb21wbGV0ZSBhcyBxdWlj
a2x5IGFzIHBvc3NpYmxlLg0KPj4+IA0KPj4+IFdoZW4gZG9lcyB0aGUgdXNlciBpbml0aWF0ZSB0
aGlzIGluIHlvdXIgc3lzdGVtPw0KPj4+IA0KPj4+IEhvdHBsdWcgc2hvdWxkIG5vdCBiZSBoYXBw
ZW5pbmcgdGhhdCBvZnRlbiB0byBiZWdpbiB3aXRoLCBpdCBpcyBhIHNsb3cgcGF0aCB0aGF0DQo+
Pj4gZGVwZW5kcyBvbiB0aGUgZGlzcnVwdGl2ZSBzdG9wLW1hY2hpbmUgbWVjaGFuaXNtLg0KPj4+
IA0KPj4+PiANCj4+Pj4gUGVyZm9ybWFuY2UgZGF0YSBvbiBhIFBQQzY0IHN5c3RlbSB3aXRoIDQw
MCBDUFVzOg0KPj4+PiANCj4+Pj4gKyBwcGM2NF9jcHUgLS1zbXQ9MSAoU01UOCB0byBTTVQxKQ0K
Pj4+PiBCZWZvcmU6IHJlYWwgMW0xNC43OTJzDQo+Pj4+IEFmdGVyOiAgcmVhbCAwbTAzLjIwNXMg
ICMgfjIzeCBpbXByb3ZlbWVudA0KPj4+PiANCj4+Pj4gKyBwcGM2NF9jcHUgLS1zbXQ9OCAoU01U
MSB0byBTTVQ4KQ0KPj4+PiBCZWZvcmU6IHJlYWwgMm0yNy42OTVzDQo+Pj4+IEFmdGVyOiAgcmVh
bCAwbTAyLjUxMHMgICMgfjU4eCBpbXByb3ZlbWVudA0KPj4+IA0KPj4+IFRoaXMgZG9lcyBsb29r
IGNvbXBlbGxpbmcgYnV0LCBDb3VsZCB5b3UgcHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0
IGhvdyB0aGlzIHdhcyB0ZXN0ZWQgLSB3aGF0IGRvZXMgdGhlIHBwYyBiaW5hcnkgZG8gKGhvdyBt
YW55IGhvdCBwbHVncyAsIGhvdyBkb2VzIHRoZSBwZXJmb3JtYW5jZSBjaGFuZ2Ugd2l0aCBjeWNs
ZSBjb3VudCBldGMpPw0KPj4+IA0KPj4+IENhbiB5b3UgYWxzbyBydW4gcmN1dG9ydHVyZSB0ZXN0
aW5nPyBTb21lIG9mIHRoZSBzY2VuYXJpb3MgbGlrZSBUUkVFMDMgc3RyZXNzIGhvdHBsdWcuDQo+
PiANCj4+IEFsc28sIHdoeSBub3QganVzdCB1c2UgdGhlIGV4cGVkaXRlIGFwaSBhdCB0aGUgY2Fs
bHNpdGUgdGhhdCBpcyBzbG93DQo+PiB0aGFuIGJsYW5rZXQgZXhwZWRpdGluZyBldmVyeXRoaW5n
IGJldHdlZW4gaG90cGx1ZyBsb2NrIGFuZCB1bmxvY2suDQo+PiBUaGF0IGlzIG1vcmUgc3BlY2lm
aWMgZml4IHRoYW4gdGhpcyBmaXggd2hpY2ggYXBwbGllcyBtb3JlIGJyb2FkbHkgdG8NCj4+IGFs
bCBvcGVyYXRpb25zLiBJdCBhcHBlYXJzIHRoZSByZXBvcnQgeW91IHByb3ZpZGVkIGRvZXMgcHJv
dmlkZSB0aGUNCj4+IGN1bHByaXQgY2FsbHNpdGUuDQo+IA0KPiBCZWNhdXNlIGhvdHBsdWcgaXMg
bm90IGEgZmFzdCBwYXRoOyB0aGVyZSBpcyBubyBleHBlY3RhdGlvbiBvZg0KPiBwZXJmb3JtYW5j
ZSBoZXJlLg0KDQpBZ3JlZWQsIEkgd2FzIGp1c3Qgd29uZGVyaW5nIGlmIGl0IHdhcyBpbmNyZWRp
Ymx5IHNsb3cgb3Igc29tZXRoaW5nLiBMb29raW5nIGZvcndhcmQgdG8gbW9yZSBqdXN0aWZpY2F0
aW9uIGZyb20gVmlzaGFsIG9uIHVzZWNhc2UsDQoNCiAtIEpvZWwNCg0KDQo+IA0K

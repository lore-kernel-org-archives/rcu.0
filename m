Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D502397B9;
	Fri, 18 Apr 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008024; cv=fail; b=GtRsdvjzaFDCYOEi7ZTORknDbwHHQkq4rTrPIq9iyTM88AHbX8TfPQE8Q7/XjDE8jgRrbv76tHAiG1htWgJJxrHX7CDeQMXyx+rfnyNyOGdgn5NpKWkl9N5PXdvDRbW63iORz3GS6Izrh0Dft5iZiq4SPuCSTLwb4+oIuQkVepg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008024; c=relaxed/simple;
	bh=iDwEzVBpKcztCkil3wXr6Z2vOQStItocMViJmCk0Go4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LUo9Kg0TGlsVSNciQzMjHDf6Q1TETkZ8iL00Xd6o9/cKUuIoeD/uNHB1CBDLCg1OEHRWlQkjNT2szvKagBvu4MS45CWyvfWUKBz92122pMdr2RkudgQpA8IT8MYSNviZPHSy1JTNQiPyBnmCP2A3v6Js4pVecHPe5FYqq9ABeB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rpZkAh3Z; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rpZkAh3Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Odbxhh5/0d3nVJs9IcUyYd1AFC4Pt1cjNUNs3Q/ZgDRB5tgnGCn7S9a3bKunQsiBBrPdjZTDL8ysncXDtVmfB6T6dfBxZdXOpN0edL0Xf/fQ6kJSLvwC2979RphfLpKPnGKtzKYRqOMJ2qzfRkSyRdTEUtvMudS7pbop/XB8VNQYGk3LFw7gmiDz4ouAAKXQCWPbqnM+8mPn3CBAl2/UCcPGQsx0jcKKBYZFKigSvFKCoN0LboQ7duDLppLNrpSD/9+zeCHc2A/hgTFOSYX9yZhaeTwMwtpZKSdba/pk3GAiAxpXuVc4mqhtFDFP3Eb8UjqPmtBgB+LQiXPHA1Z63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEAANV7uASOrrwEifMViGRoYLXg2CLJYoaIEzcqx1EQ=;
 b=vWzVcKJkq3gKfSRxX4QmnRJ8FTjghgX6QrSuSn8Flg3LRZM2s4d7l96qaFkjHNZYKxPWYAg3KeaxE0Nqpa6SG0Ixgn+hwwrl36yVWVhqc265/pSEPdZSA/Q8WtgccsJEg7bwNnFcRq0s7p0tveSB8hscJo0vOiyOZgPtzwAaaRzbDpVwYYdfO5FxuPt43sPaXGIScDU4+B0kW97EIDvS7gVMgUw2WKQ4BYCJqoZ/fnylx8yHu3//+UYC3B4JIdVZExUNHG01SdceWwoSYlu4jVAndJGPEMYSKtQ74Ra5CWyDRq+tj+ng6cUfJEiNEE30WHH/fW4aGvOrkejC77lqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEAANV7uASOrrwEifMViGRoYLXg2CLJYoaIEzcqx1EQ=;
 b=rpZkAh3Z3ASv2v1Mwuf+h9ONYVGRfBetQp2GIGyCAsu8Ax0sxoTPNDhuexNkgN7qkDgYwx4nraUoJTb+v1ixuLBCrwWtibCE/NUrTDubDy1lc3SEM/j3jl/SjNazBnXTpb67mSra2PpZee+pKxAA0FgIaPUYZGXk2k8wZkkdkXvUlFC+ksnm9q55AQiZiQQbc7rVYMG8y4bKNHI0GEpIABxUCDrJPXPengzQ6OMOCh6keMxceuBXw7dz/ccVMbLyYnx/Fi94m8OeBE1yUM0E9FHpaQUD7vHGaWV1Q2x/T4S9ESpSNIBWtiYVT9z0vvemFwMsRvt6zwxsCTtxsH7xdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Fri, 18 Apr
 2025 20:27:00 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 20:27:00 +0000
Message-ID: <be4a252a-f39c-4f9d-8a76-5fc09a158f23@nvidia.com>
Date: Fri, 18 Apr 2025 16:26:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] rcutorture: Check for ->up_read() without matching
 ->down_read()
To: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
 <20250418161005.2425391-10-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250418161005.2425391-10-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0731.namprd03.prod.outlook.com
 (2603:10b6:408:110::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: b93983f2-ae73-458f-8c1c-08dd7eb75f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXE0amlsa1loR0ZCNkdKV0dBbHEzZVlETVg4RmJpTVpaT2pwakduclZUWFJV?=
 =?utf-8?B?OW8yMUlEVW52Z3RQT3RGVUtiTW1PRTczd21sWlRBak5ydklNZjUwWE5KNkp4?=
 =?utf-8?B?Y0lwdHVTU0xybnVNclZsNUFNMHprQVJuMUhuWDY2aDZtZTk0eC9CcjVmYXFv?=
 =?utf-8?B?QjJDWVhqUWFrUFk1OVBDRTh4M3VEUXBJSTA5c0NOMEZTQlVYSTR3bTFUY1kz?=
 =?utf-8?B?L3NtejBYcW12MFpkbWxGRHFxMkJoMnhDSVB6ZW5tUUpOS29IY2YxUjgxRzBG?=
 =?utf-8?B?QWltMmZSTU1EaFFFT0dob3RWRFZSaXA4Y29mb1orcTkvN2g5cFRaUnE0Y2tt?=
 =?utf-8?B?Z0IwaDZaUEpVWU0yV05rUERaQUdteW1WU3BrbmJDVmxMelc2djgxZlYwNGIy?=
 =?utf-8?B?bU1jMkZJcTFLWlB3bmh0Z2JsSWhMZUFZcVVhWG9RU0lOL3lYOUo1WkFqd0RC?=
 =?utf-8?B?YnBnSjJCV0ovSVUza3dJVU4wL2xKOFBDZis3OFNUdDJxTjdPTnI3bEkzeU01?=
 =?utf-8?B?VG1RYUNic1FPK1NPSXh0NEh3RjRaTGlCYXZmemJRYVdycmE2VzZJVkNTVjhN?=
 =?utf-8?B?WlFvdllRWXQxcy84VWRYZktKUEF1U0ZwRVBmNUozY1dMaGFaODBPeEdFRGY4?=
 =?utf-8?B?VkJuOEhuTlZheGltcEVCdUxWaU5XUWtVeFVyU1dHRVRDZ0RiaXB2TTU1NHFz?=
 =?utf-8?B?V25NWUdRMWowMGtBK0ozQkpkVktkSlRTZ2FpaFo5dDdFSGo4N1poU2VBQ3ph?=
 =?utf-8?B?RUxuN25ObGgyclAvUTRwVVU3QnRKUVRBMUR2SG1pcDZoQVRHU3lUblhWb1dK?=
 =?utf-8?B?MnVDZmVISjZ6YkNHUElaQ01NbkFvblA1ZUJwalhreU5kOVhZTWJxajdic2NT?=
 =?utf-8?B?cWsxM2xYOVNKSWZWbktSTjFrUGlYMlRGREl1Q2t4aU9PeVB6ZWRzRTNZQTN0?=
 =?utf-8?B?THdKUDFmaWtkNVBsSlZ4dkVibW95ODZYUTJxY1kwUUF0U2NJL0drblMxU2tF?=
 =?utf-8?B?YktBR1NUc3F6bEFibURGUVV6RVZ6cWxpN0t1NXVaNVdWRndxb3QwQmpiZG9E?=
 =?utf-8?B?RnNMMnVBMXV5Z3lFYm14RzhGNXRLNkNlMGtFMUowSjJuR0ZMSUpYQmd4bEVh?=
 =?utf-8?B?ZnR4NTRCTnQwcHFhSGZYdGlHdU5tR0thdS8wMTVsNTRYSGJnYnIvWkJBb05h?=
 =?utf-8?B?RDZ4YkN2Z29RVjFpZWhxakFhL1EwL0J2d3hIcXJ6SkI3M1kwRXkwZjZvRWtm?=
 =?utf-8?B?T3VKcm5jdWdkUkd5anBRRWVPcnpXN01OTjgzMFNwWU80WWNGWkc0OU10YzZE?=
 =?utf-8?B?blNvYnlSWGNqRWE3T1BEUm9hQzRxSDczUElXa0trai9jcFFDM0IxanVYODd1?=
 =?utf-8?B?b2RKV2dWYWtMZDVxQ2swNktWSTRySEsyU0w2Nm9EZzRXbVdxUXA4SXhWb0FO?=
 =?utf-8?B?UVdrZGhIZ2MyU3ZKY29rWEdCdFJGQmYyVFZ5ZFN6YzVscHRwb2JIWTdseUFX?=
 =?utf-8?B?NGlNelk2bEh2eE9GWHVCZjVJQmdJQVh1QkRKM2ZlQWJQNk4wV3J3S1JrdTNo?=
 =?utf-8?B?YXJYbzBNYS93UEJxdlJ5bHRGNDF0R1FlYVY4cDRFUXZSK0l0bDZ1VlFZTXFR?=
 =?utf-8?B?U3J6R0NLbW5CUXBra3NteXl3MERhd1BwUk9TdExxUmx0czQ3K0VmWTJpblRR?=
 =?utf-8?B?RUl3ZDc0SzQ0dng2bTlaMHJxR2UrWk0vOStVaEpGSVdmYXBnc1JGUkZrWmlv?=
 =?utf-8?B?OWNwMFVaZEpvR2pMN1ptdnZncnZITGVpeFVFZTNlakx0VnhYTWpsTlZ0TVBM?=
 =?utf-8?B?ZXRGN1dpdFNmb2g2UEZPdDAzcHRQcUI5Q0Z3UU84ZW8yK0FvTDY2emFldEZK?=
 =?utf-8?B?SmZyYXFyaHZTMkNCc2xqYmd3ZGkwN1pXUHM2dGMwWHdKWS8vRE0xbFlPWGRq?=
 =?utf-8?B?Qmo1U0UvUXNZTnhIWlFRYTJPYS82cWl2N256dmY2dXBtZTBVbDVjTmpQbUNl?=
 =?utf-8?B?UnlESWZCZll3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnNSS1U2cmkvaXBXdlFOSG1kRU9xbUtadTJkeXBRc0JjZmZKcklKaTRYL1gy?=
 =?utf-8?B?RVVJT0grdDlFaSt1ZG90WTk0bzduTnZPVlFXZ0RUUDFFdk9uTFpBeEg0WjVl?=
 =?utf-8?B?MXNBa2sxaXhDRGpGK3hXdm9pR2lrbFBYTjFEdWJPTWx1TThWUFVON2l6K1BC?=
 =?utf-8?B?WUpuZFh0dDJlV1dsVWJrVHE5Vng1WCthS0xDQXY4QnNBdkFiVVVtVnFCRW1w?=
 =?utf-8?B?L21Ic2VmNy80LzJ2ZUZXRjJkRitHNklHeHRwRUt2RGtTUmNHQ3dneGRGNTRM?=
 =?utf-8?B?bFhKQjUzb1RkcjY3VGlNalJPMW1HbXZaSDc4UUV3dWIvNVluSFJEMFFEK090?=
 =?utf-8?B?eDZMeGo5OWRnRmdaZTEzT2JuZUNHWXFmRzI2R1duaC8raVBpZ3kzMERETDlZ?=
 =?utf-8?B?dG1sR3BUdmxickdiTWYvenFrNE5ISFIza2VJQnFLRlZZMTFKaEV6bmx5WTBs?=
 =?utf-8?B?LzZNeFlaVlg1QUhsa3FPblo0OEsrUThnZjFIbGNYUjlUbnI2Zkw2VGtLVlls?=
 =?utf-8?B?MmdWZjNYbjg2VFNRcTlhMUdQTXB6VGJxSjVTSm8xQWNWc29sTmNzZlZvdGZJ?=
 =?utf-8?B?Q0NNakNUMUozOCtPWDE5eG5BREhCdXRQd3A4aE5wTU5yVVE2dmRVTnlTdCtZ?=
 =?utf-8?B?MElZNURSUGsrR1Flc2g5WXN4aVZFSWlPSGJKR1NhYVgwcnRBSGhITndUTWow?=
 =?utf-8?B?NmZ2S0hxVENqSERNZkVpVDhyMHJkUFhPdkhZMGlPNElNa0hYd2xaVzB5eVpl?=
 =?utf-8?B?VjFKSDFubWUvVWdwb3pPNkF6alNYNmVqYURpenBJMVBpSWhDREVnSEVuTFBm?=
 =?utf-8?B?QWVmOUFpUmNRRExoTmdYZjgrWVF2ZUh6RkxpL2t3VTdtVEtaVmY5N1hVMHNr?=
 =?utf-8?B?ZzFQZWFLdWJNejF6T05qUUdOWkFESzZmKzF3S2pjL2tncnYwNVhrM01kaWhQ?=
 =?utf-8?B?VnJEUUlhbm51Mk4yYzBDVmNvWGM1ODVaSXMyNkc2VzVFOHZ0MCtnaU5oVWpx?=
 =?utf-8?B?d2NXdk1MYUVldGZWOFBLRTNFNlNQanhiRnQvRUhWTUdIUWdYMloxeCsvNitD?=
 =?utf-8?B?SWpzTzY1MHRrZjhyMjZkWTB3Vjhid3A4R282RDdUbTM3ZWZ3RzBjRjlqWUk0?=
 =?utf-8?B?SUFuVC9KbXZBZjlTQkhZeDJPeWdnQWRueWlQb3pLMzZhdXVabzZ6eVBBVGM0?=
 =?utf-8?B?TkQ2UnRoRWRlQ2VCKzZ3V1lQcHUvQzVOWmhhYldjTnVuMTFEZFZjeDh1cUVq?=
 =?utf-8?B?SEN1TTZOWHh4TXkzMnRZSXA5U0lMNXp0M3BaQ3BNcnVHVEpESkJFbE9hWmxj?=
 =?utf-8?B?cjFkWGcyRTJBNDdINjFVTkV3Zm44eTFIbXFtV3dWMVpCWHFOaXFwenFlNnhi?=
 =?utf-8?B?UmRvVXVIdExXZDRnR3dnSmdQQ2NldWwxbkZWZEk4U1hSdzN0bkVEVmpKNGRC?=
 =?utf-8?B?OSsxMUlMVi8rRGVoL2hPTTZ5c2MzcVFUZTZML3h6aVBoelYxVXExZm0wdmVa?=
 =?utf-8?B?U2JBNEhhY3AzM1UrNlVTZ3dRT0dGVFZXV0M1MkhPL09RcnFYdVIvZXBJSkxj?=
 =?utf-8?B?VVVrMVNiNEV4bnJMY0RiVHFPOXN5QlA4c2JoaWhyODhGRUFFSVdyenl5VXgy?=
 =?utf-8?B?Y3hKRjBvbEdxcEVuVStqaUwrSVl2MHBkQnpHNWhtS3RxampCZVFzOG42NnFU?=
 =?utf-8?B?OExLcHE2L0lOYUNweVI0U2lDMHQvVFBQaWhQd0wzNklYbUlYRzQ0TkV1WXZZ?=
 =?utf-8?B?QkdtMllIK0o1bmNWYWRvbTBLWHp2eE8yUUZqdFRtNUEwbnlUeVVmUWFmU1FE?=
 =?utf-8?B?MnpwdFhrTXBqcW1qSDdtR2lLUlIxWjA5b0lCUFQ4VWxoU1E2R2NBSUdQNXdm?=
 =?utf-8?B?cjJiZU9GZ3dLNHRqempBYzRJV2ZOUXhWUXdIVVQyZ25tWnkvUTVEZ2d1d1BI?=
 =?utf-8?B?U2pLSmdwYVJQYTh6OVZKaDMxRVBaaWxNaXNMdExBWStBeVM0cnV3T093eE9C?=
 =?utf-8?B?ZFEvN3o0ZEhjNW5VQzN5TTcvWEkwUG1RWkUvWUlidFY4ZnNuZW1SMGF4V0g5?=
 =?utf-8?B?Y3BzTlF6d3c5RVE4dTdYUTQxSk0ybzRXOE9RSEpycmRGOUVPdlRUYVpuMHpo?=
 =?utf-8?Q?B+1naiXmX3dGkcY4V4Y1E2lsJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93983f2-ae73-458f-8c1c-08dd7eb75f38
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 20:27:00.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2gnd/phibwYY+dRNCU9HnCxE8qYMBDMP4pVXqZPQbdqQZJDyzAptylg18MfcEIalOwEK4a2MV+Y6ZLpI5o+2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202



On 4/18/2025 12:09 PM, Joel Fernandes wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit creates counters in the rcu_torture_one_read_state_updown
> structure that check for a call to ->up_read() that lacks a matching
> call to ->down_read().
> 
> While in the area, add end-of-run cleanup code that prevents calls to
> rcu_torture_updown_hrt() from happening after the test has moved on.  Yes,
> the srcu_barrier() at the end of the test will wait for them, but this
> could result in confusing states, statistics, and diagnostic information.
> So explicitly wait for them before we get to the end-of-test output.
> 
> [ paulmck: Apply kernel test robot feedback. ]
Fyi, I just updated this commit message:

[ joel: Apply Boqun's fix for counter increment ordering. ]

Hope it looks good now [1], thank you Boqun for the fix!

 - Joel

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/for-next&id=fc9e01b94032d2b017925a5f1437532e021bba5d

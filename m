Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A7189BB6;
	Fri, 16 Jan 2026 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580613; cv=fail; b=C2Z09vOSSWdRvgKs7tk+domZyiNxk0Ntu/6bhhTlPopxtbqN1hXvZC60Ny/VZLvYjjLcPvXsRk9gSAjKH1I1pxk10XSIJ/MYqvAn49CP3SdihYAdCV7eqH7MxKp+qNUbzqFKL5w8CaI0/YuUt6mdRw21S8A9qkyDS8vZrX5Pm0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580613; c=relaxed/simple;
	bh=hrO8D5/epTBxTZO6DZ/mOkz2MHiwbypn25/l3rdGhZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MqX1tzNibcSTI1TVgmwtHSrI6bgoZJKtpGbV0JjCi0SpNl9NHx715tMN4CFKFZ7AguJ0n+M06BZN842+yaAPWrnqeaHUFXs76Zima5BgvmdHRnuOL5dYryvU65KzsesUh6GXL8oB4afOdEZTn8qC3UagrA5HVCBoVk+Re/0F4mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qcEQqT/M; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qcEQqT/M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZ422sjCeNpaRSAEeLOU3/hY4Ygwxwu3jP3QtTUt8DexUU7M0NjLXnRr+DPfP8Red7ZvmAwRyTqWp/x+4/2UN7/pyYnyNC1aBptNRXv3Luv9AO6dysZXhnaHllGfVpzL61u634Sq57zF17JhepfydsFhqgzodZ/MTahZ36aXgblkQZHRifbOSfnGkHQgWt1kMWDq+gqc1xHEHqq33FllDOIvEqvMqdStG8Sla7OHem0o8aEuihUUwZ94Or11B+dg3G2GXoMsdfxkrHqzjSppoPR+XiHEQi0b1h19JMbhHEE8iMF/Uy2ruSo4j93eSHy5GiisBRIkRhxgl1zT6R/kxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRmbW0dLBnsfSJIiK1b2rPPufs5wHHzP/2/SdWkT8/A=;
 b=u0bESUEINMi1ewVa6L46SZW01wx7DHvQvd7GbdoCS/woY4NQLlXxRTSg1JrdAdiYp/1VlwkqZClszySvJrS/GlRDrUNSGoe+dk3/ec6lv5OY1qCtLvCyUmBt7aWivDtPe7E7Uh8zg92ZuGn1ZoALxfph66Axb0LabHUQsjpCVaP++BBzyk49m0P6biNOkg+oCYReVPUmv2hVfg7iUUu33w2xwOZfw+37b8aVj3dO7YGtsvrr3GRQJe+HFHV4f7xwdCS5A2NVFj/4y8Dqkc5W1jFvIHD+uh+XlIXl57v6jvvfdbaCkT0H9pj+qGLh6c96ieR1diAPBl/En79ag2qzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRmbW0dLBnsfSJIiK1b2rPPufs5wHHzP/2/SdWkT8/A=;
 b=qcEQqT/MJWu1Xluzbgu76PIkJFb8bO+Q9XCMM72XXDXMuXBFUwvStpzdkpdauar4o4Q0lvWr6ZDd5whFS8Vl4z5lLfSBOWeX/VIT4jnxIFNHBXRRq+MR40Vrf+8s/U/c/1+G47bBh5Jyav4qg+A9YGKqxzmK2Dxycbnehwm9ygnejB6+MKid58QepVlwfnvodIO2oNQt68VkIFnDER71bwY/Kt85qMs0tGzIxHxTOzXjunt7nw0mVn27ycuZ4Oyw0YrArutEMXc/WK9L5hGqnlyS6YWpQ9nC6tXjDwlbWJJkXaorUV613m+japGoh4p2UidcwcsIribPKIhDYKIe0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 16:23:28 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 16:23:28 +0000
Message-ID: <ef39d1a7-7f13-436d-adcf-cefd7cd854b4@nvidia.com>
Date: Fri, 16 Jan 2026 11:23:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] rust: rcu: add RcuBox type
To: Alice Ryhl <aliceryhl@google.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Andrew Ballance <andrewjballance@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
 <20260116-rcu-box-v1-1-38ebfbcd53f0@google.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260116-rcu-box-v1-1-38ebfbcd53f0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::22) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 4394ae40-d50e-4327-6100-08de551b94ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2N0WVFrUzZISUNpcjRDeHNCNFVZaHUxT0RLVGxjc1BBc2w3YUgrQ1JLMm44?=
 =?utf-8?B?VEpvTS9PTEpZc3FxaWQ3TjFYbHV0R3h2WjJUUklaeUh3SjBYbTRUZG4zK2hB?=
 =?utf-8?B?SzlIeDBleUdxYVZSNnMwWmdxUnorNUEvVmRCNGZqTG1DaVkyam5hZTFiZVpR?=
 =?utf-8?B?T3gzVW5BN3lLYXV5Q2lFZWRUZXVRbjR2eG1RSG9LRGxmL2t2dWl3cW1GenY3?=
 =?utf-8?B?dkRLNUFQVUk0SnlpdHdNdmJra2RMRXI1RFlIS1U1QTQrUldZSkFkOEIzSlZ4?=
 =?utf-8?B?UlZlbUUwRDlOZnE1WWNBN25YTFpsVGhKQW1ZZGl1S25vSWFYZktkeXdaLzJk?=
 =?utf-8?B?dnZlZ05JVUZxWm1SQ3NyeW5zelVNM05BL1R4dFJTY0tIZUUzUjZYRUdqUFJl?=
 =?utf-8?B?NzNpWVRFRnI5cER5ejRlczVHSUI4Z09qY3kxc1V6UUdHbEdteVdGQnBIa2N2?=
 =?utf-8?B?VERHSThBLzhQZmNMZEpzTGt2bC9TNWFTU2FmRTBjVkE3V3ZWNUpYQlBBb3A1?=
 =?utf-8?B?NnlvVnBMUnp3eWtydzE0UytZYllaeC95cmVrNmFKMmduc0ZBS0VzbWpNd3RL?=
 =?utf-8?B?bklGRW9jakVVY0NjN3p3N1BNd1BGSnpnczR2YXlDR1VFU01YTjI5VmZEVXZz?=
 =?utf-8?B?cFcyc2NHRHByNnk2OXcrd2dMOUZZcGhScE5SVVdMaDNhcWpIZnRzZjhNaGJB?=
 =?utf-8?B?bjY3QUxvWVYwQ1pGNzR4QVg5Y0U4OWowSmFFTlJwVkhGcSttNERsTU9TWkhZ?=
 =?utf-8?B?a0o3ZXM5aEhLeTMxZXNHeklndlhIMjlVdmFiVHNMSFFmQmovYmg0M2J3Y09m?=
 =?utf-8?B?NTB5djkvZDNRVWtsWjAwVWpJM3Y2SiswUDd2VkpSaUhBUWk4MWpCMkl2K1Fs?=
 =?utf-8?B?T0dsL2ZHamxMeTNuc2Zpem5sL1NGK2x5T1AyTGN2dUpSYkhrOXBwTStwOC82?=
 =?utf-8?B?ME9iekp6Q1ZsTjN0eW43akZBRXdia1NTYXB6a21USUVKWVh3TUJSME9zelkw?=
 =?utf-8?B?dXJBOEppRVR0NU1DUWFaQWVZU21adW5rZy9FYkdJOFBKbDMyelJUWjI4Mm04?=
 =?utf-8?B?V3ZWUkdlRTJwVVRvRjdjMjFNSTc0NXFpaVY4cGJPbS95ZnduVEVNV1hCS0M4?=
 =?utf-8?B?NHlJaC9pNnNLK1NtMThicVhUOXNvNDdPWEZIMWxxLzFmNW1xcXE2d0htZk1L?=
 =?utf-8?B?UGIwZE9zTzVUbEMyRE10TjhtTXdRbzRRc0RHUkZtaHNqdjFpL0Rid0taeS9M?=
 =?utf-8?B?dEV1c0ROMERSb0lmTFh6L05ZcE05bDd3YWNpdlZjb0dQdTVTeHkxNzdENi9i?=
 =?utf-8?B?c0tReVVGSnlhWkxnRFRGYkx1RExNSC9ONEZ5Mmp5eUVCUy85d0pOU1QxKzRO?=
 =?utf-8?B?ZCtTMEdZUmM1ZzRnckZXRkUreXllVTZpbEdTM0ljN3VNRy9WQTFSK3pXOEFu?=
 =?utf-8?B?RHFHeHpUUzAwYno1aldmdi81MzQ3OGx4OG54S3g1dXBScHI2T2s3WVVTb3Rj?=
 =?utf-8?B?MGVhSTRoYnFPbHBCMEw4a0xMS1J2c3VXT2xXT25LMVM3WjlpQmJjS1N5SjM3?=
 =?utf-8?B?bjFVUXM3MzErRlVwa1R6OXRRdm41V0c4S292SjV3MTd5QkJudERMTmI2VXBK?=
 =?utf-8?B?NmJIOE1hcExTS3N3d0tyUm5qcHJtaVlETG5kZWFyaGdidU9FV2hpSS9KKzBJ?=
 =?utf-8?B?SGtzTk5sL0pmL3dZL2cxM0pMSVQ4SmxnZjdRcnc3UWs4YlRDamZwRGxyMzBF?=
 =?utf-8?B?enViM3hXcXhvN3JrVGJ5U2dDNC8veFljWXdoK0RMT0NiTlBDd1BPNnljcmZ4?=
 =?utf-8?B?b3JPR3RTSk5mS1o4QmNVMWI2QTZQVzVzS3ZxdGZ2WGViQ2JyMEZxaGRoMHhC?=
 =?utf-8?B?YVB3L1RyTCs0SWdjelY4YVZGQnJaa0JqQkQwMTRjU2kvNlBDbE1XWXVsZE5L?=
 =?utf-8?B?Uy9wbitRMjBRYTJ5WVY4SUd3QlI5b1ZaM2NYN3Zxc3A3dkxKNU1VYVpORzRa?=
 =?utf-8?B?UW1CRXg3czAyb01ocnk1TitqNFlCcWhZU2tjYmEwTHh5QXNRaGcrSXl0bWdB?=
 =?utf-8?B?MTE4TlRyQ0ZhdzJvNlJ1K0EwRGQ0ZDBPK29kZVZTSnpnUnhJbmYxMmFGb0tL?=
 =?utf-8?Q?9f04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkVmRFVnRFJxd1JzVkx3OWJMNlpLVERVdnYybXI1Sldoejlya2UwM1pSNGxR?=
 =?utf-8?B?Y2tNMzAzL2d5ZDlnYXpUQzhJOW1DTUVLTWpucUtQUnpFQjlmQXBVWVVhQ0VW?=
 =?utf-8?B?OUlTd2UwRFR1NFVxcVk0dC9sT3kxVG1HWkc3UHJDTkNjUGtibm1NN0VDQ0Fy?=
 =?utf-8?B?bmdJdUxHMFFHK0hwOGdMRW1OK3AxdTJUeEE2SFVmaHRUTFVuWTJ1YTlPOE5v?=
 =?utf-8?B?WFQzNkpVbHN0YVdoNURoSHFtVXJjSGF2dWE3NlA3RlREL0h4M3lJczBNYStE?=
 =?utf-8?B?MU9nWTBPOFFSQUl1NysreEdLTWg2QVAxSk9hMFFiVEZNMXZxbkpiaGJaTmxG?=
 =?utf-8?B?c2tWN3lmTDJjWCszSmhaZkRlZUpxMnlLb0JvNm05dWZhSmgxRzd5MkYwNlhB?=
 =?utf-8?B?Uk1nUzdvQnFSVW5jRmVpQndOZEVoVjlvWERUUTVTd2YxaDdBQ1lsbXdUSTds?=
 =?utf-8?B?SVowbGltR0FIMjA2S1NGdFdWd0hMckMrbjE1U3NCOGRtMXhCc0RFbmM2WW9Y?=
 =?utf-8?B?WUxlczNHV3lXbnVoa0tKY09FSlhKZjlGVFd3aGVhYW10NTJucUZwVVpCY2Mz?=
 =?utf-8?B?dEh1V3M2RE9NazBMbGk3cmp2cy9FdktyYjU3UWVMSmJHc2QwQ3ZQek54Z29Q?=
 =?utf-8?B?aVlER1FRSTRpdjJOK3lGb0JzcDRnTlVvTFZHOFBBdDBUQlVJZHJFK2ZSaCtT?=
 =?utf-8?B?SUp0NDRtMEIrLzIxRnRQVFNDNEJYV0NPRkVUb0xQdkUwREF5UnQ5OWRSWG1h?=
 =?utf-8?B?TWIxUjhLb0hGdlNRcmNFS1dOdGJtTVgwUEk4ZnpoWGQ2cTVnMmRObTd2cW9h?=
 =?utf-8?B?QTVJRjZSclM3QlkzQnVBQlE1U0t6MkxqRldQMXdKblRwM1dvcWJjeEdraGYr?=
 =?utf-8?B?eHArWWRrMyszMVZ3LzlVM3JCaE9GQlptYWtkSURHM2JZWXo3TE0waTU5RlJO?=
 =?utf-8?B?b0Q3RU0rM0F4cG1KZzZMN1ZxbE5DeVZ1bWhMOEhqRmpHT2xMU0lzUk8raHFM?=
 =?utf-8?B?SnY1a2pJZU9FcGZJTGpOc1YwYWpsWFpBOXlyU083clhyb0xHVDdabkRycW1D?=
 =?utf-8?B?M3V0dldXWjhJcWFZYWtOaXkzWW15U0N2VTM4NHZSUHJoOVlxQng5MVpIRU1v?=
 =?utf-8?B?SGoydkx1OHVzNGF6OE1qVWZzQ2FRbjRPdWp0QlJJM0piNEYwUGl2VHBIa284?=
 =?utf-8?B?ejYzWGhGdTJWWkJpWitlK2ZrMXdCTEpPL2JpVXdNSmFyOG92UlpydUZDWnQ5?=
 =?utf-8?B?TmxyeXZ0ZGt1eWxFRm1zaVMvYUVndkcvejVyVzkzMjh4aEFnYzZsdGJQNlZm?=
 =?utf-8?B?UnpmcFdLeWFlQlRaZklqYUdhSDN5MTlkLzRicEUyQ2ZNSmJGc3JhLzNqSlZT?=
 =?utf-8?B?c3BXRFZldy94YnJLVEdJc3V5UFZrTDJzbkxzVjBTaXpiZ3hUNk9YK2JwMkhh?=
 =?utf-8?B?QkpqNUs5MXpINXR4SW5mc2tOUzRHS202ZTROWVNkYTRWRU5XU1VobExFN1Bq?=
 =?utf-8?B?MlpybDJxa0hwMm94aCt5dXYwNUh5aXRoRmlmYkt1RzBHVDJuSWNBcGNZcUNl?=
 =?utf-8?B?N3ZrSTFSRFBlWVovTHpWWDRFbzZBMEJJNGxZQXNuY0tZbTlYUy9rMFIvN0M1?=
 =?utf-8?B?RnJ0cmZTeEdpeUlmQzdXOGYwb2tsTEpPWk1FVlVRUmd6K3RjTTBMWmpsdTZi?=
 =?utf-8?B?SG1UQzRiSG9QK1pYOEtHR0RMcmVYRExneVNJTG1Wek9XT0JNb0dIbEJjNWxY?=
 =?utf-8?B?Q3U2U1JjZUUzbFJOaDQxc0N6L0Ixb0Z1Ri9Kd3B2RGxlM2dvZVdhc2dRRmFl?=
 =?utf-8?B?WUxJaUNoT3B1Z1hQVXRZOHk5cEROSVJocHBIM0pPbEJsWm9uWlFHZ28xRGUy?=
 =?utf-8?B?ZEJNSVBXc2hDUkpZMXJnNU1UMVNPSkpFU2pDZ1hHeXpPRkJjbU1FMFVkdmZB?=
 =?utf-8?B?eSt0MzZJWkJwYzJaanhZeHJuWVF6OXhwcVN5K084ZU01TTJ2N1RmV2FQdnZP?=
 =?utf-8?B?T2pkLzRRRzZ1SFcvYm1jWGFnTHk0L29hS1hJbVZKQmZQK3BqN3Vnbnk5OGRP?=
 =?utf-8?B?bE9EcGdzbnRCRkxwWnlDeDMrSk8ycjY2eVJnVVM1WU92SndGdm8wUHZJYWNl?=
 =?utf-8?B?T25UdDZmYlJqbEkyMTBNbmoxdC9uTkd6RDZOWlJHeFpLSWVaMEhGRHBTVkRZ?=
 =?utf-8?B?a0MwM2RiVG1IVnVrSXRjRmVNNm5wRGlYMkZ4emF5SWsvOXNFdGQvcEppMnF0?=
 =?utf-8?B?SE1WU2VaR1hiK1VVejAzWDBBNVJ2OVZGajBiSnZQdWg0UiswT3VaNjdqQlFq?=
 =?utf-8?B?RTV5RlRhbnp2allsVS9rdENNbkRBSHZNRWdQN3BJYlJxRTNySm1qUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4394ae40-d50e-4327-6100-08de551b94ab
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:23:28.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuA18tTVXfkMLHKqRl6H0XaN4sqZM5JdrR7hw/bnmWtdhgOMFff/uSXP9fvkkRgrZKQPyUPNuJqVjwSwYux4Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262



On 1/16/2026 10:46 AM, Alice Ryhl wrote:
> +impl<T: Send> Drop for RcuBox<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The `rcu_head` field is in-bounds of a valid allocation.
> +        let rcu_head = unsafe { &raw mut (*self.0.as_ptr()).rcu_head };
> +        if core::mem::needs_drop::<T>() {
> +            // SAFETY: `rcu_head` is the `rcu_head` field of `RcuBoxInner<T>`. All users will be
> +            // gone in an rcu grace period. This is the destructor, so we may pass ownership of the
> +            // allocation.
> +            unsafe { bindings::call_rcu(rcu_head, Some(drop_rcu_box::<T>)) };
> +        } else {
> +            // SAFETY: All users will be gone in an rcu grace period.
> +            unsafe { bindings::kvfree_call_rcu(rcu_head, self.0.as_ptr().cast()) };
> +        }
> +    }

We should probably add support for asynchronous callbacks for Rust instead of
directly calling the bindings in Rcubox. I know Boqun and me talked about that a
while back, and there was a usecase missing. Perhaps, RcuBox is a good use case
for the same?

 - Joel


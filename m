Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E02FD69E;
	Tue,  6 Jan 2026 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734654; cv=fail; b=ioXXDrQpBO7AvfR3zryr4mo4QvCaxXuSTpap7cNjPVGxp/+xRV6OMX4RAfF72jctEJTpr8eFU2MLY7icGQjptCFAnyYv+r0b/uGnkAga1gLXr4lb9QVcnkClNHsa1bd3ow0UtPWoS85lZV+PJq3BhhPnORgTpnmFZOAMgTNAyEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734654; c=relaxed/simple;
	bh=OQFjYWWNUePRTplRCfmEzn1SveeAlYfJBOei+RpvI7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hZrPqexN1/cQul/M3pegXeQrPzFwb415GtS1kZyuiDUkM4n29MaLqAYGluggGi4aytAcWTblZiu+7drwZvp5cBU37g+Z4IM+2qLPKUVTkK5GUX3Fv5BEQX/HXXmIIhqxaGQrzgtkoLZnV6pColVXY5ZxKqifWwMOim2z+idRI8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jhjA8Dsx; arc=fail smtp.client-ip=52.101.53.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jhjA8Dsx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZ0uJCYV5QIxP/1gigoFKxiru4P8C5MrMsjMTOWWaFinOWVLvX0MLcgswjMYslGzI+qqlHCNb22O/MQLLDwZgBmlHC8z+lMKQgRpTp/aBcAcbLHtdn7lPlXmZ5IamVM1PMu5L44ouxOuHYXCOjQ8cu4iHKWCRd66Hr6UT5Rex6Kuf0hSiU38Ro8GFEtKSArPHQrGab725xeXTI7SARg69PDrisqntT5ykgDVaVLsBBWp1YuWNclwHqIfdXY98S5i+QSn2Uk/DR8Wt8uoyuTtnwlswbXc5AG/TFslc57kXHdDz5gc7GJ51n0krbLNcXhjNoNKhAwKy31bo3wSEnstRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDw7NTIftDpEO08hydlj5QPhyN/CKi8yJwYmE1QaJmQ=;
 b=qn3109E4/2/svYxpWoOx3qw0n8Ae4MJtUk8heXYDsSJKhMsf8+s6L1CQ+dQiLfzdxAzjZqE/rV390+Pm4CPiln5kTrFeiBc7f3QsFBKqZr446ANUnLCMxswRynzU+jJLhwcU3d0UpXgvcTPp0wr6kuDYk7KJvvw5u5GiF2koDq1zMDD6VvATvVC14NK8Y/DHzQ7GcNkV0VMlI5FJPJl/rRGgDMJcLSuoH5EpKUVe+b6+6OJPDNG4xBxpOCali76M1yB39B33uhmkpA85J5eT7O0SlSxH87/lRKOsd3xIJPmvvIyW8r0T43hjKJNsd31WVrawAgy0ODpy82NDAkEWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDw7NTIftDpEO08hydlj5QPhyN/CKi8yJwYmE1QaJmQ=;
 b=jhjA8DsxWEEdAi5bjsxuj1L/eYb0jkdTlI6s2U44W3vfQDmb1905gZ/9gFlPap9sa7q3/kdb/Uj/uxO9SiospXKZkO8w3OALBmNYzkNoa63GFLLVTCFxOarFU2XFwCVuhhjaPaxG5Q8ljUqHGEg6CipkauumsHnjcmbZ85aEr1+6t6rxyS/0N16EDUiusH3VGkp5mAnGgZO1FrjP6aL4McGUcbwhQhGTowy/U312gVYtVE5mAF0AJph5eFuTzFc98OGTm2d7ZAZABb0dqM/T0n5a5rIf5iADhwLi8iznew1/7B20t6u/nFzm4KsUxzRoMqvJfENYfRd69sAybA4lFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 21:24:10 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 21:24:10 +0000
Message-ID: <fa4d2f13-2fc1-4f2a-983d-66414b8ebb2d@nvidia.com>
Date: Tue, 6 Jan 2026 16:24:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
To: paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
 <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
 <936afbad-226f-4209-b347-c87b30b4a7f3@joelfernandes.org>
 <a40f5831-ae62-4d16-8a7b-b6adb2a59aa8@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <a40f5831-ae62-4d16-8a7b-b6adb2a59aa8@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:208:238::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cefc19-e9fb-47c8-7fa1-08de4d69ee70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXdmMXp0ajQxejMvdkJHR2o3d1FYQlNZOVhnQTVuTmtTcWhWMlBIQTd5SGdk?=
 =?utf-8?B?V3NtbElKU2RKSjZRR0Z0bzAzaUFHelJReENmMmNreUFSeU5lYU40WjN2REs5?=
 =?utf-8?B?b3dzMlFKK251c21WRkVvK1JtNk1Vd2xKNEQ2ZWZPWUVlenlSWHh0RUsyUk9q?=
 =?utf-8?B?TGFzK1RlVFBxcDR0NTJVUHByVUdQYXlhZklwVlJBUWNKcHBvLzdLc3AwUDFD?=
 =?utf-8?B?cEhsMEIwK0hCekV1aEUrcmQ5UGd5VDRETTg0ODErT1UrRis0YTUreFhRaUdQ?=
 =?utf-8?B?ZVc1RWd4cG5seXVQcUtNRzdpbGJJY3hRV2RGZW4yTTVZN3lEUjh4QXp1NHhr?=
 =?utf-8?B?N3NnU0RicWl2TDVUSEhodCthTG1TTkRoMmRSTks2ZGE5dFhHNGtyK1dNajJk?=
 =?utf-8?B?THBnZVhGMHowQTNZWjRPdzRJWXcrR1M5MlRnZWlYMlIveGJpUUJJVlVTa2RE?=
 =?utf-8?B?WjBieTZmNEJaYWJteGpGbEI4SVg4ajl3ZS90TEpBSFVoODY5SkhVckp0aTNU?=
 =?utf-8?B?Y2lxRWk5TjRRcDRtV25ZODcrSkYvMWdoYXlBb0N6R3htRHJlb1NoUVVQN1g5?=
 =?utf-8?B?VWVvUnJ1M1NnUjh5ZHd6MWVqY01kNUowRUNsRDJ3NU1JOWZONTBlRWZ3QTd1?=
 =?utf-8?B?V1VqS3dqZHhHRzV3YjBRemVoSVFhcm94OEJVbkdqRXlpT0FlRkp2ZTdlQmd1?=
 =?utf-8?B?NGhYazNUSHJBUlNZS1ZiSEJGYnJvNjBoR3VMeFVQV1VnTDlwdERYRWl2UWlm?=
 =?utf-8?B?RHAydmxwUFA0ZUJWYU5tQ2kxWXo5Y1FqQ04ySGozOTNqRGpGYzdMYmRmWS9W?=
 =?utf-8?B?M0wzS2o4ZWNNTnBVb1NuZ2hSWnE3TWwyNmFSeGl3ZTM1TzVVSE9SUlhFdjFU?=
 =?utf-8?B?cUlxZVBDUitTSWFuVW1xV3o5YnY1N1lHcStxbFNlbkM4dkpNY0pFSk1QZmtx?=
 =?utf-8?B?RVR1RjUzMHNuemRIcE1xbTJUbzMvWmMrV1pSbHhRZ2NPRTdyUDJHemhiQlN6?=
 =?utf-8?B?WHZyVGlhdGo1U2dRaFdTK3JWdFljZmxQNDF6MEllcTJpRWJSajNMUUFtbVRy?=
 =?utf-8?B?M3NTamZ1UzdJdlBacHVtaXhMU2I2eEUzOU5LVlRsY0tzcGF1ZzJnV3ZWWTE5?=
 =?utf-8?B?cEFTM2IwZCtkRFlqMlVBaFVFdW84TzR5VTQwK2MwTmlHS0J3RHYxd2ZHRzlH?=
 =?utf-8?B?YzVlUzBwWDJoRDhyWUx0aGFqQjQ3V1hvMTVBTmFYWmNoQldWTXNiM1A5bUhi?=
 =?utf-8?B?YWEwYlgyQVFJWGJTZDBUTGRqYjBUNDVrc1Z2MjVvZjNaQjhLR2RERzZaOW9B?=
 =?utf-8?B?SWxSWUR6ekQ2d0lJQWx2UitjWnE1cTh3c0xqZHRBUU9Ga3lnZEIvb3JxZThx?=
 =?utf-8?B?Y0h5VTB2b3BqVjB3R3lzZDFjMUV0bUFpSXhyR3EyZEZ1WWtOQSt1NXF2aFIv?=
 =?utf-8?B?aWxqdEVaOHdmcmJOMFJwQVRoUWxhZ0hqcHF4cEVMVnhBcGJ6bzVKMGxIb25X?=
 =?utf-8?B?VzNqdHlkTUpEbjgzZ0NYUHNPQ1B3RGlCeTk0TXh5RHR3QU9odWJSY1VZdmk0?=
 =?utf-8?B?eWlTN2JBUkFQSU12cktQV2RUcXcwZzRpKzYzRnorcU5xTHlaQmRTVnp6bkxQ?=
 =?utf-8?B?SktqS2xiYjJXbjZRdStzNTJkL0NlYkdGUkVJbFRkc3o3WkhyVGRadlh1Q3dk?=
 =?utf-8?B?cHlpaHBHVVE0SEtDV0gzY3REUElvTGszNHM2SWlOTHhNcENlY3E3bjRqV0F1?=
 =?utf-8?B?Z0F2UEo1SjdvTG5UbXcwbmdtRFFVeGV1TzA3eFZxdCt5dlBROXFhY1k5Ynoz?=
 =?utf-8?B?SEpDRVNlTWFCSlZVOG96WEVXWTlsb2hBQk1zbHRHcUVpblVTV2tYUEdNcnFI?=
 =?utf-8?B?WGJ4RW91bzZOa0pSYlVTZm10ZGRmSXQzUENJTkRIcXcwR2tWaTY2UlQyb3do?=
 =?utf-8?Q?t1sqBHdhFQHmxz8RlwSjqYhbZeSiplMg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWVsRktUYmFpYTRZei9DUnk1Wmg0N1h0YWRiRll0S3hoS2JBSnFKNzhyUFFS?=
 =?utf-8?B?UjY3RzVYTDBRclQ3NmVIa1p2aFh4UG9tL1BYSWVka0xwMkpGUEhpSmd0OS9p?=
 =?utf-8?B?bEFqWnkvWFRKbzRESE9IRHkwR090OEgyeXZMb1g5YjBvTU5hOTRxK3A3Yk5P?=
 =?utf-8?B?eU1LbUZOQU9EbG9OajhsemtJYlRjQWR0VFpGdmFLYXF4UCtZYWp3OHZkYm9C?=
 =?utf-8?B?MUVpNUx6TFBzMVh0NEE2SDVRVXVwazYxSUdYQWwxdjRkVkRPamsxRVFuWVM4?=
 =?utf-8?B?KzF2ZDN3Wjgzek1kNkFwL0pGc0NwcTRNMnRTaWMxSW45T2UwaCszT1lYaXVs?=
 =?utf-8?B?S3lzMTN6WEdDMTltU1FiMU81S1JFVUx3YTI4aGRxU054SWZXeDIrWHFZYkN0?=
 =?utf-8?B?OVRKanhuMnZCS1lwVFpqOWNyTEhMdEMyNHJRdHhLZjhNVEI2TmhIb0xYbEdC?=
 =?utf-8?B?OTRWYTNYV3ZyN2V5Q1FYWnZoY2YvZzlLVDd5QU8wb2lSZ1dUU2ZuYjhKSWhk?=
 =?utf-8?B?UExRZ24vNzcvS1dvN3hkdmxuRUtFa0lHcGNlbGNvTUVuQXNTK2JrV0NERUps?=
 =?utf-8?B?K0ViVXh4WVlueGRuZjFGRVp2ZWkrWjZCVWZjVmVWWTVTbStRNkhubHNNMUdK?=
 =?utf-8?B?eUNiWnFrWnZ5NFgyd0FLRGlrSGZIZDRsVG1INU9SY0FQeWR3WmFlMzgzempC?=
 =?utf-8?B?dm9hVU43eENEdFVXY0hXRTlPVUdmeEZhMkk3c2lUV0JWZkUvUjFYWFd5V2ZN?=
 =?utf-8?B?QjhWQXN5RXJXMzJWVHN6S0x3bFZ2RHFxVlVxQ2VDNVlXbjB3UnJodE5QNGV1?=
 =?utf-8?B?Znc2LzJuZ1RkWFcxNjBFSVNuMXRqaEFRNmhUN1F0R1lJZEdJS3MvcmVTa01O?=
 =?utf-8?B?N3VPMXFHSFdGdjJGTlFqSnZ3bnFVZDlKbFRBWnEyRG5BQ0JlbzRxMTlnK3BV?=
 =?utf-8?B?cnVTOEQ4V2VsNWtpVE0wU09wQlZFQlRGbXhNTHVBUDhyVmNoZVpiK3VBaTRY?=
 =?utf-8?B?cGtEUkp2UTZRV1NNV1cxTVJ1bEl1UDhYR29NYzhoakZ5ZVB3Tm1sdGFDNW9a?=
 =?utf-8?B?Z2pneGhRaDBNVFI2bEMzTHU1NTAweHUza0pUeDlOcExMVWZOUUdDMEZhbEpw?=
 =?utf-8?B?YWVlaGhBTzZhbUxjc0pEK1NwNm1OL04yWjFEckM0eXJ0SmY4cFBITGkxczYy?=
 =?utf-8?B?WEtQMWpWNzhkTFJpQ2poRDRtbStTZUtGcmFXVjhGRytKdFVtc01vNzgxcmtk?=
 =?utf-8?B?cHN4UjQ1T2tyVVA3QlZocGVkSklWYlpmOG1YQllVZm1IdTRpVHF6RXNCUHg1?=
 =?utf-8?B?MDU3S3V1LzdoSnBycTFpMVN4M0NBaERrVUYzNzNYOHZNdjhIeU5RY3NTbzN5?=
 =?utf-8?B?VlZoZEI2L2hCS2RQWDROeWptK0o0UGgzdnJhTW4zZFRMc0tTT3N4dlZXNEJn?=
 =?utf-8?B?NVpid1Buc3A0RFhIald6MWczVzZJV0FoUWo4TWN5bHU0R1d6WTk3WXVqM0ln?=
 =?utf-8?B?ZXVlLzFIQVhOQ2loM2Qzc3F2RTdYM1BUUHR2V09KUFgxdDZFVFA4SHRNbmt6?=
 =?utf-8?B?c0w4RXpoRVhKc0gxajRjdTlLS1pLdmd6RkJ0Q2dOcDhvVVdDTjFaY2lPRXI1?=
 =?utf-8?B?a05CMHZYWGtvaXVyald1THVyRDZjem1nc0c1QXlBUjFJYUtwRFFTbWo1Sm43?=
 =?utf-8?B?VTg1WkRHcmxJbFFTc2RPbCs1K1JQcFpSc1V5WDFyK3R5NEJjNmRtRFNTWE0x?=
 =?utf-8?B?WGFDSFJTMzNRWGlrdGtnaWF0TytQOURlbTZzMGQ2OXphTDl0OHpqbm9Tc2ww?=
 =?utf-8?B?c3JwMStDa3NpNHkrMnFlY2pldDVNcmhKVFMzeGk1R2VaUENMTy9CbUFlZFJQ?=
 =?utf-8?B?aU1VY09vRnp1ckRkeUR5cHk4ZnZmZlVNWklvckkweVJJWlhPNW1ocXpUaFBQ?=
 =?utf-8?B?SE5qWFc4R21ScjhzT2xralZsUUFPcFRNRVQ2NGMzWXk3MXduclZ1ZzIycHkr?=
 =?utf-8?B?NDVjVHdKRGIyNXRpSmZ2WGZ6bHp2LzB6Z0tCWmh4ajdVNHZCTngvNWFFeWJY?=
 =?utf-8?B?QThaTDQ3Z3VKc25pTXo4UnU3WTJZakN1REVML2gzOUk4VVNYdE1YN1o0ekFi?=
 =?utf-8?B?bkc0WDBMZW4rQkNLVk8rZjFKUWo4T3padmlWNmIzZk9ZaUNMcGVia2FFVFpp?=
 =?utf-8?B?N1hzVEhSR3ZNejkrTjVxRGU3QW1DYkVyV0FvVEJKWU51NjgwZmZIWEI1Sjk1?=
 =?utf-8?B?ZHh1Y2xqaC9CcnFjeFFpd01iSEJ2K2FnUjk1eWNJelc1VTYvQmFoTjZoNHAv?=
 =?utf-8?B?VUUxRjRtK0xkK3ViSmU2enRwRjZTTHIrVEdsNko3am1UeWpTVWlpZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cefc19-e9fb-47c8-7fa1-08de4d69ee70
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 21:24:10.2037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sEi9e67VNlXqPBl5r/cg9Qvba5hM3TKY43kuakDwX6+ymAs7fHY2oAsaEDXih7sYs25bA2o1iTlt1sOgJhQdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052



On 1/6/2026 2:24 PM, Paul E. McKenney wrote:
> On Tue, Jan 06, 2026 at 10:08:51AM -0500, Joel Fernandes wrote:
>>
>>
>> On 1/5/2026 7:55 PM, Joel Fernandes wrote:
>>>> Also if so, would the following rather simpler patch do the same trick,
>>>> if accompanied by CONFIG_RCU_FANOUT_LEAF=1?
>>>>
>>>> ------------------------------------------------------------------------
>>>>
>>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>>>> index 6a319e2926589..04dbee983b37d 100644
>>>> --- a/kernel/rcu/Kconfig
>>>> +++ b/kernel/rcu/Kconfig
>>>> @@ -198,9 +198,9 @@ config RCU_FANOUT
>>>>  
>>>>  config RCU_FANOUT_LEAF
>>>>  	int "Tree-based hierarchical RCU leaf-level fanout value"
>>>> -	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
>>>> -	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
>>>> -	range 2 3 if RCU_STRICT_GRACE_PERIOD
>>>> +	range 1 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
>>>> +	range 1 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
>>>> +	range 1 3 if RCU_STRICT_GRACE_PERIOD
>>>>  	depends on TREE_RCU && RCU_EXPERT>  	default 16 if !RCU_STRICT_GRACE_PERIOD
>>>>  	default 2 if RCU_STRICT_GRACE_PERIOD
>>>>
>>>> ------------------------------------------------------------------------
>>>>
>>>> This passes a quick 20-minute rcutorture smoke test.  Does it provide
>>>> similar performance benefits?
>>>
>>> I tried this out, and it also brings down the contention and solves the problem
>>> I saw (in testing so far).
>>>
>>> Would this work also if the test had grace periods init/cleanup racing with
>>> preempted RCU read-side critical sections? I'm doing longer tests now to see how
>>> this performs under GP-stress, versus my solution. I am also seeing that with
>>> just the node lists, not per-cpu list, I see a dramatic throughput drop after
>>> some amount of time, but I can't explain it. And I do not see this with the
>>> per-cpu list solution (I'm currently testing if I see the same throughput drop
>>> with the fan-out solution you proposed).
>>>
>>> I'm also wondering whether relying on the user to set FANOUT_LEAF to 1 is
>>> reasonable, considering this is not a default. Are you suggesting defaulting to
>>> this for small systems? If not, then I guess the optimization will not be
>>> enabled by default. Eventually, with this patch set, if we are moving forward
>>> with this approach, I will remove the config option for per-CPU block list
>>> altogether so that it is enabled by default. That's kind of my plan if we agreed
>>> on this, but it is just an RFC stage 🙂.
>>
>> So the fanout solution works great when there are grace periods in progress. I
>> see no throughput drop, and consistent performance with read site critical
>> sections. However, if we switch to having no grace periods continuously
>> happening in progress, I can see the throughput dropping quite a bit here
>> (-30%). I can't explain that, but I do not see that issue with per-CPU lists.
> 
> Might this be due to the change in number of tasks?  Not having the
> thread that continuously runs grace periods might be affecting scheduling
> decisions, and with CPU overcommit, those scheduling decisions can cause
> large changes in throughput.  Plus there are other spinlocks that might
> be subject to vCPU preemption, including the various scheduler spinlocks.

Yeah these are all possible, currently studying it more :)
>> With the per-cpu list scheme, blocking does not involve the node at all, as long
>> as there is no grace period in progress. So, in that sense, per-CPU blocked list
>> is completely detached from RCU - it is a bit like lazy RCU in the sense instead
>> of a callback, it is the blocking task in a per-cpu list, relieving RCU of the
>> burden.
> 
> Unless I am seriously misreading your patch, the grace-period kthread still
> acquires your per-CPU locks.

Yes, but I am not triggering grace periods (in the tests where I am expecting an
improvement). It is in those tests that I am seeing the throughput drop with
FANOUT, but let me confirm that again. I did run it 200 times and notice this.
I'm not sure what else a fanout of one for leaves does, but this is my chance to
learn about it :).

I am saying when there is no GPs active (that is when the optimization in these
patches is active). In one of the patches, if grace period is in progress or
already started, I do not trigger the optimization. The optimization is only
when grace periods are not active. This is similar to lazy RCU, where, if we
have active grace periods in progress, we don't really make new RCU callbacks
lazy since it is pointless.

> Also, reducing the number of grace periods> should *reduce* contention on the
rcu_node ->lock.
> 
>> Maybe the extra layer of the node tree (with fanout == 1) somehow adds
>> unnecessary overhead that does not exist with Per CPU lists? Even though there
>> is this throughput drop, it still does better than baseline with a common RCU node.
>>
>> Based on this, I would say per-cpu blocked list is still worth doing. Thoughts?
> 
> I think that we need to understand the differences before jumping
> to conclusions.  There are a lot of possible reasons for changes in
> throughput, especially given the CPU overload.  After all, queuing
> theory suggests high variance in that case, possibly even on exactly
> the same setup.

Sure, that's why I'm doing hundreds of runs to get repetitive results and cut
back on the outliers. But it is quite challenging to study all possibilities
given the time constraints. I'm trying to collect traces as much as I can and
study them. The synchronize RCU latency that I just improved, for instance, came
from one of such exercises.

Thanks.


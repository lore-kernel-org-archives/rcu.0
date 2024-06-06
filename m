Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717CEADA;
	Thu,  6 Jun 2024 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717645584; cv=fail; b=CthIxExeLr8+qIozIHosIEIMGWJpyLT6JgYhmMXShJUfOAQSnxHSnj79yY/xcaRcFlUSXqavPoZ96naL4XPWboC2rPBxHjZplwdPpF3Ja8GwVCOovZBg26+CXvaflUmQOLluRT+tepEeg3/AR3EEPjFtX4xpARSYMDLg4cMWFqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717645584; c=relaxed/simple;
	bh=RAFu8aHdxs/pSlhEcqn5P0jzdVrFh4MfmghEuiTo3Vs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/0AnpF4A2XKD+lLmv0xwqrP/2GHX6Ev3vaC/ZNj0HZkDCqrnRmXkAWKXzy0yzu/MjcVpJsFVEgg/g4XasKVjn0x62TxXsVEX3QCUwGWrqnMUfT2LN/BFbT/ihwdWriLyY/lMXJo1sglhLkIrf8MaP9S0lX8nXwXMGW9XHqU2l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F9Qnzncs; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F9Qnzncs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGtSPpD7yKvqq1YXEOHnOvKWZrw4o3tqIX9K+9Qj2dD92ZZLuvXuHfc/CAJ10FY4zZFHQG0bFSA9fwdhM04syI9dQnyxmRkN9UrG7QKrqcvtzVj9OYDBrFUi025uovEydHwB/GdbWSIWEAS/9PUdvOpWGjPTMnsZL16Dca1hTsE2Xcto0pZ6807U7d4J7spZMC7KRpMujjxiWIjs71mYfDEUSzoO31C/KvuXvuB0DqJ9kgpw2iv/aGLGW5ZR4IKBWMpAXmbiHGefG/UcKDPcCMCYEb+J2gw8dXGoZFdn9Y8H6IMHj9mKCIMf/ZFbacPuacnJBIYD8kCAZf036Jh2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESGdbkyDguSQDjzK+xekocb6/b7MnfMaVItVzWeVTDY=;
 b=WBO7uG2quktPlUX721mJnUqHAl6ipyO+wvh1Asl4+wMz7Vti5fzTISTx7BbTTnQlDg1IlIZYnwUuQAVKb/ivxVd9/AbLW2c3/hR5LUqvjbp2fffyOoWue/KlYqS2AONdfYVms3kp2nlRmS/SaPklIKMZ5WaatmPVtdQZ+IYre/IgT6YE7J9m7TOdmUtQjN/XvJHnPXkBM2ovqgOHOgTu6DC27647RHrJ56dpbnVetWLbk1UNhUE1MyJ2zzn/Iao2KvipG1NCmpafSCO2k3E3MPz+FfSR/WLRqHBUKcvYfis+mZzb+y8joR8H6Mz1Q9dqQ7OjZ8KWd1BzEjFY89Lisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESGdbkyDguSQDjzK+xekocb6/b7MnfMaVItVzWeVTDY=;
 b=F9QnzncsGzm7zrTtIqVweMkH22y2TR33k5XM/GyoSmYSU/7BSHhloM13ES6+YzvLW4LE+D5WXSAqnBCFmj+AEWbLMpFUMpJNidDiHMa0130hZwI5zvilaFdPFebAM3Huu2vR+5U7UmMLsYGHv1Oc6XKIqqtcwQrQtLSwIYZ4ynw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 03:46:19 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 03:46:19 +0000
Message-ID: <fbc30c3a-ecd3-4525-9434-307c7769bb4c@amd.com>
Date: Thu, 6 Jun 2024 09:16:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 2/9] rcu: Reduce synchronize_rcu() delays when all
 wait heads are in use
Content-Language: en-US
To: paulmck@kernel.org, Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rostedt@goodmis.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-2-paulmck@kernel.org>
 <ZmBVfpyEZeTIAHJn@localhost.localdomain>
 <c7d07e5d-34a0-4874-8e7e-1c576c14c8e6@paulmck-laptop>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <c7d07e5d-34a0-4874-8e7e-1c576c14c8e6@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::25) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8b8918-fc10-4b8d-b996-08dc85db39b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0lBOXUrVldDNnlqd3lOaXZMTlpFRy92cWppWk9NVXFPa2dpY2JaWmdGVnpq?=
 =?utf-8?B?WVVpc3FLTGtHRWVSYTk1NG9BYjhPdlM4a3Bjam1xZmNZQ2dvV3E5aWM3eU9M?=
 =?utf-8?B?cmhYZmhFTnZMeVdQVGlXZEJuWGdkWE8vWFJzb1lSKzF5ZnJUM1pnS0NWR3dE?=
 =?utf-8?B?Z0tYMlEzekpEUVRoZlJBZzgrcitzdm5iYjF6K2V1L0RQR0VlaUtOOFlmV3cy?=
 =?utf-8?B?SWxmeUlEMmhFeFVtUFNNdmFhaXpnU1ZQelVINXhROUpHRUJ0QVNvSXdObDBG?=
 =?utf-8?B?VTJQa3JDNDlTN0p2a2ZPTGNKSVNOYUJyTjFmREVwZjc0RldDTDRsci9mOXdF?=
 =?utf-8?B?TFR6b2dSSW44RjVsdEx3TzlIV3Q4TDBmbktzM3lTL2hxOHduSU5ISkRPWTB4?=
 =?utf-8?B?SytVeXEzTFp2aTdYMUdheGJkN3BBRGljTkxFUVFZUnl5SVdkM09KZEdRMW1F?=
 =?utf-8?B?VDk2MDhQcDhSNkpJcmpPdTBYSDUzam5tZmQwTWNZeHlLcGNVSnFUQjBsMzl3?=
 =?utf-8?B?K0tMNGFEbU9xOUQ1MmNqUFkxR2ZOSlpIUWZ0SzFtbnJXOG96NjdtcVhuTUw1?=
 =?utf-8?B?SlVHMnN2LytITUpGWHBKSGdCSEtzVVNLMW5pQjVhdG5KTldBaW9WRkVOcHdl?=
 =?utf-8?B?OXFzc3lZYXp3ZGNteE56TXF3ZHFqamllNkgxVUxhT1lob2JvMnFZUG1RRkV3?=
 =?utf-8?B?d2JuUDVOSWs3RlI5NTN0S04yVythc1RrZnpNcXZKMWYrdFRnZHhCd3FvZkx5?=
 =?utf-8?B?eXBhT0dMb2dLUHpaaDdtVUpmeGtKNktxMXRqcUtpSlpKZTV1dFcvMm0vdXNP?=
 =?utf-8?B?NTg2NFJuQkFUVDdiMjhZNDFGeUljTEZ0LzBkSzBGMktod2NtZnhjWjlTV1pV?=
 =?utf-8?B?UGpaSC94YVJmSVI2TDlSdXZnbWliZytyTzMyYUl3UkdzVW1xMzJ0dFRqcnBY?=
 =?utf-8?B?Zm1GTlJqRkQ3UkU2alRveWhYSDB5czBiaG5nakNoWXpIVkw0bDJCY3BYa0hD?=
 =?utf-8?B?VnN4cEVnVWdsTi85ektBNlVwRlR3QnpYVHZLaVJKbk80WWJnQjl3VnZXVkNv?=
 =?utf-8?B?aDVmTkxlTUdVQ2w5Vk5vcHVrZm8xamlmcVpkR2VONXd4VUIrQlJ1aFc2aEVH?=
 =?utf-8?B?bnZ2Z3Q5TEVOWkFnbkR6eXhzUGZyRGZlMWRhWkwyaG5NaktQVWtsOWRuTnFQ?=
 =?utf-8?B?OWZNVW5lOFg1QWt3QnVjZzRqM3NXb2tKUTYwTFI1VStKeHdRa2JVSlYyTno3?=
 =?utf-8?B?NmFPbmRXRUNGN011TkNqQWN0RW9TMEdiZU5GYUY4bzBiWVAzQ29QVnFESkRL?=
 =?utf-8?B?d0JRYkh6VlpiRlZoSmV3a000VW5mdHA4MERyczZtSnNIZEh3SHpTTUxaNXEr?=
 =?utf-8?B?K3A0b2VoRWdTaW05OWR5R2p2VDIzNGx3L1hRMXZrRTBWcWtRZ1FKY1UrTzE0?=
 =?utf-8?B?bFhFZUxvQS9oc1VDZ3Q0Y1hlMnNmcDNPSG1xYlpDYkRUd25ISUJ0WmQ2QnE4?=
 =?utf-8?B?RWtMck9EV2ZNYzRqUjZ0czlBQ3JrSGtUekw4ekFqTjNHb3JHZ3BLQkV3ZHls?=
 =?utf-8?B?SkxkaGtwS3A5SUJ4UFJYUXFNaFR0Nm4za2JzQU1vSytjT3J6b0VVUVlLbno3?=
 =?utf-8?B?RmUwWkswVmU0UUxzRmxoNjdBUDZJQ0s0ZDkrVjVSTDhWMGIxaUFKUldQYnMx?=
 =?utf-8?B?WElQTTRidUlCb3liUlN0VVNyZlE2aDhrWEhPTjdDc055cUFUYXI0ZXdHbzlv?=
 =?utf-8?Q?5WviRbZOW9/o3i33qI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnhKV2tKUDNTcjBIUFQ5V3dHOE1mMDAvVXZ6cFdZamsrdVJuQjE1V3Bla0ho?=
 =?utf-8?B?ZFUrVGdJTlRVWkdZeGVoNE1pbHp5V05ucm52N05WL3ZTVjNYOUpHaEVYS05v?=
 =?utf-8?B?TS9Lb3N5Tk9RSG9KNEtiVno0R2swcGVVZFN1YWxRYjV5Wm5IeStJaGQwelRR?=
 =?utf-8?B?cHBSc0ZyUHZvUDRPYWozQUEyTWJSWk5wUm5Tck54NVdpTG4rdHhKM2t3dHMz?=
 =?utf-8?B?N2ZoMDRhU0JRZ2N4R3duNmFuQzczdWZVWmtBNXZ6VjdoL2cvZ1A2eFdKaEZq?=
 =?utf-8?B?ZGJ2QXlXTmhtZjZCS2EzZ2FGMmw2Q1hhelZLNDByYXhLVGZtaWVJOStWM2JX?=
 =?utf-8?B?SnpwNzRQL0t4Mld1Z21JSWRZeDZ3K2VkdXFVY2JIcVpjSk0ydzF3VndDcm8z?=
 =?utf-8?B?U0hPZ2Y2ejdnWFRXZWxlWkE4ajVTb2VycFFXcVR1bUtOTHBxaFpQc3hXRFNK?=
 =?utf-8?B?MG5WVmk1UEp6ZXZ5RGVXSEwwSjF3TTFBL3RITXZ1TTA0QnVBYmd4M0E1Ni9v?=
 =?utf-8?B?MVh1RjNEMnNwcU9ockQ4Q0RJQXNuNGNUbjhEYkpXUWpqc2ZxYkxqb1hPemtH?=
 =?utf-8?B?b0NrUkJ6S3o3QlQ2TTFKMDBXaHBHbW1GL01acDVYQm5FYmtRaTBzSThKa1Vh?=
 =?utf-8?B?Q3MrYzBHRXJvUHhlOElWd29ZbEdWVWV0cFRLcUUrbzVKTFJTaGdTbFBGWVNo?=
 =?utf-8?B?RTRCSHNSdExmUTBDK0Q4VzVKc3ZCRktjY2c3RHRlSnZkT3pTV0NFcTV5eURV?=
 =?utf-8?B?RjFQWVMyV2pWeUNUWkp0QkE4ZlN2MVZCa0Y4YWttYTk5blBWZHZFWU9SOXhN?=
 =?utf-8?B?eGIyUnJpSDFWbWVGQnRNNnYrRWtVSHg3VUpCakJFMzA5NXJLaHNiaHVKV0V4?=
 =?utf-8?B?bHdGcmFLVWJpSUt5U1JvYWN1ajMranVGRmlhcElRZ0RoWHVPc05WNlYzTnpJ?=
 =?utf-8?B?QWJ4UUdveFJsM3Ivai92K01NK2NpNFJ6cjJFbXk4NFlTS3lqMEJlUm8xaFFC?=
 =?utf-8?B?Z2ltRnVTRDBoUHlFTU5jVWw1anN5WGhCSzNMdHYyRzhoaCtGQnl5MjZnQldL?=
 =?utf-8?B?RkJKbWVXRjJSSFJRVmZydlJoUGR4VjBaYVU4MU8yMUhQdVZVeTB6d0VaaHk5?=
 =?utf-8?B?NFZFVmNkU1RuWXQxL3ptYVh3MXNNYVhJTnFSZG80OWNJa2dGM3BUUGhTT2lv?=
 =?utf-8?B?RlhjTnZab2hUSVFJTTlRbnNsaW0rVDNGQ3B5SHBQbHltSXlnUllnRlYvbDVW?=
 =?utf-8?B?S2kvaUd3NHVDMGl0MExDd1JqSnVBbXFuT2NwWm1kc2hOb05mTWRwSDFuV2JN?=
 =?utf-8?B?QmFXUlZlbHBkMHM0M2dBNTJ6eC93K29EWk9EYkwxVWhjRWxEY2ltNHY3K2dv?=
 =?utf-8?B?N2NrWEdMc0VqRFFSbEZuTmpOdGUzVmtmWTBrZ01LSkdCVWpPSXlYRjNxM3Y2?=
 =?utf-8?B?ZTVlQzVXcmtERWdXV3M2M1E4cmN4Z1RaSnFHQ0Q4aTFoUXkxK21pVy85MGxJ?=
 =?utf-8?B?MkMxSS9WeWM5MTdQVHlacklKSWZmTCs4cE52WEg0SmtybHAzSDJUcHlrb3dW?=
 =?utf-8?B?VjgvWVR1Z3NvekRyY0xJcy9LbkJKR1UwWVdGR1kyOTFjK0ZrczJjUUFNMzVY?=
 =?utf-8?B?RGRGcjgxWlI3WU1xOEU5anAwQzZ3SVZxZ0VrWllRMENjOHBKbG9nYlNndWY3?=
 =?utf-8?B?OGxQMnV5WWRkUGxsa3NqSmJMcWRkS3NCcVFBYy8vWUVHdlVldVhrZE1oSFFN?=
 =?utf-8?B?MXg5ajF0azdNbkVBSUorU2pWcTVwMUpoRTN0Z1lZTDd3UXVXN2tOWjJDbkZs?=
 =?utf-8?B?cEhzUW1MMk4vemhtb2QwazY3QjF1SlBVaXpkWTU2c0Rqc1M2Q1ROY0NKVVY5?=
 =?utf-8?B?cjIrZG42Sm5iaysyZ3MrWHdGWXp0SWpoY1U3S3ZVZ29PN05vSnB5S3dDVjFy?=
 =?utf-8?B?ZUJIUlZKeGYzNnNtMit4Uit6aTloYktuUlBqWXBrVzVSUmNCQllKb2NHQXlo?=
 =?utf-8?B?RmxxRHBIZ3VDdHBzVm9PWVhmMDVXMXdQUEpZTTUweFl1QjlvWktyWWh3UEUy?=
 =?utf-8?B?dlh4SExqY280VjlqUlRxNUt1RUQ5aFNQWm02Y1N0Yi9XLythSGs1YStvQTZp?=
 =?utf-8?Q?pAFV3lPMoq1B0HltPaNvXvuCf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8b8918-fc10-4b8d-b996-08dc85db39b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 03:46:19.6044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObVp0Y2SkwQZ9xtOJwSWFn6zNlRU1UYlClHvpU3mR1/V3UEEZrHa2MOrvLO8BIfI70F/Lw+7QBAXJvOgrGi4pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154



On 6/6/2024 12:08 AM, Paul E. McKenney wrote:
> On Wed, Jun 05, 2024 at 02:09:34PM +0200, Frederic Weisbecker wrote:
>> Le Tue, Jun 04, 2024 at 03:23:48PM -0700, Paul E. McKenney a écrit :
>>> From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>>
>>> When all wait heads are in use, which can happen when
>>> rcu_sr_normal_gp_cleanup_work()'s callback processing
>>> is slow, any new synchronize_rcu() user's rcu_synchronize
>>> node's processing is deferred to future GP periods. This
>>> can result in long list of synchronize_rcu() invocations
>>> waiting for full grace period processing, which can delay
>>> freeing of memory. Mitigate this problem by using first
>>> node in the list as wait tail when all wait heads are in use.
>>> While methods to speed up callback processing would be needed
>>> to recover from this situation, allowing new nodes to complete
>>> their grace period can help prevent delays due to a fixed
>>> number of wait head nodes.
>>>
>>> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>
>> IIRC we agreed that this patch could be a step too far that
>> made an already not so simple state machine even less simple,
>> breaking the wait_head based flow.
> 
> True, which is why we agreed not to submit it into the v6.10 merge window.
> 
> And I don't recall us saying what merge window to send it to.
> 
>> Should we postpone this change until it is observed that a workqueue
>> not being scheduled for 5 grace periods is a real issue?
> 
> Neeraj, thoughts?  Or, better yet, test results?  ;-)

Yes I agree that we postpone this change until we see it as a real
problem. I had run a test to invoke synchronize_rcu() from all CPUs
on a 96 core system in parallel. I didn't specifically check if this
scenario was hit. Will run RCU torture test with this change.


Thanks
Neeraj


> 
> 							Thanx, Paul

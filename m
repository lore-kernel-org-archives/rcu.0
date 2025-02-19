Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95FB1F8AE5
	for <rcu@vger.kernel.org>; Wed, 19 Feb 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980661; cv=fail; b=WD3hYEyCqBl4zffE+Gk42D6DSqMIBg9/3o8NAfTm2eYjZtXwgAHpzf+ZzA+qH/TMDQEsByLD7Vu521NoMks8nEG3TYfwdPV32ZIBPxN4dxpZk770aIv7y4GyOI/qpqHjAzvT7PQzVeRoEco6/vpDMufZJeXS385JGV0jB5wgPkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980661; c=relaxed/simple;
	bh=k0CxmYgbtS6oWQA92H9eGHiNM+DdhEOOpE8cX2zRvJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fNmfu9iL/wrOrKhp6gj7oVv6mhoVx+bSzjGIyRVNYcRjLKfKCOlb9YY9BkuwGuG+pZN2dcwtiorhJDxUnZKkZNrn4ht+7utN1nUFck8xpJExxtMdwSE2mJTZuZzccb0rlCFF7zp/rQvy5OY2I8YIHDbMZteV11IK1bUYmO7U1iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hKj4zn/E; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hKj4zn/E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqZZHT+y82a96yhwue4RO07jlGSFRRmMK2Rds1kla4qIXbUL+dTQs0wArW6FSdompJqNsou3WfDD0zan7B/CMuFDgZKMHxmLbQmDmBOKsKC+ivyplLcYvadfXFjqYnkXuyziuiaZdSqP7KSOK8FTm1SfCS9UAxkfEFUryboH8TBcnnZoioPt3QpC54VIFPS3J6YbY65G2OU/+V1LwbKUB2yTqRaM5bT+HR4ZxlxV6qKLL2QwPv4D6kBTFi1fOe3KnEJyeiayJXGBcs+IKuesFHbMWwqWQC2AND1lVNFSHlncJ6CsockjkeyrunWVaymjHAS21VK7+RmL+M0ZLaX0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFMP6//JR27o/19ZaGAYnBXfYmRnzoJ3awfGbqSWork=;
 b=aDvSyVS9jRL3wifKi56lH93XJiI37fr6ulbCj2eTuWTro6KNDuspnBvuGmP+etr+O/eF3R9AZm/zVVNr4Cp+zn85HTtlHlog4K8BRpSPxwraZ9ypdqHQudKir8gNQ4SC26jHwaqFJd4EBC0+JVXALnHlhEZYpwWDPKq4X/mD5TCHRdeCr29Z+U1PqEbREg5dr1LLE2M3zJTKWWOnjSJWCP5QAXxF6EY8J7VAvgW96wxWgbC4bnTxOpy17qbW/ERM7Vab2psRVZ8Zgu8en7tmtJkaAdtTqvpZEovXo55l4v2nY5LkoSLTcY+FwIJlbCITIgljtnIZXj/5+0V+gykgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFMP6//JR27o/19ZaGAYnBXfYmRnzoJ3awfGbqSWork=;
 b=hKj4zn/EWOYZMKJYhyvyAPb/gJ6W/NXztkI+fY+fxiGrMzEPUqYbG3rKD1bvwtIhbz4tVSlYtvlVNGJHlEW6RqN7iJMEp+y2fI5z7MQMZLe8mEmFQyNn9QJtgvoWy6zdASKVZwUj5al2HuOXKyu5Mf52Gil7XYCNPrGUmruCdQp6uF9wfHR4te0/r1dPpu+tQo/PgQ5GwWCAATvpyUVKv8ZU9DNTywv1s5dvk+3rXll4bI0bQ4ot2x7NMpD56FYp0QLDZlbO2YLOZoFNyXxyZjVvhQJYn8F3K3pM4P+Ow+aAO2hrXfNb8Bb6/Jbf6eMp07sR52SWt3u+HUGnbb+wtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Wed, 19 Feb 2025 15:57:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:57:31 +0000
Message-ID: <7dd7431d-a8d9-4ac1-9c28-e43c7c1fcbce@nvidia.com>
Date: Wed, 19 Feb 2025 10:57:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: The rdp->gpwrap behavior
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
References: <20250213183033.GA2635051@joelnvbox>
 <b04b997e-fee6-4c5f-a0f9-12e671d27f8c@paulmck-laptop>
 <009ef653-f41e-4101-886e-d9a4ce4d6e32@nvidia.com>
 <d1ebe3a6-42d9-489e-8df2-9dc8c2635a61@paulmck-laptop>
 <03416b20-789a-464e-8c2a-f9a96eec4b68@nvidia.com>
 <b613df84-a176-4333-8c7b-2f3a75c7fdaa@paulmck-laptop>
 <04e2c857-d66c-4ab6-8db8-33dd88160910@nvidia.com>
 <f23140ec-2676-48a0-ab59-51ee18f22238@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <f23140ec-2676-48a0-ab59-51ee18f22238@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:335::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c25fd8-c940-4779-52e9-08dd50fe1dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDYxbGxuK1kyeXU3SGJjdDRERWZDeEVNUDdaVWhFRnlvcWRLZVQvcm8rUGtJ?=
 =?utf-8?B?cmxyekVuVDFGb2I0N1kzSU40OHFVQmxxZGFucjlPSUR5RDlsWlRPN3hncURO?=
 =?utf-8?B?VUpFVFpOSUNzR25jdUpXcEI2dDFRNmxIR04wdnRkZDRaMEIvb3hpK3ljdHVU?=
 =?utf-8?B?UlEwaHRTZnQwMys1WjdOMkRMSUN0bVlpUDZ1R214UnhtYUhrOUxFb2Z6eWx3?=
 =?utf-8?B?R1grSGZ2ZTd0anA4V2JlUXd6aHZXTzhxLzUxSnlWWlltK1RWYVNZaUtnRmsv?=
 =?utf-8?B?OExucWNkbjN5ZXhMQ04xOG9qVzJWOVZFcVQ3VTM1b1FtVUQweklKeXFOb1Fv?=
 =?utf-8?B?aFhidGNiay91cEJNcFZ5eVBoWElpM2dxZ2VURzJsOVJrNXBPRzNQdVVOYmFl?=
 =?utf-8?B?eUJidm1JU3BiQlJ6R2phTmRtN05scmEwRkp4dktWZjFFenZVV2JMUkw3Witt?=
 =?utf-8?B?eFRPMWc1eXY0cE1sSk9tNjZ3UHlWeDg1S1BSYm9XQ2toendlU285MkZhQ0Zr?=
 =?utf-8?B?cmg2RjVYQjl0QnZDM0wrbUQzSzhMUFR6VGMweW1RMmtsRi9WMDZxdmpDMkpY?=
 =?utf-8?B?b0kzcUdpZ3JHOHZIcTEwOTBlOHY0ZU1IRExMaUpLTDd6ZG1TcklUNmtsQldP?=
 =?utf-8?B?cWduYUJKbnVnbndEVk1YRXljM3VIWDJZMlpsbXZTMVR1SkdhejcwT3NHWUtJ?=
 =?utf-8?B?TkdoR0s1U2ZocGt2dktuQ21TaXBCMDBUUHpTQ29HWnRtTnBFY3VVTTFaMUYx?=
 =?utf-8?B?STZUWHFDc1VhTDVSQW1IYWc3ZmJTMEdSNTlzRWhEV200YkV5aDZqV2VDTmZm?=
 =?utf-8?B?Y2x3YVovUGFILzVSMXpuTmhIR24rYUk4SGtWdTZCVFBEMkc4MUYxWUY2TDY3?=
 =?utf-8?B?VWQxTlNNVHNlcFo1aU50Y3QwSVhGcm9sNS85cFUvNHNJV1pRZ2kzK01MVDlx?=
 =?utf-8?B?ZkhrWUVtbitaWmk5SThYdlEzc3pwSUNsT1UycDV5N3luYitSWkloY2hhTSs2?=
 =?utf-8?B?Nk1HT1Nid3JhUS9LQmdEazVUYk1hWXZSN2dLWkZqWVJwU3hSU0pib1RuK3cy?=
 =?utf-8?B?cHpabzcwTUVHMmFwbGM0eW0zMlNEOTdYNUt2TnNrc05lbXozYnNVTVZKeXhF?=
 =?utf-8?B?azlZZmNzR1QrNDVqanppM0hLL2srekZyaEt4azFqTUdlUG5kUjhPZHhRMzJm?=
 =?utf-8?B?c3h5Z3czM0MzR2RnRTBOcVdJOTFTblNwVTZTRGY5dk1NUEZmMnpudVc0czg0?=
 =?utf-8?B?cS95NnBUaEloUFFHMVN0a1hTUDBhS1RyV3hIL2RZUXMyclNBNGNQRVYzVGVT?=
 =?utf-8?B?M29aajFOVzVsSlFTYk9KTEhkOGlSVUgwTklUUTljTFZmcmtINkZoME9aQjZQ?=
 =?utf-8?B?WDJmWU1QMWY2QzFqSkE1ME50RXR6VlA5VnhmM1UwSzRWK2l0WGlXLys1QTVt?=
 =?utf-8?B?UDZoVVdkYm5yOUNScWdpRGdqbmtwNC9VamFtbmZRMUxTTlJnZUVSbVE3S29o?=
 =?utf-8?B?bXFkYkF5QXp5NDYrTDlDMy9LWjZheWdwcUk2bnRweS80WFNsNGRnYTVtM2My?=
 =?utf-8?B?em5nRzZEQTZ2ZW0zcmVGOVZ5b0J4TEcyMFBEZi95Nm5GK0l0d0F3cWgvYjhv?=
 =?utf-8?B?cDNmY3djRktzRGJOU2VaRUxGOHAzdjE2Uk1weUkwRTE3NXNYQUVhUmNZTE03?=
 =?utf-8?B?R0t3TUFCUzVQcXpRZmNtWGhnUmRwUWVDeURiQ3lueDNhVjBJRVp0R2hQMEZa?=
 =?utf-8?B?YXVwU0hZbWo5em5TSnlhWTVxRDhDVlBKcUFObGZQcGtzY0J0MzFpNndxQXRt?=
 =?utf-8?B?bnRWcVF6aFkwaDE5aWdwR3dtd1hoeDhQNzBmT3ZhNUo3RUZwd09NYllnYUFP?=
 =?utf-8?Q?r3qS+NfX04Jfg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmtUWWZhMHF6SllwU3NibThoK1pFazBBdjdDU1N1TnRTcWF6aVZNZy9CSEk3?=
 =?utf-8?B?VWRrQXZaelhqUFhLSEpHUFh6VmNXN0hmVGlmRnQ1R1ZXTS9yRXlSNlBaaFI0?=
 =?utf-8?B?Y1NZQ2IydUNWOXg5NkgwZWY1Rko2TFhYbWc4Y2JwY3ZnU1gwZDR5VHJvMXBn?=
 =?utf-8?B?Nlhkb0hENkY0NktRQWcrQjQxSURLQ2FsNVlxT3BwQ2F5NmhBVGl3cWduUnkw?=
 =?utf-8?B?SUhlVnhiNTRKUGNxTzg1UWJxZ09EbS9ScjhmNzhQMkRycHlhYVpZVmJhN1I0?=
 =?utf-8?B?amVZYUdQY09icS9yVGJ2ZXEwVk9rUlR3dGV1UkNVeFZlWXdXajVVZjRQd21L?=
 =?utf-8?B?YVJoS3hzSUgvUHBYMThDSXdUSm0vK0hvNURjdTlReWFMYlBIcG1iNm5XbkNL?=
 =?utf-8?B?SE5oNzNROFcwTkptY2FrYlRIc3FUQ09BRS9LNlZvUEJBUSs1MzNPaHZBRWNa?=
 =?utf-8?B?encrdzU5cnJ5anRkdElsZEw4d0JKdUZSVXdTbzRBdERrVjdwdlQ1R0wrNWpI?=
 =?utf-8?B?NldZZHBBbHZEN3pxM2l3MVVvQXdzai9RZjl3VFVTVUtoYUZQSlRWM0krSnQ0?=
 =?utf-8?B?SVVDcDJBc2pXbWxCeWlWQXo4czFhUWNKM1FCNjV5T2VDZjFMYUhHSjg4KzZa?=
 =?utf-8?B?QkJMNkFFbmQ4c2ovMkpWbDc5dlhsZU93QTd0cFUxUEN3TjJrRDhYc3lTTDRE?=
 =?utf-8?B?OXpPS2l6R1g3MFd2eU82WXlqOHVtT2hHQVNtOXAzakpUejdrNi9iRzlnbDh0?=
 =?utf-8?B?ekRqc0RvSDM3a3Vhclo0QUVSamRRRUxKakZDVGczSXZSMEdCMmJ3SUpMcmdM?=
 =?utf-8?B?QjR5cTZSblBJU1ROV0xOeVNtekFteXFCR0JHZzNWUVpaSnR6QTVXVTk0OWxi?=
 =?utf-8?B?S1hrcnIwYTUrc3BvT1l0dFkrQ3RnTkFEV1QzaVo5NzZHVXZnWnpRZ0VCYXdw?=
 =?utf-8?B?MnRzZ3JmUW8vaWZXSHZyWFMzUHdCbVQyU1o5emRXSlMrVy84aitPUDlKV2Mr?=
 =?utf-8?B?YjdIdDhqbXdtSjRpbG82Y3JVMCtQUEJwa0lQazRpNkpkZDhIdXZ2bzNYR215?=
 =?utf-8?B?Y053VFB5RC9ab3JnR2g1VmZvaE5sYjZ4NWpRbk11TkwvWElrMnppcVpHT0hH?=
 =?utf-8?B?R2ZzZFB3dFcra1IrWUhkN0lBbVdxMy9uZXAwRDY0YTQ4UU1mY2V0VWVtdTY1?=
 =?utf-8?B?WUhsT0NULzdiQ3Fnd1kzWnFGblBlaDFxWUZxbTIxK0gzWmYxTTAvZnh4WnVI?=
 =?utf-8?B?MTZQOE9vNGhpTndlekVydkpoTEFzbU5SR3ZzMkkrNGwvSFZoNzhzaWU3L1Zr?=
 =?utf-8?B?a0VlUm1PVW1uczRYcFZYM3pGSnBaVEdEN04rUVFHNGdEYThSUjR4WEZ2aVRQ?=
 =?utf-8?B?RXFOQUs3bUNobkYrUk9EdDFkQ1lCYjUxd0lzVTRNMUpTUHR2SXIvSU1TeUNl?=
 =?utf-8?B?dGswdUFMSUh4bGxKNzFYdHpUZnlPdjA0VTE2VFg2d1NlVk5pWXd4YzYwS1Vp?=
 =?utf-8?B?YW1FOE5iOE1WbVdpVUpWVHN3Z1hWVFRJY1ZjTWhyVllvS0JmS24yNkpQVmFq?=
 =?utf-8?B?RDl0eTM2bFVmN2srWVkvTTlUWTJUUStkdGQzYTQyQ3UvZ0JWUjc1Z2pWa1pI?=
 =?utf-8?B?SWF5YkFuOHR6djVYYVFTL1JXcG9wbkFMRGpOVHErNHhhRjl0dklXQTA2QmRp?=
 =?utf-8?B?S1U3TFNRRTVETGpQcUJrK2g0dVFwV0UyRjFyZ2hRVXNmY0h6N3hKQjN1MlpG?=
 =?utf-8?B?alZOblIxVDJjVGdrNndSYVkzN2V1OGNibUdSMEgrSHRCRU5MRUV2K3EvOGFv?=
 =?utf-8?B?YzNQT2NLTFA0SjRUWnRVaS91TytGQ3hCWFQxUHNjeHRCVVpDUWh1NGhQRUdS?=
 =?utf-8?B?WTdZWXJocnBjeVJvMDNCenZHZmJaMnNYMmt1Q0pwcWdGTVFrakRHWGdnNTZl?=
 =?utf-8?B?MjVKaEo4Q3Qvcy9ndkhLajVuSnJKNW4vbUFPYnRvOFpBZnd5SWNaVkJHaVNR?=
 =?utf-8?B?U1UvVDZHeUp6NGhsUDYyZ1dlYUZpdVI2R1p3OVY3djV0amVEK1pVeHJHQkdr?=
 =?utf-8?B?RjJIaUYyV0Z6MU5yVFpLamUvbDZQUGZVS1diK2l0VnBFQWJUbVlTTGFoZkJl?=
 =?utf-8?Q?LCD+6vTd5/xlWPqyQblDFIFPR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c25fd8-c940-4779-52e9-08dd50fe1dcd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:57:31.0142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPVRpkLAhE+pQ8ZofFIJc49CstjIperOya0GfiAt0oLrvP253eB+gUsqzQ3Aqs9FFmhcBtReWVyrkojkqgkPXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414



On 2/19/2025 8:54 AM, Paul E. McKenney wrote:
>>> the system, by scaling the default by the number of CPUs.  After all,
>>> we want to test both the ->gpwrap path *and* the non-->gpwrap path.
>> Agreed. But do we want to test both these paths only under rcutorture testing or
>> were you considering we do it for regular operation as well? i.e. wrap in 10
>> minutes in regular operation. I am guessing you want it only for rcutorture
>> _and_ have a 10 minute default.
>>
>> If that is the case, we would then need rcu_gpnum_ovf() to consult rcutorture,
>> if it is enabled, about what what the threshold is.
> The rcu_gp_slow() function does something similar for the grace-period
> kthread's injected delays, so that can work.  Probably better than putting
> the module parameter in tree.c, because putting it in rcutorture makes
> in more clear that it is for debugging.

Ok thanks, just to clarify:

Normal operation is still ULONG/2 threshold.
rcutorture operation will be 10 minutes (overridable by rcutorture module
option, not module option in non-test kernel code itself).

If we are in disagreement about this, please let me know. Otherwise I will work
on a patch as a next step on this.

 - Joel


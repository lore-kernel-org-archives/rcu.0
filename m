Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B518A95E
	for <rcu@vger.kernel.org>; Fri, 14 Feb 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556231; cv=fail; b=YqlQDvYOg7m5+1wYtTVF6CNg+oB0wYa4lTJR8lNLG7Wd3u4jiIPhJDnnlUOQF55/nqERFg63HXutEYr/VuNnw6H5aoWrb9xsVbi83wUy4JQ03lMwIcHv5sv6qHpQ6UOt5D51nRkU1HMZJh47xNGD7y+y+zOfITuGU8dUYQTocmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556231; c=relaxed/simple;
	bh=4GKzgOpRJQDe0ENamDJTQP3ElCAln12vW+OJo8dHecQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFPQN6uQHmWkdO4M5HG5ExAQk6FWK5F/C4Zs/oeBu/jPL6q5hdHMqOOG8CJm1WekKlUAjsXTqMwXXFQcR+AlgIaz56fbDiM2DzlA8z75yKpMpcnt+sfiVw0RsN9Le6BxNV8qKOn7OPIX8q74ZvPbI52ze+UHJMTdxUc/GW3i39E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SDKRu6xm; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDKRu6xm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeiXoGn8Y8l6niO9uh+nF8cl5qHMKg9g5EKivehLIvd2DO39bCSaObvVFEFN5Hatqvwz301chv0zns+aPG3Ul8M26+PhTIAL4pT25PLmrT/qctvPdxuZU/iY+lkpx8/3g4x38BCgrGZ/iQsy0ZOIK/0nkl/DhNlbZoGAwC8dGbGgllcz/4D/0+6QU8WbusYSZvkz+cD50sxCxfT3cyRH7YJiPOhT7UrxAdrK1klDsFXHF5mp3jhGrqNsMjrLaxAhrEFdFwOE/8JfWvJyeGle6mEG/BxkazwK1eRIgq7KTS1BKJUsWXWDszgk1ktNg0iGFejjE1+E40c0/ENTNjQMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr5EeKHHV1qE4NZMsFHDlgfEHaWHAHVGcsZHujCk87c=;
 b=h6aHau7icLVYi3TExIKiVt1Jj+Mr9xUwJL0M8QIRcdWMPnK+k+07MX4FYbP5attie7881R3u3lHQOdoKqw3oxkCvKJrTFPlsugRlR0IsKJcTFWPn6lCiAkf60m0R3ZpVJpmFDtd2dPgstTb/LlnRd914/1GPkrdXengN09NjZyjJNoL1crC2cQ8Txsy3GehRyonAsxCvKrIa9Uu8KeCmvEjfyuiZjgxJW37u0yr+DwVmca0XrLgYbmxF1W7sXy0Sh48vdvqR/AtGktK76eWSkYgK7spPFShExl7hlztvrWQcvYC2Q5Hzq20C559Df6RA97Emza4aMWr/FB6jNjkUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr5EeKHHV1qE4NZMsFHDlgfEHaWHAHVGcsZHujCk87c=;
 b=SDKRu6xm2eWlZ9tNWMMVW2+j7L4z++lqEAIFCJYhqLwLBiF+26GA+zsq7JI0btMU8w4BqqVTlU9v5Mr1rHXNZgn/YuZJ6bsFpe66bznknJ5wQaSe/o4XGOjtNvHcqIhvnAYwVz8KljF51dZzO/2hXUGQv/KtUTk3cyNljMX38fQSYcEFBfoj4VVPoz4Jf2PWkCXaHmPlCuLad1IS3Q1lmamLhfnm5wpmIKeTcQ40wjQp+QZqIjtN8iz8D9aPa6O9nWcTdrTXRYixtWAleu5V7P05RfYEKbcQXiK/M0XDSDeG2cIF6zxpPVs6sKiWOENKYl6Srwl1HSLLk2fvVwxH3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 18:03:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 18:03:42 +0000
Message-ID: <009ef653-f41e-4101-886e-d9a4ce4d6e32@nvidia.com>
Date: Fri, 14 Feb 2025 13:03:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: The rdp->gpwrap behavior
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
References: <20250213183033.GA2635051@joelnvbox>
 <b04b997e-fee6-4c5f-a0f9-12e671d27f8c@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <b04b997e-fee6-4c5f-a0f9-12e671d27f8c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 257a567a-1840-4c62-c334-08dd4d21ea67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXNOczNQRHc2YVdiRndMWXF5eDlCTkJWWE9KWE9xTDVtRVAxdDJMR1ZhUEt1?=
 =?utf-8?B?UnRDWnBnTXY4VkNlUS9NNjlZVXBub3dadi9HejlJaGo5cUJ1N1RGR3ovUkFZ?=
 =?utf-8?B?TnY0Z2l0bEJTOW1KKzNXR2xzUjBna2s3VWEwejR3SXdZNGRyeUFlcWsyWnhO?=
 =?utf-8?B?aHRPWXMyQUxKS0o2dzBYWG1pL0ErNFdYUWZ0blJTbmZhMHdqcXl0TU1veHJ2?=
 =?utf-8?B?NS8wNDZ3L0t3Uk82b29BRFVmUFdUVEVVMmhVM1VjaFprSDh1eHYzSkdWSjZV?=
 =?utf-8?B?a2IzeW1hRUZFVWtLdlMvbmUwL3haTXJ2eUhDYkdKTUFZTTdxUnRLS05lSE9M?=
 =?utf-8?B?ekU2NWhqOUlUNVFoSDBKRkJieDFSWnZDdjRjYURReXA4cG1LQjdBVWVKbmxJ?=
 =?utf-8?B?QjhINkNOY2M4NHBRMk9KTTBwVlZZeHlic0NtUnBOSXRrcW8xL0tYVmQ3S3RM?=
 =?utf-8?B?dHdocTYrQ0VXVzZSY3RLQ0pJUVNUOFlyK2EzT1RCQ3hGL3oxczhVVytFT3Z2?=
 =?utf-8?B?UVpYUlQzNUZrWm5wTUx3UlY5WEpXZjMva1pFTmxJeGU4ck1IZ0JhZ0dzNmw5?=
 =?utf-8?B?ejhEQXlsbUoyMUdaUHpJMURXL082T3lpajNwRjFMZFRGd0sxdzNTTmdmWEpm?=
 =?utf-8?B?Rjg0TXZwOEF5aEhEK09oUFdjNmtTbXAxNERqWU1DTUZBWmFGUWgreVE1amQ1?=
 =?utf-8?B?V1I2WXZLYWtlZnZXUHVGV2xjcklYdDJBZDNQSlJkS005bEc3Q0k0ZkR5bytu?=
 =?utf-8?B?VXY3emJ1dXhmSjc3c0dDVS9vN0lxb2xHZUcreCtoQXFlMVNwaHJNRFJwUTRW?=
 =?utf-8?B?V0oxcVVPMXlyaHIwbWJyRDZLMFlFYTcxRlN3Nk8raUhxcVdyTlJUYVkrWFA0?=
 =?utf-8?B?c3JWczhLQ0RzeHpXSzdoU3FQMXRYOW92a2Vrd3gzaVVvOEN1UmRnYmk2MVZv?=
 =?utf-8?B?NmNhY2pjc3YvK3haOXhOYWF5SElFeHowMEdNczFTUzJVWGV1YnlmWXRjcTBC?=
 =?utf-8?B?YTZXanNnTVhKcEczSGFWMXlBdFRsN2crRE1JNWdVc3pSN3MySGs4UUdnWnJw?=
 =?utf-8?B?N0dMUkhKTDNWdzZraTVOSlNBMkdlczZnaUd5Syt5aGN0R2J5UlgxUXBzNnZJ?=
 =?utf-8?B?TVF0YTdLM0RXV0hDeWJHNmtrS0VyR3I3Z3dFN1dBbTQyNmhQU2Z0bVE4NVls?=
 =?utf-8?B?bTcyQmk0Nk1YWGlveVVNdm1NY1pyN2J5QWdoc2NRK0NWeng0OWNiL28zRFor?=
 =?utf-8?B?N01iY0FpNDd4UmRwazVXUUpTT1JhejY0aDlUS052bmo5cS9aeitlN3JzRUZ1?=
 =?utf-8?B?NGliNGx1SGpYclFZSzk1anVBOWx0TjlxazRmS1YybTdCem9GTEdRdU9NanE4?=
 =?utf-8?B?RFE3VVpBUy8zRjM2YTIxOW9kN2hITyt4czVTVWl4M2FZa1pVaVlZZDZHY3lS?=
 =?utf-8?B?NzNFbnRublFKbDFGd3YxcWlObTcyL3djV0NNWTgwd0wzNjJiU1VreW5zNnAv?=
 =?utf-8?B?U3gvTjFDWG5KT2hsVFh0VmRob2x5ZEpCaWZscVJZVUVmdXgxMlpNRmVkYjBF?=
 =?utf-8?B?QmpnZkQ0UVAwNXltN0VJcmdMcjV3djhKWnFsSllJM2thRjVFVEZTSDVHRzYy?=
 =?utf-8?B?OTNFYTByT2RSN2RYZmRSSEtkdCtaSHVmV0RtOG9GeG1ub0tkUXkrMmxHVzNJ?=
 =?utf-8?B?Z0h6QVdPN1VFSGcvQThQWkdHR3VmVWZtbElta09ZS0RkTE9ZdG1CWi9ZaDlp?=
 =?utf-8?B?MlBieHMzcDljYzludDRGQWFXb3ZsWTZNbkF0UWR4RVZyeGpOKzJCVXRaald0?=
 =?utf-8?B?VWZJbXAyOG1IZnoveHR3QnRCL0ZveGhoRXZ3UlFMdDQ3TDBhS2grWnR4TlRT?=
 =?utf-8?Q?ge8I0QXmKhyup?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlFuT205SmlPVnl0SzBoUmpyNUJrSHlFMThlR3p1cGlEbGNRajhldUM3RTdO?=
 =?utf-8?B?K2FjU2pqVS9vczRHSXFXVmFCSTdsY1lqcXBSZjhOcnVOQU9ESFowdTJyR0hx?=
 =?utf-8?B?U2UzRmo1OHhBSmNWbTNTb1ZyczRyNWhZSktpRDJRZXc2NURMUDZtbGdGd1BH?=
 =?utf-8?B?dk04b256dU9nNXhsVE8wNy9uVTEyNFdxNEprWlZkNk1SNjh6bGlsVUIyQ1dV?=
 =?utf-8?B?YjZOUmlqZ0VwSjlvWGt0NnVFSVFHZ1puSHpFalZGRis5YlNjZXVIYjhjRzdV?=
 =?utf-8?B?NDVvY1BNNC9oemdpaTJiekhIejRXZ1NGbys3Zy9SQnEwMWFYWHNCb3lyR0dM?=
 =?utf-8?B?aFNVMk1ZdnpZMkUyYXBSdCtvbEtYaVZYWjJWSXZKaG1QWTZ2M1Z4TUJhdEd3?=
 =?utf-8?B?NGRUVEtPWnNndGthdW0xSXRtV3dqeHgrbVNNNkNPSTloSjRnaW5xNmVQMlJI?=
 =?utf-8?B?K0RNVFNLb2hleS9MM2pUZ0RhUFNjVlhmMFZydzN3VW1oTnJLYWlOTy84TnJF?=
 =?utf-8?B?Y25abmQ2M1ZmZmlOTnhhVXY5M3daM2pkQVp5VHVNWVh2eG03WjhBUElxRmQy?=
 =?utf-8?B?R3NPQzFTakpGZkRoVUVhQThMWG4wOHJQUCtmMjdTMzNjcE5YcEpINlpBSHQ2?=
 =?utf-8?B?MHQ3NnJSZDg3SlNJaHBWell4cXA0VEVzYklhV0VxTTZvTjhJOXBPR3lFcFpP?=
 =?utf-8?B?M0hOSnJWZWg2N0lFeWR0N2l5cmdsdXRCcGUrVG5IU3VQMXBvbFE1aUttMXMr?=
 =?utf-8?B?MDFZbUFmMUEyVm1kR040NWVxWXZmMi9kRzFyQTlKaW8xMFNCRy9PMmxjM1Jj?=
 =?utf-8?B?aS9JbGluc0l1OWxta0ZHTFVjZDIvU0ZXdkYvWU5UZmZPYWRoSU53YXZ1Tm1i?=
 =?utf-8?B?a1VreUVDbTFXbkhad3dxZ2QzVHE5czRucm1rMFhIUmFpSTJPUXQ0WjhuazZO?=
 =?utf-8?B?RkF6dExYY1Zldm9JSWtQdzdWN3lYRldjS2lPSjJLbkxvNy83ZTgvQ0cxTGds?=
 =?utf-8?B?MzAwNmlESnQwR3RERitGK1p2V1hZcElyQTZFZXZZdVllSnJ4Z0x5MTZjQWgz?=
 =?utf-8?B?cWR4YjJhRnM5eW9qWTJuSnhzbWk2R05kQ0tVZ3ZqaWZWOUdDellaclVWVUFN?=
 =?utf-8?B?K2NMbTFLKzdzNDRMMjE1TmNMZjdUTGR0WU1qQjdOMXlIbmlLWW43SlE2WjVE?=
 =?utf-8?B?aEdXYTNCc1JFRkJtckhUdXkwbGE4ajFYZnlSR3oxcW5lOFF1WlUwOUQ2Y0tL?=
 =?utf-8?B?ZlRValNxVjVJWlZ6Zk8rV3J5MlRSMFhmOUNqN2V1aFNLenBLb2tGb2dHTjdF?=
 =?utf-8?B?aFExRGc0VlVxNmN2akhuV212anN1VVFaNTNIbHNqaE5MNE41OTRESmRVai9D?=
 =?utf-8?B?V2NQVHFlTm9yMm1VeThEb05YNXdRZjQ4QUtxcFN4Y3lvN2NMdDBvS3dUNjJy?=
 =?utf-8?B?dFNMQlFlVC9Zdm80TEl3YlVEYURacE4rQXRNbkdWNUVFNXdwK2ppSGZmb1B6?=
 =?utf-8?B?SzRlYzd5dXl0UHNaYUIyWFRJZ3MzZ1cxQmlJYzJ6Um9FSGZTSkp3TU15eTlK?=
 =?utf-8?B?ZXlkREhqMEIxbm1Bd1hxQys5bDUzM0F3NzNmRStaZDBQZFpPR3hBS1FqbXhn?=
 =?utf-8?B?TEFNVG1MSHd6bVBLVUl2YU8xK2tHTVRHQTBTZ2hQVVdTdzRHeHpUK0tOZVpH?=
 =?utf-8?B?Z0cvRXhxb1ZtRjBjN3FqdUlZK0FjaW0zVFZFU3RCbTdEd1IxUHhNWENBSklH?=
 =?utf-8?B?UGJPcTNtVEdQWFN6anZoSHNCUld5Ums2WkpYM2U5cmpvb2tWWmo2ODhDZ09X?=
 =?utf-8?B?aWE1YThJeEpweEgxZ0pkWVNQRFphV1VqQVJuZFpXbXU5RklDbmdtc3lNbVlw?=
 =?utf-8?B?OEhFalNOMkw0YzUyYzBUdzhNYlZlazZOR1dtMU5jendKTXNaNGNwS3pjVHN3?=
 =?utf-8?B?KzVGTXZNUnlxUnNXbWJ6eFBmT2FKS2JFWS9vY3VhVHQ4blUxQldCN3ZGMStV?=
 =?utf-8?B?eXdVUW95V240eWVNK0V0NWxSYmNONDdzTGFNbnNYNS8xdFN0bVFPZTBPQ2Vy?=
 =?utf-8?B?OERra3NKQkk5Y1BCWm13VXpxYW84a0pOclBhMXNWTlJjRElZRVNkUHBFS3FD?=
 =?utf-8?Q?FpX/2df41iWYziHdbrCBGiznZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257a567a-1840-4c62-c334-08dd4d21ea67
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:03:42.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wwg6LPTpycvRMRCKjlSaaqKjWABwPGD3HZZ+5DGVe81y8gtgZj7bt56IkY8RUynEiAGBh5PujRn1MqSvq43Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Hi Paul,

On 2/14/2025 3:20 AM, Paul E. McKenney wrote:
> On Thu, Feb 13, 2025 at 01:30:33PM -0500, Joel Fernandes wrote:
>> +rcu for archives
>>
>> Hi,
>>
>> Following up about our gpwrap discussions, I did some tracing of rdp->gpwrap
>> with just boot testing.
>>
>> I actually never see it set because rdp->gp_seq and rnp->gp_seq are usually
>> very close.
>>
>> Example trace:
>>
>> # rnp->gp_seq starts with -1200 on boot and then right around the wrap:
>>
>> 178.096329: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap before: 0
>> 178.096330: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap after: 0
>> 178.100327: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap before: 0
>> 178.100328: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap after: 0
>>
>> The wrap "before" and "after" are the value of gpwrap before and after
>> calling rcu_gpnum_ovf().
>>
>> Closer look at the _ovf() shows it should be only set if rdp->gp_seq and
>> rnp->gp_seq are quite a distance apart (say if the CPU was idle for too long
>> and many GPs have passed. This can happen both with/without wrap. So imminent
>> wrapping seems not necessary for ->gpwrap to be even set AFAICS.
>>
>> I think the problem is ULONG_CMP_LT is not really "<" so even after wrap, it
>> can false. i.e if rdp->gpseq + ULONG/4 wraps, it could still return false.
> 
> Exactly, and all of that is in fact the intended behavior.

Ah I think I get it now, so the wrap isn't really about the counter wrapping
causing an issue, but about the design of the ULONG_CMP APIs which are designed
for comparisons that wrap around. Due to this design, there is a side effect
that the numbers being compared have to be at a distance that is less than half
the number wheel. Otherwise the comparisons of numbers yields incorrect results.
Is that accurate to say?  IOW, ->gpwrap == true means, don't compare the numbers
anymore till we sort these huge deltas out.

> 
>> >From a testing POV, the example shows it is not set even when around when a
>> wrap actually happened.  So may be, we are not testing gpwrap much, or at
>> all, with rcutorture?
> 
> True enough, and that would be well worth fixing.
> 
> One simple (and maybe too simple) fix is to add a Kconfig option to
> kernel/rcu/Kconfig.debug that makes rcu_gpnum_ovf() use something like
> (32 << RCU_SEQ_CTR_SHIFT).  This, or some similar value, should cause
> rcutorture's stuttering and/or shuffling to trigger setting of ->gpwrap
> within a few minutes.
> 
> And I would not be surprised if doing this located bugs.
> 

Ok cool! So I will work on this next then. I am curious to see how often it
triggers both with/without such a change.

>> But before that, I am feeling it is not behaving correctly. I'd expect it to
>> be set even if rnp and rdp values are close but we are actually about to
>> wrap.  So most likely I am missing something.
> 
> If I understand correctly, you would like ->gpwrap to be set
> unconditionally at various points in the cycle, for example, at zero,
> ULONG_MAX/4, ULONG_MAX/2, and 3*ULONG_MAX/4.  But this could easily
> have the effect of discarding each CPU's quiescent states that showed
> up before the first call to rcu_watching_snap_recheck(), even if that
> CPU was active.  Our users might not consider this to be a friendly act.

Got it.

> In contrast, the current setup only discards quiescent states for CPUs
> that just came back from idle prior to call to rcu_watching_snap_save().

Do you mean the check of ->gpwrap in rcu_report_qs_rdp() which returns early?

> In addition, use of the aforementioned Kconfig option has the benefit of
> making any ->gpwrap-related bugs appear during testing, not in production.
> On the same grounds, one could argue that absence of this Kconfig option
> should also cause gp_seq to zero rather than the current;
> 
> 	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,

Hm, I think it still make sense to the do -300 even without debug options, just
so we have a true wrap early on, regardless of which APIs we use for comparison.

thanks,

 - Joel


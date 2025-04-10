Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C47284B3D
	for <rcu@vger.kernel.org>; Thu, 10 Apr 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293555; cv=fail; b=E9Kl7GCSoFz8sos8tXKE/jGbeWOQGpWz9HhFJwu4RaNeM1C1yLTTOIsQAV7eMlfIDqRGdiC9EkUNYoNEaO5IOjuTH0z+DiAjkKPSU8I7Td2EycBeKTssTPHBvuosXcOmIb+Xmr28B/RVW8c33xuaPfX2cdBocW7/8dD5RXZKE6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293555; c=relaxed/simple;
	bh=jkPtcnsJBKx4yQgnMjfwG8BLqRQ4OtnItRB8K+74yqQ=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Vj5ogWPKcLIoOsHjGYlhjmbE6MBYi0kUPLq1XeCSPj3HOMJEFnWohzKloEnAM9jAIha3HDJU+pI6CALVagikeVpgfKlNPXR4BB/fENWof25nNu2/kXgUrABqCcmb+/7KYDvw124z0XKZ7rM8PEFdSJxsYMkGE+kCodKPqHCzcx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ipOoU3K7; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ipOoU3K7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNonGL5iPyKtguEJoCmWqS+EYlWy9o3wR3ro73hAMKTmgPAAFLVaBS/jYQm2JZWVpXRIelZqot8xbrgeUWN0mV78OWfyV7HaQZ4b6AIzRohRti51JtT237paAvL/tAUcrp89xPipZJR501LuFvbhuOPnLoDaEqx9oHBOY40+WCwnc7UxibXdgxtWP0geYRKI4zwOsK8IcWtNJp0wLqr2sjW+Ade0xlTsoqSZfPlyO6hPeDzgQGaALQEvdtXytDqiVWAxYBpXvY9m8+vVGe/tfm0gCu5Kr/UbT1/lY272J3LR0l/sTJKzxSSl5dk5eWHcs7/MMfN7016nR+atSt5FGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t+Y/0wzMey4nm9Dyy1xRaeqENcXNpGgKMAFVbtbyNo=;
 b=HVytfsRhIsiIoCrmTVTXlyxtY6YYncwz+mA34TryZGzf2LSMkeu6YbVty9FJZRGjIpwicdU/v4jOty1kxauwKfz6IbFx9Eb5rkwczSF20hW+NgoOq93+f8Q9lbER18WxQHc9lS/pgW8pYy54+krzGPVgoMM06X3lL3j0GwD6VK3V0PXohb3h3wrOJ0kBKQkN98hHA1njSu6GYxVY4FihSpPxt0/ATEUvxGQS4QqqF9u0LiRjPf57dY+LirUbyeCzZX8UWwwVqq1+MKTC5WQChLJzj81HU92Jh6RlVHAse+ufGIr+JNcTFiL9OmX0hLht1azxrkjqM86j8Z0FDSg0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t+Y/0wzMey4nm9Dyy1xRaeqENcXNpGgKMAFVbtbyNo=;
 b=ipOoU3K7Xq1GCdW6XEiljVe8zADvP1X4188GqfVoDEPMa+4Y3W9PZp+Z2KnHqFGN0r7wMaPudGt0ii5EZiv4xD4hP01f9zxfbk/EsW8gZRvLjmCSCjQng8zGi9WsoNxI5sgpXTZJcelU0vK7idevwme2Fp5MSbwThajMwMTjCHNkaUpia+ScxXkOzuNbYZcFGcq/GTpbKzyMHIPep2ia1XrZxxjW0Q1wcPW2ftrlEKn78cg7ZTNF6A9oirgp4RKU+mJLw0g7/58LFSdb/Eqq5qTLvqBGsE0zDXyHcQHxRTayXPj8mmrwkPJ/S1efiZrD1zc6g1qQLgbEZlvRJxUX2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 13:59:10 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 13:59:10 +0000
Message-ID: <a6039f75-3662-48cd-8346-4cb8ac929685@nvidia.com>
Date: Thu, 10 Apr 2025 09:59:07 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Possible scriping bug in rcutorture/kvm.sh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LV3P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: b6927c0e-637c-4cdc-f3d1-08dd7837ddec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFZpS3dTbXJ0V0JxWk1vNVc5WUh2Rmk2SzRKS0M2TWZvNVlvN0I3WFptV1Yv?=
 =?utf-8?B?NWozMzdscmM4Uy9kMTVCM215TE9nMFF1WVhFY3ZHVVZJQ3lqbnRYdExnOEZF?=
 =?utf-8?B?YzZWUEVieGl3bm5GT0JESXFQMnpwZDkyN0xhMHE0dHQvdlRuc2c3TU1HTkpZ?=
 =?utf-8?B?TmFVNU8vUFZ0RFFWbFdRREZCU1FDMjVhNlRDa0FveE00cUNmUS94aFByOFRB?=
 =?utf-8?B?Nml3QU93ZkpYVnJldXJocVBOZ1ZTM0JWTGU1K1NRU2xUOXJWVGNqUk1oQ1ZQ?=
 =?utf-8?B?cVBkYlFkbHowYm5qY2dkSUtXSnRPNmJYQmtlOEtFQlJJbVpjSHVoc2hMY1dT?=
 =?utf-8?B?NXJwcUs5VlFsa0pFWTlSOG01cGUvaDB3K21mdDkyUHUrdTh0UnF4WkhHajZk?=
 =?utf-8?B?RUlkVVU3UFVxVEtFWDBkMzlTUjVPcHlKclpOUS93T0RHZktQeEFqUElDcVFU?=
 =?utf-8?B?UWovQ3Bia1JhMXI2WVMxSTlLdENsR1VIOE1IYVBjcFJ4UXROUW9IZ3VMRytv?=
 =?utf-8?B?RE8vTERqRmlJbnNPeTJscHEweC9MaGR3VEUzSmhBenRjc2Q1cUc0dG9oQ0ls?=
 =?utf-8?B?M0ZlTEFpYlRvREx0UzFUNXhEUnV0NEdPd21mcEhLVlczeUI3Y3d2eGRzTVZq?=
 =?utf-8?B?VDk3bmxIK0VTd0ZOU0xvclFUdnhYUkw0U0VHdE5uSGxUY3pQWEZGekxNc2xz?=
 =?utf-8?B?Unh6akZMNm5wejg0WGdXTHBCeGdheVNxT3NtKzQxbDJlMEoxbGQwbzhMSEo1?=
 =?utf-8?B?cWM0MDZ2V1BsWERzTXAwZVZMbnlCaFlhM3pYcmp3NFNOaTcxcUFyeHBmeTFH?=
 =?utf-8?B?RFF2MUYwbzRFbnhDM1NzWC9RTkJKalJCSnRjZHJOSUJCMXhzQXlqVjhqcmNv?=
 =?utf-8?B?aWZ3OU9BczRmNnNyVmQ5WThQRFZaY2lFVjhvSlVOY0ZJeVduM2VpOWhOekxy?=
 =?utf-8?B?R3hsR1F6R1ZKVmxleitCVE1melpQS1d6MG9FcVEyVllscXd0djJ5b1JFeDR0?=
 =?utf-8?B?NTZCaHNnZ24zbzY0NnpZc0Z4R1JQdGJFTm9XUHAyRkxPaGMvTThVNEx4VTg5?=
 =?utf-8?B?Q1RHL3dWQXpvUGJVNWh3M3J1d1ZlcDVzVDlOeHoyemxmRmxsWHpXRUd6V01E?=
 =?utf-8?B?eXpUNXArNkZEN0JXMytKK3JUS3BGVGtVUTFRdHZ3a2FSczdBRWltbkl1b3Y0?=
 =?utf-8?B?UE9DZnBPWURoa1dsRVMxbjE3QWlQc0RpenRuQnNnSmdzNEExRURDeGk5TFNp?=
 =?utf-8?B?SzlnRXpESWhFam94NFpFNCtwWlhPL2JZL01WdTBPUGpGN05iU0hjbmVlMTAx?=
 =?utf-8?B?U2RaTFVVLzAvUk9ZZXZHcEhZTG4vc2EzNnU4THc0OGhFTkNiS29qaVNMNGtK?=
 =?utf-8?B?aERkMUl6MmgzSFFId295ZWpGSk9LT2dvajdFSzNHT0lLRGMxcThpQ2twRC8v?=
 =?utf-8?B?YzRpUjkvZVQ2c0p3NEthQWJ4aG40L0duMWNzTkhXME92amFYUW9DbDMvajQ1?=
 =?utf-8?B?ZVFHVUltaWdCREhjeVN0VERJWVZJV0hTaWU3emRtZzdoUTdwdFdqZFlRc3JQ?=
 =?utf-8?B?ODFmTmhwdWZDbVRzNjgyOUxtejUvS3dUTVV1R2QvdERmZjQ3dUxxQ2NDUU9l?=
 =?utf-8?B?K2dtRXVXK2ZkbFR6UmhCSFZyMTdvWXhwLzRIdG9UNUFBQlZ2K2VqeTFVV2FM?=
 =?utf-8?B?Q2hWOEpyNlQ2bWZQbVhKdjUrK1JTa254elFMQzdnbkkyN1c5VS83eTkraGZG?=
 =?utf-8?B?YnhnNEVVNnlDd1piM3JVTjNqZ3pYVVFjUTZmZlpqdEVNMG8xWXRDNjRRNGxH?=
 =?utf-8?B?WkFIeWZPUlAxVXFMZHRUUUtpVXE2dUNOMW80bFk2TVlIbkc0SHV4QS9iWFZX?=
 =?utf-8?Q?s5D1LxRRyp4lg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2F1dFlsRDZOenJ6RWxoclkvTUVmU1J6dFAweXpFWUdUL1BpVERzT3o4MG0x?=
 =?utf-8?B?azBCWGZPM01yOU1pYzRvUE5BbXV0QlVlSWllTjJnSXZzZXJjK28xOHBINWth?=
 =?utf-8?B?YjFzT1cwMDJBU0czVEZ6WEF2V2lNYUJVdkZGS1dZRWdhaWVlaGtRUDNmMUlt?=
 =?utf-8?B?V2J0cW5zZUpaenhMSkdLQTdZcXJLOTBYZkVjYUZpZS93blFBVmFBWjJWK3hK?=
 =?utf-8?B?YjBQL2lhODd4WUNOVDcrazM3anZ3VEJ6azdoUHpPQUlZQmpMc0kyMmRKS1Vj?=
 =?utf-8?B?SkZkSUE3N3pRcHI0TTg3OGN0YXUwd0NVZWVtRXREMVVJUnBOMDA3cW1nVVQz?=
 =?utf-8?B?OWpmTXVmYXhIU2xTd3VzbjRtMmU5SVlFY0VUVXBSOUxHOGpYSW4xdEp5Q3Y5?=
 =?utf-8?B?S3d5QlFNTGRVVU1CMkQ0SC9iUXhUTTJRNEl0RnBoWElBQ3JMWVErM0RGNXRs?=
 =?utf-8?B?NFYrdS9qQVpoZ0RQWk9ma0N3S0oxdWRUQk95OFNPRGVpeUIxTHNxeFBEd3dD?=
 =?utf-8?B?YVh0VUxHRWcxRnFxckg4Yk4wRXpNSGdjeG1FQ2RQWXFRalFuaitwT1ExUWRL?=
 =?utf-8?B?aytWN3l3bXVZSmVUNGdiOERxZHpZNmNKek1zWnVuemtuSWZTdlIyQzRiQTM2?=
 =?utf-8?B?L2F3NktzbUd6eVVWL1NQck5EK3pDMHJxWElleWpWcnRKL2QwcVdLUzdhYzN6?=
 =?utf-8?B?cmxic0JjTG5tZUFrdGFad1BkWGVpek12NDhHczFEYzFRUmRFWC9vYXE2YS9k?=
 =?utf-8?B?Rnc0TWdhM2xIb0FiQ1ZyNnloaXBDSkNzK2M3QmhmTFRDVndtRjZXMlphcmN6?=
 =?utf-8?B?WmNBdE1nN3FhQlQ3em1zKzFEOVNZaXNKWWFzc28xeFJ4Rlk1NEI2MUNKMVBQ?=
 =?utf-8?B?YUx5RUNyaVJId0NYV29pZDVqZHBzdkMzZjhHTDNSZmYzcVFVSERZRGtTalIy?=
 =?utf-8?B?eU5Gd2ZJbXBJN091cjd5YmlvbDBKYWRibTVRbytoMkFVU1VKSUR4VUl6cmJj?=
 =?utf-8?B?VEVhTlpqNjZmVnFGYXlvNFRoemxlQUhkVE5SRDVJd0YzSU13Szh6bFZKbTh1?=
 =?utf-8?B?SnZRTjBGeVloYWNKbGdudGMyWGx5M08rR0NGaVVlWmlYZEdmczEyamZ3UGJT?=
 =?utf-8?B?V2hua3ZWazU1dEdxTW1iUEtieXdnRXdYcE1VbTZuR1pLdW13RWd1cWVyQVg1?=
 =?utf-8?B?dFYrNVUybGkvck9Bc0hlMDlna055eWxDQWdLYjdqUjVoMjZpSnZvK04ydWE4?=
 =?utf-8?B?VS9MRzNtTkVQMEJsc2d0M0dzWHhNWTEvK3RVMFRhbXJTRlZxaVhweURsVXBU?=
 =?utf-8?B?QVNPN0dHbjR2dWtGbDR4Vk1lWkhOR2Z6V3M1VDQ5aS9jVlpQQ0VBSVMvV2RS?=
 =?utf-8?B?T1pLaXhKSGIwSEc5c3BSWHFoTklwVzhzeGl5YjZiQm5kRE1CZ2tyWEQraHRY?=
 =?utf-8?B?ZzVHQTBtOGpxcjJtRFUyZ1VlT014Q3c3Z1VvMm1vOUpzeXpBVTJaTlJ5WTRk?=
 =?utf-8?B?dmVZSmJocUxtY3pySThyOXNtME15L2ZHZVFseDlvZ3FEUnhWYmNOc1lLNU5Y?=
 =?utf-8?B?bitoL2tiMk1DSXBvWW5kUVhSWHcxR1Y1d0dnc215aWxCL3NvMktKUElHOU9z?=
 =?utf-8?B?SFY0Y1ZoK2tkZW15bnBlMHZQTEh3a2p6YnVXT0orY0tUdVliZGtoT1BNeThO?=
 =?utf-8?B?QjluY2R6OVIrUyt6dVV0RWNBV0VwUllabEtlZXV0K3BVaFVqeXByZjg1Q1Br?=
 =?utf-8?B?RE0xdzhBbHBySHFxb01lY1VJVkJzQ3Jwb01RVEFnanNKYWlHK3M5cnFpM0JW?=
 =?utf-8?B?bjJQaEZKVE1ObCt1NWI2U3B0cFVEQmViNWsrNUw0aU80SHdROFNVc2oyQVds?=
 =?utf-8?B?WkI1b0ZyMUE3dGlCZHA5ZXc2UVFkTWpCSDBEQy9yaElHd3Rvd1kxbG9GOFdP?=
 =?utf-8?B?bjVjbEFTK3h0L3FzWDE5cThwR3BoeWkwWkNxVjV4MFBHMlFXR3IxQUVtWkxJ?=
 =?utf-8?B?OHZoajI4K0FxNnV2OHVEKzhOeHUxQWNwRXpUbEt2aWhHemRhejI1VTdUeFRu?=
 =?utf-8?B?VFIxMVZQZGNFajA5RU8xVGRBR3lBOWhiVzNUZngzaGZhZmtwc0doTXRLK3RJ?=
 =?utf-8?B?S0ZiMlNOU0I2OTNzWjdBeUErUlkrNHQ1d29wYzR4bUxnQlBEY2hQNVU4S0U0?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6927c0e-637c-4cdc-f3d1-08dd7837ddec
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 13:59:09.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VMvTJSyzfP7aGQyKs8/tF+eh0aikKDsPAuHTd+4B7f77REWcxoBclA3LTpzauX1aGgutZ6oinqtoe0AZl9BcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

Hello,
Currently with my ARM machine of 288 CPUs, I am only seeing 56 of them used at a
time. Any ideas if this is a bug or I am doing something wrong?

I started a batch of 36 SRCU-P runs, which is exactly 1 batch:

$ sudo tools/testing/selftests/rcutorture/bin/kvm.sh --duration 120 --allcpus
--configs "10*SRCU-P" --dryrun batches
1 SRCU-P 8


1 SRCU-P.2 8

1 SRCU-P.3 8

1 SRCU-P.4 8

1 SRCU-P.5 8

1 SRCU-P.6 8

1 SRCU-P.7 8

1 SRCU-P.8 8

1 SRCU-P.9 8

1 SRCU-P.10 8

But, when I run it via:
$ sudo tools/testing/selftests/rcutorture/bin/kvm.sh --duration 240 --cpus 288
--configs "36*SRCU-P"

ps shows me only 7 qemu instances of 8 CPUs each. However, weirdly it is only 1
thread for each instance (thus its not even 56 CPUs, but rather 7 or so).

1496915 root      20   0 1684276 256996  66816 R  90.9   0.2   8:38.06
qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
-machine virt,gic-version=host -cpu host+
1496913 root      20   0 1684276 256996  66816 R  89.7   0.2   8:50.53
qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
-machine virt,gic-version=host -cpu host+
1496929 root      20   0 1684276 256996  66816 R  89.3   0.2   8:44.53
qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
-machine virt,gic-version=host -cpu host+
1496938 root      20   0 1684276 256996  66816 R  82.8   0.2   8:46.03
qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
-machine virt,gic-version=host -cpu host+
1496922 root      20   0 1684276 256996  66816 R  82.1   0.2   8:57.83
qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
-machine virt,gic-version=host -cpu host+
1496908 root      20   0 1684276 256996  66816 R  81.5   0.2   8:50.59
qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
-machine virt,gic-version=host -cpu host+
1496920 root      20   0 1684276 256996  66816 R  63.6   0.2   8:51.46
qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
-machine virt,gic-version=host -cpu host+

Thanks.



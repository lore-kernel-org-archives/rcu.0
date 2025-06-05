Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B6E1CBE8C;
	Thu,  5 Jun 2025 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149792; cv=fail; b=lvzFJ5YQ+lwsQYSvgrR6fDNpcqUP8D/5OM2JoIHDeuwWMzT8+t5sseUELU3cQzByVU9DDholtvcs9ckFzJrwVCAeDyZi+QleYRfC+KC++zad4XQt/1GdA9yAGvdqK4vWS4E0/Qdt1p/0MU6H4TDNoe4sAUNFL3whY2Q6GtIKQMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149792; c=relaxed/simple;
	bh=w9CnRXHRVl+KbS5yoJeqF/gNzNbKGzLOJRSBGWv/SPw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Se334Tq4JBlMNL5FZ9F/SEOa++pp03V6t+dUWC07sDpgy717D92EUV+L0PryuCTkbiRrucGTp2zPgcHRyxcGSd/wx9+DKaNKnCWN92LdaIxMqxIk7vRChHGzjJTX+qBgOr7ohlBbsdtdIin35A7dW/FPHBJNuJ1WvlwE0PwSAsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQct1YRe; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQct1YRe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbvSf0zjb9GiX6ERsxMqVI3+1Y4efd+6chkrQUlyEQIyUJ2JncRIbvJDUVDksmUEoYSi1INARx282h9242g7mSMtgi19cB4avY3mPFAeft/BN1aegVV6IDwnP9JJIdHPL3tvZTHeIy1hysnWOJWvf29stNILqF4whxxJIoAuXAxj7fM9TqlCaIlUjOFTBRO394culj+nSZ6MNljj2dE2vzOUOwby/r9/SKdoZgOsAGPjIOVJbXHC7sBMbHBUcVDFFnQhAHUmNJS70vcWU+1YVfVtVJnFqJM5ya+yoIkgLwXlLaYML4STbHKS7FfRui4Y6Mr4tXImxtyuljEvWaMP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erGeuSBrc4EpvK3Smz47lAhx4EMhqYR2mWPVGgkyXQk=;
 b=wxDmPGdwg75D+AocBmnk2qmHUqu//xcWmx9QJq8G0rSqvLhpQOq21IW/qRMyUPUGJY5HEnoWDM+d6riu2uTBtE77+O5hKDFQHtuFzM5IDRfOdtT+xc5NIMtAY6mCuEss1GONtsrYhQskTS/llVUvj5T/CWLbq6r226roFADQ6qEiM/v14ZpUSXzlZtGR+fwXgmn4EgGa9x9ol6dstaFy4WVqQGwIkmJWC7jiJuf5azJLGjbAJjhbZbZVwX3O5zXpt8LxBOXcxGPmfosWVRw5LwJupo6eCosKHGlSn4wPEaWTMwA/0V1k5ElqslNK5nAwjhvQNbRN5rLlhm9i8JGEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erGeuSBrc4EpvK3Smz47lAhx4EMhqYR2mWPVGgkyXQk=;
 b=pQct1YRe4ncO4Pc4fPKGJgIDBoGeJKMyZIdShZAMfCWJJ9M9Fn1bZwd+uW4wXpE2bJo5jZVgsCrAEFwTqTgAh43RUGfoDOpNFdpU5zkm7CQUtZe85fuqH68mZZ5u1jhSqFVjaAPyHMP590b47s9hzpEgXPR575+E+BG3CF5fPruML7tzJLslXfW0RTZGExn9BCWZF0e3I7RdVRfkHlFaxuZcyboznuWl3hF4ngT2vYkdVMViA/SO3FkN1YcVAWzHP/nrQmeAbP7AAUpvm50YDW8pFEM5sJcHqHyTxmKQ35ZEzHUO8FpqiNv+sxIDnpiMciPcpCU8/xqaVeJQDL5hxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Thu, 5 Jun 2025 18:56:28 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 18:56:28 +0000
Message-ID: <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
Date: Thu, 5 Jun 2025 14:56:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
To: paulmck@kernel.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
 Frederic Weisbecker <frederic@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, neeraj.upadhyay@kernel.org, urezki@gmail.com,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org, xiqi2@huawei.com,
 "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
 Xie XiuQi <xiexiuqi@huawei.com>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
 <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:408:e2::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd3aca2-6323-4d4b-1e38-08dda462adbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTZjKzFwU0gwdUNhVWE4ejN5UGtqcWJhR293YnE1Z3FadXJJeWdoUWs2WVEr?=
 =?utf-8?B?eU84SnN0eDNQc3pmNDBLbkd1cjFBT3dXcDN4bjBjaEhXSDNRNjFpeHNqNVlE?=
 =?utf-8?B?MVR4K1VEd2IyVm1YckliaEhLbVUzWFA3NDM5MFMwaTBiVnp4eHd1a3JNSlRK?=
 =?utf-8?B?K0NDVDFleklNUkI2NGlFSE1sRVJka3hLQWh6YmUzOGZaYTBMM0VOeGloVTFk?=
 =?utf-8?B?Sk12K1M2cVIrc2NqMGRudU9KWVRZZDFMVWxDOXZHVGxjV212NWFJb0JLaThP?=
 =?utf-8?B?cW5rVTJaN1BtNS8yWWVldEZZYUpkeU82UnVITWhDZFk2cW1NYzJRdXdTbTJO?=
 =?utf-8?B?MGlWNXJtRVpXZEtjMVdUWTErUWJFd1pyZTFEWVA5WWxYd2E2MmFFcmZNOTI0?=
 =?utf-8?B?Nm9yUVM3dDJNdmFpOUR3Vk1BYjdlMHV3ejRMV2NsVU9qVisyMjk4L1FYTVdo?=
 =?utf-8?B?RGRVcHJuUlpwUVI4ck9LampGQW55OVZ0cTkxMVJXbEZJRjZoSlpVNHJNN2ZS?=
 =?utf-8?B?ZVg1QUxvdDJyUGtxOGJXUzN1Q1ZmT2pkOGFEYWY5NkwwZ2V2S1RUV21ueG5x?=
 =?utf-8?B?bkE2dVJBNjVXSU5EK2UvZ2JVYTFicmpLTkFzK1dlUmlQRU8vOUhGTlFUdDhB?=
 =?utf-8?B?eWxJT0EzekJsZGJmSnI0cjhmUkhuOFdYd3p6dm14RC91REprendPbXUrWWpI?=
 =?utf-8?B?bFI1ejM0elBEaVFIRmlEWUFSeHNzOGEzcWJQR3RpTHVBSWtoZXJaWWZQSEU3?=
 =?utf-8?B?K1pMUjduanhiRTdKR3REdTZTdTRkczJSanhsdUFGN1NBZ01SVFZRdEVJa2Q4?=
 =?utf-8?B?eVFEUXhKczJNSXZNZU15aFl2eCtKeEZ6QkxUaStZMTVYWVhwNW9xcVBEN1cz?=
 =?utf-8?B?SnJjN1V2NUQrMnZCbHltc0loZGl2WjB3MTloZk5wRURuZU1LVC95cHMxaE1u?=
 =?utf-8?B?M2d6SFhNUXF2ME5SR0VSdXNsTWVrd0svb0w2L29STURPalNmb2FKZ3c5Y05B?=
 =?utf-8?B?a1RwbEZDQ1BBSHA0ZDFjNVR5MmRKMGo4MFNGQjFPSVZNeVVJNVhCcldqSmJy?=
 =?utf-8?B?NXBLRzBVWFZHUmcxdThKa01mbzlYb1RURllYNE1zTS90QWFKcmFJdEtENitC?=
 =?utf-8?B?YzdmRFBFNEk2MjJRWkh0bjNFMWZqa0p2dHgrZW5MWFBudzMvOWNJQlVsVGJn?=
 =?utf-8?B?Nlo3a1lMRTBPaldubXQ0UXZudnY3WnQ5SzNzdUorQXZYbGFOWUhyQWJ5SEwy?=
 =?utf-8?B?dG9YQTNnS1ZmYmFoMnN1c3BjTFJqNFBGY3EvZExLNHA2SDRNUTBUcjNrUEdF?=
 =?utf-8?B?S0lydzZmR0FkRTBhRnhtLzh5a3FGYm5SNHprRkhyeXNzek13OUZ1eDJxUnZk?=
 =?utf-8?B?aEhuQ0oyZGdxNUxmR2pOdndJZU5Xc21BNzJXS3JkSWNDTTdjZFE0OFRFdXlG?=
 =?utf-8?B?cVRsUHJsM055N0g3MmdjUVB2ZzdISkdGVzZMelArcnhaVFZsWWNVZk1sTmgr?=
 =?utf-8?B?b0xISlR6RkRLbVd3VlVZcEpZODNvcDdWV3N0eE5DSFJBZzJnUFg5NFEzT3cx?=
 =?utf-8?B?cW93VjdhV1JvTXJUZVJTQ0swREQ3RkFQd09PN3RrUDQ3ZU9PRFRZZTlvNk1i?=
 =?utf-8?B?aXpUTm1SVm1xVk5KWVpBNUkxMXFlTkw0TXZORHFhbEU1R1BuaVhlUEhLQWts?=
 =?utf-8?B?L0xnaFM5blhyQnFuNUZYRHk5N2FxdUpvTnNJaU4wdlhMeXl6Q3dZRmIvT2F5?=
 =?utf-8?B?T3pNeVA1T29QdHJxNGp6SzNqRTlIYlhldytqNjlUVEoxZG9TcWZlWWlVRGxF?=
 =?utf-8?B?LytDeGRUSjQ2Z256WTZMdVZJdDM5bzB0NVVLVFNtZkUveEdud3lpVkg1cWp0?=
 =?utf-8?B?d0pBMDVpQk5kdS90dllnUXdOSmFHR0pORkN0SUYxTDMvcXEzWVNuSXQ3UUJx?=
 =?utf-8?Q?EfpWQpHHd98=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVpWY2VMQXlqbWtBL1BlRHhXRWE3NElMWVhvUExvdDR4NXc1WVZoWTJvU2R0?=
 =?utf-8?B?ZG1SRXpOZHdQQzJzUnZxN3EzSHpKMUhvNHptZEQxN1RadHNTYTJhU3NtanB4?=
 =?utf-8?B?L1F6SGUxT2RUcEE4a3EyNUxDOXU1eWg1ZThFT05FWGNCY1JVYnRPU0YxdFdH?=
 =?utf-8?B?MStFVmk0djlTRHFabmE4RG1sSHYzdGkzOTRKbUV4T2xhdlE0b0J6RDk0STFi?=
 =?utf-8?B?Z0xhY1YrS3hrclRvTitERUtRU1VsU1RhMDFwdW91eG9Ba0psWnM2dlFXZEM2?=
 =?utf-8?B?ZGh1UG02ZEo4a2JDamg4OXZ4d1RCSmZ4ajZmZVJrSk04a0ZLbWduTlFVU0cx?=
 =?utf-8?B?b3FNekxjYkIyWnkxS1dqczcxcnVvTXUvN1RET3RqRkZqZCtjaWZ3MzRCNVFq?=
 =?utf-8?B?Y2Z0YkFMajIxYUtDdDZFMHZJRW5rNWVqMWVMd1NZcGpKbkdNUFMyMkN3cGVZ?=
 =?utf-8?B?Z3VMa0lFejRYK29UWXE1SGJ3bUZ0OGYwUnFlYjFZZU9RejlMTEhlL2h2S04y?=
 =?utf-8?B?eDhZN0NTQUticDRQall0VVV6Vnc4b3VXRDh1bzNCVXFwcmtTdEY0NzExdnFQ?=
 =?utf-8?B?ODFFMGZ3aGJxTjdidk9sbzA1VzQ2dzlNTVhRMm9zdGdkT2prWWFHdG53RWw0?=
 =?utf-8?B?TXVuWkN2c29XSldMamZweXdudjBZeXQ4LzcxRlNqWVBheFlBVEgxdlFBaXVQ?=
 =?utf-8?B?SGZMenl4Mm9OMnY2QUFUcTBLR0x4MkdhRFZQVmdoRVFmVkZqMEtjcTdRTWpq?=
 =?utf-8?B?YVlscFcwZ2Y5YTJoaXcvTUowNjltRjNZSUxOcW9kcXV2ZUlRODVMcEVESFNQ?=
 =?utf-8?B?ZmI3QlIwcTNtQXBRZ2R5ZmxqdVBxUXk1SG11a0J0bWl6VThtakdZcWxXM1Q4?=
 =?utf-8?B?dTJTRzZPTlJ1ZnZLTE53UVVHbG1jclVQWDJuMEl5VEtSeTNUZXd1aFVvU0RN?=
 =?utf-8?B?aHZjL2JDb2l3Ry9odlBqdFFrUjA2aDFQV2ZKdSthRWE4cWtxS2s0Q3plUHZ2?=
 =?utf-8?B?Zy9YTGZlZWpzc0NVUlBmMVlTYUFMUlR5MzYrbGtIZ3RZMTlSMDhMS25rU1Zl?=
 =?utf-8?B?QU1kYlRmdS8vK09RdVZ3OUF5NGxqeEhySUZrUlhiS1A1NWYxcnBxVklZWjVo?=
 =?utf-8?B?OHhiNzN1L21HS3EyRXNMSWtkN3hEckozYUUrOG9USmlGN01GNTRER0tNK082?=
 =?utf-8?B?UHU2c016NVNoYUo4SzBVL0VtVkN3MVRzMkFZNEwySTd0RHV5QWFjb1oyMEVv?=
 =?utf-8?B?V2ZSaDhrNnQrSTRlTHAxNXFmUWY4RnlHR2ErNi9jYTZkQUhkZ0d0eGpwYU1L?=
 =?utf-8?B?RFg3eEVNQmdCaEl2NldmRytnMm5menhod2VyRFRLZ3pIeHBIM0RmVUF3czls?=
 =?utf-8?B?UjIzQVg3WFcxNVBlVDF0MTVPOUI3WldmRXh4dXFzK1E1bWkva04xT1UrRkhs?=
 =?utf-8?B?elBRcTV3ZmMwVHF5Q0ZrMktUSjVBRy9RK3pEamxqRHZpK1lzbkdBUjFNRHNz?=
 =?utf-8?B?QjNYU0tUS3hZSDlOcjB3aGYxc3pUS2c2eTNpem9UaFZmdnVoQ2FhYk9qaTVM?=
 =?utf-8?B?Qm43TUpMUUFObWUwa201bi9Ca3doV3NMZ2x6bUlQRlJtYXdCeVBqdGpOamYv?=
 =?utf-8?B?Z0QzWEdGRCtPbG5GTGpXYjVURnM3blJ5dDJGMU9FUUZJeTQrVmNDMWpsVmJE?=
 =?utf-8?B?QUZpU3RhRDJvZVNoOVVPWWloaFlMZW1Sem5QcHlEM1V3MnJia0oxVGo5d2Fv?=
 =?utf-8?B?RzZYbGpnaTRPNVdiZG5GelRQY3RqT0gyZkdLdmdJbzhRTXFqNXhUUngybWJ4?=
 =?utf-8?B?UW1ITnJlUHNKZzNoNkdIQ0R6TjhuTW1EWU1ZQ2ZVeEtqbjVhR1dBTkFvQkNt?=
 =?utf-8?B?bDlLdXlYRXNJVDRWNVRxSGVWdkFVUXJFMFlHOFg0TzljU3FvaXNMTTNlSFVq?=
 =?utf-8?B?ZEtnYjdIYUFQSFduaklWMWF3OUVPTitPN3ROODd0K0s3WVUxYVhORnB3azBi?=
 =?utf-8?B?NGxIcVFDTlY4Kzk2ZXIxdW00MUUrRnlqV2RqSWdlUG40YkhVUHpOdFEvb2pl?=
 =?utf-8?B?U2U5K1BTUWk4YXJReHJtY3FlZlE2bGxFcktXU3hJM29hMnh3N0JHWlFWUHRU?=
 =?utf-8?B?SVcrcjQ1Vzk4eGZTMmNuNzdxNDdWT1NMeEFmREVZSFRaS3o3UWxXZTFtci84?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd3aca2-6323-4d4b-1e38-08dda462adbf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 18:56:28.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfgGsEP6FMU1RgfZdheE6Wb2n7eB6H8jqsdDqVx6r3kg7CJIIfLWKCnfY2ruRzCPiEkFVSDoScv1ngGL4jTiSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344



On 6/4/2025 8:26 AM, Paul E. McKenney wrote:
>>>>>>> Or just don't send subsequent self-IPIs if we just sent one for the
>>>>>>> rdp. Chances are, if we did not get the scheduler's attention during
>>>>>>> the first one, we may not in subsequent ones I think. Plus we do send
>>>>>>> other IPIs already if the grace period was over extended (from the FQS
>>>>>>> loop), maybe we can tweak that?
>>>>>> Thanks a lot for your reply. I think it's hard for me to fix this issue as
>>>>>> above without introducing new bugs. I barely understand the RCU code. But I'm
>>>>>> very glad to help test if you have any code modifiction need to. I have
>>>>>> the VM and the syskaller benchmark which can reproduce the problem.
>>>>> Sure, I understand. This is already incredibly valuable so thank you again.
>>>>> Will request for your testing help soon. I also have a test module now which
>>>>> can sort-off reproduce this. Keep you posted!
>>>>
>>>> Oh sorry I meant to ask - could you provide the full kernel log and also is
>>>> there a standalone reproducer syzcaller binary one can run to reproduce it in a VM?
>>
>> Sorry, I communicate with the teams who maintain the syzkaller tools. He said
>> I can't send the syskaller binary out of the company. Sorry, but I can help to
>> reproduce. It's not complicate and not time consuming.
>>
>> I found the origin log which use kernel v6.6. But it's not complete.
>> Then I reprouce the problem using the latest kernel.
>> Both logs are attached as attachments.
>>
> Looking at both the v6.6 version and Joel's fix, I am forced to conclude
> that this bug has been there for a very long time.  Thank you for your
> testing efforts and Joel for the fix!

Thanks. I am still working on polishing the fix Xiongfeng tested. I hope to have
it out next week for review. As we discussed I will split the context-tracking
API into a separate patch and will also add a separate documentation
comment-patch on why we need the irq_work.

thanks,

 - Joel

Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690A16E863;
	Tue,  3 Jun 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977420; cv=fail; b=eepJynen4GAtPPcdmMqBwrNX1cylabP7JW/FfZ6GvAeCurPbBmUVMQ1lwS9MXm+SZx9tgVYhO2F1PR8E9LUAlypAXCuTXiUhjtDlic/FvMMxkx31qW6NMfZwTG63zzkc2eR3JVNpXgGPnl50rUZKMhpgABkDkWFpSzLlBrwtsBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977420; c=relaxed/simple;
	bh=IKzVBhks7N0s65in8bEQIh8J3OQAZ2/T/a4p29WgELM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nfd2sKoruI1cDzEbFobe1xpccEWl5PIhwOFR5l7iCXmDUGdocgBWM1o02ZaE3VrV/vPhCzplu/y7PsFonR1j0KRmLbrGhpK6DshdtbBg0stYyzUiKKHMIEZ28y08/IJoniaY2xtUiKDnvNz31GbSGMOd/bV/cRtZkS/eq3o67Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=biiQBts7; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="biiQBts7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMaq+dHyI7hoEF+opr1JZxNuU1W70Od8N2f3CUY8DjJf+JSzFmjUUrqRHRB1xHiuOmbwnsSqDNtS41nXkpNEVi0Ut9VTHT4RTrrD8NJz1AnBTFiJt6CW8Yl8obItVbhpet+eloXYIuUgOEeCM+ulUyTYewRJ8MhPR217/zOgPoQusQxiA5ofm/8DVV0VQZPdLEK7nUpogE7Zy2QYpjSlpCuCD/M3nTi9mRUcUPQpnhJnEyzxrdcDSFm2Rk+9eMXenZR4XazSVzQ7q+1ZyRXkqedGJvzr8EoNJo/sc5bUHkBZY3UTGeE++U4tNH9n+Vth3zXhZ7QCUrGUheS9+c5vbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8ZWzRrXXK1Ok0ByhkPeT9EeT0tpWfARxPTumTiToyw=;
 b=EU3JYQNGDNYNS/l0ifA5bu3gu7s4LFDZWfFCSQCi41EurTkvw6DMk2KQYBsI1oa/kRsI6+SZSq2/oQHDEtflXN540/HR1ubGowiB8jRIXP0wP9wn2OT9CLkTnFmIhf1UxRdH9Q9xKB0tqhn0XFZyy9pWGhnJL0BgoHj4ikmfTJX/nD2akMxFaHDs8qJ3rLYI5gdYLMoQWl+Qj7LEx2gtqjPQQou94poVIz8ykUmhl9Zh/WpB7XCf3QC+sacQQc196Uh6c2I7o7LHXvoh5IlfcOkDEHAyPDLRC2N3QmhN1c7eu0JSg74yypTmwxGnJ69Y1lbKXq98bdXbRtBIQtlv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8ZWzRrXXK1Ok0ByhkPeT9EeT0tpWfARxPTumTiToyw=;
 b=biiQBts7KyK1qTf+hNPQRRkyIbbZYvo0f+whIatYYcE0sV1wjcfnxAIFSRF6LjxmIx03qHSE+jw8XiRxOy9ZHKvBdOMljtdbqPNrE2lyekPXHi127Hmsam4ItEN1hrXp50AvaTnLWejaoL5zlQPWQyAqZkNdhj4vy3upwmMAD7SIrC6+PgzTqXA2aKr4i6bfa5flOAFZoWtFrcltWaClROWiaVVIOQ4QGGNlJFFWg4WSwsm3abOiWLcSbMs97ovHL19gKH/DpOj4KmcS9cExIbksTy4KaNpAXX3s4WNdMAr8nrsqCloJFWCNDemg/GSX3oTP78r87WejN2AeMrTJwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Tue, 3 Jun
 2025 19:03:33 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8769.025; Tue, 3 Jun 2025
 19:03:33 +0000
Message-ID: <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
Date: Tue, 3 Jun 2025 15:03:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 neeraj.upadhyay@kernel.org, urezki@gmail.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiqi2@huawei.com,
 "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
Content-Language: en-US
In-Reply-To: <20250603185939.GA1109523@joelnvbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0304.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9d6318-45a3-4f81-17ab-08dda2d155dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0d0bFVMcmpjUXk5S2JQWkd4RHRkY0dDVVNaY1Z2K3BEVjhIL0ZiQ3R4UTk4?=
 =?utf-8?B?Rmh1cGlWR2krWjN2eXlCY3V3a3dZZDAxdzBhMTJkLy9EVHRqVkN0SFRRdHdy?=
 =?utf-8?B?NW9YZXNqRkwwUjczOGhsOVE4UUtySnR3NHFzZWIyZ0lLeVpvL01DSXZKcVA1?=
 =?utf-8?B?UTdOYXpTeGFCZ2JPSnFCRm5RUzNDai9QSVlicG1YNWQ4d2xxQmp5ZC9ia3FL?=
 =?utf-8?B?TlRnZERjTWZIZDNPK0hHYlFORzQvVDZRcVhPV3dKSjBSMWc1SEUyK2gwL0Vw?=
 =?utf-8?B?aGZxdTdZZDFPR3VNR3VwOEpVV0htalhLQ3M3bVVlWG5MWDhkQllHdWN0OUNw?=
 =?utf-8?B?dzFUMHQzYnBhQXFUcG1LM3VrMlFNOENWemlUQk1GUEdyTmNlaXdLZmRZZ1g1?=
 =?utf-8?B?UW5jaG1xQ3hJUGViTEN5ODR5UTJ5R0RibUNVY2JRNEZiT0ViUVVzMGxLNU5u?=
 =?utf-8?B?b3AyRjV4SElILzh6eGFYbGhsNWpFSlJCMmk2bEJabTlQVGpHaGE2NENRWGNS?=
 =?utf-8?B?dGwzVHFIMVY5MjZzL1FkbGpER1BVMXBnd04vNWZDTStndTM3NktLRzVZUUdN?=
 =?utf-8?B?aFUvdWpEcGQ1QTd4SEFmbndML2dPL1g4QlZtcXZvUzF5TGtjbzRhQytEQkdz?=
 =?utf-8?B?UzRyb3BQVkEzcmQ3dVFidnF6eHl2Z1pnbG50bDFVa3NzVEhISVNIb3FVc290?=
 =?utf-8?B?b2ZXTnFCTE9GY3VrZmZ0S0xTQUlJL1VvM3ZmNEJHbktvcjFhSlpOMGprZTRC?=
 =?utf-8?B?RVc5QW4vc0lNNGd5RURtMGZ6M3Y4MmNWc1Bpc0JGclc4bjR4b04za3dEUlgx?=
 =?utf-8?B?Rk8xTVMyb29CMDN6a2JZb2wrdWFiSG9KZndobEtZSWZOUWJFcVFyTDlRdldI?=
 =?utf-8?B?SCtNMVdTQWphNGV4TDA1Z3M3RXI5Q2Q1cW1LdnMyandUOGROUnV6emlnVVg5?=
 =?utf-8?B?UDRQT3hWV014V3oyMUVtUWMxalVmc2NUNGljYVBjbUh3aHBYSmNYQjM3NDlS?=
 =?utf-8?B?dmE0SGoxcm5xSmdWaTR1R1IrcmRIMlBuanZXbmc5azJWOEhOR1I5NDFUSFF4?=
 =?utf-8?B?bld5TkVpbm9EVm9qaTc0YjIwY1V3a0JyZWVYZWhVWERwTVYwTVhTdG5HMlRu?=
 =?utf-8?B?Y3I1TXZJd2EvNmd2czA0dGkzZmNBMllUbi9zd3FRSk9sYkcwTXVXb3lMNnRp?=
 =?utf-8?B?OSs3aXREd3VLaHpIYWRKR2dxRmVleWdscDM4UGp4Sm5VVExGT2czYjRxQmdB?=
 =?utf-8?B?Z1pPcjFOVkc4TTYwWkwxcmFSNnJpZDMxSXZVWTBQMEN6YlZFTE8xMjJhSm85?=
 =?utf-8?B?ZkxvYnlOVjBFbWRCRUQ1dlBpZzlreXhyK1FGRzlTaGxXR0J5S0F4SUl1Rmgz?=
 =?utf-8?B?KzNxbTRMdXhqQWpwbUtSOWRnMW5ueDRZU3MxVFdzN3pZN1h5b3VvdkVQQmVm?=
 =?utf-8?B?MnEyWFNnM3ZzRTNIQVBTcFF6dERxU3dvL1N3MGFvRjRZSm9Fb1piNzhPdDNJ?=
 =?utf-8?B?NFhxeDhkY0xSU0VXNGprbWt2WTZTanpURGE3L0tpNXV6SnNvV3dPZzJVd2Ft?=
 =?utf-8?B?YVo3UjIyMFgvUURkRjMwMnVuM0gvaHVieGJXSGdsZi9wNThxZDQ0eEdhT2xL?=
 =?utf-8?B?Y1RkdUN1QTRCNG1IU28vTFd6WUNDYy9zaFdrSFRDTmtpbk11ZTNObUxPSGpU?=
 =?utf-8?B?QlZjc2tLNDBQVU5DYVVNZWVTbUoxRzd2b0E5NnRrTXBWS2hQVVZEUEd4Q2VI?=
 =?utf-8?B?Sm43bENlam95SmlVQ0FmRzErVUh5ZXJ6eStXTDhLbkwyY0lpSkcrV0czSlMr?=
 =?utf-8?B?dXpjck5yZ2VYMVpsZGNxMnFaUS9XZ2cyc0xJOEFZaXMzODJZeW1ob1RBZ2wv?=
 =?utf-8?B?MnhwMG5JNkQ5SnJtRnRidHcrcWtFMGJqQ1dJeDRsU1llLzRubFRyTXpWN0cr?=
 =?utf-8?Q?8/qEIY6wezI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGoxM3BZbi9FTFlkOHFDZUN0ZEc3Mjg4UGFvN2tUTkFqYmU0TTZkbHM1YklF?=
 =?utf-8?B?YVVNQU94UDVubHJYUWtzMGJhUXVqRDIydlBPc0ZwTlFlaVRjWVorbk9ta3Rj?=
 =?utf-8?B?TThQNjlKNXg5K2xsL3VVL1JsNmZDUFpIQjdkc1k1ZCtwTWNiREszUURvOHZh?=
 =?utf-8?B?ZXJMTXFDZ0VmZ0FmUGR5TnczNHB2dnl2V0s1ZDUvYk9ubHJFMkZLMlRaR0hJ?=
 =?utf-8?B?NlQySSsyekk1TlNVMmNpd0kxYTRRYTRSM1FFVEtOdld0T0ttNVFxcDVVOVlN?=
 =?utf-8?B?NVN3SzcwaU9tOTFZVE9uRGxUZHpzMmR5OVNkMFR3VW5uL0NmVSt4NGorRGdu?=
 =?utf-8?B?VWhRTUZsRUtFYm1ZKzllVmY2eXlKeG5meCtoV1kzUEdrNENTZ3R0SEkrNjZI?=
 =?utf-8?B?bnpZWFlEK1FnWDM2RCthcS92UFJjUjdMajlLT0R2YXpqeFJ4aERPK05Fd3VE?=
 =?utf-8?B?aDh1Q1ZLWUJyT2lMSVRVWmJwaml6aG5MS0ZRdHErMnZacm1meU5sR0RBSzV2?=
 =?utf-8?B?ZEFyVXdBTFdKRVVwaER4WlU3VE5iWVMrZ2dLYzdqK2dXb3BsYzZnTmxRLzVt?=
 =?utf-8?B?a1kyZFM4M214K0ErRldVb01WSnZBT0pldnlaRFEwYllGczd0T1RxV2UrL1pm?=
 =?utf-8?B?aHR0Q0syd0ZORDNDWE9POEZqMGJRdjlEOTIxdXdGSFlsSW9kUGdQTlduQy8r?=
 =?utf-8?B?bWhzOFlETHA0cGtIMjBGZGlFVUNrejhITUlQNjRsWlU2WFZOQUwwSWZWa2pH?=
 =?utf-8?B?a1R2eXFrT0d4NUpoaG1OTEs5T2ltcEdjSC82cXJzdHIxTFoyRjhETVkwTTNR?=
 =?utf-8?B?ZmVtbHlSYVBSL05YNFM3N3pGYlZ2Tm5iSzNlSmMvcGxtY2JQbXFmRUQ0aVhv?=
 =?utf-8?B?d0h6Wi9Ta2FxZ0ZIT2Fzek1GM2FWcjdkdXNjbWVIcCtXRHk0am40a3ZSVEpK?=
 =?utf-8?B?QjBtUDRLYnI1VWlGZW1BM21SZE9pZDkvbFNIa2ZodGZWTC9PS0YzTXVqMEJE?=
 =?utf-8?B?bTJOS1AweWw4NWtmMDR3RExBbmcwM0FqS3RYcUYrZjFkZnlJcVV5dmpZRm5n?=
 =?utf-8?B?UlRMZkpxc0Vka0t5QkF4bkkxUmZpemtjRlJOUmQ0aFV5dWZmMGxISHlYbCtJ?=
 =?utf-8?B?Tno2RzlCNjV1UTNEMWtieU9rY1lWNktkRkpoek9KMXpZVDUxZWtSYSt2Mi9E?=
 =?utf-8?B?RUdGZUxoWG5nTXBaeXp0d2w3dXhUeWVGaFlvcEZjeFVwVkVIL3hVQjkyUlBL?=
 =?utf-8?B?dmtqSktSVjNaTXB2d1QxRlpKbTlXZ0hCUzRyOXBLYU1yS0ZxY3poNElTYjAv?=
 =?utf-8?B?TFJ4Nkk5NGUxL1hoVUIxbks4bDMxYTZYMVk0R2RCM0QvQkZjRUxCTStWamF5?=
 =?utf-8?B?emdSS3dCRmNvTXZQQ0gvWUphVHdPa1NJM3lrUTI2RUZ6bWJMbEQyMWo5SE44?=
 =?utf-8?B?WXJ0NVNQR2Z0VWxGWVp6Q1RCRjQwQy8rcDB3Y3F6TlUrV1hoL00vbzQ5QWZs?=
 =?utf-8?B?Tnl1Sy9zNDRzdU4wTjhQRGZxNktKRzVINk0vSjllNk1Kc2dBREJiMXJTeWZm?=
 =?utf-8?B?WUVPSFJmWFVNdmtuNnlXZGlKNW9TZkR3SmhsejVLRFk5Ri81cUlXdWhWU2dx?=
 =?utf-8?B?YzZseTl5eDdjMVhEMzl1aEdhSlRwTUNKT2I3VW5ZZFVFYkpVdEZyQVNUN1Yx?=
 =?utf-8?B?ODY1SExRY0dUVzk2V1kyVlZKV3AyMW81U1VXUmYwVXJ6U29sZDJyeXRTSEY0?=
 =?utf-8?B?MkI1U3lrOVpiZVl4SktGZGRPWE4xQ0ZrNDlCS2NXeFVQZ1NOY3hmTVNrQUNZ?=
 =?utf-8?B?cTVUbUp2bWNCSXNZNXVFc0l1dWl3b2QxenZaNnIwOTJocUlJNmRkYVRGSEdx?=
 =?utf-8?B?UTVkVHhBS3NZUGM0a0tKUlZwZlhhQW84THB4Z01UR040VWpleS9SeW9BUHR4?=
 =?utf-8?B?cWQ5SS9BeDZmdG1VMEM3SDJiVGJQK2p3VDJaeXNkZWNMdlRYRXpxdnpFNU00?=
 =?utf-8?B?TU5OSkJuMSsvR3pjUkd6ekRYZDVxeWd5WHp1enlObklBMjFYMEdsb3FOYjVl?=
 =?utf-8?B?REZuZ1psd1MxVWZ1LzlPTlE0cldZK2Y3L2NRZXlhSGlVdU1xSW9VOWF4WG1T?=
 =?utf-8?Q?c7LarKVQHGHfqXJ2iOFYgsG+7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9d6318-45a3-4f81-17ab-08dda2d155dd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:03:33.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhColUg4Ld/XacZJaJLVveq8nrwzPO+Xe0T4c31WoPMGUHRCRbG6rU95R6C9wnk7AbY7jUW1Rl1ztmL3K3GYvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018



On 6/3/2025 2:59 PM, Joel Fernandes wrote:
> On Fri, May 30, 2025 at 09:55:45AM +0800, Xiongfeng Wang wrote:
>> Hi Joel,
>>
>> On 2025/5/29 0:30, Joel Fernandes wrote:
>>> On Wed, May 21, 2025 at 5:43 AM Xiongfeng Wang
>>> <wangxiongfeng2@huawei.com> wrote:
>>>>
>>>> Hi RCU experts,
>>>>
>>>> When I ran syskaller in Linux 6.6 with CONFIG_PREEMPT_RCU enabled, I got
>>>> the following soft lockup. The Calltrace is too long. I put it in the end.
>>>> The issue can also be reproduced in the latest kernel.
>>>>
>>>> The issue is as follows. CPU3 is waiting for a spin_lock, which is got by CPU1.
>>>> But CPU1 stuck in the following dead loop.
>>>>
>>>> irq_exit()
>>>>   __irq_exit_rcu()
>>>>     /* in_hardirq() returns false after this */
>>>>     preempt_count_sub(HARDIRQ_OFFSET)
>>>>     tick_irq_exit()
>>>>       tick_nohz_irq_exit()
>>>>             tick_nohz_stop_sched_tick()
>>>>               trace_tick_stop()  /* a bpf prog is hooked on this trace point */
>>>>                    __bpf_trace_tick_stop()
>>>>                       bpf_trace_run2()
>>>>                             rcu_read_unlock_special()
>>>>                               /* will send a IPI to itself */
>>>>                               irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>>>
>>>> /* after interrupt is enabled again, the irq_work is called */
>>>> asm_sysvec_irq_work()
>>>>   sysvec_irq_work()
>>>> irq_exit() /* after handled the irq_work, we again enter into irq_exit() */
>>>>   __irq_exit_rcu()
>>>>     ...skip...
>>>>            /* we queue a irq_work again, and enter a dead loop */
>>>>            irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>>
>>> This seems legitimate, Boqun and I were just talking about it. He may
>>> share more thoughts but here are a few:
>>>
>>> Maybe we can delay subsequent clearing of the flag in
>>> rcu_preempt_deferred_qs_handler() using a timer and an exponential
>>> back-off? That way we are not sending too many self-IPIs.
>>>
>>> And reset the process at the end of a grace period.
>>>
>>> Or just don't send subsequent self-IPIs if we just sent one for the
>>> rdp. Chances are, if we did not get the scheduler's attention during
>>> the first one, we may not in subsequent ones I think. Plus we do send
>>> other IPIs already if the grace period was over extended (from the FQS
>>> loop), maybe we can tweak that?
>>
>> Thanks a lot for your reply. I think it's hard for me to fix this issue as
>> above without introducing new bugs. I barely understand the RCU code. But I'm
>> very glad to help test if you have any code modifiction need to. I have
>> the VM and the syskaller benchmark which can reproduce the problem.
> 
> Sure, I understand. This is already incredibly valuable so thank you again.
> Will request for your testing help soon. I also have a test module now which
> can sort-off reproduce this. Keep you posted!
Oh sorry I meant to ask - could you provide the full kernel log and also is
there a standalone reproducer syzcaller binary one can run to reproduce it in a VM?

Thanks a lot.


Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC28341061;
	Fri, 19 Dec 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157250; cv=fail; b=ql8wDkzkKJq4bOATEtPBLZYVf6nzJk8I3gykQq3SnJzMlKoy+FvIFMCvCzYNSxB/TWDJFbFIkA6Bfy3bYL6hVpyJrArZfg96XnNhhmNxS3xgq384EAdo//tzNnajt8+6JaY4QqPEjqs7RXlEkswXxr2sThKCIy58eaYufBjy8AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157250; c=relaxed/simple;
	bh=9UEQOvEAoFj9K5OH3bzK0Qml1mFPFQUCGUM9Q1ShJ44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H6qJmmPXHVhLOAoiqqYEMg8ricTSoxQlYkX/xrjPA7DlRk4f05SLduwy69T7STPR8IiVqIBymag4q5hiIF9MRWzTz6r1FvcA78KjJgeEtiJpyyU9BocL5dZxcSlYhnPj3r3cJyLjCzPyh5uvlMlIfAgqKB5dBZGrHMGV1k7CT6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nozYgbPT; arc=fail smtp.client-ip=52.101.53.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nozYgbPT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtCqGCIl/JcZQRrkXpW4OEUhi39oA+e9DwLOXOYfkviSM1gNaKhVqxfIoWm00VYXDefESQJo5qzC3lxCYd6SwEZuYf7Hqt4FuaxAH59rkFP1L3jvZqcvCWnGBrxKodZVXx3baKZHkHvD3v1bgpQUWXWTHpsJrobnHvwpDre5h475YBWq/ZnZqF0g1s51TWiIS4mNspumcpLOq8k7DymvixYphN9bt3kzvuSuyChpQfvw0vNdw2p56vvbdActvP+Yy1gw/fT9j68ursDTDuS5shoxTG+FKvGQybDMgDDOfZregZEqjzmOmyX3/E4XpHxFeiZhrJjMrxbvFuHP1rJy+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5czAud0UBEkvOtacdszMQ7K3bMwg2uTxXVEm0xRzxk=;
 b=L805FYl1qSEkBYQ65oXVzf9myZm3aV178vLSOCECzAj7jXwnoIGUELtad2Yvxv0yy5l8+59Pbgu4mgJDxKwScvPfrt0XOHbleHuqhAzafusCTRN4nhm7zcsjD/8dcokf6NGyiJ6cv21Bc2qXZpOUj5RhgBGBeSnhSF6YvXfLZBwFIDLzied8tW8kCpEaFKptoJj/Sj8HImS1xVtCI+/LDBdivpg4jSjj3/jnnFYj8wCW5Ykq8dBbftg5rUzHHPfCAP+su1zjiDPmIFnyOO0GGwikc9gOv96HFV87wRB0AjrCErxwpi5b0ty66fHEHWKGr6nmIv3f/vgHT6wIJV9/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5czAud0UBEkvOtacdszMQ7K3bMwg2uTxXVEm0xRzxk=;
 b=nozYgbPTCHbasyqt1ag2rIV+zSshqNAFfrS18bFKVzES/RTwib99MH8yklvlsg/G/xvG2iLCTzXQ5A20ulwhhMzlPco92cW5Drqd+Mk5ShaHJpbZOWKQxR/uzNcz9P11qr8jXYRZiq7K9eL1GwhNTqGw1jqi8OtdN5dQtx9+a30Ptd/79RxhJPtQdnrk4r4RIto7VRF43QStUMvVhhetlFIP35PQMVWux4pkdbEUmpMsuqeBz92Qc+WZdbVMsvBckmAtK2bFZ1maugnPZP3wQTs4kfwGz5ABUBQWysSBGdhe2xm0ce/FSYdKwJEkHJ9fz5vgRg2uCGAXZ+hvFTHVnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 15:14:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 15:14:03 +0000
Date: Fri, 19 Dec 2025 10:14:00 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Yao Kai <yaokai34@huawei.com>
Cc: rcu@vger.kernel.org, liuyongqiang13@huawei.com, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org, yujiacheng3@huawei.com
Subject: Re: [PATCH] rcu: Fix rcu_read_unlock() deadloop due to softirq
Message-ID: <20251219151400.GA820904@joelbox2>
References: <20251218074950.1936014-1-yaokai34@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218074950.1936014-1-yaokai34@huawei.com>
X-ClientProxiedBy: BY5PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::40) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 557bcb23-e88f-4406-d44f-08de3f113eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cGu6GustmKHvdguKNJwHsoGQ7fpGyxPsigkCdEN6MGeQ24hW6VD6/zx4BX/5?=
 =?us-ascii?Q?SV+mR+d8ANtp/MiJObTm3Qi71jt5RIJxcIGa44YJv0TM2CuBLf9LYx3rNY4v?=
 =?us-ascii?Q?wiU3QIuHuQrpLU/15PYfLGAloBA0ZcAxHP5w3DiyF7KMEctJ80J9vDOgMLqH?=
 =?us-ascii?Q?PsKQwZSa6t2Cn41EmMUqRem7QXBYENPdYKmrdpnDGpKOjcVKFF40XM3Q1gi0?=
 =?us-ascii?Q?1Nl6lS052sUbVLuxht/UiasApgFeey9fYj7j3UBlPLfm7f3lKrrUdz0ylFq3?=
 =?us-ascii?Q?4zT+nMsHW4lXn9TG3UGZQfyJP06P6rq0DG49Tx9drl188C9340s+mq133lOC?=
 =?us-ascii?Q?CptnHsufMGK4l1FRxP+xTKOMzau3xAK16KoTs+i1b+GbVctyLLq6+g8Bs9OG?=
 =?us-ascii?Q?zdYHXRnOnw5sMHF+Ceq5Gls8Gf1CwBuGOyrZ7hK+8Kne/s2WE/k3xulL49sp?=
 =?us-ascii?Q?92SLYISNAt/GQa7h5V2G0DVXkBhg/bYMTZnKehgMHP59yld3kbStfA9arwJs?=
 =?us-ascii?Q?pyv99lxZvmWuQK+uciBXUmBndtfSt/7LFGdccicFMDak/gdL8On21bPBwsmD?=
 =?us-ascii?Q?5KdT5eC4skWJTuDS8OivrO743A2KixQPvQg1eWJHuGnL1H6xMp7Ng5kD17ML?=
 =?us-ascii?Q?nPejSf93kiQPx7PuDw6JFSRKdqinmdgeaD8zP8Ndn4REI2bqbfSu3lqUjgi4?=
 =?us-ascii?Q?0oLyKJq8aZQ7EQdE3v3wmi9gJTjIKkQpiKzUjZAwXb7zpm+Fb0/mAboTAWON?=
 =?us-ascii?Q?5q/iigNT36w45zt8Jh05O65RSAGZjmj9ZzjG7ud+aFHV8E28zqSuTTVJsIqr?=
 =?us-ascii?Q?AUYDGFpJNzFvTc9nx0FyVVbEfM4ZxG3q5G1FjBNBqDPndJVYrySCGWQ2fvQJ?=
 =?us-ascii?Q?ccAXRCDz36+Db8ronM5Bp0iJjTN4vaS5LG3sPHhgdScUJ5U/LhXTSi+jXMyu?=
 =?us-ascii?Q?pA6+2H5DgCmf17B1+V1eqotNoeV/aiqpWgJr8vCsD3YFA/mVq+FngJfwFG+Z?=
 =?us-ascii?Q?Z+g/75e+us8F4RJBOPFXEe4y3KziHBip/wtA7ZVS5/lA42PY7Xw+VKayv91E?=
 =?us-ascii?Q?cWFjPCQP42AKwVMEh8HV6+TM045Yaxzgl2Kr42SlbN0p8mJlCIPwEJXLIMoq?=
 =?us-ascii?Q?ouG34NXmfrOWCfQOa9cXPhONICTu6UN5eDww8VTjdKvQWJvizfd4CE6vI8uZ?=
 =?us-ascii?Q?DULS00d13g6M1WCXawJajO6dDXUo8OFRzXZQRmzPFGy6tVYEhXUMGBZaaU8n?=
 =?us-ascii?Q?+lJ14tSIx+EZW7g7qNmkC1tWC7kRCRDqeKmh3uDXU+fvGz3Qf4UgDxO0+3OE?=
 =?us-ascii?Q?YVHvBD7YWWksb3yt+0Mnm+1ro1v/z1mvtEa18SolKijJjz6ALHf+mQWlgNT0?=
 =?us-ascii?Q?z8WEDjLDcovRoNm22c3AemCv1jzpBj7yu1yoLSeNvuwZYWTky/b2IsjoH9Jz?=
 =?us-ascii?Q?6gn5deYC806xToEovVcZ6K6tpypyEdb2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m5S0oZ7qJXJHzVxBMEHlqUXse3Zlf/GPaLGHuf9qVl6z+3wbOGd80+tGaXaI?=
 =?us-ascii?Q?/wN7z9lKtFElUxnZSTB8WMcO5YioU55CzM2NLLp4iGphHiByQcHO4TgjB8Pb?=
 =?us-ascii?Q?6VltC/pHvpEudPLLLD27neGw0hhyUCEjforLLwaQJy5NmvWKWC5IwBtTTX4I?=
 =?us-ascii?Q?c2eRgrLDcxKs2Suh8/cc/Sib3bX0/TnqTj6oXEGOdhGEoLud29H4N+I1C7kc?=
 =?us-ascii?Q?2kUNv/87wyTVVRofOotO9zcIzIJvnrjiD3o9nj7kiy78xeLiVU1p7dNki8XX?=
 =?us-ascii?Q?GyxUie6u5MVaUjB9pLy6JgDULrEhtY5u3mmSG9iJPvYkazFrNddoL/jdK60y?=
 =?us-ascii?Q?6knNQmOc083ZpVsXGZJOdaiO+FJN9BiRaZQYe/6KBl0hCUsxBhAhoyzFrNw2?=
 =?us-ascii?Q?x/Zvy2C3wbsEr3dK3xdzsa9+12C4+RS7YpG9qooapLjf60zrrwKyXER/umwn?=
 =?us-ascii?Q?WNWC3IHVM/nS7ZR4XZ5PEF/djvm6te5nHtnhprbH7C/zi5sqhPokrHuMVUjM?=
 =?us-ascii?Q?YqyzwN/QO4tVXRfySt/RtJf81WXIG+HxQwejAcVHCnicYdP9puToyPQNajjl?=
 =?us-ascii?Q?zj5VRqTaENVBDCsZ1oXpzUT5MQcP+SOl73SxGWHOIC/UV/3Vh4OT/XSLYvdk?=
 =?us-ascii?Q?9sD7UcTIMF6bO7h1V6Ph/4oaJSCT1xMRLEUYL6wGkmFDaaxzRpVQjMAvHm9D?=
 =?us-ascii?Q?OZ4xHiFmffmn0o3DAPEtvf//nO7U1ewbSi0ihjQhhPLoeG2NyrdpXtQD2Cuf?=
 =?us-ascii?Q?2J+jDYeZttpOhEfnZTROJSZmBsheQS6669JGz2lIoxNnkk5NYoWyeaZYu5GN?=
 =?us-ascii?Q?VVb3kg4jVJNzikyMYYuOsLLGJEQWKlSFPb4Bp5gXlhszhRPipiTYKFsw2HR4?=
 =?us-ascii?Q?yKudv+FcY6SH3DnR5VDvl1KVk+tIjnh9iVuoai3tj47HCIx5GHw47sWezjx3?=
 =?us-ascii?Q?KKulRDnEJ/ZNljeSmSFIMjhxqdgusjYQtF9M0bEPJi1svZ6hBVSXLzGWxdzu?=
 =?us-ascii?Q?iQE/VTOUpI1Gk04qyqTshKQIFkZSwo0eM/y86LWxdsRhYMooFx61p/3kdeLT?=
 =?us-ascii?Q?yBxaBIbM+RUlI0BQVXREjMmeGJaxDz52N/Or8z+awT1HAHc208rOteBr6e7l?=
 =?us-ascii?Q?irakGzsAFY1UwYoB3HYczuuP6qCMmJA23Xfpuh+AtUObClMNPmsT7S+2SYvY?=
 =?us-ascii?Q?p1ldE4WMPABR7FcYhvNlHqcD89IrrxQfDVQZKmFkhbPRgDnH8o4bXrG9zlug?=
 =?us-ascii?Q?hr4hHRy+0CkulUXxbYkmOfR1z3UZzaVIU0+xpt1z4Aik1umVxgJ2c9rZytjx?=
 =?us-ascii?Q?SiCq2+DSqCqRvyzXj3eAO+7yfe1u+5B7gVgF1vdA2/AE0w88eL3mAKeUNCDd?=
 =?us-ascii?Q?0Y6RDcNIJws2CxSxkhuaJvitz9dQoihr11ekmy8GDW6IYFU+lmpZ569Yfj7x?=
 =?us-ascii?Q?FLp55A18b+bl2euqQ3ifpq7TFV3dC117r4xNKQXGVgFaqTVpd2ECHThcn2lJ?=
 =?us-ascii?Q?N17wxITjHwSChoig5b4C1mUQ4psiF8NtMkdIqQVftdnFjjDXm5acn3/Z9jkz?=
 =?us-ascii?Q?sr9Ha3VMi08oyD8jIFKiEioRG86ZBcpC9G/F6YUgWaG5F7JWqshmUBKKtorz?=
 =?us-ascii?Q?5lGhyzrE5fuku14vMER6ePFWtbcxoa75OOZG/ihLljv+iwT3cbXDyASSxw51?=
 =?us-ascii?Q?xn3Q8++i7r0066AKFVlgGUKAMuSRlLJfaHQ/TPz+QVQZzdvzzBAzXBzk9rz4?=
 =?us-ascii?Q?lIW1kxLA+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557bcb23-e88f-4406-d44f-08de3f113eaa
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 15:14:03.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbkb8BvxFTHf8BrX+FmCvBDuCT5chKN1IrGf9P5Se7ZlPpnMsc9XumkTPXNNUDFDV+OpI3fPUUUZAcY5ZlaDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374

On Thu, Dec 18, 2025 at 03:49:50PM +0800, Yao Kai wrote:
> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
> __rcu_read_unlock()") removes the recursion-protection code from
> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
> raise_softirq_irqoff() with ftrace enabled as follows:
> 
> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.constprop.0+0x172/0x180
> Modules linked in: my_irq_work(O)
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PREEMPT(full)
> Tainted: [O]=OOT_MODULE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  __is_insn_slot_addr+0x54/0x70
>  kernel_text_address+0x48/0xc0
>  __kernel_text_address+0xd/0x40
>  unwind_get_return_address+0x1e/0x40
>  arch_stack_walk+0x9c/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  __raise_softirq_irqoff+0x61/0x80
>  __flush_smp_call_function_queue+0x115/0x420
>  __sysvec_call_function_single+0x17/0xb0
>  sysvec_call_function_single+0x8c/0xc0
>  </IRQ>
> 
> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
> setting a flag before calling irq_work_queue_on(). We fix this issue by
> setting the same flag before calling raise_softirq_irqoff() and rename the
> flag to defer_qs_pending for more common.
> 
> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
> Reported-by: Tengda Wu <wutengda2@huawei.com>
> Signed-off-by: Yao Kai <yaokai34@huawei.com>

Good change! It is the exact same pattern and both IRQ work and softirq
raising are for deferred QS purposes.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel



> ---
>  kernel/rcu/tree.h        |  2 +-
>  kernel/rcu/tree_plugin.h | 15 +++++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index b8bbe7960cda..2265b9c2906e 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -203,7 +203,7 @@ struct rcu_data {
>  					/*  during and after the last grace */
>  					/* period it is aware of. */
>  	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
> -	int defer_qs_iw_pending;	/* Scheduler attention pending? */
> +	int defer_qs_pending;		/* irqwork or softirq pending? */
>  	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
>  
>  	/* 2) batch handling */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index dbe2d02be824..95ad967adcf3 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -487,8 +487,8 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  	union rcu_special special;
>  
>  	rdp = this_cpu_ptr(&rcu_data);
> -	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
> -		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
> +	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
> +		rdp->defer_qs_pending = DEFER_QS_IDLE;
>  
>  	/*
>  	 * If RCU core is waiting for this CPU to exit its critical section,
> @@ -645,7 +645,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  	 * 5. Deferred QS reporting does not happen.
>  	 */
>  	if (rcu_preempt_depth() > 0)
> -		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
> +		WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
>  }
>  
>  /*
> @@ -747,7 +747,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			// Using softirq, safe to awaken, and either the
>  			// wakeup is free or there is either an expedited
>  			// GP in flight or a potential need to deboost.
> -			raise_softirq_irqoff(RCU_SOFTIRQ);
> +			if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
> +				rdp->defer_qs_pending = DEFER_QS_PENDING;
> +				raise_softirq_irqoff(RCU_SOFTIRQ);
> +			}
>  		} else {
>  			// Enabling BH or preempt does reschedule, so...
>  			// Also if no expediting and no possible deboosting,
> @@ -755,11 +758,11 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			// tick enabled.
>  			set_need_resched_current();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    needs_exp && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
> +			    needs_exp && rdp->defer_qs_pending != DEFER_QS_PENDING &&
>  			    cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
> -				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
> +				rdp->defer_qs_pending = DEFER_QS_PENDING;
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
>  		}
> -- 
> 2.43.0
> 

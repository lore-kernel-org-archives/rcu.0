Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794223D7C7;
	Tue,  3 Mar 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570771; cv=fail; b=iLFwjBbuLChPc8p75LlJ28KDZQIVwIG2FRbezxIHm2rQcydb1/PWDuCaB2llRDf94rYrW4bnxZ/QqaevT9awTXF7WPWl+fmCjdPBNH4Ve/ZKDtuglV+FIbJv8DF7GDnzolg7Zr5p2vLi1oGdfmtMbA0u9rzk6OtzyqkLDTqhVZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570771; c=relaxed/simple;
	bh=4i5B3CjvcweKlqNw4iGQyxcibv2hSu7yWk/z/dH6dk8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NViI384+Kv0Q5YVMmKjc6DseYorqh2oOwWi986JmJPO07T2WQmSYaALFTbnbBixd8H+FcHTjd9H3F4Zyz4B1KEgkfeyN8y7WSJL6SC2pyPftUIow9dJdRAf+EMBtHCCeGgAwxKsMlde4SOZfk8lsKuUqe5RsyqVc24RPKGFWtf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MixAV8Ye; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MixAV8Ye"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zkgq308M1caxi9x2BZzbPyFEpv06z8etpN6rW90jkBZmQWA0nUVmgMeHMXEZBqJwxwnmLRwnD+WhlsNj/VSAGhGU/ak4GCh1Zmx6pZo0BfXft4KZ3ma6geTcvR2JVLMyN7X0v1qEk+Y1SzVLJQIhhPMOrQIV4WS7MeehDuzdpGh9qWhKbJmi2KqU6F69g4ySKPE55zUHIp78IdM1QhxPwgE6X5sAPdok5wu5LuuxQIA3ehInY7FVRX6X5bqsWfJSSDdmJEL1HKuxs407g/Be6zbkHvxAYoYNk3g7WzQMHBjnDZAyfgDCOkeMBQIe2kEljHH7KIk99krAhXkI7wV1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n+SYup2nLwI5EkXME28llHzMB5zYqAxa1sqyWX+QWE=;
 b=WM3knSrfcdM+CUxCzSsH6cy3F+skbtOOYv2qhlP3CJVFbdZCRe+pLB+KX3moGTj/b05gek+3pT6IVrSEBJnOakNy64n2tWsEodhm7EkmVxc9EeDldT4Ka29xtrNK9B3QEUl6iE4w9GnYWeZLAyePgQ8HblG2/nuOptW0tQD0OST+Y6X8JJYXR0nlIq6YSqkRGWxJGiy7id/Zu65kZe9Lkx8SQUgsBqKA4NQAkz54LEtGKAoy1M7l6aTajoHVT92whwAja8Atnvwq8CZG2HoWmqUPDCHRdrIr2yPErA2V+vHQf+lJU6L2fvBm6M99rZ+wGoj7sE9bS9yqzepvNurZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n+SYup2nLwI5EkXME28llHzMB5zYqAxa1sqyWX+QWE=;
 b=MixAV8YeoEE56YHceVyqhR1vbrt1NyH14x/wV1CnA4yQqKuvbqgGaYt3O6DL/Q3QspQRh5fK4FD7Dew1rx+tqNL2ZwFIco8oqjo5PkBacJo7+xOaBlSfQgs0dJzun9OuSZVHs3Q/gmmT9tohASC1knM3XZE3iQ+zaCGzBPiO/8D9/23KWqRShfBOAbOuwLg+uZZ0Y33ZPSrbaZOSOKda2/yCdrfODizMZMGzjaj5heDrPsH5lkWCajhpFuWcn9W909DgrDWDegtz6Mn96dcmOKv89Lz+A3Mf5ujKoTqomwwSzUxBrS3bQ7WXnn4RXBReEVqJi8YUZewoYP/WrUgGKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 20:46:01 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 20:46:01 +0000
Message-ID: <14e954e4-cfa6-4069-a25f-ccb444d17535@nvidia.com>
Date: Tue, 3 Mar 2026 15:45:58 -0500
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v2] rcu: Latch normal synchronize_rcu() path on flood
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E.McKenney" <paulmck@kernel.org>,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Samir M <samir@linux.ibm.com>
References: <20260302100404.2624503-1-urezki@gmail.com>
Content-Language: en-US
In-Reply-To: <20260302100404.2624503-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::18) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH0PR12MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: d83474f8-3746-44b0-bccf-08de7965e113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	waNg19LAX6LG2WRoIFhaB+4enzmueENaXIwRfki+RafRFQmRU/AUk/WdNrADXtdjLE6pUSgzKI8cCpwOwbBPFnh7lrs/OeTQrT8424OmfmbHZJj8IzJ5ZgzuNNDNuik3Mt6BQtO5WbUL7LYqR/znqutl06o+NgnzGrtHZHLAx3r7owtc4nxVZ2ZepNhfz/NHcMgn6qRX8YLNIcPyXn8iPpSb0ID+i/esM+mVXR/zZ8fu7upaQFofz2qVWc/AYaHwOSlx3NUWglED1yg/HsUTbNWH7m3cQ2iOeTXuonqgPajtVrS2nMPMD00q8Rw02O5pydGeXyrkOQYy9HAW22bzXWyBPo/z8WeZD+sgk7SfiREzm4rYCm7mhb16ci/8sH5RaLuRw70wJNS02bM//NlM9Lyj79/3L5OPN7LXYHvjuSOl6S83ldL+fEjvVwC10SrD6+fko9SBEHoZrvgjIikMq6sFaikN/XvZLknyRjVhq4laEZQnmtcGDp18Yp/g24TLtfgbepnNM5rOz255CWL1VK/Ar7SqAag8Ji+xk83p3ci66iox3B47+gLC15ag9aXlEWOdZ4bFfArQunAUlzdjrIbCPEA9rEe5r/05ry5zB0gLG2gtlltiDuaImnY6DlhS1atceAk5a+Xi6jnIYssltmgS/S9OnwiS54hrv5Ut4pBk2LdwC4+M35j1Ny1cYo8YuT7sH0EoXqr00LWgifEhESPQ2LyNoHch/mySOXhbs8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzhPU0xyVXFmbGxONEJNc3ZTK3MyNVM0RHlNZWhtdy9FWHRnSkdLVmsyaWw2?=
 =?utf-8?B?RXJNdUNFdklPOTNjUkYwUklxUEQrTGdUUDFwcVVhREwrazU2WFRseGhrNU1O?=
 =?utf-8?B?NjBqamlZMmxLOWMyQmhTbzFaczJDZndqK3JNbFlDYjlDdVB1OFdYNjRmL3dI?=
 =?utf-8?B?OVBNaFBVcEtob0orSU5aQTgvNHdIRTZwZWJRQittL0dQdmd1NXhleFpUdWVa?=
 =?utf-8?B?UHUzaGV2VlJHRyt5OGFZWC9TZmswdDZoWWZ0cldvU2RNS1FDdzUzMlZRNzc5?=
 =?utf-8?B?UDRJUXQ5MjVUM0dsQStIL1NuaW01Vy93UnliUCs2NWhhR25nZ0xWMGNPWjFU?=
 =?utf-8?B?c0poM0dUZ01NREZ1eGhNTXZNQjQ0SnF1QkRUOUMzTWdQNEpyaFFFNG1VZ2Jn?=
 =?utf-8?B?TlBRU1dsZ3RSVkphUWN6VFdSV1hoWmRyVzVHbVJ1ejFkWkRPYWYvQXNrYUY0?=
 =?utf-8?B?Z0FTRTdRYXJBbWlMSUJqV1VPbDB2dWJDWTE0MVd1SFhQY3FVa2FkMHp4TkRG?=
 =?utf-8?B?Sm1DWUVZSXRTU01DczZOOGl4cWI2ZEJQZm5keTZTbkRZLzBWSXdKSnY3VW1J?=
 =?utf-8?B?VXkzUUlhZ3EwRytMa2F5eXFsSytwQTN1RkFFV3FIOUNSRklTL2NpeG1qNXVj?=
 =?utf-8?B?V2FqSG5XKzZMUnI1RFpkeWdqRUV6Y2lsYXEzTStvcDcrWkVWOWJxSkdPZ1k2?=
 =?utf-8?B?YUptcWoxdUE4REczZkFTQUNsYU1uekhUV2VBVHRGaE1ld0RkM2hKV0VIRTJK?=
 =?utf-8?B?bm1yb25jbDY1YTdqMlphUHBtQklDMGpGN0EzM2M0TTFQTmx0ZEFLK3VaZTFO?=
 =?utf-8?B?R1U2S1RyQlBtZU16aUdCTXpVNWdLaHNka0Qxc2tXVzhuSmxqV081dXRZdDFN?=
 =?utf-8?B?TS9QcEVrSjJMaGNGN1VKenFsZlJUeFBJYkxLWUpaaTlKU21NKzNkNlpjK3p6?=
 =?utf-8?B?NUIvQXhob2IwZGxCbjNPY0ozdjJvOXVLWlBUanhkbTlweUFwR2J4cEF4bmti?=
 =?utf-8?B?Q3RBeEcydkdiN0xaMHNycVNOR1JHd0VhRXFOaXEzSEhUMTdvanB4QzFwSGU5?=
 =?utf-8?B?alB5a21RQnBxYzVCNStiMGdxTHdzWXFwbnU5bzBzNWRjd0ZBVHRpZ2Fpc2NU?=
 =?utf-8?B?czRkQ1VHamhmRWwzaHdpaGlnR3ArN0JReWlQSVJDSno4T3hyMStPSGxIOHpN?=
 =?utf-8?B?aUprbzIraXM4eDBsNUlBYWp2Njc4MTYrOFRyZGJ2TlZRWTMxcHdyZnI2Z3JY?=
 =?utf-8?B?QXpOYUhYdk5ienRsZFc1WGlDMXZTdU1KeUgwWEVSdUJPWUN6K2t3SHVTVTZT?=
 =?utf-8?B?QXVKWHZuM3JMTkhXanVzTVRBTjB4SkhHSU1tcENJSmJGK2V3c1pwV3JSR3R4?=
 =?utf-8?B?QlRpczVCNHp5b2xlYk40dCt2QWdXcG81dXFmWTNLMnVXdzU2SXAvSHA4amNo?=
 =?utf-8?B?amJndWF2VS90NlBqbStZOXBlWXFDTi9VdlJwZlVPL1A4cVZHdEJWYko3N1Z6?=
 =?utf-8?B?OHZiRUIvTVpWeENoQVJSbXNoajVRZ1NGdTVOT1FVaEV6eFk0a051NlVwOC8x?=
 =?utf-8?B?NHlyY1RKK0dNWFVBMGI1QTA2aENZS05IRXJneEVGUWwyMHdBVmk0aVlaUVNH?=
 =?utf-8?B?aXRpWk1RT3lLQUk5L3pZbXJVOGovOGkwNHppZFVJM2hqcjd3Zm9VNFVMMVRW?=
 =?utf-8?B?YjJEeUtVZ3IwbVB1OFg2YktrZWxreDZJdldHQTNQQTdkNHkxZ3ZzUjRaQmVm?=
 =?utf-8?B?U3ArTUVwaEp4Mlkzc1UwcVhFeWd5Yzlid1A2R2VPZ2ZjWjY0N250dlVpRWxM?=
 =?utf-8?B?WHV5dHhGZlhFalZ6U3p6TmdQZUU3N3JZVFRQaWcwRS9Ta1hTZnN5SzZxaXNm?=
 =?utf-8?B?NVpPNldxUVphWTllZ2NIWjFDaWFVOExEMyt4eDhSV2k5dXhWK1N5Zm5FRFZn?=
 =?utf-8?B?MzdRNjRkWTFBL2NWZFJGOUQrK2FVbFEvVGdScTRXQjQrQ2tXdUVaa0EyajVZ?=
 =?utf-8?B?RzNFd21pZ1VnbWErNlNsUTh0VnVxWi9ybnJ0bnlxLzZPUnBIUzYxK2xrS2dS?=
 =?utf-8?B?SkJtUnUycEtqMVRWTHcvOEFVSEY5MSswYmlqaG5odnVTMW5WdDUxOWRML0Fr?=
 =?utf-8?B?NkpYaGFHbUZYVDNpbThmYzZacGpEUVEzQWhwYWUxeVp5T21ZTjBYQmw2YUFm?=
 =?utf-8?B?UXdDV25uRFZMaGluZVJpbnRMS1RqOXNqbnZibHFFQjRxdlY4S0RZRTV1UUp5?=
 =?utf-8?B?Tko3U1kyT2xpc3dtNER0b0NpZmdsaCsyWHI2ekMzMm03ZXZYMm5QU2hTcmkr?=
 =?utf-8?B?aWdZdlRzMjVLSVB3OGxHMU1Od2RwZFQ3Rm5KZGtpbUpjNU9GUmRxZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83474f8-3746-44b0-bccf-08de7965e113
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:46:00.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWiofmF31C+Y4njiVq/fBjRBww9Bi9XS3aA7ooRhyQD8gs9udi1T4ikp+nX+sFUi72hXcPB2UKTx3wWraMnR/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530

On Mon, 02 Mar 2026 11:04:04 +0100, Uladzislau Rezki (Sony) wrote:

>  * The latch is cleared only when the pending requests are fully
>    drained(nr == 0);

> +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> +{
> +	long nr;
> +
> +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> +	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> +
> +	/* Latch: only when flooded and if unlatched. */
> +	if (nr >= RCU_SR_NORMAL_LATCH_THR)
> +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> +}

I think there is a stuck-latch race here. Once llist_add() places the
entry in srs_next, the GP kthread can pick it up and fire
rcu_sr_normal_complete() before the latching cmpxchg runs. If the last
in-flight completion drains count to zero in that window, the unlatch
cmpxchg(latched, 1, 0) fails (latched is still 0 at that moment), and
then the latching cmpxchg(latched, 0, 1) fires anyway — with count=0:

  CPU 0 (add_req, count just hit 64)       GP kthread
  ----------------------------------       ----------
  llist_add()    <-- entry now in srs_next
  inc_return()   --> nr = 64
  [preempted]
                                            rcu_sr_normal_complete() x64:
                                              dec_return -> count: 64..1..0
                                              count==0:
                                              cmpxchg(latched, 1, 0)
                                                --> FAILS (latched still 0)
  [resumes]
  cmpxchg(latched, 0, 1) --> latched = 1

  Final state: count=0, latched=1  -->  STUCK LATCH

All subsequent synchronize_rcu() callers see latched==1 and take the
fallback path (not counted). With no new SR-normal callers,
rcu_sr_normal_complete() is never reached again, so the unlatch
cmpxchg(latched, 1, 0) never fires. The latch is permanently stuck.

This requires preemption for a full GP duration between llist_add() and
the cmpxchg, which is probably more likely on PREEMPT_RT or heavily loaded
systems.

The fix: move the cmpxchg *before* llist_add(), so the entry is not
visible to the GP kthread until after the latch is already set.

That should fix it, thoughts?

thanks,

-- 
Joel Fernandes

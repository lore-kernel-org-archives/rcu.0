Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8189E545;
	Mon, 11 Nov 2024 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731310658; cv=fail; b=jZir0sGmLxQXhcHOBktJEs+XKaCZjEhM9g4oQk/7apUYsxz7AIW4WwCg3KVxQ8st0BxKf5821S/d+J/dVq1pkX7NBeyO8XMVNws6AM1Qb1IahIxWQay5KIZbhHAeMB/l3QMcD9mirrN3jpSadNuZq8yXP6XLVgTv4toqQrICoFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731310658; c=relaxed/simple;
	bh=WEqgR964Ksc2kPKzJAEHn+g+OlfmrcZLlEODW563hDQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttxarHca1hCIvy9DShbdiYwyt/IEzss/Ftku4HBP/cs+EPUXrK6VXh4EzZP0MwRCx83uQzfrnM3/aSQFG+Yq9Papsx6Tzyt6UKZKvCD2gvHjp+E8uKbfmjqJKz56/OllQSPP0ipHA9RNrszmnSzafVW5FXXz4V9YahV5p8dwmZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3W0BCZrp; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3W0BCZrp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXSWRKyllO2xaZHt5EoLi2tE07A3g7IH3AhOQcKRCEiy7PFtKxxls7qQ6Z2Ntf+vIjIWdCB5EbPwE/7NVSTNA+ffVWyD/PndxUd8NNLItkHfwJpt7qeplI7ByYVuza6pO6kWmqrXX5awY5hQdJSzXCSkttcyoMfk2PFFur9073mOhA0mGr7lzLMfvOMfdtOw/J9qc78VnUQ34UGgdzCln8LvIJQ7rXYtvZsVLVkspI+dkpPBYXMR6pkbyDeIREaBvwolz9ZTwwFLrvNCLJ3fdOTfLE72TAD1RDP/MWPsg7wAajoh3fyevHElsUk4Z29C/rQZMEvXyrUcrAFTQeTrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ1NP9iZgqJdYJJZAyHKsPh41dDd+48GLKxVJhrcbWc=;
 b=Y8oBf2v114eFixI/95WE7k32c962QdhhCRmWQz/LRqCu8e0zuiO2Qva9jo3R5LT4wN/9X0Sbe03pHKuIy75eoEBJqEP0BJCxZt9cjiLX//XW4VIuXSesjawnqIHxY+jN/uaFzROPb1eraK3bHWv+/cErRO/5Lt7V8CE5u/b4iQnnXfzXADEG5orCQaCxpJvTlikaJs1dAVVBd6xTIocPRxf7msSX5WMhDX24jeskJO2uHsBNte+jI+bhx8DxK+ghK5tLgXNRWMF3Y0HgG5TtINhd8324PYoYoMwoX5Q/O+mi+SiQ3VstBh0Z3LGYujNLsKPUhTU7G2GyCnFWe8Xr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ1NP9iZgqJdYJJZAyHKsPh41dDd+48GLKxVJhrcbWc=;
 b=3W0BCZrpCkhtganavJQmGo1vr5AJAqe5tw6QbFCcC/CMWKNb2RgWHj15xJus0+kEmm4Lwbr2sOvzb6uoMrUDTJfU+t8QAIIeedI5rA/bP9Z3fDdVZxIIlVRDtqcyoXD2JMgGYAhxT3By6zyix3g2IVqJ94dCEeFUncsaGtYHyfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Mon, 11 Nov 2024 07:37:34 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.019; Mon, 11 Nov 2024
 07:37:34 +0000
Message-ID: <68c39e33-6281-4978-ba4e-131c6336aa7e@amd.com>
Date: Mon, 11 Nov 2024 13:07:16 +0530
User-Agent: Mozilla Thunderbird
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH 2/2] rcu/nocb: Fix missed RCU barrier on deoffloading
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Uladzislau Rezki <urezki@gmail.com>,
 rcu <rcu@vger.kernel.org>
References: <20241106153213.38896-1-frederic@kernel.org>
 <20241106153213.38896-3-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20241106153213.38896-3-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: e348b885-6a00-47cb-611f-08dd0223b516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VURPYjBiMGo0aU1BYmZLOTBWNnAwd1ZIaTQ2MTFKbk1xSENLV1BCMFkrb3B4?=
 =?utf-8?B?VU1JRG9EVTd4ai9XV2s4d29pNThPY0E2ZHE3dlB4L1hOUVRDdlJYeGE1M2ZB?=
 =?utf-8?B?YlZ3UWNQa3dCVUc0UjdoK01kaEt0dU41VW0zcmhGWjJzMUEzNkxWMHV3ZHRz?=
 =?utf-8?B?UXhCVWRGQ2hIOElBUmtoSHY0RDFCN0RjRjZoZEtBSnJianpIWW1oUC9KeG8r?=
 =?utf-8?B?OEdoVWZ1WmFUQk9QQzQxRURZY2pXZ2dpbGpZb2piU0FaZlEvSzBMbG92NGhz?=
 =?utf-8?B?RU9jdEhmR1dCaDQyY08rQ3hGaGcvWlBmTGhLbnB3VTNDQVJoSmpHcWNlalAr?=
 =?utf-8?B?MEFPL3VkdXh0UzJEZ1RBUzlGV0RSTFg2aVZEYnBEZUNINGFXZGd2dXRLMUZP?=
 =?utf-8?B?QlFOVEtJN0Q0VDN4RWExVzlVVDJIbUQ0NnJaS0MvUXJRbXRKZHk2UnVEZlhX?=
 =?utf-8?B?a25kaDVsZFZKcDdyWWhBYVl4c1pFTUZvV2ZTazRNazVEQi9UNEJsQjZETW9j?=
 =?utf-8?B?RFhncVNJMlhwTk9BZE5acTEzRnFOVm1tVXA1eVRmVjZBbWpEelFvdCtqcjhN?=
 =?utf-8?B?MXV6ZkRrMnpUd3UwN2w5UkozRGdiNks3SFgrY3N3Q3JleXpzRW5vSHdjT1dD?=
 =?utf-8?B?Ly94a1ZXdUVHcTh2eFVnd0dOdmEyRk9zc0FkTGRxTzJ5UEEzS2cyUjdZRkpz?=
 =?utf-8?B?amFYZDZ0bEhsTFVWKzhLb0lYVVQ1M25zbi8vRStsZktZWGJvNmlENnFLU0lL?=
 =?utf-8?B?SEh6cFhXU2Zra3o1VGtzZEU4aUhOeWFuOENKSjNOYWRiRDNUNlgwdmE3V01O?=
 =?utf-8?B?M0VIK1JsTDBqL2FkMVBNbzZoN1NaRk91T2IvRENMQ3RXUjI0NVN0WitxZ0hl?=
 =?utf-8?B?THEyY2Z2SmV1eDdUb0NucWxkVVpRbDYwOGJVZTlEdk1HcU1oUnViMThuWjd4?=
 =?utf-8?B?eVlpUnlacGpxZWM0UG1lR25TRml6aUZMK0dZQnJOL0plWm03QStDU2VmT20z?=
 =?utf-8?B?ZXJNZnhUVSt2Wm14WmZYQzB5SXNZVU1saEwyOW4wbkRWZkI2RmRLTWRyU1Z6?=
 =?utf-8?B?Ri90dHJCWms0MnpRUWJOSWNUNi9HZG5kSjN4TnBXaDA0clY1UC9mRE9yQXZk?=
 =?utf-8?B?UlZmaSsxaWRZSkkyWnl2L3Y3VGw5MUFKaG9JbmhQS1kyamRZaVg4T0hNcWFL?=
 =?utf-8?B?TC9VMFdCdEk4Nk9kOFpWYTFqaXFTS0Nhb1JkTDZRMDJFcjM2M1ZWa1RVVXNQ?=
 =?utf-8?B?ZVJFUVJhSzYrdzgxOGF5TjZ4TmFLWWVzbktwdlArSkdMejFhQWJjb1Y1Qmt2?=
 =?utf-8?B?cC9qSEptZmVFUUlNdGRncFlZMFU2RXRuVncxR3lGOWlNT1ZXcFZnK3NKa2Iw?=
 =?utf-8?B?NkMxa1BEWDBrcC90NDJmcER2Skxrd0FHM1VMSlZZT0xhS2F3Y1ZhUkZTanFa?=
 =?utf-8?B?R3JISytpajJWeDR2ZXpKRlJFSWNIcEpYWjhMUEhNVGs5WjlhUlgzU05EelhI?=
 =?utf-8?B?YUZoK1ppeTVwTE1qdDVnZElCM3ZxNmU2SlZ5RjFCcWZCUituQlcvOHVTSWVs?=
 =?utf-8?B?V0M4Y2tGak9LTlV5MWZPWVllUFRoYytNSWExc09NMmFQZFRqUW0vdkk2Y3ZZ?=
 =?utf-8?B?eTZyUXFybkV4TkF6TWFrZ3ZxaWlPa016Rk1IVG5CMTVTVUJDTlpoZ3BQVmpI?=
 =?utf-8?B?SjJLcDRUK3pVTDZUSFd0S3RlNWlrUjFZbnhhQmN3NExkdmR3MGdEQ1YxNnVp?=
 =?utf-8?Q?6LNjTROZtmH4eLJMeM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDhkM21IQmUrb0lEdWRHdU9pSnFqc1d5WGZYK1lQMEtSWkJwamgwL01kd3ln?=
 =?utf-8?B?MnV4Q3FhbHE5QnhWZXM5QTN6RVY1UmJDNVpET2NnVVVXQjVkQ3F3UkRham5S?=
 =?utf-8?B?c1U2Z0FnZU9ZM3hTYWZETExuYlgxUVpuVXJ2SHZiNDFpS3pqL0FrZG5VeWt6?=
 =?utf-8?B?VU1xVzgyNEtkV21LV05GcmtlNmdic29hSVJEQjBYc0FyamN4WnExb2pHRGh3?=
 =?utf-8?B?amp0bXBzMjI0MUpUMnJydlhDTStZVzExOGFTTjhkZExKYVRBY056L0xMRXVt?=
 =?utf-8?B?Y0pZNWU5cS9jdVA0L2VBdGhXYlZMSEtGbGdtUUdTblV1cmU0ZG1KK1Nkem1z?=
 =?utf-8?B?SSs5OEtES3BnbmdFMmZHKzRrMk1EWUJKdkhRZlFUV2d2WGxaMmJzR1VQRlRE?=
 =?utf-8?B?Q1NQNUhMOGFlVktvQVVvTVVzN1RRMHQzWit6bW9KTHhncVVuaGFjUlpjbmhP?=
 =?utf-8?B?amNSUWRuYXMrKzJhcmxuTWVDSi9OaXRLY1FEOHk1Q3FxMFJlc0NicUllWGk3?=
 =?utf-8?B?TW1temRDd0VnUEFDcktNMUQyWlg0ZnJ5ckVKbWd3YkMxY2E0VWlOWVdGcUpD?=
 =?utf-8?B?cXNnRkEwOHB2UFdyeC9mbldrYU4rVVUycDZZbDFjc1duTllMUFE2eng3QUY4?=
 =?utf-8?B?bFVqQlYxMWt0YzN6TmdDSCtZRmdXcVN4cU1qd0RVcUw0eGZ6cll4UjhLaUlx?=
 =?utf-8?B?ek53TENRVmQyMStWMytGdnJ4YlFrc1JOWWlMZ0VpanltL291N3pCSjlycEVq?=
 =?utf-8?B?OUk5OUpyOG16Qm4veERVakxxZlVKSGpTeUovNVZKc0RvTFNuU05uMncrcGZU?=
 =?utf-8?B?Sk5ocVNIR21tMVR5OG9uUUNFYllieDQ1ZHU0Rm9VWWFUb1VWQ0Q0WUpnSU40?=
 =?utf-8?B?eEpIc1A3UEZJYXROMGNOa1Z0bmtyd3lML0tMK0JxWG5XUkc5NHlFMjVXcVRy?=
 =?utf-8?B?dzQwZG9CYUdHTm91YndOU2lrYnVnYnU5RGdxSmN0Z0k4TUFPMmRlTHNYK2dm?=
 =?utf-8?B?MU1YcTl6eGNrc0hxTzErOG1VeSt6THViQjhHZ1Bnbnc0czlqNFllTE5abmZt?=
 =?utf-8?B?cXREVExwcE1IWFREZVhhd1pQamZVZitycG1wY2M0ZFA4US8yR1dqSTFBUXB6?=
 =?utf-8?B?b1RpL3ptS0kvUCt0aHV0Vm9hNFN3ZXAvSVBDSFJrNExpbndzcUZESmFNdTFh?=
 =?utf-8?B?M0VEYmhlcWRsTmRmdkI3U1JqbFZpMzd5REhDOGl1ZUpKSitLTXpEMjNXdlBU?=
 =?utf-8?B?dytnQS92SFR0R1Q1MFJkc3BNOUkrSDJaQWh4d1NCWi84SjIyaDdLSFVtTmQx?=
 =?utf-8?B?ZVI1K2hDYnJybDQyaitjTG93bFVldDNZODBEYkQ3Vy8zYmxCNm9namhRRmhR?=
 =?utf-8?B?SmZMZmNQOTd6QUFGOUtXNjlPZGNOWkVRcDV4eDY4bWNKZUVYSnZ3RzBQRU9p?=
 =?utf-8?B?OUdMT05SbGVlZDdJdW8xV2ZlaFhkb051Q2xYZUoxMnBnaEUvaWFoUVQ2ZU1l?=
 =?utf-8?B?V05XTE9YTm1XWlBiTzFPb0x6bzIxMG5CeUx0U1Z6SG4yeVFQbU55UWRTcGlY?=
 =?utf-8?B?L0UvenlnV0pqSHdnYm02VDFQeUZhbjNCTGVaY3ExcHVuOVNOeThPWDljZklC?=
 =?utf-8?B?dEl3RzNLR1R6MkhkUGZ1M0ZoWmVmTElCY1AzSTBoaWJkekQxdnBGVjZJRFBv?=
 =?utf-8?B?emJqeDBQOUp6YjNzeEVad1RkWmNMQXdOU09XY2NDaHQvaG5UN2FuR2xNcVND?=
 =?utf-8?B?TGVDK21oditUbXI1RGczUkQvdzk4NC9WSHV4QmJyMUJtTUEvQUd3WEJGcC9m?=
 =?utf-8?B?WWhGY2FDTHRTRkFUTUVsZjY1RHNFY0ZDUFFCcUtMUU4vMHl5bzBuK0pKaDV0?=
 =?utf-8?B?ZzZBMEQzeGpxeFZ5TnpGUG1xSFc3c1g3ZS9iUFdlMFk1VG1yUWJaNnpjRXdZ?=
 =?utf-8?B?b2RUenFpNnRzb0VaQy93Wi91U0w4ZHdOYmJ1TVVYRDhjb0pWZGljRzU2MVNj?=
 =?utf-8?B?a2FMdUxkeFpMNCtUOFUzeUpQenQ2a1NmT3NGdzFaQ3YzeHNtTDZMRWNUem0r?=
 =?utf-8?B?cU9JbHAzU2tJSUtjM1pUL3c5bzljMldwVjZQUzRsWlYzWjZXbXc2RHJhODlp?=
 =?utf-8?Q?VsCU2ighWld9GXEDAll9fo1iU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e348b885-6a00-47cb-611f-08dd0223b516
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 07:37:34.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNDqXB6e37cvLdEeGNgcsdjqjESs/D6ZU/yqh/mSh+nAuRohiy3mlsEl6cMwX7gO8rV8E/pNerJElsmHpdS0EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233


> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 16865475120b..2605dd234a13 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -891,7 +891,18 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>  	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
>  					    nocb_cb_wait_cond(rdp));
>  	if (kthread_should_park()) {
> -		kthread_parkme();
> +		/*
> +		 * kthread_park() must be preceded by an rcu_barrier().
> +		 * But yet another rcu_barrier() might have sneaked in between
> +		 * the barrier callback execution and the callbacks counter
> +		 * decrement.
> +		 */
> +		if (rdp->nocb_cb_sleep) {

Is READ_ONCE() not required here?


- Neeraj

> +			rcu_nocb_lock_irqsave(rdp, flags);
> +			WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> +			rcu_nocb_unlock_irqrestore(rdp, flags);
> +			kthread_parkme();
> +		}
>  	} else if (READ_ONCE(rdp->nocb_cb_sleep)) {
>  		WARN_ON(signal_pending(current));
>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));


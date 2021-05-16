Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B002C433B4
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 09:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C10961028
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 09:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhEPJeY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 May 2021 05:34:24 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:62271
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234797AbhEPJeX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 May 2021 05:34:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1JDjbeaSgoLN32N1CDaY0FTWVQ1dxs3ZAhgtJfWuyUwIUoxWQFOHL4G2geZ1lhEFisyGhNQVOQsOEhCiscKKGZ+b5FqMYAbK8eko3O175GCU8nsFA0I3/0+jps+ud9WOVqrL11LO+yoDzZg9O6YXf/w2J+CVEmxwsEGBnuKUVH9avzB/wuSFBCWcc20tO1iU2wDRZU3hgMWiSuDkrDJqTJv1sjhKT6sP64VpWnsiObG6olu6oWMmSjwDtc+ZtQOzulQ8N3vKVorfcsZ5TCfCJfojNwJoYbbtgIqGXoiKrq2x3FlapV0hlPBhXGOCAxwXoWdUrQehAghArZEnbhe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TYeVOqnRQ4tKHE248djMJQqJN/KulRhNg5UFXKulyU=;
 b=Fl8GafW3heipmUlAQsm9GqpcDC5iz6djjFde6Vo25D6S/ruChmAqVpYK/kvFmSY8Ohl7uTij21QGvYkTVpNgXFnkALRG+IZlF/aqIYXrrM5BQOKPsGCKUy1mpvRiCdaWte8Hu32er3nZ7ZlyTvJjg24lf7jDN4+xujogPSsqkEJqZWXh1zYYTVi4IDmjRg/z0XYJ2mqzoFneZKi6lu3sl4TyfEG6rMwkzYFgfaVcfcOIP9nDnoBqHVpX1dVrUvHyskMsrzVpddpy8iTlJ+nanTvzSJyxfs3gkQO7dbHXbCWDah+xumFNP/zn1HJ1WWMzXlViVunTEVZx7EKHXMFhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TYeVOqnRQ4tKHE248djMJQqJN/KulRhNg5UFXKulyU=;
 b=PsjerJlzh4UtvVk8u3f0Wgm0fp08rfN0PmZS8lOqTia8KoEmEwpY9bF8QL6byAiMY8ecpFaDWrUsQK8+F8NxziP+TIVbO4/66JUf1yzBxfbNP9UG46KZT3kLnu8UC3zfuKbY+Vfkqz6Xf2XhnvyFekbAcZ7Jh3yZduGFGIZK9zg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3221.namprd11.prod.outlook.com (2603:10b6:a03:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Sun, 16 May
 2021 09:33:08 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.029; Sun, 16 May 2021
 09:33:08 +0000
Subject: Re: [PATCH] rcu: fix a deadlock caused by not release rcu_node->lock
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210516092837.3655526-1-yanfei.xu@windriver.com>
Message-ID: <e60dd306-c12c-df3c-41da-d64cec47eaee@windriver.com>
Date:   Sun, 16 May 2021 17:32:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210516092837.3655526-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BY3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:39a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Sun, 16 May 2021 09:33:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8897c106-9f1e-4a68-dee9-08d9184d9d3a
X-MS-TrafficTypeDiagnostic: BYAPR11MB3221:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3221C10846FA6760CF9FB1EFE42E9@BYAPR11MB3221.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9/ZqmzpjlnD+xsbDUDyew/BidkilaGXaE1S4Y1mi91oagq7gNI2gNss/dXUS1OowZuk6In7lGzRcm3jXQgzPfbyDd8ncpv2dAQQ1qL5+5znE68J3JH8k6w5jE3oDYshF/55fNGHNoQj8vKeiwp7Dh4y5MJkHzhF5E4I/rlP0p9OMiQKi/U4xZjl2yJRjgATqXlb7kecLUWS/HxHB/AbkqaIVrjxwUPTWnPvqI5X1tJTJ3BPsa19OJlJaiXKPKTqeGSZqBnIS6+3B1sH3DqgU6fsdwAocXbDolB3zktBn1E795hnh+PzaGAx0mjB8l3+SQgKP0hmt000DVThxeX7vr+LRxG9nQC+RfqcSVaa8loLfi4pYUMevWQq51NpHv/vDbri4MLSYnZz0Q8LE2kxPqYd5adUB0xiFojNO6mYDa2HE3sK+yFjhv0Fmp3d7QGwMw2CXauBuN33ugsIqsrLfZ6Ys87nipjTuQ4hWrs3SjHR9S12MWlcpBMUvWqUnfb9mi3JA/L8iSqVfG4yzStrXYGlaHvhrTo/TK8qw0s8UuXTdkqOQEOYjSw4dRlloAHfGTveKDP4zh1u5ocoPTs5j/EfQn0aKdeyfuy/3tKANERdPKWG5plAuz9fmXWGmiwu4lc/QYFN1zpR+Lmw6e6PyiZGjuHqd+lq5xLUIDkBWZFGw2g09rpkJFvclEzPYgFu3nlpqR4ir1hMy8/Zva8uhjKUnxn3T+y7ArJCo7koj/nqmvuxOnkuKWOcXu21WlgW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39830400003)(396003)(16576012)(8936002)(6706004)(316002)(83380400001)(186003)(8676002)(5660300002)(6486002)(4326008)(16526019)(2616005)(6666004)(66476007)(66556008)(53546011)(2906002)(36756003)(478600001)(86362001)(956004)(38100700002)(38350700002)(66946007)(26005)(31686004)(52116002)(31696002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UnVBK0RNMjZtOTgwd0NEVld6RTBia2dqV29wS05PeVFxTGhpU3RzRFVhN2Ey?=
 =?utf-8?B?TUpHajNjay81ZmxEOGo1cG4vMElWL0p3Y0dsMy91ZGwvRGYrclQyWFVFT0l1?=
 =?utf-8?B?K1BEUlZNRm5IcGJiSmlwTFA3alBSRjZ1L3BNSnVSeFlnYkRYZ1ZrRVA4cDlY?=
 =?utf-8?B?a2lYYjhRTXVhb0N4SEQzdnFtN21oRUhxVVM3RktXWFAyQzdRY2FvbmJBYVI2?=
 =?utf-8?B?Qk1tTnVHR2JoTmlBMkxHNUhoN3ZhQ1RUT2d3S2dNbFlyZDlKUE9EU2ZLTnIv?=
 =?utf-8?B?aUpDWUtXaVVvVGU5RWVMNnRGSFlLeUJSR0hnckJiZXFNc2l3RFhhbzdkRVNr?=
 =?utf-8?B?emQzSnlGaER3aGFaVjVadllIOWhRaXRHdU5TNjFmeTFpN0o0M09PNFRZa29l?=
 =?utf-8?B?R1Q1MnpQd09zZGVlYlZoU0dpT2xOaWtzWW9HSS8yb25Ebkt2MXNXQ1c4T01X?=
 =?utf-8?B?TXAvTmR4a3N2Y0FyKzRWemU4a0lGVnlZcFNKWFErYU91ZkVkRm1ocEpCNXRL?=
 =?utf-8?B?N3NOTVJRTUdCYzdYWFVtUDRhWVhxcllXaWxUTU5vbzVDY3NRQ0FCNFNwd1lK?=
 =?utf-8?B?aTlZaTMwM0VEZG5raXlKdjh5cDNnOHAwcEY3UGZBTVRGSWR5anFrZHpicXdY?=
 =?utf-8?B?K0M1UnhWQXB4WjRlUTRvdm0wWmN6Ym1QRWhIMjVhNU05a0RuMWM3TU5wY2VV?=
 =?utf-8?B?VGlPblRUeEwwaitZWC9HN2kvWVZqSUc2bTcyejdmd3FXdjhOdGUrdGFsKzR0?=
 =?utf-8?B?eEkzejREWG5kdndsc0htdkxXbnRobTQ1MzMyMkNyTkVicWlaNkluOVhqK25w?=
 =?utf-8?B?RVFZSkhEWG9LSjM5bVgxRFVSU1ByanprYTUvalhaK0JsR3AzMlhodktxRE9v?=
 =?utf-8?B?TmFHb3d3MHBIZy90V21URWNQR3VJbmsrMndxK2Z0VTBlQnlOK0k4K3BIVGg3?=
 =?utf-8?B?RVF5NTJLbFl0YVdKU3JrMmY0ZkRvQkMwZVREVnRQbzVuNkVZUS9XcGlOeEhn?=
 =?utf-8?B?aDlISDFHZ3RpL1FQZGRJWG1VY0p4dW1vNCtFeklGc095d05xcHZ2MDhwcE9R?=
 =?utf-8?B?bmNJeHFNdk9tNjZpRHlkdVd6QjMwYmtVWWJSOUNocVdjanB4aFVuSlp0VTVG?=
 =?utf-8?B?ak12cnRMUWRuNENFSVlxMjB5QjhaQUh0Q3FQZFNrcmxWaTNqWXBqOTFLdkls?=
 =?utf-8?B?MlQ5N0FhdGg2N09zU0YyM21tSGMzWHJMdmRuSGI4RmRpOEQ0M09WejJTVk5u?=
 =?utf-8?B?WWU1cXNEdDFydmdlWmc0MEJFYkpMUUVMbHVYRHlrVGRZbjgvYUJXck94UEVq?=
 =?utf-8?B?TzhVZVZ5LzZWaStSMmIyVHFqbGtGQUw3WXY3eWFzK1RMY0M1TWZRQkNZc3VU?=
 =?utf-8?B?UnozZG5COXpQdTJneEloREN4dWJsNGhEL3RMSTBCdDRza2pMZlltZGJyTlk3?=
 =?utf-8?B?V3ZRWUNjV3lOVXg0cXNzeFBDd3hQY09Rc1J2U1Y1aHNjODVkU24wdHJjMXNk?=
 =?utf-8?B?aTRZYmJzdGhYSzR3T2p4VWo5YmZQbDQxKzQzOHpHcUVYNTF4ZGJLc1M1U3M5?=
 =?utf-8?B?ZVBMM0xXeDJ4NDlCWHhBZUt5U2IrdzYxMC9rTDIrMTBQMDFnVkw1QkVTWGhS?=
 =?utf-8?B?dndxMkNNNjVTdGNRbzNFR014YXZnTS9RcHhRQktHaFdiRXhWZFQ1WVIwUDFv?=
 =?utf-8?B?V3kzOWhqWHEwL0lLYmtWRGZweHZSNzdhYkJYNHNmZmI2Zm83SUZHVXBQVmx1?=
 =?utf-8?Q?VUlSSowzRf0BBZ2Kg9a9OxXBNOTI+vYxXSYjoe+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8897c106-9f1e-4a68-dee9-08d9184d9d3a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2021 09:33:08.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxP4ZHCBU2fMRh/tdzf9pSc5WWlTRjTOkE4oGKqXSL+Modpx+cgfYcMUEwP7prcuco6+qg+IYFVH4J03piFb7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3221
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

sorry, please ignore this patch...

Regards,
Yanfei

On 5/16/21 5:28 PM, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> rcu_node->lock isn't released in rcu_print_task_stall() if the rcu_node
> don't contain tasks which blocking the GP. However this rcu_node->lock
> will be used again in rcu_dump_cpu_stacks() soon while the ndetected is
> non-zero. As a result the cpu will hung by this deadlock.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>   kernel/rcu/tree_stall.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b72311d24a9f..4e97c9977d1c 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -267,8 +267,10 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>   	struct task_struct *ts[8];
>   
>   	lockdep_assert_irqs_disabled();
> -	if (!rcu_preempt_blocked_readers_cgp(rnp))
> +	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
> +		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>   		return 0;
> +	}
>   	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
>   	       rnp->level, rnp->grplo, rnp->grphi);
>   	t = list_entry(rnp->gp_tasks->prev,
> 

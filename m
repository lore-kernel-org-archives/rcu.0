Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D68C433F5
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 06:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F20610E5
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 06:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhKCGyN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Nov 2021 02:54:13 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:26532 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230152AbhKCGyM (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 3 Nov 2021 02:54:12 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A36RCAu028127;
        Tue, 2 Nov 2021 23:51:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=kfwenw28jhKJHuu6TYIKYwDcwW/IlTnWXgK+9r03kWM=;
 b=T8t+0LHubJ6pI/XTjqt32kBuisa4yUkdtRfmNFnSvZG8ejHUpp8+FaZ2Lf5m1wJ2a9OZ
 Y0rwqd/XioyO5MhKfdg+fMJiNtbdBV44dm5Nu1bu9zBs8xj9dbs5HL1FOZBpuPp0u1FC
 /MCqyYD2BdhyejzpsamUnMeVPjBPa1FVAbykMrKYwaYirntba72PQKaruA68nmeAkW9L
 XsOfdBW7zGOQSdOcFVEfmDhFczltJq7xneC7O5oFJVDURYSqufW5ttqlE3DgVe+iSmHN
 4wVknZsS1oM3NZZc9m+BUX05QTkumr2poGqIsmgTabZ2hxs44Ijt040kAfwJTRTI4GsK lQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3c3ddd89n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 23:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6PaToqQHL5g+BFz6SSd9aCCaiq7Vpava8vZHMZinoOXy6IoYZQKc8eBC4blDTRuJjM91z7kzzqgPw0U6q74LQXkYOHhdVGhYl8+JW0+XhIl6BmPHfxSmTZRnY3QOqNxitaEZhCzRi0E5qVuW3QjPUg8rv/E32jMacG9nR+EeYHVhBLS/qLgDn/51AlF5AepZ6iyy9+4iGcsR3dGTwIHFsbbSzqPaEfWEHUKPjLrbKf/bOmk/T2LCUEw9944FvW5z+Acc9DlRp3Y864Bp5lKcyD6lQ7nw2XO6Zwcs+Sabe4DsjxLruQQyUcQnbFE/wssvUx1bmF1zyo0bQobM0pspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfwenw28jhKJHuu6TYIKYwDcwW/IlTnWXgK+9r03kWM=;
 b=f8lS5WGJn4eTcWyDV3rmZZce1pNODyUXWMXkttzeZKImJOH1KGSiEqyLK5YHSJdSa1/OJs/hRLeFxr9J1cLrRcbzNgdIO91um5KZMCEUWa5YBApwGm2/6t6fdHuCX9ZQtECV7nsJtMunp9NqHLYlt6j7nPmLdQdD4X/qSXYX/2FXPQQ+bl3Ix2gVE20vJXPBoXPZmOqwJP27MEzBNBRAKE6XP22Xs9Hw7/RYzXy3dCM04cIwSZ1XZ5hQeVYZygyKkGH6jVfGrfW5n0Brx9NOz6dWfYA4X6Supod5KNi4rCwf0+Z1sCb3OgTxMSl5obOFQSMfhOle6gPRkZj5ekQloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM6PR11MB2585.namprd11.prod.outlook.com (2603:10b6:5:ce::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17; Wed, 3 Nov 2021 06:50:59 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::3558:2607:4c64:8f5c]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::3558:2607:4c64:8f5c%6]) with mapi id 15.20.4649.019; Wed, 3 Nov 2021
 06:50:58 +0000
Subject: Re: [PATCH] rcu: avoid alloc_pages() when recording stack
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dmitry Vyukov <dvyukov@google.com>, qiang.zhang1211@gmail.com,
        RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        miaojun0823@163.com, ryabinin.a.a@gmail.com,
        Alexander Potapenko <glider@google.com>,
        jianwei.hu@windriver.com
References: <20211101103158.3725704-1-jun.miao@windriver.com>
 <96f9d669-b9da-f387-199e-e6bf36081fbd@windriver.com>
 <CA+KHdyU98uHkf1VKbvFs0wcXz7SaizENRXn4BEpKJhe+KmXZuw@mail.gmail.com>
From:   Jun Miao <jun.miao@windriver.com>
Message-ID: <baa768a3-aacf-ba3a-8d20-0abc78eca2f7@windriver.com>
Date:   Wed, 3 Nov 2021 14:50:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CA+KHdyU98uHkf1VKbvFs0wcXz7SaizENRXn4BEpKJhe+KmXZuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HKAPR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:203:c8::21) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
Received: from [128.224.162.214] (60.247.85.82) by HKAPR03CA0016.apcprd03.prod.outlook.com (2603:1096:203:c8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.4 via Frontend Transport; Wed, 3 Nov 2021 06:50:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe6075b1-37a5-48a6-28fb-08d99e964aab
X-MS-TrafficTypeDiagnostic: DM6PR11MB2585:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2585D625289E3A2FF60569168E8C9@DM6PR11MB2585.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+d2/pw/6oF4MdQNlffyfM7deh0jupklOv3XQ6gFJJ3KPe5YP9DCrZvnghyXGfJASRi/hOy/a/ias5hdwTIUXpCqAOzaKTmmpuexiTY7z5Ovh4ap0eOfoxpbJ3ECtzjU1xDbrKIAzybA1ktJxNPUyecl9YX/+6xvlExujyS/ZDNhJmhHAEI2FJ0d5VSFhDt9bn35XEvkG3FgobnIBC4uuu3A4+OrkKgvCkXQVD91AyTIYlV8QULQBafYErTIaavaE0tR7VqJgCfSVuQ/GP7joj2RTbe9YSfKMObvvV4JFAd/e5yrXIdQvk8Hs4RYG2Ki6za3sGb7YWQvBHxjRcNSJJ2FuNffXdfLb3ovc9zDufI5VfZ1E5nCL/ftnuhFCQzywBzk+nWyLtiFM5IrCu9HksT6Ay5MBuYviu6bsdXZDL6pJfzZM4YcslxQ+fjWrI7SUmSjZSyX3KKcSOQRv4Im0Xq/L4VR+YhwUVqr/FeT1XPTPftpc+CtHzrpxQ1i+SkcOoJtnohLaNEQYeg64uLzreobWF2LUFFcxB6SxmOHgrHqAFjWKMnWzivbK7xO4Q7pphXQawJ+aAzTx6ebDIPGRdbIEcf24mwHDCZVejF9CEQWTKd6JbcS+rDptQrqiyUK/mdJ7BGu0pDeOFnpKfLhMYbSe7ZZnulG9zrx/ylwz2IZ0FzsnbOGGL3xEGt3VAONpHIKcCtM904KI+gPEvXBui2/IKr1JxezZcbHD+ZaBoPuw5HLhSx+ZEGRr3aQPLpTpwSzdfZtRHpAGfITajQxypbdhJbaBXdRofPTOzOHBOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(44832011)(5660300002)(6706004)(8936002)(16576012)(54906003)(956004)(8676002)(316002)(2616005)(83380400001)(6916009)(6486002)(4326008)(53546011)(107886003)(52116002)(66476007)(66556008)(66946007)(66574015)(6666004)(31686004)(508600001)(26005)(36756003)(7416002)(31696002)(86362001)(186003)(38100700002)(38350700002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFRNkM5NkQ0UkEvTzVSWDJldTh5KzlRWWpGSkdUbkZlSTBTazh1SUdKSTRL?=
 =?utf-8?B?WE1zQ01taEJPdVJldGlUbnpadmhqcEpUc0xBM2U1Mkd2MHVnRjNwWWx4dEho?=
 =?utf-8?B?ZVRJYjZlVHRVWUJEMC9CNUExVVB2RVlzbkZxSWNCa2hHbnhBd3pydUJzZlJr?=
 =?utf-8?B?ZU5XNnZlMjgwMHYyTkd2bCtSSk5OdnNLOUVyRWtxK3FPSkxCeENuMnJOcDNR?=
 =?utf-8?B?OVJzSWdjdHZYV1ZvdWlQb2QvQ1V0RWVMMzRlTWYvS2ZSdmdXRmdJMExsTW9R?=
 =?utf-8?B?dW9uR3BQWWZSMjRZZnlOZzR0cmV4djRLQ1lwN0NYeHNSZ0s5cjgwYjdlZktQ?=
 =?utf-8?B?OWViU2sxWWl1bWdRaHA4akVPZnhuQytXRVFpZURiYWxZSDIrM2g4MWhiaHg0?=
 =?utf-8?B?VEFLTjdiclkyeFY3aDVla1N0ZkpBNjRPaVRYNHd0dFBkVGJxRzN2dFlaaXAy?=
 =?utf-8?B?WnBBNmQreG1QYW5saVduaVoxM2dGMHFrdElSaUJKUEFLY1NZUTdZOEhoQXk4?=
 =?utf-8?B?L2tuUUZlenFvZERWUm1qZGp3SmpYUE4zUkVBUmpDeEk5K20zYWdrQUhIbkI3?=
 =?utf-8?B?UzEveVc4d3ppa3pXdzRMWlZCKzdFdmdqRjVhVklpZXFHUzN0TWJ3R25IdFY5?=
 =?utf-8?B?Zmc4OXpNOHFCZzMwaUN0TWpGM2dTUFpHNTFrVjhSR09LbXJsZ1hvRkI4Uklw?=
 =?utf-8?B?bEh3NG1QVUtvdVJDZEVVK1FQWW9KTEUxNkdaekhmR2NVTWRlZjlLRC9YZVpz?=
 =?utf-8?B?ZE9nS2tGZ0JCUnR1QU1HMWNIOXk3cFVRdU1SZkVhTU03cy8rb00yRDlPNElm?=
 =?utf-8?B?SHF3a0ZhQ3NHcFY4NjQ2Y0VheE1NWnVHaEtGUTIrUXdBMm8zTVJISE14ekJS?=
 =?utf-8?B?eWxUMzRJSmFiNVBoSnc4M2dTREVnZVlNNFB4V2RnRG1Icm81dllmVDBtM3h2?=
 =?utf-8?B?dDFMTFVEVXFKblh2TXF6NU5lays1WVM0cURZbG0vdG9SWWJIYXgrKzYySU5Z?=
 =?utf-8?B?S0g0aHVnOWlwbDIyS3RxWDlmOE0xejNNNnV4SXB1MTJ3WDMxbElhZHorVGlM?=
 =?utf-8?B?TDVObDdTUUdHbWtybllYUm9zdzJoUTBtRzlVcVFGbk5jRHh5eFVzNVBBN002?=
 =?utf-8?B?TndkVjErcnpwRUJoZXlvOEZ3Y2JIdlQrbXBSNDI0ck1mcXJTT3BUTkVrUEl2?=
 =?utf-8?B?MlM5ZUV0WFpUVDNCeWY2TGFxSVo2QlNzaHlQYWJ6dXE4ZlpuV0Y4L0pvUitR?=
 =?utf-8?B?SkNuZVltN05Idk51U0NvRlVIZ2tmQjhPTkJSVE51ZTJRb3JiMUNjZ1ovUzIz?=
 =?utf-8?B?cXdOR0M3dUh4QmpaUlVnU0RYeXJHK2ViM2Z1WkdpdThMVGpBaEo1ZW43YUZP?=
 =?utf-8?B?VUU1QWtOQUZpbXZnL25kQXJXTXZKd1diQ0dOdmNQMFoyNlIxaEFXcTRTTi9k?=
 =?utf-8?B?dXpHaWY1ODBkNmtIM3FhdzNpdy9xOW0xMytCVHlHdys0Sk5yRjcxZm9zYkpC?=
 =?utf-8?B?ekdQMGlOc2VvQTdMYWN0cm55NmkzVXIxR0FUTjN2eEFwVUxoNkhaTDJ3MzNs?=
 =?utf-8?B?YVY3aFI1Sis5NEFGamI5YStsREFXbjA3TUE5eFlaL0Q1MVBSWXh6T052NnJG?=
 =?utf-8?B?TTMyaythVnM1WUJWRy9VUXBENFp2eEo5QnFObWtyeHc5ZldVKzBqZlBRVklo?=
 =?utf-8?B?N3BtNTd6SDBYYzlqOGlnTlJpUjloZU1zTm1XY2lLRGFHVHdlejcrRGJlL2pz?=
 =?utf-8?B?OC9UOFp4ZDZ2YWhRR1R0Z0hjYVIzR04zVmxLWVFneWZWUVVaUnEzVU4rZmF3?=
 =?utf-8?B?bXpqUm9YL0hKaGczM3VwWDRBSEp5Qk5xRVlJNkx0ZCtLY3RZUm52L050MDVP?=
 =?utf-8?B?Yll4WFV2aElVTE4yOEFqelphcEZ4dndUWVpwTUtIRGgxaTU2d0gxSGo3WStY?=
 =?utf-8?B?Sm10a2ZQWXphUXlQVTJpYW1ZVVdvVG1NaXpLdVJBUy85dENZQ01jVlZPVlhr?=
 =?utf-8?B?MTlpTTVUM2FaTGRtZnM1LzFZMFpSdHNlMlhKNnp3V2VydUJLWWhoNm45L3dZ?=
 =?utf-8?B?L3RmZ0FqUHRLWjBVUWViR2lNTGhZQ01Jem1MeFpocTgrZDhja0xvNi8wNTMy?=
 =?utf-8?B?TTFSY3JyT0tHUi8wRS9kWHh4eURPRFlhbVI0WDhHc09jSnJJd1o2b2Vuc1Zx?=
 =?utf-8?Q?IV6tff3yKSk/cfW1LcKOY64=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6075b1-37a5-48a6-28fb-08d99e964aab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 06:50:58.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXMsVspkW5brfMUaBLe2vB0ly0KyZpxm8SSd/wLF4bHu0QKkW/qzBPs2EVsDBNnQCtaHbflx/hl3pdcMM+1Gdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2585
X-Proofpoint-GUID: cTCRAoQgrMs9xTWX6unl-Q96-7ztB_fs
X-Proofpoint-ORIG-GUID: cTCRAoQgrMs9xTWX6unl-Q96-7ztB_fs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_02,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030043
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


On 11/2/21 10:53 PM, Uladzislau Rezki wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
>> Add KASAN maintainers
>>
>> On 11/1/21 6:31 PM, Jun Miao wrote:
>>> The default kasan_record_aux_stack() calls stack_depot_save() with GFP_NOWAIT,
>>> which in turn can then call alloc_pages(GFP_NOWAIT, ...).  In general, however,
>>> it is not even possible to use either GFP_ATOMIC nor GFP_NOWAIT in certain
>>> non-preemptive contexts/RT kernel including raw_spin_locks (see gfp.h and ab00db216c9c7).
>>>
>>> Fix it by instructing stackdepot to not expand stack storage via alloc_pages()
>>> in case it runs out by using kasan_record_aux_stack_noalloc().
>>>
>>> Jianwei Hu reported:
>>>    BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
>>>    in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15319, name: python3
>>>    INFO: lockdep is turned off.
>>>    irq event stamp: 0
>>>    hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>>>    hardirqs last disabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
>>>    softirqs last  enabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
>>>    softirqs last disabled at (0): [<0000000000000000>] 0x0
>>>    CPU: 6 PID: 15319 Comm: python3 Tainted: G        W  O 5.15-rc7-preempt-rt #1
>>>    Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN4F, BIOS 1.1b 12/17/2018
>>>    Call Trace:
>>>     show_stack+0x52/0x58
>>>     dump_stack+0xa1/0xd6
>>>     ___might_sleep.cold+0x11c/0x12d
>>>     rt_spin_lock+0x3f/0xc0
>>>     rmqueue+0x100/0x1460
>>>     rmqueue+0x100/0x1460
>>>     mark_usage+0x1a0/0x1a0
>>>     ftrace_graph_ret_addr+0x2a/0xb0
>>>     rmqueue_pcplist.constprop.0+0x6a0/0x6a0
>>>      __kasan_check_read+0x11/0x20
>>>      __zone_watermark_ok+0x114/0x270
>>>      get_page_from_freelist+0x148/0x630
>>>      is_module_text_address+0x32/0xa0
>>>      __alloc_pages_nodemask+0x2f6/0x790
>>>      __alloc_pages_slowpath.constprop.0+0x12d0/0x12d0
>>>      create_prof_cpu_mask+0x30/0x30
>>>      alloc_pages_current+0xb1/0x150
>>>      stack_depot_save+0x39f/0x490
>>>      kasan_save_stack+0x42/0x50
>>>      kasan_save_stack+0x23/0x50
>>>      kasan_record_aux_stack+0xa9/0xc0
>>>      __call_rcu+0xff/0x9c0
>>>      call_rcu+0xe/0x10
>>>      put_object+0x53/0x70
>>>      __delete_object+0x7b/0x90
>>>      kmemleak_free+0x46/0x70
>>>      slab_free_freelist_hook+0xb4/0x160
>>>      kfree+0xe5/0x420
>>>      kfree_const+0x17/0x30
>>>      kobject_cleanup+0xaa/0x230
>>>      kobject_put+0x76/0x90
>>>      netdev_queue_update_kobjects+0x17d/0x1f0
>>>      ... ...
>>>      ksys_write+0xd9/0x180
>>>      __x64_sys_write+0x42/0x50
>>>      do_syscall_64+0x38/0x50
>>>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> Fixes: 84109ab58590 ("rcu: Record kvfree_call_rcu() call stack for KASAN")
>>> Fixes: 26e760c9a7c8 ("rcu: kasan: record and print call_rcu() call stack")
>>> Reported-by: Jianwei Hu <jianwei.hu@windriver.com>
>>> Signed-off-by: Jun Miao <jun.miao@windriver.com>
>>> ---
>>>    kernel/rcu/tree.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 8270e58cd0f3..2c1034580f15 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -3026,7 +3026,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>        head->func = func;
>>>        head->next = NULL;
>>>        local_irq_save(flags);
>>> -     kasan_record_aux_stack(head);
>>> +     kasan_record_aux_stack_noalloc(head);
>>>        rdp = this_cpu_ptr(&rcu_data);
>>>
>>>        /* Add the callback to our list. */
>>> @@ -3591,7 +3591,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>                return;
>>>        }
>>>
>>> -     kasan_record_aux_stack(ptr);
>>> +     kasan_record_aux_stack_noalloc(ptr);
>>>        success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
>>>        if (!success) {
>>>                run_page_cache_worker(krcp);
> Yep an allocation is tricky here. This change looks correct to me at
> least from the point that it does not allocate.
>
> --
> Uladzislau Rezki

Thanks your approval. Could you like to give me a review?

And This fix patch is my last patch in WindRiver by using email of 
jun.miao@windriver.com. Because i will go to intel next week.

What about your advice @Paul E

---
Jun Miao

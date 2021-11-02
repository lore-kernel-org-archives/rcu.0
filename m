Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A030C433F5
	for <rcu@archiver.kernel.org>; Tue,  2 Nov 2021 04:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0217460F4B
	for <rcu@archiver.kernel.org>; Tue,  2 Nov 2021 04:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhKBEYV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 Nov 2021 00:24:21 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:25134 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231881AbhKBEYU (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 2 Nov 2021 00:24:20 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A24ITQQ028707;
        Mon, 1 Nov 2021 21:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : from :
 to : cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=/HKvzSBHiAFiEJzjJcdLf9zPdqvs82Saea3uAusCAhM=;
 b=olyBIAkYTov46UhxjYkLCkiz9a8n6lVJmoiKB8xJqK8wmmMBFlLBWG/YiIgUIn8Kaz9d
 +iIxAt1Ok5oUvum3TxhvrRCh4rKX9HqehkZvzUI3N8YZk+dYTmARUN3EWNG3CfZA96oW
 7vz6szwoIMZ2MbD8GmENtU3EKA+zwalYyE3cNIcWmNEwLQcchfPbBgiq97NWi2Jetxhn
 k0u2bB67/b9gdnMUr5cGRDbJ7cZ8Uilg7vqG4xnf4sHQ6npWTlTEYX23gpodYolH4Wph
 OAnUfC5QDqzupPmr/bGffBWZM5lwSYldqprG6t/xQz6+oJgRugsbyh8Dd5o+aXte043S Tg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3c2u5y83g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Nov 2021 21:21:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPFd9ncd02pJE+OQPOmmTd7cLKgkEEnVuz5cB0k5V/0hUI2w3onVgLU7LCa4KEPWTrUDaPEueLJKxL9e0HGdcbLylNqXqIsNm8GcZJN44pV4bgT1Phcy8Q0EcPEmfXKAaJiwmxIdPwebYEhbybdSkmrxZAGxcuU22R1MPWNxu9R0fyxZBGr3QBpfDzKywqPAK4AMdiTq2TWYv6Gi+jJoXh7R4k+lqDAHyiFaZSTES5xxRAnwW62Avqkrz5Stol8YPIVMgTQQ/YXuG399DIJU8yUd21wYkFOmwrUG9iABx7v3pXE9FygpZzM/o9Ch3yf4fzks/9vi7JsNYtRu1aKDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HKvzSBHiAFiEJzjJcdLf9zPdqvs82Saea3uAusCAhM=;
 b=hd51fA7I88X9070yLWHGzKyf4PsQPdHtQ9NmQI0YRdZc6FeNaHNE8sQinJmApSC0Q7GN+9OCIdGtiifBnvJOIlzcFDfPs6tHvgbCta2VtU3bEBguf6SW+gxWqbHayDTYhYYYVgRlOG+yAB5SrSeNpmdClPBL/c242Itd4C3tFK2cQxb+AMmtG8NwwlObAdcqpYDSHGKEBKCKqWU9rr8rdTrlmzJi2Ys3HEmhCPnAye0vH9YC4s5VpY0LETLEmeeRuq+ZO7ClQaje4gFPbDLlcp3W9rA9ewwNyH8hwMdEQf6SRk0LBHxEydQGQqUqXanRvK9DGZw7IoMYpZt6M9dxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM6PR11MB4137.namprd11.prod.outlook.com (2603:10b6:5:199::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17; Tue, 2 Nov 2021 04:21:15 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::3558:2607:4c64:8f5c]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::3558:2607:4c64:8f5c%6]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 04:21:15 +0000
Subject: Re: [PATCH] rcu: avoid alloc_pages() when recording stack
From:   Jun Miao <jun.miao@windriver.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, dvyukov@google.com
Cc:     urezki@gmail.com, qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, miaojun0823@163.com,
        ryabinin.a.a@gmail.com, glider@google.com, glider@google.com,
        jianwei.hu@windriver.com
References: <20211101103158.3725704-1-jun.miao@windriver.com>
Message-ID: <96f9d669-b9da-f387-199e-e6bf36081fbd@windriver.com>
Date:   Tue, 2 Nov 2021 12:21:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20211101103158.3725704-1-jun.miao@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
Received: from [128.224.162.214] (60.247.85.82) by HK2PR02CA0160.apcprd02.prod.outlook.com (2603:1096:201:1f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Tue, 2 Nov 2021 04:21:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6067c9c2-9867-40d6-867f-08d99db8359f
X-MS-TrafficTypeDiagnostic: DM6PR11MB4137:
X-Microsoft-Antispam-PRVS: <DM6PR11MB413729D732BE5260A9D2B5A28E8B9@DM6PR11MB4137.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEi1US/JDDPgmWW3NQvVd7yCRRKtY/I7DVDWTtlrea4s9R7raQgipZ/NcgUaNsMdtsEWmi6V4iHASBudVSy0FWG3CXEvlnX2sqhu0yofPE8Kdhse5tpluopDE0RRD4ElCzsBytIZsXdUXjDXcviL1VED0aToH6eVFeQiJAKcxcPuVGxPlYpZPRyisp/QHvbV6MWIDFBCu1LgfMR2scW6knkRg7HPu6UHr3HvxNaEMHiS7kFTXrDAMfTyk3FNc7UiUTjqcw3i+ZdXmO9RDubacSVKj60/8UNhrfS0G6XMs19Z2IDfnH5jeZioSJv9m76ybC0EL2wWLdSLYofUveOteEhkfgxQBf2C5GJHfUe+XRpALrIdyMfE/h6+4QIZSyQlvVJIYvUhUgpYHZ/2ezPsSQYdC0mM1LtK/fk4eOEn4jKVzbct8jAtJzAdZoPG1aUzftxA4Hj26IVFwWLjnuoofK8mEllVLKPcxCM4/5lK/LKVZRpkfg9LaLL1FzS1Ixf5MHKQzDOLevId9P0uHS8NBilXrE5BHtTA7t0dbyuN4tjZ/ElCn/URKrIOO7yWyttZUomhhIY+3rJLHCLAS4gMHKO6w3VSUBaLWWvsv975yixhX3hbRd6hOoeOxQ5ER4zr2Oil+oNZVgOi4KUrD+Yykgb4kCkhz1zKQzBzt6kfGyY0Z/cPqWceIZsiJN4kuvMHP+9uILl4DqSdivdOAY75Z0iFFJKJXPRwRZm613ivtLI5+3wqxr/JZaAvoGzLgBVqaCxeSc8YkxpbHMrUoR/f3/O0a55vgL8STOCQqYvJy6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6706004)(186003)(8676002)(38100700002)(5660300002)(508600001)(38350700002)(26005)(4326008)(8936002)(44832011)(7416002)(52116002)(31686004)(107886003)(83380400001)(86362001)(16576012)(956004)(2906002)(2616005)(66946007)(36756003)(53546011)(316002)(31696002)(66574015)(66556008)(66476007)(6666004)(6486002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhVd2hNY3J2bUhLZTludkNoVGlneEhRcU9RbXgxRVY0clZ0bkVtU1lXanQ1?=
 =?utf-8?B?azhTMVY5TDZFRG9ZUmU4Tk5idGQ1RGhlWWJyM0FONlQyNlJrTVhOeDFSaEZH?=
 =?utf-8?B?ZU9EYnNvaDVoNVpYdFRoM3JUdXZCNTREcEw5eE9iMjlJRzFNSUpGdDVYbUVi?=
 =?utf-8?B?WVdmNVlCcUFVWGJ2ZFZvWEpWUXMvV2VIVlkrajlGVHZOWWhIUnNRcmk4R1FC?=
 =?utf-8?B?OWZyVXhPNUhOaUE5emJodUZwTnJjeWNnY0pranZMMGRCbU9jZ0J4WUNGS2pM?=
 =?utf-8?B?RUJ3SHZPZG1hS1NGTEJwY1BjMTZYRjFCSDh4b2VOb3BDWnozeFZTVkQyVVI0?=
 =?utf-8?B?anQrZWFaVXpXZFp6OWJ0SXR1K0M1ZjBtVENQcHc0aUdQY1E0SmN5dllxNGdi?=
 =?utf-8?B?SGJSK2Z5TkFpUi9ydFl6YkhyUExDUFNxSGNXVG1iTWhBVjcvSGFqbGNVZlg2?=
 =?utf-8?B?SDJDWi9YT1NuRmlhR1dkZlJJbkxaY3VWbUVKSUx3SGxCYTJsSktSNG1jTVRO?=
 =?utf-8?B?OWY3SWY2THZnMFFuR0kyR0JwbVgyWDZoQlBYcmp2dnRUc0xWU2xqQTJ1QXdN?=
 =?utf-8?B?NVFGYmliQVdQbVNxR2s2RFp0ZklEdFZYdEdRTmsveEFmUEZuZXpmQ3JZemtu?=
 =?utf-8?B?VWtuaXFNVXdPR0dMUjRpQmx2ZzlXRUNpYWptME9JdlJJUWpLZi92MDlHR1Ns?=
 =?utf-8?B?cDk1K21aZ2VIalJHVWNHamJ3a3hPYmh6NEhxd1doRlFKeEhQTXQ0WWtIVlRp?=
 =?utf-8?B?SzI0dzZRUWZXUkVvelZCYVhGNGJTcVRSd2k2M1ZiVnd0b25nZjRoVHgzT0VQ?=
 =?utf-8?B?Uk4rbU00K2xqMDA5SkZDaU15TzJxUzRtMzdyRWZ3VzhOTFFsK0lBYkk3TEQ5?=
 =?utf-8?B?ZWQzNS9BaEU4OTIyU1JYTXNYRWE2cEM4WG9RZkxJSWh4cXI3UU1RWnI2TWtw?=
 =?utf-8?B?SCtRYmJKdU5mcUF0MFZsQ0hxNDlNUFJUNmlTS2M5RzEwSitwMTdHYi9MeUlC?=
 =?utf-8?B?OHVCb0tHM1IvWWN2TTJqSFc4dkx6aTZpL3kxNUFUdXpQTHliZW5xMHo1ZW82?=
 =?utf-8?B?MVUzK284SGNxZHkwcWk4Uk5uTm1hc3Roa0Q4dUFIRTNmRy95dDZFVUM0c0VX?=
 =?utf-8?B?eEhubmxoZElEL0NuM1c2S0ZjbDFReXNPZ3VCZWNiNENzU3ZwR0QxVjQ5dUFo?=
 =?utf-8?B?cjZDUlFrbnRkZjdQSzE0ZHliZEZuY0FZUkVuY2thbVpTK2p0TUFNSnZORDJ1?=
 =?utf-8?B?RXUyZmVUOVFkcC95OUxzVUtuczB4OWVMd202cUUxWGdyWVNjWDczSEpSb3Iz?=
 =?utf-8?B?U21jaGs3N2c5dTkvNTBKdmYzcjdUREdRa1M4RDZ6d0xCa2ZmNE9uaDFPcys3?=
 =?utf-8?B?U3hKdXE5R1g4dGd3NFZRQWx2SmtiWTlvNzhzbTRNNFU2YWFhaDhxa2o5Y3Fr?=
 =?utf-8?B?ZzVPcGtjaDBtMkplcVVFRmY2aDVlYUpyRGtmOGxCRkQzNVZieEQyVzRwdjRS?=
 =?utf-8?B?ZTZmQVJsTUEzcVo2dzkxdFNGbkRXM051UHNJWE15U0FhcU4zRGRpZHRFNXNl?=
 =?utf-8?B?UnVyN1l4MFgxMTRvRmhWSHR1YWp1RDFsQ01OREMyQ05XeDBFWkZGbWZSVnNJ?=
 =?utf-8?B?MU5UdWdDaXpnOWpudWVJTmdKdFNsNkg4dmpNVXdzdExDZk96Q3B6Q0tKbWxT?=
 =?utf-8?B?dFpmeGpBSlIrUlE4SUhKQWprQ0xLRk1tdFAyN2VZblNJSHRUYjJxUjFObTAr?=
 =?utf-8?B?c3Q1OHVNSDlpeXErdjVMRjk3dGVqck1Cd1FVWjJBWU42dFBCY25aL1RSeC9P?=
 =?utf-8?B?bXBLV3RUMS82Zm80WENYRVJ3L1JTQW84ZW96MjFzQmZsUFprV0ZXOFN6azZ5?=
 =?utf-8?B?THAvenFMWVZTbHdqazVQWEhVbVpBdmt6c3pyMnBPZXpjeXlNU283QUhESjFa?=
 =?utf-8?B?SHRnQ01kOHlhWGFxU0tmbko3b3Q3aUE1QWhwaWJjdmRLVXR0aitPK21wMC9a?=
 =?utf-8?B?eEJOMHk1dXg2TUxpalVDN2tSVk5mMFNESlE4M2lxTHI3UDRkUlcxYkZGUG5E?=
 =?utf-8?B?L3dUSFJCZXBiQ1RqeFRQekZsUnZhUnZaUXRJM2d0VXM3M0lkL1ByZ3hkYS8z?=
 =?utf-8?B?T3JWVnRRVTd5bFpKbUhjWDJqdWNDcU1rV1k3TDF1aU1QTUhTM0kvRnlLb1hN?=
 =?utf-8?Q?wRLMi3N+0APiIFVkZGFS13w=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6067c9c2-9867-40d6-867f-08d99db8359f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 04:21:15.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0okwh6dylVJnptP0BxKWxpspL5knmR+5hS9NBdhUTEJtlSVJPhpaMZ7vKrYaL05VWMc0wbCnW3Zj0kYC/hEQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4137
X-Proofpoint-ORIG-GUID: jI5DKTgQ3dFh7E2RO9mdSJ8ER7v9JYxi
X-Proofpoint-GUID: jI5DKTgQ3dFh7E2RO9mdSJ8ER7v9JYxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_01,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020023
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add KASAN maintainers

On 11/1/21 6:31 PM, Jun Miao wrote:
> The default kasan_record_aux_stack() calls stack_depot_save() with GFP_NOWAIT,
> which in turn can then call alloc_pages(GFP_NOWAIT, ...).  In general, however,
> it is not even possible to use either GFP_ATOMIC nor GFP_NOWAIT in certain
> non-preemptive contexts/RT kernel including raw_spin_locks (see gfp.h and ab00db216c9c7).
>
> Fix it by instructing stackdepot to not expand stack storage via alloc_pages()
> in case it runs out by using kasan_record_aux_stack_noalloc().
>
> Jianwei Hu reported:
>   BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
>   in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15319, name: python3
>   INFO: lockdep is turned off.
>   irq event stamp: 0
>   hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>   hardirqs last disabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
>   softirqs last  enabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
>   softirqs last disabled at (0): [<0000000000000000>] 0x0
>   CPU: 6 PID: 15319 Comm: python3 Tainted: G        W  O 5.15-rc7-preempt-rt #1
>   Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN4F, BIOS 1.1b 12/17/2018
>   Call Trace:
>    show_stack+0x52/0x58
>    dump_stack+0xa1/0xd6
>    ___might_sleep.cold+0x11c/0x12d
>    rt_spin_lock+0x3f/0xc0
>    rmqueue+0x100/0x1460
>    rmqueue+0x100/0x1460
>    mark_usage+0x1a0/0x1a0
>    ftrace_graph_ret_addr+0x2a/0xb0
>    rmqueue_pcplist.constprop.0+0x6a0/0x6a0
>     __kasan_check_read+0x11/0x20
>     __zone_watermark_ok+0x114/0x270
>     get_page_from_freelist+0x148/0x630
>     is_module_text_address+0x32/0xa0
>     __alloc_pages_nodemask+0x2f6/0x790
>     __alloc_pages_slowpath.constprop.0+0x12d0/0x12d0
>     create_prof_cpu_mask+0x30/0x30
>     alloc_pages_current+0xb1/0x150
>     stack_depot_save+0x39f/0x490
>     kasan_save_stack+0x42/0x50
>     kasan_save_stack+0x23/0x50
>     kasan_record_aux_stack+0xa9/0xc0
>     __call_rcu+0xff/0x9c0
>     call_rcu+0xe/0x10
>     put_object+0x53/0x70
>     __delete_object+0x7b/0x90
>     kmemleak_free+0x46/0x70
>     slab_free_freelist_hook+0xb4/0x160
>     kfree+0xe5/0x420
>     kfree_const+0x17/0x30
>     kobject_cleanup+0xaa/0x230
>     kobject_put+0x76/0x90
>     netdev_queue_update_kobjects+0x17d/0x1f0
>     ... ...
>     ksys_write+0xd9/0x180
>     __x64_sys_write+0x42/0x50
>     do_syscall_64+0x38/0x50
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Fixes: 84109ab58590 ("rcu: Record kvfree_call_rcu() call stack for KASAN")
> Fixes: 26e760c9a7c8 ("rcu: kasan: record and print call_rcu() call stack")
> Reported-by: Jianwei Hu <jianwei.hu@windriver.com>
> Signed-off-by: Jun Miao <jun.miao@windriver.com>
> ---
>   kernel/rcu/tree.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8270e58cd0f3..2c1034580f15 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3026,7 +3026,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>   	head->func = func;
>   	head->next = NULL;
>   	local_irq_save(flags);
> -	kasan_record_aux_stack(head);
> +	kasan_record_aux_stack_noalloc(head);
>   	rdp = this_cpu_ptr(&rcu_data);
>   
>   	/* Add the callback to our list. */
> @@ -3591,7 +3591,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>   		return;
>   	}
>   
> -	kasan_record_aux_stack(ptr);
> +	kasan_record_aux_stack_noalloc(ptr);
>   	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
>   	if (!success) {
>   		run_page_cache_worker(krcp);

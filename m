Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FDFC48BE5
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 10:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4934F61351
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 10:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhFVK7h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:59:37 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:62912 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhFVK7g (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 22 Jun 2021 06:59:36 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MAsqAw009734;
        Tue, 22 Jun 2021 10:56:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by mx0a-0064b401.pphosted.com with ESMTP id 39avpmrmrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 10:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et9boo52Rdzb0V4+GEiylV5q648aXZk48YQRl8Zve0/B1i4l4ylUfF6up+LqWN8EClO5oYvFNRbVhOKoPVpbP/YBxpHdLZT5fhvRJHmaFPuMdqY7mW2z83jY0gbyKD6YZQLXIE6hg13t0HaanlTeok6dQFeGtO8B3ZvjIJEKWG0FeOdQRcnLaTgerVi6MaZ55WvfkiPQj8CgdrtM+X82jxEj83yYsmUyLaDPBxtG7k+LihW0k9EeOU13dphv++xOTSa1kCUAyIslWH6MDDhJu7Nr05prlmvao0i8+G9YgctYqVw0RZKfQmGtque2W7uL0ufGVVjah9rJLHYCXQrycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTK8/a4sBUS48QFxabKqaRDVhlhy3fuYRKjRsxqHtBo=;
 b=Ai05snVEIXhGCMRepmm4AXEpJnSKkd7kkWI1GknOVEiBEw0Afhu23k8goba+OHPa22P74fOvaN/oJGmLui52NWlhlgi5z+dkJoBRoSr6OSL0WubB8UMCWwpHzTjGL7tkXZTCYE/YVdDl320ckYEpDxUoQihHmbgVM0uBsqV5BNB8ElW/sqBw4ggnBr30v7CB/d50o9lRCaw3DrqsNaMHlzelRRRz7BTKeiZGLPnpI8lOyUm4aiDjYDVsG+1sA34JKzEHCXIr7bU5/NH/dWSKcczX5YXC9D5fQwgWBwgKUvLG7HlhMcEBMZGM/1wIQhdV1VSNLO3ueJMCKzsw6UXq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTK8/a4sBUS48QFxabKqaRDVhlhy3fuYRKjRsxqHtBo=;
 b=emzA1igICQIkhYLGXkGd6Azyo0tg9/mf2e14iWUAFE75C5UOqjUAQxvnL4TzXxNtfCmidGW57QO1lsyZ2Vn+A75VlVONFElrbnDif5fV6O5UILNzQzXhWUO2Y+UfDQ1hw5ULujqLkGxtU4R/3Ar2PRqKu9dzrz8/mIDFZGgzNlc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SN6PR11MB3309.namprd11.prod.outlook.com (2603:10b6:805:bd::14)
 by SA2PR11MB5081.namprd11.prod.outlook.com (2603:10b6:806:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 10:56:39 +0000
Received: from SN6PR11MB3309.namprd11.prod.outlook.com
 ([fe80::a170:9c84:bd22:f77c]) by SN6PR11MB3309.namprd11.prod.outlook.com
 ([fe80::a170:9c84:bd22:f77c%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 10:56:39 +0000
Subject: Re: [PATCH] rcu-scale: change rcu-scale report.
From:   "Han, Jiangong" <Jiangong.Han@windriver.com>
To:     paulmck@kernel.org
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
References: <20210605070019.30377-1-jiangong.han@windriver.com>
 <20210609203711.GL4397@paulmck-ThinkPad-P17-Gen-1>
 <127fc462-375e-7e1a-2ecc-dd647f3bcb89@windriver.com>
Message-ID: <405e1757-45c7-583c-6e1f-1ed54cd935ac@windriver.com>
Date:   Tue, 22 Jun 2021 18:56:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <127fc462-375e-7e1a-2ecc-dd647f3bcb89@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [147.11.105.121]
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To SN6PR11MB3309.namprd11.prod.outlook.com
 (2603:10b6:805:bd::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (147.11.105.121) by HKAPR04CA0003.apcprd04.prod.outlook.com (2603:1096:203:d0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 10:56:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30fc1b6e-233f-4920-06cc-08d9356c69a8
X-MS-TrafficTypeDiagnostic: SA2PR11MB5081:
X-Microsoft-Antispam-PRVS: <SA2PR11MB50812CB4E9605537D934C84D9F099@SA2PR11MB5081.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:287;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyPABEELvCemtdtUfVvWKnF2eveXpnpSXysruVAw8i2fynsTLamvMPTnO7OREuhfezwcxqyr/qW2P+fr1BxFH8tpBigUEPdxf+Cn7giBSrM8ripba0uVcLm8jluqNdQHuY6GX+9JJ/PLGJrxFT5CNphrJWt0kw06zniVSZowNgHRggd5E1aU73nrXY2yXbzgya99dDaAe4vbs+JEb8uCOjArBtYqP0eo4GxVetRGy16fbWK1dp7J2d2gAjjQkGfntCxtVqjtpdTkH6xN4QoY855rtxPDgKriI8S5JAjRwCzf/ms36lwKcIdIAW+dUUK2820s1WKy6Uj11m0utM6xNDNsNaSta5dT55IYGTZwPXBUDyq2ytCdy1mDF9ztOO6i+Wgl6a5ZaUB5XuL8M/Q8d1WmEsz+IGRLjW0Qk2rFgIqIYVr1P+LJ1dTgPIitIpC7oiHGTzqtlOOpWFtgU3JfBHMtcp4U1P1zcUTmwYdBhgkDAMrFOaz8eJnmG2BP08gX/Q0+WwB5QnvDPPR7U6p/EsjbY1ol+UjV5DYPoOAwcTJKKZCZd+a/F1nKi04LUdDQe/VKGmGmeCIByRqJTwdVPOItHvsMaDUheHeHyip170Nr06qS1KqP3vD8bIqq0P9cf5fIBC2a3pUF2kWEXXJdPoF4CgCdPqmwtOSqSojRb3R7z/XaZHtw2Tt2UW6bWhP6XDKwB7928Zkn3lyoqh24PI2LB3ax3OLfmw7knR1Om5+D3YhH/Cr8dSxR2t/Ly6MWBaeApozY8DY7nS74lWaseAi5t3LrUrv9w74DyTqchUEjak4RUvli2pC6E+t6mwx7fX/CjImxz9iBt3Uk7cZwrZIwCnsJsMUUrjtaYabGQKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3309.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(136003)(366004)(396003)(2616005)(956004)(478600001)(2906002)(966005)(6486002)(6916009)(6706004)(4326008)(5660300002)(36756003)(31696002)(38100700002)(38350700002)(31686004)(186003)(83380400001)(26005)(8676002)(66946007)(66476007)(66556008)(16526019)(52116002)(8936002)(86362001)(16576012)(6666004)(316002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azIzQzRmcXUyMWFNL1hNYkdJTWhBb0VRa0hNRUZJeGJzazBuSWx5Mkg0cHRJ?=
 =?utf-8?B?N1NzY0pxUEFxNXhDQVRLSGlycU1aQng0T0cvU2JXTUpkUmVNWVZLUUIwcURY?=
 =?utf-8?B?WTIvanFDOUc1MHJ6MFBYYmpuOVJwWk92RkxpZjNOYVM2LzY2NWhDOG53RnV2?=
 =?utf-8?B?cDYzWTR1MjF3OXoyYlR0TStzdWhFU0RGQzlNRksrRzhmOURtWFd0aDRyQlAr?=
 =?utf-8?B?STRlU1huZldwdHVaRy91OVo5aDFKVWVmQjBMbVhIdzU3SWFWai9IZEhrZnFJ?=
 =?utf-8?B?MEpIamhMV3ZUbmZpcWhNMytTU3cvU0lqV3NaOFRVeFZFZ0lDNEcvVTVMVHpR?=
 =?utf-8?B?V2pnV3lsRWtyY3g3cHpjTFB5V2hISU9oT0lhUERpOURBZ01mdUg3bU9Ea1Jt?=
 =?utf-8?B?eGN0QXM2UlFJa3V5VjVUU2hsbStTMWUvRzhzcXZFSzM0alFVQmdsOEw1U2ht?=
 =?utf-8?B?eFdDY0hYazJUYjV3ZmNnQTNxM1pOYklUMnFqQ0xEUi83Q01wQVNxN0VNUEZO?=
 =?utf-8?B?VldOd2h5Ny90c2xFZ1dQSWpmNjNmTlYrYzEvWnR6ampwQVFlSWRrSEV1RkJk?=
 =?utf-8?B?UVpmNUFFRXZrcWdWTCtOV3BFejFvd2tOZEtWek5ZNUlFY1hnQTVoZktGQTJ0?=
 =?utf-8?B?cnZsQ0RvVzBHOG1PbUNjeWJIbi92R3JLOGpYTWxXbHRsZ0Z5ME5rTHZuYnVC?=
 =?utf-8?B?M3o0eVlvTzNYV3hBRWhPUFNyQXYrcnNHem9YQmtET29MUTl6QW5Lb1JpbVBF?=
 =?utf-8?B?QTRLbVZ1QzlNUVdvSUdreTl2TFUvczdYQXRlV3V4alo5MkZaSXJWRlF0LzZN?=
 =?utf-8?B?MEpna2o0dmcraXExbktkd3VMOHpaMW9SZTBNVFdaNUM5Y25OOUNZQVVxT0RP?=
 =?utf-8?B?YVBvZllmeTFIUytva1VCZmJsSFZjMlRiRldvalJzRWoxU3JKNmJ5dThyUW9R?=
 =?utf-8?B?OXF0anVvYm1zVXAvaDdTUm1SbUxEQ0hlb2loUVlIVXp5RjAzcEhsOHhkK1U0?=
 =?utf-8?B?WVY1dEl3TjhhanA4eGNVUXByeVRkeEpaYnR4VjVjaXcwcjRXdUI2YVlrbkQ1?=
 =?utf-8?B?bDdWRjRoYXUyYnRtZEtpZGtVQll1TkNDd1lGTjQydWhIb2c2ZDlwbTJYU05i?=
 =?utf-8?B?cnRBMW1tYnoxS2ljbXZSVjNOZnVtcldzemlRd2gwQ3VTV3R0TzI3ZHprTEZ6?=
 =?utf-8?B?TFVHMWQ2cWhzU3RJMVEvOXgyQnJVcm9RcHJ3djRUc0ZVaTNsK2ZiQTVzNjNE?=
 =?utf-8?B?Ly9pTXNSSVhrUnNyMnA0U25YQ3FXS0N6NnA0bGFWR050OXY4aUFEdXYzT2Vj?=
 =?utf-8?B?TThRcGtnYzBqTlE2LzN5a0w4OWxkc3I2R0N1UlVBTkhKU2xlOVFmS0RUTXJq?=
 =?utf-8?B?R20xOGdqZVJKczcwUGtHVHJzaXRnK2xEVmF4ZGtTY0x4VDJzMW9YemNHbStP?=
 =?utf-8?B?c0h1WkkyaEtDZ0pYdVhoaUZLQ0RHN0Y3ZzZNb2g0bVFNVkNhOVhvcDZLTXMz?=
 =?utf-8?B?MlgyNGFqeDM5em5aRG9idEhzQlJSN1RtR1E3Q0duZXovQ2trNXptQWUxSUF1?=
 =?utf-8?B?eGxIS2N4RjNzOHR2RGFtaXFiWStuelRoczl2NWVVODdTdGpXekZuc05haWJm?=
 =?utf-8?B?OTEzQysrTm1GL0dvWktBYWhNRVVPY2FobVRRUGNwU0toUmpHTDdHdVEvS1BS?=
 =?utf-8?B?QkZjWm9aek9qNTliVDdNeFJCcEJrVnV6a1BVVFFPbFFxMk9JNytqT3ZxSXJn?=
 =?utf-8?Q?xPQ3EPvMlCzzgZqajJ5PqHG3dJcseQUqj1/y/eV?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fc1b6e-233f-4920-06cc-08d9356c69a8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 10:56:39.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPfU5XI5iDfh4aWS1Ibq3aaQ+9uNcxsQMUBQCOzPPfP7NDbDY0gNHMtVAeS1lfGmbZPnPr9SZpyH33ZJmzReR74rBRZ2oq0P6Gid0FPEJKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5081
X-Proofpoint-GUID: untGitgWKv0cnU0TYTKxukr6YCwrzmZE
X-Proofpoint-ORIG-GUID: untGitgWKv0cnU0TYTKxukr6YCwrzmZE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_06:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220069
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

and the new edition for reviewing is here: 
https://lkml.org/lkml/2021/6/22/327

Thanks for you time.
Br,
Jiangong.


在 2021/6/22 下午6:48, Han, Jiangong 写道:
> Sorry, my the comment is wrong, and the correct comment should be like 
> below, and I had modify this, and I had resend one more applying 
> review patch email for this.
>
> Thanks for you time.
>
> Br,
>
> Jiangong.
>
> ----------------------------------
>     rcu-scale: rcu-scale returns one less than the real number of gps 
> in the dmesg report.
>
>     The dmesg report on rcu-scale shows there are N grace periods, and 
> gps
>     are listed from 0 to N.
>     This commit make writer_n_durations stores the counts of gps,
>     and shows there are N+1 gps, change the listed gps index begin 
> from 0 to N.
>
>     From
>         [ 8306.087880] rcu-scale: writer 0 gps: 133
>         ......
>         [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
>         [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
>         ......
>         [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
>         [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410
>
>     to
>         [ 8306.087880] rcu-scale: writer 0 gps: 134
>         ......
>         [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
>         [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
>         ......
>         [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
>         [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410
>
> ----------------------------------
>
>
>
>  2021/6/10 上午4:37, Paul E. McKenney 写道:
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> On Sat, Jun 05, 2021 at 03:00:19PM +0800, Jiangong.Han wrote:
>>> The report on rcu-scale shows there are N grace periods, and gps
>>> are listed from 0 to N-1.
>>> This commit make writer_n_durations stores the counts of gps,
>>> change the listed gps index begin from 1 to N.
>>>
>>> From
>>>      [ 8306.087880] rcu-scale: writer 0 gps: 133
>>>      ......
>>>      [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
>>>      [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
>>>      ......
>>>      [ 8316.472860] rcu-scale:    0 writer-duration:   131 28004391
>>>      [ 8316.538498] rcu-scale:    0 writer-duration:   132 27996410
>>>
>>> to
>>>      [ 8306.087880] rcu-scale: writer 0 gps: 133
>>>      ......
>>>      [ 8307.864630] rcu-scale:    0 writer-duration:     1 44003961
>>>      [ 8307.935711] rcu-scale:    0 writer-duration:     2 32003582
>>>      ......
>>>      [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
>>>      [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410
>>>
>>> Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>
>> You lost me on this one.  Why is this helpful?  And how does the change
>> shown below actually result in the output shown above, given that
>> rcu_scale_cleanup() still starts j at zero?
>>
>>                                                          Thanx, Paul
>>
>>> ---
>>>   kernel/rcu/rcuscale.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>>> index dca51fe9c73f..2cc34a22a506 100644
>>> --- a/kernel/rcu/rcuscale.c
>>> +++ b/kernel/rcu/rcuscale.c
>>> @@ -487,7 +487,7 @@ rcu_scale_writer(void *arg)
>>>        if (gp_async) {
>>>                cur_ops->gp_barrier();
>>>        }
>>> -     writer_n_durations[me] = i_max;
>>> +     writer_n_durations[me] = i_max + 1;
>>>        torture_kthread_stopping("rcu_scale_writer");
>>>        return 0;
>>>   }
>>> @@ -561,7 +561,7 @@ rcu_scale_cleanup(void)
>>>                        wdpp = writer_durations[i];
>>>                        if (!wdpp)
>>>                                continue;
>>> -                     for (j = 0; j <= writer_n_durations[i]; j++) {
>>> +                     for (j = 0; j < writer_n_durations[i]; j++) {
>>>                                wdp = &wdpp[j];
>>>                                pr_alert("%s%s %4d writer-duration: 
>>> %5d %llu\n",
>>>                                        scale_type, SCALE_FLAG,
>>> -- 
>>> 2.17.1
>>>

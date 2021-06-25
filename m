Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA021C49EA6
	for <rcu@archiver.kernel.org>; Fri, 25 Jun 2021 02:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893BA61002
	for <rcu@archiver.kernel.org>; Fri, 25 Jun 2021 02:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhFYCDH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Jun 2021 22:03:07 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:24692 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232917AbhFYCDH (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 24 Jun 2021 22:03:07 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15P1sBie012963;
        Thu, 24 Jun 2021 19:00:06 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0064b401.pphosted.com with ESMTP id 39d23yg590-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 19:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwI8f+7n6rq0nr/H9CS0b+E3MXy+4ykfork89s9yMqHlaJ73xk6t48odXQ7rAFyRPDuwFDHUTZHNALF1jJ3QclK449j2Eerh+PuGO2/ecqbiNa1XYAoku6IN63T+GzUjrznpAmFNCAcZvo4H/ZJg7BYWCTkqY01thLfMKIWxoRY/1eCLP0v075bje4DNirA7wm8tzK1EpIE7+0XL3D+JZVECUmgADHvzbI8NcM7aATB7WfKeYwWfFGrE7ucD2L5FRymLdK3do3FcbkkrhRQQP0kYxRmjO+JnGXCfIiwEcoUh6yQhQ4sXZ4ZchdxYAiK2vhrNlD5olyIVWZIJenp1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSSZPyRBgtmwb5t/u1LGzCfZ8DNpc/+yUjIKaCL781w=;
 b=VojPm8VjOzAO7fS3qrfWMacShlXu2ZWuMGiM89gD72Q20M7+URWG9rqdlP0mTnnwJAFrauf/Zc+PJrIA38S94l/y8L7tdEAn8gTB4C+GugG7Tsz+S4hHx7OgBFqChcOFFRRn4w75m9fTF8HhTok82lq4hRraq3z7fPAqXkjGSiF1p9Po9RE93YnOKIYjrj3Gpw2fGngV1Sa5I/2WvLAPX9S+2Z7+MZBN/XEiH7cFhm4bl1iGmKe1KM4ieCMl1tAFLUq++Z+FmvuQc8ub0rTv6GNYfuwbz+WNeARu61lsGnGveztp6OH5oCOvd6i9ZqB+sUuTN99jHJ7ac7JupqXXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSSZPyRBgtmwb5t/u1LGzCfZ8DNpc/+yUjIKaCL781w=;
 b=Cxxs58rg4PDdHGcMPP+4cODJxVaD+bNlZCTUq7+W40PafSrgrhDPQuJfTndbVx/Hdij6emyr0yeVajLXqVUVio9Pxt7Ga81zYmwQMsgGTCSLdQdh4ONDzGVkPrdsDgA/XorMp8yLnvygWgaDUTqjo3t490175NJN5Wb8TyrMz1s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SN6PR11MB3309.namprd11.prod.outlook.com (2603:10b6:805:bd::14)
 by SN6PR11MB3088.namprd11.prod.outlook.com (2603:10b6:805:ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 25 Jun
 2021 01:45:00 +0000
Received: from SN6PR11MB3309.namprd11.prod.outlook.com
 ([fe80::a170:9c84:bd22:f77c]) by SN6PR11MB3309.namprd11.prod.outlook.com
 ([fe80::a170:9c84:bd22:f77c%6]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 01:45:00 +0000
Subject: Re: [PATCH v3] rcuscale: Console output claims too few grace periods
To:     paulmck@kernel.org
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
References: <20210624143424.16158-1-jiangong.han@windriver.com>
 <20210624164045.GU4397@paulmck-ThinkPad-P17-Gen-1>
From:   "Han, Jiangong" <Jiangong.Han@windriver.com>
Message-ID: <0f251dba-0e0d-970f-904a-24b540a175be@windriver.com>
Date:   Fri, 25 Jun 2021 09:44:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210624164045.GU4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [147.11.105.121]
X-ClientProxiedBy: HK2PR04CA0061.apcprd04.prod.outlook.com
 (2603:1096:202:14::29) To SN6PR11MB3309.namprd11.prod.outlook.com
 (2603:10b6:805:bd::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (147.11.105.121) by HK2PR04CA0061.apcprd04.prod.outlook.com (2603:1096:202:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 01:44:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c93bbd2-07dd-4460-7c69-08d9377ad813
X-MS-TrafficTypeDiagnostic: SN6PR11MB3088:
X-Microsoft-Antispam-PRVS: <SN6PR11MB30883316AF2D66452FEF2EBA9F069@SN6PR11MB3088.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcj4ylBj2loZmJGnIlorO88Ac0IhZGYTg0QblV50o2DoFjcvnweCTSTityveJAB3pD+waBK/fI4DFFSymsukoq66e4TuKxfjzyXipXvuAwJgJ+3YNKsR7el3/uhqbhDSrGWlESFsR3Ikpi8fzDzcVL1Z3zAaz4su3fWBae9GHoIjqngGyu9SePj+87VyAFCleUmi2nP91hOmRhD+DSXbHuLzMZ+jB6yun2b91lN1RW/d0n5Uo94Lf+06xERimqCjxnIjWQAowm4C7bvB8vEpiYRrONqUMHxYtCL6nB4a0cjGDeKZCosiqXzBnx/Uz9eIttng9ebe+TBzqDGyoFzxM6ShcSG7I6SHdv8Uifhh+IO+6Nk2yCR5IclaQsXLwvjXr1198gBaxQjhafgC3Z4mgx23q0H+VdA5Mq26MPeUkGvERwR+Pbs4QVfogUcf7yNx5565dDIeS7ol/aFULtufIw7e51pzghFxYhGqrYPENQo5/omRphlS25SPlS7M87MDSq9PqpyjOIUunl4m0v9X0cT7T396kWETdhDLnWyLc5Eck2zA/h2neRpPSDOAFgE4jZhNyQfiGAHvhepGq3FEYMa5IDFtyUIpZAlp1Ip6jtoDeMsCp4zvxR5n9JwXPC9+LoiL9KZI1KcwNq8HXC3HWpMZtXN2vwdAGf0lteqA242Gc0fLE0szwAjf9/Bs8aoaP+hzIc86pdo2WbW6ifAlcFcaFdjNb4qxoi2AoboVvCd/LK/RYwk31N8e9bCrtbQKrfbNYI/AmEGs9kC4xlPqOp0lb1GVJy08tMMzrM6Kzl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3309.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(346002)(376002)(366004)(36756003)(5660300002)(38100700002)(6486002)(83380400001)(38350700002)(6916009)(66556008)(956004)(31686004)(2906002)(8936002)(16526019)(4326008)(66946007)(316002)(16576012)(6706004)(66476007)(478600001)(26005)(6666004)(2616005)(8676002)(186003)(52116002)(86362001)(31696002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNud2owazJpc2h4RmhGTXNTeklVTXA5L2tUWnhoWlVVV0JPS3ZPODdLa0Ir?=
 =?utf-8?B?aC95Z3NVWGs5cWZSUjRkSE5wR3JXSnN3bXRVSlZmeDMzTEk4R0JqS20yTmEz?=
 =?utf-8?B?U1JRTjdETkJDb01lK2pCTDQ0S1JwNklQY1c5UnFENkJuSmJPNGJkdUVEL1Ur?=
 =?utf-8?B?SzFuSnVZcDd0Zk5IcnZNQ3QrS09xVjhqYWx2THl5SE1LaG42OG52dUJSY1Jz?=
 =?utf-8?B?V3J3dWlGZnZPam8wVTZkWU1pcUd5TC9RTHc0c0lFNy80dEgrUUlEQmhOdmdk?=
 =?utf-8?B?YThLM2M2S0dkMVBTRkZKd3F1dU1pK1gwbXdiTWVmVGtqOUVsS1ZUZ09IOExG?=
 =?utf-8?B?MmJtR3VLRVJiNU5pSmc3UWQ5U0VLNUdBQ3hWS0MwV3BVSDJTQ0NESGNvMW1Q?=
 =?utf-8?B?b09SMVdnNHQ1MSs1ZGtpQ0VWZXlDYWU1QlRRQW9iZVhwTnZ6QVo0VDd1U3NY?=
 =?utf-8?B?eGViczJ6U1FBQnRDUEs4K21FQjBJYWlrcVRrOVpTUlZXWVpCWGpLTi9BNzlH?=
 =?utf-8?B?NUtRa2ZWWFJvYTVYTnlCUjF0dHVTL1I5RnAzam8rYktNOER6TTFLMWtYQUlr?=
 =?utf-8?B?VDI4SjlLQ0ZYb01UNDRpZ0ZqQXhxbGZnZEZXdmk3ZURaVVJuWlk3dDgyK0tK?=
 =?utf-8?B?V0VwN0dacyt4RkNleFYvalR2Qk0vc0xBeWpjRmNuNk84VDJlODdDUHlBWVdm?=
 =?utf-8?B?TVFzVmpDN2RQK0s4UGJZdkw4NkhBdjdrWWhTSTVEcVFBMklaZy9CSXc4Rklk?=
 =?utf-8?B?UUNCU1hnZGh4QlYxMCtPYVJiak03REl0K1gwaW9ZQnhMbmFnRXpoR0NONTNv?=
 =?utf-8?B?MHBKeXpzSWh6NGZnb1d1amp1RzhlZmdSMm95QThzREMwTVppM0tSMUU2YkFl?=
 =?utf-8?B?VmZMdUlIL1FsM0dUNUJEUSs3aUxNVHljMXZsb0ZncWpEUWxZU2huNjBJeUpT?=
 =?utf-8?B?SFhRdWIxT0dYcjIweWFRSDNvWElaYWttRXl0YnM2UWo0N1BUWDc4UGtTa2xp?=
 =?utf-8?B?VGdMb3Z4YTZ1M3N6VGJlWmRWZisrbWtlZjBVZ0x5L3Bkc0d6bUZwdjAzbjBW?=
 =?utf-8?B?aXZ0NHZXemVsV1c3OCtrM3VLQmFqTWNYYjZsdDc4VEVIbGVNY3RzTUxOeVpQ?=
 =?utf-8?B?Qy9uWTYrSG9GS3J2T1gxVlhUR01LczJWS1M3dmhKelNmdWNZVUh1UldhNitC?=
 =?utf-8?B?Um5MOXVieXNJczBsS1hWZythZnc3OTVvVUJQRWlCT3lTM2pwWVFKOVpkNUVn?=
 =?utf-8?B?TVBYd3JkY0JqNUx4aC9reFNHL05EZ0VGZVNCangvLzU2S0ZYOHBJcWsyVjhm?=
 =?utf-8?B?TmFPSURkSW8zcDZqS1o2cC9xSjlZWTgxWGVuT3RjZUF0clk1aTlHWm1tVElr?=
 =?utf-8?B?TnVoaElLYTVMZEtTZlBha3oyVmQzNlpNRnd5Rm5YK1hIbkU3eW0zV3hqNGU4?=
 =?utf-8?B?T3NjZ2R2NGFqL0doRkc3U3FSbGt4UFlRUWZveDhjVmxxbUlsTW1rRlRSaTY2?=
 =?utf-8?B?dFQ5NG9BSXJ5ajlyZFhjRGd0aXNlQmZ4UHZGQ0ZnZ2tKZlRtR3htM3BBa3NP?=
 =?utf-8?B?NXQzRGZBWXhMdSs0cGZqbWFETjI2ZURGQWg0SU5IVUNJV2FGbWwzQmN1Z2oz?=
 =?utf-8?B?QStoeU5kUUk5OHZQejdnZFNhVGM4YjNPeXNUdDR0T0syYWFwQlVaTFNWUEk4?=
 =?utf-8?B?ejloTWRER0FhdDhEQVRocHhmajlSbWI5My9iOTkvdStZQnVTMXNuM3J2WVRZ?=
 =?utf-8?Q?5RBfOaJUzY6z7waUZzaFYmyzq8UdbLp3TAobQjk?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c93bbd2-07dd-4460-7c69-08d9377ad813
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 01:45:00.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1D3yF/tU6P5qoqQ/aBedxEbnngELISkkcfQvqOO+AKRKMS76jts7TI6VzXjFFXyIjPaNcJ1CElJ2D5ZNQy1exHUljmLmXZqeD4hh09Q/Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3088
X-Proofpoint-ORIG-GUID: kIezRmX08k1Kgeub4DZAB25aGlEa5E6c
X-Proofpoint-GUID: kIezRmX08k1Kgeub4DZAB25aGlEa5E6c
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_17:2021-06-24,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=897
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250009
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,  Paul,

I think your words are much clear than mine, no missings, thanks for 
your help.  :)
Thanks for your quickly response again.

Br,

Jiangong


在 2021/6/25 上午12:40, Paul E. McKenney 写道:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> On Thu, Jun 24, 2021 at 10:34:24PM +0800, Jiangong.Han wrote:
>> The rcuscale console output claims N grace periods, numbered from zero
>> to N, which means that there were really N+1 grace periods.  The root
>> cause of this bug is that rcu_scale_writer() stores the number of the
>> last grace period (numbered from zero) into writer_n_durations[me]
>> instead of the number of grace periods. This commit therefore assigns
>> the actual number of grace periods to writer_n_durations[me], and also
>> makes the corresponding adjustment to the loop outputting per-grace-period
>> measurements.
>>
>> Sample of old console output:
>>        rcu-scale: writer 0 gps: 133
>>        ......
>>        rcu-scale:    0 writer-duration:     0 44003961
>>        rcu-scale:    0 writer-duration:     1 32003582
>>        ......
>>        rcu-scale:    0 writer-duration:   132 28004391
>>        rcu-scale:    0 writer-duration:   133 27996410
>>
>> Sample of new console output:
>>        rcu-scale: writer 0 gps: 134
>>        ......
>>        rcu-scale:    0 writer-duration:     0 44003961
>>        rcu-scale:    0 writer-duration:     1 32003582
>>        ......
>>        rcu-scale:    0 writer-duration:   132 28004391
>>        rcu-scale:    0 writer-duration:   133 27996410
>>
>> Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> I already have it queued in -rcu here:
>
> 4c154a910344 ("rcuscale: Console output claims too few grace periods")
>
> Or did you find an error in my wordsmithed version of your commit log?
> If so, please point out the error explicitly.  (It looks identical to me,
> but I could easily be missing something.)
>
>                                                          Thanx, Paul
>
>> ---
>>   kernel/rcu/rcuscale.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>> index dca51fe9c73f..2cc34a22a506 100644
>> --- a/kernel/rcu/rcuscale.c
>> +++ b/kernel/rcu/rcuscale.c
>> @@ -487,7 +487,7 @@ rcu_scale_writer(void *arg)
>>        if (gp_async) {
>>                cur_ops->gp_barrier();
>>        }
>> -     writer_n_durations[me] = i_max;
>> +     writer_n_durations[me] = i_max + 1;
>>        torture_kthread_stopping("rcu_scale_writer");
>>        return 0;
>>   }
>> @@ -561,7 +561,7 @@ rcu_scale_cleanup(void)
>>                        wdpp = writer_durations[i];
>>                        if (!wdpp)
>>                                continue;
>> -                     for (j = 0; j <= writer_n_durations[i]; j++) {
>> +                     for (j = 0; j < writer_n_durations[i]; j++) {
>>                                wdp = &wdpp[j];
>>                                pr_alert("%s%s %4d writer-duration: %5d %llu\n",
>>                                        scale_type, SCALE_FLAG,
>> --
>> 2.17.1
>>

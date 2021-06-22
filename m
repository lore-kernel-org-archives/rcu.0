Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99CBC2B9F4
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 10:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F6660041
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 10:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFVKvp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:51:45 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:54764 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229682AbhFVKvo (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 22 Jun 2021 06:51:44 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MAmmXs019343;
        Tue, 22 Jun 2021 03:48:48 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-0064b401.pphosted.com with ESMTP id 39b47h8aac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 03:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrORIjbJCJsgTfB1skONiRXyH7XKbOP3MK5JuwFFO6pKIrkD+iq7dqicbl/SzLcchttBiFDV8dWBhv/UVrzxgHsN+Oj7l2+nFOsSrcqx9skMLKMrE2t029KX7Q7nK8xwJKiiN2yP5WJn9QjFbia/YpSOCNGy2x+ypZjglC0Z+ZYOqhwHJvWc6fJYsPkYce6p7ulo5I0pClyTTRxEzLSxWAizkE2uBncAyBWx/T/iuHAYnAP0EDllYOxrdUAw5FHYqEW0PqpNkiXo1jCO5FPwzf7FFL0wabUOpbDFKOfp/0glHv94XFe/x5aZv/98qv6DN1KYfHxx0cIhOATHNTyHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdFmPqxDEsDy/EY3jp/b/87ZQxPCzhLYb1V3ZYU8snQ=;
 b=lwJGITzzv0MEKincNizV5/g3oR4XMISB0Q7nvA/jBgq+HgouTQwz0dG102E31YqHZzk2qxQahz3KV9sce8VXwJ9anwUDsTzsVq0kOufEWEqgD/ruUgkA1CALiOs7O0mPRslNBsBuen1dpL8YRvNhFoiG8Ns0t4JIDoO7yAo8pEn75vw7EeffszxAlx5yl9AaFVMaYXRwS82MeeNm+yvL/a09YXz5HG6VRboPT/5T7rAKBXe1DOe/5TUGPvebQqD5kAItjCg4ZddFALqzqnrbf3HFcGCL2Jr2kw2nFetVmHoQzaHNS+kGUniPTUP040juWFlaFQEc5gyyriMeo15Y3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdFmPqxDEsDy/EY3jp/b/87ZQxPCzhLYb1V3ZYU8snQ=;
 b=dNNZ9Pb1NRihaf+y0IkBjB0oJ8WEsTcEob97C2Hug06LM+4A1i83DAmzfXQ6XDE6+2eg4Svbtlkckvbbks5XF/Q7T2CY8c2k64BGVBRSvxMTCwy+1VERJzOb62cmQDfkOBo2f1jlBGIe7DzQhBET6uffmvJrUX5gxzr5XdhPKWY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SN6PR11MB3309.namprd11.prod.outlook.com (2603:10b6:805:bd::14)
 by SN6PR11MB3038.namprd11.prod.outlook.com (2603:10b6:805:cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 10:48:46 +0000
Received: from SN6PR11MB3309.namprd11.prod.outlook.com
 ([fe80::a170:9c84:bd22:f77c]) by SN6PR11MB3309.namprd11.prod.outlook.com
 ([fe80::a170:9c84:bd22:f77c%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 10:48:46 +0000
Subject: Re: [PATCH] rcu-scale: change rcu-scale report.
To:     paulmck@kernel.org
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
References: <20210605070019.30377-1-jiangong.han@windriver.com>
 <20210609203711.GL4397@paulmck-ThinkPad-P17-Gen-1>
From:   "Han, Jiangong" <Jiangong.Han@windriver.com>
Message-ID: <127fc462-375e-7e1a-2ecc-dd647f3bcb89@windriver.com>
Date:   Tue, 22 Jun 2021 18:48:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210609203711.GL4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [147.11.105.121]
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To SN6PR11MB3309.namprd11.prod.outlook.com
 (2603:10b6:805:bd::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (147.11.105.121) by HK0PR03CA0105.apcprd03.prod.outlook.com (2603:1096:203:b0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 10:48:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 029c83b5-6119-40a5-0312-08d9356b4f7f
X-MS-TrafficTypeDiagnostic: SN6PR11MB3038:
X-Microsoft-Antispam-PRVS: <SN6PR11MB303839B58255DD15512738D09F099@SN6PR11MB3038.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:287;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrVRuZ3HlEBEGuOIuZHY+o7XW4MzbLMrUcMBr2JzGRY2htE+QH7bZtreLtLS9bsDdT+DFff+9cdniZA68zlufJTFS7NqMAmfjPNBeFcY3UNvHJSNycQkMsbFdFTyVNIJ6IpQF6YAgYzAOQEFuYo2yJ9HfPnRfYPwG9nBDOgqSXsD1X5RAATLpDOIS0ap83ZTCMgUaqtNRWApkxj61/DI9yIZFeOpN/h4m9ZjSnnEYRgNf+Ks0ANnwNSgQmSEjoqWyFkgTVk83rt2uzcUNY7nkFYwFHXXVHTLq5/A2rNzSzgCIbIG3/lAilk6fEF1YLURHzb1FUF43QLw6KdKnNq2tzD5AzRg+321U/MRrsuLOUBQxaXUSfHy6UP3PVEjvuONccjKluCu//8qzDFo5Hyf6C1DF1LGae0Hj9E1/DRhLbugP3ay5O+5Wtym19XEVoUUPT5mDiTwKDXvEUaw6YX8z7MaPq+Jq6VN/CI/MOlS1PjSxiGQ6mzULgRZy5o0KFwS9GP/1rdvloNH8W7Bl/RHOlJTbC0UwrhvxgMsAq7UgNGYP8UYFbL8TDMR9AINFmp2XV5uxsl3Z2wXclZQA1BW7P54k/pR426Sg3xEkGmcaglk6QIigTTYy4xTvwZr1igpT7NroRuaiCPySG8E2S1X06PBOPnOKn+nQDaRnOFVaEQWeGgtwBxN4WviLBJrsRo2uuZOXdbiKNwGLojDOpoJRn8SGdbcauuc0TgqWlGU14tORw6JJeVDkjuIfzTz02c2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3309.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(366004)(136003)(376002)(396003)(6486002)(36756003)(66556008)(31686004)(316002)(86362001)(83380400001)(186003)(6666004)(5660300002)(8676002)(2906002)(66476007)(26005)(66946007)(31696002)(6916009)(956004)(2616005)(16526019)(8936002)(4326008)(52116002)(6706004)(38350700002)(16576012)(38100700002)(478600001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXlpRW1vK29SL290WHFna1d5MUhWTjAySkFpbUpKMnFIOU9BTmI1V2tuRTUr?=
 =?utf-8?B?WkJQejdIUnRBcVBjdm5TNndSb1RjZXdrMjdXUjA4dEpUak1XeXlFaTlTOGxC?=
 =?utf-8?B?Wm42WER5ZXJZdTJzY1pYWlE1NU9QdjBtQ1lUL2ZTK0N2dGw0SHltT3NKaTNU?=
 =?utf-8?B?NkM1bmUvVmwxL0liWlh4K3Y3aVl0Z3pnTVBIWUVadUV5cWtES1drU1Fsd2tJ?=
 =?utf-8?B?S0JYekc3TDcwL1hxQ3lUYkN0VHgwV2N4S2N6Uzk0dVM5SnVHVitWNDBtcnlQ?=
 =?utf-8?B?Z0gxaWRTWmVmVXFwN1RHUUZQd1UwUFlZZmZoYWhXNlN0R2lPMS9sNkd0djRF?=
 =?utf-8?B?T3V6Vk03RzViTE9OS1k5Z21QZEpZa0Y4OTRtQS92MUt3b0VTbkZzYlRIZXFv?=
 =?utf-8?B?Lzh2alFFWUlvUTQvKzY0MmcwMGJzM3VPeHRRd0Y1SzhUelBFK0pDbVFLZXQ0?=
 =?utf-8?B?SmplaDFLTVMwcnVFbTJzSTdDWDBaRmEyOHlUeURKcnR1MVF5L2ZaOC90aUVF?=
 =?utf-8?B?RWJaUGRPdkZjOWN6eUM4anh0TklQZ3VQQ3hjdnZCcnlGOVRmbUpqV3RrWHd1?=
 =?utf-8?B?Y1VsYmNzSGdEU2xQOXV4U2ExY1IxdTZIZVJhQjZxYzZ3THRTVkxub2xJVFpG?=
 =?utf-8?B?blVmMXdUenNwWG1FNTB1STE2SmREWFFXb0h6T3FCcGFIbHdBUEM4dHh5cDh1?=
 =?utf-8?B?MjFmaXFyTGFJU2RnUzdFNDFvM2FXbENsQXBVY0NJRHE1WDR5czNKajZxWitl?=
 =?utf-8?B?TXo0ZEM0TVRoT2RhNmJtQkNaR0FHSVRGUlZpL29JYkp4TTB0bFkxb2Z0VlAy?=
 =?utf-8?B?TGdOVE5WNFNEVTNuQWZnSEM2NVdqRmtudGduR2o2aktsOG5xVHV1eUYwTVRm?=
 =?utf-8?B?TXBmeU5XOUtSK0NEWTQrQ2hHOStEV1c1US9BVTB6bFRiNk9YQk84aFNnVWlE?=
 =?utf-8?B?Ry9SbUhMcHRDcUo0UVNkc2tFVHY5TkVIVVlpSWx0ajh5SkUvRkFIK1NsR0tw?=
 =?utf-8?B?UVFZWWtoblc1K0JWeWxVYjFrUVZWa3ZQWjlpYlRwSjExNUJyeFhlVjBTWE81?=
 =?utf-8?B?L2E3OUtIYlBkNHV4bVZVRXhpUkRpMkh6TVAwdVkyK3VjK0pwRlpBZGlKY0dj?=
 =?utf-8?B?a2xiaGNTUC85Z0ladXBqVm4rNHlTNzh1U1QyRGczSzZCNWZCRThkRXA2ZVhS?=
 =?utf-8?B?R1pMOFVZUGhhSlc5UHZJcForbGxHWGkxM1FLREFFSVBSdGRjZGRnRXYxUWRO?=
 =?utf-8?B?RDk3VHVZb2NsQ3pORFpYSGFRYnpIdCt5SjFBWFNlb3dHelFIQXpmSXdNaGt0?=
 =?utf-8?B?YnZNdzBqUzlIK1pkVDRNQlNUK3l4MHRnUTQvT0c1RnMvVnlBWVRDcDhlNWNK?=
 =?utf-8?B?N3U5c0NkVDZxL2dzcVEzNTRXeEM5K2IwWE50aFF3ZjR5NVB2Q2x3VWtXempL?=
 =?utf-8?B?YkJpR2czZmhsUFREdjB2WTROYmNKU1RHU0cwOVdwZWIyQ0dWMXpGeWFKZ1Vl?=
 =?utf-8?B?dnhUWFU4RTNwemxmYTV0Q1RnSk0wNFZzYzlvc1NPQU1NK0NNSTFpYUZrVFZM?=
 =?utf-8?B?OWZqaUVDemJZV254cWNrN25FL2tqL1BleXU3MlJFeEU0dHk3SDFmTGxENWdJ?=
 =?utf-8?B?V0tNVDVEa3BlMFJkUFFrM0JRLzRkaW1yekNKYmFjdmRWZFl4Q2MzT1RaWTBV?=
 =?utf-8?B?UG9YSWU3cWYrZHpoa2g2Y1djTzBObng5c0dLd3pOR2tmNUIzVDBBM3YwRmx5?=
 =?utf-8?Q?GSFy4PexRsZM0YUE5dJIYjyNCxKkEZVyM4G4xew?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029c83b5-6119-40a5-0312-08d9356b4f7f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 10:48:46.2191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vCWHGIBdoz6NmTctM0Qb8MGPi5GWbyKZLt4b/qTpow15nv1Aa5lwElo+cnp7qVmyUadR3JmUtMfLmkzC2uDwYC7vO9j+ZtC3OcQ+GBhKtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3038
X-Proofpoint-GUID: 5JT0RiuLc9mNAJ0qeNWdubddWhB4A65A
X-Proofpoint-ORIG-GUID: 5JT0RiuLc9mNAJ0qeNWdubddWhB4A65A
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_05:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220068
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sorry, my the comment is wrong, and the correct comment should be like 
below, and I had modify this, and I had resend one more applying review 
patch email for this.

Thanks for you time.

Br,

Jiangong.

----------------------------------
     rcu-scale: rcu-scale returns one less than the real number of gps 
in the dmesg report.

     The dmesg report on rcu-scale shows there are N grace periods, and gps
     are listed from 0 to N.
     This commit make writer_n_durations stores the counts of gps,
     and shows there are N+1 gps, change the listed gps index begin from 
0 to N.

     From
         [ 8306.087880] rcu-scale: writer 0 gps: 133
         ......
         [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
         [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
         ......
         [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
         [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410

     to
         [ 8306.087880] rcu-scale: writer 0 gps: 134
         ......
         [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
         [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
         ......
         [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
         [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410

----------------------------------



  2021/6/10 上午4:37, Paul E. McKenney 写道:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> On Sat, Jun 05, 2021 at 03:00:19PM +0800, Jiangong.Han wrote:
>> The report on rcu-scale shows there are N grace periods, and gps
>> are listed from 0 to N-1.
>> This commit make writer_n_durations stores the counts of gps,
>> change the listed gps index begin from 1 to N.
>>
>> From
>>      [ 8306.087880] rcu-scale: writer 0 gps: 133
>>      ......
>>      [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
>>      [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
>>      ......
>>      [ 8316.472860] rcu-scale:    0 writer-duration:   131 28004391
>>      [ 8316.538498] rcu-scale:    0 writer-duration:   132 27996410
>>
>> to
>>      [ 8306.087880] rcu-scale: writer 0 gps: 133
>>      ......
>>      [ 8307.864630] rcu-scale:    0 writer-duration:     1 44003961
>>      [ 8307.935711] rcu-scale:    0 writer-duration:     2 32003582
>>      ......
>>      [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
>>      [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410
>>
>> Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>
> You lost me on this one.  Why is this helpful?  And how does the change
> shown below actually result in the output shown above, given that
> rcu_scale_cleanup() still starts j at zero?
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

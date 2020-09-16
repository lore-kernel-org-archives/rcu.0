Return-Path: <SRS0=+/rT=CZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D61EC43461
	for <rcu@archiver.kernel.org>; Wed, 16 Sep 2020 06:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A6A206A5
	for <rcu@archiver.kernel.org>; Wed, 16 Sep 2020 06:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="P9G3aizO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIPGc5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Sep 2020 02:32:57 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:39713
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726161AbgIPGc4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Sep 2020 02:32:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWp68CSfQMzzOW5U/hYg6DZc+sbLkQss/L89g5ikVBs6wDBIF5+TGfix/UqgboAiZn6o1qXIbKwCZnTKXD5AecMCCT2SK7f2GZu7v/Bxi7sZ/JKYQVUkxfZd3qpj6GRKlEQLiweuGSImlDst10/ADTpB8xkUostjcDpAmBaggxJAt4h7goZJfFs4+WHtDtOzRJim9D086FVUTsAcX29yQIulTXJdzAn5JqW0NwYvWSZydBezwt6F7RCjohw4DAv992nAuljU3A6GvIUFX12QcY8ndeeHv9W1dfXwse1A9uOe3NXWyIjN0xvCSGXpls1mOILmadboymOzTDIcScqNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v32Mkl8uM7sL3wf1lpr8Vqn9ze9+JN20zd9lc9dVRtI=;
 b=VvKV1MEBeqJ/DpxOpNl1vPNZWdCKn3KY/dWx/lKjvcdx25tQdLD0tl6E4nB/L+NbqOwLMRveXcGGE90yQOpSU41sXQFcM5KJXWBRmTcYD1qS7gToMoXPFp++SYlVWaOnW6U0f6x5Gja4uRgX7BOPLEB+EE+bziZxetHR6j0f7svqZEZvphGIGcEK/rMBOnxU3j6TlbaGBEr7vpLih7PWIVXPLASBeMvlOKhLk1arice7YnU4o4aYWxVfb9RZhiNX/U/GhLiIP02ERDcPrdj+I3En3a5/GSxgxMfLoU+OTRWoswqOUKkgGkuXp5IMZ6GXGIn2BAbT1kd3gRsiv0KDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v32Mkl8uM7sL3wf1lpr8Vqn9ze9+JN20zd9lc9dVRtI=;
 b=P9G3aizOV1WZFVUhIxmNLBmltHDMd0Kd+CYn7QEuiBsfk8KJMeqScAaIredZdR40uFaB7427qR9S+ejz1gJ6hGN2akmQHo8FDgoQIwpIFl8+2Yqdo44SKmqYQEtsdarcegibDKCIvCpN1mxP2b5nrHyZPR4EN3cjlSnUT1C1q50=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 06:32:53 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 06:32:52 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUkNVOiBRdWVzdGlvbiBvbiBmb3JjZV9xc19ybnA=?=
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <BYAPR11MB2632C4C06386B39BB5488428FF230@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200914194208.GA2579423@google.com>
 <20200914205642.GE29330@paulmck-ThinkPad-P72>
 <BYAPR11MB263207BFF3AFB6A9D1A7A32FFF200@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200915034139.GK29330@paulmck-ThinkPad-P72>
 <1079509d-c474-42bd-44e9-18cfa948fbae@windriver.com>
 <20200915180613.GQ29330@paulmck-ThinkPad-P72>
From:   "Zhang,Qiang" <qiang.zhang@windriver.com>
Message-ID: <ef4e4da7-d5e2-4655-0fcc-54b6d4c34a71@windriver.com>
Date:   Wed, 16 Sep 2020 14:32:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200915180613.GQ29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::22) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.183] (60.247.85.82) by YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 06:32:49 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2a925a4-b37a-4202-582a-08d85a0a56ce
X-MS-TrafficTypeDiagnostic: BY5PR11MB4241:
X-Microsoft-Antispam-PRVS: <BY5PR11MB424196204088FBE106FC3771FF210@BY5PR11MB4241.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uW3im+BnhhUytmJWXU9Rshbziyz6hYpqUoqIQSjCD6lesm/8i9NvL2UunryOiXlwxCdeoALNV3E85S26gSeSiEtwiBqlEBGoFkGjt9c+63f+2SAeb7tSa6hjKCzqqf//r62TY101Pu8XmLkwPPJj4ISlI/DHpLBsdiyZ/w7t93XEUbx/F5NmRHizmYm3NfqBGr22kbNQil/S1fEO4tOUDJNyo4O47OEYQP/kSp7immSZJX331BovP85gP8pS3TwKuhlIhhLuCfbvUGgsCPN515cDX80ksUWW+dX847cqr6JJ2/MUhdwGdpAHfCSK/mYU293bCHvLdlRLJUNnGhX2gB9pYp3b1N/ByDVjvhTfTx0ecsU1wdchw2HCqcnpqSTKpA0EFLTB0xvIo/vm4wCv/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(366004)(376002)(396003)(136003)(86362001)(6666004)(5660300002)(6706004)(54906003)(6916009)(478600001)(31696002)(66946007)(66574015)(83380400001)(66556008)(66476007)(224303003)(52116002)(31686004)(16526019)(6486002)(316002)(53546011)(16576012)(2906002)(26005)(186003)(36756003)(956004)(8936002)(4326008)(2616005)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ePXmiroGO5IPzHUm08+atCK+I/GH6BHPoUxCKwnI6+NdthUyh6NlAVDgmH73pJC7B5XfaPPLzPzLYnaZIhzd3HZqqJttAUC7HBmj105JrAmPKPvMeVH/rBqAY0BGOJhx/W1BGAhLO6GqCSPK2GqBfVIGy9K3ERUeHQVcMymfso2Vu+uBm3ADPDKt5xkJMIiBFcNgpHxIf9q4Qik16B0exaaEOxpmOpSPggDy/NSzXN/hPZ5agVVuh3lOnkbJm3dW5ru4n87foQuiGnvNx5hU+zLCVnQzgAa04o3fu+G/khvIkog6RWrBH4BjLofk5XOPo6hamPREC3o78U0WhED6/mCOi0LNel/6+P7lpwoCUzymcR7RDWW+ydks7u30qpeufNVBbOsJbnKYS6zcI89LPEriM5bZapua2N424yeqqhuoDMDbaDS5d/rrHlcXyLT4MBRaF3QZGACt13EPquRxXuA//U14LuvvpxmYxEothKqtFSkOnuEMUs9tphWHsXUMU23/N68tCzUpO4Mt7qsqQxoHScwZfYYoJRAMY7HQu4pL3hdfDVbYcy33wyujmpKYr/M5fMaLv60Uq11s2v+MjQdHZAEFsOypkwjWwzYU2qaZd1brUKgTvpOA1F7LcZpxpb4WIINAYd4jyAc7/+xYzg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a925a4-b37a-4202-582a-08d85a0a56ce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 06:32:52.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SB//DysgtfA6KkUFzAuqY5M2qdY33O4+fxuaQOIdKlgZv0rlQ1dYcpLKOwQSFEiXC3g1ZKFxXG5zC07GA78v9rO9dwS5cGpCeZ1oJ1Xck04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4241
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/16/20 2:06 AM, Paul E. McKenney wrote:
> On Tue, Sep 15, 2020 at 01:16:39PM +0800, Zhang,Qiang wrote:
>>
>>
>> On 9/15/20 11:41 AM, Paul E. McKenney wrote:
>>> On Tue, Sep 15, 2020 at 03:18:23AM +0000, Zhang, Qiang wrote:
>>>>
>>>>
>>>> ________________________________________
>>>> 发件人: Paul E. McKenney <paulmck@kernel.org>
>>>> 发送时间: 2020年9月15日 4:56
>>>> 收件人: Joel Fernandes
>>>> 抄送: Zhang, Qiang; Uladzislau Rezki; josh@joshtriplett.org; rostedt@goodmis.org; mathieu.desnoyers@efficios.com; Lai Jiangshan; rcu@vger.kernel.org; LKML
>>>> 主题: Re: RCU: Question on force_qs_rnp
>>>>
>>>> On Mon, Sep 14, 2020 at 03:42:08PM -0400, Joel Fernandes wrote:
>>>>> On Mon, Sep 14, 2020 at 07:55:18AM +0000, Zhang, Qiang wrote:
>>>>>> Hello Paul
>>>>>>
>>>>>> I have some questions for you .
>>>>>> in force_qs_rnp func ,  if  "f(rdp)" func return true we will call rcu_report_qs_rnp func
>>>>>> report a quiescent state for this rnp node, and clear grpmask form rnp->qsmask.
>>>>>> after that ,  can we make a check for this rnp->qsmask,  if  rnp->qsmask == 0,
>>>>>> we will check blocked readers in this rnp node,  instead of jumping directly to the next node .
>>>>>
>>>>> Could you clarify what good is this going to do? What problem are you trying to
>>>>> address?
>>>>>
>>>>> You could have a task that is blocked in an RCU leaf node, but the
>>>>> force_qs_rnp() decided to call rcu_report_qs_rnp(). This is perfectly Ok. The
>>>>> CPU could be dyntick-idle and a quiescent state is reported. However, the GP
>>>>> must not end and the rcu leaf node should still be present in its parent
>>>>> intermediate nodes ->qsmask. In this case, the ->qsmask == 0 does not have
>>>>> any relevance.
>>>>>
>>>>> Or am I missing the point of the question?
>>>>
>>>>> Hello, Qiang,
>>>>
>>>>> Another way of making Joel's point is to say that the additional check
>>>>> you are asking for is already being done, but by rcu_report_qs_rnp().
>>>>
>>>>>                                                          Thanx, Paul
>>>>
>>>> Hello Pual,  Joel
>>>>
>>>> What I want to express is as follows :
>>>>
>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>> index 7623128d0020..beb554539f01 100644
>>>> --- a/kernel/rcu/tree.c
>>>> +++ b/kernel/rcu/tree.c
>>>> @@ -2622,6 +2622,11 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>>>>                   if (mask != 0) {
>>>>                           /* Idle/offline CPUs, report (releases rnp->lock). */
>>>>                           rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>>>> +                       raw_spin_lock_irqsave_rcu_node(rnp, flags);
>>>> +                       if (rnp->qsmask == 0 && rcu_preempt_blocked_readers_cgp(rnp))
>>>> +                               rcu_initiate_boost(rnp, flags);
>>>> +                       else
>>>> +                               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>>>>                   } else {
>>>>                           /* Nothing to do here, so just drop the lock. */
>>>>                           raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>>>
>>> But in that case, why duplicate the code from rcu_initiate_boost()?
>>>
>>> 							Thanx, Paul
>>>
>>
>> Hello Paul
>>
>> When we force a qs for rnp, we first check the leaf node "rnp->qsmask" if it
>> is reached zero, will check if there are some blocked readers in this leaf
>> rnp node, if so we need to priority-boost blocked readers.
>> if not we will check cpu dyntick-idle and report leaf node qs, after this
>> leaf rnp node report qs, there is may be some blocked readers in this node,
>> should we also need to priority-boost blocked readers?
> 
> Yes, but we will do that on the next time around, a few milliseconds
> later.  And by that time, it is quite possible that the reader will have
> completed, which will save us from having to priority-boost it.
> 
> 							Thanx, Paul
> 

Thanks Paul, I see.


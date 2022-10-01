Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29B5C433FE
	for <rcu@archiver.kernel.org>; Sat,  1 Oct 2022 02:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiJAC0U (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Sep 2022 22:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJAC0U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Sep 2022 22:26:20 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFBD1A3AF1
        for <rcu@vger.kernel.org>; Fri, 30 Sep 2022 19:26:19 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id b23so3704099qtr.13
        for <rcu@vger.kernel.org>; Fri, 30 Sep 2022 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VTK4OCUfPSqpxkZXHqSrqtU5gJtvyJejBe2MXgnfdw0=;
        b=qbvctjeq/Uw+rqJzICnIeUKaYd6HE/0UYn9pZ3YcgHQn+9Ojvpzfom1ub8/WhPzkDe
         6ecVQc8+6oqq+fIzURBxD6WzZzSWhVGyo3/ABAiqW58gu4qEGJOr+iVc67YJmYwZT1gk
         kZgi3NwJtY9tmwdmeXYms11/uSEU9ivwRjmSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VTK4OCUfPSqpxkZXHqSrqtU5gJtvyJejBe2MXgnfdw0=;
        b=NMshmjugMNOxuX1Uih/R9yWxX0TCW9hh0QQ+Hs68wzB4K30yzuVr3kaf4JH9Fte040
         HIBJJuqpDpSDVR3FYuHt5I2MPTt16ROZD2NAff9+/gQfWwn/8y5KmCVsTq/IQcRu4Nls
         Sna15XPwW1s1uVbDcg3H2cfPIi/d+55orLOv3+Lw3wjUakeVYk2HmwpA45ewbvkIXL5w
         HgjYG3ePzqN+NGFhO6UsK7DQ4a8OLgeQ0LskVE322rRuYRCSukfx2GNsSpv7/RBnGWaw
         iWO8s1c2YFRyhGy5B+cLgTNGZam6Jn6c90iCPliLHcIEavlrXjS8AGPyYrv3Molvfeve
         8rcg==
X-Gm-Message-State: ACrzQf0pVxCew6LCUnlXsfW5oaf56d2cIcP2uzh56uT2gIE4DQdIf6Us
        kYiamXRLdRMOoG0dTnys4JdS3A==
X-Google-Smtp-Source: AMsMyM5vrIGeXMNyl670aLzxzNE3vzMcSJzBTh+7/TGIBgs9h0cWHp379ssHFGzDXXUkV6HmYaK+WQ==
X-Received: by 2002:a05:622a:1991:b0:35b:a3d3:4b0f with SMTP id u17-20020a05622a199100b0035ba3d34b0fmr9138976qtc.358.1664591178468;
        Fri, 30 Sep 2022 19:26:18 -0700 (PDT)
Received: from [10.0.0.27] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id e5-20020ac84e45000000b0035ccd148026sm3385184qtw.69.2022.09.30.19.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 19:26:17 -0700 (PDT)
Message-ID: <a7bfc699-fb8d-6dbc-6b4b-299a88e371a1@joelfernandes.org>
Date:   Fri, 30 Sep 2022 22:26:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv2 1/3] rcu: Keep qsmaskinitnext fresh when
 rcutree_online_cpu()
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-2-kernelfans@gmail.com>
 <20220916145240.GA27819@lothringen>
 <CAFgQCTuB72QZNL4AW95WntkCUqAinzis=6Mjwyfdy_NiMi_pgQ@mail.gmail.com>
 <20220919105149.GA58144@lothringen>
 <Yyk3acmumN7ezhhv@piliu.users.ipa.redhat.com>
 <20220920092303.GE69891@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220920092303.GE69891@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/20/22 05:23, Frederic Weisbecker wrote:
> On Tue, Sep 20, 2022 at 11:45:45AM +0800, Pingfan Liu wrote:
>> On Mon, Sep 19, 2022 at 12:51:49PM +0200, Frederic Weisbecker wrote:
>>> On Mon, Sep 19, 2022 at 06:24:21PM +0800, Pingfan Liu wrote:
>>>> On Fri, Sep 16, 2022 at 10:52 PM Frederic Weisbecker
>>>> <frederic@kernel.org> wrote:
>>>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>>>>> index 438ecae6bd7e..ef6d3ae239b9 100644
>>>>>> --- a/kernel/rcu/tree_plugin.h
>>>>>> +++ b/kernel/rcu/tree_plugin.h
>>>>>> @@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>>>>>>  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>>>>>>  {
>>>>>>       struct task_struct *t = rnp->boost_kthread_task;
>>>>>> -     unsigned long mask = rcu_rnp_online_cpus(rnp);
>>>>>> +     unsigned long mask;
>>>>>>       cpumask_var_t cm;
>>>>>>       int cpu;
>>>>>>
>>>>>> @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>>>>>>       if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
>>>>>>               return;
>>>>>>       mutex_lock(&rnp->boost_kthread_mutex);
>>>>>> +     /*
>>>>>> +      * Relying on the lock to serialize, so when onlining, the latest
>>>>>> +      * qsmaskinitnext is for cpus_ptr.
>>>>>> +      */
>>>>>> +     mask = rcu_rnp_online_cpus(rnp);
>>>>>>       for_each_leaf_node_possible_cpu(rnp, cpu)
>>>>>>               if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
>>>>>>                   cpu != outgoingcpu)
>>>>>
>>>>> Right but you still race against concurrent rcu_report_dead() doing:
>>>>>
>>>>>       WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask)
>>>>>
>>>>
>>>> Ah. Indeed, my commit log is not precisely described.
>>>>
>>>> In fact, either speedup smp_init [1] or fast kexec reboot [2] still
>>>> uses the model: one hotplug initiator and several reactors.  The
>>>> initiators are still excluded from each other by the pair
>>>> cpu_maps_update_begin()/cpu_maps_update_done(). So there can not be a
>>>> cpu-up and cpu-down event at the same time.
>>>
>>> Yes but two downing CPUs may race right?
>>>
>>> So isn't it possible to have rcu_report_dead() racing against
>>> rcutree_offline_cpu()?
>>>
>>
>> Yes, two downing cpus can be in a batch.
>>
>> There is a nuance between onlining and offlining:
>> -1. onlining relies on qsmaskinitnext, which is stable at the point
>> rcutree_online_cpu(). And it is what this patch aims for.
>> -2. offlining relies on cpu_dying_mask [2/3], instead of qsmaskinitnext
>> which is not cleared yet at the point rcutree_offline_cpu().
>>
>> It is asymmetric owning to the point of updating qsmaskinitnext.
>>
>> Now considering the racing between rcu_report_dead() and
>> rcutree_offline_cpu():
>>
>> No matter rcutree_offline_cpu() reads out either stale or fresh value of
>> qsmaskinitnext, it should intersect with cpu_dying_mask.
> 
> Ah I see now, so the race can happen but it is then cancelled by the
> stable READ on cpu_dying_mask. Ok.
> 

Maybe I am missing something but, concurrent rcu_report_dead() on CPU's
of the same node can corrupt ->qsmaskinitnext as Frederick showed. That
may not be a problem for affinities (due to the cpu_dying_mask), but is
that not an issue for RCU operation itself?

i.e. due to the corruption, ->qsmaskinitnext is in an inconsistent state
causing *RCU* issues.

Or is there a reason that that is not an issue?

thanks,

 - Joel






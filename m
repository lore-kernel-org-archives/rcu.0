Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B540C433FE
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 15:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJBPwb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJBPwb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 11:52:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890D120B2
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 08:52:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k12so5454214qkj.8
        for <rcu@vger.kernel.org>; Sun, 02 Oct 2022 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/l6IrCIHS1LoloOSjcheOFQjDt+ZueNH3uIoHHBLwcE=;
        b=PZ1kzNBHw+iqJHlsYqDjjhr40MtAfQIxM4GGQGKImdpeNqiC+KulAbuCy6pbHsCUJs
         UFYr2AmJ2dvlfiwzkHjgiUeuz5lPLXsdpU3XV7R99lUqcz3vGDlKne+4lcvqXUr1rt+0
         K/7ayrLH8ktzVAaRlUrGamlFWVuGcQtE2XZUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/l6IrCIHS1LoloOSjcheOFQjDt+ZueNH3uIoHHBLwcE=;
        b=oG6maFZtsc3ogcBOsmw3UznKSRjfbzP7Qg0J3VDCwUQGSP8IXis+mKJjj/ZarR1LHi
         JimLahZVzI8mAe1t67oXVHP+Hn6rAZnTyVw6kHeJoYbuBLFX89epatp5eFaDsolA4LK7
         T4+mNpJ/Nt4WxIMqxUTlgTpfteCOahBGN8rlUnPTn0FWkIddarximrUOdDh4c6bbaQqd
         zsiyRL1Rswe3UqWDA/y0ZH7kGQEd8pWwj+Qo+Yi+Et4hQ8fS79LLb2Q9YPBTdk034kZP
         Em9nt24HfxSCkRREayi7OoIkI6/V6PpJBALGwIkrJX7680CvfWXTHWWSUotvvwL8G95p
         H8Gw==
X-Gm-Message-State: ACrzQf3nJm6Jjr/LABndVxKcUxEJTbcNgOW1yAfqZtfIqWAJguKl3N3h
        8EYjsU+KW/4Dmilz2j+4dUAFjFL9o3skgA==
X-Google-Smtp-Source: AMsMyM47f6XPpmKIL5ASuSoXQmWlptD+stYTdm2GC/USlQIAehwaC1KINjDcv1GAVwSY1DiB62C+tQ==
X-Received: by 2002:a37:6441:0:b0:6cd:d477:61e with SMTP id y62-20020a376441000000b006cdd477061emr12138406qkb.739.1664725949123;
        Sun, 02 Oct 2022 08:52:29 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a268300b006cbb8ca04f8sm8249389qkp.40.2022.10.02.08.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 08:52:28 -0700 (PDT)
Message-ID: <616401ae-a1dd-71ba-ce4b-ff79c5418f60@joelfernandes.org>
Date:   Sun, 2 Oct 2022 11:52:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv2 1/3] rcu: Keep qsmaskinitnext fresh when
 rcutree_online_cpu()
Content-Language: en-US
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
 <a7bfc699-fb8d-6dbc-6b4b-299a88e371a1@joelfernandes.org>
 <CAFgQCTukQ3_5FEh=ddWw9ffhimrmiUUYecTw7kwDaeGb=L4nkw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <CAFgQCTukQ3_5FEh=ddWw9ffhimrmiUUYecTw7kwDaeGb=L4nkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 10/2/2022 8:34 AM, Pingfan Liu wrote:
> On Sat, Oct 1, 2022 at 10:26 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>> On 9/20/22 05:23, Frederic Weisbecker wrote:
>>> On Tue, Sep 20, 2022 at 11:45:45AM +0800, Pingfan Liu wrote:
[...]
>>>>>> <frederic@kernel.org> wrote:
>>>>>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>>>>>>> index 438ecae6bd7e..ef6d3ae239b9 100644
>>>>>>>> --- a/kernel/rcu/tree_plugin.h
>>>>>>>> +++ b/kernel/rcu/tree_plugin.h
>>>>>>>> @@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>>>>>>>>  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>>>>>>>>  {
>>>>>>>>       struct task_struct *t = rnp->boost_kthread_task;
>>>>>>>> -     unsigned long mask = rcu_rnp_online_cpus(rnp);
>>>>>>>> +     unsigned long mask;
>>>>>>>>       cpumask_var_t cm;
>>>>>>>>       int cpu;
>>>>>>>>
>>>>>>>> @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>>>>>>>>       if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
>>>>>>>>               return;
>>>>>>>>       mutex_lock(&rnp->boost_kthread_mutex);
>>>>>>>> +     /*
>>>>>>>> +      * Relying on the lock to serialize, so when onlining, the latest
>>>>>>>> +      * qsmaskinitnext is for cpus_ptr.
>>>>>>>> +      */
>>>>>>>> +     mask = rcu_rnp_online_cpus(rnp);
>>>>>>>>       for_each_leaf_node_possible_cpu(rnp, cpu)
>>>>>>>>               if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
>>>>>>>>                   cpu != outgoingcpu)
>>>>>>>
>>>>>>> Right but you still race against concurrent rcu_report_dead() doing:
>>>>>>>
>>>>>>>       WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask)
>>>>>>>
>>>>>>
>>>>>> Ah. Indeed, my commit log is not precisely described.
>>>>>>
>>>>>> In fact, either speedup smp_init [1] or fast kexec reboot [2] still
>>>>>> uses the model: one hotplug initiator and several reactors.  The
>>>>>> initiators are still excluded from each other by the pair
>>>>>> cpu_maps_update_begin()/cpu_maps_update_done(). So there can not be a
>>>>>> cpu-up and cpu-down event at the same time.
>>>>>
>>>>> Yes but two downing CPUs may race right?
>>>>>
>>>>> So isn't it possible to have rcu_report_dead() racing against
>>>>> rcutree_offline_cpu()?
>>>>>
>>>>
>>>> Yes, two downing cpus can be in a batch.
>>>>
>>>> There is a nuance between onlining and offlining:
>>>> -1. onlining relies on qsmaskinitnext, which is stable at the point
>>>> rcutree_online_cpu(). And it is what this patch aims for.
>>>> -2. offlining relies on cpu_dying_mask [2/3], instead of qsmaskinitnext
>>>> which is not cleared yet at the point rcutree_offline_cpu().
>>>>
>>>> It is asymmetric owning to the point of updating qsmaskinitnext.
>>>>
>>>> Now considering the racing between rcu_report_dead() and
>>>> rcutree_offline_cpu():
>>>>
>>>> No matter rcutree_offline_cpu() reads out either stale or fresh value of
>>>> qsmaskinitnext, it should intersect with cpu_dying_mask.
>>>
>>> Ah I see now, so the race can happen but it is then cancelled by the
>>> stable READ on cpu_dying_mask. Ok.
>>>
>>
>> Maybe I am missing something but, concurrent rcu_report_dead() on CPU's
>> of the same node can corrupt ->qsmaskinitnext as Frederick showed. That
> 
> There is a pair of lock ops around WRITE_ONCE(rnp->qsmaskinitnext,
> rnp->qsmaskinitnext & ~mask), i.e. raw_spin_lock_irqsave_rcu_node(rnp,
> flags) and raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> 
> So it should not be a problem, right?

Correct, I think should not be problem. I got thrown away a bit by the comment
"Right but you still race against concurrent rcu_report_dead()".

Even with concurrent offlining, a stable ->qsmaskinitnext should ensure that the
hotplugged CPUs are properly considered in rcu_gp_init(), so I don't see a
problem with your patch so far... but I'll continue to dig when you send the
next patch. My fear was if a bit in ->qsmaskinitnext is not cleared during
offlining race, then grace period will hang.

Thanks,

 - Joel


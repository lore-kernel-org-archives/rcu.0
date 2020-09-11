Return-Path: <SRS0=/mld=CU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE66C433E2
	for <rcu@archiver.kernel.org>; Fri, 11 Sep 2020 05:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3547521D81
	for <rcu@archiver.kernel.org>; Fri, 11 Sep 2020 05:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="xe/Lc3RK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgIKFJw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgIKFJs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 11 Sep 2020 01:09:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BBFC061573
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2020 22:09:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 34so5749305pgo.13
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2020 22:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oR6MVe0czZko8wPQxUg17Yo2wMUks4twWfDs3UPZrmc=;
        b=xe/Lc3RKIHtd/3Es0xtznXhv5Ow445/pl+hcXan86QmrfwHtsAeuN+tnOfVHBgLcBt
         f4bA3jCRdMPUEjY9tTkyix/dZRodlBJ1wgQMZrlgXwRNXigGyCoLw9rqr6qVoxKm6M2b
         /LaWesLODN2lJ27jpy0u1EXBmWvD1qPgjNT9rgl2z+6Yg8PuFbip4Fm039fl9mjFWXJb
         CW1vMSye1siW/LUyF5qA/cKASegJVD9Nsw2RMhbbswao7ntQSvHpiK52U3iaWKN8+LC9
         LF0goI7GE4j3RtNNP44ieCzfu445MxWG5fsC93IsApzGygw/bNGLXmuFji45ckrvtfnb
         t4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oR6MVe0czZko8wPQxUg17Yo2wMUks4twWfDs3UPZrmc=;
        b=JbqgnjfUg0V1YLqxtA0SZ32Ip0W1o4S5XoOqULQdwI3IJ7JC/6UKFxIszTl5XqzAVW
         eACRVG56QQL6OM3GAJ71KmkWzsCJoDXg6AvDi7etvN+Pf0MSxCU9vsWCmck6VABpJjVu
         liMyC2Tj/u6IuiG+XtTRkYyzhvqGGTSJDkXIM0AdZwbkQIGw5rk6F1F0Ch8px3+95Uup
         /BlFjZ83T9lHyUZWZSLoT8MNgaE7lozoZe5UVVADfayl7O9nm5KAF5GsGN+m6NbAuKcl
         yY5RUJkC3W1pjtbDj9lsJuLZNtB22pFZElSEicYPVGEjKdm0zvGDyHqkS+HE2N0esVBX
         lnEA==
X-Gm-Message-State: AOAM532/wXA42n+973U/6rpFFXaadz5/HrOVDzdb52DN2V1WjhzWK9M6
        yiZbDmRuUk2KsxY2NGfqLvNBmg==
X-Google-Smtp-Source: ABdhPJwbeEW3PS6Zer9V4wwLx6lb74l7rImJ9x8+mFY2ZMvwMJQB0oaOxml2vHvh4JL0cLwdloS9ug==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr303719pls.89.1599800987116;
        Thu, 10 Sep 2020 22:09:47 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id c201sm809261pfb.216.2020.09.10.22.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 22:09:46 -0700 (PDT)
Subject: Re: [PATCH kernel] srcu: Fix static initialization
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <20200908144306.33355-1-aik@ozlabs.ru>
 <cc25257d-804e-8cf7-150b-e6bdbaf184be@ozlabs.ru>
 <20200909115010.GG29330@paulmck-ThinkPad-P72>
 <37f76aac-d8e3-8ab1-24e9-c417b719e2a6@ozlabs.ru>
 <20200910185353.GS29330@paulmck-ThinkPad-P72>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <611a6a87-f673-c5b7-3b60-58805fba580a@ozlabs.ru>
Date:   Fri, 11 Sep 2020 15:09:41 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200910185353.GS29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 11/09/2020 04:53, Paul E. McKenney wrote:
> On Wed, Sep 09, 2020 at 10:31:03PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 09/09/2020 21:50, Paul E. McKenney wrote:
>>> On Wed, Sep 09, 2020 at 07:24:11PM +1000, Alexey Kardashevskiy wrote:
>>>>
>>>>
>>>> On 09/09/2020 00:43, Alexey Kardashevskiy wrote:
>>>>> init_srcu_struct_nodes() is called with is_static==true only internally
>>>>> and when this happens, the srcu->sda is not initialized in
>>>>> init_srcu_struct_fields() and we crash on dereferencing @sdp.
>>>>>
>>>>> This fixes the crash by moving "if (is_static)" out of the loop which
>>>>> only does useful work for is_static=false case anyway.
>>>>>
>>>>> Found by syzkaller.
>>>>>
>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>> ---
>>>>>  kernel/rcu/srcutree.c | 5 +++--
>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>>>> index c100acf332ed..49b54a50bde8 100644
>>>>> --- a/kernel/rcu/srcutree.c
>>>>> +++ b/kernel/rcu/srcutree.c
>>>>> @@ -135,6 +135,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
>>>>>  				   levelspread[level - 1];
>>>>>  	}
>>>>>  
>>>>> +	if (is_static)
>>>>> +		return;
>>>>
>>>> Actually, this is needed here too:
>>>>
>>>>  if (!ssp->sda)
>>>>          return;
>>>>
>>>> as
>>>> ssp->sda = alloc_percpu(struct srcu_data)
>>>>
>>>> can fail if the process is killed too soon - it is quite easy to get
>>>> this situation with syzkaller (syscalls fuzzer)
>>>>
>>>> Makes sense?
>>>
>>> Just to make sure that I understand, these failures occur when the task
>>> running init_srcu_struct_nodes() is killed, correct?
>>
>> There are multiple user tasks (8) which open /dev/kvm, do 1 ioctl -
>> KVM_CREATE_VM - and terminate, running on 8 vcpus, 8 VMs, crashes every
>> 20min or so, less tasks or vcpus - and the problem does not appear.
>>
>>
>>>
>>> Or has someone managed to invoke (say) synchronize_srcu() on a
>>> dynamically allocated srcu_struct before invoking init_srcu_struct() on
>>> that srcu_struct?  
>>
>> Nah, none of that :)
>>
>> init_srcu_struct_nodes() assumes ssp->sda!=NULL but alloc_percpu() fails
>> here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/percpu.c#n1734
>> ===
>> 	} else if (mutex_lock_killable(&pcpu_alloc_mutex)) {
>> 			pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
>> 			return NULL;
>> ===
>>
>> I am still up to reading that osr-rcuusage.pdf to provide better
>> analysis :) Thanks,
> 
> Ah, got it!  Does the following patch help?
> 
> There will likely also need to be changes to cleanup_srcu_struct(),
> but first let's see if I understand the problem.  ;-)
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index c13348e..6f7880a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -177,11 +177,13 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	INIT_DELAYED_WORK(&ssp->work, process_srcu);
>  	if (!is_static)
>  		ssp->sda = alloc_percpu(struct srcu_data);
> +	if (!ssp->sda)
> +		return -ENOMEM;
>  	init_srcu_struct_nodes(ssp, is_static);
>  	ssp->srcu_gp_seq_needed_exp = 0;
>  	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
>  	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */


The line above confuses me a bit. What you propose returns without
smp_store_release() called which should not matter I suppose.

Otherwise it should work, although I cannot verify right now as my box
went down and since it is across Pacific - it may take time to power
cycle it :) Thanks,


> -	return ssp->sda ? 0 : -ENOMEM;
> +	return 0;
>  }
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> 

-- 
Alexey

Return-Path: <SRS0=9ZY9=C7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BF7C4727E
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 00:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3053D23A82
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 00:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="nXrnj59q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgIVAlq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Sep 2020 20:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbgIVAlp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Sep 2020 20:41:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A74BC061755
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2020 17:41:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so10844520pff.6
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2020 17:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PNKUy9UbxB71ZPxOMn8QCcnMX+5rNdWeZS8ckF8exiY=;
        b=nXrnj59q/BigDoGxqrKS+nz+d5zciYsxKnab5vm7DDfjItfKx7YVwSi35TC7Un+CDh
         CaCSV29g8onW3AURu4PA7jrYgc2cdsuXvYKK1gMhcuIoFBlu8PYRvYzkzrQNHeYBUlEp
         t5gnPzHVjTyIWVWnDeITKsZN1UX+JVX/FoDb0bxXXQ2I0BAGVV9s9JEojMSDES0Nl3i2
         VBFgBLIEf1gCPCH4Ddwc3O8ecdHHxnTKpwj/3YhIp0K2xg/XcVNIPRRoZuQ1SfXA4M7q
         6aFg5oO3RQnIg5/7+/gfjYNzS3FbSJjm23cV5D6NL+zDhaufc3BG9smP4PSbA3PQaoxr
         FB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PNKUy9UbxB71ZPxOMn8QCcnMX+5rNdWeZS8ckF8exiY=;
        b=VyCiZDaPk/x+8Kz7VYeDqyxrSerlgI1MbQ7USA1YvxvoiFqq7LCO+KoIm4AHbjVhHU
         3A72Z6Ds7yqUJEnCSsYMTzZYXgcHji5djAIerhtT4UMsAAnsnY76e+MNbqHe5R84Et9q
         QFhRUwgDdrkTAYlzOlS1PNKFHuJ5+FXOvIJtJFEAkCUVBAhvxOmAvoex7YB7fR4235s2
         1VsqZCO5cIef0QeOcpIGeZV5ZlE8KmVbJ5GQH0uyMM7oQVvWmeeoHg8y2DVUnny1qPH7
         ERQER9N12IOJpDk3CKUFmR9P7nwrnmXk6Ej9Dp2PqKg9QtflUirfplgfhkCCjEl8/rXT
         BJjw==
X-Gm-Message-State: AOAM533qveQgH0fl7kyDCgmLNfmJQAN0ItMsBdFFir4+eUQDYxRqmoZg
        5MTDwHvrIFa6HZ4kJrAhYGyjKQ==
X-Google-Smtp-Source: ABdhPJyt79n191zAavGNJS2WkhpFIM6gerGv5gXOsS5aaxptWFBvCmZ1b0l9Msiq85FeDgjXCriePg==
X-Received: by 2002:a17:902:b186:b029:d1:cc21:9a7d with SMTP id s6-20020a170902b186b02900d1cc219a7dmr2214352plr.8.1600735303844;
        Mon, 21 Sep 2020 17:41:43 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id 17sm12803858pfi.55.2020.09.21.17.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 17:41:43 -0700 (PDT)
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
 <611a6a87-f673-c5b7-3b60-58805fba580a@ozlabs.ru>
 <20200911135208.GX29330@paulmck-ThinkPad-P72>
 <20200916161224.GA30546@paulmck-ThinkPad-P72>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ef2179e0-ddad-05c0-2292-9b9dcfd348f9@ozlabs.ru>
Date:   Tue, 22 Sep 2020 10:41:37 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200916161224.GA30546@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 17/09/2020 02:12, Paul E. McKenney wrote:
> On Fri, Sep 11, 2020 at 06:52:08AM -0700, Paul E. McKenney wrote:
>> On Fri, Sep 11, 2020 at 03:09:41PM +1000, Alexey Kardashevskiy wrote:
>>> On 11/09/2020 04:53, Paul E. McKenney wrote:
>>>> On Wed, Sep 09, 2020 at 10:31:03PM +1000, Alexey Kardashevskiy wrote:
> 
> [ . . . ]
> 
>>>>> init_srcu_struct_nodes() assumes ssp->sda!=NULL but alloc_percpu() fails
>>>>> here:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/percpu.c#n1734
>>>>> ===
>>>>> 	} else if (mutex_lock_killable(&pcpu_alloc_mutex)) {
>>>>> 			pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
>>>>> 			return NULL;
>>>>> ===
>>>>>
>>>>> I am still up to reading that osr-rcuusage.pdf to provide better
>>>>> analysis :) Thanks,
>>>>
>>>> Ah, got it!  Does the following patch help?
>>>>
>>>> There will likely also need to be changes to cleanup_srcu_struct(),
>>>> but first let's see if I understand the problem.  ;-)
>>>>
>>>> 							Thanx, Paul
>>>>
>>>> ------------------------------------------------------------------------
>>>>
>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>>> index c13348e..6f7880a 100644
>>>> --- a/kernel/rcu/srcutree.c
>>>> +++ b/kernel/rcu/srcutree.c
>>>> @@ -177,11 +177,13 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>>>>  	INIT_DELAYED_WORK(&ssp->work, process_srcu);
>>>>  	if (!is_static)
>>>>  		ssp->sda = alloc_percpu(struct srcu_data);
>>>> +	if (!ssp->sda)
>>>> +		return -ENOMEM;
>>>>  	init_srcu_struct_nodes(ssp, is_static);
>>>>  	ssp->srcu_gp_seq_needed_exp = 0;
>>>>  	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
>>>>  	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
>>>
>>> The line above confuses me a bit. What you propose returns without
>>> smp_store_release() called which should not matter I suppose.
>>
>> The idea is that if init_srcu_struct() returns -ENOMEM, the structure
>> has not been initialized and had better not be used.  If the calling code
>> cannot handle that outcome, then the calling code needs to do something
>> to insulate init_srcu_struct() from signals.  One thing that it could
>> do would be to invoke init_srcu_struct() from a workqueue handler and
>> wait for this handler to complete.
>>
>> Please keep in mind that there is nothing init_srcu_struct() can do
>> about this:  The srcu_struct is useless unless alloc_percpu() succeeds.
>>
>> And yes, I do need to update the header comments to make this clear.
>>
>>> Otherwise it should work, although I cannot verify right now as my box
>>> went down and since it is across Pacific - it may take time to power
>>> cycle it :) Thanks,
>>
>> I know that feeling!  And here is hoping that the box is out of reach
>> of the local hot spots.  ;-)
> 
> Just following up...  Did that patch help?


Yes it did.

Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> 
> 							Thanx, Paul
> 

-- 
Alexey

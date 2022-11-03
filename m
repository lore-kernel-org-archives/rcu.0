Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FE7C433FE
	for <rcu@archiver.kernel.org>; Thu,  3 Nov 2022 15:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiKCPNf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiKCPNb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Nov 2022 11:13:31 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 08:13:30 PDT
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7140F55BC
        for <rcu@vger.kernel.org>; Thu,  3 Nov 2022 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667487934;
        bh=uz/AUMquq1p8alDld4JOebuVpzOJjxQ90llEYwuirxU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FcBQ6bXyJWfH1t8OczQkNj1ajIWu/TQVaSQhylyUky2P0FWsLCuzGeqyhNtyzYLO6
         eQJJY83PKED577E/rkjHEaztxlfOZmN65h4xMdmvgu7Zva1jK+9xUt1wZIGqTi8IXP
         Ej3qKBUW4YNBkAx3yNaNs6ZF2QlfyqJBU67mBReptKIyk9EF2q6hLfpi4V4qRBPFod
         QtgMQpDTqqKN528SP0+AKa3wnKw/VEt8hARLwL9GofrRh5Keg1XjEJFMaHCwcgMpkQ
         aqknaJZjNFLDGuTsoX4LzBD9hfg3047/bxEkX7BhtbTWvyW6cJfpiPFgcbekTL7IIT
         qZ4nrjTw+DcHQ==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N36Wf5sdmzfXx;
        Thu,  3 Nov 2022 11:05:34 -0400 (EDT)
Message-ID: <e9d7e96b-e46e-0067-2461-6f5fb0a5b07b@efficios.com>
Date:   Thu, 3 Nov 2022 11:05:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] srcu: Fix a rare race issue in __srcu_read_(un)lock()
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20221103131313.41536-1-kernelfans@gmail.com>
 <20221103133607.GB1410480@lothringen>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221103133607.GB1410480@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2022-11-03 09:36, Frederic Weisbecker wrote:
> On Thu, Nov 03, 2022 at 09:13:13PM +0800, Pingfan Liu wrote:
>> Clarify at first:
>>    This issue is totally detected by code suspicion, not a real experience.
>>
>> Scene:
>>
>>    __srcu_read_(un)lock() uses percpu variable srcu_(un)lock_count[2].
>> Normally, the percpu can help avoid the non-atomic RMW issue, but in
>> some rare cases, it can not.
>>
>> Supposing that __srcu_read_lock() runs on cpuX, the statement
>>      this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
>> can be decomposed into two sub group:
>>      -1. get the address of this_cpu_ptr(ssp->sda)->srcu_lock_count[idx],
>> denoted as addressX and let unsigned long *pX = addressX;
>>      -2. *pX = *pX + 1;
> 
> It's not supposed to happen:
> 
> * The weak version of this_cpu_inc() disables interrupts during the whole.
> * x86 adds directly to gs/fs memory
> * arm64, loongarch, s390 disable preemption
> 
> This has to be a fundamental constraint of this_cpu_*() ops implementation.

I concur with Frederic, this is guaranteed by the this_cpu_*() API. 
There is no issue there.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


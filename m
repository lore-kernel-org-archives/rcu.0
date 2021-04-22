Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B7FC433B4
	for <rcu@archiver.kernel.org>; Thu, 22 Apr 2021 15:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4618C61026
	for <rcu@archiver.kernel.org>; Thu, 22 Apr 2021 15:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhDVPsY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:48:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2907 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbhDVPsX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Apr 2021 11:48:23 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FR1p52bSyz68BcP;
        Thu, 22 Apr 2021 23:40:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 17:47:46 +0200
Received: from [10.47.95.78] (10.47.95.78) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 22 Apr
 2021 16:47:45 +0100
Subject: Re: RCU stall query
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
References: <52dabee9-9c00-d9f9-7df2-4ae1dc643349@huawei.com>
 <20210422143552.GE975577@paulmck-ThinkPad-P17-Gen-1>
From:   John Garry <john.garry@huawei.com>
Message-ID: <412926e8-d3e1-3071-8cb9-098a7f49b64c@huawei.com>
Date:   Thu, 22 Apr 2021 16:45:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210422143552.GE975577@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.78]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 22/04/2021 15:35, Paul E. McKenney wrote:
> On Thu, Apr 22, 2021 at 10:20:51AM +0100, John Garry wrote:
>> Hi RCU experts,
>>

Thanks Paul

>> Recently I have noticed that I can trigger an RCU stall quite easily on my
>> system under specific conditions.
>>
>> I have a fair idea why it happens, but need to analyze a proper solution
>> further. It looks like a hard IRQ handler and threaded part are tied to
>> specific CPU and getting swamped and not relinquishing.
>>
>> However, mixed in the RCU splats, I have noticed many BUG logs, like:
>>
>> [  207.788748] BUG: spinlock recursion on CPU#46, fio/1470
> This is a self-deadlock.  Given that deadlock, and given that spinlocks
> disable preemption, the RCU CPU stall warnings are expected behavior.
> After all, your code really is grabbing a CPU by the throat and shaking
> it indefinitely.
> 
> Please build your kernel with CONFIG_PROVE_LOCKING=y and then fix the
> issues it calls out.  Then please also fix the bugs resulting in the
> "sleeping function called from invalid context" and in the "scheduling
> while atomic".

Here's the rub, the issue goes away with CONFIG_PROVE_LOCKING and all 
the extra debugging it adds. Hmmm.

But I get the point that these are separate and need to be fixed also.

> 
> In addition, there are quite a few idle tasks called out in your list of
> stalled CPUs.  This is often due to RCU's grace-period kthread (named
> "rcu_preempt" in this case) not getting any CPU time.  This is not
> unexpected given the "RT throttling activated".  If you are going to run
> code at real-time priorities, you must ensure that any number of kernel
> kthreads get the CPU time that they need.  As Spiderman's uncle said
> "With great power comes great responsibility".

OK, I need to check on that separately also.

Cheers,
John

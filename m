Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B1C00140
	for <rcu@archiver.kernel.org>; Fri, 12 Aug 2022 08:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiHLIrT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Aug 2022 04:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiHLIrS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Aug 2022 04:47:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95ED6A61C5
        for <rcu@vger.kernel.org>; Fri, 12 Aug 2022 01:47:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 926C2106F;
        Fri, 12 Aug 2022 01:47:16 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 621A03F67D;
        Fri, 12 Aug 2022 01:47:15 -0700 (PDT)
Message-ID: <93a35a13-64ca-4ddf-5c76-c49e86ff9193@arm.com>
Date:   Fri, 12 Aug 2022 10:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Incomplete RCU stall splats ... Why?
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
References: <1d469564-2ea0-d450-7d07-8d48a2686a06@arm.com>
 <20220804163031.GO2125313@paulmck-ThinkPad-P17-Gen-1>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220804163031.GO2125313@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 04/08/2022 18:30, Paul E. McKenney wrote:
> On Thu, Aug 04, 2022 at 04:54:14PM +0200, Dietmar Eggemann wrote:
>> Hi Paul,
> 
> Adding the rcu list on CC in case someone with more ARM experience
> than I have has additional insights.

many thanks for you swift response!

>> one of my colleagues here in Arm approached me with an RCU stall issue
>> on `5.4.0-66 Low Latency (Ubuntu)` (on Arm64 Ampere Altra server) he
>> gets when he tries to bring-up a network card for which he only has the
>> binary module for this kernel version. I tried to help him understanding
>> it but after checking all the kernel config switches and studying the
>> RCU code we still haven't found the culprit here. I was hoping you can
>> give us some advice on this matter.
> 
> Do other kernel versions work better?  If so, I suggest manually forcing
> an RCU CPU stall warning and bisecting.  (But you knew that already!)

Hard to say. IIUC he only has those binaries for this particular version.

>> (1) What he gets when he launches the card is:
>>
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> [15766.032270] rcu: 0-...0: (2 GPs behind) idle=866/0/0x1 softirq=109892/109892 fqs=7186
>> [15766.040260] rcu: 7-...0: (51 ticks this GP) idle=bc6/1/0x4000000000000000 softirq=7973/7975 fqs=7187
>> [15766.049552] rcu: 19-...0: (18 ticks this GP) idle=842/1/0x4000000000000000 softirq=1289/1289 fqs=7187
>> [15766.058931] rcu: 33-...0: (1 GPs behind) idle=36e/1/0x4000000000000000 softirq=132936/132936 fqs=7187
>> [15766.068309] rcu: 37-...0: (2 GPs behind) idle=c86/0/0x1 softirq=117951/117951 fqs=7187
>>
>> w/o any task or stack information (1a). Even the line:
>>
>> [    X.XXXXXX] (detected by X, t=XXX jiffies, g=XXX, q=XX)
>>
>> is missing (1b).
> 
> I never have seen this, aside from the usual printk() messages being
> lost due to overrunning the console device.  But then you will at least
> sometimes get messages saying that output was lost.

I asked him to check. He told me that there are no such lines in the log.

[...]

>> My question now is how can this happen and is there a way to convince
>> the system to hand out the missing information?
>> Other folks were suggesting to use kdump kernel w/ panic_on_rcu_stall=1
>> and then use the crash tool. I haven't use this so far.
> 
> That makes a lot of sense to me!
> 
> You could then look through the rcu_state data structure, including
> the rcu_state.node[] array to see what is stalling the grace period.

I convinced him to go down this path for now to find the issue.

>> I was hoping you can shed some light on this issue.
> 
> Another possibility would be to set hbreak breakpoints in gdb.

[...]

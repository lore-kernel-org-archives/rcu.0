Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9A4C28B2B
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 17:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349871AbiHSRM0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350412AbiHSRMI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Aug 2022 13:12:08 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5BB10B52F
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 09:31:41 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id e4so3728425qvr.2
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Xo7su420EVzXp2bxcK091URgsQkLz9vza9IhSFlCxo4=;
        b=hEcl5zBnjJmx73nB7F8amiQFJTnhEGllskdC4rCt8R+FFI8xMct9GPDRLodND29bC7
         lsf0KTa61d8GjQx4nc296wyB0KXIHSwVJ9IpIF3niqo18lrGNzqZRhXnyz4a9vXHcY4I
         f4ahihM+PNwNx1r9ChuJvhsOtEyNcBc3wQcPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Xo7su420EVzXp2bxcK091URgsQkLz9vza9IhSFlCxo4=;
        b=IjPwrWfvkhuMS7F+QOR+MqiF1JNHfZ1FtVL6wZNsr6mmEtuKNfjvNRmNJ+EqugxAS/
         /XLSmPZTeK10m2SIKL93Q0DKOjpYQrXlj0IYcSWU2aGTBCWgiBlCm8t58ZBj2CpmmLrW
         +a+J0s2lY3K+pAh5fBrsH3dhTwGCqQhohY+x3L+D9WbVDb/aDLr+psjAXKSOUPV0QxPt
         ELw/K1LcLWBfBrjotXxB6RA+nCgwmN+hTUV+aEXF8LxaOCBn6yvyDMsd1opKUuIvm9u2
         wGhEUmIj86d0uS9VWE4F6TTGEiqdVp8Z3alhgpEmeS9AopPPo9pGFdqDXzXH3tMJe4Kg
         7fUQ==
X-Gm-Message-State: ACgBeo0ztZpFjTycCPaupVQ25wNAGUdx51Pl+NmfvAMAfSEQ/qKj968k
        2PZruCWNoOeuoYWlCzdcaJRi4w==
X-Google-Smtp-Source: AA6agR5CS0PUH2Lp7LFafeq3LRxR5CGf61lfkIbi9nNq2deEXL98Ih0Z5VGaMkq9LyxQSLfegqpCiw==
X-Received: by 2002:a05:6214:5287:b0:476:7938:5b76 with SMTP id kj7-20020a056214528700b0047679385b76mr7114606qvb.131.1660926686112;
        Fri, 19 Aug 2022 09:31:26 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id u9-20020a05622a198900b003430cbb0006sm3770646qtc.1.2022.08.19.09.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 09:31:25 -0700 (PDT)
Message-ID: <2d56e4ad-7d6e-2abb-461f-15f20128d42b@joelfernandes.org>
Date:   Fri, 19 Aug 2022 12:30:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <20220809034517.3867176-5-joel@joelfernandes.org>
 <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
 <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
 <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
 <20220819023550.GN2125313@paulmck-ThinkPad-P17-Gen-1>
 <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
In-Reply-To: <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 8/18/2022 10:45 PM, Joel Fernandes wrote:
> 
> 
> On 8/18/2022 10:35 PM, Paul E. McKenney wrote:
>> On Thu, Aug 18, 2022 at 09:21:56PM -0400, Joel Fernandes wrote:
>>> On Thu, Aug 18, 2022 at 7:05 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>>
>>>> On Thu, Aug 18, 2022 at 1:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>>>
>>>>> [Sorry, adding back the CC list]
>>>>>
>>>>> On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
>>>>> <joel@joelfernandes.org> wrote:
>>>>>>
>>>>>> This is required to prevent callbacks triggering RCU machinery too
>>>>>> quickly and too often, which adds more power to the system.
>>>>>>
>>>>>> When testing, we found that these paths were invoked often when the
>>>>>> system is not doing anything (screen is ON but otherwise idle).
>>>>>
>>>>> Unfortunately, I am seeing a slow down in ChromeOS boot performance
>>>>> after applying this particular patch. It is the first time I could
>>>>> test ChromeOS boot times with the series since it was hard to find a
>>>>> ChromeOS device that runs the upstream kernel.
>>>>>
>>>>> Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
>>>>> patch? I wonder if the issue is with wake up interaction with the nocb
>>>>> GP threads.
>>>>>
>>>>> We ought to disable lazy RCU during boot since it would have little
>>>>> benefit anyway. But I am also concerned about some deeper problem I
>>>>> did not catch before.
>>>>>
>>>>> I'll look into tracing the fs paths to see if I can narrow down what's
>>>>> causing it. Will also try a newer kernel, I am currently testing on
>>>>> 5.19-rc4.
>>>>
>>>> I got somewhere with this. It looks like queuing CBs as lazy CBs
>>>> instead of normal CBs, are triggering expedited stalls during the boot
>>>> process:
>>>>
>>>>   39.949198] rcu: INFO: rcu_preempt detected expedited stalls on
>>>> CPUs/tasks: { } 28 jiffies s: 69 root: 0x0/.
>>>>
>>>> No idea how/why lazy RCU CBs would be related to expedited GP issues,
>>>> but maybe something hangs and causes that side-effect.
>>>>
>>>> initcall_debug did not help, as it seems initcalls all work fine, and
>>>> then 8 seconds after the boot, it starts slowing down a lot, followed
>>>> by the RCU stall messages. As a next step I'll enable ftrace during
>>>> the boot to see if I can get more insight. But I believe, its not the
>>>> FS layer, the FS layer just triggers lazy CBs, but there is something
>>>> wrong with the core lazy-RCU work itself.
>>>>
>>>> This kernel is 5.19-rc4. I'll also try to rebase ChromeOS on more
>>>> recent kernels and debug.
>>>
>>> More digging, thanks to trace_event= boot option , I find that the
>>> boot process does have some synchronous waits, and though these are
>>> "non-lazy", for some reason the lazy CBs that were previously queued
>>> are making them wait for the *full* lazy duration. Which points to a
>>> likely bug in the lazy RCU logic. These synchronous CBs should never
>>> be waiting like the lazy ones:
>>>
>>> [   17.715904]  => trace_dump_stack
>>> [   17.715904]  => __wait_rcu_gp
>>> [   17.715904]  => synchronize_rcu
>>> [   17.715904]  => selinux_netcache_avc_callback
>>> [   17.715904]  => avc_ss_reset
>>> [   17.715904]  => sel_write_enforce
>>> [   17.715904]  => vfs_write
>>> [   17.715904]  => ksys_write
>>> [   17.715904]  => do_syscall_64
>>> [   17.715904]  => entry_SYSCALL_64_after_hwframe
>>>
>>> I'm tired so I'll resume the debug later.
>>
>> At times like this, I often pull the suspect code into userspace and
>> run it through its paces.  In this case, a bunch of call_rcu_lazy()
>> invocations into an empty bypass list, followed by a call_rcu()
>> invocation, then a check to make sure that the bypass list is no longer
>> lazy.
> 
> Thanks a lot for this great debug idea, I will look into it.

It seems to be a subtle issue when a large number of callbacks are
queued trigging the lock-contention code, which happens at boot. It
appears the non-lazy ones and lazy ones collide, so you have the lazy
timer which wins, and then the regular bypass lock-contention timer is
not allowed to do its thing. Due to this, the rcuog thread wakes up much
later than a jiffie.

Things are much better with the following change. However, this brings
me to a question about lock-contention based or any deferring and boot time.

If you have a path like selinux doing a synchronize_rcu(), shouldn't we
skip the jiffie waiting for the bypass timer? Otherwise things
synchronously waiting will slow down more than usual. Maybe bypassing
should not be done for any case until boot up is done. I'm curious to
see if that improves boot time.

@@ -580,7 +585,11 @@ static void __call_rcu_nocb_wake(struct rcu_data
*rdp, bool was_alldone,
        len = rcu_segcblist_n_cbs(&rdp->cblist);
        bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
        lazy_len = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
-       if (was_alldone) {
+
+       // If we are in lazy-mode, we still need to do a wake up even if
+       // all CBs were previously done. Otherwise the GP thread will
+       // wait for the full lazy duration.
+       if (was_alldone || (READ_ONCE(rdp->nocb_defer_wakeup) ==
RCU_NOCB_WAKE_LAZY)) {
                rdp->qlen_last_fqs_check = len;
                // Only lazy CBs in bypass list
                if (lazy_len && bypass_len == lazy_len) {

---

Thanks,

 - Joel



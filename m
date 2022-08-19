Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0401C00140
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 02:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbiHSCph (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Aug 2022 22:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiHSCpW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Aug 2022 22:45:22 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A0261111
        for <rcu@vger.kernel.org>; Thu, 18 Aug 2022 19:45:21 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id cb8so2544396qtb.0
        for <rcu@vger.kernel.org>; Thu, 18 Aug 2022 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=R1Nex1dRhqgA1BqvYMjnNRmSClR3k11xE4UGyWNn60Q=;
        b=Ok012zWfPIvabs2S1CBCGnYTewq8E8mj9YgLWiYgQDPjkQNRZq5nWVnIei1cFuroJ7
         +1DXtuzBRVj9hlJwEu4L5PQfTIJqaX168fJMehooRDG2PL8BOy9OGONeNiyxfWMiEMaz
         14oL+wgqSc7THLVk7fGQDl2ynU3GmmTMyzSPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=R1Nex1dRhqgA1BqvYMjnNRmSClR3k11xE4UGyWNn60Q=;
        b=qUELHVxhtzmEvRmjRCTtNOcEeg4COy9T5+Ddxpju0BgvYYwl4SXL7InCfabnXWwfWO
         zS0JE3w1kCsRkTOAhk2Z2oJ61iOqt7Jzo52tOK2OpeybBwMIL+29QrjWI7GsFV8ib9gA
         pPyKa+3zK1N/Km/OCQct30bK4tGnDXw17jIfe8q9Tx5vy3/k+o/JhlQvkOy+lXlBK817
         x1mtvNaw1oLEq1GIl+jC6MQYaUsLraaNsBLbOTOciI19V5c4oBeS718AEJ/DZmXBgBIP
         O+qwJiIv0GTVNaUwdMGf0p+90jWeiZOhzfamC6LFDjy+0OpDnCkpVuvG3qD+cfcsLCti
         RjnA==
X-Gm-Message-State: ACgBeo1Wl3paxr/FmRjIi/7Dzie06ReZ65eGVQDVYcYV43IinHjyeCnG
        nlWp2VavNde1B0GcJYhRKLEcqQ==
X-Google-Smtp-Source: AA6agR6eDfn8hvm4pO7LcZECxnyoEvfMsXNaLritry7g8G9XfKNTM+77uXybpHLmFiuK0ZXvTiW7Ig==
X-Received: by 2002:a05:622a:d1:b0:344:9490:148a with SMTP id p17-20020a05622a00d100b003449490148amr3947146qtw.211.1660877120490;
        Thu, 18 Aug 2022 19:45:20 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id y12-20020a05620a25cc00b006bb78d095c5sm2649392qko.79.2022.08.18.19.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 19:45:20 -0700 (PDT)
Message-ID: <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
Date:   Thu, 18 Aug 2022 22:45:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
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
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220819023550.GN2125313@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 8/18/2022 10:35 PM, Paul E. McKenney wrote:
> On Thu, Aug 18, 2022 at 09:21:56PM -0400, Joel Fernandes wrote:
>> On Thu, Aug 18, 2022 at 7:05 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>
>>> On Thu, Aug 18, 2022 at 1:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>>
>>>> [Sorry, adding back the CC list]
>>>>
>>>> On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
>>>> <joel@joelfernandes.org> wrote:
>>>>>
>>>>> This is required to prevent callbacks triggering RCU machinery too
>>>>> quickly and too often, which adds more power to the system.
>>>>>
>>>>> When testing, we found that these paths were invoked often when the
>>>>> system is not doing anything (screen is ON but otherwise idle).
>>>>
>>>> Unfortunately, I am seeing a slow down in ChromeOS boot performance
>>>> after applying this particular patch. It is the first time I could
>>>> test ChromeOS boot times with the series since it was hard to find a
>>>> ChromeOS device that runs the upstream kernel.
>>>>
>>>> Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
>>>> patch? I wonder if the issue is with wake up interaction with the nocb
>>>> GP threads.
>>>>
>>>> We ought to disable lazy RCU during boot since it would have little
>>>> benefit anyway. But I am also concerned about some deeper problem I
>>>> did not catch before.
>>>>
>>>> I'll look into tracing the fs paths to see if I can narrow down what's
>>>> causing it. Will also try a newer kernel, I am currently testing on
>>>> 5.19-rc4.
>>>
>>> I got somewhere with this. It looks like queuing CBs as lazy CBs
>>> instead of normal CBs, are triggering expedited stalls during the boot
>>> process:
>>>
>>>   39.949198] rcu: INFO: rcu_preempt detected expedited stalls on
>>> CPUs/tasks: { } 28 jiffies s: 69 root: 0x0/.
>>>
>>> No idea how/why lazy RCU CBs would be related to expedited GP issues,
>>> but maybe something hangs and causes that side-effect.
>>>
>>> initcall_debug did not help, as it seems initcalls all work fine, and
>>> then 8 seconds after the boot, it starts slowing down a lot, followed
>>> by the RCU stall messages. As a next step I'll enable ftrace during
>>> the boot to see if I can get more insight. But I believe, its not the
>>> FS layer, the FS layer just triggers lazy CBs, but there is something
>>> wrong with the core lazy-RCU work itself.
>>>
>>> This kernel is 5.19-rc4. I'll also try to rebase ChromeOS on more
>>> recent kernels and debug.
>>
>> More digging, thanks to trace_event= boot option , I find that the
>> boot process does have some synchronous waits, and though these are
>> "non-lazy", for some reason the lazy CBs that were previously queued
>> are making them wait for the *full* lazy duration. Which points to a
>> likely bug in the lazy RCU logic. These synchronous CBs should never
>> be waiting like the lazy ones:
>>
>> [   17.715904]  => trace_dump_stack
>> [   17.715904]  => __wait_rcu_gp
>> [   17.715904]  => synchronize_rcu
>> [   17.715904]  => selinux_netcache_avc_callback
>> [   17.715904]  => avc_ss_reset
>> [   17.715904]  => sel_write_enforce
>> [   17.715904]  => vfs_write
>> [   17.715904]  => ksys_write
>> [   17.715904]  => do_syscall_64
>> [   17.715904]  => entry_SYSCALL_64_after_hwframe
>>
>> I'm tired so I'll resume the debug later.
> 
> At times like this, I often pull the suspect code into userspace and
> run it through its paces.  In this case, a bunch of call_rcu_lazy()
> invocations into an empty bypass list, followed by a call_rcu()
> invocation, then a check to make sure that the bypass list is no longer
> lazy.

Thanks a lot for this great debug idea, I will look into it.

Thanks,

 - Joel

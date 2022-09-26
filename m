Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F698C6FA82
	for <rcu@archiver.kernel.org>; Mon, 26 Sep 2022 23:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiIZXo2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Sep 2022 19:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiIZXoZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Sep 2022 19:44:25 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C489CE6
        for <rcu@vger.kernel.org>; Mon, 26 Sep 2022 16:44:21 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a20so5110628qtw.10
        for <rcu@vger.kernel.org>; Mon, 26 Sep 2022 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=ASwh/CgTRSpzQFYNiOH2eANmCBYsRG0dH0x+rJ55fRA=;
        b=pytN1TMD6dIZXBvRDozKmbJWLf1R6mnG1tWyX1jUnyTVUkxDic8eUgLLYupjmw0Nr5
         fuXqulhwaW3RhaWnvOkmqPV2e5ufhsrltk2ANbBzwgNFS6gsEOdAsQzwBt7XoaW7+Ia+
         XUAPgmHR8JEAGtB17AxfxsoR3SJEfAqBVPbl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ASwh/CgTRSpzQFYNiOH2eANmCBYsRG0dH0x+rJ55fRA=;
        b=R05jd1A6DafdhFq8VFSOJOe8ofSnkTfpPhVpTcmMJSItCSCIvhmLWx3sYewCvuNKpL
         /4m90MRUTYe4XWEKT3n3IDJULmjsHCZ5J0fRzcrF9CnDlaYxrblynssT2ISmxDzj/QCk
         lKSPgud8a95BuSpFWe4XF8d7dRD4jihwv78zdKp2D+kOsfhhlhBg9tXTnDAT6VIiRQyW
         JbQg+Zx/FyDx3PKUEboaLOkdg+KLf1OFmmn3VFw22AXDc2lpQcEu1Qk+mFN8U7UsZybP
         QlY9BX/HYl0gUEMAuYjUB5DPJv9vcZEuNilxStrvYlix/oi5pA7XAyT0lkrT0PXqtAgK
         +K9g==
X-Gm-Message-State: ACrzQf15ytLJ5mU6WySp75uQzesrtSa7CGsKJXUARvjuYop3WMJTFI66
        qiWPVBlGpg5lqlyqpDrStTvGfA==
X-Google-Smtp-Source: AMsMyM6OHHlk3trS7vFIpyoDpWc1oBvF2SfboGAoMWExoAm9HYN02UTIjPjS2Wp5byQ/AcWKLadAEQ==
X-Received: by 2002:a05:622a:38a:b0:35d:6ca:ff91 with SMTP id j10-20020a05622a038a00b0035d06caff91mr20120657qtx.532.1664235860865;
        Mon, 26 Sep 2022 16:44:20 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b132:37f:2047:987d:1b5f:cf31])
        by smtp.gmail.com with ESMTPSA id c12-20020a05622a058c00b0035bafecff78sm12708236qtb.74.2022.09.26.16.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 16:44:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Date:   Mon, 26 Sep 2022 19:44:19 -0400
Message-Id: <BE2B629D-B5D2-4ED0-944E-2F13E846047E@joelfernandes.org>
References: <20220926223534.GY4196@paulmck-ThinkPad-P17-Gen-1>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
In-Reply-To: <20220926223534.GY4196@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Sep 26, 2022, at 6:35 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Sep 26, 2022 at 08:54:27PM +0000, Joel Fernandes wrote:
>> Hi Vlad,
>>=20
>> On Mon, Sep 26, 2022 at 09:39:23PM +0200, Uladzislau Rezki wrote:
>> [...]
>>>>> On my KVM machine the boot time is affected:
>>>>>=20
>>>>> <snip>
>>>>> [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Conn=
ection
>>>>> [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
>>>>> [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2=
 tray
>>>>> [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
>>>>> [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
>>>>> [  104.115418] process '/usr/bin/fstype' started with executable stack=

>>>>> [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mo=
de. Quota mode: none.
>>>>> [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +=
AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +=
GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 defau=
lt-hierarchy=3Dhybrid)
>>>>> [  104.340193] systemd[1]: Detected virtualization kvm.
>>>>> [  104.340196] systemd[1]: Detected architecture x86-64.
>>>>> [  104.359032] systemd[1]: Set hostname to <pc638>.
>>>>> [  105.740109] random: crng init done
>>>>> [  105.741267] systemd[1]: Reached target Remote File Systems.
>>>>> <snip>
>>>>>=20
>>>>> 2 - 11 and second delay is between 32 - 104. So there are still users w=
hich must
>>>>> be waiting for "RCU" in a sync way.
>>>>=20
>>>> I was wondering if you can compare boot logs and see which timestamp do=
es the
>>>> slow down start from. That way, we can narrow down the callback. Also a=
nother
>>>> idea is, add "trace_event=3Drcu:rcu_callback,rcu:rcu_invoke_callback
>>>> ftrace_dump_on_oops" to the boot params, and then manually call
>>>> "tracing_off(); panic();" from the code at the first printk that seems o=
ff in
>>>> your comparison of good vs bad. For example, if "crng init done" timest=
amp is
>>>> off, put the "tracing_off(); panic();" there. Then grab the serial cons=
ole
>>>> output to see what were the last callbacks that was queued/invoked.
>>=20
>> Would you be willing to try these steps? Meanwhile I will try on my side a=
s
>> well with the .config you sent me in another email.
>>=20
>>>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>>>>>> index 08605ce7379d..40ae36904825 100644
>>>>>> --- a/include/linux/rcupdate.h
>>>>>> +++ b/include/linux/rcupdate.h
>>>>>> @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
>>>>>>=20
>>>>>> #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>>>>>>=20
>>>>>> +#ifdef CONFIG_RCU_LAZY
>>>>>> +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
>>>>>> +#else
>>>>>> +static inline void call_rcu_flush(struct rcu_head *head,
>>>>>> +        rcu_callback_t func) {  call_rcu(head, func); }
>>>>>> +#endif
>>>>>> +
>>>>>> /* Internal to kernel */
>>>>>> void rcu_init(void);
>>>>>> extern int rcu_scheduler_active;
>>>>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>>>>>> index f53ad63b2bc6..edd632e68497 100644
>>>>>> --- a/kernel/rcu/Kconfig
>>>>>> +++ b/kernel/rcu/Kconfig
>>>>>> @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
>>>>>>      Say N here if you hate read-side memory barriers.
>>>>>>      Take the default if you are unsure.
>>>>>>=20
>>>>>> +config RCU_LAZY
>>>>>> +    bool "RCU callback lazy invocation functionality"
>>>>>> +    depends on RCU_NOCB_CPU
>>>>>> +    default n
>>>>>> +    help
>>>>>> +      To save power, batch RCU callbacks and flush after delay, memo=
ry
>>>>>> +      pressure or callback list growing too big.
>>>>>> +
>>>>>>=20
>>>>> Do you think you need this kernel option? Can we just consider and mak=
e
>>>>> it a run-time configurable? For example much more users will give it a=
 try,
>>>>> so it will increase a coverage. By default it can be off.
>>>>>=20
>>>>> Also you do not need to do:
>>>>>=20
>>>>> #ifdef LAZY
>>>>=20
>>>> How does the "LAZY" macro end up being runtime-configurable? That's sta=
tic /
>>>> compile time. Did I miss something?
>>>>=20
>>> I am talking about removing if:
>>>=20
>>> config RCU_LAZY
>>>=20
>>> we might run into issues related to run-time switching though.
>>=20
>> When we started off, Paul said he wanted it kernel CONFIGurable. I will d=
efer
>> to Paul on a decision for that. I prefer kernel CONFIG so people don't fo=
rget
>> to pass a boot param.
>=20
> I am fine with a kernel boot parameter for this one.  You guys were the
> ones preferring Kconfig options.  ;-)

Yes I still prefer that.. ;-)

> But in that case, the CONFIG_RCU_NOCB_CPU would come into play to handle
> the case where there is no bypass.

If you don=E2=80=99t mind, let=E2=80=99s do both like we did for NOCB_CPU_AL=
L. In which case, Vlad since this was your suggestion, would you be so kind t=
o send a patch adding a boot parameter on top of the series? ;-). I=E2=80=99=
ll include it in the next version. I=E2=80=99d suggest keep the boot param d=
efault off and add a CONFIG option that forces the boot param to be turned o=
n.

Thanks,

 - Joel



>=20
>                            Thanx, Paul

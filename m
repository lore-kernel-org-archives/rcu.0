Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CFCC7EE23
	for <rcu@archiver.kernel.org>; Mon, 27 Feb 2023 13:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjB0NY2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Feb 2023 08:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjB0NY1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Feb 2023 08:24:27 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45743BB
        for <rcu@vger.kernel.org>; Mon, 27 Feb 2023 05:24:26 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c19so6414957qtn.13
        for <rcu@vger.kernel.org>; Mon, 27 Feb 2023 05:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvWgbJ9JHqwbDNhWcFDNiCZkkzEissDQVBURsUj8ZIc=;
        b=oKsTvaze0v+fliq+yhISzNmMHTgaoRjTFxGNiMkiFr8xwejqoVDZ3SbqCe1P7uMiEr
         f84rxWS0HQWHgVdJnxaqzE6wssLYtdv3R0X0VPE6KjHhoHou6743WAS6o6Ru+TkRoxN7
         YXhnaUo5i9+BkfNQGLBbDWxaEzxFnmD//goSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvWgbJ9JHqwbDNhWcFDNiCZkkzEissDQVBURsUj8ZIc=;
        b=ZweVYvnbcl8X7ztinSBgGIZKqdnAjJRQzRPxfXMvK1IWkMgfwE2NhFmJxopOf+/rkz
         iTC7o+iDfIbw+rH3B1YHLxyChKtf80d3Nc+59HPLQmkfZd8FRvlm3vMfdWbYU+qrLqcm
         A6PBP6dACS8WZV50qaWrq9Y9ZJBA61M+aDscP67cd83dGVjsP7OBCGIfBdOIsII9liQt
         xRbp95CFasPuW8MPqLelFxVW66RX1nkrdxvj7kBY53KUSYfQizNicOkYryTymXSuHtpW
         gJxVv3vmeennFJO9cezGUpjIv3aVVOXHs7Eb4NOwYmDjw9R49ccO+SOPSX/XdpmpCb9Z
         FMfw==
X-Gm-Message-State: AO0yUKXUwmO1Nr+ViuEVBvrKz2J4JiMMgfH2oM1kVUk6oXEDaeRm31Bd
        CSg3FjSaTRuiptjYVFbgoP0TR0t+rKAQic9r
X-Google-Smtp-Source: AK7set/RKUThs6S/feli3szgaS/+d/HsT0B0UInQ6324wdqpABzcfGwCKnyPp4CE3pNdGJNew2XSFg==
X-Received: by 2002:a05:622a:1048:b0:3b8:4951:57b8 with SMTP id f8-20020a05622a104800b003b8495157b8mr29368866qte.15.1677504265255;
        Mon, 27 Feb 2023 05:24:25 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id k13-20020ac8074d000000b003bfd27755d7sm2592585qth.19.2023.02.27.05.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 05:24:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] rcu: Add a minimum time for marking boot as completed
Date:   Mon, 27 Feb 2023 08:24:13 -0500
Message-Id: <F276BA2C-5401-498D-80CF-D60DFEA71F38@joelfernandes.org>
References: <d24bff4c-9426-296a-d43a-f22983ab9086@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
In-Reply-To: <d24bff4c-9426-296a-d43a-f22983ab9086@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Feb 26, 2023, at 7:03 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
> =EF=BB=BF
>=20
>> On 2/24/23 19:59, Joel Fernandes wrote:
>> On Fri, Feb 24, 2023 at 07:32:22PM -0800, Randy Dunlap wrote:
>> [..]=20
>>>> +
>>>> +      Accept the default if unsure.
>>>> +
>>>> config RCU_EXP_KTHREAD
>>>>    bool "Perform RCU expedited work in a real-time kthread"
>>>>    depends on RCU_BOOST && RCU_EXPERT
>>>> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
>>>> index 19bf6fa3ee6a..5b73341d9b89 100644
>>>> --- a/kernel/rcu/update.c
>>>> +++ b/kernel/rcu/update.c
>>>> @@ -62,6 +62,10 @@ module_param(rcu_normal_after_boot, int, 0444);
>>>> #endif
>>>> #endif /* #ifndef CONFIG_TINY_RCU */
>>>>=20
>>>> +/* Minimum time until RCU considers boot as completed. */
>>>> +static int boot_end_delay =3D CONFIG_RCU_BOOT_END_DELAY;
>>>> +module_param(boot_end_delay, int, 0444);
>>>> +
>>>> #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>> /**
>>>>  * rcu_read_lock_held_common() - might we be in RCU-sched read-side cri=
tical section?
>>>> @@ -225,12 +229,29 @@ void rcu_unexpedite_gp(void)
>>>> EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
>>>>=20
>>>> static bool rcu_boot_ended __read_mostly;
>>>> -
>>>> /*
>>>> - * Inform RCU of the end of the in-kernel boot sequence.
>>>> + * Inform RCU of the end of the in-kernel boot sequence. The boot sequ=
ence will
>>>> + * not be marked ended until at least boot_end_delay milliseconds have=
 passed.
>>>>  */
>>>> +void rcu_end_inkernel_boot(void);
>>>> +static void boot_rcu_work_fn(struct work_struct *work)
>>>> +{
>>>> +    rcu_end_inkernel_boot();
>>>> +}
>>>> +static DECLARE_DELAYED_WORK(boot_rcu_work, boot_rcu_work_fn);
>>>> +
>>>> void rcu_end_inkernel_boot(void)
>>>> {
>>>> +    if (boot_end_delay) {
>>>> +        u64 boot_ms =3D ktime_get_boot_fast_ns() / 1000000UL;
>>>=20
>>> Is that division OK on 32-bit?  Might have to use a helper macro. (I dun=
no.)
>>=20
>> I believe the below should work on 32-bit, but I will test it more. It do=
es
>> on 64-bit.
>>=20
>> Thanks!
>>=20
>> ---8<-----------------------
>>=20
>> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
>> index cbdad7b46841..2f539c18b310 100644
>> --- a/kernel/rcu/update.c
>> +++ b/kernel/rcu/update.c
>> @@ -243,7 +243,7 @@ static DECLARE_DELAYED_WORK(boot_rcu_work, boot_rcu_w=
ork_fn);
>> void rcu_end_inkernel_boot(void)
>> {
>>    if (boot_end_delay) {
>> -        u64 boot_ms =3D ktime_get_boot_fast_ns() / 1000000UL;
>> +        u64 boot_ms =3D div_u64(ktime_get_boot_fast_ns(), 1000000UL);
>>=20
>>        if (boot_ms < boot_end_delay) {
>>            schedule_delayed_work(&boot_rcu_work,
>=20
> Joel, this now builds cleanly on 32-bit. Before the patch:
>=20
> ld: kernel/rcu/update.o: in function `boot_rcu_work_fn':
> update.c:(.text+0x4623): undefined reference to `__udivdi3'
> ld: kernel/rcu/update.o: in function `rcu_end_inkernel_boot':
> update.c:(.text+0x46b3): undefined reference to `__udivdi3'
>=20
> I don't know what the second one refers to, but it didn't show up
> after the patch above (using div_u64()).

Thanks a lot, I will update the patch with this in the next spin.

 - Joel


>=20
> Thanks.
> --=20
> ~Randy

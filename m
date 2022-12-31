Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B53C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 17:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiLaR30 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 12:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiLaR3Y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 12:29:24 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EB6631B
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 09:29:24 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h21so19314798qta.12
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzlpZDuvoVoGSutxGaGBlqJPMYD9cn1Rs4pSGazihlY=;
        b=lhyUQQKZgCa7g85wJ0GSChxXTjXm6EqaRrvOnJEV4TXouTi2OxWVKe8ITmnVNAV4Rg
         3qU669a/2mFE5zF0Fe4SQJXk0TM/gv6oRJ4Y/AjNY9/jUtCfKVt8bsHBVXrGEIETgVsB
         TuFUwsZj9XYaa5joBUYPIaoZWFfDHLk33h8CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzlpZDuvoVoGSutxGaGBlqJPMYD9cn1Rs4pSGazihlY=;
        b=N6i5YTYGFvJF3lzvEvljC2NNGbwJ67eRgVi43xgr6+LaOFbp52gMsPwq1Y8RAzjXKc
         ZyqkmS+oIJoAbqLjw+KvjKBORSuxi2LmJTftj+/9DFVH72a6lgota2KzRvPJQj/L9CeH
         3g4bfkjtfND41VuU8iTMhTWnZSAkeflsQvhRhOH32xEtbzScwUu6yBbcRfBaEBRsUYOm
         QyC6k5fTFl+otajvg8R1mGnKS+ZEIB4Prgjwk1DVCk5sddLtEFciUjfA3NWrtCH8Ub4b
         odU9v5i1qEgXCAi3QM2iu4ZKhPcKGdmQjMBnd2+87MyoBS7P1Of65HXxLC++GWk5nUoV
         Stig==
X-Gm-Message-State: AFqh2kpJJyY5hDuRb49XDvDPCp+EsdqlJTW74bgPH4uoVwG0B9NuQulK
        //PeFA8AMLwp5n6EGu1OEWUtJA==
X-Google-Smtp-Source: AMrXdXvEoTK/8u1JLLP+hDfIzFDMM532ejjjQErWFK0sod0Zy2ESemelF8Rsr6Jmc1hymZ3FMooKxg==
X-Received: by 2002:ac8:530f:0:b0:3a7:f669:4599 with SMTP id t15-20020ac8530f000000b003a7f6694599mr44897042qtn.62.1672507761868;
        Sat, 31 Dec 2022 09:29:21 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a0bd500b006fa4ac86bfbsm17208115qki.55.2022.12.31.09.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 09:29:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
Date:   Sat, 31 Dec 2022 12:29:10 -0500
Message-Id: <E7D2CF49-C4B5-47DF-BBE6-59A1DB26E847@joelfernandes.org>
References: <20221231172727.GA205110@lothringen>
Cc:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
In-Reply-To: <20221231172727.GA205110@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 31, 2022, at 12:27 PM, Frederic Weisbecker <frederic@kernel.org> wr=
ote:
>=20
> =EF=BB=BFOn Fri, Dec 30, 2022 at 08:42:24PM -0500, Joel Fernandes wrote:
>> Hello,
>>=20
>> I have been firefighting a hang on 6.0.y stable kernels with
>> rcutorture. It happens mostly consistently when TREE07 is shutting
>> down.
>>=20
>> It appears that the RCU torture threads are attempted to stop but the
>> shutdown thread, but are constantly awakened by a timer softirq
>> handler in ksoftirqd context. When they wake up, they immediately goto
>> sleep in uninterruptible state until the next time a timer handler
>> wakes them up. It appears the timer softirq is long enough to cause
>> RCU stalls and I see it calling 100s of timer function handlers
>> (call_timer_fn).
>>=20
>> I am doing some more investigation with trace_printk(s):
>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=
=3Dstable/trace-hang-6.0.y&id=3Db779b1e92c97f29333a282ee8f548da02f64de2b
>>=20
>> Regarding the timer handlers, I was wondering if it is possible that a
>> large number of timer handlers constantly queued can cause RCU stalls
>> due to the timer softirq taking a very long time. That certainly
>> appears to be the case here. Shouldn't the timer softirq also do
>> rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
>> many of them?
>>=20
>> Here is a full log with trace dump if you anyone wants to take a look:
>> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/1=
1/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07=
.2/console.log
>> And the res directory:
>> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/1=
1/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07=
.2/
>>=20
>> Any thoughts on any patches 6.0 might be missing?
>=20
> I can't reproduce it in v6.0 (vanilla not stable) after 100 runs of 5 minu=
tes,
> so may be it's actually some patches too many instead :-)

Thanks for that insight!

- Joel=20

>=20
>>=20
>> Meanwhile, debug here continues... thanks,
>>=20
>> - Joel

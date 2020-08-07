Return-Path: <SRS0=1SSE=BR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D3DC433DF
	for <rcu@archiver.kernel.org>; Fri,  7 Aug 2020 20:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D552075A
	for <rcu@archiver.kernel.org>; Fri,  7 Aug 2020 20:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j7qfrT4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGUtc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGUtc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 7 Aug 2020 16:49:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B2C061756
        for <rcu@vger.kernel.org>; Fri,  7 Aug 2020 13:49:30 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j9so2853308ilc.11
        for <rcu@vger.kernel.org>; Fri, 07 Aug 2020 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NIHYSnFxx2dvKiTmnFFM/FXfwIfs/Ib+zKZYEPwZY0M=;
        b=j7qfrT4kJrcek1ofjcrRZ6VKtkX1s/7rhTMPOZ4EmnaYZuifQkht/CpOeb4vB9GbTS
         zgg466Prscb6qM82Z7ScIAaqtDttChChZ7wKJk8fgHKQ+/4PyP9lcZXaSm5Ozb5hslz7
         tCAA3EkZ+lGdztqhB3vcGHNgKbGwQB8Ojy1zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NIHYSnFxx2dvKiTmnFFM/FXfwIfs/Ib+zKZYEPwZY0M=;
        b=Q8TtLuPc7jmhA6+c4ITcgQml70e35Jd0LMnRuZWDz28XWs4T1Op6NIo+AZJOq325VG
         EFZuDMv0jS8rYC2gh/S73bz3cN9Vwoumijt5qghfqFnR4H/1zIpa4ED07UFsjRlthpYf
         ZmhZAZNH34OnDWa06wUqvl18STmxIe/cNsIUMxAi70IWJ/SUsKyK2uRcHp1IFyovz7Mt
         DNJLkMCncATVJgxC/2xq9CAw3/nqKkcvHpHXTqtlbd2UmNAoUEBHt8SYkXzaKoOVQQ3e
         4zqTIEK2sKsIOiAqzIwCwAE2XF6OwLdFgIkpIJ8b2Xj/D00IMlLpTaJk03HQeiGvf0vW
         jMew==
X-Gm-Message-State: AOAM532o/8SMJgEWijXQ+sDmzorRwyU/mnR1oup2W/MJaUnCOWI2nsKb
        2TYfq4yMj8zUyv0uHZx21dtXi6uwMDgJ6+8U7FP1cA==
X-Google-Smtp-Source: ABdhPJwuOnvOf3rcTb2Mp4RVc9ZYxUM04u8wYPf56hh8WrvNOEMpXfnNiQzBf4/NwX/4JNZ3Ev8T+hfGqGPTKN3Edac=
X-Received: by 2002:a92:340d:: with SMTP id b13mr6600128ila.78.1596833370279;
 Fri, 07 Aug 2020 13:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Sh73MJhqs7PBk6OV2AhzVjYvE1foUQUnwP5DwWR44LHZRZ9w@mail.gmail.com>
 <58be64c5-9ae4-95ff-629e-f55e47ff020b@gmail.com> <CA+Sh73NeNr+UNZYDfD1nHUXCY-P8mT1vJdm0cEY4MPwo_0PtzQ@mail.gmail.com>
 <CAEXW_YSSL5+_DjtrYpFp35kGrem782nBF6HuVbgWJ_H3=jeX4A@mail.gmail.com>
In-Reply-To: <CAEXW_YSSL5+_DjtrYpFp35kGrem782nBF6HuVbgWJ_H3=jeX4A@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 7 Aug 2020 16:49:18 -0400
Message-ID: <CAEXW_YRC=+mA1jr_dn6n2Nx-fFoVctBpsG1VStBKOna7imu76Q@mail.gmail.com>
Subject: Re: [ovs-discuss] Double free in recent kernels after memleak fix
To:     =?UTF-8?B?Sm9oYW4gS27DtsO2cw==?= <jknoos@google.com>
Cc:     Gregory Rose <gvrose8192@gmail.com>, bugs@openvswitch.org,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 7, 2020 at 4:47 PM Joel Fernandes <joel@joelfernandes.org> wrot=
e:
>
> Hi,
> Adding more of us working on RCU as well. Johan from another team at
> Google discovered a likely issue in openswitch, details below:
>
> On Fri, Aug 7, 2020 at 11:32 AM Johan Kn=C3=B6=C3=B6s <jknoos@google.com>=
 wrote:
> >
> > On Tue, Aug 4, 2020 at 8:52 AM Gregory Rose <gvrose8192@gmail.com> wrot=
e:
> > >
> > >
> > >
> > > On 8/3/2020 12:01 PM, Johan Kn=C3=B6=C3=B6s via discuss wrote:
> > > > Hi Open vSwitch contributors,
> > > >
> > > > We have found openvswitch is causing double-freeing of memory. The
> > > > issue was not present in kernel version 5.5.17 but is present in
> > > > 5.6.14 and newer kernels.
> > > >
> > > > After reverting the RCU commits below for debugging, enabling
> > > > slub_debug, lockdep, and KASAN, we see the warnings at the end of t=
his
> > > > email in the kernel log (the last one shows the double-free). When =
I
> > > > revert 50b0e61b32ee890a75b4377d5fbe770a86d6a4c1 ("net: openvswitch:
> > > > fix possible memleak on destroy flow-table"), the symptoms disappea=
r.
> > > > While I have a reliable way to reproduce the issue, I unfortunately
> > > > don't yet have a process that's amenable to sharing. Please take a
> > > > look.
> > > >
> > > > 189a6883dcf7 rcu: Remove kfree_call_rcu_nobatch()
> > > > 77a40f97030b rcu: Remove kfree_rcu() special casing and lazy-callba=
ck handling
> > > > e99637becb2e rcu: Add support for debug_objects debugging for kfree=
_rcu()
> > > > 0392bebebf26 rcu: Add multiple in-flight batches of kfree_rcu() wor=
k
> > > > 569d767087ef rcu: Make kfree_rcu() use a non-atomic ->monitor_todo
> > > > a35d16905efc rcu: Add basic support for kfree_rcu() batching
> > > >
>
> Note that these reverts were only for testing the same code, because
> he was testing 2 different kernel versions. One of them did not have
> this set. So I asked him to revert. There's no known bug in the
> reverted code itself. But somehow these patches do make it harder for
> him to reproduce the issue.

And the reason for this is likely the additional kfree batching is
slowing down the occurrence of the crash.

thanks,

 - Joel

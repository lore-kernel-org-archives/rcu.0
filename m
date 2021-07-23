Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED3DC4338F
	for <rcu@archiver.kernel.org>; Fri, 23 Jul 2021 00:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5A960EBA
	for <rcu@archiver.kernel.org>; Fri, 23 Jul 2021 00:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhGVXt0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Jul 2021 19:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhGVXt0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Jul 2021 19:49:26 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAD5C061575
        for <rcu@vger.kernel.org>; Thu, 22 Jul 2021 17:30:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y9so678507iox.2
        for <rcu@vger.kernel.org>; Thu, 22 Jul 2021 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KgKFOkONI3mTZRna/+r404Hh51umJSee16r7lKb3sAY=;
        b=HAFgLWgXvjf1TyVVLOAasc9MFalEmsNLr7qbqo96Z22FfdH59ULQFyJK6yhjUipOf/
         Sxx87K9OooVgDu4Fl5kZxF8P1cJfvvfNN7w6ahWcA9e7DRhQ3uhtcuC9L/AqFAbYQcBR
         6LAROHun2xsgJ7W4/qiojiHa80GHEyIckW3hbWcUcEtwuLqQHustdfOU4kOVTOF48E2p
         lP11re8cqRV9Ktm25JTNcfsadMQo18ZcZzCcm+hLVXYgk2WalYCI3Auv43pW1tqmVD0F
         hGK41ebB2IU97oD0ZmpUwl69QfQ2hlw3HK6Owr/s8FstLkQXy74sicFrEv+OmAyxfe6x
         3tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KgKFOkONI3mTZRna/+r404Hh51umJSee16r7lKb3sAY=;
        b=tCL4RreVyuwhaeFo7Je/irrXjUoLlk1u5OFYQmTfHOyfmbQDv+0PmByYKEZuzTI0bG
         Iw1sxdfoMI4L/Of8jH3anQbVB3Epi0rzL6+IPkULqP8+VBYhRglRnb/1zy1gLpVQ3lWe
         Tw0+307PakcbF3fP+3RkkorKHw7qRuKz/AxDL50xL0QKu8Ac3a6GpuEanO/BiocSVRQc
         yWmxOl+eYU2DwHlexGHdASyPB40IgXrv9s6uYgH/2eti9q2IBQPWCKF1+kKWZIxEQ7lu
         /8+c5GD6ULMK0+toRfFeSQdId64yPhbPoNbRGjGz/nl4RHhNhi2BOfHEz4vdTi11FUb+
         JPgA==
X-Gm-Message-State: AOAM5325dbWk6YBOrZxHYMjgZ9sqElmlQ//2Gl/OJB1k1yOOEzXNVkwb
        hS4hhlce1eDnJ3jF0pDn6g0=
X-Google-Smtp-Source: ABdhPJyads7Y14reqYYi4gazgwtRb43JjEOhBPdgpumB9s5sHZG/ndfNxO86IlnV64rA9Sr2yqUP9g==
X-Received: by 2002:a6b:510c:: with SMTP id f12mr1801578iob.59.1627000199440;
        Thu, 22 Jul 2021 17:29:59 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x10sm14198414ill.26.2021.07.22.17.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 17:29:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5C36827C0054;
        Thu, 22 Jul 2021 20:29:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 22 Jul 2021 20:29:58 -0400
X-ME-Sender: <xms:hQ36YF4UkQ9wbsuaBI6lyhTBa7aI886htHKJkyiKDLUTErLgjRk_0g>
    <xme:hQ36YC48sItojPdD-zynb0Q8uVgDJf3EgYTMg7VvE6mRpOV_JbPMp2K_LTs5QMTrO
    5i_0UQuZPo11JRuBA>
X-ME-Received: <xmr:hQ36YMdL4yWUf88ej8UhbT8Y_9oqxbfDK2cMrEyXpw1mZA12TYE3Qj2GEeM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeejgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:hQ36YOJ5MwofsXwGnelpy6TmH41uQvAdRdd_LEWTG4iNjeI34YGYtA>
    <xmx:hQ36YJK1BywFnizBB6uaK-HaFWJmRMlHWVNDSayjKIUn2ZEDqek40g>
    <xmx:hQ36YHwX6CsyAdbHO3sFTsGxnNr8WiL2xfQLym4So8-FFdcgyDgt0A>
    <xmx:hQ36YHgfV2C0rO6v-jnHAuoS0v5otoIHaYXxVfZ0UfVPtvtV3Tmcag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jul 2021 20:29:57 -0400 (EDT)
Date:   Fri, 23 Jul 2021 08:29:53 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     donghai qiao <donghai.w.qiao@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: RCU: rcu stall issues and an approach to the fix
Message-ID: <YPoNgcLgJY/POS4u@boqun-archlinux>
References: <CAOzhvcPb=NMCHCqyDiyWiX9DjR=RXgdQRfJDkJOdazugHe7+Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzhvcPb=NMCHCqyDiyWiX9DjR=RXgdQRfJDkJOdazugHe7+Zw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 22, 2021 at 04:08:06PM -0400, donghai qiao wrote:
> RCU experts,
> 
> When you reply, please also keep me CC'ed.
> 
> The problem of RCU stall might be an old problem and it can happen quite often.
> As I have observed, when the problem occurs,  at least one CPU in the system
> on which its rdp->gp_seq falls behind others by 4 (qs).
> 
> e.g.  On CPU 0, rdp->gp_seq = 0x13889d, but on other CPUs, their
> rdp->gp_seq = 0x1388a1.
> 
> Because RCU stall issues can last a long period of time, the number of callbacks
> in the list rdp->cblist of all CPUs can accumulate to thousands. In
> the worst case,
> it triggers panic.
> 
> When looking into the problem further, I'd think the problem is related to the
> Linux scheduler. When the RCU core detects the stall on a CPU, rcu_gp_kthread
> would send a rescheduling request via send_IPI to that CPU to try to force a
> context switch to make some progress. However, at least one situation can fail
> this effort, which is when the CPU is running a user thread and it is the only
> user thread in the rq, then this attempted context switching will not happen
> immediately. In particular if the system is also configured with NOHZ_FULL for

Correct me if I'm wrong, if a CPU is solely running a user thread, how
can that CPU stall RCU? Because you need to be in a RCU read-side
critical section to stall RCU. Or the problem you're talking here is
about *recovering* from RCU stall?

Regards,
Boqun

> the CPU and as long as the user thread is running, the forced context
> switch will
> never happen unless the user thread volunteers to yield the CPU. I think this
> should be one of the major root causes of these RCU stall issues. Even if
> NOHZ_FULL is not configured, there will be at least 1 tick delay which can
> affect the realtime kernel, by the way.
> 
> But it seems not a good idea to craft a fix from the scheduler side because
> this has to invalidate some existing scheduling optimizations. The current
> scheduler is deliberately optimized to avoid such context switching.  So my
> question is why the RCU core cannot effectively update qs for the stalled CPU
> when it detects that the stalled CPU is running a user thread?  The reason
> is pretty obvious because when a CPU is running a user thread, it must not
> be in any kernel read-side critical sections. So it should be safe to close
> its current RCU grace period on this CPU. Also, with this approach we can make
> RCU work more efficiently than the approach of context switch which needs to
> go through an IPI interrupt and the destination CPU needs to wake up its
> ksoftirqd or wait for the next scheduling cycle.
> 
> If my suggested approach makes sense, I can go ahead to fix it that way.
> 
> Thanks
> Donghai

Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B571FC433EF
	for <rcu@archiver.kernel.org>; Thu, 14 Oct 2021 13:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EAD60EBB
	for <rcu@archiver.kernel.org>; Thu, 14 Oct 2021 13:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhJNN7h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhJNN7h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Oct 2021 09:59:37 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695CFC061570;
        Thu, 14 Oct 2021 06:57:32 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id p4so5501912qki.3;
        Thu, 14 Oct 2021 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GIBH8o6WpT2H7iYi/BIo0/Wyph7orVRqgeyBe3NOH3M=;
        b=LTHM8tt06egaQG0WMY7pxFR+XLCw55vUWv7sxk436edTxMZr0w/LkyRjWCBVnLlYqW
         psQXSfKCRPB49wKQUNnbOw3IUQ94G5HfVPn8BmG8oOouofTzcKJrqRSCVcWv2xO45OmY
         wgwfpNH8EWdPLy3RcozvpisCjfesmSbOek332pLvyZSorEvEnrtO33xippBc+vYk7Bny
         qNBFqJoL0Vc7FEX97Cwi5McfaqdPq2P4V8BSgt18v9ou/u89YUbVApW6lA4e7zkFxf/b
         +1LYnGWUUQhAffPqCfXZOkCOuO2y9BrDmPuvQw26/ZEyYvJLg8sZvY90+4jqdGl/hOHl
         EGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GIBH8o6WpT2H7iYi/BIo0/Wyph7orVRqgeyBe3NOH3M=;
        b=OqPSYmMtJWSysXNw9GyaOnnffBdBvCgGlBQMLy10GIjXDfw1xp0Lo45Gak1/AaGNfU
         oUAs/XXXd8UUPf6nrbkYfGOVn/Ivub+BF+QXkDUoy21f+iqZxMQ/AYLqbTZFIRbr9UWQ
         WpB5MsD6ZbVty9QPXFk9uWRkdup96EPrV4KfDj3MWU43trGdW+gElLKFsR0C+FjjDj87
         A4LG4lQZW8KzmOHDmiZ80nqIpvL81hW7mF9rOp0OORePf73TIF2nr57V0HgjEi87YZbp
         8ZLUMLymnqYsqE8OgizfaWKC8lAoQb60Lhm9iVOkYjUlNgxHwA6RTk+erQI4jaS0MMu4
         zBLQ==
X-Gm-Message-State: AOAM532Mcgjk0gkR34XKbkZebBRK5YVAH7AE0DfpibnlDLwA+nhx7tTv
        1QWMJbY4PFHXpuDO+f+/g6o=
X-Google-Smtp-Source: ABdhPJzMSynW04AaJea12M1eFo9J7qDsdaPfjkDYOTzx6zEtLLaeloZCJQHH4YQpmX9+mzR7i/ed/g==
X-Received: by 2002:a05:620a:198e:: with SMTP id bm14mr4732122qkb.429.1634219850117;
        Thu, 14 Oct 2021 06:57:30 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t19sm1386835qtn.26.2021.10.14.06.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 06:57:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5830227C0054;
        Thu, 14 Oct 2021 09:57:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 14 Oct 2021 09:57:28 -0400
X-ME-Sender: <xms:RzdoYSixGWPoRWPamyyaRt85pLF_9dox-btTaRe9ngL4yAMjpivmIA>
    <xme:RzdoYTB68I-AAuaRdnFuitFaB4q2CBjrumciWK8NJc8quYLLcPi9P20JqyBIut-ar
    Krx9_yHeQbngpNwqA>
X-ME-Received: <xmr:RzdoYaF-y5KQnt_jrmfoldBpSN3iTckcILYblbsfg5MawJ7R0IPV8_BzoFMbqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdduvddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:RzdoYbT8uPO_U446wS2sOb1DU3Jfxj6E4Fv71FqTZFrrTOAACTHRhA>
    <xmx:RzdoYfwUAUPaSNkLxgBR1ukKJXRq9an1wlAY_lrduTbVeWs2d3UGzw>
    <xmx:RzdoYZ7zhuHTBJrgND0lBD5EvwJwz4fgLIdvM7x8hkYaG-pJuplxNA>
    <xmx:RzdoYd4pWTN3n0ewbLyLfAC1aR3ribkd02NEOq6ycK6r9kQXgj9i0m__Jm4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Oct 2021 09:57:27 -0400 (EDT)
Date:   Thu, 14 Oct 2021 21:57:22 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Valentin Schneider <Valentin.Schneider@arm.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 03/11] rcu/nocb: Invoke rcu_core() at the start of
 deoffloading
Message-ID: <YWg3QthesE5XMeLj@boqun-archlinux>
References: <20211011145140.359412-1-frederic@kernel.org>
 <20211011145140.359412-4-frederic@kernel.org>
 <YWcEXj2+nqO8kIFS@boqun-archlinux>
 <87o87rkf2n.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o87rkf2n.mognet@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 14, 2021 at 12:42:40PM +0100, Valentin Schneider wrote:
> On 14/10/21 00:07, Boqun Feng wrote:
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index e38028d48648..b236271b9022 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -2717,6 +2717,23 @@ static __latent_entropy void rcu_core(void)
> >>      unsigned long flags;
> >>      struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
> >>      struct rcu_node *rnp = rdp->mynode;
> >> +	/*
> >> +	 * On RT rcu_core() can be preempted when IRQs aren't disabled.
> >> +	 * Therefore this function can race with concurrent NOCB (de-)offloading
> >> +	 * on this CPU and the below condition must be considered volatile.
> >> +	 * However if we race with:
> >> +	 *
> >> +	 * _ Offloading:   In the worst case we accelerate or process callbacks
> >> +	 *                 concurrently with NOCB kthreads. We are guaranteed to
> >> +	 *                 call rcu_nocb_lock() if that happens.
> >
> > If offloading races with rcu_core(), can the following happen?
> >
> >       <offload work>
> >       rcu_nocb_rdp_offload():
> >                                               rcu_core():
> >                                                 ...
> >                                                 rcu_nocb_lock_irqsave(); // no a lock
> >         raw_spin_lock_irqsave(->nocb_lock);
> >           rdp_offload_toggle():
> >             <LOCKING | OFFLOADED set>
> >                                                 if (!rcu_segcblist_restempty(...))
> >                                                   rcu_accelerate_cbs_unlocked(...);
> >                                                 rcu_nocb_unlock_irqrestore();
> >                                                 // ^ a real unlock,
> >                                                 // and will preempt_enable()
> >           // offload continue with ->nocb_lock not held
> >
> > If this can happen, it means an unpaired preempt_enable() and an
> > incorrect unlock. Thoughts? Maybe I'm missing something here?
> >
> 
> As Frederic pointed out in an earlier thread [1], this can't happen because
> we still have IRQs disabled, and the offloading process has to be processed
> on the CPU being offloaded. IOW, in the above scenario, rcu_core() can't be
> preempted by the rcu_nocb_rdp_offload() work until it re-enables IRQs at
> rcu_nocb_unlock_irqrestore().
> 
> (hopefully Paul or Frederic will correct me if I've just spewed garbage)
> 
> [1]: https://lore.kernel.org/lkml/20210930105340.GA232241@lothringen/
> 

Thanks! I think Frederic and you are right: this cannot happen. Thank
you both for looking into this ;-)

Regards,
Boqun

> > Regards,
> > Boqun
> >

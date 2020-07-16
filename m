Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26FAC433E2
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 14:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775682065D
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 14:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsolWBi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGPOhU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPOhT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 10:37:19 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE30C061755;
        Thu, 16 Jul 2020 07:37:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y13so3390238lfe.9;
        Thu, 16 Jul 2020 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kcj5G59GOTPUhqEln7W+1LEARocoTm+rR4NtydTtguo=;
        b=fsolWBi7fEMSttVRztN88vZvdXxpApiO8nGZnGfXBYuEqQm02/VSbeTmuDVv7DvsAF
         zqUaYfoMi4yCccLUSyZU1zXDHArDXbTwrgozKCgZ2Do4Q4i8AKm6uIQhjIc6WNA4pgXE
         4YAKBoHU+7Nq4gKyyIlwrhS64PiKsEmaVRAc6bfeFnRPVFKLH8blfsCtNFgf9mfi+Wf+
         YpfzD33ZXXbBkM0bgmbTRmtnCTbsVViWzb17iKY92lDfvXqaZoi4/g8bh2K6wGsei3Fb
         tu1sexbPoEq/Z2ajTY8Q7OM3XZpYMl3L9y1zSlzKDmU1Ql481NARoEKwDqspLwAKIOVn
         iTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kcj5G59GOTPUhqEln7W+1LEARocoTm+rR4NtydTtguo=;
        b=oluKmLkXk+duqSPIJJ8++CZpoiA2RggMxDW57JCID+QVka+8kwCDJloFotaQUJV/1s
         XlC8FvtwKvhxw5MIu7S+j9eeC6qFZBELdreTTAf4mSVKAEviW+0tznJ0pHJbnlvOZoLw
         Vr6kOZltBfcuMW1zhbeuTFuS2k2dxJmK4r4HF1Hj3Dl4pRsQWw27I94i/cLg0C2kfX4S
         5RH4xHiAi1vDAPMPwmkR/V7obbyqQtyIgcDfrPIGA7YJDq27U8T5uqHDYuUkb9vGtBnl
         K5rNU2OeT0OTCCFQHb0NSF8aJxrEj0AXXG8EST/jaHNHlkx9MeB7gxzvm8PBmgqsdx6C
         UPOA==
X-Gm-Message-State: AOAM532tWtlzDJf/HYfpsKtaXI87Lm5rtSqrSyVrEa9iHMbN01DE1UMk
        9NKqtZO+iDoXAVV59FpkbQQ=
X-Google-Smtp-Source: ABdhPJx4BQ3PHoFUdHg7Bvc8rgLUE3SYrUvOnJNTSabEq9+6seSXFnJKIWATP+/bQpICka1dYxxfow==
X-Received: by 2002:a19:43:: with SMTP id 64mr2244338lfa.72.1594910237254;
        Thu, 16 Jul 2020 07:37:17 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s62sm1078206lja.100.2020.07.16.07.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:37:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Jul 2020 16:37:14 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200716143714.GA30965@pc636>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
 <20200716091913.GA28595@pc636>
 <20200716133647.GA242690@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716133647.GA242690@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 16, 2020 at 09:36:47AM -0400, Joel Fernandes wrote:
> On Thu, Jul 16, 2020 at 11:19:13AM +0200, Uladzislau Rezki wrote:
> > On Wed, Jul 15, 2020 at 07:13:33PM -0400, Joel Fernandes wrote:
> > > On Wed, Jul 15, 2020 at 2:56 PM Sebastian Andrzej Siewior
> > > <bigeasy@linutronix.de> wrote:
> > > >
> > > > On 2020-07-15 20:35:37 [+0200], Uladzislau Rezki (Sony) wrote:
> > > > > @@ -3306,6 +3307,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > > >                       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > > >                               return false;
> > > > >
> > > > > +                     preempt_disable();
> > > > > +                     krc_this_cpu_unlock(*krcp, *flags);
> > > >
> > > > Now you enter memory allocator with disabled preemption. This isn't any
> > > > better but we don't have a warning for this yet.
> > > > What happened to the part where I asked for a spinlock_t?
> > > 
> > > Ulad,
> > > Wouldn't the replacing of preempt_disable() with migrate_disable()
> > > above resolve Sebastian's issue?
> > >
> > This for regular kernel only. That means that migrate_disable() is
> > equal to preempt_disable(). So, no difference.
> 
> But this will force preempt_disable() context into the low-level page
> allocator on -RT kernels which I believe is not what Sebastian wants. The
> whole reason why the spinlock vs raw-spinlock ordering matters is, because on
> RT, the spinlock is sleeping. So if you have:
> 
> raw_spin_lock(..);
> spin_lock(..);   <-- can sleep on RT, so Sleep while atomic (SWA) violation.
> 
> That's the main reason you are dropping the lock before calling the
> allocator.
> 
No. Please read the commit message of this patch. This is for regular kernel.

You did a patch:

<snip>
   if (IS_ENABLED(CONFIG_PREEMPT_RT))
       return false;
<snip>

--
Vlad Rezki

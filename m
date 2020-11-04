Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75700C4741F
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 14:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1708320739
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 14:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcrXWmsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgKDOks (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgKDOks (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 09:40:48 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216FDC061A4A;
        Wed,  4 Nov 2020 06:40:46 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id m8so17170817ljj.0;
        Wed, 04 Nov 2020 06:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sTSDxZUIuX+/oFAMSh4KmM1Q1CKq7R+2MRl2RZzI4OM=;
        b=XcrXWmsS87g75IfrGmI+WuFUogelHxzu3zvy+QJdn4/pbxBNC5fMbAfWVC90fQjk6E
         tLge93C4XSttBw/XYwCEmiaNtE90S67F+I3J1wW8XghMT/UvLMz5TxT4QXPnN72Ti99L
         SVURU6wx/0+4YabjWiKy2+gbNkkPioEJ3zm7R2Y5sxY4Xzq7AuXo80WdJGXb7mQXouvX
         OAsphFEr30h9zOCP/Q7T3V3FGpHpXrNT3/xSSsqA+qNMQRlA9gV3JQc2XF0qlngcfKSo
         msSP8VoRv8qJJPVoipm8UCz1n92fmDmLTeDh3ik1DehGR5xj698m2YGQ/CxZ7gFK+eFw
         NRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sTSDxZUIuX+/oFAMSh4KmM1Q1CKq7R+2MRl2RZzI4OM=;
        b=l4AS2uqFMO9tJefgPXjPuGnSwDiP2b3TppuMO8TELewKtyQxOasLgSIyeRLy5km4ED
         ULrzW9eIKD0S3SMgp5/L8WLEz2DYw8mmB0kNREFHuBJUih6GPxGxv99hHSjKGTSi+pyN
         nNwqc+O730S8yYgddVOGSqtBbiMakabPXbNJN+velejZrTBvY7iDo3e09n48Sa0wfvaB
         HIsu7XGgipYDTGs6vwxh47hI6eodeYPTlJLrqXW3tMyPFwUZ47w5LeoFDg6+QYTA+C6O
         wq6+TXtEEHIN9aFaOoTI2MRzok78DoXQ+Dn88Sqfelaa0hrYnNNIu38GhWNYxQi2FOYJ
         yomA==
X-Gm-Message-State: AOAM533xWnazuPfnqPt+gwfTh6eKJU+Vw3AZObsMUgPzF/BrLlYNPdqU
        aZcK7SX7h3Eumo1bcoOxG2CC5URSGWm+9g==
X-Google-Smtp-Source: ABdhPJw7Nd1iC3KwwWefm6H2n9W9kxcpNyogT5cSFxj6PObBSSIlCWkU/PX8wQXDlqBKeXpX3425aQ==
X-Received: by 2002:a2e:9a16:: with SMTP id o22mr11476974lji.395.1604500844550;
        Wed, 04 Nov 2020 06:40:44 -0800 (PST)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id h9sm428432lfp.170.2020.11.04.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 06:40:43 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 4 Nov 2020 15:40:41 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        willy@infradead.org
Subject: Re: [PATCH 01/16] rcu/tree: Add a work to allocate pages from
 regular context
Message-ID: <20201104144041.GA22473@pc636>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201103154723.GA1310511@google.com>
 <20201103163350.GA10665@pc636>
 <20201103191822.GC3249@paulmck-ThinkPad-P72>
 <20201104123553.GC17782@pc636>
 <20201104141200.GH3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104141200.GH3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 04, 2020 at 06:12:00AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 04, 2020 at 01:35:53PM +0100, Uladzislau Rezki wrote:
> > On Tue, Nov 03, 2020 at 11:18:22AM -0800, Paul E. McKenney wrote:
> > > On Tue, Nov 03, 2020 at 05:33:50PM +0100, Uladzislau Rezki wrote:
> > > > On Tue, Nov 03, 2020 at 10:47:23AM -0500, Joel Fernandes wrote:
> > > > > On Thu, Oct 29, 2020 at 05:50:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > The current memmory-allocation interface presents to following
> > > > > > difficulties that this patch is designed to overcome:
> > > > > > 
> > > > > > a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
> > > > > >    complain about violation("BUG: Invalid wait context") of the
> > > > > >    nesting rules. It does the raw_spinlock vs. spinlock nesting
> > > > > >    checks, i.e. it is not legal to acquire a spinlock_t while
> > > > > >    holding a raw_spinlock_t.
> > > > > > 
> > > > > >    Internally the kfree_rcu() uses raw_spinlock_t whereas the
> > > > > >    "page allocator" internally deals with spinlock_t to access
> > > > > >    to its zones. The code also can be broken from higher level
> > > > > >    of view:
> > > > > >    <snip>
> > > > > >        raw_spin_lock(&some_lock);
> > > > > >        kfree_rcu(some_pointer, some_field_offset);
> > > > > >    <snip>
> > > > > > 
> > > > > > b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
> > > > > >    is converted into sleepable variant. Invoking the page allocator from
> > > > > >    atomic contexts leads to "BUG: scheduling while atomic".
> > > > > > 
> > > > > > c) call_rcu() is invoked from raw atomic context and kfree_rcu()
> > > > > >    and kvfree_rcu() are expected to be called from atomic raw context
> > > > > >    as well.
> > > > > > 
> > > > > > Move out a page allocation from contexts which trigger kvfree_rcu()
> > > > > > function to the separate worker. When a k[v]free_rcu() per-cpu page
> > > > > > cache is empty a fallback mechanism is used and a special job is
> > > > > > scheduled to refill the per-cpu cache.
> > > > > 
> > > > > Looks good, still reviewing here. BTW just for my education, I was wondering
> > > > > about Thomas's email:
> > > > > https://lkml.org/lkml/2020/8/11/939
> > > > > 
> > > > > If slab allocations in pure raw-atomic context on RT is not allowed or
> > > > > recommended, should kfree_rcu() be allowed?
> > > > >
> > > > Thanks for reviewing, Joel :)
> > > > 
> > > > The decision was made that we need to support kfree_rcu() from "real atomic contexts",
> > > > to align with how it used to be before. We can go and just convert our local locks
> > > > to the spinlock_t variant but that was not Paul goal, it can be that some users need
> > > > kfree_rcu() for raw atomics.
> > > 
> > > People invoke call_rcu() from raw atomics, and so we should provide
> > > the same for kfree_rcu().  Yes, people could work around a raw-atomic
> > > prohibition, but such prohibitions incur constant costs over time in
> > > terms of development effort, increased bug rate, and increased complexity.
> > > Yes, this does increase all of those for RCU, but the relative increase
> > > is negligible, RCU being what it is.
> > > 
> > I see your point.
> > 
> > > > > slab can have same issue right? If per-cpu cache is drained, it has to
> > > > > allocate page from buddy allocator and there's no GFP flag to tell it about
> > > > > context where alloc is happening from.
> > > > > 
> > > > Sounds like that. Apart of that, it might turn out soon that we or somebody
> > > > else will rise a question one more time about something GFP_RAW or GFP_NOLOCKS.
> > > > So who knows..
> > > 
> > > I would prefer that slab provide some way of dealing with raw atomic
> > > context, but the maintainers are thus far unconvinced.
> > > 
> > I think, when preempt_rt is fully integrated to the kernel, we might get
> > new users with such demand. So, it is not a closed topic so far, IMHO.
> 
> Agreed!  ;-)
> 
> > > > > Or are we saying that we want to support kfree on RT from raw atomic atomic
> > > > > context, even though kmalloc is not supported? I hate to bring up this
> > > > > elephant in the room, but since I am a part of the people maintaining this
> > > > > code, I believe I would rather set some rules than supporting unsupported
> > > > > usages. :-\ (Once I know what is supported and what isn't that is). If indeed
> > > > > raw atomic kfree_rcu() is a bogus use case because of -RT, then we ought to
> > > > > put a giant warning than supporting it :-(.
> > > > > 
> > > > We discussed it several times, the conclusion was that we need to support 
> > > > kfree_rcu() from raw contexts. At least that was a clear signal from Paul 
> > > > to me. I think, if we obtain the preemtable(), so it becomes versatile, we
> > > > can drop the patch that is in question later on in the future.
> > > 
> > > Given a universally meaningful preemptible(), we could directly call
> > > the allocator in some cases.  It might (or might not) still make sense
> > > to defer the allocation when preemptible() indicated that a direct call
> > > to the allocator was unsafe.
> > > 
> > I do not have a strong opinion here. Giving the fact that maintaining of
> > such "deferring" is not considered as a big effort, i think, we can live
> > with it.
> 
> And agreed here as well.  If this were instead a large body of complex
> code, I might feel otherwise.  But as it is, why worry?
> 
Agreed! I do not consider it as extra complexity.

--
Vlad Rezki

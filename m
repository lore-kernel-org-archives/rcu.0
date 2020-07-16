Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F59C433E0
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A72207CB
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 19:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swyc6466"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgGPTDn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgGPTDm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 15:03:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3F3C061755;
        Thu, 16 Jul 2020 12:03:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so9493111ljm.11;
        Thu, 16 Jul 2020 12:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uQLm+yqvyyrDlHJaC2rIkXacLA9eYNZLnOlnoh9hxck=;
        b=swyc6466rHmiDhvBnx48LzOoyQSQ/+ijym4BrC1MzTTp9UR080ptucGzJBlzQD7zAQ
         9C1M49zcNPC5lGoWvuznezl471FpNOkC2wxDEZ0Z8PM1c3lQjN2RqGdB5QZJ9JtZXZke
         KCHnxANlf43CEghmN5IJKaY1KpoUmAQqhHsPm4b6vJMwxF5PZwODhGuul4K7lMBxc4HB
         i6lDT6IwXZrQgzQjNx47XJ65N2di6cEvwy/2JaeNVSxOsn6N35MsIeX6N2C2/S2AsomF
         TSo3tXPu7kosAPJ7Yx+W2VPhMBzMojFWELPapQUQVDOxeRw7ibjKvud7cX5/IDyv5Zmn
         CZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQLm+yqvyyrDlHJaC2rIkXacLA9eYNZLnOlnoh9hxck=;
        b=NGYjYNYGSFshE92aJZcZEwL3evbiTwthSbBezdYuE6Vl0PipZky7kEOhxiB5PE+Wwz
         MWyXqiqejPD6nYjtV/p/q6s2enh1xYBF0coIoB9q0yw7Xp67Z/+zacRK4ba8AN+OQpfR
         FGs5Ydgc/jpDHXYMrhtjCUf8NF85uHm0XLFn5ERc3jAurbWUkq8D5n2Psrzg4/vMxlJa
         +9p8IuNVTw2xzRXeuPx6HWQCxtd6UhxgzS/58VLM+v1ksB5vEdnZSQ2R55Iz62NZBjl4
         wTPfHIOzArzJ1R2rOowBElBjkCzZJk/P9Gwc6GyvE5MPO6FBAgSICSQHTnmIVuiDPKtr
         fQMg==
X-Gm-Message-State: AOAM530NxEmJmoHhCYwmeZ6lWd8bUwtUh9Ghvc/QzN+FS4Cs6mOT/X7t
        fczgdYHFskiOXMZsgI3Om+c=
X-Google-Smtp-Source: ABdhPJz/unK1D8S/ze0y2ZvvoDv+FobpH/NjduzAbTJs6a5h1a1rn/Gt8fbpYXHeaOhK9lV/IE6QDw==
X-Received: by 2002:a2e:90cc:: with SMTP id o12mr2794823ljg.231.1594926220802;
        Thu, 16 Jul 2020 12:03:40 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id j17sm1351027lfk.31.2020.07.16.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:03:37 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Jul 2020 21:03:35 +0200
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
Message-ID: <20200716190335.GA584@pc636>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
 <20200716091913.GA28595@pc636>
 <20200716133647.GA242690@google.com>
 <20200716143714.GA30965@pc636>
 <20200716182707.GA552227@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716182707.GA552227@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 16, 2020 at 02:27:07PM -0400, Joel Fernandes wrote:
> On Thu, Jul 16, 2020 at 04:37:14PM +0200, Uladzislau Rezki wrote:
> > On Thu, Jul 16, 2020 at 09:36:47AM -0400, Joel Fernandes wrote:
> > > On Thu, Jul 16, 2020 at 11:19:13AM +0200, Uladzislau Rezki wrote:
> > > > On Wed, Jul 15, 2020 at 07:13:33PM -0400, Joel Fernandes wrote:
> > > > > On Wed, Jul 15, 2020 at 2:56 PM Sebastian Andrzej Siewior
> > > > > <bigeasy@linutronix.de> wrote:
> > > > > >
> > > > > > On 2020-07-15 20:35:37 [+0200], Uladzislau Rezki (Sony) wrote:
> > > > > > > @@ -3306,6 +3307,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > > > > >                       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > > > > >                               return false;
> > > > > > >
> > > > > > > +                     preempt_disable();
> > > > > > > +                     krc_this_cpu_unlock(*krcp, *flags);
> > > > > >
> > > > > > Now you enter memory allocator with disabled preemption. This isn't any
> > > > > > better but we don't have a warning for this yet.
> > > > > > What happened to the part where I asked for a spinlock_t?
> > > > > 
> > > > > Ulad,
> > > > > Wouldn't the replacing of preempt_disable() with migrate_disable()
> > > > > above resolve Sebastian's issue?
> > > > >
> > > > This for regular kernel only. That means that migrate_disable() is
> > > > equal to preempt_disable(). So, no difference.
> > > 
> > > But this will force preempt_disable() context into the low-level page
> > > allocator on -RT kernels which I believe is not what Sebastian wants. The
> > > whole reason why the spinlock vs raw-spinlock ordering matters is, because on
> > > RT, the spinlock is sleeping. So if you have:
> > > 
> > > raw_spin_lock(..);
> > > spin_lock(..);   <-- can sleep on RT, so Sleep while atomic (SWA) violation.
> > > 
> > > That's the main reason you are dropping the lock before calling the
> > > allocator.
> > > 
> > No. Please read the commit message of this patch. This is for regular kernel.
> 
> Wait, so what is the hesitation to put migrate_disable() here? It is even
> further documentation (annotation) that the goal here is to stay on the same
> CPU - as you indicated in later emails.
> 
Actually preempt_disable() does the same for !RT. I agree that
migrate_disable() annotation looks better from the point you
mentioned.

> And the documentation aspect is also something Sebastian brought. A plain
> preempt_disable() is frowned up if there are alternative API that document
> the usage.
> 
> > You did a patch:
> > 
> > <snip>
> >    if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >        return false;
> > <snip>
> 
> I know, that's what we're discussing.
> 
> So again, why the hatred for migrate_disable() ? :)
> 
Let's do migrate_disable(), i do not mind :)

--
Vlad Rezki

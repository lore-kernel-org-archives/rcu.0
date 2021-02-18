Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC1FC433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 08:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4267C64E85
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 08:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBRIuE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 03:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhBRIta (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 03:49:30 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3501C061756;
        Thu, 18 Feb 2021 00:36:41 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r23so2996367ljh.1;
        Thu, 18 Feb 2021 00:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M9artFNahNJXMTqeblKUa+liYcJDw6ZriCndVjRs68A=;
        b=L6M9dQQWFbNg0rv9keR8DU1O6CbzcyEmgRaX2KNjScJ1vX1UCgGvSfgipA1EWLitBg
         LP+E04a4HSZq550hUu1fZsQ1ksA6Ygbl8HiEOkSI+OFw1NJ8LORwgAOGBZBOLMZThISr
         7jO+giYF5UoytvP3+NpZrtlqmD7/emqH75Qv8Nof98RZTLbyP5wYyGG+I3hOODkqSOq8
         5sT6SyQ4iiGeBrTQRIEU1n/RJAdWXXycuFf5hhS+pnYqAlnWUAtgstVpJu+p1OONMCow
         +8/5O/W+fw7pSTmFgEjhRVR/FDXQQuDGQu/iSeVkZI30uSHZSYwT0yvXLVENm2y6OSa+
         d8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M9artFNahNJXMTqeblKUa+liYcJDw6ZriCndVjRs68A=;
        b=eBkXx4Yn2DmRJzOh4fZkS68PCP862whs6vziGTKVjjfLDmC8rWVaykxxg+3K1J2slb
         iFsJVu5q0QIkd1HNLEqYuqL9awvZPeeJSzS5wqpUBlDOsO716F5+T9EXAlvAV20FA0K4
         MI8FlUJe7MBMAIywlynzkiXHD5/y+5fkCwL9k1GiuC150LkYXh7mtdL2WdCYUr3WpxIO
         e0q5xwQ7oaSf7HE4qEqtVt4Ra6HdLmaTq4D5/eqwppGDARuNVnyvnu97w6XzjIsybBrb
         Few75BjbznZOvTPnyy19RJMDtJ1wDaHQt+nCJ5z0kFibh+5EBmFfWd9s1g0RPulS2hOi
         0J4w==
X-Gm-Message-State: AOAM5314t0Bu5RZkJBeS2pm2rRJ379FJPq4Liu4KjZQvWAyT55kbG6bc
        VM7jxVGm8WuQnYysxEx5hrs=
X-Google-Smtp-Source: ABdhPJwSC2MTfD3teUGS/hLfmQ1NgyPeVuBn9o2aRZonuPlXX3vyyLZGzMQiIShONegI0t0WQv38tA==
X-Received: by 2002:a2e:90cc:: with SMTP id o12mr1966972ljg.464.1613637399063;
        Thu, 18 Feb 2021 00:36:39 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id s12sm528556lfo.143.2021.02.18.00.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 00:36:38 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 18 Feb 2021 09:36:36 +0100
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     paulmck@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        rostedt@goodmis.org
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-ID: <20210218083636.GA2030@pc638.lan>
References: <20210212234851.GP2743@paulmck-ThinkPad-P72>
 <20210213003709.GA27846@paulmck-ThinkPad-P72>
 <20210213004328.GB27846@paulmck-ThinkPad-P72>
 <20210213113030.GA1878@pc638.lan>
 <20210213164554.GS2743@paulmck-ThinkPad-P72>
 <20210215112826.xc6b4se6ujwvrwco@linutronix.de>
 <20210216173003.GX2743@paulmck-ThinkPad-P72>
 <20210217234759.b82e39049a2e99cf6358e1c2@kernel.org>
 <20210217181738.GE2743@paulmck-ThinkPad-P72>
 <20210218140307.71f475248ebefa0ca613c09e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218140307.71f475248ebefa0ca613c09e@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 18, 2021 at 02:03:07PM +0900, Masami Hiramatsu wrote:
> On Wed, 17 Feb 2021 10:17:38 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > > 1.	Spawn ksoftirqd earlier.
> > > > 
> > > > 2.	Suppress attempts to awaken ksoftirqd before it exists,
> > > > 	forcing all ksoftirq execution on the back of interrupts.
> > > > 
> > > > Uladzislau and I each produced patches for #1, and I produced a patch
> > > > for #2.
> > > > 
> > > > The only other option I know of is to push the call to init_kprobes()
> > > > later in the boot sequence, perhaps to its original subsys_initcall(),
> > > > or maybe only as late as core_initcall().  I added Masami and Steve on
> > > > CC for their thoughts on this.
> > > > 
> > > > Is there some other proper fix that I am missing?
> > > 
> > > Oh, I missed that the synchronize_rcu_tasks() will be involved the kprobes
> > > in early stage. Does the problem only exist in the synchronize_rcu_tasks()
> > > instead of synchronize_rcu()? If so I can just stop optimizer in early stage
> > > because I just want to enable kprobes in early stage, but not optprobes.
> > > 
> > > Does the following patch help?
> > 
> > It does look to me like it would!  I clearly should have asked you about
> > this a couple of months ago.  ;-)
> > 
> > The proof of the pudding would be whether the powerpc guys can apply
> > this to v5.10-rc7 and have their kernel come up without hanging at boot.
> 
> Who could I ask for testing this patch, Uladzislau?
> I think the test machine which enough slow or the kernel has much initcall
> to run optimization thread while booting.
> In my environment, I could not reproduce that issue because the optimizer
> was sheduled after some tick passed. At that point, ksoftirqd has already
> been initialized.
> 
From my end i did some simulation and had a look at your change. So the
patch works on my setup. I see that optimization of kprobes is deferred
and can be initiated only from the subsys_initcall() phase. So the sequence
should be correct for v5.10-rc7:

1. ksoftirq is setup early_initcall();
2. rcu_spawn_tasks_* are setup in the core_initcall();
3. an optimization of kprobes are invoked from subsys_initcall().

For real test on power-pc you can ask Daniel Axtens <dja@axtens.net> for help. 

--
Vlad Rezki

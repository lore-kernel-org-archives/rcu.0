Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578DCC433E0
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7702065F
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 15:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT6gOuw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgGPPef (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgGPPef (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 11:34:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DA0C061755;
        Thu, 16 Jul 2020 08:34:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y18so3634586lfh.11;
        Thu, 16 Jul 2020 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wa186aYiFLYKssSecQBUE+3MH15z3xTby6qCg2AUg3E=;
        b=UT6gOuw65rx5hu9zS9LXU+Tpi1khKAosbBXpSNmANhffltq/DLTxNtCmDpLEVuTWDS
         tq3Myqv2AMC6ywTouzyNflJakW6wktJdvosfbx4zFb9jR2B6iwUv0CW0vNuK0zfX+rTZ
         lKFueF5dTJHmNkCfTZowDfqBOdQw0870tACaDdv1hHEG6wWpDbrW9h5CiQm8vow7/m/D
         Du06gQk6djTprEG0A/BiRsYTCuAs0vtcBdblb8czKQJt271Lfjgf5OhKeYRYQVzQey8L
         bDo8GBS26sBGvOhqzjYAz53tGOHHkLNbZLQf16d9STj6zOoq9VFoxUnhX6CEvosBff1S
         NhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wa186aYiFLYKssSecQBUE+3MH15z3xTby6qCg2AUg3E=;
        b=d8E/2ZlviJS6CrTPhGIwCB2OnqMDTNFJ7cwJH3/q1QbPXQS8rSeRysMQZuBLZl6gdJ
         hAxxvLP/BO1PDbV3NwBFQHbaR5nrBfV4IOnRETzO9uCQ45VGa5NrAyxCpkSKm2KheZqU
         zcfhJ14OpPHbtq1AmOBJPKrRM0YVT+Gky5FK3h80KNbKCxZby5qSMkX+Zae2o35Eyocc
         pO9VNGxuqvORRouiYD+nYl02n9ucRgjjuoqwbckMOrQA4cnJoh+x7Eu6WMqcQrysbyJ1
         t13LRkFOfXgYD/y/S2Ok2IBau0AA9BWnVNAov6EHs7/PZ6YShZmDoUAld++SOrlRB6Ks
         qFSA==
X-Gm-Message-State: AOAM533X8xbB8Kt3yE8ueR3zElYcL+aRKXzHOYQV6Zgan/3kYpSEqQ5r
        zYGzk96U4aQxNYPKzOXlwJw=
X-Google-Smtp-Source: ABdhPJxQKVzXdd/2TuQ3vqMa1B4aHBHoA3r1YE1G0WnYJLh+FGabiRX28tdvsXd23NnXvJ4XJlpVsA==
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr2385417lfp.68.1594913673496;
        Thu, 16 Jul 2020 08:34:33 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id q3sm1111749ljm.22.2020.07.16.08.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:34:32 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Jul 2020 17:34:30 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200716153430.GA31261@pc636>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
 <20200716091913.GA28595@pc636>
 <20200716142537.ecp4icsq7kg6qhdx@linutronix.de>
 <20200716144728.GA31046@pc636>
 <20200716150414.iqpyby6nrww4zbyk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716150414.iqpyby6nrww4zbyk@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 16, 2020 at 05:04:14PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-16 16:47:28 [+0200], Uladzislau Rezki wrote:
> > On Thu, Jul 16, 2020 at 04:25:37PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-07-16 11:19:13 [+0200], Uladzislau Rezki wrote:
> > > > Sebastian, could you please confirm that if that patch that is in
> > > > question fixes it?
> > > > 
> > > > It would be appreciated!
> > > 
> > > So that preempt disable should in terms any warnings. However I don't
> > > think that it is strictly needed and from scheduling point of view you
> > > forbid a CPU migration which might be good otherwise.
> > >
> > Please elaborate your point regarding "i do not think it is strictly needed".
> > 
> > Actually i can rework the patch to remove even such preempt_enable/disable
> > to stay on the same CPU, but i do not see the point of doing it.
> > 
> > Do you see the point?
> 
> You disable preemption for what reason? It is not documented, it is not
> obvious - why is it required?
> 
I can document it. Will it work for you? Actually i can get rid of it
but there can be other side effects which also can be addressed but
i do not see any issues of doing just "preemtion off". Please have
a look at sources across the kernel how many times a memory is
requested in atomic context:

<snip>
preempt_disable() os any spinlock or raw_locks, etc..
__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
or
kmalloc(GFP_ATOMIC);
<snip>

all those flags say to page allocator or SLAB that sleeping is not
allowed.

> > As for scheduling point of view. Well, there are many places when there
> > is a demand in memory or pages from atomic context. Also, getting a page
> > is not considered as a hot path in the kfree_rcu(). 
> 
> If you disable preemption than you assume that you wouldn't be atomic
> otherwise. You say that at this point it is not a hot path so if this is
> not *that* important why not allow preemption and allow the schedule to
>
If i disable preemption, it means that atomic section begins. Let me
explain why i disable preemption.

If i invoke a page allocator in full preemptable context, it can be
that we get a page but end up on another CPU. That another CPU does
not need it, because it has some free spots in its internal array
for pointer collecting. If we stay on the same CPU we eliminate it.

The question is what to do with that page. I see two solutions.

1) Queue it to the CPU2 page cache for further reuse or freeing.
2) Just proceed with newly allocated page thinking that previous
   "bulk arry" is partly populated, i.e. it can be that previous
   one has plenty of free spots.

Actually that is why i want to stay on the same CPU.

>
> place you somewhere else if the scheduler decides that it is a good idea.
> 
It is not a hot path, really. I do not consider it as critical, since the
page allocator will not do much work(we use restricted flags), on a high
level it is limited to just ask a page and return it. If no page, check
watermark, if low, wakeup kswapd and return NULL, that is it.

> > > Also if interrupts and everything is enabled then someone else might
> > > invoke kfree_rcu() from BH context for instance.
> > > 
> > And what? What is a problem here, please elaborate if you see any
> > issues.
> 
> That the kfree_rcu() caller from BH context will end up here as well,
> asking for a page.
> 
Please think about that CPU0 is somewhere in __get_free_page(), when it
is still there, there comes an interrupt that also calls kfree_rcu()
and end up somewhere in __get_free_page(). To prevent such internal
critical sections usually the code disables irqs and do some critical
things to prevent of breaking something. 

So, basically __get_free_page() can be interrupted and being invoked
one more time on the same CPU. It uses spin_lockirqsave() for such
scenarios.

Our internal lock is dropped.

--
Vlad Rezki

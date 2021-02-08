Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5C9C433E0
	for <rcu@archiver.kernel.org>; Mon,  8 Feb 2021 12:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66AF64E42
	for <rcu@archiver.kernel.org>; Mon,  8 Feb 2021 12:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhBHMqu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Feb 2021 07:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhBHMqt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Feb 2021 07:46:49 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD31C06174A;
        Mon,  8 Feb 2021 04:46:09 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f19so16787273ljn.5;
        Mon, 08 Feb 2021 04:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rDzbovQf+m2HT1RtAwhlf4DB2G60MVFL22m+m2kRh44=;
        b=aKUlItJqmZN42uNmYGm0cxo8S5689U20hHbe8+k/oLO8sCoaudZJfVq69UqLqj/ggX
         4FIXFFv9FhPmncJdgJEUP9KEOIFhEDX8tO21DHrDpiuzzGC71Y1turdx9UHwUTqKVREy
         VPefGkjKFXlXbANhcpeaYgYStLMjblZLFoE9Vce30y8UzCWtHYfUwKkXYes2FhbpLoQA
         SkiBmanpK2Sl+QbPEBo7wHYhZ6IQ0LHLHQP4zR0wDYh0JTfM78oWi3VRNUO78wrmclfd
         TafExqrccELWYoj/0NeelruId7APHqJAsBGyXW0DHev7rkcyZ8rPQ6vtBMDIVAHffXN5
         NmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rDzbovQf+m2HT1RtAwhlf4DB2G60MVFL22m+m2kRh44=;
        b=ooxn1uoJGVlpBhxlgrD62qr8cL74P8/lBlyXCnf3iCNEgB/cPP1waUv4fBp5xDvVCb
         02y2MusUl0mJrSnXb1/zY60FcyxhIfprIOgsKyO7UQ3PVKA3B2bNFRl1bbFdXRGOGG19
         yik3KSF3xzHKhWNkVk6v0PgPNCHaQFQFN7zbYo/oL0KbOB5sLOy2W2oon2os4OjKdr9y
         O5MQycGttn39UJOIHFXOzgnAtVGLylgy/qkqohQQPBOJq4QKKkXXRq5zEQqwyq59KtiE
         rOugKVPOpl38FERbP+c06veENk2WsZ2pcmJXyY6iEkkBhmS7nHP6BFPFsYWEYzXGaW2b
         ekMg==
X-Gm-Message-State: AOAM533k7cp12lZDGJRVh/kuhiYzoJWhRTqbe7gB5wTbId+4cZHNyB4v
        0uIDlDd+9Kn2ON5D9aH0790=
X-Google-Smtp-Source: ABdhPJzADCb8cqg8rUQrAcRiB0GUTTFxKFwjuGap4sU0gozxdG0omVaHaAJrMxFJ4i4fM8nW8qhY1g==
X-Received: by 2002:a2e:b176:: with SMTP id a22mr5674497ljm.204.1612788367779;
        Mon, 08 Feb 2021 04:46:07 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id r19sm308713lff.214.2021.02.08.04.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 04:46:07 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 8 Feb 2021 13:46:05 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/2] kvfree_rcu: Use same set of flags as for
 single-argument
Message-ID: <20210208124605.GB1920@pc638.lan>
References: <20210129200505.5273-1-urezki@gmail.com>
 <20210129200505.5273-2-urezki@gmail.com>
 <20210204220427.GM2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204220427.GM2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 04, 2021 at 02:04:27PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 29, 2021 at 09:05:05PM +0100, Uladzislau Rezki (Sony) wrote:
> > Running an rcuscale stress-suite can lead to "Out of memory"
> > of a system. This can happen under high memory pressure with
> > a small amount of physical memory.
> > 
> > For example a KVM test configuration with 64 CPUs and 512 megabytes
> > can lead to of memory after running rcuscale with below parameters:
> > 
> > ../kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig CONFIG_NR_CPUS=64 \
> > --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 \
> >   rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
> > 
> > <snip>
> > [   12.054448] kworker/1:1H invoked oom-killer: gfp_mask=0x2cc0(GFP_KERNEL|__GFP_NOWARN), order=0, oom_score_adj=0
> > [   12.055303] CPU: 1 PID: 377 Comm: kworker/1:1H Not tainted 5.11.0-rc3+ #510
> > [   12.055416] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> > [   12.056485] Workqueue: events_highpri fill_page_cache_func
> > [   12.056485] Call Trace:
> > [   12.056485]  dump_stack+0x57/0x6a
> > [   12.056485]  dump_header+0x4c/0x30a
> > [   12.056485]  ? del_timer_sync+0x20/0x30
> > [   12.056485]  out_of_memory.cold.47+0xa/0x7e
> > [   12.056485]  __alloc_pages_slowpath.constprop.123+0x82f/0xc00
> > [   12.056485]  __alloc_pages_nodemask+0x289/0x2c0
> > [   12.056485]  __get_free_pages+0x8/0x30
> > [   12.056485]  fill_page_cache_func+0x39/0xb0
> > [   12.056485]  process_one_work+0x1ed/0x3b0
> > [   12.056485]  ? process_one_work+0x3b0/0x3b0
> > [   12.060485]  worker_thread+0x28/0x3c0
> > [   12.060485]  ? process_one_work+0x3b0/0x3b0
> > [   12.060485]  kthread+0x138/0x160
> > [   12.060485]  ? kthread_park+0x80/0x80
> > [   12.060485]  ret_from_fork+0x22/0x30
> > [   12.062156] Mem-Info:
> > [   12.062350] active_anon:0 inactive_anon:0 isolated_anon:0
> > [   12.062350]  active_file:0 inactive_file:0 isolated_file:0
> > [   12.062350]  unevictable:0 dirty:0 writeback:0
> > [   12.062350]  slab_reclaimable:2797 slab_unreclaimable:80920
> > [   12.062350]  mapped:1 shmem:2 pagetables:8 bounce:0
> > [   12.062350]  free:10488 free_pcp:1227 free_cma:0
> > ...
> > [   12.101610] Out of memory and no killable processes...
> > [   12.102042] Kernel panic - not syncing: System is deadlocked on memory
> > [   12.102583] CPU: 1 PID: 377 Comm: kworker/1:1H Not tainted 5.11.0-rc3+ #510
> > [   12.102600] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> > <snip>
> > 
> > Having a fallback mechanism we should not go with "GFP_KERNEL | __GFP_NOWARN"
> > that implies a "hard" page request involving OOM killer. Replace such set with
> > the same as the one used for a single argument.
> > 
> > Thus it will follow same rules:
> >     a) minimize a fallback hitting;
> >     b) avoid of OOM invoking;
> >     c) do a light-wait page request;
> >     d) avoid of dipping into the emergency reserves.
> > 
> > With this change an rcuscale and the parameters which are in question
> > never runs into "Kernel panic".
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> I did have some misgivings about this one, but after a closer look at
> the GFP flags you suggest along with offlist discussions it looks like
> what needs to happen.  So thank you for persisting!  ;-)
> 
> I did the usual wordsmithing as shown below, so please check to make
> sure that I did not mess anything up.
> 
Looks good to me, i mean a rewording of the commit message :)

--
Vlad Rezki

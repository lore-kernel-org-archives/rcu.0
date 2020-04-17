Return-Path: <SRS0=YclE=6B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99246C2D0EF
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 18:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D12A20771
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 18:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pSVSKbwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgDQS0o (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730407AbgDQS0o (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 17 Apr 2020 14:26:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43E0C061A0C
        for <rcu@vger.kernel.org>; Fri, 17 Apr 2020 11:26:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o19so3456769qkk.5
        for <rcu@vger.kernel.org>; Fri, 17 Apr 2020 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EGV5iBCdgUI9bxOhbrbPqcJYXUWmv8zZdPW9n0KUVqI=;
        b=pSVSKbwJ6KZDupYAQJM8TBEpDpoxgWL3SDWvOufXXp2TU8fEG92Ygsg5Br/CqHDPH5
         2X+UyktOQtZwLOYyE75bqRZLY+qHcdrBmFhlLpWUs5Q7i6ndN2U4G8FJnT+ZTvmOa76P
         dLOPB+hPXx5w72eztEimFR1IzxoUBq4F+XXBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EGV5iBCdgUI9bxOhbrbPqcJYXUWmv8zZdPW9n0KUVqI=;
        b=YQHsfPsyI+5hhtENIFU8hRyPbOvxXuesZ2xdZbnlJozBxlpmkqBq/UmRWAIZ9GI0qa
         knnFXo4l1oYk7Dw+KvGQbXI/XEc0wB7YVjBYZ3F9cM5tOcvjMyeE/waimi3t5iaJMLbh
         Gkv3FwkB/bjLyRFBwlEin8uRF9LySRcqO1L8COs/LJbVGKUC3KiuYJSrwDf3MdWPQAF3
         1J7ooX0CdB17uJ+MWFwACIxiJba6DP2xqjBI9NKs+OmMnlvEaUFN5dIQoHragIwRI6Lo
         B75On0ZTZGeQt91XBtLJCLNVATgst6yZkUHxldJFAXWxxHJOrndwdldNB1fv8rhxczq2
         xLvQ==
X-Gm-Message-State: AGi0PuZOns1EzFf5ZyRVBxhxwlJL9PJSPdLA/yAfnYsFvy4tld+m7YHP
        z0lsnA1ZWA51Hb/UzgUeEe7DNg==
X-Google-Smtp-Source: APiQypIhCpWG0cLNE8U8FY33oyf2Je0AVv7b/LPlQuj5JKl6ZzkGpA60u41QIx/FIhpy7KGSxJNpYA==
X-Received: by 2002:a37:5347:: with SMTP id h68mr4643570qkb.451.1587148002869;
        Fri, 17 Apr 2020 11:26:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b13sm14130361qka.20.2020.04.17.11.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 11:26:42 -0700 (PDT)
Date:   Fri, 17 Apr 2020 14:26:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200417182641.GB168907@google.com>
References: <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416203637.GA176663@google.com>
 <20200416210057.GY17661@paulmck-ThinkPad-P72>
 <20200416213444.4cc6kzxmwl32s2eh@linutronix.de>
 <20200417030515.GE176663@google.com>
 <20200417150442.gyrxhjymvfwsvum5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417150442.gyrxhjymvfwsvum5@linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 17, 2020 at 05:04:42PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-16 23:05:15 [-0400], Joel Fernandes wrote:
> > On Thu, Apr 16, 2020 at 11:34:44PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-04-16 14:00:57 [-0700], Paul E. McKenney wrote:
> > > > 
> > > > We might need different calling-context restrictions for the two variants
> > > > of kfree_rcu().  And we might need to come up with some sort of lockdep
> > > > check for "safe to use normal spinlock in -rt".
> > > 
> > > Oh. We do have this already, it is called CONFIG_PROVE_RAW_LOCK_NESTING.
> > > This one will scream if you do
> > > 	raw_spin_lock();
> > > 	spin_lock();
> > > 
> > > Sadly, as of today, there is code triggering this which needs to be
> > > addressed first (but it is one list of things to do).
> > > 
> > > Given the thread so far, is it okay if I repost the series with
> > > migrate_disable() instead of accepting a possible migration before
> > > grabbing the lock? I would prefer to avoid the extra RT case (avoiding
> > > memory allocations in a possible atomic context) until we get there.
> > 
> > I prefer something like the following to make it possible to invoke
> > kfree_rcu() from atomic context considering call_rcu() is already callable
> > from such contexts. Thoughts?
> 
> So it looks like it would work. However, could we please delay this
> until we have an actual case on RT? I just added
> 	WARN_ON(!preemptible());

I am not sure if waiting for it to break in the future is a good idea. I'd
rather design it in a forward thinking way. There could be folks replacing
"call_rcu() + kfree in a callback" with kfree_rcu() for example. If they were
in !preemptible(), we'd break on page allocation.

Also as a sidenote, the additional pre-allocation of pages that Vlad is
planning on adding would further reduce the need for pages from the page
allocator.

Paul, what is your opinion on this?

thanks,

 - Joel


> 
> to kfree_call_rcu() on v5.6.4-rt4 and nothing triggered.
> 
> This is the list of users I had (just to figure out if this is used at
> all):
> - addrconf_ifdown
> - cgroup_free
> - cgroup_migrate_finish
> - css_task_iter_end
> - disk_expand_part_tbl
> - drop_sysctl_table
> - __hw_addr_flush
> - inetdev_event
> - ip6addrlbl_net_exit
> - ip6addrlbl_net_exit
> - ops_exit_list.isra.0
> - rtnl_register_internal
> - simple_set_acl
> - swevent_hlist_put_cpu
> - timerfd_release
> - vfs_rename
> - __xfs_set_acl
> 
> Sebastian

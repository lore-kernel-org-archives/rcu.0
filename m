Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFD6C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 20:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7314321744
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 20:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8hjkEah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgDPUGM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731673AbgDPUGL (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 16:06:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA85FC061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 13:06:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r24so9268856ljd.4
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MHxkgv/IS+vQO2YVqcbuUZB+07k6qBD5YsO+zM3lefk=;
        b=V8hjkEahKf5AW3kp73ZRmoJHU8BhRYL3R2qh7tP3O/WR63o/vpOwWzo2e/U4iv+e7x
         T8FAa2epVHweyZdQ/teaL4D9gRgjszg4ib4NeSYdILqFdl61+QUvW2aDhGix2oXn11Th
         BXqX26WOjo083yJ1+HIY/O+gVWSv0Au/9gFUlP1SzlztuULeVMVePg7Mt/FhfMDV9ZJu
         kIYYAN3xske3RoJk34V3EVw7SG4v0nNmvBhkOLsw41aJK59GRuqRrGyT6xdXEQQXkwJD
         kO88yt4Sl7OogdV7Bw9JRzM610jUHRsN2BiEevuP6AM8b9cu5sBjTPzJDGXQaowF6EWw
         USSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MHxkgv/IS+vQO2YVqcbuUZB+07k6qBD5YsO+zM3lefk=;
        b=On+QNcEeuDywi76xkA7D6+Wzt08Dw86aQOcKSdlnugIDiVcCU0relNz3EfHCkdNb8b
         D1BX2AwXSehSnznoELjXee2x+3gmAK0i22GVv9kDYI5QOrHe0it0xcasm8RVPN+oSBTf
         nna7I6wHINn2CgmbFfmlgrTe/DpmS7mT7iqv3CODxFe0Wg8H3ZHvY3ZT8XY10iQcBY0H
         rsNXVThTETOxFdkbfSNHLwP5z47znNILUMRYI3J2Uh+PYiH5o95LdpgI9p19M218mvPh
         Up2O3BSB3VM1eW5YzGATuB+xsDUeURR2bBxQjo8MLFgInZ3cPW+c+WEIfpq9Ig0ctctY
         kG+g==
X-Gm-Message-State: AGi0PuY6JeKsGf5SwqcIcOvMTW2XAHZPvs7+y16YmacDJUFQ3anH6BMJ
        pqp8UjWZw1QwtF+VCrrTT4ZcRebKvnE=
X-Google-Smtp-Source: APiQypLwaSS50Gnf2Yadoj48BhQWWh02M/VWoYLy9wytBx5p8TvL+zv63bnexQItMukLMjEiea7xXA==
X-Received: by 2002:a2e:b5b2:: with SMTP id f18mr7189516ljn.136.1587067568274;
        Thu, 16 Apr 2020 13:06:08 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l7sm16945620lfg.79.2020.04.16.13.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:06:04 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Apr 2020 22:05:57 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416200557.GA11301@pc636>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416195327.GW17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416195327.GW17661@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 12:53:27PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 16, 2020 at 03:26:23PM -0400, Steven Rostedt wrote:
> > On Thu, 16 Apr 2020 14:59:34 -0400
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > But, then will it be safe for kfree_rcu() callers from hard IRQ context to
> > > call this in PREEMPT_RT? That could would just break then as you cannot sleep
> > > in hard IRQ context even on PREEMPT_RT.
> > 
> > But where in PREEMPT_RT would it be called in hard IRQ context?
> 
> I believe that call_rcu() is invoked with raw spinlocks held, so we should
> allow kfree_rcu() to be invoked from similar contexts.  It obviously
> cannot allocate memory in such contexts, so perhaps the rule is that
> single-argument kfree_rcu() cannot be invoked within hard IRQ contexts
> or with raw spinlocks held.  In those contexts, you would instead need
> to invoke two-argument kfree_rcu(), which never needs to allocate memory.
> 
> Seem reasonable?
> 
Paul, just to make it more clear, even invoking two arguments fkree_rcu()
currently does an allocation. We maintain an array that contains pointers
for "bulk logic". 

--
Vlad Rezki

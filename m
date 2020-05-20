Return-Path: <SRS0=9J+a=7C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DF9C433DF
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 18:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D054206C3
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 18:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIMaAXT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgETSuM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 May 2020 14:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgETSuL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 May 2020 14:50:11 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB8C061A0E;
        Wed, 20 May 2020 11:50:11 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c21so2974056lfb.3;
        Wed, 20 May 2020 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CbVGwxZLKRnq0rt2K9zGYbx9SxMA/Df1UT34H3Wxb5o=;
        b=OIMaAXT+9JBJiT8OHcFcbjovt6et1jVWHkFoETHTBiCZMW4Vi20WOh0SvQmBUgopk5
         K9QDFPkQf0PTEPJ5ykUF1Xv/W1cJSqECeObDaZbDm5C94GX9lpONVdMm1ZeBB+5ombQp
         HktBd/JAWQHA+gx32bRgJrnLzUkgEgW0FZJ6YR4KDtP8bllG5izU14G5oL7JZEviy2tK
         ONWmfZeiACSBoiiYdT3QFB8VcFMAdJj5nNNS6kMmZeyeqf5FTk64gWQO9dBz/AJLFOWs
         YLhfQ36PGLaa+jCx7CzdGsN3j1E9xoxY8r3pUiOWlJJ4q1aaKJ3tRly6AVB/zuVOksT4
         Tgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CbVGwxZLKRnq0rt2K9zGYbx9SxMA/Df1UT34H3Wxb5o=;
        b=lwMxpr6bzNBU1PtQ4oNVCO9cEh1RDZ6jTTHRMv76j/N1rMGciCaGfaJ38sDKbca7wo
         VkrwjxW+xsCBqYieIQGi1H/aDZrrILS+vMwIwVkjLXuMw6q4fmBxQJWGDX6fGPJU32AI
         8QpG/N+AuMcdrB2IXR6AcMepAfrFueptjV7bonie5ozBXhvFUuJh5+zEjH+ubANdRDZF
         jYfJckUvyoZddXUtWNsHeC/lggUDbILgG4FzmpxOHaJhpMwDII2/fuEXu+Uhm93dc2dv
         pO54/cj2tXIne9e/S3b4w4KIUur1bv5p6TJEW+hgigrFfV9LvKCe/zYfEGRXkwO73mHD
         /3Jg==
X-Gm-Message-State: AOAM533pkMoc7SbBP4LVw4HpYpEE93fuIbt7HBN+ncwzQe3zeHaXK36X
        LcHGnkR/CnOQMc0pGmc9BHE=
X-Google-Smtp-Source: ABdhPJzpl4cwsHJZrldCeqPRZ1d0ahOVRjNHMLD4ClVO0veKadPYOdybhNiaHr3HOaCN/QkVaExVTQ==
X-Received: by 2002:ac2:550a:: with SMTP id j10mr3199303lfk.46.1590000609975;
        Wed, 20 May 2020 11:50:09 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id h15sm1221227ljj.10.2020.05.20.11.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:50:07 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 20 May 2020 20:50:05 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200520185005.GA15928@pc636>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520174259.GA247557@google.com>
 <20200520182800.sdp6t6bgbhn4kkqk@linutronix.de>
 <20200520183529.GR317569@hirez.programming.kicks-ass.net>
 <20200520184425.GA261674@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520184425.GA261674@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>
> I actually found it in RT 4.4 kernel, I thought this was also on newer RT
> kernels as well (is that not true anymore?). But yes it was exactly what
> Peter said.
> 
I see it also in 5.6.4 linut-rt-devel:

<snip>
#ifdef CONFIG_PREEMPT_RT
...
# define get_local_ptr(var) ({ \
 migrate_disable(); \
 this_cpu_ptr(var); })
...
<snip>

--
Vlad Rezki

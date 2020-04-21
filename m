Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3B4C54FD0
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 13:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9072720672
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 13:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/h0HwZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgDUNpr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728479AbgDUNpq (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 21 Apr 2020 09:45:46 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7E3C061A10
        for <rcu@vger.kernel.org>; Tue, 21 Apr 2020 06:45:46 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u6so14047557ljl.6
        for <rcu@vger.kernel.org>; Tue, 21 Apr 2020 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jgND+vYKjZ2Frd/vEGKk4vcUm9XKaFngOUPSU0cv0iY=;
        b=S/h0HwZwFEUOfFjkRgVUOVKLt6Rn4vXV8pV6DLmWY+V2SSyLb+aavi18zuOCn0ylM9
         tZ4xyWeA2WxL/klZEvZu3CvYvs+/zmjmTiaWAlSJpeDl/jrYUgjiIDiORhrtlAgWQFYC
         zJ0gGYvS268jSue0xGCFt9pzQYPiTc61QpzAevLcasioylWzZ4JFHo+f+TfGTy1gHsRr
         qjBmWnqdvXNqQOZ32HI1bRuREnhwasqABQAmEAC1+5d654ACzFEr6eeloe4I6fjHhCdv
         SrRZqu7Ux6deemycZYpfF2JDCav2qghEJ/PSTWwa/fiB00Uuipe5RZQa3shL8lT63Mfz
         JKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jgND+vYKjZ2Frd/vEGKk4vcUm9XKaFngOUPSU0cv0iY=;
        b=uoLaBlxpekpuEf3VxlNs1neznJw/2nurKOlcV0QVURibpH/7qZI6I7YI3nrS+zBs5b
         302rhY+OkBJBJe2cjiTbqz/cBsgd8sRmwbXnFaOzD7DBp4v+7dJZliKBVi/36PY4ro3k
         MaBEr4X+rqFBr2hl/vM7ltg8OV+/dKui0GKZ9VFwT4UDxBEquLmYjqEhphjMKYCo/GVD
         ur9EuJw/RCTJ9zkC7h4jII+rNS7iPKrkf2ut99Aj4vUxQY10MwupOU5L8uRVDYFMlzU8
         cTzsEpA3ZKp8JVL9T6Zzl5vc55zU8Asaf44t16gcMaAOYVgXPNArBcVrzW9FKaQVhmCz
         jLVA==
X-Gm-Message-State: AGi0PubFEhe6DGUS4GognVCLaQHQG8xGGiz6Ts9AXs7JesQnkUxAEj4b
        RgwNy7O254U4NGx3y+xWFCwtPbQx9ZvEcA==
X-Google-Smtp-Source: APiQypK3nVIS0HXF6f5JYZB2ZkwijqJ0GDgwzsOtNZM82GdRPgCtgP+DH+jtzIW0C9XWoHD+mIq0XA==
X-Received: by 2002:a2e:9817:: with SMTP id a23mr13843030ljj.71.1587476744849;
        Tue, 21 Apr 2020 06:45:44 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o25sm2091211lfg.41.2020.04.21.06.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:45:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 21 Apr 2020 15:45:37 +0200
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200421134537.GA5952@pc636>
References: <20200420164657.GE17661@paulmck-ThinkPad-P72>
 <20200420165924.GA12078@pc636>
 <20200420172126.GG17661@paulmck-ThinkPad-P72>
 <20200420174019.GB12196@pc636>
 <20200420175915.GH17661@paulmck-ThinkPad-P72>
 <20200420190650.GA12775@pc636>
 <20200420201723.GA4192@pc636>
 <20200420212257.4332734f@oasis.local.home>
 <20200421051805.GA5124@pc636>
 <20200421093008.7a0d55ab@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421093008.7a0d55ab@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > <snip>
> > root@pc636:/sys/kernel/debug/tracing# cat set_ftrace_filter
> > measure_schedule_delayed_work.constprop.86
> > root@pc636:/sys/kernel/debug/tracing# cat tracing_thresh
> > 5
> > root@pc636:/sys/kernel/debug/tracing# cat current_tracer
> > function_graph
> > root@pc636:/sys/kernel/debug/tracing#
> > <snip>
> > 
> > Also i set 5 microseconds threshold to filter out what is less
> > and added the latency-format trace option.
> 
> Ah, I forgot that tracing_thresh affects function graph tracing.
> 
> The tracing infrastructure has so many features, I can't even keep up ;-)
> 
No problem :)

BTW, i decided to perform manual measurement of the schedule_delayed_work()
duration, just in case:

test PC: laptop with Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz

<snip>
static void noinline
measure_schedule_delayed_work(struct kfree_rcu_cpu *krcp)
{
       u64 delta;

       delta = sched_clock();
       schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
       delta = sched_clock() - delta;

       if (delta > 100)
               trace_printk("-> took %llu nanoseconds.\n", delta);
}
<snip>

I get the following figures of taken time:

MEDIAN: 831 nanoseconds
MAX: 4423 nanoseconds
MIN: 123 nanoseconds

The data you can find here: ftp://vps418301.ovh.net/incoming/measure_schedule_delayed_work.txt

--
Vlad Rezki

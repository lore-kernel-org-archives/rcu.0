Return-Path: <SRS0=Mmc0=5N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042B0C2D0E5
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 14:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1D5206E6
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 14:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kShGLTXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgC1OGk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:06:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40302 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1OGj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 28 Mar 2020 10:06:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id l25so14054098qki.7
        for <rcu@vger.kernel.org>; Sat, 28 Mar 2020 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZlMnYD6JqijSy564Fn87fpjw+Y3itMay1NF67PRDIo=;
        b=kShGLTXZ9/1ypJmti9uE2QCKI+tWlrSzVk6cgWkeYRd4haLeUZDrDHXvwSS7rQX4Ji
         wVTTtAGngCgnEhumeW2mdSnS/tR8Ne2FzLgCTzixXqkN+4ASa3WRGMtz79anz4CpCKt1
         ND7gKDEM+zwAcxtS1D0ASlVU0N9Tei5E1OWTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZlMnYD6JqijSy564Fn87fpjw+Y3itMay1NF67PRDIo=;
        b=KehkmZoo3+/sO2hFX//2IIGzP959+IUc85089xxEdtRptRnf9Djgi78lGc+3Z+J3ND
         wXaer/V8ByMlAHDRt+hr7Ig6eugGHV/2LA+x+XFzV7gmG5Bxi2K56l55mai9c9qKoYTZ
         YU2j1givqi3H7/jRj3JYp9Y465wonWJMQqWnU6GSkQ6lEJ5eiLuN40uhYHbYoPo01tnU
         dBFsCiTNeXDS/KCsIX9AcA4dofgWNSZf/9TZytTe9JND3O61FyzVpRMVN7TSjERaX7GX
         rKvsdSNwQGLo8nIFspzNDVbFmh+NWU3y8GwkUHgezbWN1fSQI84AZ7xEJ6jaUEndALuy
         lvOw==
X-Gm-Message-State: ANhLgQ078NjB0ojFjbuH7L/Ml1O1mfFkn+PD5imX3tddYE4agAQZertq
        69NqRUFPqpcE1E0gF6xGeg6VcA==
X-Google-Smtp-Source: ADFU+vvQLa1gK5s2WAC8iuBwK3tSpdtA4/uyjFRuaqfLuLFWmj6ncKwjq5JqYfByyZnjFVPq3a+4Fw==
X-Received: by 2002:a37:9ec8:: with SMTP id h191mr4063670qke.260.1585404396878;
        Sat, 28 Mar 2020 07:06:36 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w9sm5863186qkf.28.2020.03.28.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 07:06:35 -0700 (PDT)
Date:   Sat, 28 Mar 2020 10:06:35 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH RFC v2 tip/core/rcu 14/22] rcu-tasks: Add an RCU Tasks
 Trace to simplify protection of tracing hooks
Message-ID: <20200328140635.GA201808@google.com>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-14-paulmck@kernel.org>
 <20200319154239.6d67877d@gandalf.local.home>
 <20200320002813.GL3199@paulmck-ThinkPad-P72>
 <20200319204838.1f78152a@gandalf.local.home>
 <20200320024152.GM3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320024152.GM3199@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 19, 2020 at 07:41:53PM -0700, Paul E. McKenney wrote:
> On Thu, Mar 19, 2020 at 08:48:38PM -0400, Steven Rostedt wrote:
> > On Thu, 19 Mar 2020 17:28:13 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > Good point.  If interrupts are disabled, it will need to use some
> > > other mechanism.  One approach is irqwork.  Another is a timer.
> > > 
> > > Suggestions?
> > 
> > Ftrace and perf use irq_work, I would think that should work here too.
> 
> Sounds good, will give it a go!  And thank you for catching this!

Since the the Tasks-RCU holdout thread is supposed to wake up periodically to
scan holdout tasks anyway, can it not detect the end of the Trace-RCU grace
period on its next wake up? Sorry if I missed something.

thanks,

 - Joel


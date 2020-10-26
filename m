Return-Path: <SRS0=HAhG=EB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F447C2D0A3
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 05:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB6C22247
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 05:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qi6Sj4Li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769494AbgJZFqA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Oct 2020 01:46:00 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46130 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769421AbgJZFqA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Oct 2020 01:46:00 -0400
Received: by mail-il1-f195.google.com with SMTP id a20so7095860ilk.13
        for <rcu@vger.kernel.org>; Sun, 25 Oct 2020 22:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VPdTQ1PhfZhRRPXMROU07q6mswRw0Z2rrWcG2UvF3K4=;
        b=qi6Sj4Li60olorDiCltHElQhHrEOEUkilTwugUpbXAL5bEgaerax0LSJP052TT7FsZ
         ttIQoWdBRnRzpMMiDtZFobiVaj4CT+Wy3YZ9UKS1MYvSUC6dwhQIrXgDEzXUHulrUR6n
         YtZqsCxZfvkZsxvN29YRNKGrT5YF39ncILQ4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VPdTQ1PhfZhRRPXMROU07q6mswRw0Z2rrWcG2UvF3K4=;
        b=sbqtcqvREPgUjw3NOhfVaahZ9gPEcFGbRKlfCMfXnbt9yzGyHzabQMxuWLTbfnGAsr
         7zfaTtNFDL+GQtxhz+Gyb16/fHPMfNi8woqWAAPbEmaGKgod6UQOyRKyZItJOTz5v9ov
         nS8oWKb5AzphyWvH0l5oRXVl3XH3If8yM0frSfKO7T1AIa0BZbjWe5cqUTjTJ71U6nqg
         TrOhjsqEJ+cAttqpqYxuWsNQC9QxNsV+sq5HV6FQCF5EWGQvgp2SVnXirD0Se9GcfHME
         3M2HSplgFGKnBQ/a0vRK5VVOICNOZjvGl0OdooH3q4ruCLaR3mbvprFOhivgl09Z4sdO
         FV0g==
X-Gm-Message-State: AOAM5323iYbsvIKT7FZT0+Q9sAbnbiZOki6qDolUAkM5hQAmalwhpnxH
        SH6bpfD+yJ9XqX9hx8cf4e0zew==
X-Google-Smtp-Source: ABdhPJzxULDj+S29M5YgN9h83NkEIYBykH1HhRuUGajq9t05NEPOZUO8o7stxRu2lUnNE3b4Yz2tQQ==
X-Received: by 2002:a92:5b46:: with SMTP id p67mr7692480ilb.150.1603691158960;
        Sun, 25 Oct 2020 22:45:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id e4sm4835132ils.75.2020.10.25.22.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 22:45:58 -0700 (PDT)
Date:   Mon, 26 Oct 2020 01:45:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v8 2/6] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201026054557.GB4192074@google.com>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-3-joel@joelfernandes.org>
 <20201026005058.GB104441@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026005058.GB104441@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 26, 2020 at 01:50:58AM +0100, Frederic Weisbecker wrote:
> On Wed, Oct 21, 2020 at 03:08:09PM -0400, Joel Fernandes (Google) wrote:
> >  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
> >  {
> > -	int i;
> > +	int i, j;
> >  
> >  	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
> >  	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> > @@ -487,6 +508,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
> >  	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
> >  		return false;
> >  
> > +	/* Accounting: everything below i is about to get merged into i. */
> > +	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
> > +		rcu_segcblist_move_seglen(rsclp, j, i);
> > +
> 
> Can you perhaps reuse the below loop to move the seglen?

Not easily, because we will need to store 'i' into another variable then, which
does not change.

Besides IMHO, the code is more readable with the loops separated.

thanks,

 - Joel
 

> >  	/*
> >  	 * Merge all later callbacks, including newly arrived callbacks,
> >  	 * into the segment located by the for-loop above.  Assign "seq"

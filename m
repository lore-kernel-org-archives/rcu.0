Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8777C5517A
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D6520756
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 14:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="b9NT2N3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgKKOJL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Nov 2020 09:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgKKOIs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Nov 2020 09:08:48 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52D4C0613D1
        for <rcu@vger.kernel.org>; Wed, 11 Nov 2020 06:08:47 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id b16so1084177qtb.6
        for <rcu@vger.kernel.org>; Wed, 11 Nov 2020 06:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p193/gfZhwMwQQgjZComuF01Y8jmSrOLDTP+qjDesEs=;
        b=b9NT2N3qVXzD4LHnqG/NOLqlrjMlVJudXJxGsyOtW1KaDBfkAvBtIFnpwASXe8fNtb
         P7A1uxFU1IzfyywAd5V5igLUBwgaVIAy+oGqzf53b6AkevmEdUbhuumx8MAhW2SgRd7d
         kb9wx6SHh66wRrmw4TGBEuSeP1Bwq+CMbxzxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p193/gfZhwMwQQgjZComuF01Y8jmSrOLDTP+qjDesEs=;
        b=JaloPh6gJ46ZYytTW0wggfJ3AiTan7A4bZgyVQaqJT0fYb1rRvM05hrmLOjO8YBwpo
         +FXunayHtpu8TC3PHZ6ZYHqD8okj7tLUZI1PSEaiBlzrmTHfQZdvVqlyj9SOfQj2uy/D
         c+jVhij0jYZK3MWKi9Q9g68VdZbu222ZnSskg81GBlB+q3awMseZm++qfIprxIfdw2ea
         3/7D77R3XsTO7D2kbTSWSllAKPGga9uZu5LkZCpqPYwJwTDbIyvsZcXNIycAS4YscdAF
         hBkm4L3rzAy9Ms4ZOMA3y940gJc+1gJKdEH1pMqG/NLOHP/0xEr0CiRp8jhxp435IIMa
         HhnA==
X-Gm-Message-State: AOAM5308VrR5E153Ij7bW8JCRxK4YNkEkGDH8Gw7V5CUn2zi/mYSDA0N
        u+b3/5AKfzYZbWTdVorCeHOeIA==
X-Google-Smtp-Source: ABdhPJy8WbejFevwGNxbd0aEEK8HtJZWbsDfgMUBLW48WbcRASRhJC+Btox33xIq+74NeLIBymo9fw==
X-Received: by 2002:a05:622a:18f:: with SMTP id s15mr22503294qtw.160.1605103727046;
        Wed, 11 Nov 2020 06:08:47 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id h26sm2129456qkh.127.2020.11.11.06.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 06:08:46 -0800 (PST)
Date:   Wed, 11 Nov 2020 09:08:45 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        fweisbec@gmail.com, neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 4/7] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20201111140845.GA875516@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-5-joel@joelfernandes.org>
 <20201111003530.GA10251@paulmck-ThinkPad-P72>
 <20201111084941.1db1b324@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111084941.1db1b324@gandalf.local.home>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 11, 2020 at 08:49:41AM -0500, Steven Rostedt wrote:
> On Tue, 10 Nov 2020 16:35:30 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context)
> > > +{
> > > +	int cbs[RCU_CBLIST_NSEGS];
> > > +	unsigned long gps[RCU_CBLIST_NSEGS];
> > > +
> > > +	if (!trace_rcu_segcb_stats_enabled())
> > > +		return;  
> > 
> > Can't you rely on the trace system to enable and disable this trace
> > event?  If the thought is to save instructions, then moving all this
> > into TP_fast_assign() enables the trace system to deal with that as well.

Makes sense.

> > > +	rcu_segcblist_countseq(rsclp, cbs, gps);
> > > +
> > > +	trace_rcu_segcb_stats(context, cbs, gps);
> > > +}
> > > +#endif
> 
> Yeah, I agree with Paul. I think it is possible to move this all into the
> TP_fast_assign. If you have trouble doing so, let me know.

Sure. Last time I tried this for this patch, I ran into some issue. I will
try again and let you know if I need help.

thanks,

 - Joel

> 
> -- Steve

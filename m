Return-Path: <SRS0=nRMg=BI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A794AC433E0
	for <rcu@archiver.kernel.org>; Wed, 29 Jul 2020 12:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8431920829
	for <rcu@archiver.kernel.org>; Wed, 29 Jul 2020 12:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nE2NBVpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2MkB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2MkA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Jul 2020 08:40:00 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C38C061794
        for <rcu@vger.kernel.org>; Wed, 29 Jul 2020 05:39:59 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id a19so4738163qvy.3
        for <rcu@vger.kernel.org>; Wed, 29 Jul 2020 05:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=spmyQP3L/yNiXY42BwMCA8cPT1EWwAdeGPZrcULFkt4=;
        b=nE2NBVpNVJeONO7+Dlq5cIwm+uHzUci3Za0sSd+X3HYlADyCM+AUV/yTIyl5wQ8OO4
         X0sOmPVqaxoHwBd1gXMX5hpn8o3zBr96GPYkLA08eFL7rlVemiUKJ4xW+EbZMW+dDJEc
         pYB97TfCJn5I3ZlPgRyEJTGIk4rnO6W2hkgZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=spmyQP3L/yNiXY42BwMCA8cPT1EWwAdeGPZrcULFkt4=;
        b=FQyVSY9cJ/wxjtdtqi0wNQkfNKU5NQXk4U2nhJGyJ7vhLKmlZDS4SDyNSHQtbFa6yp
         U0EDJCmPdombhinnAkI0OaVxt3kMkwU9Sp715LhfozbJzl/kTMELPXHM8f0FLAW7xG6w
         innEIGPPiIW/ZqJh97g7eW0F4YpiNS75Ki2SBbprv5M9lGEpNZ2kJfZTAA5dXUCDlQpQ
         PzT3Fj64AgoGifsltY8SlxgJyvW3Olp4PRZtm84ocyFMoBVF7mdym7fDpImt24NiLtk1
         JwAjMzHDOfSf8GvDCEUVceS9gGpLvQyIzTc+v0aR68P25oi8MhYWEE77b6uvP4ppTXGK
         4k/A==
X-Gm-Message-State: AOAM532LKZekpx5u7PoTXauvKQpU/9xC+So3cYbDOHsnADoLT3f2m6DM
        lqeVeozKydr0/sapMAu1EoFM2A==
X-Google-Smtp-Source: ABdhPJyCCHXXwDumfa6ncclTkZxwczJdk2K85nLzunPVAs6lxIo0hcpkWdN/ELYIxGWAjHbT9QJX8w==
X-Received: by 2002:a0c:8224:: with SMTP id h33mr19165728qva.52.1596026398412;
        Wed, 29 Jul 2020 05:39:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d198sm1436718qke.129.2020.07.29.05.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 05:39:57 -0700 (PDT)
Date:   Wed, 29 Jul 2020 08:39:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH RFC] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200729123957.GC225345@google.com>
References: <20200719034210.2382053-1-joel@joelfernandes.org>
 <20200720142923.mrudcweyttlmnhqp@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720142923.mrudcweyttlmnhqp@linux-p48b>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 20, 2020 at 07:29:23AM -0700, Davidlohr Bueso wrote:
> On Sat, 18 Jul 2020, Joel Fernandes (Google) wrote:
> 
> > +/* Move from's segment length to to's segment. */
> > +static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
> > +{
> > +	long len = rcu_segcblist_get_seglen(rsclp, from);
> > +
> > +	if (!len || from == to)
> > +		return;
> 
> Nit: You probably wanna do the parameter sanity checks before the
> atomic_read.

Ok, I'll do that next revision. Thank you.

 - Joel


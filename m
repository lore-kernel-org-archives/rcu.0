Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC4C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57EA620752
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 14:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtaY+wOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgEDOZz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgEDOZy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 May 2020 10:25:54 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7700BC061A0E;
        Mon,  4 May 2020 07:25:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b26so117755lfa.5;
        Mon, 04 May 2020 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hhx3Y7SsgO+0pmQCmi95Yty7DE5Dn2yrj/e7yZMXjG0=;
        b=gtaY+wOls/Wn72DXE5zrDNRZapha54YHqFjI7tLPSTVE3KhJjRF9XPiL/Kif8hfE2b
         zw6O0NMqzNQslRstDGtK/vor9xwnlKEcS5gXZR5fMxNbXG/XcWKL7KHAFMr4CCROyJkv
         9aQopC0oR42Cm+ssDOYsF/HbYTIW0Ou0VONYSct3LJ1arO43L/LmjP7LMlmk4XGMEi4N
         +sBdvzuYpExABl2O/vYbyDeZKT1HEkfVm/zqkjI6w4wmozdhQVj2e+BdqlELb54VlSSA
         3fDJxPBDW29sk1fNkfeW+kbPFHOejCma3mmuau/PE2wF0UyCH6qbRhUksS2TtRpP9mOI
         cKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hhx3Y7SsgO+0pmQCmi95Yty7DE5Dn2yrj/e7yZMXjG0=;
        b=jYRdl2GSe0pShoqhElHgtUYDbXC4rMSvmADyJkDfsNh4G/iXhaZWgK8rTEhUgMuw1h
         +VeiD1y4slcvf20msGQoHmNCGOsilZX9/7BzbIb9XCRHwxf+ckv4uOw+9OFjrF707FBV
         B5xqE6hi8dmDiLjFrfcPtyxVYiwqdLvfTB8ba5dhE5uqtf8+8A3VOdJnxUkZywpngCpq
         gr95seXJbd5mh7feAcffbGdWWJZtpf3r0rWe08UIAtiyZjYLSOyvKzmdw8uRSkuPZmZr
         1Thki29fSt6j5JMcXStWPiVVyhMYG4/Wooj89AJ2t/SshkZ9hKFvqDs+dLf8R48MiVXt
         UPEA==
X-Gm-Message-State: AGi0PuaGb00hgD6cUoDeuiktlLShS13LLcdLMD85vEZvC/zkYyf+oDVz
        uQcuWeWANRsGa53YlLQthJw=
X-Google-Smtp-Source: APiQypJ4dL9JmnH70gQO29PoJf3xiH1hPxzW7b8U0rWIhC+A4/ca4FoDEcrtO/IXLdtwMMZISYRNxA==
X-Received: by 2002:a19:f00b:: with SMTP id p11mr4500062lfc.210.1588602352950;
        Mon, 04 May 2020 07:25:52 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id i20sm10279354lfe.15.2020.05.04.07.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:25:51 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 16:25:49 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 11/24] rcu/tree: Maintain separate array for vmalloc ptrs
Message-ID: <20200504142549.GH17577@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-12-urezki@gmail.com>
 <20200501213753.GE7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501213753.GE7560@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > @@ -3072,21 +3105,34 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> >  		krwp = &(krcp->krw_arr[i]);
> >  
> >  		/*
> > -		 * Try to detach bhead or head and attach it over any
> > +		 * Try to detach bkvhead or head and attach it over any
> >  		 * available corresponding free channel. It can be that
> >  		 * a previous RCU batch is in progress, it means that
> >  		 * immediately to queue another one is not possible so
> >  		 * return false to tell caller to retry.
> >  		 */
> > -		if ((krcp->bhead && !krwp->bhead_free) ||
> > +		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
> > +			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
> >  				(krcp->head && !krwp->head_free)) {
> > -			/* Channel 1. */
> > -			if (!krwp->bhead_free) {
> > -				krwp->bhead_free = krcp->bhead;
> > -				krcp->bhead = NULL;
> > +			/*
> > +			 * Channel 1 corresponds to SLAB ptrs.
> > +			 */
> > +			if (!krwp->bkvhead_free[0]) {
> > +				krwp->bkvhead_free[0] = krcp->bkvhead[0];
> > +				krcp->bkvhead[0] = NULL;
> >  			}
> >  
> > -			/* Channel 2. */
> > +			/*
> > +			 * Channel 2 corresponds to vmalloc ptrs.
> > +			 */
> > +			if (!krwp->bkvhead_free[1]) {
> > +				krwp->bkvhead_free[1] = krcp->bkvhead[1];
> > +				krcp->bkvhead[1] = NULL;
> > +			}
> 
> Why not a "for" loop here?  Duplicate code is most certainly not what
> we want, as it can cause all sorts of trouble down the road.
> 
Agree. Can be done. Thanks :)

--
Vlad Rezki



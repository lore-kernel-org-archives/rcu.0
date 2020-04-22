Return-Path: <SRS0=2A48=6G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA3BC55185
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 11:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850042077D
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 11:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwar++eK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgDVLpQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgDVLpP (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 22 Apr 2020 07:45:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66974C03C1A8;
        Wed, 22 Apr 2020 04:45:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so1894422lje.10;
        Wed, 22 Apr 2020 04:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJg8AbjlH1I4fIrHvIylqzy5rYC5XErFrt9tt5uOmOk=;
        b=lwar++eKXn7OMIQp5L2Bc1jMD711rhfBC629H9jcISA6sdQnkk+JWi+53cosyPrvn6
         npkbP2eo+xpXVl0ViF+QzEFdCz5f1S4Lkxq1HuvRrpYI2xf799w/6C3Z53TaUnHd4aOX
         uxO94GuGFAfqHycx/gcm3RClgLGlGQ6zKsFlAA7+c3nWgpp2qtawmIbLaenoKODO4l+Y
         PFMDDhzOv+sCPO1hHOS4EUJ6UOb7vL7KTD655ylqk//6zrOL46O6qJndXPWLt2V9BfaO
         j9n6dptn34aDT9P1Zc4QL3Q/CsP+NeUYGugFpPcx/UNd61xo/3r7xbo/mc8AThudE971
         Kckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJg8AbjlH1I4fIrHvIylqzy5rYC5XErFrt9tt5uOmOk=;
        b=haARF/kbnP6WBWC3WVdjrJTtczz+CKdPbJwS/GnJf/N1r7BwtLtq1KvDlpSAjaZJI1
         JMcZxZf3wBQ4wI4tCfXX9+rI6csvRFlQc1laFYciN82W+FknjwDVP/JmxE/tTCba1ZYp
         1LT10X3qQ7bIXFBIuzfQ/womvcYQxRcHjgJBC13SawMSF6PhGcG9kzxdic0TphIVZHLh
         axRLhamhtCmlwZ9RNtNFtpLzirC2oxA/tAHheaEByvzedUOcAIOrbt1FkGF8QYD/WzJd
         urh3fHjPHrhHWLPO7wym+07RuDslusVIqGM6zvV/3adgZWC4ek5cJ0RA5vVNYJdX7SB8
         7Azw==
X-Gm-Message-State: AGi0PuZyBJr68bOuE/oCQnFwVA96o7CgPe0nsVCme4+v/dbQYQ7hdQVI
        4OPwIFLeYyut7auCbXTHnbM=
X-Google-Smtp-Source: APiQypIVw3Rp00qV6+NXOadN+4qa01IwMXlqZJAAYgBk67ir1srjw5x4rxpJ9qrh49Ej1zKEuDUKvg==
X-Received: by 2002:a2e:140e:: with SMTP id u14mr15621002ljd.252.1587555913815;
        Wed, 22 Apr 2020 04:45:13 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id h14sm4499416lfm.60.2020.04.22.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 04:45:13 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 22 Apr 2020 13:45:06 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/dev -fixes 2/4] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200422114506.GA17108@pc636>
References: <20200420153837.194532-1-joel@joelfernandes.org>
 <20200420153837.194532-3-joel@joelfernandes.org>
 <20200422103536.GA16263@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422103536.GA16263@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 22, 2020 at 12:35:36PM +0200, Uladzislau Rezki wrote:
> On Mon, Apr 20, 2020 at 11:38:35AM -0400, Joel Fernandes (Google) wrote:
> > To keep kfree_rcu() path working on raw non-preemptible sections,
> > prevent the optional entry into the allocator as it uses sleeping locks.
> > In fact, even if the caller of kfree_rcu() is preemptible, this path
> > still is not, as krcp->lock is a raw spinlock as done in previous
> > patches. With additional page pre-allocation in the works, hitting this
> > return is going to be much less likely soon so just prevent it for now
> > so that PREEMPT_RT does not break. Note that page allocation here is an
> > optimization and skipping it still makes kfree_rcu() work.
> > 
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index cf68d3d9f5b81..cd61649e1b001 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3092,6 +3092,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> >  		if (!bnode) {
> >  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
> >  
> > +			/*
> > +			 * To keep this path working on raw non-preemptible
> > +			 * sections, prevent the optional entry into the
> > +			 * allocator as it uses sleeping locks. In fact, even
> > +			 * if the caller of kfree_rcu() is preemptible, this
> > +			 * path still is not, as krcp->lock is a raw spinlock.
> > +			 * With additional page pre-allocation in the works,
> > +			 * hitting this return is going to be much less likely.
> > +			 */
> > +			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +				return false;
> > +
> >  			bnode = (struct kfree_rcu_bulk_data *)
> >  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> >  		}
> This will not be correctly working by just reverting everything to the
> "rcu_head path" for CONFIG_PREEMPT_RT kernel. We need to preallocate at
> least once. I can add caching on top of this series to address it.
> 
Forgot to add: Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Caching should be added as separate patch.

--
Vlad Rezki

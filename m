Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE09FC47254
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C915420757
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcA9NxlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgEDMp0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEDMpZ (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:45:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDFFC061A0E;
        Mon,  4 May 2020 05:45:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so9472366ljg.8;
        Mon, 04 May 2020 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cObmNJWQhpMjg4TLyfHtW5v/IhhmWX2FOHpf6uHBZHo=;
        b=jcA9NxlZ6L0c9hBTeHkL+6ZWV3WMvNq5hmd5o3BKUGFT05J4wSfTVkPPtd7ZPMKrRb
         N1WKJ93oae9Huxf1IDfhSLAOl0onP+QuYfXmUjBTbCWGse19Rf6dklWp3v8QO+yyavv4
         u9edXDa+OdxM1SqSN0p7s1hlD2aWJSaRRhDBkU4HEsbVhbzioCoC+so3+2mBSnq3XY2m
         rDSsEMllnnMybQ0nUpGYpyhowW33Z2u/8MgCu6jo6edb12QXklFdjpkiaVit8/vvOvUB
         VkfkoBoG4ouFI9vbOsu+S6voPhEvjlbOoW9ixlYs5tDAipPT+1glfqBJz+g9jhUy5+h0
         0XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cObmNJWQhpMjg4TLyfHtW5v/IhhmWX2FOHpf6uHBZHo=;
        b=e8YpF0P1iVm7TeLVjr1YrhIQKS6XuEL7Eo4iEsFlN3NFktqJW/YPwF0XPIqtEUuvov
         PXy/wA6dKkQGPTGoRagY/olhBLnizc7qIZTqzg6EL1TdYZzI48QktgiT0gFXt4gfWCWl
         jIQ2SP8WLdcDqzkhUS2RC9rvlcIp99OYReuZRAbP+EVgBqHrmqvXlzhKoZGVQWtYiLVb
         MLhN0oqrErgImJhBCiFm/aPqGcRvtmlFCEQnkTb0GRAWrO6fSpWTvsgMSewsrLVNXGmP
         UwcxuZ8DlTzLcVzesYXqsCduGb186j8yO9H7JLKqZiA6LjjI6zVpkcZ3g1HMH0cVwx97
         p5PA==
X-Gm-Message-State: AGi0PuZmHsCbZ/QCOjrmed/nreScLfQLr2NB5jWp9U7GSVGdeCIw2HfH
        NjHL3nqPzHXroITbZgWhj1d0jk9CnEMPbQ==
X-Google-Smtp-Source: APiQypJXhT/ViTAl6h4ti7rqTDMwxGMrUxUDQkVVA6TeUrECI9C7Ng7Ry4jNrt/7FS9j+EVuatustw==
X-Received: by 2002:a05:651c:3c6:: with SMTP id f6mr10141274ljp.229.1588596323191;
        Mon, 04 May 2020 05:45:23 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l8sm8096189ljo.5.2020.05.04.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:45:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 14:45:20 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 21/24] rcu/tiny: move kvfree_call_rcu() out of header
Message-ID: <20200504124520.GC17577@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-22-urezki@gmail.com>
 <20200501230359.GH7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501230359.GH7560@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 01, 2020 at 04:03:59PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 28, 2020 at 10:59:00PM +0200, Uladzislau Rezki (Sony) wrote:
> > Move inlined kvfree_call_rcu() function out of the
> > header file. This step is a preparation for head-less
> > support.
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/linux/rcutiny.h | 6 +-----
> >  kernel/rcu/tiny.c       | 6 ++++++
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > index 0c6315c4a0fe..7eb66909ae1b 100644
> > --- a/include/linux/rcutiny.h
> > +++ b/include/linux/rcutiny.h
> > @@ -34,11 +34,7 @@ static inline void synchronize_rcu_expedited(void)
> >  	synchronize_rcu();
> >  }
> >  
> > -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > -{
> > -	call_rcu(head, func);
> > -}
> > -
> > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> >  void rcu_qs(void);
> >  
> >  static inline void rcu_softirq_qs(void)
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index aa897c3f2e92..508c82faa45c 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
> > @@ -177,6 +177,12 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  }
> >  EXPORT_SYMBOL_GPL(call_rcu);
> >  
> > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +	call_rcu(head, func);
> > +}
> > +EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> 
> This increases the size of Tiny RCU.  Plus in Tiny RCU, the overhead of
> synchronize_rcu() is exactly zero.  So why not make the single-argument
> kvfree_call_rcu() just unconditionally do synchronize_rcu() followed by
> kvfree() or whatever?  That should go just fine into the header file.
> 
I was thinking about it. That makes sense. Let me rework it then :)

--
Vlad Rezki

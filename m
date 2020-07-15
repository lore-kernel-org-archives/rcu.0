Return-Path: <SRS0=HY8l=A2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF685C433E2
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C63B20657
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 19:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvbGB7NA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGOThD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGOThC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jul 2020 15:37:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC89C061755;
        Wed, 15 Jul 2020 12:37:02 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y13so1719795lfe.9;
        Wed, 15 Jul 2020 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/UQQ7JECYxcJsC+04YvXu3jkXwx9o0ZU8amBSOGyyL0=;
        b=gvbGB7NAoQRARPoqxv9Cw9rm5EurTvOipDiLnb6iNSZzYaZbtuhDGwQLbpauTXguAd
         C+jHRBFUdxhSCfFghxodI4ckz6RBDCAXk1Tj7sBTds8+txIG5PEdKfgwfCWcjaQPWLWp
         g+erEo9033BpAGp2/xEB13F7l4nR9Uz3oUPR+HmUGwy6R1orIJi1m0bih0U/72ra69d+
         F/zQBPKiaYzooX+8utpp7jGrm2VVP+1dUhmFTjnxvnHIDTg4hBN17XVgYzLnTTjWcADC
         1gJGD+gyf51zCD13dM4kh46RTD1LuzJX4xh2bl33eWsWZdj5dX3L2OZVSenIoab3p048
         u03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/UQQ7JECYxcJsC+04YvXu3jkXwx9o0ZU8amBSOGyyL0=;
        b=JQ+ai5l1/r341wc9FHjkz6MfhWly3Vp7GplpvY6ZvAkaMIP2cEEOy1LEdt395B5WJ6
         tTiH67ByGlZfNXN3AkjPNiefs7gRhk7s6X6g3/xYHwglbi3QK0aTXoGWq3zMCrXm4Ibn
         8SGKXXJ1DiEPB00OGzqebV7pI6FgBu0IvWqwOAjVdH+L+GFItMCFNEol2NCp7yM4sZN8
         F0Fwnfg82m371sWN1Q4pDOGfrfZ2qXhBA6iTpI5p8wdJG4Q8zjt8RY0X8/B73BK+WSR4
         08u8HoX9E1/xrtCasbnaaKJpGFK+6Y/2d6lD5Ta7xQiZpyJViEanGd9bRMLr5ZOOSaOL
         aXiw==
X-Gm-Message-State: AOAM532B1DaXw0qSi9+7TRW6RWc7eX+SbzHNTD30SU9w5I+IQVR4xH+U
        oq8lV4VwQ3IYINP/KIbSxZ4=
X-Google-Smtp-Source: ABdhPJyTaONhk5LPv5gQR0R6gh7bhdAZIqNcCJDNHomyLJvqxfKFsunEhujBeuBm7wTLGiCaT+nO1A==
X-Received: by 2002:a19:4a96:: with SMTP id x144mr269142lfa.213.1594841820710;
        Wed, 15 Jul 2020 12:37:00 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id k3sm608184lji.125.2020.07.15.12.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 12:36:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 15 Jul 2020 21:36:57 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200715193657.GB26938@pc636>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <20200715190243.GA26735@pc636>
 <20200715193250.axntj7jdt6bw52dr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715193250.axntj7jdt6bw52dr@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 15, 2020 at 09:32:50PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-15 21:02:43 [+0200], Uladzislau Rezki wrote:
> > 
> > <snip>
> >     spin_lock();
> >     __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> >     spin_unlock();
> > <snip>
> > 
> > Also, please note we do it for regular kernel.
> 
> ach right okay then.
> 
> > >
> > > What happened to the part where I asked for a spinlock_t?
> > > 
> > What do you mean?
> 
> Please drop that raw_spinlock_t for the kfree_rcu() based locking and
> use just a plain spinlock_t for the locking. Then you can keep the same
> code flow for RT and !RT without any special cases and everything.
> 
Ahhh... That i see :)

I guess it is up to Paul. I wrote my thoughts. I have only one concern
that i explained in my previous mails.

Thank you, Sebastian, for your comments!

--
Vlad Rezki

Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC5BC1B0D9
	for <rcu@archiver.kernel.org>; Fri, 11 Dec 2020 07:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D84A23F2A
	for <rcu@archiver.kernel.org>; Fri, 11 Dec 2020 07:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436667AbgLKHAC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 11 Dec 2020 02:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbgLKG7k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 11 Dec 2020 01:59:40 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E599CC0613D6;
        Thu, 10 Dec 2020 22:58:59 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id j13so1859516pjz.3;
        Thu, 10 Dec 2020 22:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X2z1OwRPORTsgcZvnqGISSv4h6wK7dEp/2HbkPrGQG0=;
        b=ub+CvGZTile3AyOOyE/qzEUxhUZWtjRs+LLeA2VZhA4w/Rn/PAcjz9IDOYT55syfl3
         usVrbmBEfW6u94edAXP20+RZP5PWOfiOgEqK6M49GPeweKXDTQkrrpCjsUkbunIVcbeG
         ZrCoAoRtj5acqA1UV6ejwjkRjuebWtNC0b3OMB28KErKFrKzWByq4UhG/okN3Cf5oGHX
         b3lheVupOBQbRiZfYbYxd02hc4jlcCMsDGAYF1q6tdEJzR8h3rx9H/8FyttB4gSRrBaI
         J2sa6ekpqSG12IQ8hsCidfoSsVHW9JTcI9fXxoCMgqzbj511TsvjEyKd2IIxTJrcilaI
         Z95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X2z1OwRPORTsgcZvnqGISSv4h6wK7dEp/2HbkPrGQG0=;
        b=s8nR4Ttk8pSviWB24i3NcKEsq+mLhe6MdxQzGObdEjupEd34rR14K857Z1kK1l5S4x
         ZCtfURACRdGgCocebBVcLkDNYj/8a3ZqCee7v6YY6sS+Hz6ZOhP7f8Pt5KpPfJw7RnKZ
         7CK2oQgxCAU0hCSCV8G5J19OpHnvKRiRf/gk5waZJd8H/1duwPPGHTl2pOgQmngbCZwX
         AUfzfIX6t71yF4pnVVKX+XI+hnQ71mOxvwNEjDkJBjpz/u8+OrVa6ZwlIa9gfQ8QwJTS
         U5N/DiUahPWgCGeyTiiCnCWrhc0L3GsAjIMZ0yssP0Z9Ng4/86dvqOxPxvnivMbdndI8
         Eknw==
X-Gm-Message-State: AOAM530yXO/C0KvbFgGyv1e0X5YQsZKQ8QFYPUDPeQX/BubSXODkc27f
        uW8PsKqtNdNcY3Z/Kh2Lfbnl8eVktIlugw==
X-Google-Smtp-Source: ABdhPJyOg822jqzFkAiCwQ5VVT1rRAxBZ7c5+euPYPmSSpNcaP3LSZhtJuHR43OcbBWbxrqaUG6QaQ==
X-Received: by 2002:a17:90a:1bc7:: with SMTP id r7mr12152120pjr.33.1607669939492;
        Thu, 10 Dec 2020 22:58:59 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id mz1sm8922830pjb.33.2020.12.10.22.58.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 22:58:59 -0800 (PST)
Date:   Fri, 11 Dec 2020 15:58:51 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        andrii@kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH v3 sl-b 1/6] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <20201211065850.GB587@js1304-desktop>
References: <20201211011907.GA16110@paulmck-ThinkPad-P72>
 <20201211012003.16473-1-paulmck@kernel.org>
 <20201211022205.GA11631@js1304-desktop>
 <20201211033359.GD2657@paulmck-ThinkPad-P72>
 <20201211034226.GA2116@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211034226.GA2116@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 10, 2020 at 07:42:27PM -0800, Paul E. McKenney wrote:
> On Thu, Dec 10, 2020 at 07:33:59PM -0800, Paul E. McKenney wrote:
> > On Fri, Dec 11, 2020 at 11:22:10AM +0900, Joonsoo Kim wrote:
> > > On Thu, Dec 10, 2020 at 05:19:58PM -0800, paulmck@kernel.org wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> [ . . . ]
> 
> > > We can get some infos even if CONFIG_SLUB_DEBUG isn't defined.
> > > Please move them out.
> > 
> > I guess since I worry about CONFIG_MMU=n it only makes sense to also
> > worry about CONFIG_SLUB_DEBUG=n.  Fix update.
> 
> Like this?  (Patch on top of the series, to be folded into the first one.)

Yes!

Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks.

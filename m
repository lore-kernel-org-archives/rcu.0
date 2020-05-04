Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10730C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC082071C
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5hrseaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgEDMqC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727950AbgEDMqC (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:46:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773CC061A0E;
        Mon,  4 May 2020 05:46:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w20so9544537ljj.0;
        Mon, 04 May 2020 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MxtvJADHQyF2Bfyd3shzrzOV9msYv3TiT6BAQiW+KhI=;
        b=f5hrseaHOwjQMXJt8bBACt6DaEIHexL3hv/OOA/rVyWM1tWtk+sIH+NdF5cNVNVhN5
         qKA3GFB/imTK1sicAOYYj5xW2DmIA1vbJtN3nk43C2BxXlCOZGvEx5+HaoDiOr0gEe8P
         b9lbbtykY/8gFZ6dtFAMjZILSNyQvimUYRYp/7Hoj4yjX7fjaJVEZZZkmghiiaVuqkxJ
         Izl12k3Dleo6+leSUvmD8e66qM+dCmn9I9WhvGAhO02Ng8NufCBXJ1FPhKWQKrWb0gER
         m293HKARydc4lfUPPSyYtWXgHLYleszKk75AXRlG6i2h/n+v1SbECwX4b1SjTDdKXb/s
         QFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MxtvJADHQyF2Bfyd3shzrzOV9msYv3TiT6BAQiW+KhI=;
        b=A1eWNLWpdckPYK5/KZrtmCgO3IzRlea3sLVCe+DcKl4JyRIPpFarTNPu6PWAd1gz1q
         hoJNQSVaMH1gP4mE9+u8JN/DuWn7vpm1jeEDWYbx8mE9o8bTdPl4lnyCetf0DfORNFwL
         6yAwvZp/p18f1XpC3YM+2bPMNi1ZqifyaqMkNcaM0HaXMvReYNE0pyqfoxE7uAZ79His
         VLuPph7EJqZGiihAi9Ml4kuJZA1eV6scvp3uQiWQ7Fj2Vgl5Kg04hKJ8rxyneGfDOgu6
         A3holIqiIU+9lv9omOWX4p+yTfE1TyR0UMIe3bfxl/FuupgSexrFcyGa9vxaHzz/08Po
         j3Tg==
X-Gm-Message-State: AGi0PuYUldTYuzvmQ6poLR6PM2r++iMEi3UXHVFNl+KKqXvxVQZCNG7M
        GFBMKuIoaZUYBGx6naYphgk=
X-Google-Smtp-Source: APiQypJTSD+9jSx9npyWswKL3jKL6Fr3OUB38jOmcbJ2+udY4w2QdHHBJWxIzAa5v4c/b0ZTMcE0BA==
X-Received: by 2002:a2e:9048:: with SMTP id n8mr10552753ljg.122.1588596360414;
        Mon, 04 May 2020 05:46:00 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s8sm9570030lfd.61.2020.05.04.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:45:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 14:45:57 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 22/24] rcu/tiny: support reclaim for head-less object
Message-ID: <20200504124557.GD17577@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-23-urezki@gmail.com>
 <20200501230638.GI7560@paulmck-ThinkPad-P72>
 <20200504002700.GB212435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504002700.GB212435@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 03, 2020 at 08:27:00PM -0400, Joel Fernandes wrote:
> On Fri, May 01, 2020 at 04:06:38PM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 28, 2020 at 10:59:01PM +0200, Uladzislau Rezki (Sony) wrote:
> > > Make a kvfree_call_rcu() function to support head-less
> > > freeing. Same as for tree-RCU, for such purpose we store
> > > pointers in array. SLAB and vmalloc ptrs. are mixed and
> > > coexist together.
> > > 
> > > Under high memory pressure it can be that maintaining of
> > > arrays becomes impossible. Objects with an rcu_head are
> > > released via call_rcu(). When it comes to the head-less
> > > variant, the kvfree() call is directly inlined, i.e. we
> > > do the same as for tree-RCU:
> > >     a) wait until a grace period has elapsed;
> > >     b) direct inlining of the kvfree() call.
> > > 
> > > Thus the current context has to follow might_sleep()
> > > annotation. Also please note that for tiny-RCU any
> > > call of synchronize_rcu() is actually a quiescent
> > > state, therefore (a) does nothing.
> > 
> > Please, please, please just do synchronize_rcu() followed by kvfree()
> > for single-argument kfree_rcu() and friends in Tiny RCU.
> > 
> > Way simpler and probably way faster as well.  And given that Tiny RCU
> > runs only on uniprocessor systems, the complexity probably is buying
> > you very little, if anything.
> 
> Agreed.
> 
Cool. Agree also :)

--
Vlad Rezki

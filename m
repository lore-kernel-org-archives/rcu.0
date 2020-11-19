Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597BBC64E69
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 20:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD3F2158C
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 20:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="E4ATwBW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKSUmY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgKSUmY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 15:42:24 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36167C0613D4
        for <rcu@vger.kernel.org>; Thu, 19 Nov 2020 12:42:23 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id j31so5443580qtb.8
        for <rcu@vger.kernel.org>; Thu, 19 Nov 2020 12:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1fI8LYeeHZvB8l+dO4G9/ig9mUXz+DcREqe0Rtm8+fY=;
        b=E4ATwBW6XoGEG9+dr7/A7CaJtFRdYaYbmgp09Unbw2L9KqL1IZp2k8tvA/lYUi6Puv
         mtPiZGLb7ns9NAnW9NBPpyQzKEREOk0nP9PK5JKKWXcd0ef+/vW0pSLIKDsOWse2T7rO
         LlYBp9EspYBFxI7Yoi8guGDWUZ/JOBV59ocCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fI8LYeeHZvB8l+dO4G9/ig9mUXz+DcREqe0Rtm8+fY=;
        b=mxNXn73AfPD1jF0fmG+3/IuenbqnzAkENaOJqaMYyJeTKlZdls1hcUU62QF/oTNFfE
         m7YQCDf/pYqYBKNTcELoXgWqYDvLBORNee8y6Z2syVEq/SHD1sZiJJuCzr6sC1y/yZZR
         ZMb7poJcRD6YiRYvO4sOW2/teKl6akF86nf1DPIK6Tzt0F3Qc7Im537kFIxLNYEscoX7
         wN9HNIUMeLm0CbSKTFSlWrATFzTRmF0tVre42FeCwn1lOLOgqqgLMB4/dh7Q4apQA53j
         zi5e9TDiCh13FTVu91oSXpgyVIUR7eOiVkhXQMYovW5Iq7qZS5k9T2eM/mp2dAVhYbBA
         Op+g==
X-Gm-Message-State: AOAM530lTmMtC/ovYTmglU1Px/z5eVeaww7PD/IWcu6h0Bs7yv6bYDtG
        QyzEmUzbUrgl+4QpFeyEa+K1LQ==
X-Google-Smtp-Source: ABdhPJzWgmjO+QClMsuLdFixbO7L/u20fXJ1rGmfCaQgXGBeBUv4M9KsoizPNTxbbeg6ImpMU0GNzg==
X-Received: by 2002:a05:622a:4e:: with SMTP id y14mr12990868qtw.392.1605818542369;
        Thu, 19 Nov 2020 12:42:22 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t126sm644992qkh.133.2020.11.19.12.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 12:42:21 -0800 (PST)
Date:   Thu, 19 Nov 2020 15:42:21 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu/segcblist: Add debug checks for segment lengths
Message-ID: <20201119204221.GB812262@google.com>
References: <20201118161541.3844924-1-joel@joelfernandes.org>
 <20201118201335.GR1437@paulmck-ThinkPad-P72>
 <20201119035222.GA18458@paulmck-ThinkPad-P72>
 <20201119035613.GA18816@paulmck-ThinkPad-P72>
 <20201119183252.GA812262@google.com>
 <20201119192241.GZ1437@paulmck-ThinkPad-P72>
 <CAEXW_YSRQ+r_CjFOOEZ38BBRpkhjs5UbpfhGCzA8=XywEU0u8Q@mail.gmail.com>
 <20201119201615.GA1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119201615.GA1437@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 19, 2020 at 12:16:15PM -0800, Paul E. McKenney wrote:
> On Thu, Nov 19, 2020 at 02:44:35PM -0500, Joel Fernandes wrote:
> > On Thu, Nov 19, 2020 at 2:22 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > On Wed, Nov 18, 2020 at 11:15:41AM -0500, Joel Fernandes (Google) wrote:
> > > > > > > > After rcu_do_batch(), add a check for whether the seglen counts went to
> > > > > > > > zero if the list was indeed empty.
> > > > > > > >
> > > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > >
> > > > > > > Queued for testing and further review, thank you!
> > > > > >
> > > > > > FYI, the second of the two checks triggered in all four one-hour runs of
> > > > > > TREE01, all four one-hour runs of TREE04, and one of the four one-hour
> > > > > > runs of TREE07.  This one:
> > > > > >
> > > > > > WARN_ON_ONCE(count != 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> > > > > >
> > > > > > That is, there are callbacks in the list, but the sum of the segment
> > > > > > counts is nevertheless zero.  The ->nocb_lock is held.
> > > > > >
> > > > > > Thoughts?
> > > > >
> > > > > FWIW, TREE01 reproduces it very quickly compared to the other two
> > > > > scenarios, on all four run, within five minutes.
> > > >
> > > > So far for TREE01, I traced it down to an rcu_barrier happening so it could
> > > > be related to some interaction with rcu_barrier() (Just a guess).
> > >
> > > Well, rcu_barrier() and srcu_barrier() are the only users of
> > > rcu_segcblist_entrain(), if that helps.  Your modification to that
> > > function looks plausible to me, but the system's opinion always overrules
> > > mine.  ;-)
> > 
> > Right. Does anything the bypass code standout? That happens during
> > rcu_barrier() as well, and it messes with the lengths.
> 
> In theory, rcu_barrier_func() flushes the bypass before doing the
> entrain, and does the rcu_segcblist_entrain() afterwards.
> 
> Ah, and that is the issue.  If ->cblist is empty and ->nocb_bypass
> is not, then ->cblist length will be nonzero, and none of the
> segments will be nonzero.
> 
> So you need something like this for that second WARN, correct?
> 
> 	WARN_ON_ONCE(!rcu_segcblist_empty(&rdp->cblist) &&
> 		     rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> 
> This is off the cuff, so should be taken with a grain of salt.  And
> there might well be other similar issues.

Ah, makes sense. Or maybe should be made like the other warning?
        WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) && count != 0
		&& rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);

Though your warning is better.

I will try these out and see if it goes away. I am afraid though that there
is an issue with !NOCB code since you had other configs that were failing
similarly.. :-\.

thanks, :-)

 - Joel


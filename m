Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64B2C63798
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788E4221FB
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NSZmoJN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgKCPHo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgKCPHk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 10:07:40 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E0C0613D1
        for <rcu@vger.kernel.org>; Tue,  3 Nov 2020 07:07:40 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id q1so5762746qvn.5
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2020 07:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4n4eKbeBF029LZEVM8Tx6GsjHib9jcrVPlcNT/Y/Yx0=;
        b=NSZmoJN8BVndRdwEMQQd1+hTP/RRmifn9wf265YZzYwbSlBwPLhY/7F+PPW8+Y/68Z
         WhaRUJ9ki+KpWXZMu3+oEIcJ3fB2Gebdj/gTiMHYKlV8qP+I6Q7s1tqR8f9p+oMu9ftV
         5LSvV7PyTDq2NTyClPrKeEVZGckDJ2mmhvauo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4n4eKbeBF029LZEVM8Tx6GsjHib9jcrVPlcNT/Y/Yx0=;
        b=KGtYcRZlhyHfbR3BGlsCI3t0GjwNwrfUXemCql8AZIkSUZrkOdjZIVvGutkqiTGcHe
         ezoUpR0xoAm3qvCeQCaQhqLQ5+9og78TpAe9nelSyxx1KHvNML0q4IoYxgQjY/9F9kyc
         zYpYXI/UpNuOJ0kJoKAAD+T2v8TwHqP+BqlcTGxBQ+FxzmUBGjm3g06pWFJV6zUGaYoz
         5L6HMXWMA4KHikKZraWsrdokBnNRAPdWPc1ngiqk80y77Gup+p4gIpb37XmSlv+NAESH
         siRucXGLA9Z8t4aHwt3HBGrQ0l0I0A94fTPMPwSE5rPrMqLH8JQkNZgpH6i1bDGY46qs
         1uaQ==
X-Gm-Message-State: AOAM531p/i7/Uil3qgr1FtvGiq5msuhOP+H9pQ5ifODE0gMTEedZAXub
        +6wGVzcaclasZyc3/FPg3QuRvQ==
X-Google-Smtp-Source: ABdhPJzzlcDLLdFjM34pMHGZgTdfKu/8EkQtfR2uV18EK3dvw/pyiibGX7BzyhFs4My2qNIiqkFtUA==
X-Received: by 2002:ad4:4985:: with SMTP id t5mr25591422qvx.27.1604416059573;
        Tue, 03 Nov 2020 07:07:39 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c6sm4857206qke.35.2020.11.03.07.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:07:38 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:07:38 -0500
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
Subject: Re: [PATCH v9 3/7] srcu: Fix invoke_rcu_callbacks() segcb length
 adjustment
Message-ID: <20201103150738.GB1304393@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-4-joel@joelfernandes.org>
 <20201103144714.GA432431@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103144714.GA432431@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 03:47:14PM +0100, Frederic Weisbecker wrote:
> On Tue, Nov 03, 2020 at 09:25:59AM -0500, Joel Fernandes (Google) wrote:
> > With earlier patches, the negative counting of the unsegmented list
> > cannot be used to adjust the segmented one. To fix this, sample the
> > unsegmented length in advance, and use it after CB execution to adjust
> > the segmented list's length.
> > 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> This breaks bisection, you need to either fix up the previous patch
> by adding this diff inside or better yet: expand what you did
> in "rcu/tree: Make rcu_do_batch count how many callbacks were executed"
> to also handle srcu before introducing the segcb count.

Since doing the latter is a lot more tedious and I want to get reviewing
other's RCU patches today :) , I just squashed the suggestion into the
counters patch to fix bissection:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/segcb-counts&id=595e3a65eeef109cb8fcbfcc114fd3ea2064b873

Hope that's Ok. Also, so that I don't have to resend everything, here is the
final branch if Paul wants to take it:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch rcu/segcb-counts)

Thank you for your time, Frederick!

 - Joel






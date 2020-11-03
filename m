Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D3C388F9
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E929320735
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604416851;
	bh=MAxC15ZBCRgqAWQmINA1Xb3bGR5aaGk0zcw3qLyvCyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2OZtA7+n8ocr38SAeIrvcWTvP6yaajKS9XH+/8Vgt6f+xfU/kj+R1/lvb/wutokGT
	 6faLhJqn4VJOFhcLS2dK+rbp5dvG3fsusWmm37FqNyvMir5+oosk9WoGun5ih+vvIK
	 B9/OPAtkIvqKTM4xGBmdN+v8TN/aNUAn+TE1wIFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgKCPUi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbgKCPTW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 10:19:22 -0500
Received: from localhost (unknown [176.167.46.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9796020735;
        Tue,  3 Nov 2020 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416762;
        bh=MAxC15ZBCRgqAWQmINA1Xb3bGR5aaGk0zcw3qLyvCyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOLsS+7fAQkJSXmbS7ZLD8H8h8Er4z2R/TxhVwnkLZI8Iy59MwEPDHTQC8CLjIMP/
         leUnnKZa5EZDQM+TPYIJ+eBjSt3fppaEvWAQYnJp7kysjwkFG6ulsbBhcEU5dHL+5A
         VW5E1kir+ssKEdfNAMpaSjfQBGw0DP73EGWMv80k=
Date:   Tue, 3 Nov 2020 16:19:19 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20201103151919.GC432431@lothringen>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-4-joel@joelfernandes.org>
 <20201103144714.GA432431@lothringen>
 <20201103150738.GB1304393@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103150738.GB1304393@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 10:07:38AM -0500, Joel Fernandes wrote:
> On Tue, Nov 03, 2020 at 03:47:14PM +0100, Frederic Weisbecker wrote:
> > On Tue, Nov 03, 2020 at 09:25:59AM -0500, Joel Fernandes (Google) wrote:
> > > With earlier patches, the negative counting of the unsegmented list
> > > cannot be used to adjust the segmented one. To fix this, sample the
> > > unsegmented length in advance, and use it after CB execution to adjust
> > > the segmented list's length.
> > > 
> > > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > This breaks bisection, you need to either fix up the previous patch
> > by adding this diff inside or better yet: expand what you did
> > in "rcu/tree: Make rcu_do_batch count how many callbacks were executed"
> > to also handle srcu before introducing the segcb count.
> 
> Since doing the latter is a lot more tedious and I want to get reviewing
> other's RCU patches today :) , I just squashed the suggestion into the
> counters patch to fix bissection:
> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/segcb-counts&id=595e3a65eeef109cb8fcbfcc114fd3ea2064b873
> 
> Hope that's Ok.

Works for me.

Thanks!

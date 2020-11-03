Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2170BC388F7
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C688C20757
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604416687;
	bh=4+NbJFTPXLn00+roYDaxMSNvwFacHhij1ifzJGHsc3o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=S4yJXLl1MudxppfNYWGIOCO7WlRr4XNaWIDYX28Cf6QyhZ4MQdcOaCfpjg2oDIeMG
	 fRSrqPOnhlCiPT1kwzYSEzzv85gYtZJVLLrfyA/tu5uSxCGMvS9fh+jqFapgaIl96W
	 ZqtMp3WW0Gmnf7+2Ap5gwnd1zae7r/O6NkgkhB4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgKCPSH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:18:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgKCPSE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 10:18:04 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6984B20735;
        Tue,  3 Nov 2020 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416683;
        bh=4+NbJFTPXLn00+roYDaxMSNvwFacHhij1ifzJGHsc3o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SQ72rCSPvOXUAG5ariXK8uIOIBT+2ArBQUJXOx+T9HnU3aJHkcCPCCVR60Uv+gVNI
         7sQX5qrLt0zytvelBdTL1DtrCqGI45CqXSe5IIff6JaboF3MNqOZZ6QphGkR5WYEZ/
         ZF1zv9QVPZGKIIgAU4v3fLWiB38KBZpMAj1VEb98=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1A3D835225E2; Tue,  3 Nov 2020 07:18:03 -0800 (PST)
Date:   Tue, 3 Nov 2020 07:18:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 3/7] srcu: Fix invoke_rcu_callbacks() segcb length
 adjustment
Message-ID: <20201103151803.GB3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-4-joel@joelfernandes.org>
 <20201103144714.GA432431@lothringen>
 <20201103150738.GB1304393@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103150738.GB1304393@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
> Hope that's Ok. Also, so that I don't have to resend everything, here is the
> final branch if Paul wants to take it:
> git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch rcu/segcb-counts)

Either way, it sounds like it is time for me to review this series.

Thank you both very much!!!

							Thaxn, Paul

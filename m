Return-Path: <SRS0=zZsG=CY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D9EC43461
	for <rcu@archiver.kernel.org>; Tue, 15 Sep 2020 00:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172AE208DB
	for <rcu@archiver.kernel.org>; Tue, 15 Sep 2020 00:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600129836;
	bh=HVBTbKnwBEpFXclm8qQqDqlib/rfo66Alp+9WBUODkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=F6AgIfTX6tGyKWj4hYb50sEZJIMDKqfLGZNFFtLTMLBjsjY9BYj34rse4kYnnpejt
	 izC6RBKIneQgN5htR+UMbAgEATaxD0KkXRywKrul66bdgvd/Ss4izCjEDXTV67Oe7Z
	 QVJraEc+HquV29oA1Y2BScsRKeXerfba6MsNySsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgIOAaf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Sep 2020 20:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:32846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgIOAac (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Sep 2020 20:30:32 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85964208DB;
        Tue, 15 Sep 2020 00:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600129832;
        bh=HVBTbKnwBEpFXclm8qQqDqlib/rfo66Alp+9WBUODkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wm8mNngC4wY7l4bTcpzPb0zIAlOSfAJl8UKtlts8lQ6e3TxsUaQWj4UF4SOD4RK+T
         8EG5qzAmhWey7Aw3auOzCNM37dWgBfaCWskFMpTN5sgrOJ76HSJYSrnFCQN1R9UJt+
         c+NFjrT2bGsmSx0asA1K/WXWZ7dK09nPhYa/CI9U=
Date:   Mon, 14 Sep 2020 17:30:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        nikolay@cumulusnetworks.com, davem@davemloft.net,
        netdev@vger.kernel.org, josh@joshtriplett.org,
        peterz@infradead.org, christian.brauner@ubuntu.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, roopa@nvidia.com
Subject: Re: [PATCH net-next] rcu: prevent RCU_LOCKDEP_WARN() from
 swallowing the condition
Message-ID: <20200914173029.60bdfc02@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200915002011.GJ29330@paulmck-ThinkPad-P72>
References: <20200908090049.7e528e7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200908173624.160024-1-kuba@kernel.org>
        <5ABC15D5-3709-4CA4-A747-6A7812BB12DD@cumulusnetworks.com>
        <20200908172751.4da35d60@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200914202122.GC2579423@google.com>
        <20200914154738.3f4b980a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200915002011.GJ29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 14 Sep 2020 17:20:11 -0700 Paul E. McKenney wrote:
> > Seems like quite a few places depend on the macro disappearing its
> > argument. I was concerned that it's going to be had to pick out whether
> > !LOCKDEP builds should return true or false from LOCKDEP helpers, but
> > perhaps relying on the linker errors even more is not such poor taste?
> > 
> > Does the patch below look acceptable to you?  
> 
> The thing to check would be whether all compilers do sufficient
> dead-code elimination (it used to be that they did not).  One way to
> get a quick sniff test of this would be to make sure that a dead-code
> lockdep_is_held() is in common code, and then expose this patch to kbuild
> test robot.

I'm pretty sure it's in common code because kbuild bot complaints were
the reason I gave up the first time around ;) 

I'll expose this to kbuild bot via my kernel.org tree in case it
doesn't consider scissored patches and report back!

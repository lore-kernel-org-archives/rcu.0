Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C49C2D0E4
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 01:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D8724101
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 01:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGr2omu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgKUBLd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:11:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKUBLd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 20:11:33 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D6124101;
        Sat, 21 Nov 2020 01:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605921092;
        bh=WrKqO4Isxk29a1EjwyODaxkNz5BVDhwd51HjPAGDdMk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aGr2omu4KB6mwymqJAm9IXvkoK1NMy01XoJ8PJA6ZPEO4ZQBS3TeHu8xyUKi/Wb02
         4r8OENIXSo3Dku52CoReO2rx0+reGGRhpdgn+bn8igu8pNLYC+f4pkCEC1eyZMzKfL
         t6C5cbO3PE4Le2b8a4JqDdRDgQcCVZHwUmPbJs5g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2A2583522A6E; Fri, 20 Nov 2020 17:11:32 -0800 (PST)
Date:   Fri, 20 Nov 2020 17:11:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang,Qiang" <qiang.zhang@windriver.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: SRCU: Question on srcu_advance_state
Message-ID: <20201121011132.GR1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <7fc7b6b9-bcf2-fa78-1931-415d04a5ac1a@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fc7b6b9-bcf2-fa78-1931-415d04a5ac1a@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 04:30:15PM +0800, Zhang,Qiang wrote:
> Hello Pual
> 
> sorry to disturb you, I also have some quesetion for you:
> 
> in srcu_advance_state function, when seq state == SRCU_STATE_SCAN1, we will
> check, if the previous readers critical region exits, will be returned
> directly.
> 
> I'd like to know under what scenario this will happen?

Suppose that a reader gets preempted for a very long time in the
middle of __srcu_read_lock():

	int __srcu_read_lock(struct srcu_struct *ssp)
	{
		int idx;

		idx = READ_ONCE(ssp->srcu_idx) & 0x1;
		// PREEMPTED RIGHT HERE
		this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
		smp_mb(); /* B */  /* Avoid leaking the critical section. */
		return idx;
	}

Suppose that several SRCU grace periods elapse during that preemption.

Do you see how that can lead to your SRCU_STATE_SCAN1 early exit?

							Thanx, Paul


PS:  The paper below outlines a similar situation in userspace RCU,
     so feel free to use this paper as a hint.  The paper is in two
     pieces, with the first piece in the first URL and the second in
     either of the last two URLs.

@article{MathieuDesnoyers2012URCU,
 Author="Mathieu Desnoyers and Paul E. McKenney and Alan Stern and Michel R. Dagenais and Jonathan Walpole",
 Title="User-Level Implementations of Read-Copy Update",
 journal="IEEE Transactions on Parallel and Distributed Systems",
 volume={23},
 year="2012",
 issn="1045-9219",
 pages="375-382",
 doi="10.1109/TPDS.2011.159",
 publisher="IEEE Computer Society",
 address="Los Alamitos, CA, USA",
 annotation={
	RCU overview, desiderata, semi-formal semantics, user-level RCU
	usage scenarios, three classes of RCU implementation, wait-free
	RCU updates, RCU grace-period batching, update overhead,
	http://www.rdrop.com/users/paulmck/RCU/urcu-main-accepted.2011.08.30a.pdf
	http://www.rdrop.com/users/paulmck/RCU/urcu-supp-accepted.2011.08.30a.pdf
	http://www.computer.org/cms/Computer.org/dl/trans/td/2012/02/extras/ttd2012020375s.pdf
},
}

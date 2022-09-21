Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BA8C6FA82
	for <rcu@archiver.kernel.org>; Wed, 21 Sep 2022 02:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIUCVR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 22:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIUCVR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 22:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E761D7D
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 19:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0FDB625DC
        for <rcu@vger.kernel.org>; Wed, 21 Sep 2022 02:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55084C433C1;
        Wed, 21 Sep 2022 02:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663726875;
        bh=dNMPjDRk2o47iAjXeR6yfDJr8MSLmNoSDsQZjNzJkSM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H1cGB1IkCZmdTWTBvdTSqkENTR/tmFOEz1oM11UKH+i6IMMVDcEMpm/wsX5EVacUK
         +gxW9mOI2oqdcHN8u/ITkP3b8DwO/C1nvnO130DUZllaOSX4E4kHeTqedUJ6oeZkj4
         66QcmgFr3TwyOXEeGaJzF1cqoqPDfkxqbUh9qVB1HXg4hJzyIRSYNoZVTALxV2c7IC
         fCgaq0a8YSP4KbwYHqklr0sE2g41y70xqWHulrk4ZAAWsMifAVvjUATsjHMmPGhZbz
         V3ZLZSRubYSGYjzfk8dDUEtmaY+akyv1K/kipJVQf5UYSNvzXpXZrC5Xjxm+hsGrAK
         a67g7NVAyDLHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E9AEA5C1503; Tue, 20 Sep 2022 19:21:14 -0700 (PDT)
Date:   Tue, 20 Sep 2022 19:21:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Kadam, Rushikesh S" <rushikesh.s.kadam@intel.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH v5 00/18] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220921022114.GW4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <f061b798-e6f6-1523-52c3-12fe7966f809@joelfernandes.org>
 <a2882e80-1723-9004-f67a-cd8332aa701d@joelfernandes.org>
 <d72808e1-fc27-f158-37b7-ef23c23e74c1@joelfernandes.org>
 <CAEXW_YRsp4HqwAPaDq9VYRptwgdcp7mPJjRH1msE42gzGajBjQ@mail.gmail.com>
 <20220920123208.GL4196@paulmck-ThinkPad-P17-Gen-1>
 <Yyn+qSZiYI02WxOv@google.com>
 <20220920190306.GR4196@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YThgajt5C86GoEn_N8ywMByfO_4Ni0CHB85tm1yBG+tsg@mail.gmail.com>
 <20220920223505.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTFiw53e=SJ+08Ks2gmfYme4uvE=aN=1GQFSx_uVDh3KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTFiw53e=SJ+08Ks2gmfYme4uvE=aN=1GQFSx_uVDh3KA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 20, 2022 at 06:40:48PM -0400, Joel Fernandes wrote:
> On Tue, Sep 20, 2022 at 6:35 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Sep 20, 2022 at 06:27:52PM -0400, Joel Fernandes wrote:
> > > On Tue, Sep 20, 2022 at 3:03 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > [...]
> > > One question - call_rcu_expedited() just means "use regular non lazy
> > > rcu", not "use expedited grace periods" right? In this case, is it
> > > better to call it call_rcu_fast() or call_rcu_nonlazy() to avoid
> > > conflicts with the "expedited" terminology in the
> > > synchronize_{s,}rcu_expedited() APIs?
> >
> > I agree that call_rcu_expedited() is likely to cause confusion.
> > The call_rcu_fast() is nice and short, but the result really is not all
> > that fast.  The call_rcu_nonlazy() sounds good, but I am sure that as
> > usual there will be no shortage of bikeshedders.  ;-)
> 
> call_rcu_tglx() and then we can Thomas's tags :-D Jk.
> 
> call_rcu_faster() since it is faster than regular call_rcu()
> 
> call_rcu_hurry_up_already()  , likely a NAK but sounds cool :-D
> 
> Jokes aside,
> call_rcu_flush() - because the CBs are not batched like regular call_rcu() ?

Possibly, possibly...

							Thanx, Paul

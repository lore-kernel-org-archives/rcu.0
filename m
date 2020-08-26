Return-Path: <SRS0=cYnC=CE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A8CC433DF
	for <rcu@archiver.kernel.org>; Wed, 26 Aug 2020 14:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029992224D
	for <rcu@archiver.kernel.org>; Wed, 26 Aug 2020 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598451892;
	bh=y/o8xTsCxJXwdFLg7PPBp4sPe/or6bDLtEoBE6yq7jM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=sDNAf6/JC8+C+u8xu2iDIFcjWSJcazqp/+Dv/XPOfVJj6+lJZ8Q6a16gdahgW1ng4
	 3qwApr63ykcoJdYzkTQ7menPMH335MMwJkT1LNNxKSDzGts+EwwVlKdRPeknFj3o/Z
	 ZN8fbSArM5kPelsH5Ajp8Sh+xDETA6/nQ02BhXJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHZOYp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728403AbgHZOYj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Aug 2020 10:24:39 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31480221E2;
        Wed, 26 Aug 2020 14:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598451879;
        bh=y/o8xTsCxJXwdFLg7PPBp4sPe/or6bDLtEoBE6yq7jM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wNnNhrT/OAhZMK+ndEUA3Enxu1eITO8pawK+T2TlZVYk6cwdyRiplvYNc5QGHE4q8
         BN8ZQlG13QzHwdyf5CHAFT9hL1nliH5paahVUeBZPwsA22LidzEjZGqVxTxaNO5P4/
         MaVHbLMf9NRjdGNkQd8tEtA6KsOWdUTNlP6tKaWI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0782A3522612; Wed, 26 Aug 2020 07:24:39 -0700 (PDT)
Date:   Wed, 26 Aug 2020 07:24:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dave@stgolabs.net, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: Re: [PATCH v4 -rcu 3/4] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200826142438.GO2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-4-joel@joelfernandes.org>
 <20200825215338.GA16846@paulmck-ThinkPad-P72>
 <20200825225103.GC579506@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825225103.GC579506@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 25, 2020 at 06:51:03PM -0400, Joel Fernandes wrote:
> On Tue, Aug 25, 2020 at 02:53:38PM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 24, 2020 at 10:48:41PM -0400, Joel Fernandes (Google) wrote:
> > > Add counting of segment lengths of segmented callback list.
> > > 
> > > This will be useful for a number of things such as knowing how big the
> > > ready-to-execute segment have gotten. The immediate benefit is ability
> > > to trace how the callbacks in the segmented callback list change.
> > > 
> > > Tested by profusely reading traces when segcblist counts updated.
> > 
> > Might I recommend a more repeatable and sustainable test methodology?
> > (Sorry, couldn't resist, given that you left yourself wide open for
> > that one...)
> 
> Ah, this message was from an older series :-(. I did test it with rcutorture
> for many hours. But I forgot to update this commit message. :-(

That is better.  Let me see if I can find a more targeted test from the
old days...

> I will respond to other comments soon, I am still stuck on the comment about
> rcl.len and rcu_barrier interaction that you brought up in 1/4 and 2/4.

Hoping my more recent replies help.  If not, you know where to find me.

							Thanx, Paul

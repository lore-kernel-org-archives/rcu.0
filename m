Return-Path: <SRS0=yvZM=DV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D63C433DF
	for <rcu@archiver.kernel.org>; Wed, 14 Oct 2020 01:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F5021D81
	for <rcu@archiver.kernel.org>; Wed, 14 Oct 2020 01:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602640512;
	bh=x7kJdJ6ZPzEPZDcTC7J3S08SvvvsdXQ3eMCtY//v7aE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=rlHnO2nweDgiKjE61zeBsI4QASkEk9+kYChIrLT9Q3PYqWfJGMEOY6a1CVQWyrbFM
	 w68hCTajfTDBd/JszB7g7CCycfAi/L2AjBgIArwZ09H2UuIRJTakkA9k9A5oJNxHb/
	 qPJpYtPH5/RWKzHvRj7s8FO7aNsnfEIKysY/BDGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgJNBzL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Oct 2020 21:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJNBzL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Oct 2020 21:55:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E07E521D7B;
        Wed, 14 Oct 2020 01:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602640510;
        bh=x7kJdJ6ZPzEPZDcTC7J3S08SvvvsdXQ3eMCtY//v7aE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hyDGwtUW/gl2GrJoa8dy8CWH6E1P84bY3VJ0woULAgzjwLj+Ieq776J4HWwaqhurr
         j/sH85gJIULj9kS/9j5tU06ckoYqVJKBUetxeP+H20KBMA7M0cPLzAKrCLKDiNQrMV
         HRgParBnleoTZRNfPlBj/ksexCEEgB3YamVSDRVw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A665C35229EE; Tue, 13 Oct 2020 18:55:10 -0700 (PDT)
Date:   Tue, 13 Oct 2020 18:55:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v6 70/80] rcu/tree: docs: document bkvcache new members
 at struct kfree_rcu_cpu
Message-ID: <20201014015510.GQ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
 <6dd0804d6fd567f11e4c6efb767e91acca659d1f.1602589096.git.mchehab+huawei@kernel.org>
 <20201013163404.GP3249@paulmck-ThinkPad-P72>
 <20201013224608.30dd1bc9@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013224608.30dd1bc9@coco.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 13, 2020 at 10:46:08PM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 13 Oct 2020 09:34:04 -0700
> "Paul E. McKenney" <paulmck@kernel.org> escreveu:
> 
> > On Tue, Oct 13, 2020 at 01:54:25PM +0200, Mauro Carvalho Chehab wrote:
> > > Changeset 53c72b590b3a ("rcu/tree: cache specified number of objects")
> > > added new members for struct kfree_rcu_cpu, but didn't add the
> > > corresponding at the kernel-doc markup, as repoted when doing
> > > "make htmldocs":
> > > 	./kernel/rcu/tree.c:3113: warning: Function parameter or member 'bkvcache' not described in 'kfree_rcu_cpu'
> > > 	./kernel/rcu/tree.c:3113: warning: Function parameter or member 'nr_bkv_objs' not described in 'kfree_rcu_cpu'
> > > 
> > > So, move the description for bkvcache to kernel-doc, and add a
> > > description for nr_bkv_objs.
> > > 
> > > Fixes: 53c72b590b3a ("rcu/tree: cache specified number of objects")
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > 
> > Queued for review and testing, likely target v5.11.
> 
> Hi Paul,
> 
> I would prefer if we could get those on 5.10, if possible.
> We're aiming to have 5.10 free of docs warnings ;-)
> 
> If you prefer, I can send those patches to Linus with your
> ack.

That sounds easier:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

Alan's objection is quite valid, but we will address that issue in a
follow-on patch that will not be on the fast track.

							Thanx, Paul

> Regards,
> Mauro
> 
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  kernel/rcu/tree.c | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index f78ee759af9c..03c54c3478b7 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3022,6 +3022,12 @@ struct kfree_rcu_cpu_work {
> > >   * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
> > >   * @initialized: The @rcu_work fields have been initialized
> > >   * @count: Number of objects for which GP not started
> > > + * @bkvcache:
> > > + *	A simple cache list that contains objects for reuse purpose.
> > > + *	In order to save some per-cpu space the list is singular.
> > > + *	Even though it is lockless an access has to be protected by the
> > > + *	per-cpu lock.
> > > + * @nr_bkv_objs: number of allocated objects at @bkvcache.
> > >   *
> > >   * This is a per-CPU structure.  The reason that it is not included in
> > >   * the rcu_data structure is to permit this code to be extracted from
> > > @@ -3037,14 +3043,6 @@ struct kfree_rcu_cpu {
> > >  	bool monitor_todo;
> > >  	bool initialized;
> > >  	int count;
> > > -
> > > -	/*
> > > -	 * A simple cache list that contains objects for
> > > -	 * reuse purpose. In order to save some per-cpu
> > > -	 * space the list is singular. Even though it is
> > > -	 * lockless an access has to be protected by the
> > > -	 * per-cpu lock.
> > > -	 */
> > >  	struct llist_head bkvcache;
> > >  	int nr_bkv_objs;
> > >  };
> > > -- 
> > > 2.26.2
> > >   
> 
> 
> 
> Thanks,
> Mauro
